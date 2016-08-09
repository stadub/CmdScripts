@echo off

set Self=%1

rem echo Configure %Self% scrpit

call :InitVars

rem echo %Init%
IF "x%Init%" == "xFalse" (
	rem del %Self%.config.new
	call :InitConfig
	call :InitVars
	rem %SrcDir%
)
goto :EOF


:InitVars 
set "input="
for /f "delims== tokens=1,2" %%a in (%Self%.config) do (
	rem ignore comments that starts with '#'
	if Not "%variable:~0,1%"=="#" (
		call :SetVar %%a %%b
	)
)
goto :EOF

:SetVar 
	rem echo Setting var %1 %2
	set value=%~2
	set %1=%value%
goto :EOF

:WriteVar
	rem echo Write variable %1="%2"
	echo %1="%2">> %Self%.config.new
	set %1=%2
goto :EOF

:InitVar
	echo '                                                                    '   
	echo '                                                                    '   
	set /p input=Enter value for %1:
	rem echo Write variable %1="%input%"
	echo %1="%input%">> %Self%.config.new
goto :EOF

:InitConfig

for /f "delims== tokens=1,2" %%a in (%Self%.config) do (
	rem replace init flag
	if "%%a"=="Init" (
		call :WriteVar Init True
	) else (
		rem copy comments that starts with '#'
		if "x%%a:~0,1%"=="x#" (
			call :WriteVar %%a %%b
		) else (
			setlocal enabledelayedexpansion
			call :InitVar %%a
		)
	)
)
move %Self%.config %Self%.config.back
move %Self%.config.new %Self%.config
goto :EOF
