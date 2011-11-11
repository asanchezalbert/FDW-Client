(function() {
  jQuery(function($) {
    var $filtro_regiones;
    $filtro_regiones = $('#filtro_regiones');
    $filtro_regiones.find("option[value=\"" + (window.location.pathname + decodeURIComponent(window.location.search)) + "\"]").attr('selected', 'selected');
    return $filtro_regiones.change(function() {
      return window.location.href = $filtro_regiones.val();
    });
  });
}).call(this);
