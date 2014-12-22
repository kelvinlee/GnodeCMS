models = require './base'
config = require('../../config').config
Comment = models.Comment

exports.count = (next)->
  Comment.find({}).count().exec next
exports.getAll = (next)->
  Comment.find {},next
exports.getbyid = (id,next)->
  Comment.findById id,next
exports.getByPage = (page,next,where = {})->
  Comment
  .find where
  .sort {create_at:-1}
  .limit config.list_count
  .skip page*config.list_count
  .exec next

exports.new = (title,url,description)->
  obj = new Comment()

  obj.save()
