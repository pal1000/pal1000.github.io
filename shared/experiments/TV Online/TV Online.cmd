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

@FOR /F "tokens=4 delims= " %%i in ('route print  ^| find " 255.255.255.255"') do set localIp=%%i
@cd /d "%userprofile%\Desktop\TV Online\"
@set interface={a0186793-5422-4445-b943-826bcd26dba9}
@GOTO Web-filter

:Menu
@echo Select action:
@echo 1. Start Web Filter
@echo 2. Stop web Filter
@echo 3. Start Hola
@echo 4. Stop Hola
@echo 5. Exit
@set /p choice=Enter choice: 
@if %choice%==1 GOTO Web-filter
@if %choice%==2 GOTO Unrestricted
@if %choice%==3 GOTO Start-Hola
@if %choice%==4 GOTO Stop-Hola
@if %choice%==5 GOTO Exit

:Web-filter
@net start NxFilter
@REG ADD "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\%interface%" /v NameServer /t REG_SZ /d %localIp% /f
@GOTO Menu

:Unrestricted
@REG ADD "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\%interface%" /v NameServer /t REG_SZ /d "" /f
@start /d "c:\nxfilter\bin\" shutdown.bat ^&^& @exit
)
@GOTO Menu

:Start-Hola
@net start hola_svc
@net start hola_updater
@sc config hola_svc start=demand
@sc config hola_updater start=demand
@GOTO Menu

:Stop-Hola
@net stop hola_svc
@net stop hola_updater
@sc config hola_svc start=demand
@sc config hola_updater start=demand
@GOTO Menu

:Exit
exit

@if 1==0 (
-Disney Junior flash format: http://mywebtv.info/disney-junior/sursa-2
                             http://pal1000.3x.ro/tools/jwembed/index.php?media=http%3A%2F%2F178.21.120.198%3A1935%2Flive3%2F_definst_%2Fmp4%3Adisneyjr%2Fplaylist.m3u8
-Disney Channel flash format: http://mywebtv.info/disney-channel/sursa-2
                              http://pal1000.3x.ro/tools/jwembed/index.php?media=http%3A%2F%2F178.21.120.198%3A1935%2Flive3%2F_definst_%2Fmp4%3Adisney%2Fplaylist.m3u8
-Nickelodeon flash format: http://mywebtv.info/nickelodeon/sursa-2
                           http://pal1000.3x.ro/tools/jwembed/index.php?media=http%3A%2F%2F178.21.120.198%3A1935%2Flive3%2F_definst_%2Fmp4%3Anickelodeon%2Fplaylist.m3u8
                           
-Digi Online:
Disney Junior: http://82.76.40.81/digiedge2/disneyjuniorelelq/index.m3u8?is=18&src=digi-online.ro&t=00000000000000000000000000000000
               http://mywebtv.info/disney-junior/sursa-3 
               http://mywebtv.info/disney-junior/sursa-4
Disney Channel: http://82.76.40.81/digiedge2/disneychannelelq/index.m3u8?is=17&src=digi-online.ro&t=00000000000000000000000000000000
                http://mywebtv.info/disney-channel/sursa-3
                http://mywebtv.info/disney-channel/sursa-4
Nickelodeon: http://82.76.40.81/digiedge2/nickelodeonelq/index.m3u8?is=28&src=digi-online.ro&t=00000000000000000000000000000000
             http://mywebtv.info/nickelodeon/sursa-3
             http://mywebtv.info/nickelodeon/sursa-4 
Minimax: http://82.76.40.81/digiedge2/minimaxelq/index.m3u8?is=37&src=digi-online.ro&t=00000000000000000000000000000000
         http://mywebtv.info/minimax/sursa-2
         http://mywebtv.info/minimax/sursa-5
Megamax: http://82.76.40.81/digiedge2/meganaxelq/index.m3u8?is=47&src=digi-online.ro&t=00000000000000000000000000000000
         http://mywebtv.info/megamax/sursa-2
         http://mywebtv.info/megamax/sursa-3
         http://mywebtv.info/megamax/sursa-4

-Sopcast: Coolitv.net, mywebtv.info, cool-etv.net                       
)

