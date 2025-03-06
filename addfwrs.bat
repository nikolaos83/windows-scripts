@echo off
REM      BATCH FILE CREATED BY CHARLES DE HAVILLAND 20/02/2012, v2 08/09/2015
REM	 https://sites.google.com/site/mytools4000/home/allow-block-multiple-programs-through-windows-7-firewall
cls
SETLOCAL EnableDelayedExpansion
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (
  set "DEL=%%a"
)
If "%1"=="" GOTO :norulename
SET RULENAME=%1
ECHO.
ECHO.
ECHO Add 'In AND Out' Firewall rules to all 
call :ColorText 0b "*.exe ^& *.dll"
ECHO files in,
ECHO.
ECHO   %CD% (inc subfolders)
ECHO.
ECHO   "%RULENAME%" Firewall rule name will be used ?
ECHO.
ECHO.
ECHO.
ECHO press CTRL+C to stop now or
pause
cls
Echo.
FOR /r %%G in ("*.exe") Do (@echo %%G
NETSH advfirewall firewall add rule name="%RULENAME%-%%~nxG" dir=in program="%%G" action="block" enable="yes")
FOR /r %%G in ("*.exe") Do (@echo %%G
NETSH advfirewall firewall add rule name="%RULENAME%-%%~nxG" dir=out program="%%G" action="block" enable="yes")
FOR /r %%G in ("*.dll") Do (@echo %%G
NETSH advfirewall firewall add rule name="%RULENAME%-%%~nxG" dir=in program="%%G" action="block" enable="yes")
FOR /r %%G in ("*.dll") Do (@echo %%G
NETSH advfirewall firewall add rule name="%RULENAME%-%%~nxG" dir=out program="%%G" action="block" enable="yes")
Echo.
Echo done.
GOTO :Finish

:norulename
for %%* in (.) do set RULENAME=%%~nx*
ECHO.
ECHO Add 'In AND Out' Firewall rules to all 
call :ColorText 0b "*.exe ^& *.dll"
ECHO files in,
ECHO   %CD% (inc subfolders)
ECHO.
ECHO   "%RULENAME%" Firewall rule name will be used ?
ECHO.
ECHO.
ECHO.
ECHO press CTRL+C to stop now or
pause
cls
Echo.
REM FOR /r %%G in ("*.exe") Do (@echo %%G
REM NETSH advfirewall firewall add rule name="%RULENAME%-%%~nxG" dir=in program="%%G" action="block" enable="yes")
REM FOR /r %%G in ("*.exe") Do (@echo %%G
REM NETSH advfirewall firewall add rule name="%RULENAME%-%%~nxG" dir=out program="%%G" action="block" enable="yes")
REM FOR /r %%G in ("*.dll") Do (@echo %%G
REM NETSH advfirewall firewall add rule name="%RULENAME%-%%~nxG" dir=in program="%%G" action="block" enable="yes")
REM FOR /r %%G in ("*.dll") Do (@echo %%G
REM NETSH advfirewall firewall add rule name="%RULENAME%-%%~nxG" dir=out program="%%G" action="block" enable="yes")
Echo.
Echo done.

:ColorText
echo off
<nul set /p ".=%DEL%" > "%~2"
findstr /v /a:%1 /R "^$" "%~2" nul
del "%~2" > nul 2>&1

:Finish
Echo.
Echo.
Echo Batch ended...