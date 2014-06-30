request = require 'request'

class API
  base_api_url: 'https://api.bufferapp.com/1'
  constructor: (access_token) ->
    @access_token_suffix = "access_token="+access_token

  has_get_params: (url) ->
    url.slice(-1) != '?'

  path: (url) ->
    full_path = @base_api_url + url
    if(@has_get_params(url)) then full_path += '&'
    full_path += @access_token_suffix
    full_path

  get: (url, callback) ->
    that = @
    request.get @path(url), (err, resp, body) ->
      that.parseBody err, resp, body, callback

  post: (url, parameters, callback) ->
    that = @
    request.post @path(url), form: parameters, (err, resp, body) ->
      that.parseBody err, resp, body, callback

  parseBody: (err, resp, body, callback) ->
    if err? then return callback err

    try
      obj = JSON.parse body
    catch e
      console.log body
      return callback e
    return callback null, obj

module.exports = API
