config = require("../../config").config

exports.before = (req,res,next,before)->
	sess = req.session
	userid = sess.loginAdmin or req.cookies.admin_user
	if userid
		before req,res,next
	else
		res.redirect '/admin/sign/in'
	
exports.index = (req,res,next)->
	# index 为首页,如果没有二级参数,则默认访问此页.

	res.render config.templateforadmin+"/homepage"
