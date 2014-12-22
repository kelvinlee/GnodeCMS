models = require './base'
config = require('../../config').config
User = models.User

exports.getCount = (next)->
	User.find({}).count().exec next
exports.getAll = (next)->
  User.find {},next
exports.getbyid = (id,next)->
  User.findById id,next
exports.login = (username,password,next)->
	User.findOne {$or:[{username:username},{email:username},{mobile:username}],password:password},next

exports.new = (username,password,active = false,next)->
  obj = new User()
  obj.username = username
  obj.password = password
  obj.create_at = new Date()
  obj.active = active
  obj.save(next)
