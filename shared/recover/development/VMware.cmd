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
    start "" "C:\Program Files (x86)\VMware\VMware Workstation\vmware.exe"
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    tasklist /FI "IMAGENAME eq vmnat.exe" 2>NUL | find /I /N "vmnat.exe">NUL
    if "%ERRORLEVEL%"=="0" exit
    echo Requesting administrative privileges...
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params = %*:"=""
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    EXIT /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
    :--------------------------------------
net start VMAuthdService
net start VMnetDHCP
net start "VMware NAT Service"
pause

