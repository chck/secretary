git = require('githubot')
Promise = require('q').Promise
config = require('config')
_ = require('lodash')

class Git
  process.env.HUBOT_GITHUB_TOKEN = config.git.token

  @createPR: (title, baseBranch, headBranch) ->
    request = {title: title, base: baseBranch, head: headBranch}
    postPull(request)
    .then (pull) -> getCommits(pull.number)

  @createPRwithCommitter: (title) ->
    request = {title: title, base: config.git.base_branch, head: config.git.head_branch}
    postPull(request)
    .then (pull) ->
      getCommits(pull.number)
      .then (commits) ->
        body = _.chain(commits).reduce((a, b) -> _.merge(a, b)
        ).map((v, k) -> _.flatten([k, v]).join("\n")
        ).join("\n\n").value()
        postPull({body: body}, pull.number)
        .then (pull) -> pull.html_url

  @getPulls: (id) ->
    return new Promise (resolve, reject) ->
      git.get endpoint("pulls", id), (pulls) -> resolve pulls

  postPull = (request, id) ->
    return new Promise (resolve, reject) ->
      git.post endpoint("pulls", id), request, (pull) -> resolve pull

  getCommits = (pullId) ->
    return new Promise (resolve, reject) ->
      git.get endpoint("pulls", pullId + "/commits"), (commits) ->
        resolve _.chain(commits).map((row) -> {
          committer: row.committer.login,
          pullId: getPullIdFrom(row.commit.message)
        }).filter((row) -> row.pullId?
        ).groupBy((row) -> row.committer
        ).map((rows, committer) -> "@#{committer}": rows.map((row) -> row.pullId)
        ).value()

  getPullIdFrom = (message) ->
    pullId = message.match(/^Merge pull request (#\d+) from/)
    if pullId? then pullId[1] else null

  endpoint = (resource, id) ->
    elem = [config.git.base_uri, resource]
    elem.push(id) if id?
    elem.join("/")

module.exports = Git
