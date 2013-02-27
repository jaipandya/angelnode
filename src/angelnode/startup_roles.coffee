class StartupRoles

  constructor: (@client) ->

  responseHandler: (errMessage = 'Error', callback) ->
    (err, statusCode, responseBody) ->
      return callback(err) if err
      if statusCode isnt 200 then callback(new Error(errMessage)) else callback(null, responseBody)

  # Return status updates from the given user or startup. If neither is specified, 
  # the authenticated user is used. Status updates are paginated and ordered by most recent first.
  get: (options, callback) ->
    @client.get "/startup_roles", options, @responseHandler("Startup role get error", callback)

 # Export module
module.exports = StartupRoles