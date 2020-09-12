@echo off
@cd /d "%~dp0"
@set "ERRORLEVEL="
@CMD /C EXIT 0
@"%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system" >nul 2>&1
@if NOT "%ERRORLEVEL%"=="0" (
@IF EXIST "C:\Program Files\VMware\VMware Workstation\vmware.exe" start "" "C:\Program Files\VMware\VMware Workstation\vmware.exe"
@IF EXIST "C:\Program Files (x86)\VMware\VMware Workstation\vmware.exe" start "" "C:\Program Files (x86)\VMware\VMware Workstation\vmware.exe"
@CMD /C EXIT 0
@tasklist /FI "IMAGENAME eq vmnat.exe" 2>NUL | find /I /N "vmnat.exe">NUL
@if "%ERRORLEVEL%"=="0" exit
@powershell -Command Start-Process ""%0"" -Verb runAs 2>nul
@exit
)
:--------------------------------------
net start VMAuthdService
net start VMnetDHCP
net start "VMware NAT Service"
pause

