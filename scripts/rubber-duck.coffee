phrases = require '../phrases'

module.exports = (robot) ->
  random = (items) ->
      items[ Math.floor Math.random() * items.length ]

  helping = [];
  helpingLang = {};

  # Be courteous and say hello
  robot.respond /(hello|hi|howdy|hola)/i, (msg) ->
    lang = 'en'
    if msg.match[1].trim().toLowerCase() is 'hola'
      lang = 'es'

    msg.reply random phrases.greetings[lang]

  robot.respond /.*(help|ayuda).*/i, (msg) ->
    userId = msg.envelope.user.id
    lang = 'en'
    if msg.match[1].trim().toLowerCase() is 'ayuda'
      lang = 'es'

    unless userId in helping
      setTimeout ->
        helping.push userId
      , 100

      helpingLang[userId] = lang
      msg.reply phrase for phrase in phrases.instructions[lang]

  robot.respond /(thanks|thank you|gracias)/i, (msg) ->
    userId = msg.envelope.user.id
    lang = 'en'
    if msg.match[1].trim().toLowerCase() is 'gracias'
      lang = 'es'

    if userId in helping
      helping = [id for id in helping when id isnt userId]
      delete helpingLang[userId]

    msg.reply random phrases.finish[lang]

  # Respond with a random phrase to messages longer than 10 chars
  robot.respond /.*/i, (msg) ->
    userId = msg.envelope.user.id
    lang = helpingLang[userId]

    if userId in helping
      msg.reply random phrases.listening[lang]
