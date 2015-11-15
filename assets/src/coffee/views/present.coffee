Handlebars = require 'hbsfy/runtime'
getUrlVars = require '../lib/getUrlVars'

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

  open: (event)->
    #TODO : Open present
    $this = $(event.currentTarget)
    $this.text 'Back'
    $this.attr 'data-event', 'back'

  back: (event)->
    Backbone.history.navigate 'message', true

  render: (res)->
    if !res.models.length
      Backbone.history.navigate '', true
      return
    @.$el.html @.template res.models[0].attributes
    Header = new @.headerView()
    Footer = new @.footerView()

module.exports = new Present
