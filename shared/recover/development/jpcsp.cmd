@TITLE Jpcsp
@cd ..\..\..\..\..\
@set PATH=%CD%\Git\bin;%CD%\Git\mingw64\bin;%CD%\Git\cmd;%CD%\..\Java\JDK\bin;%ProgramFiles%\Java\JDK\bin;%CD%\..\7-ZipPortable\App\64;%PATH%
@if not exist "%HOME%" @set HOME=%HOMEDRIVE%%HOMEPATH%
@if not exist "%HOME%" @set HOME=%USERPROFILE%

@set PLINK_PROTOCOL=ssh
@if not defined TERM set TERM=msys
@cd projects
@If NOT exist "jpcsp"\ (
git clone https://github.com/jpcsp/jpcsp.git jpcsp
@cd jpcsp
git submodule update --init --recursive
)
@If exist "jpcsp"\ (
@cd jpcsp
)
git branch work

@set netbeanspath=..\..\..\
@if not exist %netbeanspath%netbeans @set netbeanspath=C:\Progra~1\

:Choice
@echo.
@echo ----------------------- 
@echo What do you want to do?
@echo -----------------------
@echo 1. Start NetBeans
@echo 2. Build project
@echo 3. Update local repository
@echo 4. Update forked repository
@echo 5. Launch GIT GUI
@echo 6. Update submodules
@echo 7. View repository status
@echo 8. Wipe all uncommited changes
@echo 9. Wipe all local commits and their effects
@echo 10. Fully reset local repository
@echo 11. Clean build and untracked files and folders
@echo 12. Insert commands manually
@echo 13. Exit

@set /p choice="Enter your Choice here:"
@if %choice%==1 GOTO Start_NetBeans 
@if %choice%==2 GOTO Build
@if %choice%==3 GOTO Update_local
@if %choice%==4 GOTO Update_remote
@if %choice%==5 GOTO GUI
@if %choice%==6 GOTO Update_submodules  
@if %choice%==7 GOTO Status
@if %choice%==8 GOTO wipe_uncommited_changes
@if %choice%==9 GOTO Wipe_local_commits
@if %choice%==10 GOTO Full_Reset
@if %choice%==11 GOTO Clean_build
@if %choice%==12 GOTO Command
@if %choice%==13 GOTO Exit


:Start_NetBeans
@%netbeanspath%netbeans\bin\netbeans64.exe
@GOTO Choice

:Build
@copy dist\jpcsp-windows-amd64\Settings.properties .
@RD /S /Q bin
@RD /S /Q ms0\PSP\SAVEDATA
@RD /S /Q dist\jpcsp-windows-amd64\ms0\PSP\SAVEDATA
@start %netbeanspath%netbeans\extide\ant\bin\ant -f build-auto.xml dist-windows-amd64 ^&^& del dist\*.7z ^&^& mklink /J dist\jpcsp-windows-amd64\ms0\PSP\SAVEDATA ..\..\..\ppsspp\memstick\PSP\SAVEDATA ^&^& copy Settings.properties dist\jpcsp-windows-amd64 ^&^& pause ^&^& exit
@GOTO Choice

:Update_local
git checkout master
git pull -v --progress "origin"
git submodule update --init --recursive
git branch work
git checkout work
git rebase master
@echo Update completed.
@GOTO Choice

:Update_remote
git remote add upstream https://github.com/pal1000/jpcsp.git
git fetch upstream
@set /p push=Update your fork (y/n):
if /I "%push%"=="y" git push -f --all upstream
@GOTO Choice

:GUI
@git gui
@GOTO Choice

:Status
@git status
@GOTO Choice

:wipe_uncommited_changes
git reset --hard
git submodule foreach --recursive git reset --hard
@GOTO Choice 

:Wipe_local_commits
git checkout master
git branch -D work
git branch work
git checkout work
@GOTO Choice

:Full_Reset
git reset --hard
git submodule foreach --recursive git reset --hard
git checkout master
git branch -D work
git branch work
git checkout work
@GOTO Choice

:Clean_build
git clean -d -f -x
@GOTO Choice

:Command
start %COMSPEC%
@GOTO Choice

:Update_submodules
git submodule update --init --recursive
@GOTO Choice

:Exit
exit