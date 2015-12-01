Handlebars = require 'hbsfy/runtime'
Animator = require '../lib/animator'
Present = require '../lib/presentURL'
require 'backbone.validation'
# require '../lib/backbone.validation.callbacks.bootstrap'

Share = Backbone.View.extend
  
  el: '#main'

  shareModel: require '../models/share'

  template: require '../../tmpl/share.hbs'
  
  
  # Show this when user successfully shares the present link. 
  # successTmpl: require '../../tmpl/components/share-success.hbs'

  headerView: require './includes/header'
  footerView: require './includes/footer'

  # Share and confirmation modal link. 
  shareModalView: require './includes/share-modal'

  # Terms and conditions modal link. 
  termsModalView: require './includes/terms-modal'

  # country_code: 'none'

  initialize: (item) ->
    self = @
    @.model = new @.shareModel()
    
    @.render()

    # $.getJSON 'http://api.wipmania.com/jsonp?callback=?', (data)->
    #   self.country_code = data.address.country_code

    @presentObj = new Present  
    console.log(@presentObj)

    $mainAni = $('.santa-present-dance')
    @SantaAni = new Animator $mainAni, ->
      @animate()

  events:
    'click [data-event=terms-button]': 'termsModal'
    'click .message-complete-cont button[data-url]': 'shareLink'
    'click [data-event=reset]': 'initialize'
    'click .btn-twitter': 'twShare'    
  	
  	# new @.shareModalView
  	# $('#share-modal').modal('show')
  	

  
  twShare: ->
    ga 'send','tweet','Button Clicks','twitter.com'


  termsModal: (event) ->
    event.preventDefault()
    new @.termsModalView()
    $('#terms-modal').modal('show')

  shareLink: (event) ->
    event.preventDefault()
    window.open $(event.currentTarget).data('url'), 'share-dialog', 'width=626,height=436'

  render: ->
    @.$el.html @.template

    Backbone.Validation.bind @

    Header = new @.headerView()
    Footer = new @.footerView()

module.exports = new Share
  