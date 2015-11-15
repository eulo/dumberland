Handlebars = require 'hbsfy/runtime'

Index = Backbone.View.extend
  
  el: '#main'

  template: require '../../tmpl/index.hbs'

  headerView: require './includes/header'
  footerView: require './includes/footer'
  
  initialize: ->
    @.render()
    
  events:
    'click .present': 'start'

  start: (event)->
    event.preventDefault()
    # TODO: start animation
    Backbone.history.navigate 'message', true

  render: ->
    @.$el.html @.template
    Header = new @.headerView()
    Footer = new @.footerView()

module.exports = new Index
