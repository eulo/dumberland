Handlebars = require 'hbsfy/runtime'

Header = Backbone.View.extend
  
  el: '#header'

  template: require '../../../tmpl/components/header.hbs'
  shareModalTmpl: require '../../../tmpl/components/share-modal.hbs'

  initialize: ->
    @.render()

  events:
    'click [data-event=share-modal]': 'shareModal'
    'click #share-modal button[data-url]': 'shareLink'

  shareModal: (event)->
    event.preventDefault()
    if !$('#share-modal').length
      @.$el.append @.shareModalTmpl
    $('#share-modal').modal('show')

  shareLink: (event) ->
    event.preventDefault()
    window.open $(event.currentTarget).data('url'), 'share-dialog', 'width=626,height=436'

  render: ->
    @.$el.html @.template

module.exports = Header
