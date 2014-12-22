mongoose = require('mongoose')
Schema = mongoose.Schema
ObjectId = Schema.Types.ObjectId

LogsSchema = new Schema({
  type:{type:String,index:true}
  author:{type:ObjectId,index:true,sparse:true,default:null}
  description:{type:String}
  create_at: {type:Date ,default:new Date() ,index:true}
})

mongoose.model('Logs', LogsSchema)
