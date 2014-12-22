mongoose = require('mongoose')
Schema = mongoose.Schema
ObjectId = Schema.Types.ObjectId

MenuSchema = new Schema({
  title:{type:String,index:true}
  url:{type:String,index:true,unique:true}
  order:{type:Number}
  description:{type:String}

  create_at: {type:Date, default:new Date()}
})

mongoose.model('Menu', MenuSchema)
