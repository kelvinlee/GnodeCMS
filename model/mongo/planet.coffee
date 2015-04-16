models = require './base'
config = require('../../config').config
Planet = models.Planet

exports.findOne = (where,next)->
	Planet.findOne where,next
exports.find = (where,next)->
	Planet.find where,next
exports.getAll = (next)->
	Planet.find {},next
exports.getbyid = (id,next)->
	Planet.findById id,next
exports.getbyauthor = (id,next)->
	Planet.find {author:id},next
exports.getCount = (next)->
	Planet.find({}).count().exec next
exports.removebyid = (id,next)->
  # User.findById id,next
  Planet.findById(id).remove next

# exports.getPage = (id = null,page,next)->
# 	if id?
# 		if page > 0
# 			page -= 1
# 			Planet.find({_id:{$lt:id}}).populate('author').sort({_id:-1}).skip(page*config.list_count).limit(config.list_count).exec next
# 		else
# 			page = Math.abs page
# 			data = Planet.find({_id:{$gte:id}}).populate('author').sort({_id:1}).skip(page*config.list_count).limit(config.list_count).exec (err,objs)->
# 				next err,objs.reverse()
# 	else
# 		Planet.find({}).populate('author').sort({create_at:-1}).limit(config.list_count).exec next


exports.new = (title,url,description,pics,author,galaxy,Discoverer,next)->
	console.log "before insert:",title,url,description,pics,author,galaxy,Discoverer
	obj = new Planet()
	obj.title = title
	obj.description = description
	obj.url = url
	obj.pics = pics
	obj.author = author
	obj.galaxy = galaxy
	obj.Discoverer = Discoverer

	obj.date = new Date()
	obj.save(next)
