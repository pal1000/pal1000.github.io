@echo off
@cd /d "%~dp0"
@set "ERRORLEVEL="
@CMD /C EXIT 0
@"%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system" >nul 2>&1
@if NOT "%ERRORLEVEL%"=="0" (
@powershell -Command Start-Process ""%0"" -Verb runAs 2>nul
@exit
)
@IF EXIST "%ProgramFiles% (x86)\Malwarebytes Anti-Exploit\" RD /S /Q "%ProgramFiles% (x86)\Malwarebytes Anti-Exploit"
@IF EXIST "%ALLUSERSPROFILE%\Malwarebytes Anti-Exploit\" RD /S /Q "%ALLUSERSPROFILE%\Malwarebytes Anti-Exploit"
@REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Malwarebytes Anti-Exploit" /f