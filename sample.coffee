Buffer = require './src/buffer-api.coffee'

access_token = 'YOUR_ACCES_TOKEN'
api = new Buffer access_token

api.getUserInfo (err, user) ->

  if err? then return console.log "Error: #{err}"
  console.log "Name: #{user.name}"
  console.log "Created: #{new Date user.created_at}"
  console.log "Activity: #{new Date user.activity_at}"

api.getProfileInfo (err, profiles) ->

  if err? then return console.log "Error: #{err}"
  profile_id = profiles[0].id

  update = {
    text: 'test api',
    profile_ids: [
      profile_id
    ]
  }
  
  api.getSentUpdates(profile_id, (err, data) ->
    if err? then return console.log "Error #{err}"
    if data.total > 0 then console.log "Sent updates are being retrieved"
  )

  api.createUpdate(update, (err, data) ->
    if err? then return console.log "Error #{err}"
    if data.success
      console.log "Update creation: successful"
      id = data.updates[0].id
      api.deleteUpdate(id, (err, data) ->
        if err? then return console.log "Error #{err}"
        if data.success then return console.log "Update removal: successful"
      )
  )

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
