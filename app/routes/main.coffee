# routes/main.coffee
# Define application routes.
express = require 'express'
router = express.Router()
homepage = require './homepage'
demopage = require './demopage'
vue = require './vue'

# Routes
# Pre-defined routes like sections/about-us etc. go here.
router.use homepage
router.use demopage
router.use vue

module.exports = router
