@TITLE Save Legacy Intel OpenGL
@cd ..\..\..\..\
@set PATH=%CD%\Git\bin;%CD%\Git\mingw64\bin;%CD%\Git\cmd;%PATH%
@set PLINK_PROTOCOL=ssh
@if not defined TERM set TERM=msys
@cd projects
@If NOT exist "save-legacy-intel-opengl"\ (
git clone https://github.com/pal1000/save-legacy-intel-opengl.git save-legacy-intel-opengl
)
@If exist "save-legacy-intel-opengl"\ (
@cd save-legacy-intel-opengl
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
@set /p choice="Enter your Choice here:"
@if %choice%==1 GOTO Update_local
@if %choice%==2 GOTO Update_remote
@if %choice%==3 GOTO GUI
@if %choice%==4 GOTO wipe_uncommited_changes
@if %choice%==5 GOTO Command
@if %choice%==6 GOTO Exit

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