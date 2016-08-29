# server.coffee
# Bootstrap the application.
express = require 'express'
cookies = require 'cookie-parser'
morgan = require 'morgan'
# compression = require 'compression'
path = require 'path'
winston = require 'winston'
parser = require 'body-parser'
routes = require './app/routes/main'
handlebars =  require 'express-handlebars'
#config = require './app/config/config'

port = process.env.PORT or 3000
app = express()

app.engine 'hbs', handlebars
  layoutsDir: './app/views/layouts'
  partialsDir: './app/views/partials'
  defaultLayout: 'index.hbs'
  extname: 'hbs'
#  helpers: helpers app

app.use morgan 'combined' if app.get('env') is 'development'

app
  .set('view engine', 'hbs')
  .set('views', './app/views')

app
  .use cookies()
  .use parser.json()
  .use parser.urlencoded {extended: yes}
  .use express.static path.join(__dirname, 'public')
  .use routes

app.listen port, ->
  winston.info('Listening on port %s in %s mode', @address().port, app.get 'env')

module.exports = app
