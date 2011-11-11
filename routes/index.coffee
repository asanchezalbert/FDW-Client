
mongodb = require 'mongodb'

Db = mongodb.Db
Connection = mongodb.Connection
Server = mongodb.Server

DB_HOST = process.env.DB_HOST or '127.0.0.1'
DB_PORT = process.env.DB_PORT or 5837
DB_USER = process.env.DB_USER or 'root'
DB_PASSWD = process.env.DB_PASSWD or ''

# pagina inicial (aka home)
exports.index = (req, res) ->	
	# setup db information
	db = new Db('fdw', new Server(DB_HOST, DB_PORT, {}), native_parser: false )
			
	# abrir la conexion a la base de datos
	db.open (err, db) ->
		# autenticate as user 
		db.authenticate DB_USER, DB_PASSWD, (err) ->
			# get the empleos collection
			db.collection 'empleos', (err, collection) ->
				# primero traer las regiones disponibles
				collection.distinct 'region', (err, regiones) ->
					query = {}

					# si se deben filtrar por region
					if req.query.r then query.region = req.query.r

					collection.find(query, {}).toArray (err, empleos) ->
						res.render 'index',
							title: 'Empleo - Foros del Web'
							empleos: empleos
							regiones: regiones

				
