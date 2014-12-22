mongoose = require('mongoose')
Schema = mongoose.Schema
ObjectId = Schema.Types.ObjectId

ArticleSchema = new Schema({
  author:{type:ObjectId,ref:"User"}
  title:{type:String,index:true}
  url:{type:String,index:true,unique:true}
  description:{type:String}
  content:{type:String}

  type:{type:ObjectId,ref:"Type"}
  tag:[{type:ObjectId,ref:"Tag"}]
  view:{type:Number}
  share:{type:Number}

  create_at: {type:Date, default:new Date()}
  edit_at: {type:Date}
})

mongoose.model('Article', ArticleSchema)
