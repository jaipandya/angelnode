#
# users.coffee: AngelList Users class
#
# Copyright © 2013 Jai Pandya. All rights reserved
#

# Requiring modules

# Initiate class
class User

  constructor: (@client) ->

  responseHandler: (errMessage = 'Error') ->
    (err, statusCode, responseBody) ->
      return callback(err) if err
        if statusCode isnt 200 then callback(new Error(errMessage)) else callback null, responseBody


  get: (id, callback) ->
    # Check type of id, if it is an Array then call /users/batch , otherwise /users/:id
    if typeof id is "Array"
      @client.get "/users/batch", {"ids": id.join(",")}, @responseHandler("User batch get error")
        
    else
      @client.get "/users/#{id}", {}, @responseHandler("User get error")

  startups: (id, callback) ->
    @client.get "/users/#{id}/startups", {}, @responseHandler("User startups get error")

  search: (options, callback) ->
    callback(new Error('No search parameter specified')) unless (options?.slug? or options?.md5?)
    @client.get "/usrs/search", options, @responseHandler("User search get error")

  me: (callback) ->
    # Ensure presence of token, authentication required for this method
    callback(new Error('No token provided, method requires authentication')) unless @client.token?
    @client.get "/users/me", {}, @responseHandler("User info get error")
  

# Export module
module.exports = User
