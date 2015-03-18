mongoose = require('mongoose')
Schema = mongoose.Schema
ObjectId = Schema.Types.ObjectId

PaperSchema = new Schema({
  author:{type:ObjectId,ref:"User"}
  title:{type:String,index:true}
  url:{type:String,index:true,unique:true}
  content:{type:String}

  view:{type:Number,default: 0}

  create_at: {type:Date, default:new Date()}
  edit_at: {type:Date}
})

mongoose.model('Paper', PaperSchema)
