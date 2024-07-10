@echo off
@cd /d "%~dp0"
@set "ERRORLEVEL="
@CMD /C EXIT 0
@"%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system" >nul 2>&1
@if NOT "%ERRORLEVEL%"=="0" (
@IF EXIST "%APPDATA%\Mozilla\" RD /S /Q "%APPDATA%\Mozilla"
@IF EXIST "%LOCALAPPDATA%\Mozilla\" RD /S /Q "%LOCALAPPDATA%\Mozilla"
@IF EXIST "%LOCALAPPDATA%Low\Mozilla\" RD /S /Q "%LOCALAPPDATA%Low\Mozilla"
@powershell -Command Start-Process ""%0"" -Verb runAs 2>nul
@exit
)
@IF EXIST "%ProgramFiles%\Mozilla Firefox\" RD /S /Q "%ProgramFiles%\Mozilla Firefox"
@for /f delims^=^ eol^= %%a in ('dir /b /a^:d "%ALLUSERSPROFILE%\Mozill*" 2^>^&1') do @IF EXIST "%ALLUSERSPROFILE%\%%~nxa\" RD /S /Q "%ALLUSERSPROFILE%\%%~nxa"
@IF EXIST "%APPDATA%\Mozilla\" RD /S /Q "%APPDATA%\Mozilla"
@IF EXIST "%LOCALAPPDATA%\Mozilla\" RD /S /Q "%LOCALAPPDATA%\Mozilla"
@IF EXIST "%LOCALAPPDATA%Low\Mozilla\" RD /S /Q "%LOCALAPPDATA%Low\Mozilla"
@pause