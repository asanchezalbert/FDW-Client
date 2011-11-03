jQuery ($) ->
	$contenido = $ '#contenido'

	$.address.change ->
		path = ''

		if $.address.value() is '/' then path = $('nav a').first().attr('href').replace('#', '')
		else path = $.address.value()

		$contenido.empty().load("#{path} #contenido")