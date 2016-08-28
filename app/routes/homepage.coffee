# homepage.coffee
# defines route for /
# renders using pages/homepage.hbs
express = require 'express'
router = express.Router()

router.get '/', (req, res, next) ->
  obj = {data: {content: 'This text is being written from express using
 a handlbars (hbs) template... See app/routes/main.coffee'}}
  res.render 'pages/homepage', obj.data

module.exports = router
