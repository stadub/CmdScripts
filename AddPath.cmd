
if not exist "%~1" (
    echo Error: "%~1" doesn't exist
	goto :EOF
)

Reg Query HKCU\Environment /v Path | findstr /I "%~1 >nul
if %ErrorLevel% gtr 0 (
    echo Adding "%~1" to path list
) else (
    echo Error: "%~1" already in the PATH list
	goto :EOF
)

Reg Query HKCU\Environment /v Path>env.tmp

for /f "tokens=2,* delims= " %%a in (env.tmp) do set AllButFirst=%%b

Reg Add HKCU\Environment /f /v Path /t REG_EXPAND_SZ /d "%AllButFirst%;%~1

del env.tmp
rem echo REG ADD HKCU\Environment  /f /v Path /t REG_EXPAND_SZ /d "%AllButFirst%;%~1 


