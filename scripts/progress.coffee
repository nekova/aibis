# Description:
#
# Commands:
#
# Events:

module.exports = (robot) ->
  cronJob = require('cron').CronJob
  new cronJob("0 0 15 * * 0-6", progress(robot), null, true)

progress = (robot) ->
  -> robot.messageRoom '#test', '進捗どうですか？'
