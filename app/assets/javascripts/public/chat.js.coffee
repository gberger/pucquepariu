#= require socket.io
#= require jquery-fileupload/vendor/tmpl

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

fromNow = (d) ->
	unless d instanceof Date
		d = new Date(d)

	difference = d - new Date()

	# string, limit, divider
	limits = [
		["momentos",    1000,                  1]
		["%d segundos", 1000*60,               1000]
		["um minuto",   1000*60*2,             1000]
		["%d minutos",  1000*60*60,            1000*60]
		["uma hora",    1000*60*60*2,          1000*60*60]
		["%d horas",    1000*60*60*24,         1000*60*60]
		["um dia",      1000*60*60*24*2,       1000*60*60*24]
		["%d dias",     1000*60*60*24*30,      1000*60*60*24]
		["um mês",      1000*60*60*24*30*2,    1000*60*60*24*30]
		["%d meses",    1000*60*60*24*30*12,   1000*60*60*24*30]
		["um ano",      1000*60*60*24*30*12*2, 1000*60*60*24*30*12]
		["%d anos",     Infinity,              1]
	]

	# past or future
	# tiny tolerance to permit for `fromNow(new Date())` to be in the past
	str = if difference <= 5 then 'há %s' else 'em %s'

	difference = Math.abs(difference)

	limit = do (difference) ->
		for limit in limits
			if difference < limit[1]
				return limit

	return str.replace('%s', limit[0].replace('%d', (difference/limit[2]).toFixed(0)))


class Chat
	constructor: (@element, @url, @course, @template) ->
		@socket = io.connect(@url)
		@hasRemovedPlaceholder = false
		@bindEvents()
		@element.find('.chat-messages').scrollDown()
		@updateTimestamps()

	updateTimestamps: =>
		@element.find(".timestamp").each (i, el) ->
			$el = $(el)
			$el.attr('title', fromNow($el.data("timestamp"))).tooltip('fixTitle')

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

		$line = $(@template(message))
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


window.Chat = Chat
