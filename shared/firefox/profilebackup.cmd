:firefoxrunning
@set ffprocs=0
@for /f eol^= %%a in ('tasklist /FI "IMAGENAME eq firefox.exe" /NH 2^>nul') DO @IF /I %%a==firefox.exe set /a ffprocs+=1
@if %ffprocs% GTR 0 (
@echo Error: Firefox is still running. Retrying in 5 seconds.
@timeout /t 5 /NOBREAK > nul 2>&1
@cls
)
@if %ffprocs% GTR 0 GOTO firefoxrunning

@set nogit=0
@set ERRORLEVEL=
@cmd /C EXIT 0
@where /q git.exe
@IF NOT "%ERRORLEVEL%"=="0" set nogit=1
@cd "%~dp0"
@cd ..\..\..
@if %nogit% EQU 1 IF NOT EXIST "pal1000-private\" (
@echo Fatal: Cannot obtain pal1000 repository.
@GOTO exit
)
@if %nogit% EQU 0 IF NOT EXIST "pal1000-private\" (
@git clone https://github.com/pal1000/pal1000-private.git
@echo.
)
@if %nogit% EQU 0 IF NOT EXIST "pal1000-private\" (
@echo Fatal: Cannot obtain pal1000 repository.
@GOTO exit
)
@cd pal1000-private\firefox

@for /f delims^=^ eol^= %%a in ('dir /b /a^:d "%AppData%\Mozilla\Firefox\Profiles\*" 2^>^&1') do @IF EXIST "%AppData%\Mozilla\Firefox\Profiles\%%~nxa\places.sqlite" set profiledir="%AppData%\Mozilla\Firefox\Profiles\%%~nxa"
@set profiledir=%profiledir:~1,-1%
@echo Begin backup...
@IF EXIST "%profiledir%\favicons.sqlite" copy /Y "%profiledir%\favicons.sqlite" .
@IF EXIST "%profiledir%\key4.db" copy /Y "%profiledir%\key4.db" .
@IF EXIST "%profiledir%\logins.json" copy /Y "%profiledir%\logins.json" .
@IF EXIST "%profiledir%\places.sqlite" copy /Y "%profiledir%\places.sqlite" .
@IF EXIST "%profiledir%\sessionstore.jsonlz4" copy /Y "%profiledir%\sessionstore.jsonlz4" .
@echo Done.
@cd ..
@if %nogit% EQU 0 git add firefox/*.*
@if %nogit% EQU 0 IF EXIST firefox/*.csv git reset firefox/*.csv
@if %nogit% EQU 0 For /f "tokens=1-3 delims=/ " %%a in ('date /t') do @For /f "tokens=1-2 delims=/:" %%d in ('time /t') do @git commit -m "Backup %%a-%%b-%%c_%%d%%e"
@if %nogit% EQU 0 git push origin master

:exit
@timeout /t 10 > nul 2>&1