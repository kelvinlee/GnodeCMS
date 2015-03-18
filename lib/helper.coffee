exec = require("child_process").exec

#
# 返回默认json
#
# @param {}
# @return {json}
#
recode = (recode = 200, reason = "success")->
	return {recode:recode,reason:reason}
exports.recode = recode


#
# 返回默认string,时间与现在间隔.
#
# @param {date,frindly}
# @return {string}
#
format_date = (date, friendly = false)->
	year = date.getFullYear()
	month = date.getMonth() + 1
	day = date.getDate()
	hour = date.getHours()
	minute = date.getMinutes()
	second = date.getSeconds()
	if friendly
		now = new Date()
		mseconds = -(date.getTime() - now.getTime())
		time_std = [ 1000, 60 * 1000, 60 * 60 * 1000, 24 * 60 * 60 * 1000 ]
		if mseconds < time_std[3]
			return Math.floor(mseconds / time_std[0]).toString() + ' 秒前' if mseconds > 0 && mseconds < time_std[1]
			return Math.floor(mseconds / time_std[1]).toString() + ' 分钟前' if mseconds > time_std[1] && mseconds < time_std[2]
			return Math.floor(mseconds / time_std[2]).toString() + ' 小时前' if mseconds > time_std[2]
		return format_date(date,false)

	month = (if month<10 then '0' else '') + month;
	day = (if day<10 then '0' else '') + day;
	hour = (if hour<10 then '0' else '') + hour
	minute = (if minute<10 then '0' else '') + minute
	second = (if second<10 then '0' else '') + second
	thisYear = new Date().getFullYear()
	year = if (thisYear is year) then '' else (year + '-')
	return year + month + '-' + day + ' ' + hour + ':' + minute

exports.formatDate = format_date

#
# 返回默认json
#
# @param {}
# @return {json}
#
recode = (recode = 200, reason = "success")->
	return {recode:recode,reason:reason}
exports.recode = recode

#
# 返回默认html
#
# @param {bool}
# @return {string}
#
bool = (bool = false)->
	return if bool then '<i class="fa fa-check"></i>' else '<i class="fa fa-close"></i>'
exports.bool = bool