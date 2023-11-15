# -*- coding: UTF-8 -*-
import os
import colorama

colorama.init(autoreset=True)

def get_key_value(str, split):
    if str.find(split) < 0:
        return None, None
    key = str.split(split)[0]
    val = str.split(split)[1]
    if key and val:
        return key, val
    return None, None

def echo_red(str):
    print("\033[0;31;40m%s\033[0m" % str)

def echo_yellow(str):
    print("\033[0;33;40m%s\033[0m" % str)

def echo_blue(str):
    print("\033[0;34;40m%s\033[0m" % str)

def echo_green(str):
    print("\033[0;32;40m%s\033[0m" % str)

def setenv(key, value):
    os.environ[key] = value

def getenv(key):
    return os.environ.get(key)

def setenv_user(key, value):
    command = r"setx %s %s" % (key, value)
    os.system(command)

def delenv(key):
    del os.environ[key]

def execute(command):
    command = r"call %s" % command
    os.system(command)


if __name__ == '__main__':
    v = getenv("TOOLS_PATH")
    print(v)
