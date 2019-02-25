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
    msg.send candidates.toString().replace(/,$/gi,"")


  robot.hear /lot \+ (.*)/i, (res) ->
    str = res.match[1]
    if str.length > 4
       arr = []
       arr = str.split(/[,，]/)
       candidates = arr + "," + candidates
    else str.length <
       candidates.push(str.replace(/,$/gi,""))
    candidates = candidates.toString().split(/[,，]/)
    res.send res.random(candidates)


  robot.hear /lot \-(.*)/i, (res) ->
    st123 = res.match[1]
    for str in candidates
      if str is st123
        candidates = candidates.splice(str, 1)
    res.send res.random(candidates)