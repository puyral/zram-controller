#!/bin/env bash
shift 1
#echo "$1 $2 $3 $4 $5 $6"

threshold=$1
disk_size=$2
n_disk=$3
priority=$4
algo=$5
upp_threshold=$(($threshold + $n_disk*$disk_size + 10*1024*1024));

while :
do
  offset=$(swapon --bytes | awk -v to_ignore=$6 '$1==to_ignore {print $3}')
  free_mem=$(free -b -t | awk 'FNR == 4 {print $4}')
  free_swap=$(free -b -t | awk 'FNR == 3 {print $4}')
  av_mem=$(($free_mem - $offset))
  av_swap=$(($free_swap - $offset))

  if [ $av_mem -lt $threshold ]
  then
    ./add_zram.sh ${disk_size}b $algo $priority
  fi

  if [ $av_swap -gt $upp_threshold ]
  then
    echo "delete";
    ./delete_zram.sh
  fi
  sleep $7;
done
