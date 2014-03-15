$ ->
	if (hash = window.location.hash)
		$("ul.nav a[href=\"" + hash + "\"]").tab("show")

	$(".nav-pills a").click ->
		$(this).tab "show"
		scrollmem = $("body").scrollTop()
		window.location.hash = @hash
		$("html,body").scrollTop scrollmem
