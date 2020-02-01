@TITLE Mesa3D
@set ERRORLEVEL=0
@where /q git.exe
@IF ERRORLEVEL 1 (
@IF NOT EXIST ..\..\..\..\Git\git-cmd.exe exit
@set oldcd=%cd%
@cd ..\..\..\..\Git
@git-cmd.exe --command=%0
)
@if defined oldcd cd "%oldcd%"
@if defined oldcd set "oldcd="
@set ERRORLEVEL=0
@where /q git.exe
@IF ERRORLEVEL 1 exit
@set ERRORLEVEL=0
@cd ..\..\..\
@If NOT exist "swiftshader"\ (
git clone git clone --recurse-submodules https://swiftshader.googlesource.com/SwiftShader swiftshader
)
@If exist "swiftshader"\ (
@cd swiftshader
)

:Choice
@ECHO.
@echo -----------------------
@echo What do you want to do?
@echo -----------------------
@echo 1. Build SwiftShader
@echo 2. Update local repository
@echo 3. Update remote repository
@echo 4. Launch GIT GUI
@echo 5. Wipe all uncommited changes
@echo 6. Insert commands manually
@echo 7. Exit
@set choice=0
@set /p choice="Enter your Choice here:"
@if "%choice%"=="1" GOTO Build_swiftshader
@if "%choice%"=="2" GOTO Update_local
@if "%choice%"=="3" GOTO GUI
@if "%choice%"=="4" GOTO wipe_uncommited_changes
@if "%choice%"=="5" GOTO Command
@if "%choice%"=="6" GOTO Exit
@echo Invaild entry
@GOTO Choice

:Build_swiftshader
@start buildscript\build.cmd
@GOTO Choice

:Update_local
git pull -v --progress origin
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