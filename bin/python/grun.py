# -*- coding: UTF-8 -*-
import sys
import os
import pub.path as cpath
import pub.system as csystem
import subprocess
import configparser
import requests
import time
from optparse import OptionParser
import version

# 解析所有命令 并执行 相关python

# 常量
RUN='run'
FETCH='fetch'
GLOBAL='global'

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

def execute_com(name):
    csystem.echo_blue("run " + name)
    if os.path.isdir(name):
        os.startfile(name)
        return
    if os.path.isfile(name):
        subprocess.Popen(name)
        return

def go_open(args):
    for name in args:
        if os.path.exists(name):
            execute_com(name)

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

def get_http_download_path():
   return conf[GLOBAL].get("HTTPDL") 

def get_git_download_path():
   return conf[GLOBAL].get("GITDL") 

def get_file_suffix(name):
    name.split("/")[-1]

def download_http_file(url):
    path = get_http_download_path()
    if path == None:
        csystem.echo_red("download path not exist please config path")
        return
    if not os.path.exists(path):
        os.mkdir(path)
    size = 0
    chunk_size = 1024
    start = time.time() # download start time
    response = requests.get(url, stream=True)
    if response.status_code != 200:
        csystem.echo_red("Download failed with status code=%d" % response.status_code)
        return
    filepath = path + "\\" + url.split("/")[-1]
    content_size = int(response.headers['content-length'])
    print("download url: %s" % url)
    print("download save path: %s" % filepath)
    print("download,[File size]:{size:.2f} MB".format(size = content_size / chunk_size / 1024))
    with open(filepath,'wb') as file:
        for data in response.iter_content(chunk_size = chunk_size):
            file.write(data)
            size += len(data)
            print('\r'+'[下载进度]:%s%.2f%%' % ('>' * int(size * 50 / content_size), float(size / content_size * 100)) ,end=' ')
    end = time.time()
    print('Download completed! times: %.2f秒' % (end - start))  #输出下载用时时间

def git_clone(url):
    path = get_git_download_path()
    if path == None:
        csystem.echo_red("download path not exist please config path")
        return
    csystem.echo_blue("download url:%s save path:%s" % (url, path))
    subprocess.call(['git', 'clone', url], cwd=path)

def download(url):
    if url == None:
        csystem.echo_red("Downloading url: %s not exist" % url)
        return
    if url.split(".")[-1] == "git" :
        git_clone(url)
    else :
        download_http_file(url)

def fetch(args):
    if len(args) == 0:
        for item in conf.items(FETCH):
            url=item[1]
            download(url)    
        return
    for arg in args:
        url = get_remote_url(arg)
        download(url)


def parse_command_line(options, args):
    if options.list:
        echo_list()
        return
    if options.add:
        add_config(args[1:])
        return
    if options.dell:
        del_config(args[1:])
        return
    if options.open:
        go_open(args[1:])
        return
    if options.fetch:
        fetch(args[1:])
        return
    runing_command(args[1:])

def add_command():
    hstr = '%prog [options [name]...]'
    parser = OptionParser(hstr, description='grun description', version=version.version())
    parser.add_option('-l', '--list', action='store_true', dest='list', help='list configuration commands and exit')
    parser.add_option('-a', '--add', action='store_true', dest='add', help='add command configuration and exit')
    parser.add_option('-d', '--del', action='store_true', dest='dell', help='del command configuration and exit')
    parser.add_option('-f', '--fetch', action='store_true', dest='fetch', help='fetch git or http resources and exit')
    parser.add_option('-o', '--open', action='store_true', dest='open', help='open folder or exe file and exit')    
    return parser

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

    parser = add_command()
    options, args = parser.parse_args(args)
    parse_command_line(options, args)

if __name__ == '__main__':
    run_loop(sys.argv)