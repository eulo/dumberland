module.exports = ->
  vars = {}
  hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&')
  for val in hashes
    hash = val.split('=')
    vars[hash[0]] = hash[1]
  return vars

