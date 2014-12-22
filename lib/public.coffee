Menu = require("../model/mongo").Menu
Config = require("../config").config
language = require "../language"
helper = require "./helper"
EP = require 'eventproxy'

# 后台
User = require "../controllers/admin/user"

exports.public = (req,res,next)->
  # 获取页面加载时间.
  RouteTime = new Date().getTime()
  res.locals._RouteTime = RouteTime
  res.locals.RunTime = ->
    return (new Date().getTime()-@._RouteTime)
  res.locals._menu = "home"
  res.locals.checkMenu = (name,_menu)->
    return "active" if name is _menu
    return ""
  res.locals.helper = helper
  res.locals.language = language
  res.locals.title = Config.name
  res.locals.keywords = ""
  res.locals.description = Config.description
  # 获取菜单
  Menu.getAll (err,menu)->
    res.locals.menu = menu
    next()

exports.before = (req,res,next)->
  # 此处可以做用户验证,如是否登录后台,前台等.
  
  ep = new EP.create "loginAdmin","login",(loginAdmin,login)->
    res.locals.loginAdmin = loginAdmin
    res.locals.login = login
    next()
  User.checklogin req,res,(bool)->
    ep.emit "loginAdmin",bool
  ep.emit "login",null

