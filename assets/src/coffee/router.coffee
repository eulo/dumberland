AppRouter = Backbone.Router.extend
  routes:
    "message" : "message"
    "present" : "present"
    "thank": "thank"
    "" : "index"

Router = new AppRouter

Router.on 'route:index', ->
  Index = require './views/index'

Router.on 'route:message', ->
  Message = require './views/message'

Router.on 'route:present', ->
  Present = require './views/present'

Router.on 'route:thank', ->
  Thank = require './views/thank'

Backbone.history.start
  pushState: true

window.router = Router

module.exports = Router
