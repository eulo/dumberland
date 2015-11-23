Handlebars = require 'hbsfy/runtime'
Animator = require '../lib/animator'

Index = Backbone.View.extend
  
  el: '#main'

  template: require '../../tmpl/index.hbs'

  headerView: require './includes/header'
  footerView: require './includes/footer'
  
  initialize: ->
    @.render()

    $mainAni = $('.homepage-animation')
    catchImg = '/assets/img/santa_catch_animation.png'
    catchJson = '/assets/paths/santa_catch.json'
    $.get catchJson
    img = new Image
    img.src = catchImg

    SantaAni = new Animator $mainAni, null, null, ->
      @animate()

    $('.present').each ->
      PresentAni = new Animator $(this)
      $(this).bind 'mouseenter', ->
        PresentAni.animate()
      $(this).bind 'mouseleave', ->
        PresentAni.stop()

    flag = false
    $('.present').click ->
      if flag
        return false
      flag = true

      $(this).addClass 'active'
      $('.present:not(.active)').css
        transform: 'scale(0)'

      setTimeout ->
        SantaAni.stop()
        CatchAni = new Animator $mainAni, catchJson, catchImg, ->
          @animate 0, @frameRef.length - 1, ->
            Backbone.history.navigate 'message', true
      , 1000
    
  events:
    'click .present': 'start'

  start: (event)->
    event.preventDefault()
    # TODO: start animation

  render: ->
    @.$el.html @.template
    Header = new @.headerView()
    Footer = new @.footerView()

module.exports = new Index
