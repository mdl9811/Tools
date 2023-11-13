@echo off
setlocal
set CONFIG_PATH=%1

for /F "tokens=1,*" %%A in (%CONFIG_PATH%) do (
  echo %%A %%B
)