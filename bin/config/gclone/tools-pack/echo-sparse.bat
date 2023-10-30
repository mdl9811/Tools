@echo off

set CONFIG_PATH=%GLOBAL_TOOLS_PATH%\local\config\\gclone\tools-pack\config
if not exist %CONFIG_PATH% (
	set CONFIG_PATH=%GLOBAL_TOOLS_PATH%\config\\gclone\tools-pack\config
)

set OPUPUT_PATH=%1\sparse-checkout

echo OPUPUT_PATH:%OPUPUT_PATH%

del %OPUPUT_PATH%
for /F "tokens=1,*" %%A in (%CONFIG_PATH%) do (
  if %%B == 1 (
	echo download %%A
	echo %%A >> %OPUPUT_PATH%
  )
)