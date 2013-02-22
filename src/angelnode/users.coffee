#
# users.coffee: AngelList Users class
#
# Copyright © 2013 Jai Pandya. All rights reserved
#

# Requiring modules

# Initiate class
class User

  constructor: (@client) ->

  responseHandler: (errMessage = 'Error', callback) ->
    (err, statusCode, responseBody) ->
      return callback(err) if err
      if statusCode isnt 200 then callback(new Error(errMessage)) else callback(null, responseBody)


  get: (options, callback) ->
    # id is required
    return unless options?.id?
    # Check type of id, if it is an Array then call /users/batch , otherwise /users/:id
    if typeof options.id is "Array"
      @client.get "/users/batch", {"ids": options.id.join(",")}, @responseHandler("User batch get error", callback)    
    else
      @client.get "/users/#{options.id}", {}, @responseHandler("User get error", callback)

  startups: (options, callback) ->
    # id is required
    return unless options?.id?
    @client.get "/users/#{options.id}/startups", {}, @responseHandler("User startups get error", callback)

  search: (options, callback) ->
    return callback(new Error('No search parameter specified')) unless (options? and (options.slug? or options.md5?))
    @client.get "/usrs/search", options, @responseHandler("User search get error", callback)

  me: (callback) ->
    # Ensure presence of token, authentication required for this method
    return callback(new Error('No token provided, method requires authentication')) unless @client.token?
    @client.get "/users/me", {}, @responseHandler("User info get error", callback)
  

# Export module
module.exports = User
