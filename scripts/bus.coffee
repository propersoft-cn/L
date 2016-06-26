module.exports = (robot) ->

  busIntervalId = null

  robot.respond /104/, (res) ->
    if busIntervalId
      res.send '正在查询 104 公交到站信息...'
      query104 res
      return

    res.send "Hey, 开始帮您查询 104 公交到站信息"
    busIntervalId = setInterval () ->
      query104 res
    , 15000

  lastMsg = ''

  query104 = (msg) ->
    curMsg = ''
    msg.http('http://221.180.145.86/bus/station/pass?sid=ce6b38f682e8833c2a9074bb9df7716b')
      .get() (err, res, body) ->
        response = JSON.parse(body)
        rows = response.rows
        for row in rows
          if '3055e509475fb9d97bb55c55' == row.rid || '4eb64358753c55b64d776efc' == row.rid
            if row.bus
              curMsg += '#' + row.bus.busId + ' ' + row.name + ' 还有 ' + row.bus.distance + ' 米到站，大约 ' + row.bus.cost + ' 分钟\r\n'
            else if row.busDetail
              curMsg += row.name + ' ' + row.busDetail.numStr + '\r\n'
        if curMsg != lastMsg
          msg.send curMsg
          lastMsg = curMsg

  robot.respond /home/, (res) ->
    if busIntervalId
      res.send "Good bye!"
      clearInterval(busIntervalId)
      busIntervalId = null
