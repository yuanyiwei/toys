#!/bin/bash

## upstream: https://github.com/felixonmars/dnsmasq-china-list/blob/master/accelerated-domains.china.conf and https://github.com/17mon/china_ip_list/blob/master/china_ip_list.txt

curl -o '/var/tmp/chinalist.txt' -L https://github.com/felixonmars/dnsmasq-china-list/raw/master/accelerated-domains.china.conf
sed -i 's|/114.114.114.114$||g' '/var/tmp/chinalist.txt'
sed -i 's|^server=/|domain=|g' '/var/tmp/chinalist.txt'
sed -i 's|^\#.*||g' '/var/tmp/chinalist.txt'
sed -i 's|^domain=$||g' '/var/tmp/chinalist.txt'

curl -o '/var/tmp/chinaip.txt' -L https://github.com/17mon/china_ip_list/raw/master/china_ip_list.txt
sed -i 's|^|cidr=|g' '/var/tmp/chinaip.txt'
sed -i 's|^cidr=$||g' '/var/tmp/chinaip.txt'

cat '/var/tmp/chinalist.txt' '/var/tmp/chinaip.txt' > chn-ip.rule
rm -f '/var/tmp/chinalist.txt' '/var/tmp/chinaip.txt'
