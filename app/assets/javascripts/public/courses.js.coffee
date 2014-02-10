#= require moment
#= require socket.io

socket = io.connect('https://pqp-chat.herokuapp.com')

updateTimestamps = ->
	$(".timestamp").each (i, el) ->
		$el = $(el)
		$el.attr 'title', moment($el.data("timestamp")).fromNow()

setInterval updateTimestamps, 1000

$lg = $(".list-group")
$nothing = $("#nothing")
socket.on "broadcast-message-#{course_abbreviation}", (data) ->
	timestamp = +new Date()
	$nothing.remove()
	$line = $("""
					<li class="list-group-item timestamp" data-toggle="tooltip" data-placement="left" title="tt" data-timestamp="#{timestamp}">
						<strong class="name"></strong>: <span class="msg"></span>
					</li>
					""")
	$line.find('.name').text(data.name)
	$line.find('.msg').text(data.msg)
	$lg.append $line
	updateTimestamps()
	$line.tooltip()

$("#chat-form").on "submit", ->
	data =
		name: username
		msg: $("#msg").val()
		course_abbreviation: course_abbreviation

	$("#msg").val ""
	return false unless data.msg
	socket.emit "send-message", data
	return false
