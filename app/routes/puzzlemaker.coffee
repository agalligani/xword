# View test page
express = require 'express'
router = express.Router()

renderPage = (req, res, next) ->
  obj = {}
  obj.data = {content: 'Foo' }

  res.renderVue 'test.vue', obj.data, {content: 'Foo' }

router.get '/vue', renderPage

module.exports = router
