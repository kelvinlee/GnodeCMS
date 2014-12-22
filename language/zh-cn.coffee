module.exports = (type,text)->
	_zh_cn =
	"setting":
		"debug": "测试环境"
		"name": "网站名称"
		"description": "网站描述"
		"site_meta": "网站 meta 标记"
		"version": "版本"
		"upload": "上传路径"
		"host": "主机地址"
		"list_count": "每页文章数量"
		"template": "模板"
		"templateforadmin": "后台模板"
		"cdn": "CDN 地址"
		"Origin": "跨域请求地址"
		"site_logo": "网站 Logo"
		"mdb": "Mongodb 地址"
		"mdb_user": "Mongodb 用户名"
		"mdb_passwd": "Mongodb 密码"
		"mydb": "Mysql 地址"
		"db_user": "Mysql 用户名"
		"db_passwd": "Mysql 密码"
		"db_database": "Mysql 数据库"
		"session_secret": "Session 加密"
		"auth_cookie_name": "Cookie 加密"
		"ip": "主机IP地址"
		"port": "端口号"
		# error
		"list_count_not_less_than": "每页文章数量不能小于"
		"cant_empty": "不能为空"

	return _zh_cn[type][text] if _zh_cn[type]? and _zh_cn[type][text]?
	return text