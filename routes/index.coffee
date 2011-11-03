
request = require 'request'
jsdom   = require 'jsdom'

# GET home page.

exports.index = (req, res) ->
	request { 'uri' : 'http://www.forosdelweb.com/f175/' },
		(err, respuesta, cuerpo) ->
			jsdom.env {html: cuerpo, scripts: ['http://code.jquery.com/jquery-1.6.min.js']},
				(err, window) ->
					$ = window.jQuery
					items = []

					$('.alt1.tdtitle').each ->
						$self = $ this
						$contenedor = $self.children 'div'
						$a = $contenedor.children 'a'

						items.push
							titulo: $a.text()
							href: $a.attr('href').split('f175')[1]
							autor: $self.children('div + div').text()
					
					res.render 'index',
						title: 'HTML5 - Foros del Web'
						items: items

exports.tema = (req, res) ->
	request {'uri':"http://www.forosdelweb.com/f175/#{req.params.tema}"},
		(err, respuesta, cuerpo) ->
			jsdom.env { html: cuerpo, scripts: ['http://code.jquery.com/jquery-1.6.min.js']},
				(err, window) ->
					$ = window.jQuery
					$post = $ '#posts'
					$todos = $post.find('.post_content')
					comentarios = []

					$todos.slice(1).each (i, el) -> comentarios.push $(el).html()

					item = 
						titulo: $post.find('.alt1 .smallfont').first().text()
						contenido: $todos.first().html()
						comentarios: comentarios
					
					res.render 'tema',
						title: "#{item.titulo} - HTML5 - Foros del Web"
						item: item