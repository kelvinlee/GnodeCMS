mongoose = require('mongoose')
Schema = mongoose.Schema
ObjectId = Schema.Types.ObjectId

TypeSchema = new Schema({
  title:{type:String,index:true}
  url:{type:String,index:true,unique:true}
  description:{type:String, default:null}

  create_at: {type:Date, default:new Date()}
})

mongoose.model('Type', TypeSchema)
