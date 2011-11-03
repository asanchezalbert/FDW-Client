(function() {
  jQuery(function($) {
    var $contenido;
    $contenido = $('#contenido');
    return $.address.change(function() {
      var path;
      path = '';
      if ($.address.value() === '/') {
        path = $('nav a').first().attr('href').replace('#', '');
      } else {
        path = $.address.value();
      }
      return $contenido.empty().load("" + path + " #contenido");
    });
  });
}).call(this);
