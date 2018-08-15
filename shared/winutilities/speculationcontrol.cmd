@echo off

:: BatchGotAdmin
:-------------------------------------
REM  --> Check for permissions
    IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) ELSE (
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Install-PackageProvider -Name nuget > temp.txt
    echo Install-Module -Name SpeculationControl >> temp.txt
    echo $SaveExecutionPolicy = Get-ExecutionPolicy >> temp.txt
    echo Set-ExecutionPolicy RemoteSigned -Scope Currentuser >> temp.txt
    echo Import-Module SpeculationControl >> temp.txt
    echo Get-SpeculationControlSettings >> temp.txt
    echo Set-ExecutionPolicy $SaveExecutionPolicy -Scope Currentuser >> temp.txt
    echo UnInstall-Module -Name SpeculationControl >> temp.txt
    echo exit >> temp.txt
    echo. >> temp.txt
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params = %*:"=""
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
:--------------------------------------
@IF EXIST "%ProgramFiles%\PackageManagement\ProviderAssemblies\nuget" RD /S /Q "%ProgramFiles%\PackageManagement\ProviderAssemblies\nuget"
@powershell
@IF EXIST "%ProgramFiles%\PackageManagement\ProviderAssemblies\nuget" RD /S /Q "%ProgramFiles%\PackageManagement\ProviderAssemblies\nuget"
@pause