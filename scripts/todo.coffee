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

  robot.respond /issue list$/i, (msg) ->
    github.get "repos/nekova/aibis/issues?state=open", (issues) ->
      text = ""
      for issue, n in issues by -1
        text += "\##{issue.number} #{issue.title}\n"
      msg.send text

  robot.respond /todo add \"(.+)\" to (\d+)$/i, (msg) ->
    text = msg.match[1]
    number = msg.match[2]
    github.get "repos/nekova/aibis/issues/#{number}", (issue) ->
      body = "#{issue.body} \n\- \[ \] #{text}"
      github.patch "repos/nekova/aibis/issues/#{number}", {body: body}, (_) ->
        msg.send "Added #{text}"

  robot.respond /todo list$/i, (msg) ->
    github.get "repos/nekova/aibis/issues?state=open", (issues) ->
      body = issues[0].body
      todos = body.match(/\- \[ \] .+/g)
      text = ""
      if todos?
        for t,i in todos
          text += "#{i+1}) " + t + "\n"
        msg.send text
      else
        msg.send "None"

  robot.respond /todo done (\d+)$/i, (msg) ->
    id = msg.match[1] - 1
    github.get "repos/nekova/aibis/issues?state=open", (issues) ->
      body = issues[0].body
      number = issues[0].number
      todos = body.split "\n"
      count = 0
      text = ""
      for t in todos
        if (/\- \[ \] /g).test t
          if count is id
            t = t.replace(/\- \[ \] /, "- [x] ")
          count += 1
        text += t + "\n"
      github.patch "repos/nekova/aibis/issues/#{number}", {body: text}, () ->
        msg.send "Done #{id+1}"
