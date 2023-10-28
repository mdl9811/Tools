@echo off

set CURL_CONFIG=%GLOBAL_TOOLS_PATH%\config\gcurl\config
set CURL_OPUPUT_PATH=%GLOBAL_TOOLS_PATH%\temp
set DOWNLOAD_LOG=%GLOBAL_TOOLS_PATH%\log

if not exist "%CURL_CONFIG%" (
	echo gcurl path:[%CURL_CONFIG%] no exist
	exit /b 0
)

if not exist "%CURL_OPUPUT_PATH%" (
	echo gcurl config no exist
	mkdir %CURL_OPUPUT_PATH%
)

if not exist "%DOWNLOAD_LOG%" (
	mkdir %DOWNLOAD_LOG%
)

echo http_proxy:%HTTP_PROXY% https_proxy:%HTTPS_PROXY%

cd %CURL_OPUPUT_PATH%

echo start curl  save path:%CURL_OPUPUT_PATH%
echo proxy url:%URL_PROXY%

for /F "tokens=1-4" %%A in (%CURL_CONFIG%) do (
	set HTTP_PROXY=%URL_PROXY%
	set HTTPS_PROXY=%URL_PROXY%
	if %%C == no_proxy (
		echo %%A no proxy
		set HTTP_PROXY=
		set HTTPS_PROXY=
	)
	
	if %%D == 1 (
		echo download [%%A:%%B]
		echo [%%A : %%B] %date% %time% >> %DOWNLOAD_LOG%\gcurl_log
		curl -LJO %%B
	) else (
		echo no download [%%A:%%B]
	)
)





