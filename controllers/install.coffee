config = require('../config').config
User = require("../model/mongo").User


exports.index = (req,res,next)->
  # index 为首页,如果没有二级参数,则默认访问此页.
  User.getCount (err,count)->
  	if count<=0
  		install()
  		res.send "安装成功."
  	else
  		res.send "已经安装."
  # res.render config.template+"/homepage"

install = ->
	User.new "admin","admin",true,(err,user)->
		user.admin = true
		user.save()
