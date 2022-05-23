::不打印命令行信息
@echo off



::设置当前路径
cd /d %~dp0

::回显当前工作目录
echo %cd%

::添加开机自启动

::copy "./startFileBrowser.vbs" "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp/startFileBrowser.vbs"

echo >"C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp/startFileBrowser.vbs"

echo set ws=WScript.CreateObject("WScript.Shell") >"C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp/startFileBrowser.vbs"

echo ws.Run "%~dp0./startRun.bat",0 >>"C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp/startFileBrowser.vbs"




:: 设置 filebrowser

::（1）创建数据库/初始化
filebrowser.exe -d filebrowser.db config init
::（2）设置监听地址，地址写内网的实际IP地址，若打不开，建议测试这里
filebrowser.exe -d filebrowser.db config set --address 0.0.0.0
::（3）设置监听端口
filebrowser.exe -d filebrowser.db config set --port 19876
::（4）设置中文语言环境
filebrowser.exe -d filebrowser.db config set --locale zh-cn
::（5）设置日志文件位置
filebrowser.exe -d filebrowser.db config set --log filebrowser.log
::（6）默认文件位置，建议严格区分大小写
filebrowser.exe -d filebrowser.db config set --root  ./files
::（7）添加用户/首先添加管理员用户
filebrowser.exe -d filebrowser.db users add admin 123456789... --perm.admin

title task进程监控

rem 定义需要监控程序的进程名和程序路径

set fileBrowserName=filebrowser.exe
set dingName=ding.exe
set taskPath=%~dp0
set path=%path%;%taskpath%
set taskDingStartPath=startDD.vbs
set taskFileStartPath=startfileBro.vbs
cls

echo.

echo task进程守护开始……

echo 

rem 定义循环体

:task_protect

rem 进程列表中查找指定进程 fileBrowserName

qprocess|findstr /i %fileBrowserName% >nul

rem 变量errorlevel的值等于0表示查找到进程，否则没有查找到进程

if %errorlevel%==0 (

echo ^>%date:~0,10% %time:~0,8% 程序正在运行……

 )else (

 echo ^>%date:~0,10% %time:~0,8% 没有发现程序进程

 echo ^>%date:~0,10% %time:~0,8% 正在重新启动程序

 start %taskPath%%taskFileStartPath% 2>nul && echo ^>%date:~0,10% %time:~0,8% 启动程序成功

 )
::等待 5秒
timeout /t 5 /nobreak > NUL
 rem 进程列表中查找指定进程 dingName

 qprocess|findstr /i %dingName% >nul

 rem 变量errorlevel的值等于0表示查找到进程，否则没有查找到进程

 if %errorlevel%==0 (

    echo ^>%date:~0,10% %time:~0,8% 程序正在运行……

  )else (

     echo ^>%date:~0,10% %time:~0,8% 没有发现程序进程

     echo ^>%date:~0,10% %time:~0,8% 正在重新启动程序

     start %taskPath%%taskDingStartPath% 2>nul && echo ^>%date:~0,10% %time:~0,8% 启动程序成功

 )

::每天杀一下ding.exe 重启ding服务
::chcp 437
schtasks /delete /tn "auto shutdown" /f

::每一分钟执行一次
schtasks /create /tn "auto shutdown" /tr "./dingkill.bat" /sc minute /mo 1

::/sc daily /st 00:00:00 每天几点执行


 rem 用ping命令来实现延时运行

 ::for /l %%i in (1,1,10) do ping -n 1 -w 1000 198.20.0.1>nul

 ping -n 10 127.0.0.1>nul

 goto task_protect

echo on
