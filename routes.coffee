# 404页面存储在此类当中.
note = require './lib/note'
config = require('./config').config
# publicFun 为公共数据获取传给 locals 例如: menu 等信息.
publicRE = require './lib/public'
publicFun = publicRE.public
publicBefore = publicRE.before
url = require "url"

module.exports = (app)->

  # 如果需要文件夹来区分功能使用 folderRoute
  # folderRoute 可以向下增加一级目录.
  app.all "*", (req,res,next)->
    if config.Origin?
      res.header("Access-Control-Allow-Origin", "*")
      res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept")
    next()

  app.get "*", publicFun
  app.get "*", publicBefore

  app.get '/admin', folderRoute
  app.get '/admin/*', folderRoute
  app.post '/admin', folderRoute
  app.post '/admin/*', folderRoute

  app.get '*', routeURL
  app.get '*', note.notfound

  app.post '*', routeURL
  app.post '*', note.notfound

  console.log "Routes loaded."

folderRoute = (req,res,next)->
  Path = url.parse(req.url).pathname.split("/")

  goRoute req,res,next,Path[1]+"/"

routeURL = (req,res,next)->

  # Check 移动端. [未完成]
  # 注释: 因为移动端一般使用3g/4g, 是按照流量收费,所以应该页面和图片都比较小,
  # 所以此处的功能是为了优化性能.如果您使用的是自适应方式,请无视此处或者注释此处节省性能.
  # mobile = false
  # if req["headers"]? and req.headers["user-agent"]?
  #   UserAgent = req.headers["user-agent"].toLowerCase()
  #   # ipad = UserAgent.match(/ipad/i)? and UserAgent.match(/ipad/i)[0] is "ipad"
  #   iphone = UserAgent.match(/iphone os/i)? and UserAgent.match(/iphone os/i)[0] is "iphone os"
  #   android = UserAgent.match(/android/i)? and UserAgent.match(/android/i)[0] is "android"
  #   ucweb = UserAgent.match(/ucweb/i)? and UserAgent.match(/ucweb/i)[0] is "ucweb"
  #   mobile = true if iphone or android or ucweb
  # res.locals.mobile = mobile

  goRoute req,res,next


goRoute = (req,res,next,folder = "")->

  # 路由模式:
  # url: /一级/二级
  # 一级为类文件名称,二级为类内方法名称.
  # 所有类文件放在 controllers 文件夹下.
  # console.log folder

  Path = url.parse(req.url).pathname.split("/")
  res.locals.Path = Path

  second = 2
  second = 3 if folder? and folder isnt ""
  filename = Path[second-1]
  if url.parse(req.url).pathname is "/"+folder
    CTL = require("./controllers/"+folder+"home.coffee")
    before = (req,res,next)->
      CTL["index"](req,res,next)
    if CTL["before"]?
      CTL["before"](req,res,next,before)
    else
      CTL["index"](req,res,next)
    return 
  # 调取文件.
  # console.log "./controllers/"+folder+filename+".coffee"
  # try
  CTL = require "./controllers/"+folder+filename+".coffee"
  before = (req,res,next)->
    if not Path[second]? or typeof CTL["default"] isnt "function"
      CTL["index"](req,res,next)
    else if typeof CTL[Path[second]] is "function"
      CTL[Path[second]](req,res,next)
    else
      CTL["default"](req,res,next)
  if CTL["before"]?
    CTL["before"](req,res,next,before)
  else
    before req,res,next
  # console.log "second:",Path[second]
  # console.log "next"
  
  # catch error
    # next()


  