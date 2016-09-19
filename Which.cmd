@echo off
rem  set DEBUG=1
set self=%~n0
rem set program=%~f1
set program=%1
set envVarName=%2

if '%program%' == '' (goto Usage)

rem in case standalone mode iterate all variables
if '%2' == '' (
	set iterateAll="True"
)



call :Debug Search for file in the current folder
call :CheckExistInFolder %program% "%CD%"
if %ERRORLEVEL% EQU 1 (
	if '%iterateAll%' == '' (goto :eof)
)


call :Debug Search in EvalRun script dir 
call :CheckExistInFolder %program% "%~dp0"
if %ERRORLEVEL% EQU 1 (
	if '%iterateAll%' == '' (goto :eof)
)

	
call :Debug Search in the folders from the PATH env varibale
setlocal EnableDelayedExpansion
set LF=^


rem ** Two empty lines required
FOR /F "delims=" %%i in ("%path:;=!LF!%") do (
	call :CheckExistInFolder %program% "%%i"
	if %ERRORLEVEL% EQU 1 (
		if '%iterateAll%' == '' (goto :eof)
	)
)
endlocal EnableDelayedExpansion
goto :eof


	

:CheckExistInFolder
	set "file=%1"
	set "folder=%2"
	set folder=%folder:"=%

	if exist "%folder%\%file%.exe" (
		call :Debug [%file%.exe]:Found in the dir "%folder%"

		call :SetVar %envVarName% "%folder%\%file%.exe"
		call :ShowResult "%folder%\%file%.exe" (
		set ERRORLEVEL=1
		if not '%iterateAll%' == '' (goto :eof)
	)
	
	if exist "%folder%\%file%" (
		rem make sure it's not folder 
		If Not exist "%folder%\%file%\NUL" (		
			call :Debug [%file%]:Found in the dir "%folder%"
			
			call :SetVar %envVarName% "%folder%\%file%"
			call :ShowResult "%folder%\%file%"
			set ERRORLEVEL=1
			if not '%iterateAll%' == '' (goto :eof)
		)
	)
	if exist "%folder%\%file%.cmd" (		
		call :Debug [%file%.cmd]:Found in the dir "%folder%"

		call :SetVar %envVarName% "%folder%\%file%.cmd"
		call :ShowResult "%folder%\%file%.cmd"
		set ERRORLEVEL=1
		if not '%iterateAll%' == '' (goto :eof)
	)

	if exist "%folder%\%file%.bat" (
		call :Debug [%file%.bat]:Found in the dir "%folder%"

		call :SetVar %envVarName% "%folder%\%file%.bat"
		call :ShowResult "%folder%\%file%.bat"
		set ERRORLEVEL=1
		if not '%iterateAll%' == 'True' (goto :eof)
	)

	set ERRORLEVEL=0
goto :eof

:Usage
	 echo Usage: %self% App [Args]
	 echo	Example: %self% Cmd dir c:\windows
goto :eof

:Debug
	if '%DEBUG%' == '' (goto :eof)	
	echo ---===%*===---  >&2
goto :eof


:SetVar 
	rem set variable only when it exist( method has 2 parameters: 1-var name, 2- var value)
	if '%2' == '' (goto :eof)	
	rem echo Setting var %1 %2
	
	set value=%~2
	set value=%value:"=%
	set "%1=%value%"
	echo "%value%"
goto :eof

rem show result only when envVarName variable is empty(standalone run mode)
:ShowResult
	set "appPath=%1"
	set "appPath=%appPath:"=%"
	if '%1' == '' (echo '%program%':No application  found >&2)	
	if '%envVarName%' == '' (
		echo "%appPath%"
	)
goto :eof