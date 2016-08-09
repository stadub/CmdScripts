set script=%temp%\Unzip.vbs

del %script%

set Source=%1

set DestDir=%2

call :WriteFile Set sh = CreateObject( "Shell.Application" )
call :WriteFile Set src = sh.NameSpace("%Source%").Items()
call :WriteFile Set target = sh.NameSpace("%DestDir%")
call :WriteFile target.CopyHere src, 256

call :WriteFile ' Self Delete
call :WriteFile Set fso = CreateObject("Scripting.FileSystemObject")
call :WriteFile Set f1 = fso.GetFile("%script%")
call :WriteFile f1.Delete
call :WriteFile '


"%script%"

:WriteFile
	echo %* >>"%script%"
	rem call :Debug written %* "%script%"
goto :eof