@echo off

echo "Pack %AppName%"

set Self=%~n0
set SelfDir=%~dp0

call Config.cmd %Self%

mkdir %SrcDir%\Install
cd %SrcDir%\Install

rem copy install script to the src folder

copy %SelfDir%\Copy.bat %SrcDir%

echo creating SXF archive into %SrcDir%
%SelfDir%\Bin\7zr.exe a Installer.7z "%SrcDir%\*"



rem to avoid problems with whitespace symbols in the path
for %%f in ("%DestDir%") do set DestDir8=%%~sf

echo %DestDir8%

echo %CD%
echo Writing Installer config
echo ;!@Install@!UTF-8!> 7zConfig
echo Title="%Title%">> 7zConfig
echo BeginPrompt="%BeginPrompt%" >> 7zConfig
echo RunProgram="Copy.bat %DestDir8%" >> 7zConfig
echo ;!@InstallEnd@!>> 7zConfig

copy /b %SelfDir%\Bin\7zS.sfx + 7zConfig + Installer.7z %AppName%.exe

move %SrcDir%\Install\%AppName%.exe %SrcDir%\

cd %SelfDir%

rmdir %SrcDir%\Install /S /Q 

pause