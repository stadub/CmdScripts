
rem Add Explorer context menu
Reg Add HKCR \Directory\shell\powershell /f
Reg Add HKCR \Directory\shell\powershell\command /f

Reg Add HKCR\Directory\shell\powershell /ve /t REG_SZ /d "Open PowerShell Here" /f
Reg Add HKCR\Directory\shell\powershell\command /ve /t REG_SZ /d "C:\\Windows\\system32\\WindowsPowerShell\\v1.0\\powershell.exe -NoExit -Command Set-Location  '%%L'" /f