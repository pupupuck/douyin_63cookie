
script= {
	name = "抖音一条龙",
	description = "脚本描述",
	ver = "1.1",
	time = "2019-05-13",
	auth = "靖哥哥",
}


----------------------------------------------------------------------------
-- 函数名称 : main
-- 函数功能 : 主函数,默认第一个运行,主要实现系统化的mvc调度, 如自动更新,加载模块, 分发功能
-- 函数参数 : 无
-- 函数返回 : 无

function main()

	-- 引入常用的库
	local ts = ts or require("ts") --苏泽库升级版
	require("TSLib")
	require("app")  --不通用,自己独有的
	require("function") --通用,可移植


	toast("开始运行脚本",2)
	init("0",0) --屏幕初始化
	math.randomseed(tostring(os.time())) --置随机种子，方便后面math.random调用

	wakeupDevice()
	--waitingApp(bid)

	--getLinks("首页","相册权限")
	--nLog3(" ------minListjson: " .. ts.json.encode(getLinks("首页","相册权限")))


--	local dataPath = appDataPath(app.bid)
--	os.execute("su")
--	os.execute("chmod -R 777 "..dataPath) -- 设置读写权限,原来是644
--	os.execute("chown -R mobile.mobile "..dataPath) -- 属主改成mobile，属组改成mobile
--	nLog(dataPath)

--	local result,msg = ts.dborder(dataPath.."/Library/AWEStorage/UnifyStorage.sqlite"," UPDATE UNIFYTABLE SET DATA = '8886d30e6949d25ecbb67c4e7665b86fbdf81df7' WHERE KEY = 'com.aweme.network.params.openudid' ")


cleanAppData()

--write63()

--export63()


	toast("结束",2)
end


----------------------------------------------------------------------------
-- 函数名称 : err
-- 函数功能 : 处理error等系统错误,包装后再输出,最好放在main里
-- 函数参数 : (string 异常描述信息)
-- 函数返回 : 无
----------------------------------------------------------------------------

function err(msg)
	local msg = "[拦截到错误:]"..msg
	dialog(msg, 0)
end


-- 绑定错误处理函数,这里初始化并调用main运行
xpcall(main, err)
