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


  start: ->
    Backbone.history.navigate '', true

  submit: (event)->
    event.preventDefault()
    data = $(event.currentTarget).serializeObject()

    data = _.extend data, getUrlVars()

    if data.message == ''
      return

    @.model.set data
    @.model.url = '/api/thank'
    @.model.save()

    @.$el.find('.message-content').replaceWith @.successTmpl @.model.attributes

  render: (res)->
    if !res.models.length
      Backbone.history.navigate '', true
      return
    @.model = res.models[0]
    @.$el.html @.template @.model.attributes
    Header = new @.headerView()
    Footer = new @.footerView()

module.exports = new Thank
