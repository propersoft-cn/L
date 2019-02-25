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
    candidates = candidates.split(/[,，]/)
    res.send res.random(candidates)


  robot.hear /lot \- (.*)/i, (res) ->
    st123 = res.match[1].replace(/\s/g, "").split(/[,，]/)
    for str in st123
      candidates.splice(candidates.indexOf(str), 1)
    res.send res.random(candidates)