#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "This script (for Debian and Ubuntu) need to run as root"
  exit
fi


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

apt update
apt upgrade
apt install git curl zsh python3 python3-pip jq tmux vim
# apt install proxychains4
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
sed -i 's/ZSH_THEME=.*/ZSH_THEME="ys"/' /root/.zshrc
echo 'set -g mouse on' >> /root/.tmux.conf


## for rclone, copy to ~/.config/rclone/config.conf
# apt install rclone
# rclone mount backup:/backup /srv
