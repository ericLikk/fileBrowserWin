::不打印命令行信息
@echo off
schtasks /query|findstr /c:"auto shutdown"
if %errorlevel%==0 (
	echo "查找到任务"
schtasks /delete /tn "auto shutdown" /f
 )
	
echo "没有查找到任务"


::等待 5秒
::timeout /t 5 /nobreak > NUL
taskkill /f /t /im ding.exe

::等待 5秒
::timeout /t 5 /nobreak > NUL
taskkill /f /t /im filebrowser.exe

::等待 5秒
::timeout /t 5 /nobreak > NUL
taskkill /f /t /im cmd.exe

pause