(function() {
  var Connection, DB_HOST, DB_PASSWD, DB_PORT, DB_USER, Db, Server, mongodb;
  mongodb = require('mongodb');
  Db = mongodb.Db;
  Connection = mongodb.Connection;
  Server = mongodb.Server;
  DB_HOST = process.env.DB_HOST || '127.0.0.1';
  DB_PORT = process.env.DB_PORT || 5837;
  DB_USER = process.env.DB_USER || 'root';
  DB_PASSWD = process.env.DB_PASSWD || '';
  exports.index = function(req, res) {
    var db;
    db = new Db('fdw', new Server(DB_HOST, DB_PORT, {}), {
      native_parser: false
    });
    return db.open(function(err, db) {
      return db.authenticate(DB_USER, DB_PASSWD, function(err) {
        return db.collection('empleos', function(err, collection) {
          return collection.find({}, {}).toArray(function(err, empleos) {
            return res.render('index', {
              title: 'Empleo - Foros del Web',
              empleos: empleos
            });
          });
        });
      });
    });
  };
}).call(this);
