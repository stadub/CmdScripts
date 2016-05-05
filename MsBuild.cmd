@echo off

rem SETLOCAL ENABLEDELAYEDEXPANSION

rem set  MSBUILDEMITSOLUTION=1
set MsbuildVersion=4.0

rem Trying to get MSBuildToolsPath32 registry path
for /f "tokens=2 delims=:" %%i in ('reg.exe query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\MSBuild\ToolsVersions\%MsbuildVersion%" /v "MSBuildToolsPath32" ') do (
	set "msbuild32RegistryPath=%%i"
)

rem If link to 32 bit version found -set it as path otherwise use default 
if NOT "-=%msbuild32RegistryPath%=-" == "-==-" (
	rem set msbuild32RegistryPath=%msbuild32RegistryPath:~11%
	set msbuildRegistryPath=%msbuild32RegistryPath:~0,-18%
) else (
	set msbuildRegistryPath="HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\MSBuild\ToolsVersions\%MsbuildVersion%"
	echo %msbuildRegistryPath%
)

rem Trying to get MSBuildToolsPath32 registry path
for /f "tokens=1-3" %%i in ('reg query %msbuildRegistryPath% /v MSBuildToolsPath') do (
	set "msbuildPath=%%k"
)

if NOT exist %msbuildPath%\Msbuild.exe goto MsbuildNotFound

%msbuildPath%Msbuild.exe %*


rem PerformanceSummary;
pause
goto :EOF

rem possible values quiet, minimal, normal, detailed, and diagnostic. 
:MsbuildNotFound
echo MSBuild.exe not found
pause
exit /B 1