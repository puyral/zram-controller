#!/bin/env bash
#echo "$1 $2 $3"
max_swap=20
n_swap=$(swapon --noheading | wc -l)
if [ $n_swap -gt $max_swap ]
then
  exit 1
fi
zram=$(cat /sys/class/zram-control/hot_add);
if [ $zram -lt 0 ]
then
  exit 1
fi
echo $2 > "/sys/block/zram$zram/comp_algorithm";
echo $1 > "/sys/block/zram$zram/disksize";

mkswap "/dev/zram$zram";
swapon --priority $3 "/dev/zram$zram";
echo $zram
