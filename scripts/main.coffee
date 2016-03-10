# Commands:
#   hubot-release - Create pull request for release and reply with the url

c = require('config')
util = require('./lib/util')
git = require('./lib/git')

module.exports = (robot) ->
  if robot.adapterName == "slack"
    robot.hear ///#{c.prefix}-release///, (msg) ->
      title = util.withDate("Release")
      git.createPRwithCommitter(title).done((url) ->
        msg.reply url
      )
