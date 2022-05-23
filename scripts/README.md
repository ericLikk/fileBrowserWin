# fileBrowserBat
windows 环境下的 fileBrowser 一键部署 支持内网穿透 无需云服务器 即可搭建自己的小网盘



启动方法
一： 双击 startRun.bat 启动  启动成功之后 通过在浏览器中输入 127.0.0.1:19876 来查看网盘  默认管理员登录账号是 admin 密码是 123456789...


可更改配置项：

1：网盘服务端口

在  startRun.bat 文件中指定了网盘的启动端口 该端口可进行修改
方法：

（1）用记事本打开  startRun.bat 文件

（2）找到 
		设置监听端口
			filebrowser.exe -d filebrowser.db config set --port 19876
		这里的19876就是启动端口 可以自行更改
（3）如果修改 startRun.bat 里面的端口之后 需要对应修改 startDD.vbs 里面的内网穿透端口
 方法：
	（1）用记事本打开 startDD.vbs 文件

	（2）找到 
		ws.CurrentDirectory &"/pierced-master/windows_64/ding.cfg -subdomain=znwxx 19876",0
		这里的-subdomain=znwxx 19876 中的19876就是启动端口 可以自行更改 
	（3）startDD.vbs 中的端口需要与startRun.bat中设置的端口一致


2：网盘穿透域名
可以修改网盘穿透域名
 方法：
	（1）用记事本打开 startDD.vbs 文件

	（2）找到 
		ws.CurrentDirectory &"/pierced-master/windows_64/ding.cfg -subdomain=znwxx 19876",0
		这里的-subdomain=znwxx 19876 中的znwxx就是内网穿透域名 可以自行更改 
	（3）内网穿透地址就是设置的 域名+"vaiwan.com"   默认设置的znwxx  可以在浏览器中输入 "znwxx.vaiwan.com"访问网盘

3：网盘的管理员账号名称以及密码
网盘的管理员账户可以添加用户以及设置用户权限等，如需自定义网盘的管理员账户密码，修改方法如下：
方法：

（1）用记事本打开  startRun.bat 文件

（2）找到 
		添加用户/首先添加管理员用户
		filebrowser.exe -d filebrowser.db users add admin 123456789... --perm.admin
		这里的 add admin 123456789...  add 后面跟着的两个就是管理员账号和管理员密码
		这里账号是 admin 密码是 123456789...
（3）如需修改为 账号是 testadmin 密码为：123456789  对应指令为
		filebrowser.exe -d filebrowser.db users add testadmin 123456789   --perm.admin

4：网盘的存放管理路径
网盘的存放管理路径是网盘文件的存放路径，可以自行设置一个空间用于存放网盘文件
方法：

（1）用记事本打开  startRun.bat 文件

（2）找到 
		默认文件位置，建议严格区分大小写
		filebrowser.exe -d filebrowser.db config set --root  ./files
		这里的 --root  ./files 其中./files 就是网盘文件存放路径 代表当前目录中的files文件夹 可自行设置文件夹目录  
# fileBrowserWin
