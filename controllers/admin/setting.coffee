config = require("../../config").config
helper = require("../../lib/helper")
EP = require 'eventproxy'
fs = require 'fs'
Logs = require("../../model/mongo").Logs
language = require "../../language"


exports.before = (req,res,next,before)->
  if res.locals.loginAdmin
    before req,res,next
  else
    res.redirect '/admin/sign/in'

exports.index = (req,res,next)->
  # index 为首页,如果没有二级参数,则默认访问此页.
  res.render config.templateforadmin+"/setting-index"


exports.default = (req,res,next)->
  # default 用于分发,例如文章,分类等信息.
  res.render config.templateforadmin+"/setting-index"

exports.edit_post = (req,res,next)->
  _config = req.body
  re = new helper.recode()

  for k of _config
    _config[k] = true if _config[k] is "true"
    _config[k] = false if _config[k] is "false"

  # check config
  _config["list_count"] = parseInt _config["list_count"]
  
  # error
  re = helper.recode(203,language.zh_cn("setting","mdb_passwd")+language.zh_cn("setting","cant_empty"))if !_config["mdb_passwd"]
  re = helper.recode(203,language.zh_cn("setting","mdb_user")+language.zh_cn("setting","cant_empty"))if !_config["mdb_user"]
  # warring
  re = helper.recode(201,language.zh_cn("setting","list_count_not_less_than")+"1") if _config["list_count"] < 1

  if re.recode is 200
    # 将获取的数据写入 config
    fs.writeFile __dirname+"/../../config.js","exports.config="+JSON.stringify(_config),(err)->
      throw err if err
      res.send re
      # 进行 logs 日志输入.
      Logs.new "setting",null,"修改了配置文件."
  else
    res.send re