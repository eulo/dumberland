Handlebars = require 'hbsfy/runtime'
Animator = require '../lib/animator'

Index = Backbone.View.extend
  
  el: '#main'

  template: require '../../tmpl/index.hbs'

  headerView: require './includes/header'
  footerView: require './includes/footer'

  flag: false
  
  initialize: ->
    @.render()

    $mainAni = $('.homepage-animation')

    @SantaAni = new Animator $mainAni, ->
      @animate 0, 94

    $('.present').each ->
      PresentAni = new Animator $(this)
      $(this).find('div').bind 'mouseenter', ->
        PresentAni.animate()
      $(this).find('div').bind 'mouseleave', ->
        PresentAni.stop()
    
  events:
    'click .present': 'start'
    'click .fb-share-button': 'fbShare'
    'click .btn-twitter': 'twShare'

  fbShare: ->
    ga 'send','event','Button Clicks','facebook.com'
    FB.ui
      method: 'share',
      href: 'http://www.dumberland.com/',
      title: 'Dumberland',
      link: 'http://www.dumberland.com/',
      picture: 'assets/img/fb_share_img.png',
      description: 'Give the gift of surprise this Christmas. Send a Dumb Present from the Christmas Dumberland.'

  twShare: ->
    ga 'send','tweet','Button Clicks','twitter.com'

  start: (event)->
    event.preventDefault()
    $this = $(event.currentTarget)
    # Never fire this event twice
    if @flag
      return false
    @flag = true

    $this.addClass 'active animated bounceOutUpPresent'

    $('.present:not(.active)').each ->
      $pres = $(this)
      setTimeout ->
        $pres.addClass 'animated bounceOutDownPresent'
      , 1000 * Math.random()

    SantaAni = @SantaAni
    setTimeout ->
      SantaAni.stop()
      SantaAni.animate 94, SantaAni.frameRef.length - 1, ->
        Backbone.history.navigate 'message', true
    , 400

  render: ->
    @.$el.html @.template
    Header = new @.headerView()
    Footer = new @.footerView()

module.exports = new Index
