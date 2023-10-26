@echo off

setlocal
set GRUN=C:\\Tools\\bin\\config\\grun\\grun.bat
set COMMAND=C:\\Tools\\bin\\config\\grun\\command.bat
set CONFIG_WORK_PATH=C:\\Tools\\bin\\config\\grun
set CONFIG_PATH=C:\\Tools\\bin\\config\\grun\\config
set COMMAND=C:\\Tools\\bin\\config\\grun\\command
set BIN_PATH=C:\\Tools\\bin
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
