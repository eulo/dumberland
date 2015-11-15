# libs
window.jQuery = window.$ = require 'jquery'
window._ = require 'underscore'
require 'bootstrap'
window.Backbone = require 'backbone'
Backbone.$ = jQuery
require 'jquery-snowfall'

window.log = ->
  console.log.apply console, arguments

# components
require './lib/jquery.serializeObject'
Background = require './views/includes/background'
Router = require './router'
