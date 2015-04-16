config = require("../../config").config
helper = require("../../lib/helper")
EP = require 'eventproxy'
Logs = require("../../model/mongo").Logs
oss = require "../../lib/oss"
fs = require("fs")

$cdn = "http://disk.giccoo.com/"

exports.before = (req,res,next,before)->
	sess = req.session
	userid = sess.loginAdmin or req.cookies.admin_user
	if userid
		before req,res,next
	else
		res.redirect '/admin/sign/in'

exports.index = (req,res,next)->
	# location = __dirname+"/../../public/uploadDir"
	console.log "uploadDir"
	oss.listObjects {
		Bucket: 'giccoo-disk',
		MaxKeys: '1000',
		# 文件夹列表
		Prefix: 'uploadDir',
		Marker: '',
		Delimiter: ''
	},
	(err, data)->
		console.log err,data
		if err
			next()
			return console.log err
		# console.log "success", data
		files = data.Contents
		res.render config.templateforadmin+"/media-index",{files:files,cdn:$cdn}
	# fs.readdir location , (err,stat)->
		# console.log stat
		# res.render config.templateforadmin+"/media-index",{files:stat.reverse()}

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
		console.log "rename fail:",err
		return res.send helper.recode 203,err if err?
		fs.readFile newname, (err, data)->
			console.log "read fail:",err
			return res.send helper.recode 203,err if err?
			oss.putObject {
				Bucket: 'giccoo-disk',
				Key: 'uploadDir/'+filename,
				Body: data,
				AccessControlAllowOrigin: '',
				ContentType: 'image/*',
				CacheControl: 'no-cache',         # 参考: http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.9
				ContentDisposition: '',           # 参考: http://www.w3.org/Protocols/rfc2616/rfc2616-sec19.html#sec19.5.1
				ContentEncoding: 'utf-8',         # 参考: http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.11
				ServerSideEncryption: 'AES256',
				Expires: new Date().getTime()+5000     # 参考: http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.21
			}, (err, data)->
				console.log "putObject fail:",err
				return res.send helper.recode 203,err if err?
				console.log "success",data,err
				res.send helper.recode()

		
		Logs.new "media",req.session.loginAdmin or req.cookies.admin_user,"上传了文件 #{filename} ."

exports.default = (req,res,next)->
	# default 用于分发,例如文章,分类等信息.
	Path = res.locals.Path
	
	console.log Path