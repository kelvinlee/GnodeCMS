models = require './base'
config = require('../../config').config
Type = models.Type

exports.getAll = (next)->
	Type.find {},next
exports.getbyid = (id,next)->
	Type.findById id,next
exports.getByPage = (page,next)->
	Type
	.find {}
	.sort {create_at:-1}
	.limit config.list_count
	.skip page*config.list_count
	.exec next

exports.new = (title,url,description)->
	obj = new Type()
	obj.title = title
	obj.url = url
	obj.description = description

	obj.save()
