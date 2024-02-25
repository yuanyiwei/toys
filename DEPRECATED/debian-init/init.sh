#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "This script (for Debian and Ubuntu) need to run as root"
  exit
fi


## mainly for foreign x64 Debian VPSs


## change source in china
# sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list
# sed -i 's/security.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list

# sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list
# sed -i 's|security.debian.org/debian-security|mirrors.ustc.edu.cn/debian-security|g' /etc/apt/sources.list

## sourcelist example in hk
# deb https://mirrors.xtom.com.hk/debian/ bullseye main non-free contrib
# deb https://mirrors.xtom.com.hk/debian-security/ bullseye-security main
# deb https://mirrors.xtom.com.hk/debian/ bullseye-updates main non-free contrib
# deb https://mirrors.xtom.com.hk/debian/ bullseye-backports main non-free contrib

# apt upgrade --without-new-pkgs
# apt full-upgrade
# apt autoremove --purge
# apt update && apt upgrade


# export DEBIAN_FRONTEND=noninteractive
apt update -qq
apt upgrade -qqy
## should update to stable first and use `apt upgrade --without-new-pkgs` and `apt full-upgrade`
apt install -qqy git curl python3 jq tmux vim iptables-persistent htop dnsutils mtr-tiny lsof dos2unix # zsh python3-pip # wget socat fail2ban # (fail2ban with python2.7 in buster)
apt install -qqy nload vnstat sysstat # bmon iftop vnstati
systemctl enable --now watchdog
# apt install -qqy wireguard # resolvconf iptraf-ng
# apt install -qqy ipset ipset-persistent
# apt install -qqy proxychains4

# apt install bird2 -t bullseye-backports # (backports)

# apt install -qqy docker.io docker-compose # (with python2.7 in buster)
## apt install apparmor apparmor-utils # fix apparmor error on hetzner
# echo '{
#   "iptables": false
# }' > /etc/docker/daemon.json
# reboot # no save iptables of docker

## can add netdata, cockpit, glances (python) or telegraf later to monitor vps


## SSH
mkdir /root/.ssh 2>&1
curl https://github.com/yuanyiwei.keys > /root/.ssh/authorized_keys
chmod 644 /root/.ssh/authorized_keys
chmod 755 /root/.ssh # ? Authentication refused: bad ownership or modes for directory /home/yyw/.ssh

cp /etc/ssh/sshd_config /etc/ssh/sshd_config.backup
sed -i 's/^.\?Port .*/Port 22/' /etc/ssh/sshd_config
sed -i 's/^.\?PermitRootLogin .*/PermitRootLogin yes/' /etc/ssh/sshd_config
sed -i 's/^.\?PubkeyAuthentication .*/PubkeyAuthentication yes/' /etc/ssh/sshd_config
sed -i 's/^.\?PasswordAuthentication .*/PasswordAuthentication no/' /etc/ssh/sshd_config

systemctl restart sshd

sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

## use dotfiles repo instead
# sed -i 's/ZSH_THEME=.*/ZSH_THEME="ys"/' /root/.zshrc
# echo 'precmd () { echo -n "\x1b]1337;CurrentDir=$(pwd)\x07" }' >> /root/.zshrc # For OSC1337
# chsh -s /usr/bin/zsh
# echo 'set -g mouse on' >> /root/.tmux.conf

# echo -e "[user]\n\tname = totoro\n\temail = totoro@yyw.moe" > /root/.gitconfig
## use gpg in desktop
# echo -e "[user]\n\tname = totoro\n\temail = totoro@yyw.moe\n\tsigningkey = 544765FB\n[commit]\n\tgpgSign = true" > /root/.gitconfig
# gpg --import-options restore --import private.gpg
# expect -c 'spawn gpg --edit-key EDE2551D6DE7B751168AE6FCD546F016544765FB trust quit; send "5\ry\r"; expect eof'


ln -sf /usr/share/zoneinfo/Asia/Hong_Kong /etc/localtime


## add ipset to ACCEPT
# ipset create whitelist hash:net
# iptables -A INPUT -m set --match-set whitelist src -j ACCEPT
# ipset add whitelist xxx
# /etc/init.d/ipset-persistent save

## save iptables
iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -p icmp -j ACCEPT
iptables -A INPUT -p udp -j ACCEPT
iptables -A INPUT -p tcp --dport 22 -j ACCEPT
iptables -A INPUT -p tcp --dport 443 -j ACCEPT
iptables -A INPUT -p tcp --dport 80 -j ACCEPT
iptables -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A INPUT -p tcp --tcp-flags RST RST -j DROP
iptables -A INPUT -p tcp --tcp-flags ALL RST,ACK -j DROP
iptables -A INPUT -p tcp --tcp-flags ALL RST -j DROP
iptables -P INPUT DROP
iptables -A OUTPUT -p tcp --dport 25 -j DROP
iptables -A OUTPUT -p tcp --dport 465 -j DROP
iptables -A OUTPUT -p tcp --dport 587 -j DROP
/etc/init.d/netfilter-persistent save


## for rclone, copy to ~/.config/rclone/config.conf , run rclone first to creat path
# apt install -qqy rclone
# rclone mount backup:/backup /srv

## backup
# mkdir /root/backup -p
# curl https://raw.githubusercontent.com/yuanyiwei/toys/master/vps-backup/backup.sh -OL
# mv ./backup.sh /root
## do not mix tmp backup script with the specific one in rclone

## gost
# gost_version=2.11.1
# wget https://github.com/ginuerzh/gost/releases/download/v${gost_version}/gost-linux-amd64-${gost_version}.gz
# gzip -d gost-linux-amd64-${gost_version}.gz
# chmod +x gost-linux-amd64-${gost_version}
# mv gost-linux-amd64-${gost_version} /usr/local/bin/gost

## ddns, for config.json in /etc/ddns and edit first
# wget https://github.com/NewFuture/DDNS/releases/download/v2.10.3/ddns
# chmod +x ddns
# mv ddns /usr/local/bin
# # cd /etc/ddns && ddns

## acme
# wget -O -  https://get.acme.sh | sh
# source ~/.zshrc
# acme.sh --upgrade --auto-upgrade
# acme.sh --issue --standalone --server letsencrypt -d s.yyw.moe --keylength ec-256
# acme.sh --install-cert -d s.yyw.moe --ecc --fullchain-file ~/tls/cert.crt --key-file ~/tls/cert.key