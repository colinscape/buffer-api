User = require '../src/endpoints/user.coffee'
Profile = require '../src/endpoints/profile.coffee'
Links = require '../src/endpoints/links.coffee'
Info = require '../src/endpoints/info.coffee'
Updates = require '../src/endpoints/updates.coffee'
should = require 'should'
sinon = require 'sinon'

describe 'Endpoints', ->
  callback = () ->

  class FakeApi
    get: () ->
    post: () ->

  beforeEach ->
    @api = new FakeApi
    @get = sinon.mock(@api).expects('get')
    @post = sinon.mock(@api).expects('post')

  describe 'User', ->

    it 'calls /user.json for retrieving user info', ->
      @get.withArgs('/user.json?', callback)
      user = new User(@api)
      user.info(callback)
      @get.verify()

  describe 'Profile', ->

    it 'calls /profiles.json for retrieving profiles info', ->
      @get.withArgs('/profiles.json?', callback)
      profile = new Profile(@api)
      profile.info(callback)
      @get.verify()

  describe 'Links', ->
    it 'encodes the link for retrieving link shares', ->
      @get.withArgs("/links/shares.json?url=a%20link")
      links = new Links(@api)
      links.shares('a link', callback)
      @get.verify()

  describe 'Info', ->
    it 'calls /info/configuration.json for retrieving user configuration', ->
      @get.withArgs("/info/configuration.json?")
      info = new Info(@api)
      info.configuration(callback)
      @get.verify()

  describe 'Updates', ->
    beforeEach ->
      @updates = new Updates(@api)

    it 'calls /updates/:update_id for retrieving info about that update', ->
      @get.withArgs("/updates/12.json?")
      @updates.get('12', callback)
      @get.verify()

    it 'calls /profiles/:id/updates/pending for retrieving pending updates for that profile', ->
      @get.withArgs("/profiles/1/updates/pending.json?")
      @updates.pending_for('1', callback)
      @get.verify()

    it 'calls /profiles/:id/updates/sent for retrieving sent updates for that profile', ->
      @get.withArgs("/profiles/1/updates/sent.json?")
      @updates.sent_for('1', callback)
      @get.verify()

    it 'calls /updates/:id/interactions for the detailed information on individual interactions with that update', ->
      @get.withArgs("/updates/12/interactions.json?")
      @updates.interactions_for('12', callback)
      @get.verify()

    it 'calls /profiles/:id/updates/reorder for editing the statuses\' order', ->
      @post.withArgs('/profiles/1/updates/reorder.json?')
      @updates.reorder('1', {order: [12345654, 530412, 1023214]}, callback)
      @post.verify()

    it 'calls /profiles/:id/updates/shuffle for editing the statuses\' order', ->
      @post.withArgs('/profiles/1/updates/shuffle.json?')
      @updates.shuffle('1', {}, callback)
      @post.verify()

    it 'calls /updates/create for creating a new update', ->
      @post.withArgs('/updates/create.json?')
      @updates.create({text: 'I\'m testing Buffer\'s API!', profile_ids: ['76523jksdf2', '19384akjsd22']}, callback)
      @post.verify()

    it 'calls /updates/:id/update to edit the update', ->
      @post.withArgs('/updates/12/update.json?')
      @updates.edit('12', {text: 'Now I\'m updating the update #12!'})
      @post.verify()

    it 'calls /updates/:id/share to share the update inmediately', ->
      @post.withArgs('/updates/12/share.json?')
      @updates.share('12')
      @post.verify()

    it 'calls /updates/:id/destroy to delete the update inmediately', ->
      @post.withArgs('/updates/12/destroy.json?')
      @updates.delete('12')
      @post.verify()

    it 'calls /updates/:id/mode_to_top to move the update to the top of the queue', ->
      @post.withArgs('/updates/12/move_to_top.json?')
      @updates.toTop('12')
      @post.verify()

  afterEach ->
    @api.get.restore()
    @api.post.restore()
