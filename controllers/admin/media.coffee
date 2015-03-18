config = require("../../config").config
helper = require("../../lib/helper")
EP = require 'eventproxy'
Logs = require("../../model/mongo").Logs
fs = require("fs")

exports.before = (req,res,next,before)->
  sess = req.session
  userid = sess.loginAdmin or req.cookies.admin_user
  if userid
    before req,res,next
  else
    res.redirect '/admin/sign/in'

exports.index = (req,res,next)->
	location = __dirname+"/../../public/uploadDir"
	fs.readdir location , (err,stat)->
		# console.log stat
		res.render config.templateforadmin+"/media-index",{files:stat.reverse()}

exports.del = (req,res,next)->
	# console.log "remove filename:",req.body.file
	location = __dirname+"/../../public/uploadDir"
	filename = location+"/"+req.body.file
	fs.unlink filename, (err)->
		return res.send helper.recode(203,"未知错误") if err?
		res.send helper.recode()
		Logs.new "media",req.session.loginAdmin or req.cookies.admin_user,"删除了文件 #{req.body.file} ."


exports.new = (req,res,next)->
	res.render config.templateforadmin+"/media-upload"

exports.upload = (req,res,next)->
	console.log req.files.file
	location = __dirname+"/../../public/uploadDir"
	file = req.files.file
	oldname = location+"/"+file.name
	filename = new Date().getTime()+"-"+parseInt(Math.random()*100)+"."+file.extension
	newname = location+"/"+filename
	fs.rename oldname, newname, (err)->
		console.log err
		return res.send helper.recode 203,err if err?
		res.send helper.recode()
		Logs.new "media",req.session.loginAdmin or req.cookies.admin_user,"上传了文件 #{filename} ."

exports.default = (req,res,next)->
  # default 用于分发,例如文章,分类等信息.
  Path = res.locals.Path
  
  console.log Path