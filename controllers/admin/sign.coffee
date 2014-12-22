config = require("../../config").config
helper = require("../../lib/helper")
EP = require 'eventproxy'

User = require("../../model/mongo").User

exports.index = (req,res,next)->
  # index 为首页,如果没有二级参数,则默认访问此页.
  sign_in req,res,next

sign_in = (req,res,next)->
  # 测试二级参数,如果有二级参数则 default 不会被访问到,所以要注意.
  if res.locals.loginAdmin
  	console.log "already login."
  res.render config.templateforadmin+"/sign-in"
exports.in = sign_in

post_in = (req,res,next)->
	re = new helper.recode()
	body = req.body
	re = helper.recode 201,"密码不能为空" if not (body.password? and body.password isnt "")
	re = helper.recode 201,"用户名不能为空" if not (body.username? and body.username isnt "")
	

	return res.send re if re.recode isnt 200
	sess = req.session

	User.login body.user,body.password,(err,user)->
		if user? and user.admin
			user.login_at = new Date()
			user.save()
			sess.loginAdmin = user._id
			if body.chkRemember? and body.chkRemember is "on"
				res.cookie "admin_user",user._id
			res.send re
		else
			re = helper.recode 203,"用户名或密码错误."
			res.send re

	
exports.post_in = post_in	

exports.default = (req,res,next)->
  # default 用于分发,例如文章,分类等信息.
  res.render config.templateforadmin+"/default"
