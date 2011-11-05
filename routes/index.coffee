
request = require 'request' # facilita el cargar "sitios" 
jsdom   = require 'jsdom' # esto no es js de navegador!!

# pagina inicial (aka home)
exports.index = (req, res) ->
	# solo me interesa el foro de HTML5
	request { 'uri' : 'http://www.forosdelweb.com/f175/' },
		(err, respuesta, cuerpo) ->
			# transformarlo magicamente en DOM con jQuery
			jsdom.env {html: cuerpo, scripts: ['http://code.jquery.com/jquery-1.6.min.js']},
				(err, window) ->
					$ = window.jQuery
					items = [] # aqui van los datos de los temas

					# selector (td)
					$('.alt1.tdtitle').each ->
						$self = $ this
						$contenedor = $self.children 'div'
						$a = $contenedor.children 'a'

						# titulo, url y autor por ahora
						items.push
							titulo: $a.text()
							href: $a.attr('href').split('f175')[1]
							autor: $self.children('div + div').text()
					
					# mostrarlo bonito en la plantilla
					res.render 'index',
						title: 'HTML5 - Foros del Web'
						items: items

# pagina de tema (aka /super-tema-padre-55)
exports.tema = (req, res) ->
	# como root es el foro de html5
	request {'uri':"http://www.forosdelweb.com/f175/#{req.params.tema}"},
		(err, respuesta, cuerpo) ->
			# transformarlo magicamente en DOM con jQuery
			jsdom.env { html: cuerpo, scripts: ['http://code.jquery.com/jquery-1.6.min.js']},
				(err, window) ->
					$ = window.jQuery
					# contenedor de [post, comentarios]					
					$post = $ '#posts'
					$todos = $post.find('.post_content')
					comentarios = [] # guardar aqui los comentarios

					# tomar los comentarios
					$todos.slice(1).each (i, el) -> comentarios.push $(el).html()

					# propiedades del tema: titulo, texto y comentarios(array)
					item = 
						titulo: $post.find('.alt1 .smallfont').first().text()
						contenido: $todos.first().html()
						comentarios: comentarios
					
					# enviar con la plantilla
					res.render 'tema',
						title: "#{item.titulo} - HTML5 - Foros del Web"
						item: item