#
#
#

express = require 'express'
router = express.Router()

#
#

renderPage = (req, res, next) ->
  critter = req.params.critter
  obj = {}
  obj.data = {content: 'Foo' }

  res.renderVue 'test.vue', {content: 'Foo' }, {content: 'Foo' }

router.get '/vue', renderPage
#router.get '/page/:critter(dog|cat|fish|lizzard|gerbil)', renderPage

module.exports = router
