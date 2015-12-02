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
    
    
    $('.video-overlay').show()
    $('.thanks-base').hide()
    
    @presentObj = new Present  
    console.log('you suuck')
  
  events:
    'click .close-dumb-video': 'closeVideo' 
  
  closeVideo: ->
    $('.video-overlay').hide()
    $('.thanks-base').show()
  
  render: ->
    @.$el.html @.template


    Header = new @.headerView()
    Footer = new @.footerView()

module.exports = new Video