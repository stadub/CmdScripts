@echo off
set DirPowerShell="HKCR\Directory\shell\powershell"

set "PowershellPath=C:\\Windows\\system32\\WindowsPowerShell\\v1.0\\powershell.exe"
rem Add Explorer context menu
Reg Add %DirPowerShell% /f
Reg Add %DirPowerShell%\command /f

Reg Add %DirPowerShell% /ve /t REG_SZ /d "Open PowerShell Here" /f
Reg Add %DirPowerShell%\command /ve /t REG_SZ /d "%PowershellPath% -NoExit -Command Set-Location  '%%L'" /f

rem Add PowerShellScript "Run with PowerShell (Admin)" context menu
set Ps1Shell="HKCR\Microsoft.PowerShellScript.1\Shell"

Reg Add %Ps1Shell% /f
Reg Add %Ps1Shell%\command /f

Reg Add %Ps1Shell%\OpenBypass /ve /t REG_SZ /d "Run with PowerShell (Bypass)" /f
Reg Add %Ps1Shell%\OpenBypass\command /ve /t REG_SZ /d "%PowershellPath% -executionpolicy bypass -File  \"%%1\"}" /f

Reg Add %Ps1Shell%\OpenAdmin /ve /t REG_SZ /d "Run with PowerShell (Admin)" /f
Reg Add %Ps1Shell%\OpenAdmin\command /ve /t REG_SZ /d "%PowershellPath% -executionpolicy bypass -Command {start-Process %PowershellPath% -NoNewWindow  -Wait  -Verb RunAs -ArgumentList -ExecutionPolicy RemoteSigned -File  \"%%1\"" /f

rem Reg Add %Ps1Shell%\OpenAdmin\command /ve /t REG_SZ /d "C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe -Command 'if((Get-ExecutionPolicy ) -ne AllSigned) { Set-ExecutionPolicy -Scope Process Bypass }; & \'%%1%\''" /f