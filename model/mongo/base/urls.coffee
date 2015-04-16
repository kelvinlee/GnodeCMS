mongoose = require('mongoose')
Schema = mongoose.Schema
ObjectId = Schema.Types.ObjectId

UrlsSchema = new Schema({
	readed: {type: Boolean, default: false}
	star: {type: Number, default: 0}
	url:{type:String,index:true,unique:true}
	description:{type:String, default:""}
	read_at: {type: Date}
	create_at: {type:Date ,default:new Date() ,index:true}
})

mongoose.model('Urls', UrlsSchema)
