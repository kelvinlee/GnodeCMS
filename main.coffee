# app.js for production
path = require 'path'
express = require 'express'

#var io = require socket.io').listen(server);
config = require('./config').config
routes = require './routes'
fs = require 'fs'

# sign = require "./controllers/sign"

app = express()

# here the middleware , cookies , postbody.
cookieParser = require('cookie-parser')
bodyParser = require('body-parser')
session = require('express-session')
MongoStore = require('connect-mongo')(session)

app.use cookieParser(config.session_secret)
app.use bodyParser.urlencoded
  extended: true
  limit: '50mb'
app.use bodyParser.json({limit: '50mb'})
app.use session
  secret: config.session_secret,
  resave: true
  saveUninitialized: true
  store: new MongoStore
    url: config.mdb


# configuration in all env
viewsRoot = path.join __dirname, 'template'
app.set 'views', viewsRoot
app.set 'view engine', 'ejs'

# must need next() go to next page.

app.use (req,res,next)->
  res.locals.config = config
  res.locals.mobile = false
  res.locals.css = []
  res.locals.js = []
  res.locals.title = ""
  next()
# app.use sign.userinfo
# app.use sign.default

staticDir = path.join __dirname, 'template/'+config.template+"/static"
adminsDir = path.join __dirname, 'template/'+config.templateforadmin+"/static"
publicDir = path.join __dirname, 'public'
app.use express.static staticDir
app.use express.static adminsDir
app.use express.static publicDir

routes app

app.listen config.port,config.ip

console.log "GNode CMS Start."
