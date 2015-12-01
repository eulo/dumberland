AppRouter = Backbone.Router.extend
  
  routes:
    "share"         : "share"
    "video/:item"    : "video"
    "message"       : "message"
    "present"       : "present"
    "thank"         : "thank"
    ""              : "index"


Router = new AppRouter

# The homepage
Router.on 'route:index', ->
  Index = require './views/index'

# Go to pg 2 - share on social media
Router.on 'route:share', ->
  Share = require './views/share' 

Router.on 'route:message',  ->
  Video = require './views/message'
  console.log('Video')


Router.on 'route:video', (item) ->
  Video = require './views/video'
  console.log('Video')

Router.on 'route:present', ->
  Present = require './views/present'

Router.on 'route:thank', ->
Thank = require './views/thank'

Backbone.history.start
  pushState: true

module.exports = Router

