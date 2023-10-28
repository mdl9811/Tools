@echo off

set CLONE_PATH_CONFIG=C:\Tools\bin\config\gclone\path
set CLONE_CONFIG=C:\Tools\bin\config\gclone\config

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

rem 执行 genv.bat 
echo exec genv
call genv

rem clone 代码 下载到 /src 

for /F "tokens=1,*" %%A in (%CLONE_CONFIG%) do (
	echo clone [%%A] path:[%%B]
	git clone %%B %SRC_PATH%\%%A
)

rem git clone https://chromium.googlesource.com/chromium/tools/depot_tools ../m