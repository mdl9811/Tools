@echo off

setlocal
set GRUN=%GLOBAL_TOOLS_PATH%\config\\grun\\grun.bat
set COMMAND=%GLOBAL_TOOLS_PATH%\config\\grun\\command.bat
set CONFIG_WORK_PATH=%GLOBAL_TOOLS_PATH%\config\\grun
set CONFIG_PATH=%GLOBAL_TOOLS_CONFIG_PATH%\config\\grun\\config
set COMMAND=%GLOBAL_TOOLS_PATH%\config\\grun\\command
set BIN_PATH=%GLOBAL_TOOLS_PATH%
set NOTEPAD=C:\\Program Files (x86)\\Notepad++\\notepad++.exe

for /f "tokens=1* delims=." %%a in ("%1") do set PARMMENT_1=%%a
if not defined PARMMENT_1 set PARMMENT_1=%1

if /i "%PARMMENT_1%"=="config" call %GRUN% "%CONFIG_PATH%"&goto arg-exit
if /i "%PARMMENT_1%"=="pwd" call  %GRUN% "%BIN_PATH%"&goto arg-exit
if /i "%PARMMENT_1%"=="list" call %COMMAND%\\list.bat %CONFIG_PATH%
if /i "%PARMMENT_1%"=="rm" call %COMMAND%\\rm.bat %CONFIG_PATH% %*
if /i "%PARMMENT_1%"=="add" call %COMMAND%\\add.bat %CONFIG_PATH% %*

:arg-exit
exit /b 0
