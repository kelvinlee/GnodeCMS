mongoose = require('mongoose')
config = require('../../../config').config
Schema = mongoose.Schema
ObjectId = Schema.ObjectId

mongoose.connect config.mdb, (err)->
  if err
    console.error('Connect to %s error: %s', config.mdb, err.message)
    process.exit(1)

require './user'
require './article'
require './comment'
require './menu'
require './tag'
require './type'
require './logs'
require './paper'
require './urls'
require './planet'

exports.User = mongoose.model 'User'
exports.Article = mongoose.model 'Article'
exports.Comment = mongoose.model 'Comment'
exports.Menu = mongoose.model 'Menu'
exports.Tag = mongoose.model 'Tag'
exports.Type = mongoose.model 'Type'
exports.Logs = mongoose.model 'Logs'
exports.Paper = mongoose.model 'Paper'
exports.Urls = mongoose.model 'Urls'
exports.Planet = mongoose.model 'Planet'
