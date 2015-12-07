Handlebars = require 'hbsfy/runtime'

Background = Backbone.View.extend

  el : 'body'

  template : require '../../../tmpl/background.hbs'

  initialize : ->
    # TODO: Animate mountain on page load, to scroll up to 50%
    @.render()

    @.$el.find('.background').snowfall
      round : true, 
      minSize: 2,
      maxSize: 10,
      flakeCount: 40,
      flakeColor : '#FAF9F2',
      flakePosition: 'absolute',
      flakeIndex: 999999,
      minSpeed : 1,
      maxSpeed : 20,
      shadow : false,
      collection : false,
      collectionHeight : 40,
      deviceorientation : false
    

  render : ->
    @.$el.prepend @.template

 module.exports = new Background
