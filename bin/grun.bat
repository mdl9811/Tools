@echo off

setlocal
set GRUN=C:\\Tools\\bin\\config\\grun\\grun.bat
set GRUN_ARGS=C:\\Tools\\bin\\config\\grun\\grun_args.bat
set CONFIG_PATH=C:\\Tools\\bin\\config\\grun\\config

if not exist "%CONFIG_PATH%" (
  echo grun config not exist [config path is %CONFIG_PATH%]
  exit /b 0
)

if "%1"=="" echo parament is null&exit /b 0

for /F "tokens=1,*" %%A in (%CONFIG_PATH%) do (
  if %1==%%A call %GRUN% "%%B"&goto execute-done
)

call %GRUN_ARGS% %*&goto execute-done

:execute-done
exit /b 0
