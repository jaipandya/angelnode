#
# angelnode.coffee: Top level include for angelnode module
#
# Copyright © 2013 Jai Pandya. All rights reserved
#

# Globals

API_BASE_URL = 'https://api.angel.co/1'
REQ_TOKEN_URL = 'https://angel.co/api/oauth/authorize'
ACCESS_TOKEN_URL = 'https://angel.co/api/oauth/token'

angelnode = module.exports =

  # [Authentication](angelnode/auth.html) for github
  auth: require './angelnode/auth'

  # [Client](angelnode/client.html) for github
  client: require './angelnode/client'
