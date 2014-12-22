models = require './base'
config = require('../../config').config
Tag = models.Tag

exports.getAll = (next)->
  Tag.find {},next
exports.getbyid = (id,next)->
  Tag.findById id,next

exports.new = (title,url,description)->
  obj = new Tag()

  obj.save()
