@echo off
Rem based on https://sites.google.com/site/eneerge/scripts/batchgotadmin
Rem GetGuid from http://stackoverflow.com/a/19729941/959779
Rem ShiftArgs http://stackoverflow.com/a/26732879/959779

SETLOCAL ENABLEDELAYEDEXPANSION
set self=%~n0
rem set program=%~f1
set program=%1

if '%program%' == '' (goto Usage)

call :ShiftArgs args %*
call :debug App "%program%" has args: "%args%"

call :ResolvePath appPath

if '%appPath%' == '' (
	echo Error: No application found >&2
	goto Usage
)

echo Executing {%appPath%}

:CheckAdmin

Rem  Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

Rem If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    call :UACPrompt %*
) else ( call :Admin )
goto :eof

:UACPrompt
	call :GetGuid NewGuid
	call :Debug  Writting script to %temp%\getadmin%NewGuid%.vbs

	set script=%temp%\getadmin%NewGuid%.vbs

	call :WriteFile 'Execute
    call :WriteFile Set UAC = CreateObject^("Shell.Application"^)
    call :WriteFile UAC.ShellExecute "%appPath%", "%args%", "", "runas", 1
	
	call :WriteFile ' Self Delete
	call :WriteFile Set fso = CreateObject("Scripting.FileSystemObject")
	call :WriteFile Set f1 = fso.GetFile("%script%")
	call :WriteFile f1.Delete

    "%script%"
goto :eof

:Admin
	%appPath% %args%
	pause
goto :eof


:ResolvePath
	call :Debug Resolving path 

	rem search in EvalRun script dir 
	if exist "%~dp0\%program%" (
		call :Debug Found in the script dir {%~dp0}
		set "%1=%~dp0%program%"
		goto :eof
	)

	FOR /f "delims=;" %%i IN ("%PATH%") DO (	
		if exist "%%i\%program%" (
			call :Debug Found in system dir "%%i"
			set "%1=%%i\%program%"
			goto :eof
		)
	)
	FOR /f "delims=;" %%i IN ("%PATH%") DO (	
		if exist "%%i\%program%.exe" (
			call :Debug Found "%program%.exe" in system dir "%%i" 
			set "%1=%%i\%program%.exe"
			goto :eof
		)
	)
	set "%1="
goto :eof

:Usage
	 echo Usage: %self% App [Args]
	 echo	Example: %self% Cmd dir c:\windows
goto :eof

:Debug
	echo ---===%*===---  >&2
goto :eof

:GetGuid
	set _guid=%computername%%date%%time%
	set _guid=%_guid:/=%
	set _guid=%_guid:.=%
	set _guid=%_guid: =%
	set _guid=%_guid:,=%
	set _guid=%_guid::=%
	set _guid=%_guid:-=%
	set %1=%_guid%
goto :eof

:ShiftArgs
	call :Debug ShiftArgs
	for /f "tokens=2,* delims= " %%a in ("%*") do set ALL_BUT_FIRST=%%b
	call :Debug Rest args "%ALL_BUT_FIRST%"
	set %1=%ALL_BUT_FIRST%
goto :eof

:WriteFile
	echo %* >>"%script%"
	rem call :Debug written %* "%script%"
goto :eof