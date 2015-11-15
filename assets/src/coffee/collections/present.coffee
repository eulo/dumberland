Present = Backbone.Collection.extend
  url: '/api/present'
  model: require '../models/message'

module.exports = new Present
