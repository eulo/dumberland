Handlebars = require 'hbsfy/runtime'
Animator = require '../lib/animator'
Present = require '../lib/presentURL'
require 'backbone.validation'
# require '../lib/backbone.validation.callbacks.bootstrap'

Share = Backbone.View.extend
  
  el: '#main'

  shareModel: require '../models/share'

  template: require '../../tmpl/share.hbs'
  
  
  # Show this when user successfully shares the present link. 
  # successTmpl: require '../../tmpl/components/share-success.hbs'

  headerView: require './includes/header'
  footerView: require './includes/footer'

  # Share and confirmation modal link. 
  shareModalView: require './includes/share-modal'

  # Terms and conditions modal link. 
  termsModalView: require './includes/terms-modal'

  # country_code: 'none'

  initialize: (item) ->
    self = @
    @.model = new @.shareModel()
    
    @.render()

    # $.getJSON 'http://api.wipmania.com/jsonp?callback=?', (data)->
    #   self.country_code = data.address.country_code

    @presentObj = new Present  
    console.log(@presentObj)
    
    new @.shareModalView
    
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
      title: 'Dumb Presents to Give',
      link: @presentObj.url,
      picture: 'http://52.64.226.45/assets/img/FBshare_acid.png',
      description: 'Will it scratch? Will it bite? Will it be a bloodcurdling sight? Open your Dumb Present and see what’s inside.'
      
  	$('#share-modal').modal('show')
  
  twShare: ->
    ga 'send','tweet','Button Clicks','twitter.com'
    
    loc = 'https://twitter.com/intent/tweet?text=Open a Dumb Present from the Dumb Ways to Die Christmas Dumberland. http://52.64.226.45/video/10'
    
    window.open loc, "twitterwindow", "height=450, width=550, top=" + ($(window).height() / 2 - 225) + ", left=" + $(window).width() / 2 + ", toolbar=0, location=0, menubar=0, directories=0, scrollbars=0"
    
    $('#share-modal').modal('show')
    
    
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

module.exports = new Share
  