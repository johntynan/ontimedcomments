# Require Node Packages

express = require 'express'
stylus  = require 'stylus'
nib     = require 'nib'

# Configure Express App

app = module.exports = express.createServer()

app.configure ->
  app.set 'port', process.env.PORT || 3000
  app.set 'views', __dirname + '/views'
  app.set 'view engine', 'jade'
  app.use express.bodyParser()
  app.use express.methodOverride()
  
  app.use app.router
  app.use stylus.middleware
    src: __dirname + '/public'
    compile: (str, path) ->
      stylus(str).set('filename', path).set('compress', true).use(nib())
  app.use express.static __dirname + '/public'
  
app.configure 'development', () ->
  app.use express.errorHandler dumpExceptions: true, showStack: true
  
app.configure 'production', () ->
  app.use express.errorHandler()
  
# Declare Express Routing & Listen
  
app.get '/', (req, res) ->
  if (req.headers.host != 'ontimed.co') and (req.headers.host != 'example.com:3000')
    res.redirect 'http://ontimed.co'
  else
    res.render 'index'
  
app.listen app.settings.port
