Git = require "./git"

git = new Git("chck/secretary")
#git = new Git("CyberAgent/Cabuki-server")
#git.getPRs().done((res)-> console.log res)

git.getMergedPRCommits(6).done((res) ->
  console.log res
)

#git.getCommits 6, (err, res) ->
#  console.log err
#  console.log res

#_ = require "lodash"
#
#data = [
#  {
#    commit:
#      author: {
#        name: "chck"
#      },
#      message: "Merge pull request #1381 from",
#      url: "xxx"
#  },
#  {
#    commit:
#      author: {
#        name: "kchc"
#      },
#      message: "Merge pull request #18 from",
#      url: "xxx"
#  }
#]
#
#console.log _.chain(data).map((row) -> row.commit).value()
