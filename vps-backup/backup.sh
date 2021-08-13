#!/usr/bin/env bash

## in crontab
# 0 6-12/3 * * * /root/backup.sh

REMOTE=ustc-1drv-rw
AREA=ru
LIST="ddns wireguard"


for DIR in $LIST
do
    rclone sync /etc/$DIR $REMOTE:vps/$AREA/$DIR
    # rclone copy $REMOTE:vps/$AREA/$DIR /etc/$DIR # for rollback
done
