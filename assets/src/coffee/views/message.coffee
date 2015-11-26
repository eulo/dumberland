Handlebars = require 'hbsfy/runtime'
Animator = require '../lib/animator'
require 'backbone.validation'
require '../lib/backbone.validation.callbacks.bootstrap'

Message = Backbone.View.extend
  
  el: '#main'

  msgModel: require '../models/message'

  template: require '../../tmpl/message.hbs'
  successTmpl: require '../../tmpl/components/message-success.hbs'

  headerView: require './includes/header'
  footerView: require './includes/footer'
  termsModalView: require './includes/terms-modal'

  country_code: 'none'

  initialize: ->
    self = @
    @.model = new @.msgModel()
    @.render()

    $.getJSON 'http://api.wipmania.com/jsonp?callback=?', (data)->
      self.country_code = data.address.country_code

    $mainAni = $('.santa-present-dance')
    @SantaAni = new Animator $mainAni, ->
      @animate()

  events:
    'click [data-event=terms-button]': 'termsModal'
    'submit form': 'submit'
    'click .message-complete-cont button[data-url]': 'shareLink'
    'click [data-event=reset]': 'initialize'
    'click .fb-share-button': 'fbShare'
    'click .btn-twitter': 'twShare'

  fbShare: ->
    ga 'send','event','Button Clicks','facebook.com'
    FB.ui
      method: 'share',
      href: 'http://dumberland.com/',
      title: 'Dumberland',
      link: 'http://dumberland.com/',
      picture: 'http://dumberland.com/assets/img/fb_share_img.png',
      description: 'Give the gift of surprise this Christmas. Send a Dumb Present from the Christmas Dumberland.'
  twShare: ->
    ga 'send','tweet','Button Clicks','twitter.com'

  submit: (event) ->
    event.preventDefault()
    data = $(event.currentTarget).serializeObject()
    data.country_code = @.country_code
    @.model.set data

    @.model.validate()
    if @.model.isValid()
      @.model.save()
      @.$el.find('.message-content').replaceWith @.successTmpl data

      $mainAni = $('.santa-nopres-dance')
      @SantaAni.stop()
      @SantaAni = new Animator $mainAni, ->
        @animate()


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

module.exports = new Message
