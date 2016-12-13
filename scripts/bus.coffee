module.exports = (robot) ->

  busIntervalId = null
  lastMsg = ''

  robot.respond /104 wj/, (res) ->
    str = '查询 104 路卫工街建设大路到站信息...'
    sid = 'ce6b38f682e8833c2a9074bb9df7716b'
    query res, 104, sid, str

  query = (res, busNo, sid, str) ->
    if busIntervalId
      res.send '正在' + str
      queryPass res, busNo, sid
      return

    res.send "Hey, 开始帮您" + str
    busIntervalId = setInterval () ->
      queryPass res, busNo, sid
    , 15000

  queryPass = (msg, busNo, sid) ->
    curMsg = ''
    msg.http('http://221.180.145.86/bus/station/pass?sid=' + sid)
      .get() (err, res, body) ->
        response = JSON.parse(body)
        rows = response.rows
        for row in rows
          if row.name.startsWith(busNo+'')
            if row.bus
              curMsg += '#' + row.bus.busId + ' ' + row.name + ' 还有 ' + row.bus.distance + ' 米到站，大约 ' + row.bus.cost + ' 分钟\r\n'
            else if row.busDetail
              curMsg += row.name + ' ' + row.busDetail.numStr + '\r\n'
        if curMsg != lastMsg
          msg.send curMsg
          lastMsg = curMsg

  robot.respond /117 sj/, (res) ->
    str = '查询 117 路盛京医院南湖院区到站信息...'
    sid = '6af058e4359cea9922cfb36fbaff4223'
    query res, 117, sid, str

  robot.respond /252 sb/, (res) ->
    str = '查询 252 路诗波特小区到站信息...'
    sid = '5bb9cc9123f0f245149d06f104c31daa'
    query res, 252, sid, str

  robot.respond /257 sb/, (res) ->
    str = '查询 257 路诗波特小区到站信息...'
    sid = '5bb9cc9123f0f245149d06f104c31daa'
    query res, 257, sid, str

  robot.respond /239 jb/, (res) ->
    str = '查询 239 路建设大路保工街到站信息...'
    sid = 'd9ff11b89ae802bb0c14040ba6fe83b0'
    query res, 239, sid, str

  robot.respond /135 jb/, (res) ->
    str = '查询 135 路建设大路保工街到站信息...'
    sid = 'd9ff11b89ae802bb0c14040ba6fe83b0'
    query res, 135, sid, str

  robot.respond /home/, (res) ->
    if busIntervalId
      res.send "Good bye!"
      clearInterval(busIntervalId)
      busIntervalId = null
