APIEndpoint = require './endpoint'

class Links extends APIEndpoint

  shares: (link, callback) ->
    encodedLink = encodeURIComponent link
    url = "/links/shares.json?url=#{encodedLink}"
    @api.get url, callback

module.exports = Links
