$(document).ready ->
	#Collapsible Sidebar Menu
	$(".sidebar-menu .openable > a").click ->
		if not $("aside").hasClass("sidebar-mini") or Modernizr.mq("(max-width: 991px)")
			if $(this).parent().children(".submenu").is(":hidden")
				$(this).parent().siblings().removeClass("open").children(".submenu").slideUp 200
				$(this).parent().addClass("open").children(".submenu").slideDown 200
			else
				$(this).parent().removeClass("open").children(".submenu").slideUp 200
		false

	#Open active menu
	$(".openable.open").children(".submenu").slideDown 200	if not $(".sidebar-menu").hasClass("sidebar-mini") or Modernizr.mq("(max-width: 767px)")

	#Toggle User container on sidebar menu
	$("#btn-collapse").click ->
		$(".sidebar-header").toggleClass "active"
		return
	$("#sidebarToggleLG").click ->
		if $(".wrapper").hasClass("display-right")
			$(".wrapper").removeClass "display-right"
			$(".sidebar-right").removeClass "active"
		else
			
			#$('.nav-header').toggleClass('hide');
			$(".top-nav").toggleClass "sidebar-mini"
			$("aside").toggleClass "sidebar-mini"
			$("footer").toggleClass "sidebar-mini"
			$(".main-container").toggleClass "sidebar-mini"
			$(".main-menu").find(".openable").removeClass "open"
			$(".main-menu").find(".submenu").removeAttr "style"
		return
	$("#sidebarToggleSM").click ->
		$("aside").toggleClass "active"
		$(".wrapper").toggleClass "display-left"
		return



post = (form,callback = null)->
	$.ajax
		type:"post"
		dataType:"json"
		url: $(form).attr "action"
		data: $(form).serializeArray()
		success: (msg)->

			type = "warning"
			type = "warning" if msg.recode is 201
			type = "information" if msg.recode is 202
			type = "error" if msg.recode is 203
			type = "success" if msg.recode is 200
			noty
				text: msg.reason
				type: type
				layout: 'topCenter'
				timeout: '3000'
			if msg.recode is 200 and callback?
				callback msg

