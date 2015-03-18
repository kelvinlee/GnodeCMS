config = require("../../config").config
helper = require("../../lib/helper")
EP = require 'eventproxy'
Logs = require("../../model/mongo").Logs
Paper = require("../../model/mongo").Paper

exports.before = (req,res,next,before)->
  sess = req.session
  userid = sess.loginAdmin or req.cookies.admin_user
  if userid
    before req,res,next
  else
    res.redirect '/admin/sign/in'

exports.index = (req,res,next)->
	ep = new EP.create "count","paper", (count,paper)->
		data = {}
		data.paper_list = paper
		data.page_count = count
		data.prepage = 1
		data.page = 1
		if count >= 1
			data.id = paper[paper.length-1]._id
		res.render config.templateforadmin+"/paper-index",data

	Paper.getCount (err,count)->
		ep.emit "count" ,count
	Paper.getPage null,1,(err,paper)->
		ep.emit "paper" ,paper

page = (req,res,next)->
	# console.log "page"
	data = {}
	data.prepage = req.query.prepage
	data.page = req.query.page
	data.id = req.query.id
	_page = page - prepage

	ep = new EP.create "count","paper", (count,paper)->
		if (_page > 5 or _page < -5) and paper.length >= config.list_count
			data.prepage = page 
			data.id = paper[paper.length-1]._id
		res.render config.templateforadmin+"/paper-index", data

	Paper.getCount (err,count)->
		# console.log err,count
		ep.emit "count" ,count
	Paper.getPage id,_page,(err,paper)->
		# console.log err,paper
		ep.emit "paper" ,paper

exports.page = page

exports.new = (req,res,next)->
	res.render config.templateforadmin+"/paper-new"

exports.edit_post = (req,res,next)->
	Path = res.locals.Path
	if Path[4]?
		data = {}
		data.title = if req.body.title? then req.body.title else ""
		data.url = if req.body.url? then req.body.url else ""
		data.content = if req.body.content? then req.body.content else ""

		return res.send helper.recode 201,"标题不能为空,请重新输入." if data.title is ""
		return res.send helper.recode 201,"链接地址不能为空,请重新输入." if data.url is ""

		Paper.findOne {_id:Path[4]},(err,paper)->
			return res.send helper.recode 203,"您要修改的页面好像不存在." if err?
			paper.title = data.title
			paper.url = data.url
			paper.content = data.content
			paper.edit_at = new Date()
			paper.save()
			res.send helper.recode()
			Logs.new "Paper",req.session.loginAdmin or req.cookies.admin_user,"修改了页面 #{data.title}."
	else
		res.send helper.recode 203,"您要修改的页面好像不存在."

exports.new_post = (req,res,next)->
	# console.log req.body
	data = {}
	data.title = if req.body.title? then req.body.title else ""
	data.url = if req.body.url? then req.body.url else ""
	data.content = if req.body.content? then req.body.content else ""

	return res.send helper.recode 201,"标题不能为空,请重新输入." if data.title is ""
	return res.send helper.recode 201,"链接地址不能为空,请重新输入." if data.url is ""

	ep = new EP.create "url", (url)->
		return res.send helper.recode 203,"链接地址重复,请重新输入." if url?
		Paper.new data.title,req.session.loginAdmin or req.cookies.admin_user,data.url,data.content,(err,obj)->
			return res.send helper.recode 203,"未知错误" if err?
			re = helper.recode()
			re.id = obj._id
			res.send re
			Logs.new "Paper",req.session.loginAdmin or req.cookies.admin_user,"新建了页面 #{data.title}."

	Paper.findOne {url:data.url},(err,url)->
		ep.emit "url",url

exports.del_post = (req,res,next)  ->
  Path = res.locals.Path
  # console.log "req.body.del",req.body
  if Path[4]? and req.body.del?
    Paper.removebyid Path[4],(err,obj)->
      return res.send helper.recode("203","没有找到此用户") if err?
      re = helper.recode()
      res.send re
      Logs.new "Paper",req.session.loginAdmin or req.cookies.admin_user,"删除了用户 #{Path[4]} ."
  else
    res.send helper.recode("203","没有找到此用户")

exports.default = (req,res,next)->
	Path = res.locals.Path
	console.log Path
	if Path[3]?
		Paper.findOne {_id:Path[3]},(err,paper)->
			return next() if err?
			res.render config.templateforadmin+"/paper-edit",{paper:paper}
	else
		next()
