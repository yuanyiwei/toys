from email.quoprimime import quote
import requests
import base64
import yaml
# pyyaml
from urllib.parse import quote


subscribe_urls = [
    'https://sub.yyw.moe',
]


def safe_base64_decode(s):
    for _ in range(len(s) % 4):
        s += '='
    return base64.b64decode(s)


def get_sharelinks(subscribe_urls):
    share_links = []
    for subscribe_url in subscribe_urls:
        return_content = requests.get(subscribe_url).text
        yaml_content = yaml.safe_load(return_content)
        for proxy in yaml_content['proxies']:
            share_links.append(clash2v2ray(proxy))
    return share_links


def clash2v2ray(share_link):
    link = ''
    if share_link['type'] == 'vmess':
        link = 'vmess://'
        link += base64.b64encode(bytes(('{"v":"2","ps":"' + share_link['name'].encode('utf-16', 'surrogatepass').decode('utf-16') + '","add":"' + share_link['server'] + '","port":"' + str(share_link['port']) + '","id":"' + share_link['uuid'] + '","aid":"' + str(share_link['alterId']) + '","net":"tcp","type":"none","host":"","path":"","tls":""}').encode('utf-8'))).decode('utf-8')
        # TODO
    elif share_link['type'] == 'ss':
        link = 'ss://'
        link += base64.b64encode(bytes((share_link['cipher'] + ':' + share_link['password']).encode('utf-8'))).decode('utf-8')
        link += '@' + share_link['server'] + ':' + str(share_link['port'])
        link += '#' + quote(share_link['name'], 'utf-8')
    elif share_link['type'] == 'trojan':
        link = 'trojan://'
        link += share_link['password']
        link += '@' + share_link['server'] + ':' + str(share_link['port'])
        link += '?sni=' + share_link['sni']
        link += '&peer=' + share_link['sni']
        if 'skip-cert-verify' in share_link.keys():
            link += '&skip-cert-verify=' + ('1' if share_link['skip-cert-verify'] else '0')
        link += '#' + quote(share_link['name'], 'utf-8')
    elif share_link['type'] == 'vless':
        pass
        # TODO
    return link


for link in get_sharelinks(subscribe_urls):
    print(link)
