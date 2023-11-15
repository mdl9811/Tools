# -*- coding: UTF-8 -*-
import sys
import os
import pub.path as cpath
import pub.system as csystem
import subprocess
import configparser
import requests

# 解析所有命令 并执行 相关python

# 常量
RUN='run'
FETCH='fetch'

# 变量
config_path=None
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

def get_run_path(key):
    return conf[RUN].get(key)

def add_and_del(key, falg):
    if falg and (get_run_path(key) == None):
        csystem.echo_red("key:[%s] not exists" % key)
        return
    if falg == 1 :
        ret = conf.remove_option(RUN, key)
        csystem.echo_yellow("del %s result:%d" % (key, ret))
    elif falg == 0:
        [k, v] = csystem.get_key_value(key, "=")
        if k == None or v == None:
            csystem.echo_red("add parameter error key or value is null")
            return
        csystem.echo_yellow("add key:%s vluse:%s" % (key, v))
        conf.set(RUN, k, v)
    

    conf.write(open(config_path, "w"))
   

# flag = 0 [add] flag = 1 [del]
def eumm_config(args, flag):
    for key in args:
        add_and_del(key, flag)


def del_config(args):
    if len(args) < 1:
        csystem.echo_red("The parameter is less than one")
        return
    eumm_config(args, 1)


def add_config(args):
    eumm_config(args, 0)

def echo_list():
    for item in conf.items(RUN):
       print(item)


def help():
    csystem.echo_green("Usage: grun [option <arg> ] [run-name] ...")
    csystem.echo_green("Option:")
    csystem.echo_green("--fetch <args>: 拉取 git中文件 和 工具库中文件 可以配置代理进行拉取 args:[--add | -del | --list |[name...] ]")
    csystem.echo_green("--list: 输出所有配置文件中run [key] [value]")
    csystem.echo_green("--add: 添加可运行的配置选项")
    csystem.echo_green("--del: 删除可运行的配置选项")
    csystem.echo_green("--help: 输出帮助doc")



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


def echo_fetch_list():
    for item in conf.items(FETCH):
       print(item)

def get_remote_url(name):
    return conf[FETCH].get(name)


def download_http_file(url, filepath):
    csystem.echo_yellow("download url: %s" % url)
    res = requests.get(url)
    total_size = res.headers["content-length"]
    print(total_size)
    with open(filepath,'wb') as file:
        print(1)
        file.write(res.content)



def fetch(args):
    print(len(args))
    if len(args) == 0:
        for item in conf.items(FETCH):
            url=item[1]
            if url != None:
                download_http_file(url, "C:\\Tools\\bin\\python\\1.exe")
        return
    return
    for arg in args:
        pass

def parse_command_line(args):
    j = 1
    if len(args) <= j:
        help()
        return
    if args[j] == "--help":
        help()
        return
    if args[j] == "--list":
        echo_list()
        return
    if args[j] == "--del":
        del_config(args[j + 1:])
        return
    if args[j] == "--add":
        add_config(args[j + 1:])
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
    tools_config_path = csystem.getenv("TOOLS_CONFIG_PATH")
    if tools_config_path == None:
        csystem.echo_red("No ENV TOOLS_CONFIG_PATH please run global --set-user TOOLS_CONFIG_PATH=[path]")
        return

    if not os.path.exists(tools_config_path):
        csystem.echo_red("Tools Config Path does not exist")
        return
    # check if
    global config_path
    config_path = tools_config_path + "/config/config.ini"

    if not os.path.exists(config_path):
        csystem.echo_red("Tools Config Path does not exist path: %s" % config_path)
        return

    conf.read(config_path, encoding='utf-8')
    parse_command_line(args)

if __name__ == '__main__':
    run_loop(sys.argv)