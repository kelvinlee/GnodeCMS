config = require('../config').config
helper = require("../lib/helper")
mdb = require("../model/mongo")
Urls = mdb.Urls

$cdn = "http://disk.giccoo.com/uploadDir"
#$cdn = "http://192.168.1.2:5757/uploadDir"

exports.index = (req,res,next)->
  # index 为首页,如果没有二级参数,则默认访问此页.
  re = new helper.recode()
  re.list = []
  # 翻墙
  # re.list.push {
  # 	title: "C4 Cactus Timeline" #星球名
  # 	description: "汽车参演穿越剧" #星球简介
  # 	pics: [$cdn+"/02.jpg"] #星球图片列表
  # 	url: "http://cactus.werkstatt.fr/fr/" #星球地址
  # 	views: 0 #星球访问者
  # 	author: "雪铁龙" #星球信仰
  # 	galaxy: "国外" #星球星系
  # 	Discoverer: "" #星球发现者
  # 	date: "" #星球发现日期
  # }

  re.list.push {
  	title: "A World of Belonging" #星球名
  	description: "手机玩转地球" #星球简介
  	pics: [$cdn+"/03.jpg"] #星球图片列表
  	url: "https://zh.airbnb.com/map/" #星球地址
  	views: 0 #星球访问者
  	author: "Airbnb" #星球信仰
  	galaxy: "国外" #星球星系
  	Discoverer: "" #星球发现者
  	date: "" #星球发现日期
  }

  re.list.push {
  	title: "二零一四娱乐圈画传" #星球名
  	description: "恶搞中国风" #星球简介
  	pics: [$cdn+"/04.jpg"] #星球图片列表
  	url: "http://ent.163.com/special/yulequanhuazhuan/" #星球地址
  	views: 0 #星球访问者
  	author: "网易" #星球信仰
  	galaxy: "国内" #星球星系
  	Discoverer: "" #星球发现者
  	date: "" #星球发现日期
  }

  re.list.push {
  	title: "我们之间就一个字" #星球名
  	description: "真的就一个字" #星球简介
  	pics: [$cdn+"/05.jpg"] #星球图片列表
  	url: "http://evt.dianping.com/5370/" #星球地址
  	views: 0 #星球访问者
  	author: "大众点评" #星球信仰
  	galaxy: "国内" #星球星系
  	Discoverer: "" #星球发现者
  	date: "" #星球发现日期
  }

  re.list.push {
  	title: "为了活过冬天，你知道南方人有多努力么？" #星球名
  	description: "南方公(dong)园(tian)" #星球简介
  	pics: [$cdn+"/06.jpg"] #星球图片列表
  	url: "http://news.163.com/special/southwinter/" #星球地址
  	views: 0 #星球访问者
  	author: "网易" #星球信仰
  	galaxy: "国内" #星球星系
  	Discoverer: "" #星球发现者
  	date: "" #星球发现日期
  }

  re.list.push {
  	title: "选择吧,人生!" #星球名
  	description: "多图杀流量" #星球简介
  	pics: [$cdn+"/07.jpg"] #星球图片列表
  	url: "http://evt.dianping.com/market/20141118/game/" #星球地址
  	views: 0 #星球访问者
  	author: "大众点评" #星球信仰
  	galaxy: "国内" #星球星系
  	Discoverer: "" #星球发现者
  	date: "" #星球发现日期
  }

  re.list.push {
  	title: "Mrsketch" #星球名
  	description: "美味是怎样炼成的" #星球简介
  	pics: [$cdn+"/08.jpg"] #星球图片列表
  	url: "http://mrsketch.com/" #星球地址
  	views: 0 #星球访问者
  	author: "Mrsketch" #星球信仰
  	galaxy: "国外" #星球星系
  	Discoverer: "" #星球发现者
  	date: "" #星球发现日期
  }

  re.list.push {
  	title: "指尖上的时空穿越之旅" #星球名
  	description: "动态漫画" #星球简介
  	pics: [$cdn+"/09.jpg"] #星球图片列表
  	url: "http://m.buick.com.cn/campaign/bip/" #星球地址
  	views: 0 #星球访问者
  	author: "别克" #星球信仰
  	galaxy: "国内" #星球星系
  	Discoverer: "" #星球发现者
  	date: "" #星球发现日期
  }

  re.list.push {
  	title: "百威为梦想举杯" #星球名
  	description: "\"射\"出祝福" #星球简介
  	pics: [$cdn+"/10.jpg"] #星球图片列表
  	url: "http://www.bud.cn/" #星球地址
  	views: 0 #星球访问者
  	author: "别克" #星球信仰
  	galaxy: "国内" #星球星系
  	Discoverer: "" #星球发现者
  	date: "" #星球发现日期
  }
  
  res.send re
exports.default = (req,res,next)->
	re = new helper.recode()
	res.send re

exports.homepage = (req,res,next)->
	re = new helper.recode()
	res.send re

exports.newway = (req,res,next)->
	re = new helper.recode()
	url = req.body.url
	url = url.toLowerCase()
	if /^(https?|http):\/\/(((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:)*@)?(((\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5]))|((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?)(:\d*)?)(\/((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)+(\/(([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)*)*)?)?(\?((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)|[\uE000-\uF8FF]|\/|\?)*)?(\#((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)|\/|\?)*)?$/.test(url)
		Urls.new req.body.url,"", (err,obj)->
			if err?
				re.recode = 203
				re.reason = "您提交的 URL 已经存在."
			res.send re
	else
		re.recode = 201
		re.reason = "URL 格式不对."
		res.send re