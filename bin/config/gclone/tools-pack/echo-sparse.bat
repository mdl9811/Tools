@echo off
set CONFIG_PATH=%GLOBAL_TOOLS_PATH%\config\\gclone\tools-pack\config
set OPUPUT_PATH=%GLOBAL_TOOLS_PATH%\config\\gclone\tools-pack\sparse-checkout

if exist %OPUPUT_PATH% del %OPUPUT_PATH%

for /F "tokens=1,*" %%A in (%CONFIG_PATH%) do (
  if %%B == 1 (
	echo download %%A
	echo %%A >> %OPUPUT_PATH%
  )
)