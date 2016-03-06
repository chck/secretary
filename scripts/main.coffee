r = require "redis"
_ = require "lodash"
Promise = require("q").Promise

#repo = "CyberAgent/Cabuki-server"
repo = "chck/secretary"

#zero padding
zp = (num) -> ("00" + num).slice(-2).toString()
genSuffix = ->
  d = new Date()
  yyyy = "20" + zp(d.getYear())
  MMdd = zp(d.getMonth() + 1) + zp(d.getDate())
  Hm = zp(d.getHours()) + zp(d.getMinutes())
  "#{yyyy}.#{MMdd}.#{Hm}"

module.exports = (robot) ->
  github = require("githubot")(robot)

  #  if robot.adapterName == "slack"
  #  robot.respond /.*/, (msg) -> msg.reply "test"
  robot.respond /pulls/, (msg) ->
#    robot.logger.info("")
    github.get "https://api.github.com/repos/#{repo}/pulls", (pulls) ->
      robot.logger.info(pulls)
  #    msg.reply "test"

  robot.respond /release/, (msg) ->
    #    data = {title: "Release_#{suffix}", head: "master", base: "release"}
    data = {title: "Release_#{genSuffix()}", head: "feature/with_git", base: "master"}
    github.post "https://api.github.com/repos/#{repo}/pulls", data, (pr) ->
      github.get "https://api.github.com/repos/#{repo}/pulls/#{pr.number}/commits", (commits) ->
        console.log commits
        console.log "----------------------------------------------"

        console.log _.chain(commits).pluck("commit").value()
        console.log "**********"

  robot.respond /redis/, (msg) ->
    k = "test"

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
