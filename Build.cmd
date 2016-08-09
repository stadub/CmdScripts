@echo off

echo "Pack %AppName%"
echo '                                                                    '

set Self=%~n0
set SelfDir=%~dp0

set AppName=%1

IF "x%AppName%" == "x" (
    call :CreateConfig
	exit /b
)

call Config.cmd %Self%_%AppName%

del %SrcDir%\%AppName%.exe

mkdir %SrcDir%\Install
cd %SrcDir%\Install

rem copy install script to the src folder

copy %SelfDir%\Copy.bat %SrcDir%

rem echo creating SXF archive into %SrcDir%
%SelfDir%\Bin\7zr.exe a Installer.7z "%SrcDir%\*"


rem to avoid problems with whitespace symbols in the path
for %%f in ("%DestDir%") do set DestDir8=%%~sf

rem echo %DestDir8%

echo %CD%
echo Writing Installer config
echo ;!@Install@!UTF-8!> 7zConfig
echo Title="%AppName%">> 7zConfig
echo BeginPrompt="%BeginPrompt%" >> 7zConfig
echo RunProgram="Copy.bat %DestDir8%" >> 7zConfig
echo ;!@InstallEnd@!>> 7zConfig

copy /b %SelfDir%\Bin\7zS.sfx + 7zConfig + Installer.7z %AppName%.exe

del %SrcDir%\Copy.bat

move %SrcDir%\Install\%AppName%.exe %SrcDir%\

cd %SelfDir%

rmdir %SrcDir%\Install /S /Q 

echo '                                                                    '   
echo '                                                                    '   
echo '                                                                    '   
echo '                                                                    '   
echo '                     Installer successfully generated:              '   
echo %SrcDir%\%AppName%.exe
pause
exit /b

:CreateConfig
    rem echo Creating new build configuration
    
    set /p AppName= Enter Application name:
	echo "%AppName%"
    set ScriptName=Build_%AppName%

    echo '                                                                    '   
    echo Starting installer configuration for %AppName%
	
	rem Create run script
    echo %SelfDir%\Build.cmd %AppName% > %SelfDir%\Build_%AppName%.cmd
	
    rem echo %ScriptName%
    copy %SelfDir%\BuildBase.config  %SelfDir%\%ScriptName%.config
    call Config.cmd %ScriptName%

    echo '                                                                    '   
    echo '                                                                    '   
    echo Application installer script generated successfully.
    echo Use "%SelfDir%\%ScriptName%.cmd" to start installer script.
    pause
    exit /b
goto :EOF
