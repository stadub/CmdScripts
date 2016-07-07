@rem based on http://community.skype.com/t5/Windows-desktop-client/Block-Skype-Ads-Quick-and-Easy/td-p/3222434/page/2
@echo off

setlocal enabledelayedexpansion

echo ----====Closing Skype====----
taskkill /IM skype.exe

echo ----====Remove Advertisings from skype profiles====----
set SkypeAppDataDir="%appdata%\Skype\"
for /R %SkypeAppDataDir% %%i in (*config.xml) do (

FOR /f "delims=\ tokens=7" %%j in ("%%i") do echo ----====Remove Advertisings from "%%j"====----

copy %%i %%i.bak

FINDSTR /V /R ".*AdvertPlaceholder.*" %%i >%%i.tmp
copy /y %%i.tmp %%i
)

echo ----====Restricting access to skype advertising urls====----

set RestrictedSitesRegPath="HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Domains"

reg add %RestrictedSitesRegPath%\msn.com\g /f
reg add %RestrictedSitesRegPath%\msn.com\g /f /v "*" /t REG_DWORD /d 4 

reg add %RestrictedSitesRegPath%\skype.com\apps /f
reg add %RestrictedSitesRegPath%\skype.com\apps /f /v "*" /t REG_DWORD /d 4 

echo ----====Restarting Skype====----
skype.exe
echo ----====Done====----

echo Press any key to continue.
pause