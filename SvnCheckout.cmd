@echo off
setlocal enablecelayedexpansion

for /f "delims== tokens=1,2" %%a in (SvnCheckout.cfg) do (
	rem ignore comments that starts with '#'
	if Not "%variable:~0,1%"=="#" (
		call :SetVar %%a %%b
	)
)

set "DestDir=%USERPROFILE%\Documents\Sources"

echo ==============Connecting to %Connection% network...==============
rasdial %Connection% %UserName% %Pass%

rem wait for 5 sec(get Ip/ receive routes)
ping 127.0.0.1 -n 5 > NUL 

echo "============================" > buildResults.log

call :Checkout "%comon_Path%" "%repoDir%/%comon_Name%/trunk"
call :Build "%comon_Path%" %comon_Name%

for %%i in %Repos% do (
	call :Checkout "%DestDir%\%%i" "%repoDir%/%%i/trunk"
	call :Build "%DestDir%\%%i" %%i
)

echo ==============Disconnecting...==============
rasdial %Connection% /DISCONNECT
type buildResults.log
pause
goto :EOF

:Checkout 
	set DestPath=%1
	set DestPath=%DestPath:"=%
	set RepoPath=%2
	IF EXIST %DestPath% (
		%cd%\bin\svn.exe update %DestPath%
	) ELSE (
		mkdir %DestPath%
		if NOT "%DestPath%"=="%comon_Path%" mklink /d %DestPath%\common %comon_Path%
		%cd%\bin\svn.exe checkout %RepoPath% %DestPath%
		
	)
goto :EOF
	
:Build
set baseDir=%cd%
	pushd %1
	cd qvx*
	for /R "%cd%" %%G in (**.sln) do (
		echo ==============Building Release %%G==============
		"C:\Program Files (x86)\Microsoft Visual Studio 12.0\Common7\IDE\devenv" /nologo "%%G" /rebuild Release > buildRelease.log
		echo %ERRORLEVEL% %%G Release >> %baseDir%/buildResults.log
		echo ==============Building Debug %%G==============
		"C:\Program Files (x86)\Microsoft Visual Studio 12.0\Common7\IDE\devenv" /nologo "%%G" /rebuild Debug > buildDebug.log
		echo %ERRORLEVEL% %%G Debug >> %baseDir%/buildResults.log
	)
	popd
goto :EOF

:SetVar 
	set %1=%2
goto :EOF