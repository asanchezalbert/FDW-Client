(function() {
  var app, express, routes;
  express = require('express');
  routes = require('./routes');
  app = module.exports = express.createServer();
  app.configure(function() {
    app.set('views', __dirname + '/views');
    app.set('view engine', 'jade');
    app.use(express.bodyParser());
    app.use(express.methodOverride());
    app.use(app.router);
    return app.use(express.static(__dirname + '/public'));
  });
  app.configure('development', function() {
    return app.use(express.errorHandler({
      dumpExceptions: true,
      showStack: true
    }));
  });
  app.configure('production', function() {
    return app.use(express.errorHandler());
  });
  app.get('/', routes.index);
  app.get('/:tema', routes.tema);
  app.listen(process.env.PORT || 3000);
  console.log("Express server listening on port " + (app.address().port) + " in " + app.settings.env + " mode");
}).call(this);
