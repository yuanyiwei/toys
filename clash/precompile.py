import requests
import yaml
# pyyaml

subscribe_urls = [
    'https://sub.yyw.moe',
]

Rules = [
    "DOMAIN-SUFFIX,ip6-localhost,DIRECT",
    "DOMAIN-SUFFIX,ip6-loopback,DIRECT",
    "DOMAIN-SUFFIX,local,DIRECT",
    "DOMAIN-SUFFIX,localhost,DIRECT",
    "IP-CIDR,10.0.0.0/8,DIRECT,no-resolve",
    "IP-CIDR,100.64.0.0/10,DIRECT,no-resolve",
    "IP-CIDR,127.0.0.0/8,DIRECT,no-resolve",
    "IP-CIDR,172.16.0.0/12,DIRECT,no-resolve",
    "IP-CIDR,192.168.0.0/16,DIRECT,no-resolve",
    "IP-CIDR,198.18.0.0/16,DIRECT,no-resolve",
    "IP-CIDR6,::1/128,DIRECT,no-resolve",
    "IP-CIDR6,fc00::/7,DIRECT,no-resolve",
    "IP-CIDR6,fe80::/10,DIRECT,no-resolve",
    "IP-CIDR6,fd00::/8,DIRECT,no-resolve",

    "DOMAIN-SUFFIX,ads.gmodules.com,REJECT",
    "DOMAIN-SUFFIX,ads.google.com,REJECT",
    "DOMAIN-SUFFIX,adservice.google.com,REJECT",
    "DOMAIN-SUFFIX,afd.l.google.com,REJECT",
    "DOMAIN-SUFFIX,badad.googleplex.com,REJECT",
    "DOMAIN-SUFFIX,csi.gstatic.com,REJECT",
    "DOMAIN-SUFFIX,google-analytics.com,REJECT",
    "DOMAIN-SUFFIX,googleadservices.com,REJECT",
    "DOMAIN-SUFFIX,googleadsserving.cn,REJECT",
    "DOMAIN-SUFFIX,googlecommerce.com,REJECT",
    "DOMAIN-SUFFIX,googlesyndication.com,REJECT",
    "DOMAIN-SUFFIX,mobileads.google.com,REJECT",
    "DOMAIN-SUFFIX,pagead-tpc.l.google.com,REJECT",
    "DOMAIN-SUFFIX,pagead.google.com,REJECT",
    "DOMAIN-SUFFIX,pagead.l.google.com,REJECT",

    "DOMAIN,dl.google.com,DIRECT",
    "DOMAIN-SUFFIX,fonts.googleapis.com,DIRECT",
    "DOMAIN-SUFFIX,fonts.gstatic.com,DIRECT",
    "DOMAIN-SUFFIX,alt1-mtalk.google.com,DIRECT",
    "DOMAIN-SUFFIX,alt2-mtalk.google.com,DIRECT",
    "DOMAIN-SUFFIX,alt3-mtalk.google.com,DIRECT",
    "DOMAIN-SUFFIX,alt4-mtalk.google.com,DIRECT",
    "DOMAIN-SUFFIX,alt5-mtalk.google.com,DIRECT",
    "DOMAIN-SUFFIX,alt6-mtalk.google.com,DIRECT",
    "DOMAIN-SUFFIX,alt7-mtalk.google.com,DIRECT",
    "DOMAIN-SUFFIX,alt8-mtalk.google.com,DIRECT",
    "GEOIP,CN,DIRECT",
]


def precompile(subscribe_url):
    return_content = requests.get(subscribe_url, headers={
                                  'user-agent': 'clash'}).text
    content = yaml.safe_load(return_content)
    content['rules'] = Rules
    content['proxy-groups'] = [{'name': 'Select',
                                'type': 'select', 'proxies': []}]
    content['rules'].append("MATCH," + content['proxy-groups'][0]['name'])

    HKLBproxies = []
    Latencyproxies = []
    AllSelectproxies = []

    for proxy in content['proxies']:
        if proxy['server'] == '127.0.0.1':
            continue
        if proxy['name'].find('Hong Kong') != -1 or proxy['name'].find('HK') != -1 or proxy['name'].find('hk') != -1 or proxy['name'].find('l') != -1:
            HKLBproxies.append(proxy['name'])
        if proxy['name'].find('out') == -1:
            Latencyproxies.append(proxy['name'])
        AllSelectproxies.append(proxy['name'])

    if len(HKLBproxies) > 0:
        content['proxy-groups'].append({'name': "HKLB", 'type': "load-balance", 'proxies': HKLBproxies,
                                       'url': 'http://cp.cloudflare.com/generate_204', 'interval': 300, })
        content["proxy-groups"][0]['proxies'].insert(0, "HKLB")
    if len(Latencyproxies) > 0:
        content['proxy-groups'].append({'name': "AllLatency", 'type': "url-test", 'proxies': Latencyproxies,
                                       'url': 'http://cp.cloudflare.com/generate_204', 'interval': 300, 'tolerance': 50, })
        content["proxy-groups"][0]['proxies'].insert(0, "AllLatency")
    if len(AllSelectproxies) > 0:
        content['proxy-groups'].append({'name': "AllSelect", 'type': "select", 'proxies': AllSelectproxies,
                                       'url': 'http://cp.cloudflare.com/generate_204', 'interval': 300, 'tolerance': 50, })
        content["proxy-groups"][0]['proxies'].insert(0, "AllSelect")

    content['dns'] = {
        'enable': True,
        'ipv6': False,
        'default-nameserver': ['223.5.5.5', '119.29.29.29', '192.168.1.1'],
        'enhanced-mode': 'redir-host',
        'fake-ip-range': '198.18.0.1/16',
        'use-hosts': True,
        'nameserver': [
            "https://doh.pub/dns-query",
            "https://dns.alidns.com/dns-query",
            "https://i.233py.com/dns-query",
        ],
        'fallback': [
            "tls://1.0.0.1:853",
            "tls://dot.sb:853",
            "https://doh.sb/dns-query",
            "https://cloudflare-dns.com/dns-query",
            "https://dns.google/dns-query",
        ],
        "fallback-filter": {'geoip': True, ' ipcidr': ["240.0.0.0/4", "0.0.0.0/32"]},
    }
    return yaml.safe_dump(content)


for subscribe_url in subscribe_urls:
    print(precompile(subscribe_url))
