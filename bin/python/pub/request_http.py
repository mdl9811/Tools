import requests
import re
import pub.system as csys

def get_exe_regular_expression():
    return "[^<>\\\/^\"\']*\.exe"

def request_download_exe(address, path):
    url = address.split('|')[0]
    print("requesting url: %s" % url)
    obj = requests.get(url)
    if obj.status_code != 200:
        print("request failed: %s" % obj.status_code)
        return
    context_text = obj.text
    for dow in address.split('|')[1:]:
        out = re.search("%s%s" % (dow, get_exe_regular_expression()), context_text)
        if out == None:
            csys.echo_red("Request not found [%s]" % dow)
            continue 
        url = address.split('|')[0]
        f = out.span()
        exe_name = context_text[f[0]:f[1]]
        dowload_url = url + exe_name
        csys.download_http_file(dowload_url, path)

if __name__ == '__main__':
    pass
    # url = "https://fossies.org/windows/misc/|Wireshark-|ss|fdsad|"
    # request_download_exe(url, "S:\\temp")