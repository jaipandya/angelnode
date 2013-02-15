#
# client.coffee: AngelNode Client
#
# Copyright © 2013 Jai Pandya. All rights reserved
#

# Requiring modules
request = require 'request'

# Initiate class
class Client

  constructor: (@token) ->

# Export modules
module.exports = (token) ->
  new Client(token)
