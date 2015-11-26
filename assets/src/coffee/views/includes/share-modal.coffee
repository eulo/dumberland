Handlebars = require 'hbsfy/runtime'

module.exports = Backbone.View.extend
  
  el: '#modal'

  template: require '../../../tmpl/components/share-modal.hbs'

  initialize: (params)->
    @.render()
    log '???'

  events:
    'click .fb-share-button': 'fbShare'
    'click .btn-twitter': 'twShare'

  fbShare: ->
    ga('send','event','Button Clicks','facebook.com')
    FB.ui(
      method: 'share',
      href: 'http://www.dumberland.com/',
      title: 'Dumberland',
      link: 'http://www.dumberland.com/',
      picture: 'http://dumberland.com/assets/img/fb_share_img.png',
      description: 'Give the gift of surprise this Christmas. Send a Dumb Present from the Christmas Dumberland.'
    )
  twShare: ->
    ga('send','tweet','Button Clicks','twitter.com')



  render: ->
    @.$el.html @.template
