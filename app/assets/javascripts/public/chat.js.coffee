#= require socket.io
#= require mustache
#= require moment

$.fn.scrollDown = ->
	$(this).scrollTop(this.prop('scrollHeight'))

$.fn.popVal = ->
	$this = $(this)
	val = $this.val()
	$this.val('')
	return val

$.fn.disable = ->
	$(this).attr('disabled', true)

$.fn.enable = ->
	$(this).attr('disabled', false)

class Chat
	constructor: (@element, @url, @course, @template) ->
		@socket = io.connect(@url)
		@hasRemovedPlaceholder = false
		@bindEvents()
		@element.find('.chat-messages').scrollDown()

	updateTimestamps: =>
		@element.find(".timestamp").each (i, el) ->
			$el = $(el)
			$el.attr('title', moment($el.data("timestamp")).fromNow()).tooltip('fixTitle')

	bindEvents: =>
		setInterval @updateTimestamps, 23000
		@element.find('.chat-form').on 'submit', @messageSubmitHandler
		@element.find('.chat-remove').on 'click', @adminDeleteMessage
		@socket.on "broadcast-message-#{@course}", @messageReceiveHandler
		@socket.on "broadcast-delete-message", @deleteMessageHandler

	blockChat: (seconds) =>
		btn = @element.find('.chat-send').disable()
		input = @element.find('chat-msg-input')
		setTimeout =>
			btn.enable()
		, seconds * 1000

	messageSubmitHandler: (evt) =>
		data =
			msg: @element.find('.chat-msg-input').popVal().slice(0, 512)
			oauth_token: oauth_token
			course: @course

		return false unless data.msg
		@socket.emit 'send-message', data
		@blockChat(1)
		return false

	messageReceiveHandler: (message) =>
		$lg = @element.find('.chat-messages')
		@removePlaceholder()

		$line = $(Mustache.render(@template, message))
		$line.find('.chat-remove').on 'click', @adminDeleteMessage
		$lg.append($line)
		@updateTimestamps()
		$line.tooltip()
		$lg.scrollDown()

	removePlaceholder: =>
		unless @hasRemovedPlaceholder
			@element.find('.no-messages-placeholder').remove()
			@hasRemovedPlaceholder = true

	adminDeleteMessage: (evt) =>
		if confirm("Deseja deletar a mensagem?")
			id = $(evt.target).data('id')
			@socket.emit 'delete-message',
				oauth_token: oauth_token
				id: id

	deleteMessageHandler: (data) =>
		id = data.id
		@element.find("[data-id=#{id}]").remove()


window.url = 'https://pqp-chat.herokuapp.com'
window.element = $('.chat')
window.template = """
						<li class="list-group-item timestamp chat-item" data-toggle="tooltip" data-placement="left" title="tt" data-timestamp="{{timestamp}}" data-id="{{id}}">
        	   	<strong class="chat-name">{{name}}</strong>: <span class="chat-msg">{{msg}}</span> <i class="glyphicon glyphicon-remove-circle hide chat-remove" data-id="{{id}}"></i>
        		</li>
"""

window.Chat = Chat