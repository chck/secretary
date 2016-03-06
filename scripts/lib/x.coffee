git = require('githubot')
Promise = require('q').Promise
config = require('config')
_ = require('lodash')

class X
  #  constructor: ->
  base_uri = "https://api.github.com/repos/#{config.git.repo}"
  process.env.HUBOT_GITHUB_TOKEN = config.git.token

  endpoint = (resource, id) ->
    elem = [base_uri, resource]
    elem.push(id) if id?
    elem.join("/")

  @getPulls: (id) ->
    return new Promise (resolve, reject) ->
      git.get endpoint("pulls", id), (pulls) -> resolve pulls


module.exports = X
