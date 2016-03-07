util = require('./lib/util')
git = require('./lib/git')

module.exports = (robot) ->
  if robot.adapterName == "slack"
    robot.hear ///#{robot.name}-release///, (msg) ->
      title = util.withDate("Release")
      git.createPRwithCommitter(title).done((url) ->
        msg.reply url
      )
