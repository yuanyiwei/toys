#!/usr/bin/env bash

## in crontab
# 0 6 * * * /root/backup.sh

REMOTE=ustc-1drv-rw
# ruLIST="/etc/ddns /etc/wireguard /root/backup"
usLIST="/etc/ddns /etc/wireguard /root/ustc-checkin /root/backup /etc/iptables"
jpLIST="/etc/ddns /etc/wireguard /root/backup /etc/iptables"


AREA=jp
for DIR in $jpLIST
do
    rclone sync ${DIR} $REMOTE:vps/${AREA}${DIR}
    # rclone copy $REMOTE:vps/${AREA}${DIR} ${DIR} # for rollback
done
