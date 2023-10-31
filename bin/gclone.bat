@echo off

set CLONE_COMMAND_PATH=%GLOBAL_TOOLS_PATH%\config\gclone\command
set CLONE_PATH_CONFIG=%GLOBAL_TOOLS_CONFIG_PATH%\config\gclone\path
set CLONE_LOG=%GLOBAL_TOOLS_CONFIG_PATH%\log
set CLONE_CONFIG=%GLOBAL_TOOLS_CONFIG_PATH%\config\gclone\config

if not exist "%CLONE_PATH_CONFIG%" (
	echo clone path config no exist
	echo please run global [config-path]
	exit /b 0
)

if not exist "%CLONE_CONFIG%" (
	echo clone config no exist
	exit /b 0
)

if not exist %CLONE_LOG% (
	mkdir %CLONE_LOG%
)

for /F "tokens=1,*" %%A in (%CLONE_PATH_CONFIG%) do (
  if src==%%A set SRC_PATH=%%B&goto execute-done
)


:execute-done

if not defined SRC_PATH (
	echo no src path exit
	exit /b 0
)

if not exist "%SRC_PATH%" mkdir %SRC_PATH%

rem clone 代码 下载到 /src 

if /i "%1" == "tools-pack" goto pull-tools-pack

call %CLONE_COMMAND_PATH%\clone-config.bat %CLONE_CONFIG% %CLONE_LOG% %SRC_PATH% & goto done

:pull-tools-pack
call %CLONE_COMMAND_PATH%\pull-tools-pack.bat %SRC_PATH% %*
goto done

:done
exit /b 0