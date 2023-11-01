@echo off

setlocal
set CONFIG_PATH=%GLOBAL_TOOLS_CONFIG_PATH%\config\\gclone\tools-pack\config
set OPUPUT_PATH=%1\sparse-checkout
set TARGETD=%4

if exist %OPUPUT_PATH% del %OPUPUT_PATH%
echo ---------------------------------------------------------------------------------
echo OPUPUT_PATH:%OPUPUT_PATH%

:next-arg
if "%1"=="" goto args-done
if "%1"=="--target" goto target-args
shift
goto next-arg

:target-args
if "%1"=="" goto args-done
if "%1"=="--target" shift
echo %1 >> %OPUPUT_PATH% & echo download *%1 
shift
goto target-args

:args-done
echo ---------------------------------------------------------------------------------
exit /b 0



