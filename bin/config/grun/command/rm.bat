@echo off
setlocal

set RM_NAME=%3
set TEMP=C:\Tools\bin\config\grun\temp
set DEFAULT_CONFIG_PATH=C:\Tools\bin\config\grun\config

for /F "tokens=1,*" %%A in (%CONFIG_PATH%) do (
  if "%%A"=="%RM_NAME%" (
	echo "del %%A %%B"
  )else (
   echo %%A %%B >> %TEMP%
  )
)

del %DEFAULT_CONFIG_PATH%
ren "%TEMP%" config

