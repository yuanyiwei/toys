import requests
import base64
from urllib.parse import urlsplit

subscribe_urls = [
    'https://sub.yyw.moe',
]
schemes_allow = ['vmess', 'ss']


def safe_base64_decode(s):
    for _ in range(len(s) % 4):
        s += '='
    return base64.b64decode(s)


def get_subscribe_urls(subscribe_urls):
    share_links = []
    for subscribe_url in subscribe_urls:
        return_content = requests.get(subscribe_url).text
        share_links += safe_base64_decode(
            return_content).decode('utf-8').splitlines()
    return share_links


def get_share_link_info(share_link):
    url_info = urlsplit(share_link)
    scheme = url_info.scheme
    if scheme not in schemes_allow:
        return None
    if scheme == 'vmess':
        return get_vmess_link_info(share_link)
    if scheme == 'ss':
        return get_ss_link_info(share_link)


def get_vmess_link_info(share_link):
    url = urlsplit(share_link)
    return safe_base64_decode(url.netloc)


def get_ss_link_info(share_link):
    url = urlsplit(share_link)
    if '@' in url.netloc:
        return safe_base64_decode(url.netloc.split('@', 1)[0]).decode('utf-8')+'@'+url.netloc.split('@')[1]


def get_sub_info(subscribe_urls):
    configs = []
    share_links = get_subscribe_urls(subscribe_urls)
    for share_link in share_links:
        configs.append(get_share_link_info(share_link))
    return configs


# print(get_subscribe_urls(subscribe_urls))
print(get_sub_info(subscribe_urls))
