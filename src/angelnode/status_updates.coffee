class StatusUpdates

  constructor: (@client) ->

  responseHandler: (errMessage = 'Error', callback) ->
    (err, statusCode, responseBody) ->
      return callback(err) if err
      if statusCode isnt 200 then callback(new Error(errMessage)) else callback(null, responseBody)
  
  # Return status updates from the given user or startup. If neither is specified,
  # the authenticated user is used. Status updates are paginated and ordered by most recent first.
  get: (options, callback) ->
    @client.get "/status_updates", options, @responseHandler("Status update get error", callback)


  # Creates a status update for the authenticated user or for a startup the authenticated user is 
  # a team member of. Returns the new status update on success, or an error on failure.
  post: (options, callback) ->
    # Ensure presence of token, authentication required for this method
    return callback(new Error('No token provided, method requires authentication')) unless @client.token?
    unless options?.message?
      return callback(new Error('Message parameter not present'))
    @client.post "/status_updates", options, @responseHandler("Status update post error", callback)

  # Destroys the specified status update belonging to the authenticated user or to a startup the 
  # authenticated user is a team member of. 
  # Returns the destroyed status update on success, or an error on failure.
  delete: (options, callback) ->
    # Ensure presence of token, authentication required for this method
    return callback(new Error('No token provided, method requires authentication')) unless @client.token?
    unless options?.id?
      return callback(new Error('id parameter not present'))
    @client.del "/status_updates/#{options.id}", options, @responseHandler("Status update delete error", callback)

 # Export module
module.exports = StatusUpdates