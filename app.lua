

app = {
	name = "抖音短视频",
	bid = "com.ss.iphone.ugc.Aweme",
	res = "/var/allinone",
}

-- 本页函数没有通用性,不可移植
-- 引入常用的库,以保证函数库可以独立使用,多次引入不影响效率
local ts = ts or require("ts") --苏泽库升级版
require("TSLib")

----------------------------------------------------------------------------
-- 函数名称 : page
-- 函数功能 : 存储坐标点和链接页等,格式如pages[page][point],配合waitingClick使用,
--[[          点坐标xycolor,点击坐标click,链接页link(单链接),找文字text,
              完后动作action,循环时默认动作default
              有层的概念,link连接到page.layer默认为0层
			   action= 点击,滑动,等待,保存, default=点击:小广告/帮助/错误信息/其他页面/等要关闭的小图标
			link里有多个链接,有主链接,次要链接等,默认第一个为主链接,次要链接多为错误信息等
			命名注意: key值和link值不要相同,建议link加 "**页" ,
			若有link=某个层layer, 那么可以独立成page页
--]]
-- 函数参数 : 无
-- 函数返回 : 无

pages = {
	首页 = {
		首页 = {layer=0, xycolor = {58, 1133, 0xffffff },},
		消息 = {layer=0, xycolor = { 58, 1133, 0xffffff},click={   436, 1082, 0xc4bdb8 },link = {"消息页"},},
		我的 = {layer=0, xycolor = { 58, 1133, 0xffffff},click={   569, 1081, 0xbcb6b2 },link = {"我的主页"},},
		TA的 = {layer=0, xycolor = { 34, 1007, 0xffffff},click={ 582,  322, 0xbc908c  },link={"TA的主页"},},
		喜欢 = {layer=0, xycolor = { 34, 1007, 0xffffff},click={  579,  474, 0xfcf7ef },},
		评论 = {layer=0, xycolor = { 34, 1007, 0xffffff},click={  580,  639, 0xf2f3f3  },link={"评论页"},},
		分享 = {layer=0, xycolor = { 34, 1007, 0xffffff},click={  578,  783, 0x47d300  },link={"分享页"},},
	},

	消息页 = {
		消息 = {layer=0, xycolor = { 449, 1133, 0xffffff },},
		首页 = {layer=0, xycolor = { 307,   80, 0xe9e9ea },click={   48, 1078, 0xa3a4a6 },link = {"首页"},},
		我的 = {layer=0, xycolor = { 307,   80, 0xe9e9ea },click={  569, 1082, 0xa3a3a5 },link = {"我的主页"},},
		帮助 = {layer=1, xycolor = { 62,  994, 0x20c8ec },click={  580,  973, 0xe9e9ea },default="click",}, 
		角标 = {layer=2, xycolor = {480, 1057, 0xface15},}, 
	},

	我的主页 = {
		我的 = {layer=0, xycolor = {  577, 1133, 0xffffff },},
		更多 = {layer=0, xycolor = {    584,   83, 0xf1eff0   },link = {"更多设置页"},},
		编辑 = {layer=0, xycolor = {  344,  272, 0xececed },link = {"编辑个人资料"},},
		发现好友 = {layer=0, xycolor = {   579,  282, 0xececed },link = {"发现好友页"},},
		粉丝 = {layer=0, xycolor = {577, 1133, 0xffffff},click={  314,  690, 0x8b8c91  },link = {"粉丝页"},},
		关注 = {layer=0, xycolor = {577, 1133, 0xffffff},click={  195,  694, 0x8b8c91 },link={"我关注的"},},
		首页 = {layer=0, xycolor = {577, 1133, 0xffffff },click={   47, 1082, 0xa3a4a6 },link = {"首页"},},
		添加视频 = {layer=0, xycolor = {577, 1133, 0xffffff},click={  320, 1086, 0x191a1f },link={"添加视频页"},},
		消息 = {layer=0, xycolor = {577, 1133, 0xffffff},click={  569, 1082, 0xfdfdfd },link = {"消息页"}, },
		帮助信息 = {layer=1, xycolor = { 584, 1001, 0xffffff  },default="click",}, 
	},

	我关注的 = {
		返回 = {layer=0, xycolor = { 39,   83, 0x8b8c91},link={"我的主页"},},
		发现好友 = {layer=0, xycolor = {597,   93, 0x8b8c91},link={"发现好友页"},},
		搜索按钮 = {layer=0, xycolor = {70,  195, 0x66676e},},
	},

	发现好友页 = {
		发现好友 = {layer=0, xycolor = {  428,  125, 0xface15 },},
		返回 = {layer=0, xycolor = {   39,   83, 0x8b8c91 },link = {"我的主页"}, },
		好友列表 = {layer=0, xycolor = {  428,  125, 0xface15 },click={  218,   79, 0x8b8c91 },link = {"好友列表页"},},
	},

	好友列表页 = {
		好友列表 = {layer=0, xycolor = {  207,  125, 0xface15 },},
		返回 = {layer=0, xycolor = {   38,   83, 0x8b8c91 },link = {"我的主页"}, },
		发现好友 = {layer=0, xycolor = {  207,  125, 0xface15 },click={  437,   78, 0x86878d },link = {"发现好友页"},},
		发消息 = {layer=0, xycolor = {  570,  304, 0xc5c5c8 },link = {"聊天窗口"},},
	},

	TA的主页 = {
		返回 = {layer=0, xycolor = {   48,   83, 0xf4f4f5  },link = {"首页"}, },
		更多 = {layer=0, xycolor = {   584,   84, 0xf5f6f6 },link = {"TA的更多"}, },
		感兴趣 = {layer=0, xycolor = {  569,  270, 0xffffff },link = {"可能感兴趣的人"},},
		头像 = {layer=0, xycolor = { 48,   83, 0xf4f4f5},click={  126,  266, 0xd7bfaf },link = {"TA的头像页"},},
		TA的粉丝 = {layer=0, xycolor = {48,   83, 0xf4f4f5},click={  401,  774, 0xe9e9ea },link = {"TA的粉丝页"},},
		TA的作品 = {layer=0, xycolor = { 48,   83, 0xf4f4f5},click={  103,  885, 0x161823  },text="作品",link={"TA的作品页"}},
		TA的动态 = {layer=0, xycolor = { 48,   83, 0xf4f4f5},click={  318,  886, 0x161823 }},
		TA的喜欢 = {layer=0, xycolor = { 48,   83, 0xf4f4f5},click={    536,  882, 0x161823  },},
	},

	TA的头像页 = {
		下载 = {layer=0, xycolor = {  580, 1078, 0xffffff },link = {"相册权限"}, },
		返回 = {layer=0, xycolor = {  580, 1078, 0xffffff },click={   293, 1000, 0x000000 },link = {"TA的主页"},},
	},


	相册权限 = {
		不允许 = {layer=0, xycolor = {  152,  658, 0x007aff },},
		好 = {layer=0, xycolor = {  445,  662, 0x007aff },default="click",},
	},

	推送通知 = {
		不允许 = {layer=0, xycolor = {153,  678, 0x007aff},},
		好 = {layer=0, xycolor = {  446,  681, 0x007aff},default="click",},
	},

	验证码登录 = {
		关闭 = {layer=0, xycolor = { 55,   83, 0xf2f0fd},},
		密码登录 = {layer=0, xycolor = { 499,   85, 0xffffff},link={"密码登录"},},
		选择国家 = {layer=0, xycolor = {    134,  261, 0xffffff },link={"选择国家页"},},
		输手机号 = {layer=0, xycolor = {  134,  261, 0xffffff},click={  175,  260, 0xface15 },},
		取验证码 = {layer=0, xycolor = {  134,  261, 0xffffff },click={  513,  368, 0xcfb4fa },},
		输验证码 = {layer=0, xycolor = { 134,  261, 0xffffff },click={  62,  370, 0xbf99fc },},
		其他登录 = {layer=0, xycolor = { 415,  487, 0xffffff  },link={"其他登录页"},},
		辅助点 = {layer=0, xycolor = { 415,  487, 0xffffff  },},
	},

	其他登录页 = {
		关闭 = {layer=0, xycolor = { 55,   83, 0xf2f0fd},},
		头条 = {layer=0, xycolor = {   190,  592, 0xff0000},link={"头条授权登录"},},
		qq = {layer=0, xycolor = {  318,  598, 0xe81e1e },link={"qq授权登录"},},
		微博 = {layer=0, xycolor = {  442,  589, 0xe42223 },link={"微博授权登录"},},
	},

	选择国家页 = {
		关闭 = {layer=0, xycolor = {   55,   84, 0xa1a2a4 },link={"验证码登录"},},
		美国 = {layer=0, xycolor = { x,   y, color},text = "美国",link={"未知的"},action = "move"}, 
	},

	点选验证码 = { 
		确定 = {layer=0, xycolor = {55,   84, 0xa1a2a4 },link={"首页","验证码错误"},},
		刷新 = {layer=0, xycolor = { 55,   84, 0xa1a2a4},},
	},

	密码登录 = {
		返回 = {layer=0, xycolor = {   39,   84, 0xf2f0fe},},
		选择国家 = {layer=0, xycolor = {134,  249, 0xffffff},link={"选择国家页"},},
		输手机号 = {layer=0, xycolor = {134,  249, 0xffffff},click={  176,  251, 0xeabf40 },},
		输入密码 = {layer=0, xycolor = { 134,  249, 0xffffff },click={   59,  358, 0xa36dfe },},
		找回密码 = {layer=0, xycolor = {337,  472, 0xface15},},
		已阅读 = {layer=0, xycolor = { 158,  563, 0xf2e3ff },},
		登录 = {layer=0, xycolor = {  316,  673, 0xd298fd },link = {"首页","登录错误"},}, 
	},
}


----------------------------------------------------------------------------
-- 函数名称 : cleanAppData
-- 函数功能 : 清空app用户数据,相当于重装app,相当于一键新机,不删除特殊文件夹
-- 函数参数 : string
-- 函数返回 : string

function cleanAppData(bid)

	bid = bid or app.bid
	if appIsRunning(bid) == 1 then  -- 目标应用前台运行或者后台运行返回值都为 1
		closeApp(bid)
	end
	clearAllKeyChains() --删除所有手机安装应用钥匙串信息
	clearIDFAV() -- 清理所有应用的广告id ,"18F13511-BED0-4E76-8550-8D339C569DFF",

	local dataPath = appDataPath(bid)
	if dataPath ~= "" then  
		-- 清空文件夹
		os.execute("su")
		os.execute("chmod -R 777 "..dataPath) -- 设置读写权限,原来是755
		os.execute("chown -R mobile.mobile "..dataPath) -- 属主改成mobile，属组改成mobile

		os.execute("rm -rf "..dataPath.."/Documents/*")
		os.execute("rm -rf "..dataPath.."/Library/*")
		os.execute("rm -rf "..dataPath.."/tmp/*")
		os.execute("rm -rf "..dataPath.."/Library/.umeng")
		os.execute("rm -rf "..dataPath.."/Documents/.UTSystemConfig")
		mSleep(1000)

		-- 写入必要文件(重装app后才有的)
		appData1 = userPath()
		appData1 = appData1.."/res/appData.zip"
		if ts.unzip(appData1,dataPath) == false then
			nLog3(" -错误: ts.unzip失败!")
			return false
		end
		os.execute("chmod -R 777 "..dataPath) -- 设置读写权限,原来是755
		os.execute("chown -R mobile.mobile "..dataPath) -- 属主改成mobile，属组改成mobile

		-- 修改重装后的MCMMetadataUUID, 361并没有修改此项
		plistPath = dataPath.."/.com.apple.mobile_container_manager.metadata.plist"
		local tmp2 = ts.plist.read(plistPath)
		local num16 = {}
		local uuid = ""
		num16 = {"0","1","2","3","4","5","6","7","8","9","A","B","C","D","E","F"}
		for i=1,36 do
			if i == 9 or i == 14 or i == 19 or i == 24 then
				uuid = uuid.."-"
			else
				uuid = uuid..num16[math.random(1,16)]
			end
		end
		nLog3(" -修改UUID为: "..uuid)
		tmp2["MCMMetadataUUID"] = uuid 

		if type(ts.plist.write(plistPath, tmp2)) == "table" then
			nLog3(" -正确: appData数据清理成功!")
			return true
		end
		nLog3(" -错误: appData数据清理失败!")
		return false
	end
end


----------------------------------------------------------------------------
-- 函数名称 : write63
-- 函数功能 : 写入抖音63数据
-- 函数参数 : string ,参数为文本型的十六进制数据
-- 函数返回 : true or false

function write63(str)
	local data63 = [[63 6F 6F 6B 00 00 00 05 00 00 00 DE 00 00 00 C0 00 00 03 C6 00 00 00 C2 00 00 00 BF 00 00 01 00 01 00 00 00 10 00 00 00 00 00 00 00 CE 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 38 00 00 00 43 00 00 00 4B 00 00 00 4D 00 00 00 00 00 00 00 00 00 00 00 00 00 80 B5 1E E1 C3 41 00 00 80 B5 F0 4D C1 41 2E 61 6D 65 6D 76 2E 63 6F 6D 00 6F 64 69 6E 5F 74 74 00 2F 00 38 37 34 31 37 31 62 36 61 63 36 34 36 39 36 64 31 64 35 38 31 30 61 30 36 30 30 61 64 65 39 37 35 33 33 30 34 66 31 36 30 34 64 62 65 37 66 32 64 34 61 35 39 37 31 37 34 38 62 65 34 36 36 34 63 37 33 66 62 64 65 30 64 65 62 61 65 38 38 63 66 64 63 32 39 66 33 36 30 62 64 37 39 36 32 62 35 31 33 37 66 34 33 65 30 65 62 66 63 62 38 32 65 34 35 33 65 61 62 38 34 63 61 62 37 39 36 35 00 00 00 01 00 01 00 00 00 10 00 00 00 00 00 00 00 B0 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 38 00 00 00 45 00 00 00 4D 00 00 00 4F 00 00 00 00 00 00 00 00 00 00 00 00 00 80 BC 1E E1 C3 41 00 00 80 BC F0 4D C1 41 2E 74 6F 75 74 69 61 6F 2E 63 6F 6D 00 6F 64 69 6E 5F 74 74 00 2F 00 62 64 34 61 66 62 31 32 65 31 63 31 30 62 64 63 38 31 61 37 31 35 30 36 62 61 62 34 61 66 35 34 39 64 34 62 31 36 34 30 64 38 38 36 61 36 39 64 66 32 37 62 30 39 66 39 30 34 61 30 66 32 61 31 32 33 39 65 33 35 33 31 34 37 31 63 61 37 62 39 35 31 37 39 38 33 33 62 33 38 37 65 32 65 30 61 00 00 00 01 00 07 00 00 00 28 00 00 00 85 00 00 00 54 01 00 00 C5 01 00 00 73 02 00 00 E1 02 00 00 58 03 00 00 00 00 00 00 5D 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 38 00 00 00 44 00 00 00 4F 00 00 00 51 00 00 00 00 00 00 00 00 00 00 00 00 00 00 7D F1 00 C6 41 00 00 00 BD F0 4D C1 41 2E 73 6E 73 73 64 6B 2E 63 6F 6D 00 69 6E 73 74 61 6C 6C 5F 69 64 00 2F 00 37 33 34 34 34 33 35 34 37 35 33 00 CF 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 38 00 00 00 44 00 00 00 4C 00 00 00 4E 00 00 00 00 00 00 00 00 00 00 00 00 00 00 B5 1E E1 C3 41 00 00 00 B5 F0 4D C1 41 2E 73 6E 73 73 64 6B 2E 63 6F 6D 00 6F 64 69 6E 5F 74 74 00 2F 00 38 39 37 62 66 39 38 32 36 31 64 61 66 64 34 39 30 35 61 32 36 62 66 38 39 63 33 37 33 39 36 30 35 31 31 64 39 30 61 34 66 31 39 37 34 36 61 37 65 32 39 30 30 62 66 32 65 39 30 39 61 38 39 36 62 64 30 62 38 65 32 34 35 34 65 39 62 64 32 30 32 34 36 30 30 37 65 65 66 37 65 35 37 37 30 38 61 36 30 35 30 36 32 32 64 34 35 62 37 64 66 33 35 30 31 63 36 34 30 33 35 33 39 63 38 66 66 61 00 71 00 00 00 00 00 00 00 04 00 00 00 00 00 00 00 38 00 00 00 44 00 00 00 4E 00 00 00 50 00 00 00 00 00 00 00 00 00 00 00 00 00 00 B5 7D 75 C1 41 00 00 00 B5 F0 4D C1 41 2E 73 6E 73 73 64 6B 2E 63 6F 6D 00 73 65 73 73 69 6F 6E 69 64 00 2F 00 35 38 33 34 66 35 66 37 64 64 33 38 34 34 34 36 37 38 64 64 63 66 30 66 33 33 39 61 37 61 62 34 00 AE 00 00 00 00 00 00 00 04 00 00 00 00 00 00 00 38 00 00 00 44 00 00 00 4E 00 00 00 50 00 00 00 00 00 00 00 00 00 00 00 00 00 00 B5 3E 3B C2 41 00 00 00 B5 F0 4D C1 41 2E 73 6E 73 73 64 6B 2E 63 6F 6D 00 73 69 64 5F 67 75 61 72 64 00 2F 00 35 38 33 34 66 35 66 37 64 64 33 38 34 34 34 36 37 38 64 64 63 66 30 66 33 33 39 61 37 61 62 34 25 37 43 31 35 35 38 39 34 38 33 33 30 25 37 43 35 31 38 34 30 30 30 25 37 43 46 72 69 25 32 43 2B 32 36 2D 4A 75 6C 2D 32 30 31 39 2B 30 39 25 33 41 31 32 25 33 41 31 30 2B 47 4D 54 00 6E 00 00 00 00 00 00 00 04 00 00 00 00 00 00 00 38 00 00 00 44 00 00 00 4B 00 00 00 4D 00 00 00 00 00 00 00 00 00 00 00 00 00 00 B5 7D 75 C1 41 00 00 00 B5 F0 4D C1 41 2E 73 6E 73 73 64 6B 2E 63 6F 6D 00 73 69 64 5F 74 74 00 2F 00 35 38 33 34 66 35 66 37 64 64 33 38 34 34 34 36 37 38 64 64 63 66 30 66 33 33 39 61 37 61 62 34 00 77 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 38 00 00 00 44 00 00 00 4A 00 00 00 4C 00 00 00 00 00 00 00 00 00 00 00 00 00 00 7D F1 00 C6 41 00 00 00 BD F0 4D C1 41 2E 73 6E 73 73 64 6B 2E 63 6F 6D 00 74 74 72 65 71 00 2F 00 31 24 35 31 66 38 39 64 39 61 62 33 37 66 38 31 34 35 62 30 62 38 31 31 33 31 39 34 63 35 38 35 37 35 35 38 33 30 64 65 63 61 00 6E 00 00 00 00 00 00 00 04 00 00 00 00 00 00 00 38 00 00 00 44 00 00 00 4B 00 00 00 4D 00 00 00 00 00 00 00 00 00 00 00 00 00 00 B5 7D 75 C1 41 00 00 00 B5 F0 4D C1 41 2E 73 6E 73 73 64 6B 2E 63 6F 6D 00 75 69 64 5F 74 74 00 2F 00 63 61 35 36 32 30 34 61 34 37 30 32 37 33 30 34 37 62 30 33 34 38 30 30 63 37 34 39 62 63 61 30 00 00 00 01 00 01 00 00 00 10 00 00 00 00 00 00 00 B2 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 38 00 00 00 47 00 00 00 4F 00 00 00 51 00 00 00 00 00 00 00 00 00 00 00 00 00 00 BD 1E E1 C3 41 00 00 00 BD F0 4D C1 41 2E 62 79 74 65 64 61 6E 63 65 2E 63 6F 6D 00 6F 64 69 6E 5F 74 74 00 2F 00 33 32 39 65 31 31 38 39 37 66 61 36 66 38 36 30 64 34 36 39 33 66 39 36 33 62 38 33 39 37 61 36 65 32 34 61 36 38 39 65 35 65 39 63 35 64 63 34 64 34 33 33 62 64 61 38 66 65 63 36 62 32 62 39 64 62 64 64 66 34 64 33 65 39 36 35 30 37 31 35 62 37 36 30 66 66 39 30 62 30 61 35 64 30 31 36 00 00 00 01 00 01 00 00 00 10 00 00 00 00 00 00 00 AF 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 38 00 00 00 44 00 00 00 4C 00 00 00 4E 00 00 00 00 00 00 00 00 00 00 00 00 00 00 BD 1E E1 C3 41 00 00 00 BD F0 4D C1 41 2E 70 73 74 61 74 70 2E 63 6F 6D 00 6F 64 69 6E 5F 74 74 00 2F 00 30 34 35 33 38 38 63 37 62 66 63 63 36 33 30 64 37 36 62 66 39 63 65 65 66 35 65 30 37 35 32 35 62 65 64 36 66 35 65 32 35 61 63 66 65 31 31 36 66 32 66 35 33 62 38 30 35 34 61 34 61 32 39 30 36 64 39 62 65 65 34 36 64 63 35 61 65 34 31 34 62 37 61 39 32 38 38 64 34 63 33 37 35 61 30 66 00 00 00 64 92 07 17 20 05 00 00 00 4B 62 70 6C 69 73 74 30 30 D1 01 02 5F 10 18 4E 53 48 54 54 50 43 6F 6F 6B 69 65 41 63 63 65 70 74 50 6F 6C 69 63 79 10 00 08 0B 26 00 00 00 00 00 00 01 01 00 00 00 00 00 00 00 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 28 ]]
	--data63 = string.trim(data63)
	-- 63数据头部不能有空格,尾部必须有空格,中间间隔有空格
	data63 = hex2bin(data63)
	nLog3(" -写入63数据为: "..bin2hex(data63))

	local dataPath = appDataPath(app.bid)
	if dataPath ~= "" then 
		os.execute("su")
		os.execute("chmod -R 777 "..dataPath) -- 设置读写权限,原来是644
		os.execute("chown -R mobile.mobile "..dataPath) -- 属主改成mobile，属组改成mobile
		os.execute("mkdir "..dataPath.."/Library/Cookies")
		cookiesPath = dataPath.."/Library/Cookies/Cookies.binarycookies"
		--mSleep(1000)
		if io.writefile(cookiesPath, data63) == true then
			os.execute("su")
			os.execute("chmod -R 777 "..dataPath) -- 设置读写权限,原来是644
			os.execute("chown -R mobile.mobile "..dataPath) -- 属主改成mobile，属组改成mobile
			nLog3(" -正确: 写入63成功!")
			return true
		else
			nLog3(" -错误: 写入63失败1!")
			return false
		end
	end
	nLog3(" -错误: 写入63失败2!")
	return false
end


----------------------------------------------------------------------------
-- 函数名称 : read63
-- 函数功能 : 读取63数据, 参数为文本型的十六进制数据
-- 函数参数 : string
-- 函数返回 : string

function read63()
	local dataPath = appDataPath(app.bid)
	if dataPath ~= "" then 
		dataPath = dataPath.."/Library/Cookies/Cookies.binarycookies"
		nLog3(" -dataPath: "..dataPath)
		os.execute("su")
		os.execute("chmod -R 777 "..dataPath) -- 设置读写权限,原来是644
		os.execute("chown -R mobile.mobile "..dataPath) -- 属主改成mobile，属组改成mobile
		local str = io.readfile(dataPath)
		if str then
			return bin2hex(str)
		else
			nLog3(" -错误: 读取63失败!")
			return 0
		end
	end
	nLog3(" -错误: 读取63失败!")
	return 0
end


----------------------------------------------------------------------------
-- 函数名称 : export63
-- 函数功能 : 输出数据到文本文件,
-- 函数参数 : string
-- 函数返回 : string

function export63()
	local data63 = read63()
	if data63 ~= 0 then
		-- 查询表中userid
		local feedCountUser = "0"
		local dataPath = appDataPath(app.bid)
		local result,msg = ts.dborder(dataPath.."/Library/AWEStorage/UnifyStorage.sqlite","select DATA from UNIFYTABLE WHERE KEY = 'feedCountUser' LIMIT 0,1 ")
		if type(msg[1]) == "table" then
			feedCountUser = msg[1]["DATA"]
		else
			feedCountUser = "0"
		end
		local nickname = "0"
		local result,msg = ts.dborder(dataPath.."/Library/AWEStorage/UnifyStorage.sqlite","select DATA from UNIFYTABLE WHERE KEY = 'com.aweme.passport.lastSSOLoginNickname' LIMIT 0,1 ")
		if type(msg[1]) == "table" then
			nickname = msg[1]["DATA"]
		else
			nickname = "0"
		end
		-- 导出63
		local path63 = userPath().."/lua/导出的63.txt"
		data63 = string.atrim(data63)
		data63 = feedCountUser.."("..nickname..")----"..data63.."----------------"
		writeFileString(path63,data63,"a",1) -- a追加模式,1完后换行
		nLog3(" -读出的63: "..data63)
	else
		nLog3(" -错误: 读取63失败!")
		dialog(" -错误: 读取63失败!")
	end
end
