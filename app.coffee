
# dependencias (express)
express = require 'express'
routes  = require './routes'

app = module.exports = express.createServer()

# configuracion
app.configure ->
  app.set 'views', __dirname + '/views'
  app.set 'view engine', 'jade'
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use app.router
  app.use express.static(__dirname + '/public')

app.configure 'development', ->
  app.use express.errorHandler({ dumpExceptions: true, showStack: true })

app.configure 'production', ->
  app.use express.errorHandler()

# direcciones
app.get '/', routes.index # el home muestra una lista de temas
app.get '/:tema', routes.tema # carga el tema de fdw

app.listen process.env.PORT or 3000

console.log "Express server listening on port #{app.address().port} in #{app.settings.env} mode"