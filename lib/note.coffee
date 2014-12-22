# 不要删除此文件,尽量不要修改此文件(除非你对它非常熟悉).

exports.notfound = (req,res,next)->
  # 记录经常被访问的未知页面.
  console.log "Not found:",req.url
  # 跳转到404界面.
  res.send "404 Not found."
