
@echo off
if exist Bin (
    exit /b
)

set SelfDir=%~dp0
set DownloadDir=%~dp0Download
set BinDir=%~dp0Bin

echo %DownloadDir%\7za920.zip


mkdir %DownloadDir%

call WebDownload.cmd http://www.7-zip.org/a/7za920.zip %DownloadDir%\7za920.zip

rem wait for download
:loop
ping 127.0.0.1 -n 1 > NUL 
if not exist "%DownloadDir%\7za920.zip" goto loop

call WebDownload.cmd http://www.7-zip.org/a/7z920_extra.7z %DownloadDir%\7zextra.7z
:loop
ping 127.0.0.1 -n 1 > NUL 
if not exist "%DownloadDir%\7zextra.7z" goto loop

mkdir %DownloadDir%\7z\

call %SelfDir%\Unzip.cmd %DownloadDir%\7za920.zip %DownloadDir%\7z\


"%DownloadDir%\7z\7za.exe" e -y "%DownloadDir%\7zextra.7z" "-o%DownloadDir%\7zX"

mkdir %BinDir%
copy "%DownloadDir%\7zX\7zr.exe" "%BinDir%"
copy "%DownloadDir%\7zX\7zS.sfx" "%BinDir%"


rmdir "%DownloadDir%" /S /Q 

echo "Done!"
pause

