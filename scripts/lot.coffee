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

module.exports = (robot) ->
  if (robot.brain.get 'candidates') is null
     candidates = []
  else robot.brain.get 'candidates'

  robot.respond /lot$/i, (msg) ->
    if candidates.length is 0
      msg.send "You need to add data to the collection!"
    else msg.send msg.random candidates

  robot.respond /lot ls$/i, (msg) ->
    if (robot.brain.get 'candidates') isnt null
      msg.send candidates = robot.brain.get 'candidates'
    else msg.send "Empty collection!"

  robot.hear /lot \+ (.*)/i, (res) ->
    elements = res.match[1].replace(/\s/g, "").split(/[,，]/)
    for str in elements
      if str.length > 0
        if candidates.includes(str)
          candidates.splice(candidates.indexOf(str), 1)
        candidates.push(str)
    res.send candidates
    robot.brain.set('candidates', candidates)
    robot.brain.save()


  robot.hear /lot \- (.*)/i, (res) ->
    removeElements = res.match[1].replace(/\s/g, "").split(/[,，]/)
    for str in removeElements
      if candidates.indexOf(str) isnt -1
        candidates.splice(candidates.indexOf(str), 1)
      else res.send str + " is not exist!"
    res.send candidates
    robot.brain.set('candidates', candidates)
    robot.brain.save()