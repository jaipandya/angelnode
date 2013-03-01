#
# client.coffee: AngelNode Client
#
# Copyright © 2013 Jai Pandya. All rights reserved
#

# Requiring modules
request = require 'request'
config = require './config'

ActivityFeeds = require './activity_feeds'
Follows = require './follows'
Jobs = require './jobs'
Messages = require './messages'
Paths = require './paths'
Press = require './press'
Reviews = require './reviews'
Search = require './search'
StartupRoles = require './startup_roles'
Startups = require './startups'
StatusUpdates = require './status_updates'
Tags = require './tags'
Users = require './users'


# Initiate class
class Client

  constructor: (@token) ->

  # Endpoints
  
  # Activity feed
  feed: () ->
    new ActivityFeeds @

  # Follows
  follows: () ->
    new Follows @

  # Jobs
  jobs: () ->
    new Jobs @

  # Messages
  messages: () ->
    new Messages @

  # Paths
  paths: () ->
    new Paths @

  # Press
  press: () ->
    new Press @

  # Reviews
  reviews: () ->
    new Reviews @

  # Search
  search: () ->
    new Search @

  # Startup Roles
  startupRoles: () ->
    new StartupRoles @

  # Startups
  startups: () ->
    new Startups @

  # Status Updates
  statusUpdates: () ->
    new StatusUpdates @

  # Tags
  tags: () ->
    new Tags @

  users: () ->
    new Users @

  query: (path = '/') ->
    path = '/' + path if path[0] isnt '/'
    uri = config.apiBaseUrl + path
    if typeof @token == 'string'
      uri+= "?access_token=#{@token}"
    else
      uri
  # Throw error if any, otherwise parse json and return callback
  responseHandler: (res, body, callback) ->
    return callback(new Error('Error ' + res.statusCode)) if Math.floor(res.statusCode/100) is 5
    try
      body = JSON.parse(body || '{}')
    catch err
      return callback(err)
    return callback(new Error(body.message)) if body.message and res.statusCode is 422
    return callback(new Error(body.message)) if body.message and res.statusCode in [400, 401, 404]
    callback null, res.statusCode, body

  # API GET request
  get: (path, params, callback) ->
    request
      uri: @query path
      method: 'GET'
      qs: params
    , (err, res, body) =>
      return callback(err) if err
      @responseHandler res, body, callback

  # API POST request
  post: (path, params, callback) ->
    request
      uri: @query path
      method: 'POST'
      form: params
    , (err, res, body) =>
      return callback(err) if err
      @responseHandler res, body, callback

  # API DELETE request
  del: (path, params, callback) ->
    request
      uri: @query path
      method: 'DELETE'
      form: params
    , (err, res, body) =>
      return callback(err) if err
      @responseHandler res, body, callback


# Export modules
module.exports = (token) ->
  new Client(token)
