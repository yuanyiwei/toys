import requests
import yaml
# pyyaml

subscribe_urls = [
    'https://sub.yyw.moe',
]

Rules = [
    "RULE-SET,applications,DIRECT",
    "DOMAIN,clash.razord.top,DIRECT",
    "DOMAIN,yacd.haishan.me,DIRECT",
    "RULE-SET,private,DIRECT",
    "RULE-SET,reject,REJECT",
    "RULE-SET,icloud,DIRECT",
    "RULE-SET,apple,DIRECT",
    "RULE-SET,google,DIRECT",
    "RULE-SET,direct,DIRECT",
    "RULE-SET,lancidr,DIRECT",
    "RULE-SET,cncidr,DIRECT",
    "GEOIP,LAN,DIRECT",
    "GEOIP,CN,DIRECT",
]


def precompile(subscribe_urls):
    if len(subscribe_urls) > 0:
        content = yaml.safe_load(requests.get(subscribe_urls[0], headers={
            'user-agent': 'clash'}).text)
        if len(subscribe_urls) > 1:
            for subscribe_url in subscribe_urls[1:]:
                content['proxies'] += yaml.safe_load(requests.get(subscribe_url, headers={
                    'user-agent': 'clash'}).text)['proxies']
    else:
        return 'bad input'
    content['rules'] = Rules
    content['proxy-groups'] = [{'name': 'Select',
                                'type': 'select', 'proxies': []}]
    content['rules'].append("MATCH," + content['proxy-groups'][0]['name'])
    content['rule-providers'] = {'reject':
                                 {'type': 'http', 'behavior': 'domain', 'url': 'https://cdn.jsdelivr.net/gh/Loyalsoldier/clash-rules@release/reject.txt',
                                     'path': './ruleset/reject.yaml', 'interval': 86400},
                                 'icloud':
                                 {'type': 'http', 'behavior': 'domain', 'url': 'https://cdn.jsdelivr.net/gh/Loyalsoldier/clash-rules@release/icloud.txt',
                                  'path': './ruleset/icloud.yaml', 'interval': 86400},
                                 'apple':
                                 {'type': 'http', 'behavior': 'domain', 'url': 'https://cdn.jsdelivr.net/gh/Loyalsoldier/clash-rules@release/apple.txt',
                                  'path': './ruleset/apple.yaml', 'interval': 86400},
                                 'google':
                                 {'type': 'http', 'behavior': 'domain', 'url': 'https://cdn.jsdelivr.net/gh/Loyalsoldier/clash-rules@release/google.txt',
                                  'path': './ruleset/google.yaml', 'interval': 86400},
                                 'direct':
                                 {'type': 'http', 'behavior': 'domain', 'url': 'https://cdn.jsdelivr.net/gh/Loyalsoldier/clash-rules@release/direct.txt',
                                  'path': './ruleset/direct.yaml', 'interval': 86400},
                                 'private':
                                 {'type': 'http', 'behavior': 'domain', 'url': 'https://cdn.jsdelivr.net/gh/Loyalsoldier/clash-rules@release/private.txt',
                                     'path': './ruleset/private.yaml', 'interval': 86400},
                                 'cncidr':
                                 {'type': 'http', 'behavior': 'ipcidr', 'url': 'https://cdn.jsdelivr.net/gh/Loyalsoldier/clash-rules@release/cncidr.txt',
                                     'path': './ruleset/cncidr.yaml', 'interval': 86400},
                                 'lancidr':
                                 {'type': 'http', 'behavior': 'ipcidr', 'url': 'https://cdn.jsdelivr.net/gh/Loyalsoldier/clash-rules@release/lancidr.txt',
                                     'path': './ruleset/lancidr.yaml', 'interval': 86400},
                                 'applications':
                                 {'type': 'http', 'behavior': 'classical', 'url': 'https://cdn.jsdelivr.net/gh/Loyalsoldier/clash-rules@release/applications.txt',
                                     'path': './ruleset/applications.yaml', 'interval': 86400}
                                 }

    # HKproxies = []
    Allproxies = []

    for proxy in content['proxies']:
        if proxy['server'] == '127.0.0.1':
            continue
        # if proxy['name'].find('Hong Kong') != -1 or proxy['name'].find('HK') != -1 or proxy['name'].find('hk') != -1:
        #     HKproxies.append(proxy['name'])
        Allproxies.append(proxy['name'])

    # if len(HKproxies) > 0:
    #     content['proxy-groups'].append({'name': "HK", 'type': "url-test", 'proxies': HKproxies,
    #                                    'url': 'http://www.google.com/generate_204', 'interval': 300, })
    #     # content['proxy-groups'].append({'name': "HKLB", 'type': "load-balance", 'proxies': HKLBproxies,
    #     #                                'url': 'http://cp.cloudflare.com/generate_204', 'interval': 300, })
    #     content["proxy-groups"][0]['proxies'].insert(0, "HK")
    if len(Allproxies) > 0:
        content['proxy-groups'].append({'name': "AllLatency", 'type': "url-test", 'proxies': Allproxies,
                                       'url': 'http://www.google.com/generate_204', 'interval': 300, 'tolerance': 50, })
        content['proxy-groups'].append({'name': "AllSelect", 'type': "select", 'proxies': Allproxies,
                                       'url': 'http://cp.cloudflare.com/generate_204', 'interval': 300, 'tolerance': 50, })
        content["proxy-groups"][0]['proxies'].insert(0, "AllLatency")
        content["proxy-groups"][0]['proxies'].append("AllSelect")

    content['dns'] = {
        'enable': True,
        'ipv6': False,
        'default-nameserver': ['223.5.5.5', '223.6.6.6', '119.29.29.29', '192.168.1.1'],
        'enhanced-mode': 'redir-host',
        'fake-ip-range': '198.18.0.1/16',
        'use-hosts': True,
        'nameserver': [
            'tls://1.12.12.12',
            'tls://120.53.53.53',
            'tls://223.5.5.5',
            'tls://223.6.6.6',
            'tls://rubyfish.cn',
            'tls://v.233py.com',
        ],
        'fallback': [
            'tls://1.0.0.1',
            'tls://1.1.1.1',
            'tls://185.222.222.222',
            'tls://45.11.45.11',
            'tls://8.8.8.8',
            'tls://8.8.4.4',
        ],
        "fallback-filter": {'geoip': True, ' ipcidr': ["240.0.0.0/4", "127.0.0.1/8", "0.0.0.0/32"]},
    }
    return yaml.safe_dump(content)


print(precompile(subscribe_urls))
