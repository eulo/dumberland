Handlebars = require 'hbsfy/runtime'
Animator = require '../lib/animator'
getUrlVars = require '../lib/getUrlVars'
require 'gfycat.js'

Present = Backbone.View.extend
  
  el: '#main'

  template: require '../../tmpl/present.hbs'
  collection: require '../collections/present'

  headerView: require './includes/header'
  footerView: require './includes/footer'

  initialize: ->
    @.listenTo @.collection, 'reset', @.render
    @.collection.fetch
      data: getUrlVars()
      reset: true

  events:
    'click [data-event=open]': 'open'
    'click [data-event=back]': 'back'
    'click .fb-share-button': 'fbShare'
    'click .btn-twitter': 'twShare'

  fbShare: ->
    ga 'send','event','Button Clicks','facebook.com'
    FB.ui
      method: 'share',
      href: 'http://dumberland.com/',
      title: 'Dumberland',
      link: 'http://dumberland.com/',
      picture: 'assets/img/fb_share_img.png',
      description: 'Give the gift of surprise this Christmas. Send a Dumb Present from the Christmas Dumberland.'

  twShare: ->
    ga 'send','tweet','Button Clicks','twitter.com'

  open: (event)->
    $this = $(event.currentTarget)

    gfyCollection.init()

    $('#present-modal').modal('show')

    #$this.text 'Back'
    #$this.attr 'data-event', 'back'

  back: (event)->
    Backbone.history.navigate 'message', true

  render: (res)->
    if !res.models.length
      Backbone.history.navigate '', true
      return
    @.$el.html @.template res.models[0].attributes

    $mainAni = $('.santa-present-dance')
    @SantaAni = new Animator $mainAni, ->
      @animate()

    Header = new @.headerView()
    Footer = new @.footerView()

module.exports = new Present
