@echo off
echo "Copy files to dest dir %1"
xcopy %CD% %1 /H /R /K /Y /E
pause