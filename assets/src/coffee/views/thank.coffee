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

  render: (res)->
    @.$el.html @.template 
    Header = new @.headerView()
    Footer = new @.footerView()

module.exports = new Thank
