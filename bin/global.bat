@echo off

set PARMMENT_1=%1
set PARMMENT_2=%2

if not defined PARMMENT_1 (
	echo tools path not exit
	exit /b 0
)

if not defined PARMMENT_2 (
	echo config path not exit
	exit /b 0
)

setx "GLOBAL_TOOLS_PATH" %1
echo gloabl tools path:%GLOBAL_TOOLS_PATH% name:GLOBAL_TOOLS_PATH

setx "GLOBAL_TOOLS_CONFIG_PATH" %2
echo gloabl tools config path:%GLOBAL_TOOLS_CONFIG_PATH% name:GLOBAL_TOOLS_CONFIG_PATH

set CONFIG_PATH=%PARMMENT_2%\config\global\config

for /F "tokens=1,*" %%A in (%CONFIG_PATH%) do (
	echo gloabl name:%%A value:%%B
	setx "%%A" "%%B"
)
