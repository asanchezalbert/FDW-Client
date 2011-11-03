(function() {
  var jsdom, request;
  request = require('request');
  jsdom = require('jsdom');
  exports.index = function(req, res) {
    return request({
      'uri': 'http://www.forosdelweb.com/f175/'
    }, function(err, respuesta, cuerpo) {
      return jsdom.env({
        html: cuerpo,
        scripts: ['http://code.jquery.com/jquery-1.6.min.js']
      }, function(err, window) {
        var $, items;
        $ = window.jQuery;
        items = [];
        $('.alt1.tdtitle').each(function() {
          var $a, $contenedor, $self;
          $self = $(this);
          $contenedor = $self.children('div');
          $a = $contenedor.children('a');
          return items.push({
            titulo: $a.text(),
            href: $a.attr('href').split('f175')[1],
            autor: $self.children('div + div').text()
          });
        });
        return res.render('index', {
          title: 'HTML5 - Foros del Web',
          items: items
        });
      });
    });
  };
  exports.tema = function(req, res) {
    return request({
      'uri': "http://www.forosdelweb.com/f175/" + req.params.tema
    }, function(err, respuesta, cuerpo) {
      return jsdom.env({
        html: cuerpo,
        scripts: ['http://code.jquery.com/jquery-1.6.min.js']
      }, function(err, window) {
        var $, $post, $todos, comentarios, item;
        $ = window.jQuery;
        $post = $('#posts');
        $todos = $post.find('.post_content');
        comentarios = [];
        $todos.slice(1).each(function(i, el) {
          return comentarios.push($(el).html());
        });
        item = {
          titulo: $post.find('.alt1 .smallfont').first().text(),
          contenido: $todos.first().html(),
          comentarios: comentarios
        };
        return res.render('tema', {
          title: "" + item.titulo + " - HTML5 - Foros del Web",
          item: item
        });
      });
    });
  };
}).call(this);
