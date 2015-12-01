AppRouter = Backbone.Router.extend
  
  routes:
    "share"         : "share"
    "video/:item"   : "video"
    "thank"         : "thank"
    ""              : "index"


Router = new AppRouter

# The homepage
Router.on 'route:index', ->
  Index = require './views/index'

# Go to pg 2 - share on social media
Router.on 'route:share', ->
  Share = require './views/share' 

Router.on 'route:video', (item) ->
  Video = require './views/video'

Router.on 'route:thank', ->
Thank = require './views/thank'

Backbone.history.start
  pushState: true

module.exports = Router

