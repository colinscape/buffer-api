APIEndpoint = require './endpoint'

class Info extends APIEndpoint

  configuration: (callback) ->
    url = "/info/configuration.json?"
    @api.get url, callback

module.exports = Info
