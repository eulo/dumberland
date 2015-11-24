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

  initialize: ->
    @.model = new @.msgModel()
    @.render()

    $mainAni = $('.santa-present-dance')
    @SantaAni = new Animator $mainAni, ->
      @animate()



  events:
    'click [data-event=terms-button]': 'termsModal'
    'submit form': 'submit'
    'click .message-complete-cont button[data-url]': 'shareLink'
    'click [data-event=reset]': 'initialize'

  submit: (event) ->
    event.preventDefault()
    data = $(event.currentTarget).serializeObject()
    @.model.set data

    ###
    @.model.validate()
    if @.model.isValid()
      @.model.save()
      @.$el.find('.message-content').replaceWith @.successTmpl data
    ###
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
