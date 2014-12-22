models = require './base'
config = require('../../config').config
Article = models.Article

exports.getUrl = (url,next)->
  Article.findOne {url:url},next
exports.count = (next)->
  Article.find({}).count().exec next
exports.getAll = (next)->
  Article.find {},next
exports.getbyid = (id,next)->
  Article.findById id,next
exports.getByPage = (page,next,where = {})->
  Article
  .find where
  .sort {create_at:-1}
  .limit config.list_count
  .skip page*config.list_count
  .exec next

exports.new = (title,url,description)->
  obj = new Article()

  obj.save()
