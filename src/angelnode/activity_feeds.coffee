class ActivityFeeds

  constructor: (@client) ->

  responseHandler: (errMessage = 'Error', callback) ->
    (err, statusCode, responseBody) ->
      return callback(err) if err
      if statusCode isnt 200 then callback(new Error(errMessage)) else callback(null, responseBody)

  # Returns site activity. If authenticated and the personalized parameter is passed in, 
  # only activity from the authenticated user's social graph is returned. No more than 25 items
  # will be returned. Results are paginated and ordered by most recent story first, 
  # unless a since parameter is given.
  get: (options, callback) ->
    @client.get "/feed", options, @responseHandler("Feed get error", callback)


  # Returns a specific activity feed item.
  item: (options, callback) ->
    return unless options?.id?
    @client.get "/feed/#{options.id}", {}}, @responseHandler("Feed get error", callback)

 # Export module
module.exports = ActivityFeeds