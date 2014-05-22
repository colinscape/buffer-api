API = require '../src/api.coffee'
BufferApi = require '../src/buffer-api.coffee'
should = require 'should'
sinon = require 'sinon'
request = require 'request'

describe 'API', ->
  beforeEach ->
    @api = new API(12345)
    @get = sinon.mock(request).expects('get')
    @post = sinon.mock(request).expects('post')

  it 'appends the access token and prepends the api url to every url accessed through it', ->
    @get.withArgs('https://api.bufferapp.com/1/user.json?access_token=12345')
    @api.get('/user.json?')
    @get.verify()

  it 'concats the access_token with an ampersand in case there is already a GET param in the url', ->
    @get.withArgs('https://api.bufferapp.com/1/links/shares.json?url=http%3A%2F%2Fbufferapp.com&access_token=12345')
    @api.get('/links/shares.json?url=http%3A%2F%2Fbufferapp.com')
    @get.verify()

  it 'parses the JSON response from each GET request', (done) ->
    @get.yields(null, null,'{"shares":47348}')
    @api.get('http://bufferapi.com', (err, obj) ->
      (err == null).should.be.ok
      obj.shares.should.equal(47348)
      done()
    )

  it 'sends through the callback the error retrieved', (done) ->
    @get.yields('error!!!', null, null)
    @api.get('http://bufferapi.com', (err, obj) ->
      err.should.equal('error!!!')
      (obj == undefined).should.be.ok
      done()
    )

  it 'adds the passed parameters to the POST requests', (done) ->
    parameters = {order: ['12653sa23', '1asd91234', '0w9102d']}
    @post.yields(null, null, '{"success": true}')
    @api.post('http://bufferapi.com', parameters, (err, obj) ->
      obj.success.should.be.true
      done()
    )

  afterEach ->
    request.get.restore()
    request.post.restore()

describe 'BufferApi', ->

  ACCESS_TOKEN = '1'
  ACCESS_TOKEN_SUFFIX = "access_token=#{ACCESS_TOKEN}"

  it 'exists', ->
    @api = new BufferApi(ACCESS_TOKEN)
    @api.should.not.be.null

