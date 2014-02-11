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
		@bindEvents()
		@requestRecent()

	updateTimestamps: =>
		@element.find(".timestamp").each (i, el) ->
			$el = $(el)
			$el.attr 'title', moment($el.data("timestamp")).fromNow()

	bindEvents: =>
		setInterval @updateTimestamps, 1000
		@element.find('.chat-form').on 'submit', @messageSubmitHandler
		@socket.on "broadcast-message-#{@course}", @messageReceiveHandler
		setInterval ->
			@element.find('.no-messages-placeholder').text('Não há mensagens ainda. Seja o primeiro!')
		, 5000

	requestRecent: =>
		@socket.emit 'request-recent', course: @course

	blockChat: (seconds) =>
		@element.find('form input').disable()
		setTimeout =>
			@element.find('form input').enable()
			setTimeout =>
				@element.find('.chat-msg-input').focus()
			, 1
		, seconds * 1000

	messageSubmitHandler: (evt) =>
		data =
			msg: @element.find('.chat-form .chat-msg-input').popVal()
			oauth_token: oauth_token
			course: @course

		return false unless data.msg
		@socket.emit 'send-message', data
		@blockChat(1)
		return false

	messageReceiveHandler: (data) =>
		$lg = @element.find('.chat-messages')
		$lg.find('.no-messages-placeholder').remove()

		$line = $(Mustache.render(@template, data))
		$lg.append($line)
		@updateTimestamps()
		$line.tooltip()
		@element.find('.chat-messages').scrollDown()

url = 'https://pqp-chat.herokuapp.com'
element = $('.chat')
course = window.course
template = """
						<li class="list-group-item timestamp chat-item" data-toggle="tooltip" data-placement="left" title="tt" data-timestamp="{{timestamp}}">
        	   	<strong class="chat-name">{{name}}</strong>: <span class="chat-msg">{{msg}}</span>
        		</li>
"""

window.chat = new Chat(element, url, course, template)
