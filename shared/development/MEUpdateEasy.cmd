@TITLE MEUpdateEasy
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
@If NOT exist "MEUpdateEasy"\ (
git clone https://github.com/pal1000/MEUpdateEasy.git MEUpdateEasy
)
@If exist "MEUpdateEasy"\ (
@cd MEUpdateEasy
)

:Choice
@ECHO. 
@echo ----------------------- 
@echo What do you want to do?
@echo -----------------------
@echo 1. Update local repository
@echo 2. Update remote repository
@echo 3. Launch GIT GUI
@echo 4. Wipe all uncommited changes
@echo 5. Insert commands manually
@echo 6. Exit
@set choice=0
@set /p choice="Enter your Choice here:"
@if "%choice%"=="1" GOTO Update_local
@if "%choice%"=="2" GOTO Update_remote
@if "%choice%"=="3" GOTO GUI
@if "%choice%"=="4" GOTO wipe_uncommited_changes
@if "%choice%"=="5" GOTO Command
@if "%choice%"=="6" GOTO Exit
@echo Invaild entry
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