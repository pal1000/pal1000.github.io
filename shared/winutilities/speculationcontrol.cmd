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
@IF EXIST "%ProgramFiles%\PackageManagement\ProviderAssemblies\nuget" RD /S /Q "%ProgramFiles%\PackageManagement\ProviderAssemblies\nuget"
(
@echo Install-PackageProvider -Name nuget
@echo Y
@echo Install-Module -Name SpeculationControl
@echo Y
@echo $SaveExecutionPolicy = Get-ExecutionPolicy -Scope CurrentUser
@echo Set-ExecutionPolicy Bypass -Scope CurrentUser
@echo Import-Module SpeculationControl
@echo Get-SpeculationControlSettings
@echo Set-ExecutionPolicy $SaveExecutionPolicy -Scope CurrentUser
@echo UnInstall-Module -Name SpeculationControl
) | powershell
@IF EXIST "%ProgramFiles%\PackageManagement\ProviderAssemblies\nuget" RD /S /Q "%ProgramFiles%\PackageManagement\ProviderAssemblies\nuget"
@pause