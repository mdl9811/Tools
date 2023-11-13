@echo off
setlocal

set ADD_NAME=%3
set CONFIG=%1
set ADD_PATH=%4

echo. >> %CONFIG%
echo %ADD_NAME% %ADD_PATH% >> %CONFIG%

