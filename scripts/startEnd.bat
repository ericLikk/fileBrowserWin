::����ӡ��������Ϣ
@echo off
schtasks /query|findstr /c:"auto shutdown"
if %errorlevel%==0 (
	echo "���ҵ�����"
schtasks /delete /tn "auto shutdown" /f
 )
	
echo "û�в��ҵ�����"


::�ȴ� 5��
::timeout /t 5 /nobreak > NUL
taskkill /f /t /im ding.exe

::�ȴ� 5��
::timeout /t 5 /nobreak > NUL
taskkill /f /t /im filebrowser.exe

::�ȴ� 5��
::timeout /t 5 /nobreak > NUL
taskkill /f /t /im cmd.exe

pause