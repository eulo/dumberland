Handlebars = require 'hbsfy/runtime'

module.exports = Backbone.View.extend
  
  el: '#modal'

  template: require '../../../tmpl/components/share-modal.hbs'

  initialize: (params)->
    @.render()

  events:
    'click .fb_share_button': 'fbShare'
    'click .btn-twitter': 'twShare'

  fbShare: ->
    ga('send','event','Button Clicks','facebook.com')
  twShare: ->
    ga('send','tweet','Button Clicks','twitter.com')



  render: ->
    @.$el.html @.template
