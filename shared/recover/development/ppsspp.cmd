@TITLE PPSSPP
@cd ..\..\..\..\..\
@set PATH=%CD%\Git\bin;%CD%\Git\mingw64\bin;%CD%\Git\cmd;%PATH%
@if not exist "%HOME%" @set HOME=%HOMEDRIVE%%HOMEPATH%
@if not exist "%HOME%" @set HOME=%USERPROFILE%

@set PLINK_PROTOCOL=ssh
@if not defined TERM set TERM=msys
@cd projects
@If NOT exist "ppsspp"\ (
git clone https://github.com/hrydgard/ppsspp.git ppsspp
@cd ppsspp
git submodule update --init --recursive
)
@If exist "ppsspp"\ (
@cd ppsspp
)
git branch work

:Choice
@ECHO. 
@echo ----------------------- 
@echo What do you want to do?
@echo -----------------------
@echo 1. Start Visual Studio
@echo 2. Update local repository
@echo 3. Update forked repository
@echo 4. Update personal build
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
@if %choice%==1 GOTO Start_VS 
@if %choice%==2 GOTO Update_local
@if %choice%==3 GOTO Update_remote
@if %choice%==4 GOTO Update_build
@if %choice%==5 GOTO GUI
@if %choice%==6 GOTO Update_submodules  
@if %choice%==7 GOTO Status
@if %choice%==8 GOTO wipe_uncommited_changes
@if %choice%==9 GOTO Wipe_local_commits
@if %choice%==10 GOTO Full_Reset
@if %choice%==11 GOTO Clean_build
@if %choice%==12 GOTO Command
@if %choice%==13 GOTO Exit
  
:Start_VS
@set /p update-ver="Update git version before building in Visual studio Y/N? "
@if %update-ver%==y @START Windows\git-version-gen.cmd ^&^& exit
@if %update-ver%==Y @START Windows\git-version-gen.cmd ^&^& exit
@Windows\PPSSPP.sln
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
git remote add upstream https://github.com/pal1000/ppsspp.git
git fetch upstream
@set /p push=Update your fork (y/n):
if /I "%push%"=="y" git push -f --all upstream
@GOTO Choice

:Update_build
RD /S /Q ..\..\..\ppsspp\assets
RD /S /Q "..\..\..\ppsspp\memstick\PSP\PPSSPP_STATE"
DEL "..\..\..\ppsspp\PPSSPPWindows64.exe"
DEL "..\..\..\ppsspp\PPSSPPWindows.exe"
DEL ..\..\..\ppsspp\memstick\PSP\SYSTEM\ppsspp.ini
XCOPY assets ..\..\..\ppsspp\assets /S /E /I /Q
copy "PPSSPPWindows64.exe" ..\..\..\ppsspp
copy "PPSSPPWindows.exe" ..\..\..\ppsspp
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
@start %COMSPEC%
@GOTO Choice

:Update_submodules
git submodule update --init --recursive
@GOTO Choice

:Exit
exit


