APIEndpoint = require './endpoint'

class User extends APIEndpoint

  info: (callback) ->
    url = "/user.json?"
    @api.get url, callback

module.exports = User
