models = require './base'
config = require('../../config').config
User = models.User

exports.find = (where = {},next)->
  User.find where,next
exports.findOne = (where = {},next)->
  User.findOne where,next
exports.getCount = (next)->
	User.find({}).count().exec next
exports.getAll = (next)->
  User.find {},next
exports.getbyid = (id,next)->
  User.findById id,next
exports.login = (username,password,next)->
	User.findOne {$or:[{username:username},{email:username},{mobile:username}],password:password},next
exports.removebyid = (id,next)->
  # User.findById id,next
  User.findById(id).remove next
exports.getPage = (id = null,page,next)->
  if id?
    if page > 0
      page -= 1
      User.find({_id:{$lt:id}}).sort({_id:-1}).skip(page*config.list_count).limit(config.list_count).exec next
    else
      page = Math.abs page
      data = User.find({_id:{$gte:id}}).sort({_id:1}).skip(page*config.list_count).limit(config.list_count).exec (err,objs)->
        next err,objs.reverse()
  else
    User.find({}).sort({create_at:-1}).limit(config.list_count).exec next

exports.new = (username,password,active = false,next)->
  obj = new User()
  obj.username = username
  obj.password = password
  obj.create_at = new Date()
  obj.active = active
  obj.save(next)
