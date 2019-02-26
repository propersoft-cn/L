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

candidates = []

module.exports = (robot) ->
  robot.respond /lot$/i, (msg) ->
    msg.send msg.random candidates

  robot.respond /lot ls$/i, (msg) ->
    msg.send candidates


  robot.hear /lot \+ (.*)/i, (res) ->
    elements = res.match[1].replace(/\s/g, "")
    if elements.length > 4
       arr = []
       arr = elements.split(/[,，]/)
       candidates = arr + candidates
    else elements.length <
       candidates.push(elements.replace(/,$/gi,""))
    candidates = candidates.toString().split(/[,，]/)
    res.send res.random(candidates)


  robot.hear /lot \- (.*)/i, (res) ->
    removeElements = res.match[1].replace(/\s/g, "").split(/[,，]/)
    for str in removeElements
      candidates.splice(candidates.indexOf(str), 1)
    res.send res.random(candidates)