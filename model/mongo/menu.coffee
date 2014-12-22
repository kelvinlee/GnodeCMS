models = require './base'
config = require('../../config').config
Menu = models.Menu

exports.getAll = (next)->
  Menu.find {},next
exports.getbyid = (id,next)->
  Menu.findById id,next

exports.new = (title,url,description)->
  obj = new Menu()

  obj.save()
