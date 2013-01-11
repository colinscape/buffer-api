
request = require 'request'

parseBody = (err, resp, body, cb) ->
  if err? then return cb err

  try
    obj = JSON.parse body
  catch e
    console.log body
    return cb e
  return cb null, obj

class BufferAPI

  constructor: (@access_token) ->

  getUserInfo: (cb) ->
    url = "https://api.bufferapp.com/1/user.json?access_token=#{@access_token}"
    request.get url, (err, resp, body) -> parseBody err, resp, body, cb


  getProfileInfo: (cb) ->
    url = "https://api.bufferapp.com/1/profiles.json?access_token=#{@access_token}"
    request.get url, (err, resp, body) -> parseBody err, resp, body, cb

  getLinks: (link, cb) ->
    encodedLink = encodeURIComponent link
    url = "https://api.bufferapp.com/1/links/shares.json?access_token=#{@access_token}&url=#{encodedLink}"
    request.get url, (err, resp, body) -> parseBody err, resp, body, cb

module.exports = BufferAPI