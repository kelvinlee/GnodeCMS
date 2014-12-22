config = require("../config").config
helper = require("../lib/helper")
# Buffer = require("Buffer")
fs = require "fs"

exports.before = (req,res,next,before)->
	before req,res,next
	
exports.index = (req,res,next)->
	# index 为首页,如果没有二级参数,则默认访问此页.
	res.render config.template+"/test-index"

exports.upload = (req,res,next)->
	# 测试二级参数,如果有二级参数则 default 不会被访问到,所以要注意.
	re = helper.recode()
	body = req.body
	if body? and body.data?
		data = body.data
		img = new Buffer(data, 'base64')
		console.log __dirname+"/.."+config.upload+"/a.png"
		filename = new Date().getTime()+"-"+parseInt(Math.random()*100)
		fs.writeFile __dirname+"/.."+config.upload+"/#{filename}.png",img,(err)->
			throw err if err
			re.filename = filename
			res.send re
	else
		re = helper.recode 201,"没有获取到图片数据"
		res.send re

exports.default = (req,res,next)->
  # default 用于分发,例如文章,分类等信息.
  res.render config.template+"/default"
