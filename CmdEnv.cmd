@echo off

set SelfDir=%~dp0

echo Avaliable aliases list:
echo admin      EvaluatedRun.cmd 
doskey admin=EvaluatedRun.cmd $*

echo psrun      RunPowershell.cmd
doskey psrun=RunPowershell.cmd $*

echo msb        MsBuild.cmd
doskey msb=MsBuild.cmd $*

echo cps        Copy.bat
doskey cps=Copy.bat $*

echo build      Build.cmd

echo wgs        WebDownload.cmd
doskey wgs=WebDownload.cmd $*

echo uns        Unzip.cmd
doskey uns=Unzip.cmd $*

echo addpath    AddPath.cmd

echo envs       CmdEnv.cmd
doskey envs=CmdEnv.cmd

Reg Query "HKCU\Software\Microsoft\Command Processor" /v AutoRun | findstr /I CmdEnv >nul
if %ErrorLevel% gtr 0 (
    call AddPath.cmd %SelfDir%
    Reg Add "HKCU\Software\Microsoft\Command Processor" /f /v AutoRun /t REG_SZ /d "%SelfDir%\CmdEnv.cmd
    echo "Cmd Autorun scrpit successfully added"
    pause
) else (
)
