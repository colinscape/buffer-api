APIEndpoint = require './endpoint'
class Updates extends APIEndpoint

  get: (update_id, callback) ->
    url = "/updates/#{update_id}.json?"
    @api.get url, callback

  pending_for: (profile_id, callback) ->
    url = "/profiles/#{profile_id}/updates/pending.json?"
    @api.get url, callback

  sent_for: (profile_id, callback) ->
    url = "/profiles/#{profile_id}/updates/sent.json?"
    @api.get url, callback

  interactions_for: (update_id, callback) ->
    url = "/updates/#{update_id}/interactions.json?"
    @api.get url, callback

  reorder: (profile_id, parameters, callback) ->
    url = "/profiles/#{profile_id}/updates/reorder.json?"
    @api.post url, parameters, callback

  shuffle: (profile_id, parameters, callback) ->
    url = "/profiles/#{profile_id}/updates/shuffle.json?"
    @api.post url, parameters, callback

  create: (parameters, callback) ->
    url = "/updates/create.json?"
    @api.post url, parameters, callback

  edit: (update_id, parameters, callback) ->
    url = "/updates/#{update_id}/update.json?"
    @api.post url, parameters, callback

  share: (update_id, callback) ->
    url = "/updates/#{update_id}/share.json?"
    @api.post url, null, callback

  delete: (update_id, callback) ->
    url = "/updates/#{update_id}/destroy.json?"
    @api.post url, null, callback

  toTop: (update_id, callback) ->
    url = "/updates/#{update_id}/move_to_top.json?"
    @api.post url, null, callback

module.exports = Updates
