config = require("../../config").config
helper = require("../../lib/helper")
EP = require 'eventproxy'
Logs = require("../../model/mongo").Logs
Planet = require("../../model/mongo").Planet

exports.before = (req,res,next,before)->
  sess = req.session
  userid = sess.loginAdmin or req.cookies.admin_user
  if userid
    before req,res,next
  else
    res.redirect '/admin/sign/in'

exports.index = (req,res,next)->
	ep = new EP.create "planet", (planet)->
		data = {}
		data.planet_list = planet
		res.render config.templateforadmin+"/planet-index",data

	Planet.getAll (err,planet)->
		ep.emit "planet" ,planet

exports.new = (req,res,next)->
	res.render config.templateforadmin+"/planet-new"

exports.default = (req,res,next)->
	Path = res.locals.Path
	console.log Path
	if Path[3]?
		Planet.findOne {_id:Path[3]},(err,planet)->
			return next() if err?
			res.render config.templateforadmin+"/planet-edit",{planet:planet}
	else
		next()


exports.edit_post = (req,res,next)->
	Path = res.locals.Path
	if Path[4]?
		data = {}
		data.title = if req.body.title? then req.body.title else ""
		data.description = if req.body.description? then req.body.description else ""
		data.url = if req.body.url? then req.body.url else ""
		data.pics = if req.body.pics? then req.body.pics else ""
		data.author = if req.body.author? then req.body.author else ""
		data.galaxy = if req.body.galaxy? then req.body.galaxy else ""

		return res.send helper.recode 201,"标题不能为空,请重新输入." if data.title is ""
		return res.send helper.recode 201,"链接地址不能为空,请重新输入." if data.url is ""

		Planet.findOne {_id:Path[4]},(err,plane)->
			return res.send helper.recode 203,"您要修改的星球好像不存在." if err?
			plane.title = data.title
			plane.url = data.url
			plane.description = data.description
			plane.pics = data.pics
			plane.author = data.author
			plane.galaxy = data.galaxy
			plane.edit_at = new Date()
			plane.save()
			res.send helper.recode()
			Logs.new "Planet",req.session.loginAdmin or req.cookies.admin_user,"修改了星球 #{data.title}."
	else
		res.send helper.recode 203,"您要修改的星球好像不存在."

exports.new_post = (req,res,next)->
	console.log req.body
	data = {}
	data.title = if req.body.title? then req.body.title else ""
	data.description = if req.body.description? then req.body.description else ""
	data.url = if req.body.url? then req.body.url else ""
	data.pics = if req.body.pics? then req.body.pics else ""
	data.author = if req.body.author? then req.body.author else ""
	data.galaxy = if req.body.galaxy? then req.body.galaxy else ""


	return res.send helper.recode 201,"标题不能为空,请重新输入." if data.title is ""
	return res.send helper.recode 201,"链接地址不能为空,请重新输入." if data.url is ""
	return res.send helper.recode 201,"图片不能为空,请重新输入." if data.pics is ""

	ep = new EP.create "url", (url)->
		return res.send helper.recode 203,"链接地址重复,请重新输入." if url?
		Planet.new data.title,data.url,data.description,data.pics,data.author,data.galaxy,req.session.loginAdmin or req.cookies.admin_user,(err,obj)->
			return res.send helper.recode 203,"未知错误" if err?
			re = helper.recode()
			re.id = obj._id
			res.send re
			Logs.new "Planet",req.session.loginAdmin or req.cookies.admin_user,"新建了星球 #{data.title}."

	Planet.findOne {url:data.url},(err,url)->
		ep.emit "url",url

exports.del_post = (req,res,next)  ->
  Path = res.locals.Path
  # console.log "req.body.del",req.body
  if Path[4]? and req.body.del?
    Planet.removebyid Path[4],(err,obj)->
      return res.send helper.recode("203","没有找到此星球") if err?
      re = helper.recode()
      res.send re
      Logs.new "Planet",req.session.loginAdmin or req.cookies.admin_user,"删除了星球 #{Path[4]} ."
  else
    res.send helper.recode("203","没有找到此星球")