#!/usr/bin/env bash

## in crontab
# 0 6 * * * /root/run-rclone-backup.sh

REMOTE=ustc-1drv-rw
AREA=us
LIST="etc/ddns etc/wireguard"


for DIR in $LIST
do
    rclone sync /$DIR $REMOTE:vps/$AREA/$DIR
    # rclone copy $REMOTE:vps/$AREA/$DIR /$DIR # for rollback
done
