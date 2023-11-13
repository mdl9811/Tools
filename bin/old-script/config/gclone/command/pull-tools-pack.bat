@echo off

setlocal

set ECHO_CONFIG=%GLOBAL_TOOLS_PATH%\config\gclone\tools-pack\echo-sparse.bat

set SRC_PATH=%1
set ENABLE_ALL=%3

set INIT_PATH=%SRC_PATH%\tools-pack\.git
set TOOLS_PATH=%SRC_PATH%\tools-pack
set TARGET_PATH=%TOOLS_PATH%\.git\info
set LIST_PATH=%TOOLS_PATH%\dir\list

if not exist %TOOLS_PATH% mkdir %TOOLS_PATH%

cd %TOOLS_PATH%

if not exist %LIST_PATH% (
	echo list cofig not exist
	exist /b 0
)
if "%3" == "--list" (
echo ---------------------------------------------------
echo --list
	for /F "tokens=1-4" %%A in (%LIST_PATH%) do (
		echo %%A
	)
echo ---------------------------------------------------
exit /b 0
)


if not exist %INIT_PATH% (
	cmd /c git init
	cmd /c git remote add origin https://gitee.com/aixiaoxiaohui/tools-pack.git
	cmd /c git config --local core.sparsecheckout true
	cmd /c git branch --set-upstream-to=origin/master master
)

echo pull tools pack path:%TOOLS_PATH%

call %ECHO_CONFIG% %TARGET_PATH% %*

cmd /c git pull origin master
cmd /c git checkout master
