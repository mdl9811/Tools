@echo off

echo gloabl tools path:%cd% name:GLOBAL_TOOLS_PATH

setx "GLOBAL_TOOLS_PATH" "%cd%"

echo gloabl proxy url:http://127.0.0.1:1080 name:URL_PROXY
setx "URL_PROXY" "http://127.0.0.1:1080"