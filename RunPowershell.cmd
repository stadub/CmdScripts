@echo off
set "PowershellPath=C:\\Windows\\system32\\WindowsPowerShell\\v1.0\\powershell.exe"
%PowershellPath% -executionpolicy bypass "%1"
