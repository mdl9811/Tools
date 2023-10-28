@echo off

set PARMMENT_1=%1

if not defined PARMMENT_1 (
	echo path null exit
	exit /b 0
)

setx "GLOBAL_TOOLS_PATH" %1

echo gloabl tools path:%GLOBAL_TOOLS_PATH% name:GLOBAL_TOOLS_PATH
set CONFIG_PATH=%GLOBAL_TOOLS_PATH%\config\global\config

for /F "tokens=1,*" %%A in (%CONFIG_PATH%) do (
	echo gloabl name:%%A value:%%B
	setx "%%A" "%%B"
)
