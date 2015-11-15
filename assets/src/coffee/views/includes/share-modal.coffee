Handlebars = require 'hbsfy/runtime'

module.exports = Backbone.View.extend
  
  el: '#modal'

  template: require '../../../tmpl/components/share-modal.hbs'

  initialize: (params)->
    @.render()

  render: ->
    @.$el.html @.template
