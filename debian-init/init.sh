#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "This script (for Debian and Ubuntu) need to run as root"
  exit
fi


## mainly for foreign x64 VPSs


## SSH
cp /etc/ssh/sshd_config /etc/ssh/sshd_config.backup
sed -i 's/.PermitRootLogin .*/PermitRootLogin yes/' /etc/ssh/sshd_config
sed -i 's/.PubkeyAuthentication .*/PubkeyAuthentication yes/' /etc/ssh/sshd_config
sed -i 's/.PasswordAuthentication .*/PasswordAuthentication no/' /etc/ssh/sshd_config

mkdir /root/.ssh 2>&1
curl https://github.com/yuanyiwei.keys > /root/.ssh/authorized_keys
chmod 644 /root/.ssh/authorized_keys

systemctl restart sshd


## change source in china
# sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list
# sed -i 's/security.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list

# sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list
# sed -i 's|security.debian.org/debian-security|mirrors.ustc.edu.cn/debian-security|g' /etc/apt/sources.list


# export DEBIAN_FRONTEND=noninteractive
apt update -qq
apt upgrade -qqy
apt install -qqy git curl zsh python3 python3-pip jq tmux vim fail2ban iptables-persistent
# apt install -qqy proxychains4
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
sed -i 's/ZSH_THEME=.*/ZSH_THEME="ys"/' /root/.zshrc
# echo 'set -g mouse on' >> /root/.tmux.conf


## save iptables
iptables -A INPUT -p tcp --dport 22 -j ACCEPT
iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -p udp --dport 4600 -j ACCEPT
iptables -A INPUT -p udp --dport 4700 -j ACCEPT
iptables -A INPUT -p udp --dport 443 -j ACCEPT
iptables -A INPUT -p udp --dport 80 -j ACCEPT
iptables -A INPUT -p tcp --dport 443 -j ACCEPT
iptables -A INPUT -p tcp --dport 80 -j ACCEPT
iptables -A INPUT -i vpn+ -j ACCEPT
iptables -A INPUT -i wg+ -j ACCEPT
iptables -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -P INPUT DROP
/etc/init.d/netfilter-persistent save


## for rclone, copy to ~/.config/rclone/config.conf
apt install -qqy rclone
# rclone mount backup:/backup /srv


## gost
wget https://github.com/ginuerzh/gost/releases/download/v2.11.1/gost-linux-amd64-2.11.1.gz
gzip -d gost-linux-amd64-2.11.1.gz
chmod +x gost-linux-amd64-2.11.1
mv gost-linux-amd64-2.11.1 /usr/local/bin/gost


## ddns, for config.json in /etc/ddns and edit first
wget https://github.com/NewFuture/DDNS/releases/download/v2.10.2/ddns
chmod +x ddns
mv ddns /usr/local/bin
# cd /etc/ddns && ddns


## nali
curl https://github.com/zu1k/nali/releases/download/v0.3.1/nali-linux-amd64-v0.3.1.gz -OL
gzip -d nali-linux-amd64-v0.3.1.gz
chmod +x nali-linux-amd64-v0.3.1
mv nali-linux-amd64-v0.3.1 /usr/local/bin
