@echo off

setlocal

set GLOBAL_ALLOW=%GLOBAL_TOOLS_PATH%\config\global\allow
set CLONE_CONFIG=%1
set CLONE_LOG=%2
set SRC_PATH=%3

echo start clone src path:%SRC_PATH%

for /F "tokens=1-4" %%A in (%CLONE_CONFIG%) do (
	set HTTP_PROXY=%URL_PROXY%
	set HTTPS_PROXY=%URL_PROXY%
	if %%C == no_proxy (
		echo %%A no proxy
		set HTTP_PROXY=
		set HTTPS_PROXY=
	)
	if exist %GLOBAL_ALLOW% (
		echo clone [%%A] path:[%%B]
		echo [%%A : %%B] %date% %time% >> %CLONE_LOG%\gclone_log
		git clone %%B %SRC_PATH%\%%A
	) else (
		if %%D == 1 (
			echo clone [%%A] path:[%%B]
			echo [%%A : %%B] %date% %time% >> %CLONE_LOG%\gclone_log
			git clone %%B %SRC_PATH%\%%A
		) else (
			echo no clone [%%A:%%B]
		)
	)
)