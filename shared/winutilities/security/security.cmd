@echo off
@cd /d "%~dp0"
@set "ERRORLEVEL="
@CMD /C EXIT 0
@"%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system" >nul 2>&1
@if NOT "%ERRORLEVEL%"=="0" (
@powershell -Command Start-Process ""%0"" -Verb runAs 2>nul
@exit
)
:--------------------------------------
@netsh interface teredo set state disabled
@netsh interface isatap set state disabled
@netsh winhttp reset proxy
@net stop iphlpsvc
@sc config iphlpsvc start= disabled
@net stop WinHttpAutoProxySvc
@sc config WinHttpAutoProxySvc start= disabled
@sc config dmwappushservice start= disabled
@net stop dmwappushservice
@sc config SSDPSRV start= disabled
@net stop SSDPSRV
@sc config fdPHost start= disabled
@net stop fdPHost
@net stop LanmanWorkstation
@sc config LanmanWorkstation start= disabled
@pause



