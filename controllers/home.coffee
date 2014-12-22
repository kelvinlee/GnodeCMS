config = require('../config').config

exports.index = (req,res,next)->
  # index 为首页,如果没有二级参数,则默认访问此页.

  res.render config.template+"/homepage"
