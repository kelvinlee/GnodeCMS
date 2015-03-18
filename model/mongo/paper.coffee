models = require './base'
config = require('../../config').config
Paper = models.Paper

exports.findOne = (where,next)->
	Paper.findOne where,next
exports.find = (where,next)->
	Paper.find where,next
exports.getAll = (next)->
	Paper.find {},next
exports.getbyid = (id,next)->
	Paper.findById id,next
exports.getbyauthor = (id,next)->
	Paper.find {author:id},next
exports.getCount = (next)->
	Paper.find({}).count().exec next
exports.removebyid = (id,next)->
  # User.findById id,next
  Paper.findById(id).remove next

exports.getPage = (id = null,page,next)->
	if id?
		if page > 0
			page -= 1
			Paper.find({_id:{$lt:id}}).populate('author').sort({_id:-1}).skip(page*config.list_count).limit(config.list_count).exec next
		else
			page = Math.abs page
			data = Paper.find({_id:{$gte:id}}).populate('author').sort({_id:1}).skip(page*config.list_count).limit(config.list_count).exec (err,objs)->
				next err,objs.reverse()
	else
		Paper.find({}).populate('author').sort({create_at:-1}).limit(config.list_count).exec next


exports.new = (title,author,url,content,next)->
	obj = new Paper()
	obj.title = title
	obj.author = author
	obj.url = url
	obj.content = content
	obj.create_at = new Date()
	obj.save(next)
