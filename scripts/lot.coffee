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
    if candidates.length is 0
      msg.send "You need to add data to the collection!"
    else msg.send msg.random candidates

  robot.respond /lot ls$/i, (msg) ->
    if candidates.length is 0
      msg.send "Empty collection!"
    else msg.send candidates


  robot.hear /lot \+ (.*)/i, (res) ->
    elements = res.match[1].replace(/\s/g, "")
    if elements.length > 4
       arr = []
       arr = elements.split(/[,，]/)
       if candidates.length > 0
         candidates = candidates + ',' + arr
       else  candidates.length <
         candidates = arr
    else elements.length <
       candidates.push(elements.replace(/,$/gi,""))
    candidates = candidates.toString().split(/[,，]/)
    res.send candidates


  robot.hear /lot \- (.*)/i, (res) ->
    removeElements = res.match[1].replace(/\s/g, "").split(/[,，]/)
    for str in removeElements
      if candidates.indexOf(str) isnt -1
        candidates.splice(candidates.indexOf(str), 1)
      else res.send str + "is not exist!"
    res.send candidates