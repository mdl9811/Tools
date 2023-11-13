# -*- coding: UTF-8 -*-
import sys
import os
import pub.path as cpath
import pub.system as csystem
import subprocess
import configparser

# 解析所有命令 并执行 相关python

# 常量
RUN='run'

# 变量
tools_path=None
tools_config_path=None
url_proxy=None

# ENV
# -*- coding: UTF-8 -*-
# TOOLS_PATH TOOLS_CONFIG_PATH [必须的环境变量]

conf  = configparser.ConfigParser()

def parse_path(args):
    if len(args) < 1:
        print("echo path is too long")
        return 
    echo_path =  cpath.EchoPath("FIle DIR", args[0])
    if len(args) < 2:
        return 
    if args[1] == "file":
        echo_path.print_list_file()
    elif args[1] == "dir":
        echo_path.print_list_dir()


def echo_help(args):
    for i in range(len(args)):
        if args[i] == "grun":
            csystem.echo_red("Usage: grun <name ...>")

def help(args):
    args_dict = args
    if len(args) == 0:
        args_dict = ["grun"]
    echo_help(args_dict)

def get_run_path(key):
    return conf[RUN].get(key)

def execute_com(name):
    csystem.echo_blue("run " + name)
    if os.path.isdir(name):
        os.startfile(name)
        return
    if os.path.isfile(name):
        subprocess.Popen(name)
        return

def runing_command(args):
    for arg in args:
        path = get_run_path(arg)
        if not os.path.exists("%s" % path):
            csystem.echo_yellow("path:[%s] not exist please execute grun --list" % arg)
            continue
        execute_com(path)

def fetch(args):
    pass

def parse_command_line(args):
    j = 1
    if len(args) <= j:
        help([])
        return
    if args[j] == "--help":
        help(args[j + 1:])
        return
    if args[j] == "--list":
        csystem.echo_red(conf.items(RUN))
        return
    if args[j] == "--fetch":
        fetch(args[j + 1:])
        return
    if args[j] == "--echo-path":
        parse_path(args[j + 1:])
        return
    runing_command(args[j:])

# 主函数
def run_loop(args):
    tools_path = csystem.getenv("TOOLS_PATH")
    tools_config_path = csystem.getenv("TOOLS_CONFIG_PATH")
    if tools_path == None or tools_config_path == None:
        csystem.echo_red("No ENV TOOLS_PATH or TOOLS_CONFIG_PATH please run global --set-user TOOLS_PATH=[path] TOOLS_CONFIG_PATH=[path]")
        return

    if not os.path.exists(tools_path):
        csystem.echo_red("Tools Path does not exist")
        return

    if not os.path.exists(tools_config_path):
        csystem.echo_red("Tools Config Path does not exist")
        return
    # check if
    config_path = tools_config_path + "/config/config.ini"

    if not os.path.exists(config_path):
        csystem.echo_red("Tools Config Path does not exist path: %s" % config_path)
        return

    conf.read(config_path, encoding='utf-8')
    parse_command_line(args)

if __name__ == '__main__':
    run_loop(sys.argv)