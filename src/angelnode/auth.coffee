#
# auth.coffee: Authentication module for AngelList
#
# Copyright © 2013 Jai Pandya. All rights reserved
#

# Requiring modules
request = require 'request'
url = require 'url'
qs = require 'querystring'
config = require 'config'

# Authentication module
auth = module.exports =
  
  # @params {options} Hash, containing id and secret
  config: (options) ->
    @options = options
    return this

  # @params {scopes} Array of scope elements, optional
  getAuthUrl: (scopes) ->
    uri = config["authCodeUrl"]
    uri+= '?client_id=' + @options.id
    if scopes?
      uri+= '&scope=' + scopes.join(',')
    uri+= '&response_type=code' 

  getAccessToken: (code, callback) ->
    request
      url: config["accessTokenUrl"],
      method: 'POST'
      body: qs.stringify
        code: code
        client_id: @options.id
        client_secret: @options.secret
        grant_type: 'authorization_code'
      headers:
        'Content-Type': 'application/x-www-form-urlencoded'
    , (err, res, body) ->
      if res.statusCode is 404
        callback(new Error('Access token not found'))
      else
        body = qs.parse body
        if body.error then callback(new Error(body.error)) else callback(null, body.access_token)