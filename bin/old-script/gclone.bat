@echo off

set CLONE_COMMAND_PATH=%GLOBAL_TOOLS_PATH%\config\gclone\command
set SRC_PATH=%GLOBAL_TOOLS_CONFIG_PATH%\src
set CLONE_LOG=%GLOBAL_TOOLS_CONFIG_PATH%\log
set CLONE_CONFIG=%GLOBAL_TOOLS_CONFIG_PATH%\config\gclone\config

if not exist "%CLONE_CONFIG%" (
	echo clone path config no exist
	echo please run global [config-path]
	exit /b 0
)

if not exist %CLONE_LOG% (
	mkdir %CLONE_LOG%
)

echo clone src path:%SRC_PATH%
if not exist "%SRC_PATH%" mkdir %SRC_PATH%

rem clone 代码 下载到 /src 

if /i "%1" == "tools-pack" goto pull-tools-pack

call %CLONE_COMMAND_PATH%\clone-config.bat %CLONE_CONFIG% %CLONE_LOG% %SRC_PATH% & goto done

:pull-tools-pack
call %CLONE_COMMAND_PATH%\pull-tools-pack.bat %SRC_PATH% %*
goto done

:done
exit /b 0