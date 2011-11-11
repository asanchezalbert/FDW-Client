jQuery ($) ->
	# select de regiones
	$filtro_regiones = $ '#filtro_regiones'

	# seleccionar la region actual
	$filtro_regiones.find("option[value=\"#{window.location.pathname+decodeURIComponent(window.location.search)}\"]").attr 'selected', 'selected'

	# en cambio
	$filtro_regiones.change ->
		window.location.href = $filtro_regiones.val()