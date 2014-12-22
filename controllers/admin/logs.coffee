config = require("../../config").config
helper = require("../../lib/helper")
EP = require 'eventproxy'
fs = require 'fs'
Logs = require("../../model/mongo").Logs
language = require "../../language"

exports.before = (req,res,next,before)->
	if res.locals.loginAdmin
		before req,res,next
	else
		res.redirect '/admin/sign/in'


exports.index = (req,res,next)->
	# index 为首页,如果没有二级参数,则默认访问此页.
	# Logs.new "test",null,"test for logs."
	# console.log "index"
	ep = new EP.create "count","logs", (count,logs)->
		data = {}
		data.logs_list = logs
		data.logs_count = count
		data.prepage = 1
		data.page = 1
		if count > 1
			data.id = logs[logs.length-1]._id
		res.render config.templateforadmin+"/logs-index",

	Logs.getCount (err,count)->
		ep.emit "count" ,count
	Logs.getPage null,1,(err,logs)->
		ep.emit "logs" ,logs


exports.page = (req,res,next)->
	# console.log "page"
	prepage = req.query.prepage
	page = req.query.page
	id = req.query.id

	_page = page - prepage

	ep = new EP.create "count","logs", (count,logs)->
		if (_page > 5 or _page < -5) and logs.length >= config.list_count
			prepage = page 
			id = logs[logs.length-1]._id
		res.render config.templateforadmin+"/logs-index",{logs_list:logs,logs_count:count,prepage:prepage,page:page,id:id}

	Logs.getCount (err,count)->
		# console.log err,count
		ep.emit "count" ,count
	Logs.getPage id,_page,(err,logs)->
		# console.log err,logs
		ep.emit "logs" ,logs

exports.default = (req,res,next)->