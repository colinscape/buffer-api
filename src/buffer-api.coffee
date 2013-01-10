
request = require 'request'

class BufferAPI

  constructor: (@access_token) ->

  getUserInfo: (cb) ->
    url = "https://api.bufferapp.com/1/user.json?access_token=#{@access_token}"
    console.log url
    request.get url, (err, resp, body) ->

      if err? then return cb err

      try
        user = JSON.parse body
      catch e
        return cb e

      return cb null, user

module.exports = BufferAPI