models = require './base'
config = require('../../config').config
Logs = models.Logs

exports.getAll = (next)->
	Logs.find {},next
exports.getbyid = (id,next)->
	Logs.findById id,next
exports.getbyauthor = (id,next)->
	Logs.find {author:id},next
exports.getbytype = (type,next)->
	Logs.find {type:type},next

exports.getCount = (next)->
	Logs.find({}).count().exec next

exports.getPage = (id = null,page,next)->
	if id?
		if page > 0
			page -= 1
			Logs.find({_id:{$lt:id}}).populate('author').sort({_id:-1}).skip(page*config.list_count).limit(config.list_count).exec next
		else
			page = Math.abs page
			data = Logs.find({_id:{$gte:id}}).populate('author').sort({_id:1}).skip(page*config.list_count).limit(config.list_count).exec (err,objs)->
				next err,objs.reverse()
	else
		Logs.find({}).populate('author').sort({create_at:-1}).limit(config.list_count).exec next


exports.new = (type,author,description)->
	console.log "log author:",author
	obj = new Logs()
	obj.type = type
	obj.author = author
	obj.description = description
	obj.create_at = new Date()
	obj.save()
