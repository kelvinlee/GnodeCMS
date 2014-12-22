mongoose = require('mongoose')
Schema = mongoose.Schema
ObjectId = Schema.Types.ObjectId

TagSchema = new Schema({
  title:{type:String,index:true}
  url:{type:String,index:true,unique:true}
  description:{type:String}

  create_at: {type:Date, default:new Date()}
})

mongoose.model('Tag', TagSchema)
