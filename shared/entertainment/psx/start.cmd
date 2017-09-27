@echo off
:Start
@echo.
@echo Choose a game
@echo 1. Final Fantasy IX
@echo 2. Exit
@SET /p choice=Game chosen:
@if %choice%==1 (
@cd isos
@regedit ff9.reg
@cd ..
@epsxe
@GOTO Start
)
@if %choice%==2 GOTO Exit
:Exit
exit
