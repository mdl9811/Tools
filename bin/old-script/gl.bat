@echo off

set COMMAND=
if "%1"=="grep" set COMMAND="--color=always"
if "%1"=="ls" set COMMAND="--color=always"

"C:\Program Files\Git\bin\bash.exe" -c "%* %COMMAND%"