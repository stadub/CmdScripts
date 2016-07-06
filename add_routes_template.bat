@echo off

Echo Interfaces list:
route print | findstr.exe /c:"......"

set /p IF="Enter VPN interface index:"

set /p IF_LOCAL="Enter local network interface index:"

SET GATEWAY=192.168.0.1

rem reoutes goes here
rem Example 
rem    AddRoute 8.8.8.8


:AddRoute
	echo --==Adding route for the network path %~1==--
	@echo on
	route DELETE %~1
	route add %~1 mask 255.255.255.255 %GATEWAY% IF %IF% -p
	@echo off
goto :eof

pause