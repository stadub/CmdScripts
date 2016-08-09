@echo off

reg query HKCU\Environment /v Path | findstr /I "%~1" >nul

if not exist "%~1" (
    echo Error: "%~1" doesn't exist
	exit /b
)

if %ErrorLevel% gtr 0 (
    echo Adding "%~1" to path list
) else (
    echo Error: "%~1" already in the PATH list
	exit /b
)

REG query HKCU\Environment /v Path>env.tmp

for /f "tokens=2,* delims= " %%a in (env.tmp) do set AllButFirst=%%b

REG ADD HKCU\Environment /v Path /t REG_EXPAND_SZ /d "%AllButFirst%;%~1" /f


