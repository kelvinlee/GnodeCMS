config = require('../config').config
helper = require("../lib/helper")
mdb = require("../model/mongo")
EP = require 'eventproxy'
oss = require "../lib/oss"
Urls = mdb.Urls

Planet = mdb.Planet

$cdn = "http://disk.giccoo.com/uploadDir"
# $cdn = "http://192.168.1.2:5757/uploadDir"

exports.index = (req,res,next)->
	# index 为首页,如果没有二级参数,则默认访问此页.
	re = new helper.recode()
	re.list = []

	ep = new EP.create "planet", (planet)->
		# data = {}
		for i in planet
			pics = []
			for j in i.pics.split(",")
				pics.push($cdn+"/"+j)
			
			re.list.push {
				id: i._id
				title: i.title
				url: i.url
				description: i.description
				pics: pics
				author: i.author
				galaxy: i.galaxy
				Discoverer: i.Discoverer
				date: i.date
			}
		
		# res.render config.templateforadmin+"/planet-index",data
		res.send re

	Planet.getAll (err,planet)->
		ep.emit "planet" ,planet

		
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