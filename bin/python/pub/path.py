import os

class EchoPath(object):
    # 私有变量
    __path_flag = False
    __path = ""
    # method to
    def __init__(self, name, path):
        if os.path.exists(path):
            self.__path_flag = True
            self.__path = path
            print("path: %s" % self.__path)
        else:
            print(name, "path file does not exist")
    
    def __switch_dir(self, dir, file_list, is_dir): #is_dir == true 输出所有文件夹
        if not os.path.exists(dir):
            return file_list
        if os.path.isdir(dir):
            if is_dir == True:
                file_list.append(dir)
            for f in os.listdir(dir):
                ndir = os.path.join(dir, f)
                self.__switch_dir(ndir, file_list, is_dir)
        elif os.path.isfile(dir):
            if is_dir == False:
                file_list.append(dir)
        return file_list
    
    def print_list_dir(self):
        if self.__path_flag == False:
            return
        dir_list = self.__switch_dir(self.__path, [], True)
        for dir in dir_list:
            print(dir)
    
    def print_list_file(self):
        if self.__path_flag == False:
            return
        dir_list = self.__switch_dir(self.__path, [], False)
        for dir in dir_list:
            print(dir)

# test config
if __name__ == '__main__':
    echo_path = EchoPath("test", os.getcwd())
    echo_path.print_list_dir()
    echo_path.print_list_file()