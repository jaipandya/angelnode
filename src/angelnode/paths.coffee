class Paths

  constructor: (@client) ->

  responseHandler: (errMessage = 'Error', callback) ->
    (err, statusCode, responseBody) ->
      return callback(err) if err
      if statusCode isnt 200 then callback(new Error(errMessage)) else callback(null, responseBody)

  # Show paths between you and given user/startup ids.

  # Additional notes:
  #- for each user/startup up to 10 different paths will show up
  #- up to 20 ids per request are allowed
  #- do not use user_ids and startup_ids at the same time

  get: (options, callback) ->
  	# Ensure presence of token, authentication required for this method
    return callback(new Error('No token provided, method requires authentication')) unless @client.token?
    @client.get "/paths", options, @responseHandler("Paths get error", callback)

 # Export module
module.exports = Paths