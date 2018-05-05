@TITLE Mesa3D
@where /q git.exe
@IF ERRORLEVEL 1 cd ..\..\..\..\
@set ERRORLEVEL=0
@where /q git.exe
@IF ERRORLEVEL 1 "%CD%\Git\git-cmd.exe" %0
@set ERRORLEVEL=0
@where /q git.exe
@IF ERRORLEVEL 1 exit
@set ERRORLEVEL=0
@cd projects
@IF NOT EXIST mesa md mesa
@cd mesa
@If NOT exist "mesa-dist-win"\ (
git clone https://github.com/pal1000/mesa-dist-win.git mesa-dist-win
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
@set choice=0
@set /p choice="Enter your Choice here:"
@if "%choice%"=="1" GOTO Build_mesa
@if "%choice%"=="2" GOTO Update_local
@if "%choice%"=="3" GOTO Update_remote
@if "%choice%"=="4" GOTO GUI
@if "%choice%"=="5" GOTO wipe_uncommited_changes
@if "%choice%"=="6" GOTO Command
@if "%choice%"=="7" GOTO Exit
@echo Invaild entry
@GOTO Choice

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
git fetch origin
@set push=n
@set /p push=Update your fork (y/n):
if /I "%push%"=="y" git push -f --all origin
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