mongoose = require('mongoose')
Schema = mongoose.Schema
ObjectId = Schema.Types.ObjectId

UserSchema = new Schema({
  username:{type:String,index:true,unique:true}
  nickname:{type:String}
  avatar:{type:String}
  # 性别, true 女, false 男
  sex:{type:Boolean,default:false}
  oldpassword:{type:String}
  password:{type:String}

  email:{type:String,index:true,unique:true,sparse:true}
  mobile:{type:String,index:true,unique:true,sparse:true}
  # 是否激活
  active:{type:Boolean,default:false}
  admin:{type:Boolean,default:false}
  remove:{type:Boolean,default:false}
  # competence:{type:String,default:""}  

  question1:{String}
  answer1:{String}
  question2:{String}
  answer2:{String}
  question3:{String}
  answer3:{String}

  create_at: {type:Date, default:new Date()}
  login_at: {type:Date}
  read_comment: {type:Date, default:new Date()}

})

mongoose.model('User', UserSchema)
