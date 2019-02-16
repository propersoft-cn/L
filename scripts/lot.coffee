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

module.exports = (robot) ->
  robot.respond /lot/i, (msg) ->
    candidates = ['张剑林', '王浩鹏', '王怡', '寇鑫', '张磊', '方明', '王维', '张永彬', '邓广义', '李亚楠', '邢静', '付伟', '祝晓宇', '冯艳玲']
    msg.send msg.random candidates
