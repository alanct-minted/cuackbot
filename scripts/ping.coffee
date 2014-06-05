# Description:
#   Utility commands surrounding Hubot uptime.
#
# Commands:
#   hubot ping - Reply with pong
#   hubot echo <text> - Reply back with <text>
#   hubot time - Reply with current time
#   hubot die - End hubot process

module.exports = (robot) ->
  robot.respond /PING$/i, (msg) ->
    msg.send "CUACK"

  robot.respond /DIE$/i, (msg) ->
    unless robot.auth.isAdmin msg.envelope.user
      msg.reply 'I am just a rubber duck, you cannot kill me'
    else
      msg.send 'Cuack!'
      setTimeout ->
        process.exit 0
      , 100
