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
expressVue = require 'express-vue'
app = express()
expressVueMiddleware = expressVue.init()


#config = require './app/config/config'

port = process.env.PORT or 3000

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

vueOptions =
  rootPath: './app/vues'

expressVueMiddleware = expressVue.init(vueOptions)

app
  .use cookies()
  .use expressVueMiddleware
  .use parser.json()
  .use parser.urlencoded {extended: yes}
  .use express.static path.join(__dirname, 'public')
  .use routes

#VUE setup

vueOptions =
  rootPath: './app/vues'
  vueVersion: '2.3.4'
  template:
    html:
      start: '<!DOCTYPE html><html>'
      end: '</html>'
    body:
      start: '<body>'
      end: '</body>'
    template:
      start: '<div id="app">'
      end: '</div>'
  head:
    title: 'Hello this is a global title'
    scripts: [ { src: 'https://example.com/script.js' } ]
    styles: [ { style: '/assets/rendered/style.css' } ]
  data:
    foo: true
    bar: 'yes'
    qux:
      id: 123
      baz: 'anything you wish, you can have any kind of object in the data object, it will be global and on every route'
expressVueMiddleware = expressVue.init(vueOptions)

app.use expressVueMiddleware
app.listen port, ->
  winston.info('Listening on port %s in %s mode', @address().port, app.get 'env')

module.exports = app
