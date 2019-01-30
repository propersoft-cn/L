module.exports = (robot) ->

  drawLot = ['何鑫', '张剑林', '王浩鹏', '王怡', '寇鑫', '张磊', '方明', '王维', '张永斌', '邓广义', '李亚楠', '刑静', '付伟', '祝小雨', '冯艳玲']

  robot.hear /lot/, (res) ->
    res.send res.random(drawLot)