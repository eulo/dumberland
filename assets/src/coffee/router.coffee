AppRouter = Backbone.Router.extend
  
  routes:
    "share"         : "share"
    "video/:item"   : "video"
    ""              : "index"


Router = new AppRouter

# The homepage
Router.on 'route:index', ->
  Index = require './views/index'

# Go to pg 2 - share on social media
Router.on 'route:share', ->
  Share = require './views/share' 

Router.on 'route:video', (item) ->
  console.log(item)
  Video = require './views/video'
  console.log('beat it')
  console.log(Video)
  Video.test(item)

Backbone.history.start
  pushState: true

module.exports = Router

