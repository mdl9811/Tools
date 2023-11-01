@echo off

setlocal
set CONFIG_PATH=%GLOBAL_TOOLS_CONFIG_PATH%\config\\gclone\tools-pack\config
set OPUPUT_PATH=%1\sparse-checkout
set TARGETD=%4

del %OPUPUT_PATH%
echo ---------------------------------------------------------------------------------
echo OPUPUT_PATH:%OPUPUT_PATH%
:next-arg
if "%1"=="" goto args-done
if /i "%1"=="--target" goto target

shift
goto next-arg

:args-done
echo ---------------------------------------------------------------------------------
exit /b 0

:target
if "%1"=="" goto args-done
if /i "%1"=="--target" shift
echo /%1/ >> %OPUPUT_PATH% & echo download *%1 
shift
goto :target