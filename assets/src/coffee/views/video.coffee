Handlebars = require 'hbsfy/runtime'
Present = require '../lib/presentURL'
# require '../lib/backbone.validation.callbacks.bootstrap'

Video = Backbone.View.extend
  
  el: '#main'

  videoModel: require '../models/video'

  template: require '../../tmpl/video.hbs'
  
  
  # Show this when user successfully shares the present link. 
  # successTmpl: require '../../tmpl/components/share-success.hbs'

  headerView: require './includes/header'
  footerView: require './includes/footer'

  # Share and confirmation modal link. 
  shareModalView: require './includes/share-modal'

  # Terms and conditions modal link. 
  termsModalView: require './includes/terms-modal'

  # country_code: 'none'
  
  initialize: ->
    self = @
    @.model = new @.videoModel()
    
    @.render()
    
    $('.snow-mound-with-trees').css('background', 'url(/assets/img/background_without_pole.svg) top center no-repeat')
    
    $('.video-overlay').show()
    $('.thanks-base').hide()
    
    @presentObj = new Present
    
  
  events:
    'click .close-dumb-video': 'closeVideo'
    'click .watch-button' : 'watchVideo'
  
  closeVideo: ->
    $('.video-overlay').hide()
    $('.thanks-base').show()
    
    iframe = $('#vimplayer')[0]
    player = $f(iframe)
    
    player.api('pause')
  
  watchVideo: ->
    $('.video-overlay').show()
    $('.thanks-base').hide()
    
    iframe = $('#vimplayer')
    player = $f(iframe)
    
    player.api('seekTo', 0)
    player.api('play')
    
    
  
  test: (videoNum) ->
    console.log(videoNum + ' and something')
    
    baseURL = 'https://player.vimeo.com/video/'
    options = '?autoplay=1;color=#a6d2bd;api=1'
    
    iframe = $('#vimplayer') 
    
    iframe.attr('src', baseURL + @presentObj.getVid(videoNum) + options)
    
    
    
    console.log(@videoURL)
    
  
  
  render: ->
    @.$el.html @.template

    Header = new @.headerView()
    Footer = new @.footerView()

module.exports = new Video