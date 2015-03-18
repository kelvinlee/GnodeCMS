config = require("../../config").config
helper = require("../../lib/helper")
EP = require 'eventproxy'
Logs = require("../../model/mongo").Logs
User = require("../../model/mongo").User

exports.before = (req,res,next,before)->
  sess = req.session
  userid = sess.loginAdmin or req.cookies.admin_user
  if userid
    before req,res,next
  else
    res.redirect '/admin/sign/in'

exports.index = (req,res,next)->
  # index 为首页,如果没有二级参数,则默认访问此页.
  ep = new EP.create "count","user", (count,user)->
    data = {}
    data.user_list = user
    data.user_count = count
    data.prepage = 1
    data.page = 1
    if count >= 1
      data.id = user[user.length-1]._id
    res.render config.templateforadmin+"/user-index",data

  User.getCount (err,count)->
    ep.emit "count" ,count
  User.getPage null,1,(err,users)->
    ep.emit "user" ,users

exports.page = (req,res,next)->
  # console.log "page"
  prepage = req.query.prepage
  page = req.query.page
  id = req.query.id

  _page = page - prepage

  ep = new EP.create "count","user", (count,user)->
    if (_page > 5 or _page < -5) and user.length >= config.list_count
      prepage = page 
      id = user[user.length-1]._id
    res.render config.templateforadmin+"/user-index",{user_list:user,user_count:count,prepage:prepage,page:page,id:id}

  User.getCount (err,count)->
    # console.log err,count
    ep.emit "count" ,count
  User.getPage id,_page,(err,user)->
    # console.log err,user
    ep.emit "user" ,user

exports.list = (req,res,next)->
  # 测试二级参数,如果有二级参数则 default 不会被访问到,所以要注意.
  res.render config.templateforadmin+"/user-list"

exports.edit = (req,res,next)->
  Path = res.locals.Path

  if Path[4]?
    # console.log "path:",Path
    User.getbyid Path[4],(err,obj)->
      next() if err?
      res.render config.templateforadmin+"/user-edit",{user:obj}
  else
    res.render config.templateforadmin+"/user-edit",{user:null}

exports.edit_post = (req,res,next)->
  Path = res.locals.Path

  if Path[4]?
    User.getbyid Path[4],(err,obj)->
      return res.send helper.recode("203","没有找到此用户") if err?
      # console.log req.body
      obj.nickname = req.body.nickname if req.body.nickname? and req.body.nickname isnt ""
      obj.email = req.body.email if req.body.email? and req.body.email isnt ""
      obj.mobile = req.body.mobile if req.body.mobile? and req.body.mobile isnt ""
      if req.body.active? and req.body.active is "on"
        obj.active = true 
      else
        obj.active = false
      if req.body.admin? and req.body.admin is "on"
        obj.admin = true 
      else
        obj.admin = false
      if req.body.sex? and req.body.sex is "true"
        obj.sex = true
      else
        obj.sex = false
      obj.save()
      re = helper.recode()
      res.send re
      Logs.new "User",req.session.loginAdmin or req.cookies.admin_user,"修改了用户 #{obj.username} 的信息."
  else
    res.send helper.recode("203","没有找到此用户")

exports.del_post = (req,res,next)  ->
  Path = res.locals.Path
  # console.log "req.body.del",req.body
  if Path[4]? and req.body.del?
    User.removebyid Path[4],(err,obj)->
      return res.send helper.recode("203","没有找到此用户") if err?
      re = helper.recode()
      res.send re
      Logs.new "User",req.session.loginAdmin or req.cookies.admin_user,"删除了用户 #{Path[4]} ."
  else
    res.send helper.recode("203","没有找到此用户")

exports.default = (req,res,next)->
  # default 用于分发,例如文章,分类等信息.
  Path = res.locals.Path
  
  if Path[3]?
    # console.log "path:",Path
    User.getbyid Path[3],(err,obj)->
      next() if err?
      res.render config.templateforadmin+"/user-edit",{user:obj}
  else
    next()

exports.new = (req,res,next)->
  res.render config.templateforadmin+"/user-new"

exports.new_post = (req,res,next)->
  re = new helper.recode()
  data = {}

  data.username = req.body.username if req.body.username? and req.body.username isnt ""
  data.passwd = req.body.passwd if req.body.passwd? and req.body.passwd isnt ""
  data.nickname = req.body.nickname if req.body.nickname? and req.body.nickname isnt ""
  data.email = req.body.email if req.body.email? and req.body.email isnt ""
  data.mobile = req.body.mobile if req.body.mobile? and req.body.mobile isnt ""
  if req.body.active? and req.body.active is "on"
    data.active = true 
  else
    data.active = false
  if req.body.admin? and req.body.admin is "on"
    data.admin = true 
  else
    data.admin = false
  if req.body.sex? and req.body.sex is "true"
    data.sex = true
  else
    data.sex = false

  return res.send helper.recode(201,"用户名为4到20个字符.") if not data.username? or data.username is "" or data.username.length > 20 or data.username.length < 4
  return res.send helper.recode(201,"两次密码不相同.") if data.passwd isnt req.body.passwd2
  return res.send helper.recode(201,"密码为6到20个字符.") if not data.passwd? or data.passwd is "" or data.passwd.length > 20 or data.passwd.length < 6
  re = new helper.recode()
  ep = new EP.create "username","email","mobile",(username,email,mobile)->
    return res.send helper.recode 203,"用户名已经存在" if username?
    return res.send helper.recode 203,"E-mail已经存在" if email?
    return res.send helper.recode 203,"手机号已经存在" if mobile?

    User.new data.username,data.passwd,data.active,(err,obj)->
      return next() if err?
      re.id = obj._id
      res.send re
      obj.admin = data.admin
      obj.email = data.email if data.email?
      obj.mobile = data.mobile if data.mobile?
      obj.sex = data.sex
      obj.save()
      Logs.new "User",req.session.loginAdmin or req.cookies.admin_user,"创建了用户 #{data.username} ."


  User.findOne {username:data.username}, (err,obj)->
    ep.emit "username",obj
  if data.email? and data.email isnt ""
    User.findOne {email:data.email}, (err,obj)->
      ep.emit "email",obj
  else
    ep.emit "email",null
  if data.mobile? and data.mobile isnt ""
    User.findOne {mobile:data.mobile}, (err,obj)->
      ep.emit "mobile",obj
  else
    ep.emit "mobile",null



# for public
exports.checklogin = (req,res,next)->
  sess = req.session
  # console.log sess if req.cookies.admin_user? and
  # console.log "userId:",sess.loginAdmin or req.cookies.admin_user
  if sess.loginAdmin? or req.cookies.admin_user?
    User.getbyid sess.loginAdmin or req.cookies.admin_user,(err,user)->
      if user? and user.admin
        res.locals.adminuser = user
        next true
      else
        next false
  else
    # console.log "go to next"
    res.locals.loginAdmin = false
    next false





