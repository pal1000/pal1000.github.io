@TITLE Mesa3D
@cd "%~dp0"
@set "ERRORLEVEL="
@CMD /C EXIT 0
@where /q git.exe
@if NOT "%ERRORLEVEL%"=="0" (
@IF NOT EXIST ..\..\..\..\Git\git-cmd.exe exit
@set oldcd=%cd%
@cd ..\..\..\..\Git
@git-cmd.exe --command=%0
)
@if defined oldcd cd "%oldcd%"
@if defined oldcd set "oldcd="
@CMD /C EXIT 0
@where /q git.exe
@if NOT "%ERRORLEVEL%"=="0" exit
@cd ..\..\..\
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
@echo 1. Build Mesa3D
@echo 2. Build Mesa3D (out of tree patches disabled)
@echo 3. Update local repository
@echo 4. Update remote repository
@echo 5. Launch GIT GUI
@echo 6. Wipe all uncommited changes
@echo 7. Insert commands manually
@echo 8. Exit
@set choice=0
@set /p choice="Enter your Choice here:"
@if "%choice%"=="1" GOTO Build_mesa
@if "%choice%"=="2" GOTO Build_pristine_mesa
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

:Build_pristine_mesa
@start buildscript\build.cmd disableootpatch
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