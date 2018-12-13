@TITLE Mesa3D
@where /q git.exe
@IF ERRORLEVEL 1 cd ..\..\..\..\
@set ERRORLEVEL=0
@where /q git.exe
@IF ERRORLEVEL 1 "%CD%\Git\git-cmd.exe" --command=%0
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
@echo 1. Build Mesa3D (normal mode)
@echo 2. Build Mesa3D (experimental Meson support)
@echo 3. Update local repository
@echo 4. Update remote repository
@echo 5. Launch GIT GUI
@echo 6. Wipe all uncommited changes
@echo 7. Insert commands manually
@echo 8. Exit
@set choice=0
@set /p choice="Enter your Choice here:"
@if "%choice%"=="1" GOTO Build_mesa
@if "%choice%"=="2" GOTO experimental
@if "%choice%"=="3" GOTO Update_local
@if "%choice%"=="4" GOTO Update_remote
@if "%choice%"=="5" GOTO GUI
@if "%choice%"=="6" GOTO wipe_uncommited_changes
@if "%choice%"=="7" GOTO Command
@if "%choice%"=="8" GOTO Exit
@echo Invaild entry
@GOTO Choice

:Build_mesa
@start buildscript\build.cmd
@GOTO Choice

:experimental
@start buildscript\build.cmd /enablemeson
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