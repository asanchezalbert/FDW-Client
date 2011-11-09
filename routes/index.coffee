
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
	db = new Db('fdw', new Server(DB_HOST, DB_PORT, {}), native_parser: false )
			
	# abrir la conexion a la base de datos
	db.open (err, db) ->
		db.authenticate DB_USER, DB_PASSWD, (err) ->
			# crear la coleccion de empleos
			db.collection 'empleos', (err, collection) ->
				collection.find({}, {}).toArray (err, empleos) ->
					res.render 'index',
						title: 'Empleo - Foros del Web'
						empleos: empleos

				
