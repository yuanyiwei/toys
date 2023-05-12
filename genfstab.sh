#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Usage: createfstab /dev/sdb /mnt/hdd"
    exit 1
fi

uuid=$(blkid | grep $1 | grep -o " UUID=.[0-9a-zA-Z-]\\+" | sed 's/\"//g' | sed 's/^ //g')
type=$(blkid | grep $1 | grep -o " TYPE=\"[0-9a-z]*"  | sed 's/TYPE=\"//g' | sed 's/^ //g')
path=$2

if [ -z "$uuid" -o -z "$type" ]; then
    echo "no such device"
    exit 1
fi

echo "Fstab content is: $uuid $path $type defaults,nofail 0 0"
echo "You should do this first: mkdir -p $path"
