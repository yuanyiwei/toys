#!/usr/bin/env bash

tcp_tune(){ # 优化TCP窗口
sed -i '/net.ipv4.tcp_no_metrics_save/d' /etc/sysctl.conf
sed -i '/net.ipv4.tcp_ecn/d' /etc/sysctl.conf
sed -i '/net.ipv4.tcp_frto/d' /etc/sysctl.conf
sed -i '/net.ipv4.tcp_mtu_probing/d' /etc/sysctl.conf
sed -i '/net.ipv4.tcp_rfc1337/d' /etc/sysctl.conf
sed -i '/net.ipv4.tcp_sack/d' /etc/sysctl.conf
sed -i '/net.ipv4.tcp_fack/d' /etc/sysctl.conf
sed -i '/net.ipv4.tcp_window_scaling/d' /etc/sysctl.conf
sed -i '/net.ipv4.tcp_adv_win_scale/d' /etc/sysctl.conf
sed -i '/net.ipv4.tcp_moderate_rcvbuf/d' /etc/sysctl.conf
sed -i '/net.ipv4.tcp_rmem/d' /etc/sysctl.conf
sed -i '/net.ipv4.tcp_wmem/d' /etc/sysctl.conf
sed -i '/net.core.rmem_max/d' /etc/sysctl.conf
sed -i '/net.core.wmem_max/d' /etc/sysctl.conf
sed -i '/net.ipv4.udp_rmem_min/d' /etc/sysctl.conf
sed -i '/net.ipv4.udp_wmem_min/d' /etc/sysctl.conf
# sed -i '/net.core.default_qdisc/d' /etc/sysctl.conf
# sed -i '/net.ipv4.tcp_congestion_control/d' /etc/sysctl.conf
cat >> /etc/sysctl.conf << EOF
net.ipv4.tcp_no_metrics_save=1
net.ipv4.tcp_ecn=0
net.ipv4.tcp_frto=0
net.ipv4.tcp_mtu_probing=0
net.ipv4.tcp_rfc1337=0
net.ipv4.tcp_sack=1
net.ipv4.tcp_fack=1
net.ipv4.tcp_window_scaling=1
net.ipv4.tcp_adv_win_scale=1
net.ipv4.tcp_moderate_rcvbuf=1
net.core.rmem_max=16777216
net.core.wmem_max=16777216
net.ipv4.tcp_rmem=4096 87380 16777216
net.ipv4.tcp_wmem=4096 16384 16777216
net.ipv4.udp_rmem_min=8192
net.ipv4.udp_wmem_min=8192
EOF
# net.core.default_qdisc=fq
# net.ipv4.tcp_congestion_control=bbr
sysctl -p && sysctl --system
}

enable_forwarding(){ #开启内核转发
sed -i '/net.ipv4.conf.all.route_localnet/d' /etc/sysctl.conf
sed -i '/net.ipv4.ip_forward/d' /etc/sysctl.conf
sed -i '/net.ipv4.conf.all.forwarding/d' /etc/sysctl.conf
sed -i '/net.ipv4.conf.default.forwarding/d' /etc/sysctl.conf
cat >> '/etc/sysctl.conf' << EOF
net.ipv4.conf.all.route_localnet=1
net.ipv4.ip_forward=1
net.ipv4.conf.all.forwarding=1
net.ipv4.conf.default.forwarding=1
EOF
sysctl -p && sysctl --system
}

ulimit_tune(){ #系统资源限制调优
echo "1000000" > /proc/sys/fs/file-max
sed -i '/fs.file-max/d' /etc/sysctl.conf
cat >> '/etc/sysctl.conf' << EOF
fs.file-max=1000000
EOF

ulimit -SHn 1000000 && ulimit -c unlimited
echo "root     soft   nofile    1000000
root     hard   nofile    1000000
root     soft   nproc     1000000
root     hard   nproc     1000000
root     soft   core      1000000
root     hard   core      1000000
root     hard   memlock   unlimited
root     soft   memlock   unlimited

*     soft   nofile    1000000
*     hard   nofile    1000000
*     soft   nproc     1000000
*     hard   nproc     1000000
*     soft   core      1000000
*     hard   core      1000000
*     hard   memlock   unlimited
*     soft   memlock   unlimited
">/etc/security/limits.conf
if grep -q "ulimit" /etc/profile; then
  :
else
  sed -i '/ulimit -SHn/d' /etc/profile
  echo "ulimit -SHn 1000000" >>/etc/profile
fi
if grep -q "pam_limits.so" /etc/pam.d/common-session; then
  :
else
  sed -i '/required pam_limits.so/d' /etc/pam.d/common-session
  echo "session required pam_limits.so" >>/etc/pam.d/common-session
fi

sed -i '/DefaultTimeoutStartSec/d' /etc/systemd/system.conf
sed -i '/DefaultTimeoutStopSec/d' /etc/systemd/system.conf
sed -i '/DefaultRestartSec/d' /etc/systemd/system.conf
sed -i '/DefaultLimitCORE/d' /etc/systemd/system.conf
sed -i '/DefaultLimitNOFILE/d' /etc/systemd/system.conf
sed -i '/DefaultLimitNPROC/d' /etc/systemd/system.conf

cat >>'/etc/systemd/system.conf' <<EOF
[Manager]
#DefaultTimeoutStartSec=90s
DefaultTimeoutStopSec=30s
#DefaultRestartSec=100ms
DefaultLimitCORE=infinity
DefaultLimitNOFILE=65535
DefaultLimitNPROC=65535
EOF

systemctl daemon-reload
}

use_xanmod(){ #使用xanmod kernel
echo 'deb http://deb.xanmod.org releases main' | tee /etc/apt/sources.list.d/xanmod-kernel.list
wget -qO - https://dl.xanmod.org/gpg.key | apt-key --keyring /etc/apt/trusted.gpg.d/xanmod-kernel.gpg add -
# curl -s https://dl.xanmod.org/gpg.key | gpg --no-default-keyring --keyring gnupg-ring:/etc/apt/trusted.gpg.d/xanmod-kernel.gpg --import
apt -qq update && apt install -qqy linux-xanmod
# sysctl net.core.default_qdisc
# # net.core.default_qdisc = fq_pie
# sysctl net.ipv4.tcp_available_congestion_control
# # net.ipv4.tcp_available_congestion_control = reno bbr2
# lsmod | grep bbr
# apt purge linux-image-amd64
}

use_cloud(){ #使用cloud kernel
# https://raw.githubusercontent.com/jinwyp/one_click_script/master/install_kernel.sh
# https://hostloc.com/thread-644985-1-1.html
# 优质线路用5.5+cake和原版bbr带宽跑的更足，不过cake的话就算高峰也不会像原版bbr那样跑不动，相比plus能慢些，但是区别不大，
# bbr plus的话美西或者一些延迟高的，用起来更好，锐速针对丢包高的有奇效
# 带宽大，并且延迟低不丢包的话5.5+cake在我这比较好，延迟高用plus更好，丢包多锐速最好. 一般130ms以下用cake不错，以上的话用plus更好些
# https://github.com/xanmod/linux/issues/26
# 说白了 bbrplus 就是改了点东西，然后那部分修改在 5.1 内核里合并进去了, 5.1 及以上的内核里自带的 bbr 已经包含了所谓的 bbrplus 的修改。
# PS：bbr 是一直在修改的，比如说 5.0 内核的 bbr，4.15 内核的 bbr 和 4.9 内核的 bbr 其实都是不一样的

# https://raw.githubusercontent.com/ylx2016/Linux-NetSpeed/master/tcpx.sh

apt -qq update && apt install -qqy linux-image-cloud-amd64
sed -i '/net.core.default_qdisc/d' /etc/sysctl.conf
sed -i '/net.ipv4.tcp_congestion_control/d' /etc/sysctl.conf
# cat >> /etc/sysctl.conf << EOF
# net.core.default_qdisc=fq
# net.ipv4.tcp_congestion_control=bbr
# EOF
cat >> /etc/sysctl.conf << EOF
net.core.default_qdisc=cake
net.ipv4.tcp_congestion_control=bbr
EOF
sysctl -p && sysctl --system
# sysctl net.core.default_qdisc
# # net.core.default_qdisc = fq
# sysctl net.ipv4.tcp_available_congestion_control
# # net.ipv4.tcp_available_congestion_control = reno cubic bbr
# sysctl net.ipv4.tcp_allowed_congestion_control
# # net.ipv4.tcp_allowed_congestion_control = reno cubic bbr
# cat /proc/sys/net/ipv4/tcp_allowed_congestion_control
# # reno cubic bbr
# sysctl net.ipv4.tcp_congestion_control
# # net.ipv4.tcp_congestion_control = bbr
# cat /proc/sys/net/ipv4/tcp_congestion_control
# # bbr
# lsmod | grep bbr
# # tcp_bbr                20480  23
# apt purge linux-image-amd64
}

tcp_tune
# enable_forwarding
ulimit_tune
# use_xanmod
use_cloud
