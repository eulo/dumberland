module.exports = Backbone.Model.extend
  idAttribute: 'id'
  url: '/api/message'
  validation:
    'to_name':
      required: true
      msg: 'Please enter your friends name'
    'to_email':
      required: true
      pattern: 'email'
      msg: 'Please enter a valid email for your friend'
    'from_name':
      required: true
      msg: 'Please enter your name'
    'from_email': [
      required: true
      pattern: 'email'
      msg: 'Please enter a valid email'
    ,
      fn: (val, attr, state) ->
        if val == state.to_email
          return 'To & From email is the same'
    ]
    'message':
      required: true
      msg: 'Please enter a message for your friend'
    'terms':
      required: true
      msg: 'Please accept the terms & conditions'

