
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
    @uri = "https://api.bufferapp.com/1";
    @access_token_suffix = "access_token="+@access_token;

  getUserInfo: (cb) ->
    url = "#{@uri}/user.json?#{@access_token_suffix}"
    request.get url, (err, resp, body) -> parseBody err, resp, body, cb

  getProfileInfo: (cb) ->
    url = "#{@uri}/profiles.json?#{@access_token_suffix}"
    request.get url, (err, resp, body) -> parseBody err, resp, body, cb

  getLinks: (link, cb) ->
    encodedLink = encodeURIComponent link
    url = "#{@uri}/links/shares.json?#{@access_token_suffix}&url=#{encodedLink}"
    request.get url, (err, resp, body) -> parseBody err, resp, body, cb

  getConfiguration: (cb) ->
    url = "#{@uri}/info/configuration.json?#{@access_token_suffix}"
    request.get url, (err, resp, body) -> parseBody err, resp, body, cb

  ## UPDATES
  # GET
  getUpdate: (update_id, cb) ->  
    url = "#{@uri}/updates/#{update_id}.json?#{@access_token_suffix}"
    request.get url, (err, resp, body) -> parseBody err, resp, body, cb

  getUpdateInteractions: (update_id, cb) ->
    url = "#{@uri}/updates/#{update_id}/interactions.json?#{@access_token_suffix}"
    request.get url, (err, resp, body) -> parseBody err, resp, body, cb

  getPendingUpdates: (profile_id, cb) ->
    url = "#{@uri}/profiles/#{profile_id}/updates/pending.json?#{@access_token_suffix}"
    request.get url, (err, resp, body) -> parseBody err, resp, body, cb

  getSentUpdates: (profile_id, cb) ->
    url = "#{@uri}/profiles/#{@profile_id}/updates/sent.json?#{@access_token_suffix}"
    request.get url, (err, resp, body) -> parseBody err, resp, body, cb

  # POST
  reorderUpdates: (profile_id, parameters, cb) ->
    url = url = "#{@uri}/profiles/#{profile_id}/updates/reorder.json?#{@access_token_suffix}"
    request.post url, form: parameters, (err, resp, body) -> parseBody err, resp, body, cb

  shuffleUpdates: (profile_id, parameters, cb) ->
    url = "#{@uri}/profiles/#{profile_id}/updates/shuffle.json?#{@access_token_suffix}"
    request.post url, form: parameters, (err, resp, body) -> parseBody err, resp, body, cb

  createUpdate: (parameters, cb) ->
    url = "#{@uri}/updates/create.json?#{@access_token_suffix}"
    request.post url, form: parameters, (err, resp, body) -> parseBody err, resp, body, cb

  editUpdate: (update_id, parameters, cb) ->
    url = "#{@uri}/updates/#{update_id}/update.json?#{@access_token_suffix}"
    request.post url, form: parameters, (err, resp, body) -> parseBody err, resp, body, cb

  shareUpdate: (update_id, cb) ->
    url = "#{@uri}/updates/#{update_id}/share.json?#{@access_token_suffix}"
    request.post url, (err, resp, body) -> parseBody err, resp, body, cb

  deleteUpdate: (update_id, cb) ->
    url = "#{@uri}/updates/#{update_id}/destroy.json?#{@access_token_suffix}"
    request.post url, (err, resp, body) -> parseBody err, resp, body, cb

  moveUpdateToTop: (update_id, cb) ->
    url = "#{@uri}/updates/#{update_id}/move_to_top.json?#{@access_token_suffix}"
    request.post url, (err, resp, body) -> parseBody err, resp, body, cb

module.exports = BufferAPI