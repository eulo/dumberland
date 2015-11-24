Handlebars = require 'hbsfy/runtime'
Animator = require '../lib/animator'

Index = Backbone.View.extend
  
  el: '#main'

  template: require '../../tmpl/index.hbs'

  headerView: require './includes/header'
  footerView: require './includes/footer'

  flag: false
  
  initialize: ->
    @.render()

    $mainAni = $('.homepage-animation')

    @SantaAni = new Animator $mainAni, ->
      @animate 0, 94

    $('.present').each ->
      PresentAni = new Animator $(this)
      $(this).find('div').bind 'mouseenter', ->
        PresentAni.animate()
      $(this).find('div').bind 'mouseleave', ->
        PresentAni.stop()
    
  events:
    'click .present': 'start'


  start: (event)->
    event.preventDefault()
    $this = $(event.currentTarget)
    # Never fire this event twice
    if @flag
      return false
    @flag = true

    $this.addClass 'active animated bounceOutUpPresent'

    $('.present:not(.active)').each ->
      $pres = $(this)
      setTimeout ->
        $pres.addClass 'animated bounceOutDownPresent'
      , 1000 * Math.random()

    SantaAni = @SantaAni
    setTimeout ->
      SantaAni.stop()
      SantaAni.animate 94, SantaAni.frameRef.length - 1, ->
        Backbone.history.navigate 'message', true
    , 400

  render: ->
    @.$el.html @.template
    Header = new @.headerView()
    Footer = new @.footerView()

module.exports = new Index
