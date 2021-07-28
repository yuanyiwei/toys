#!/usr/bin/env bash

docker run \
    --name rclone \
    --rm \
    -v /home/totoro/rclone-backup:/data:ro \
    -v /home/totoro/.config/rclone/:/config/rclone \
    rclone/rclone \
    sync /data 1drv:backup
