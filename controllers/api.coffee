config = require('../config').config
helper = require("../lib/helper")

exports.index = (req,res,next)->
  # index 为首页,如果没有二级参数,则默认访问此页.

  res.render config.template+"/homepage"
exports.default = (req,res,next)->

exports.homepage = (req,res,next)->
	re = helper.recode()
	res.send re