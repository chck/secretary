Git = require "./git"
_ = require('lodash')

git = new Git("chck/secretary")
#git = new Git("CyberAgent/Cabuki-server")
#git.getPRs().done((res)-> console.log res)

#git.getMergedPRCommits(6).done((res) ->
#  console.log res
#)




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

data = {
  chck:
    [{committer: 'chck', prNumber: '#333'},
      {committer: 'chck', prNumber: '#338'}]
  hkcc:
    [{committer: 'hkcc', prNumber: '#332'},
      {committer: 'hkcc', prNumber: '#331'}]
}

#git.createBody(data) #.done((res) -> console.log res)
##console.log _.chain(data).map((row) -> row.commit).value()

x = require('./x')
x.getPulls().done( (res) -> console.log res)

