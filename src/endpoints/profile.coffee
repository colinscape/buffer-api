APIEndpoint = require './endpoint'

class Profile extends APIEndpoint

  info: (callback) ->
    url = "/profiles.json?"
    @api.get url, callback

module.exports = Profile
