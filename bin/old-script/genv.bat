@echo off

set DEPOT_TOOLS_WIN_TOOLCHAIN=0
set HTTP_PROXY=%URL_PROXY%
set HTTPS_PROXY=%URL_PROXY%
set PATH=%GLOBAL_TOOLS_CONFIG_PATH%\src\depot_tools;%LLVM_BIN%;%PATH%