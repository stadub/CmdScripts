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

echo which       Which.cmd

doskey envs=CmdEnv.cmd  $*

FOR /f "delims=;" %%i IN ("%DoskeyScripts%") DO (	
    if exist "%%i" (
        echo Adding doskey scripts from %%i
        call "%%i"
    )
)

SET "PATH=%PATH%;%SelfDir%"
