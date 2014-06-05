module.exports = (robot) ->
  random = (items) ->
      items[ Math.floor Math.random() * items.length ]

  helping = [];

  phrases = [
    'Can you tell me more?',
    'Hmmm...',
    'Continue please',
    'ok',
    'Keep going while I think about it'
  ]

  # Be courteous and say hello
  robot.respond /(hello|hi|howdy)/i, (msg) ->
    msg.reply random ['hello', 'hi', 'howdy']

  robot.respond /.*help.*/i, (msg) ->
    userId = msg.envelope.user.id
    unless userId in helping
      setTimeout ->
        helping.push userId
      , 100
      msg.reply 'I am just a rubber duck, but I am glad to help you'
      msg.reply 'Tell me a little bit about your problem'
      msg.reply 'When you are done, just say "thanks"'

  robot.respond /(thanks|thank you)/i, (msg) ->
    userId = msg.envelope.user.id

    if userId in helping
      helping = [id for id in helping when id isnt userId]

    msg.reply 'anytime!'

  # Respond with a random phrase to messages longer than 10 chars
  robot.respond /.*/i, (msg) ->
    userId = msg.envelope.user.id
    if userId in helping
      msg.reply random phrases
