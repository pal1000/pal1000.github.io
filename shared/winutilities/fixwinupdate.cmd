@echo off
net stop wuauserv
net stop BITS
net stop DoSvc
CD %systemroot%\SoftwareDistribution
RD Download /S /Q
MD Download
pause
