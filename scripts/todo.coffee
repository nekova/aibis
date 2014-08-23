# Description:
#   Utility commands surrounding Hubot uptime.
# Master
# Repository
#
# Commands:
#   hubot ping - Reply with pong
#   hubot echo <text> - Reply back with <text>
#   hubot time - Reply with current time
#   hubot die - End hubot process

module.exports = (robot) ->
  github = require('githubot')(robot)
  robot.respond /todo watch (\d+)$/i, (msg) ->
    github.get "repos/nekova/aibis/issues/#{msg.match[1]}", (issue) ->
      msg.send issue.body

  robot.respond /todo list$/i, (msg) ->
    github.get "repos/nekova/aibis/issues?state=open", (issues) ->
      text = ""
      for issue, n in issues by -1
        text += "\##{issue.number} #{issue.title}\n"
      msg.send text

  robot.respond /todo add \"(.+)\" to (\d+)$/i, (msg) ->
    text = msg.match[1]
    number = msg.match[2]
    github.get "repos/nekova/aibis/issues/#{number}", (issue) ->
      body = "#{issue.body} \n\- \[ \]#{text}"
      github.patch "repos/nekova/aibis/issues/#{number}", {body: body}, (_) ->
        msg.send "Added #{text}"
