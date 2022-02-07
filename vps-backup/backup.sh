#!/usr/bin/env bash

## in crontab
# 0 6 * * * /root/backup/backup.sh

REMOTE=ustc-1drv-rw
# ruLIST="/etc/ddns /etc/wireguard /root/backup"
# usLIST="/etc/ddns /etc/wireguard /root/ustc-checkin /root/backup /etc/iptables"
# jpLIST="/etc/ddns /etc/wireguard /root/backup /etc/iptables"
LIST="/root/backup"


AREA=jp
for DIR in $LIST
do
    # rclone sync ${DIR} $REMOTE:vps/${AREA}${DIR}
    rclone copy $REMOTE:vps/${AREA}${DIR} ${DIR} # for rollback and init
done

## then use /root/backup/backup.sh to rollback

echo "$(hostname) backup ok"
