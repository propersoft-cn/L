# Description:
#   Turn a URL into a QR Code
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot: qr me <url> - turn a URL into a QR Code
#
# Notes:
#   Makes use of http://www.liantu.com/pingtai/ API

module.exports = (robot) ->
  robot.hear /qr me (.+)/i, (msg) ->
    url = msg.match[1]
    msg.send "http://qr.liantu.com/api.php?text=" + encodeURIComponent(url)
