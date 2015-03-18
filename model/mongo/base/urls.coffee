mongoose = require('mongoose')
Schema = mongoose.Schema
ObjectId = Schema.Types.ObjectId

UrlsSchema = new Schema({
  url:{type:String,index:true,unique:true}
  description:{type:String}
  create_at: {type:Date ,default:new Date() ,index:true}
})

mongoose.model('Urls', UrlsSchema)
