$ = require 'jquery'
$.fn.serializeObject = ->
  o = {}
  a = this.serializeArray()
  $.each a, ->
    if (o[this.name] != undefined)
      if (!o[this.name].push)
        o[this.name] = [o[this.name]]
      o[this.name].push(this.value || '')
    else
      o[this.name] = this.value || ''
  return o
