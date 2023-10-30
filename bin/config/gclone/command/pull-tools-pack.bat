@echo off

setlocal

set PULL_CONFIG=%GLOBAL_TOOLS_PATH%\local\config\gclone\tools-pack\sparse-checkout
if not exist %PULL_CONFIG% (
	set PULL_CONFIG=%GLOBAL_TOOLS_PATH%\config\gclone\tools-pack\sparse-checkout
)

set SRC_PATH=%1
set ENABLE_ALL=%3

set INIT_PATH=%SRC_PATH%\tools-pack\.git
set TOOLS_PATH=%SRC_PATH%\tools-pack
set TARGET_PATH=%TOOLS_PATH%\.git\info

if not exist %TOOLS_PATH% mkdir %TOOLS_PATH%

cd %TOOLS_PATH%

if not exist %INIT_PATH% (
	cmd /c git init
	cmd /c git remote add origin https://gitee.com/aixiaoxiaohui/tools-pack.git
	cmd /c git config --local core.sparsecheckout true
)

echo pull tools pack path:%TOOLS_PATH%

if "%ENABLE_ALL%" neq  "1" (
	echo copy config src:%PULL_CONFIG% target:%TARGET_PATH%
	xcopy %PULL_CONFIG% %TARGET_PATH%
)

cmd /c git pull origin master
cmd /c git checkout master
