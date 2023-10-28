@echo off

set CLONE_PATH_CONFIG=%GLOBAL_TOOLS_PATH%\config\gclone\path
set CLONE_CONFIG=%GLOBAL_TOOLS_PATH%\config\gclone\config
set CLONE_LOG=%GLOBAL_TOOLS_PATH%\config\gclone\log

if not exist "%CLONE_PATH_CONFIG%" (
	echo clone path config no exist
	exit /b 0
)

if not exist "%CLONE_CONFIG%" (
	echo clone config no exist
	exit /b 0
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

echo start clone src path:%SRC_PATH%


rem clone 代码 下载到 /src 


for /F "tokens=1-4" %%A in (%CLONE_CONFIG%) do (
	set HTTP_PROXY=%URL_PROXY%
	set HTTPS_PROXY=%URL_PROXY%
	if %%C == no_proxy (
		echo %%A no proxy
		set HTTP_PROXY=
		set HTTPS_PROXY=
	)
	
	if %%D == 1 (
		echo clone [%%A] path:[%%B]
		echo [%%A : %%B] %date% %time% >> %CLONE_LOG%
		git clone %%B %SRC_PATH%\%%A
	) else (
		echo no clone [%%A:%%B]
	)
)

rem git clone https://chromium.googlesource.com/chromium/tools/depot_tools ../m