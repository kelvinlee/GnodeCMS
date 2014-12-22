config = require("../../config").config
helper = require("../../lib/helper")
EP = require 'eventproxy'

User = require("../../model/mongo").User

exports.before = (req,res,next,before)->
  before req,res,next

exports.index = (req,res,next)->
  # index 为首页,如果没有二级参数,则默认访问此页.
  res.render config.templateforadmin+"/user-index"

exports.list = (req,res,next)->
  # 测试二级参数,如果有二级参数则 default 不会被访问到,所以要注意.
  res.render config.templateforadmin+"/user-list"

exports.edit = (req,res,next)->
  Path = res.locals.Path

  if Path[4]?
    # console.log "path:",Path
    User.findById Path[4],(err,obj)->
      next() if err?
      res.render config.templateforadmin+"/user-edit",{user:obj}
  else
    res.render config.templateforadmin+"/user-edit",{user:null}

exports.edit_post = (req,res,next)->

  console.log req.body
  re = helper.recode()
  res.send re

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



# for public
exports.checklogin = (req,res,next)->
  sess = req.session
  # console.log sess if req.cookies.admin_user? and
  if sess.loginAdmin or req.cookies.admin_user
    User.getbyid sess.loginAdmin or req.cookies.admin_user,(err,user)->
      if user? and user.admin
        res.locals.adminuser = user
        next true
      else
        next false
  else
    res.locals.loginAdmin = false
    next false





