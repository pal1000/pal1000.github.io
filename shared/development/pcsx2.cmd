@TITLE PCSX2
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
@If NOT exist "pcsx2"\ (
git clone https://github.com/pcsx2/pcsx2.git pcsx2
@cd pcsx2
git submodule update --init --recursive
@cd ..
)
@If exist "pcsx2"\ (
@cd pcsx2
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
@echo 4. Launch GIT GUI
@echo 5. Update submodules
@echo 6. View repository status
@echo 7. Wipe all uncommited changes
@echo 8. Wipe all local commits and their effects
@echo 9. Fully reset local repository
@echo 10. Clean build and untracked files and folders
@echo 11. Insert commands manually
@echo 12. Exit
@set choice=0
@set /p choice="Enter your Choice here:"
@if "%choice%"=="1" GOTO Start_VS
@if "%choice%"=="2" GOTO Update_local
@if "%choice%"=="3" GOTO Update_remote
@if "%choice%"=="4" GOTO GUI
@if "%choice%"=="5" GOTO Update_submodules
@if "%choice%"=="6" GOTO Status
@if "%choice%"=="7" GOTO wipe_uncommited_changes
@if "%choice%"=="8" GOTO Wipe_local_commits
@if "%choice%"=="9" GOTO Full_Reset
@if "%choice%"=="10" GOTO Clean_build
@if "%choice%"=="11" GOTO Command
@if "%choice%"=="12" GOTO Exit
@echo Invaild entry
@GOTO Choice

:Start_VS
@del pcsx2\windows\VCprojects\svnrev.h
@if NOT EXIST bin\inis echo RunWizard=1 > bin\portable.ini
@PCSX2_suite.sln
@rem old_plugins.sln
@GOTO Choice

:Update_local
@if NOT EXIST bin\inis git checkout bin\portable.ini
git checkout master
git pull -v --progress "origin"
git submodule update --init --recursive
git branch work
git checkout work
git rebase master
@if NOT EXIST bin\inis echo RunWizard=1 > bin\portable.ini
@echo Update completed.
@GOTO Choice

:Update_remote
git remote add upstream https://github.com/pal1000/pcsx2.git
git fetch upstream
@set push=n
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
@start %COMSPEC%
@GOTO Choice

:Update_submodules
@git submodule update --init --recursive
@GOTO Choice

:Exit
exit
