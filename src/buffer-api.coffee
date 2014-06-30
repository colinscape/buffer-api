User = require './endpoints/user'
Profile = require './endpoints/profile'
Links = require './endpoints/links'
Info = require './endpoints/info'
Updates = require './endpoints/updates'
APIEndpoint = require './endpoints/endpoint'
API = require './api'
request = require 'request'

class BufferAPI

  constructor: (access_token) ->
    @api = new API(access_token)
    @user = new User(@api)
    @profile = new Profile(@api)
    @links = new Links(@api)
    @info = new Info(@api)
    @updates = new Updates(@api)

  getUserInfo: (callback) ->
    @user.info(callback)

  getProfileInfo: (callback) ->
    @profile.info(callback)

  getLinks: (link, callback) ->
    @links.shares(link, callback)

  getConfiguration: (callback) ->
    @info.configuration(callback)

  ## UPDATES
  # GET
  getUpdate: (update_id, callback) ->
    @updates.get(update_id, callback)

  getPendingUpdates: (profile_id, callback) ->
    @updates.pending_for(profile_id, callback)

  getSentUpdates: (profile_id, callback) ->
    @updates.sent_for(profile_id, callback)

  getUpdateInteractions: (update_id, callback) ->
    @updates.interactions_for(update_id, callback)

  # POST
  reorderUpdates: (profile_id, parameters, callback) ->
    @updates.reorder(profile_id, parameters, callback)

  shuffleUpdates: (profile_id, parameters, callback) ->
    @updates.shuffle(profile_id, parameters, callback)

  createUpdate: (parameters, callback) ->
    @updates.create(parameters, callback)

  editUpdate: (update_id, parameters, callback) ->
    @updates.edit(update_id, parameters, callback)

  shareUpdate: (update_id, callback) ->
    @updates.share(update_id, callback)

  deleteUpdate: (update_id, callback) ->
    @updates.delete(update_id, callback)

  moveUpdateToTop: (update_id, callback) ->
    @updates.toTop(update_id, callback)

module.exports = BufferAPI
