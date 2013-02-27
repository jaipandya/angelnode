class Tags

  constructor: (@client) ->

  responseHandler: (errMessage = 'Error', callback) ->
    (err, statusCode, responseBody) ->
      return callback(err) if err
      if statusCode isnt 200 then callback(new Error(errMessage)) else callback(null, responseBody)
  
  # Get information on a tag, including statistics such as:
  # investor_followers, the number of investors following this tag.
  # followers, the number of users following this tag, including investors.
  # startups, the number of startups listed under this tag.
  # users, LocationTag only, the number of users in this location.
  get: (options, callback) ->
    # id is required
    return unless options?.id?
    @client.get "/tags/#{options.id}", {}, @responseHandler("Tag get error", callback)

  # Returns children of the given tag. Market and location 
  # tags form a Directed Acyclic Graph. Results are paginated 
  # and ordered by id descending.
  children: (id, callback) ->
    # id is required
    unless options?.id?
      return callback(new Error('id parameter not present'))
    @client.get "/tags/#{options.id}/children", {}, @responseHandler("Tag children get error", callback)

  # Returns parents of the given tag. 
  # For more details, see the documentation for GET /tags/:id/children
  parents: (id, callback) ->
    # id is required
    return unless options?.id?
      return callback(new Error('id parameter not present'))
    @client.get "/tags/#{options.id}/parents", {}, @responseHandler("Tag parent get error", callback)

  # Returns companies that are tagged with the given tag or a child of the given tag. 
  # Results are paginated and ordered according to the order parameter.
  startups: (options, callback) ->
    # id is required
    return unless options?.id?
      return callback(new Error('id parameter not present'))
    @client.get "/tags/#{options.id}/startups", options, @responseHandler("Tag parent get error", callback)

  # Returns users that are tagged with the given tag, either a LocationTag or MarketTag.
  # Results are paginated and ordered from highest quality to lowest quality.
  users: (options, callback) ->
    # id is required
    return unless options?.id?
      return callback(new Error('id parameter not present'))
    @client.get "/tags/#{options.id}/users", options, @responseHandler("Tag users get error", callback)


 # Export module
module.exports = Tags