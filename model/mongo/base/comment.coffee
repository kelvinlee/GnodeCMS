mongoose = require('mongoose')
Schema = mongoose.Schema
ObjectId = Schema.Types.ObjectId

CommentSchema = new Schema({
  article:{type:ObjectId,index:true}
  author:{type:ObjectId,index:true}
  reply:{type:ObjectId,index:true}
  comment:{type:String}

  create_at: {type:Date, default:new Date()}
})

mongoose.model('Comment', CommentSchema)
