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
@netsh advfirewall firewall add rule name="RPC TCP" protocol=TCP dir=out localport=135 action=block enable=yes
@netsh advfirewall firewall add rule name="RPC UDP" protocol=UDP dir=out localport=135 action=block enable=yes
@netsh advfirewall firewall add rule name="NetBIOS NS TCP" protocol=TCP dir=out localport=137 action=block enable=yes
@netsh advfirewall firewall add rule name="NetBIOS NS UDP" protocol=UDP dir=out localport=137 action=block enable=yes
@netsh advfirewall firewall add rule name="NetBIOS DS TCP" protocol=TCP dir=out localport=138 action=block enable=yes
@netsh advfirewall firewall add rule name="NetBIOS DS UDP" protocol=UDP dir=out localport=138 action=block enable=yes
@netsh advfirewall firewall add rule name="NetBIOS SS TCP" protocol=TCP dir=out localport=139 action=block enable=yes
@netsh advfirewall firewall add rule name="NetBIOS SS UDP" protocol=UDP dir=out localport=139 action=block enable=yes
@netsh advfirewall firewall add rule name="Microsoft DS TCP" protocol=TCP dir=out localport=445 action=block enable=yes
@netsh advfirewall firewall add rule name="Microsoft DS UDP" protocol=UDP dir=out localport=445 action=block enable=yes
@pause



