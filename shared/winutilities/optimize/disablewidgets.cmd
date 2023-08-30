@cd /d "%~dp0"
@set "ERRORLEVEL="
@CMD /C EXIT 0
@"%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system" >nul 2>&1
@if NOT "%ERRORLEVEL%"=="0" (
@powershell -Command Start-Process ""%0"" -Verb runAs 2>nul
@exit
)
:--------------------------------------
@echo Get-AppxPackage -AllUsers ^^^| Where-Object {$_.Name -like "*WebExperience*"} ^^^| Remove-AppxPackage -AllUsers -ErrorAction SilentlyContinue | powershell -NoLogo
@cmd /c echo.
@cmd /c pause
