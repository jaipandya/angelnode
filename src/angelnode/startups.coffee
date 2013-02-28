class Startups

  constructor: (@client) ->

  responseHandler: (errMessage = 'Error', callback) ->
    (err, statusCode, responseBody) ->
      return callback(err) if err
      if statusCode isnt 200 then callback(new Error(errMessage)) else callback(null, responseBody)


  # Get a company's information given an id. quality is an 
  # integer between 0 and 10, calculated every 48 hours, and reflects the 
  # company's rank on AngelList. Higher numbers mean better quality. 
  # community_profile is true if the company's profile was automatically 
  # generated and has not been 'claimed' by anyone at the company.

  get: (options, callback) ->
    # id is required
    return unless options?.id?
    # Check type of id, if it is an Array then call /startups/batch , otherwise /startups/:id
    if typeof options.id is "Array"
      @client.get "/startups/batch", {"ids": options.id.join(",")}, @responseHandler("Startups batch get error", callback)    
    else
      @client.get "/startups/#{options.id}", {}, @responseHandler("Startups get error", callback)

  # Returns the comments on the given company.
  comments: (options, callback) ->
    # id is required
    return unless options?.id?
    @client.get "/startups/#{options.id}/comments", {}, @responseHandler("Startups comments get error", callback)

  # Returns the users tagged in the given company's profile.
  users: (options, callback) ->
    # id is required
    return unless options?.id?
    @client.get "/startups/#{options.id}/users", {}, @responseHandler("Startups users get error", callback)

  # Search for a company given a URL slug. Responds like GET /startups/:id.
  search: (options, callback) ->
    return callback(new Error('No search parameter specified')) unless (options? and (options.slug? or options.domain?))
    @client.get "/startups/search", options, @responseHandler("Startups search get error", callback)


 # Export module
module.exports = Startups