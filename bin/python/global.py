import pub.system as csystem
import sys

def help():
    csystem.echo_red("must env TOOLS_PATH and TOOLS_CONFIG_PATH please run [global --set-user TOOLS_PATH=<path> TOOLS_CONFIG_PATH=<config-path>]")

def get_key_value(str):
    if str.find("=") < 0:
        return None, None
    key = str.split('=')[0]
    val = str.split('=')[1]
    if key and val:
        return key, val
    return None, None

def set(args):
    for arg in args:
        [key, val] = get_key_value(arg)
        if key and val:
            csystem.echo_yellow("set user env key:[%s] value:[%s]" % (key, val))
            csystem.setenv_user(key, val)


def run_loop(args):
    if len(args) <= 1:
        help()
        return
    i = 1
    if args[i] == "--set-user":
        set(args[i + 1:])
        return
    if args[i] == "--help":
        help()
        return

if __name__ == '__main__':
    run_loop(sys.argv)