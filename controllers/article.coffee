EP = require 'eventproxy'
config = require('../config').config
mdb = require("../model/mongo")
Article = mdb.Article
Comment = mdb.Comment
User = mdb.User
Type = mdb.Type
Tag = mdb.Tag

exports.index = (req,res,next)->
  # index 为首页,如果没有二级参数,则默认访问此页.
  page = 1
  Article.count (err,count)->
    if (page-1)*config.list_count > count
      page = Math.ceil(count/config.list_count)+1
    ep = new EP.create "articles","types","tags",(articles,types,tags)->
      res.render config.template+"/article",{page:page,count:count,articles:articles,types:types,tags:tags}

    Article.getByPage page-1,(err,objs)->
      return ep.emit "articles",[] if err?
      ep.emit "articles",objs
    Type.getAll (err,objs)->
      return ep.emit "types",[] if err?
      ep.emit "types",objs
    Tag.getAll (err,objs)->
      return ep.emit "tags",[] if err?
      ep.emit "tags",[]

exports.page = (req,res,next)->
  # 获取分页,每页数据.
  Path = res.locals.Path
  page = 1
  page = Path[3] if Path.length>3 and Path[3]>1
  page = 1 if page < 1

  Article.count (err,count)->
    if (page-1)*config.list_count > count
      page = Math.ceil(count/config.list_count)+1
      # return res.redirect "/"

    ep = new EP.create "articles","types","tags",(articles,types,tags)->
      res.render config.template+"/article-page",{page:page,count:count,articles:articles,types:types,tags:tags}

    Article.getByPage page-1,(err,objs)->
      return ep.emit "articles",[] if err?
      ep.emit "articles",objs
    Type.getAll (err,objs)->
      return ep.emit "types",[] if err?
      ep.emit "types",objs
    Tag.getAll (err,objs)->
      return ep.emit "tags",[] if err?
      ep.emit "tags",[]


exports.default = (req,res,next)->
  # 显示 article 文章.
  # res.send "article-info"
  Path = res.locals.Path
  Article.getUrl Path[2],(err,obj)->
    if obj?
      Comment.getById obj._id,(err,comments)->
        res.render config.template+"/article-info",{article:obj,comments:comments}
    next()
