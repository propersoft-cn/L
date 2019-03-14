# Description:
#   Base64 encoding and decoding
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot lot - lot from candidates
#   hubot lot + - add to candidates
#   hubot lot - - remove elements from candidates
#   hubot lot ls - show candidates elements
#   hubot lot delAll - delete brains candidates elements

module.exports = (robot) ->
  if (robot.brain.get 'candidates') is null
     candidates = []
  else robot.brain.get 'candidates'

  robot.respond /lot$/i, (msg) ->
    candidates = robot.brain.get 'candidates'
    if candidates.length is 0
      msg.send "You need to add data to the collection!"
    else msg.send msg.random candidates

  robot.respond /lot ls$/i, (msg) ->
    candidate = robot.brain.get 'candidates'
    if candidate isnt null && candidate.length isnt 0
      candidates = candidate
      msg.reply candidates
    else msg.reply "Empty collection!"

  robot.hear /lot \+ (.*)/i, (res) ->
    if (robot.brain.get 'candidates') is null
      candidates = []
    else candidates = robot.brain.get 'candidates'
    elements = res.match[1].replace(/\s/g, "").split(/[,，]/)
    for str in elements
      if str.length > 0
        if candidates.includes(str)
          candidates.splice(candidates.indexOf(str), 1)
        candidates.push(str)
    robot.brain.set('candidates', candidates)
    robot.brain.save()
    res.reply candidates


  robot.hear /lot \- (.*)/i, (res) ->
    removeElements = res.match[1].replace(/\s/g, "").split(/[,，]/)
    for str in removeElements
      if candidates.indexOf(str) isnt -1
        candidates.splice(candidates.indexOf(str), 1)
      else res.send str + " is not exist!"
    if candidates.length is 0
      res.send "Empty collection!"
    else res.reply candidates
    robot.brain.set('candidates', candidates)
    robot.brain.save()

  robot.respond /lot delAll/i, (msg) ->
    candidates = robot.brain.get 'candidates'
    for str in candidates
      candidates.splice(str)
    robot.brain.save()
    msg.reply "It's blank candidates of brains！"