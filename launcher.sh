#!/usr/bin/env zsh

./monitor.sh ./monitor.sh $((3*1024*1024*1024)) $((1024*1024*1024)) 1 100 zstd /dev/sda3 1
