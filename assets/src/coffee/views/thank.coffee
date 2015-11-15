Handlebars = require 'hbsfy/runtime'
getUrlVars = require '../lib/getUrlVars'

Thank = Backbone.View.extend
  
  el: '#main'

  template: require '../../tmpl/thank.hbs'
  collection: require '../collections/present'

  successTmpl: require '../../tmpl/components/thank-success.hbs'

  headerView: require './includes/header'
  footerView: require './includes/footer'
  
  initialize: ->
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
    @.$el.find('.message-content').replaceWith @.successTmpl @.modal
   
  render: (res)->
    if !res.models.length
      Backbone.history.navigate '', true
      return
    @.modal = res.models[0]
    @.$el.html @.template res.model.attributes
    Header = new @.headerView()
    Footer = new @.footerView()

module.exports = new Thank
