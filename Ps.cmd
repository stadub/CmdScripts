@echo off
set "App=%1"

IF "x%App%" == "x" (
	tasklist
) else (
	tasklist /FI "IMAGENAME eq %App%"
)