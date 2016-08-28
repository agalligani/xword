express = require 'express'
router = express.Router()


renderPage = (req, res, next) ->
  critter = req.params.critter
  obj = {}
  obj.data = {content: 'This is a demo of passing a parameter to a page. This page
shows the parameter passed via the url path \'page/n\' ... in this case n is equal
to "' + critter + '". See how easy this is to implement by looking at demopage.coffee' }
  res.render 'pages/demopage', obj.data

router.get '/page/:critter(dog|cat|fish|lizzard|gerbil)', renderPage

module.exports = router