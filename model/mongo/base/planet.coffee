mongoose = require('mongoose')
Schema = mongoose.Schema
ObjectId = Schema.Types.ObjectId
# planet
PlanetSchema = new Schema({
	title: {type:String,index:true,unique:true}
	description: {type: String}
	pics: {type: String}
	url:{type:String,index:true,unique:true}
	date: {type:Date ,default:new Date() ,index:true}
	edit_at: {type:Date ,default:new Date() ,index:true}
	# create_at: {type:Date ,default:new Date() ,index:true}
	Discoverer:{type:ObjectId,ref:"User",index:true,sparse:true,default:null}
	author: {type: String, default: ""}
	galaxy: {type: String, default: ""}
	shares: {type: Number, default: 0}
	views: {type: Number, default: 0}
	star: {type: Number, default: 0}
	# comments: []

})

mongoose.model('Planet', PlanetSchema)
