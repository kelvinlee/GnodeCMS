models = require './base'
config = require('../../config').config
Urls = models.Urls

exports.getAll = (next)->
	Urls.find({}).sort({create_at:-1}).exec next
exports.findOne = (where,next)->
	Urls.findOne where,next
exports.getbyid = (id,next)->
	Urls.findById id,next
exports.getbyauthor = (id,next)->
	Urls.find {author:id},next
exports.getbytype = (type,next)->
	Urls.find {type:type},next

exports.getCount = (next)->
	Urls.find({}).count().exec next

exports.new = (url,description,next)->
	obj = new Urls()
	obj.url = url
	obj.description = description
	obj.create_at = new Date()
	obj.save(next)
