@TITLE Mesa3D
@cd ..\..\..\..\..\
@set PATH=%CD%\Git\bin;%CD%\Git\mingw64\bin;%CD%\Git\cmd;%PATH%
@set PLINK_PROTOCOL=ssh
@if not defined TERM set TERM=msys
@cd projects\mesa
@If NOT exist "mesa-dist-win"\ (
git clone https://github.com/pal1000/mesa-dist-win.git mesa-dist-win
@cd mesa-dist-win
)
@If exist "mesa-dist-win"\ (
@cd mesa-dist-win
)

:Choice
@ECHO. 
@echo ----------------------- 
@echo What do you want to do?
@echo -----------------------
@echo 1. Build mesa
@echo 2. Update local repository
@echo 3. Update remote repository
@echo 4. Launch GIT GUI
@echo 5. Wipe all uncommited changes
@echo 6. Insert commands manually
@echo 7. Exit
@set /p choice="Enter your Choice here:"
@if %choice%==1 GOTO Build_mesa
@if %choice%==2 GOTO Update_local
@if %choice%==3 GOTO Update_remote
@if %choice%==4 GOTO GUI
@if %choice%==5 GOTO wipe_uncommited_changes
@if %choice%==6 GOTO Command
@if %choice%==7 GOTO Exit

:Build_mesa
@set cdir=%CD%
@cd ..
@start mesa-dist-win\buildscript\build.cmd
@cd %cdir%
@GOTO Choice

:Update_local
git pull -v --progress origin
@GOTO Choice

:Update_remote
git fetch origin master
@set /p push=Update your fork (y/n):
if /I "%push%"=="y" git push -f origin master
@GOTO Choice

:GUI
git gui
@GOTO Choice

:wipe_uncommited_changes
git reset --hard
@GOTO Choice 

:Command
@start %COMSPEC%
@GOTO Choice

:Exit
exit