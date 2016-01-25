git = require "githubot"
Promise = require("q").Promise
#config = require 'config'
_ = require "lodash"

class Git
  @BASE_URL = "https://api.github.com/repos/chck/secretary"
#  constructor: (repo) ->
#    @BASE_URL = "https://api.github.com/repos/#{repo}"
#      token = config.git.token

  createRelease: (suffix) ->
    data = {title: "Release_#{suffix}", head: "feature/with_git", base: "master"}
    postPR(data)#releaseプルリク作成
    .then (pr) ->
      body = extractMergedPRCommits(pr) #コミットからuserと#\d+を抽出
      data = {body: body}
      postPR(data, pr.number)#bodyを編集
    .then (pr) ->
#コミッターとSlackユーザー名を変換してプルリクのurlとセットで返す

  getPRs: (number) ->
    return new Promise (resolve, reject) ->
      URL = "#{@BASE_URL}/pulls"
      if number?
        git.get "#{URL}/#{number}", (pulls) -> resolve pulls
      else
        git.get URL, (pulls) -> resolve pulls

  postPR = (data, number) ->
    if number?
      git.post "#{@BASE_URL}/pulls/#{number}", data #, (pr) -> pr
    else
      git.post "#{@BASE_URL}/pulls", data #, (pr) -> pr

  #
  getMergedPRCommits: (prNumber) ->
    return new Promise (resolve, reject) ->
      URL = "#{Git.BASE_URL}/pulls/#{prNumber}/commits"
      git.get URL, (commits) ->
        if !commits
          reject "error occurred"
        resolve _.chain(commits).map((row) ->
          {
            committer: row.commit.committer.name,
            prNumber: getPRNumber(row.commit.message)
          }
        ).value()

  getPRNumber = (message) ->
    prNumber = message.match(/^Merge pull request (#\d+) from/)
    prNumber[1] if prNumber?

module.exports = Git
