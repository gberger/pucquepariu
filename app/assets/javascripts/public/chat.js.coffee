#= require socket.io
#= require mustache
#= require moment

$.fn.popVal = ->
	$this = $(this)
	val = $this.val()
	$this.val('')
	return val

class Chat
	constructor: (@element, @url, @abbreviation, @template) ->
		@socket = io.connect(@url)
		@bindEvents()

	updateTimestamps: =>
		@element.find(".timestamp").each (i, el) ->
			$el = $(el)
			$el.attr 'title', moment($el.data("timestamp")).fromNow()

	bindEvents: =>
		setInterval updateTimestamps, 1000
		@element.find('.chat-form').on 'submit', @messageSubmitHandler
		@socket.on "broadcast-message-#{@abbreviation}", @messageReceiveHandler

	messageSubmitHandler: (evt) =>
		data =
			msg: @element.find('.chat-form .chat-msg-input').popVal()
			name: username
			course_abbreviation: @abbreviation

		return false unless data.msg
		socket.emit 'send-message', data
		return false

	messageReceiveHandler: (data) =>
		$lg = @element.find('.chat-messages')
		$lg.find('.no-messages-placeholder').remove()
		data.timestamp = +new Date()

		$line = $(Mustache.render(@template, data))
		$lg.append($line)
		@updateTimestamps()
		$line.tooltip()

url = 'https://pqp-chat.herokuapp.com'
element = $('.chat')
abbreviation = course_abbreviation
template = """
						<li class="list-group-item timestamp chat-item" data-toggle="tooltip" data-placement="left" title="tt" data-timestamp="{{timestamp}}">
-        	   	<strong class="chat-name">{{name}}</strong>: <span class="chat-msg">{{msg}}</span>
-        		</li>
"""

window.chat = new Chat(element, url, abbreviation, template)
