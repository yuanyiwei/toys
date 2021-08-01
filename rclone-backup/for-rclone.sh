#!/bin/bash

# backup /path/to/home/*/public

dir=/path/to/home

for user in $(ls $dir)
do
    for data in $(ls $dir/$user)
    do
        if [ $data == "public" ]
        then
        echo "Now backup $dir/$user/$data to 1drv:/home/$user"
        docker run \
            --name rclone-$user \
            --rm \
            -v $dir/$user/$data:/data:ro \
            -v /home/totoro/.config/rclone/:/config/rclone \
            rclone/rclone \
            sync /data 1drv:home/$user
        fi
    done
done
