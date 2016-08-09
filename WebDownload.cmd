@echo off

set Source=%1

set DestDir=%~dp0
set DestFile=%2

set script=%temp%\WebDownload.vbs

call :WriteFile set xmlhttp = CreateObject("MSXML2.ServerXMLHTTP.6.0")
call :WriteFile xmlhttp.open "GET", "%Source%", False
call :WriteFile xmlhttp.send

call :WriteFile set oStream = createobject("adodb.stream")
call :WriteFile oStream.type = 1
call :WriteFile oStream.open
call :WriteFile oStream.write xmlhttp.responseBody
call :WriteFile oStream.saveToFile "%DestFile%", 2
call :WriteFile set oStream = nothing
call :WriteFile set xmlhttp = nothing

call :WriteFile ' Self Delete
call :WriteFile Set fso = CreateObject("Scripting.FileSystemObject")
call :WriteFile Set f1 = fso.GetFile("%script%")
call :WriteFile f1.Delete

"%script%"

exit /b

:WriteFile
	echo %* >>"%script%"
	rem call :Debug written %* "%script%"
goto :eof