(function() {
  var app, express, nib, stylus;
  express = require('express');
  stylus = require('stylus');
  nib = require('nib');
  app = module.exports = express.createServer();
  app.configure(function() {
    app.set('port', process.env.PORT || 3000);
    app.set('views', __dirname + '/views');
    app.set('view engine', 'jade');
    app.use(express.bodyParser());
    app.use(express.methodOverride());
    app.use(app.router);
    app.use(stylus.middleware({
      src: __dirname + '/public',
      compile: function(str, path) {
        return stylus(str).set('filename', path).set('compress', true).use(nib());
      }
    }));
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
  app.get('/', function(req, res) {
    if ((req.headers.host !== 'ontimed.co') && (req.headers.host !== 'example.com:3000')) {
      return res.redirect('http://ontimed.co');
    } else {
      return res.render('index');
    }
  });
  app.listen(app.settings.port);
}).call(this);
