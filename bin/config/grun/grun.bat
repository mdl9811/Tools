@echo off
setlocal
if %1=="" echo parament is null&exit /b 0
set RUN_PATH=%1

for /F "tokens=1,*" %%a in ("%RUN_PATH%") do (
 cd /d %%~dpa
 echo run path: %%~dpa
 echo name: %%~na
)

start  /b "" %RUN_PATH% > nul
