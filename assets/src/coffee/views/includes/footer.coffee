Handlebars = require 'hbsfy/runtime'

Footer = Backbone.View.extend
  
  el: '#footer'

  template: require '../../../tmpl/components/footer.hbs'
  termsModalView: require './terms-modal'
  shareModalView: require './share-modal'

  initialize: ->
    @.render()

  events:
    'click [data-event=terms-button-footer]': 'termsModal'

  termsModal: (event) ->
    event.preventDefault()
    new @.termsModalView()
    $('#terms-modal').modal('show')

  render: ->
    @.$el.html @.template

module.exports = Footer
