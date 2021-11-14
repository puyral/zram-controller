#n_swap=$(swapon --noheading | wc -l)
last=$(swapon --noheading --bytes | sort -nk4 | awk '$1~/\/dev\/zram.*/ {print $1 }' | head -1)
#last=$(find /sys/block -name "zram*" | sort -n | tail -1)
i=${last/\/dev\/zram/}
if [ -z $last ]
then
  exit 1
fi
swapoff "/dev/zram$i";
echo "$i" > /sys/class/zram-control/hot_remove
