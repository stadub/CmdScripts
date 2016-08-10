@echo off
Reg Query "HKCU\Software\Microsoft\Command Processor" /v AutoRun | findstr /I CmdEnv >nul
if %ErrorLevel% gtr 0 (
    echo Add Cmd AutoRun
    rem call AddPath.cmd %SelfDir%
    Reg Add "HKCU\Software\Microsoft\Command Processor" /f /v AutoRun /t REG_SZ /d "%SelfDir%\CmdEnv.cmd
    echo "Cmd Autorun scrpit successfully added"
    pause
)

echo Add DoskeyScripts env variable
Reg Add HKCU\Environment /v DoskeyScripts /t REG_SZ /d " "
