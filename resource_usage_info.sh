#!/bin/bash

log_file=/home/tuttu/system.log

date=$(date "+%d-%m-%Y %H:%M:%S")

hostname=$(hostname)

cpu_load=$( top -b -n 2 -d1 | grep "Cpu(s)"| tail -n1 | awk '{print $2}')

load_average=$( uptime| awk '{print $7,$8,$9,$10}')

memory_usage=$( free -mh | xargs | awk '{ print "Total/Free memory : " $8 " / " $12   }')

echo "$date $hostname Load_average: $load_average CPU_load= $cpu_load Memory_usage: $memory_usage" >>  $log_file



