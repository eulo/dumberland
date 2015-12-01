Handlebars = require 'hbsfy/runtime'
Animator = require '../lib/animator'
Present = require '../lib/presentURL'
require 'backbone.validation'
# require '../lib/backbone.validation.callbacks.bootstrap'

Video = Backbone.View.extend
  
  el: '#main'

  videoModel: require '../models/video'

  template: require '../../tmpl/video.hbs'
  
  
  # Show this when user successfully shares the present link. 
  # successTmpl: require '../../tmpl/components/share-success.hbs'

  headerView: require './includes/header'
  footerView: require './includes/footer'

  # Share and confirmation modal link. 
  shareModalView: require './includes/share-modal'

  # Terms and conditions modal link. 
  termsModalView: require './includes/terms-modal'

  # country_code: 'none'
  
  initialize: ->
    self = @
    @.model = new @.videoModel()
    
    @.render()
    
    @presentObj = new Present  
    console.log(@presentObj)

    $mainAni = $('.santa-present-dance')
    @SantaAni = new Animator $mainAni, ->
      @animate()

   events:
    'click [data-event=terms-button]': 'termsModal'
    'click .message-complete-cont button[data-url]': 'shareLink'
    'click [data-event=reset]': 'initialize'
    'click .fb-share-button': 'fbShare'
    'click .btn-twitter': 'twShare'    

  fbShare: (event) ->
    ga 'send','event','Button Clicks','facebook.com'
    FB.ui
      method: 'share',
      href: @presentObj.url,
      title: 'Dumberland',
      link: @presentObj.url,
      picture: 'http://ec2-52-64-211-113.ap-southeast-2.compute.amazonaws.com/assets/img/fb_share_img.png',
      description: 'Give the gift of surprise this Christmas. Send a Dumb Present from the Christmas Dumberland.'
    
    new @.shareModalView
    $('#share-modal').modal('show')
    

  
  twShare: ->
    ga 'send','tweet','Button Clicks','twitter.com'


  termsModal: (event) ->
    event.preventDefault()
    new @.termsModalView()
    $('#terms-modal').modal('show')

  shareLink: (event) ->
    event.preventDefault()
    window.open $(event.currentTarget).data('url'), 'share-dialog', 'width=626,height=436'

  render: ->
    @.$el.html @.template

    Backbone.Validation.bind @

    Header = new @.headerView()
    Footer = new @.footerView()

module.exports = new Video