Buffer API
==========

Node wrapper for the Buffer API.

Installation
------------


	$ npm install buffer-api


Usage
-----

### CoffeeScript

	Buffer = require 'buffer-api'

 	access_token = XXX
	api = new Buffer access_token

	api.getUserInfo (err, user) ->

	if err? then return console.log "Error: #{err}"

	  console.log "Name: #{user.name}""
	  console.log "Created: #{new Date user.created_at}"
	  console.log "Activity: #{new Date user.activity_at}"

	api.getProfileInfo (err, profiles) ->

	  if err? then return console.log "Error: #{err}"

	  for profile in profiles
	    console.log "#{profile.service_username} @ #{profile.service}"

	link = "http://bufferapp.com"
	api.getLinks link, (err, info) =>

	  if err? then return console.log "Error: #{err}"

	  console.log "Links to #{link} : #{info.shares}"

	api.getConfiguration (err, config) ->

	  if err? then return console.log "Error: #{err}"

	  console.log "Supported services:"
	  console.log service for service,info of config.services


Note
----

This library is very incomplete as it stands.

The only functionality available is to get the user and profile objects.

More functionality will come in time.

License
-------

MIT
