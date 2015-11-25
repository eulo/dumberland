Handlebars = require 'hbsfy/runtime'
Animator = require '../lib/animator'
getUrlVars = require '../lib/getUrlVars'

Thank = Backbone.View.extend
  
  el: '#main'

  template: require '../../tmpl/thank.hbs'
  collection: require '../collections/present'

  thankModel: require '../models/thank'

  successTmpl: require '../../tmpl/components/thank-success.hbs'

  headerView: require './includes/header'
  footerView: require './includes/footer'
  
  initialize: ->
    @.model = new @.thankModel()

    @.listenTo @.collection, 'reset', @.render
    @.collection.fetch
      data: getUrlVars()
      reset: true

  events:
    'submit form': 'submit'
    'click [data-event=reset]': 'start'

  start: ->
    Backbone.history.navigate '', true

  submit: (event)->
    event.preventDefault()
    data = $(event.currentTarget).serializeObject()

    data = _.extend data, getUrlVars()

    if data.message == ''
      return

    @.model.set data
    @.model.save()

    @.$el.find('.message-content').replaceWith @.successTmpl @.modal

    $mainAni = $('.santa-nopres-dance')
    @SantaAni.stop()
    @SantaAni = new Animator $mainAni, ->
      @animate()

  render: (res)->
    if !res.models.length
      Backbone.history.navigate '', true
      return
    @.model = res.models[0]
    @.$el.html @.template @.model.attributes
    Header = new @.headerView()
    Footer = new @.footerView()

    $mainAni = $('.santa-nopres-dance')
    @SantaAni = new Animator $mainAni, ->
      @animate()

module.exports = new Thank
