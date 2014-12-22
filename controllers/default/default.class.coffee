config = require("./config").config
exports.before = (req,res,next,before)->
	before req,res,next
	
exports.index = (req,res,next)->
  # index 为首页,如果没有二级参数,则默认访问此页.
  res.render config.template+"/test index"

exports.test = (req,res,next)->
  # 测试二级参数,如果有二级参数则 default 不会被访问到,所以要注意.
  res.render config.template+"/test"

exports.default = (req,res,next)->
  # default 用于分发,例如文章,分类等信息.
  res.render config.template+"/default"
