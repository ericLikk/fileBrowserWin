::����ӡ��������Ϣ
@echo off



::���õ�ǰ·��
cd /d %~dp0

::���Ե�ǰ����Ŀ¼
echo %cd%

::��ӿ���������

::copy "./startFileBrowser.vbs" "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp/startFileBrowser.vbs"

echo >"C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp/startFileBrowser.vbs"

echo set ws=WScript.CreateObject("WScript.Shell") >"C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp/startFileBrowser.vbs"

echo ws.Run "%~dp0./startRun.bat",0 >>"C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp/startFileBrowser.vbs"




:: ���� filebrowser

::��1���������ݿ�/��ʼ��
filebrowser.exe -d filebrowser.db config init
::��2�����ü�����ַ����ַд������ʵ��IP��ַ�����򲻿��������������
filebrowser.exe -d filebrowser.db config set --address 0.0.0.0
::��3�����ü����˿�
filebrowser.exe -d filebrowser.db config set --port 19876
::��4�������������Ի���
filebrowser.exe -d filebrowser.db config set --locale zh-cn
::��5��������־�ļ�λ��
filebrowser.exe -d filebrowser.db config set --log filebrowser.log
::��6��Ĭ���ļ�λ�ã������ϸ����ִ�Сд
filebrowser.exe -d filebrowser.db config set --root  ./files
::��7������û�/������ӹ���Ա�û�
filebrowser.exe -d filebrowser.db users add admin 123456789... --perm.admin

title task���̼��

rem ������Ҫ��س���Ľ������ͳ���·��

set fileBrowserName=filebrowser.exe
set dingName=ding.exe
set taskPath=%~dp0
set path=%path%;%taskpath%
set taskDingStartPath=startDD.vbs
set taskFileStartPath=startfileBro.vbs
cls

echo.

echo task�����ػ���ʼ����

echo 

rem ����ѭ����

:task_protect

rem �����б��в���ָ������ fileBrowserName

qprocess|findstr /i %fileBrowserName% >nul

rem ����errorlevel��ֵ����0��ʾ���ҵ����̣�����û�в��ҵ�����

if %errorlevel%==0 (

echo ^>%date:~0,10% %time:~0,8% �����������С���

 )else (

 echo ^>%date:~0,10% %time:~0,8% û�з��ֳ������

 echo ^>%date:~0,10% %time:~0,8% ����������������

 start %taskPath%%taskFileStartPath% 2>nul && echo ^>%date:~0,10% %time:~0,8% ��������ɹ�

 )
::�ȴ� 5��
timeout /t 5 /nobreak > NUL
 rem �����б��в���ָ������ dingName

 qprocess|findstr /i %dingName% >nul

 rem ����errorlevel��ֵ����0��ʾ���ҵ����̣�����û�в��ҵ�����

 if %errorlevel%==0 (

    echo ^>%date:~0,10% %time:~0,8% �����������С���

  )else (

     echo ^>%date:~0,10% %time:~0,8% û�з��ֳ������

     echo ^>%date:~0,10% %time:~0,8% ����������������

     start %taskPath%%taskDingStartPath% 2>nul && echo ^>%date:~0,10% %time:~0,8% ��������ɹ�

 )

::ÿ��ɱһ��ding.exe ����ding����
::chcp 437
schtasks /delete /tn "auto shutdown" /f

::ÿһ����ִ��һ��
schtasks /create /tn "auto shutdown" /tr "./dingkill.bat" /sc minute /mo 1

::/sc daily /st 00:00:00 ÿ�켸��ִ��


 rem ��ping������ʵ����ʱ����

 ::for /l %%i in (1,1,10) do ping -n 1 -w 1000 198.20.0.1>nul

 ping -n 10 127.0.0.1>nul

 goto task_protect

echo on
