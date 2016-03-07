r = require('redis')
util = require('./lib/util')
git = require('./lib/git')

module.exports = (robot) ->
  if robot.adapterName == "slack"
    robot.hear ///#{robot.name}-release///, (msg) ->
      title = util.withDate("Release")
      git.createPRwithCommitter(title).done((url) ->
        msg.reply url
      )

#    robot.respond /.*/, (msg) ->
#      msg.reply "test"

#    robot.respond /redis/, (msg) ->
#      k = "test"

###
client = r.createClient()
client.set(k, "test-value")
client.get(k, (err, reply) ->
  if err
    throw err
  else if reply
    # msg.reply JSON.parse(reply)
    msg.reply reply
  else
    msg.reply "key: #{k}は見つかりません"
)
###
