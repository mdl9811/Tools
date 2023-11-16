# -*- coding: UTF-8 -*-
import os
import colorama
import time
import requests

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

def download_http_file(url, path):
    if path == None:
        echo_red("download path not exist please config path")
        return
    if not os.path.exists(path):
        os.mkdir(path)
    size = 0
    chunk_size = 1024
    start = time.time() # download start time
    response = requests.get(url, stream=True)
    if response.status_code != 200:
        echo_red("Download failed with status code=%d" % response.status_code)
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

if __name__ == '__main__':
    v = getenv("TOOLS_PATH")
    print(v)
