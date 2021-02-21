



#!/bin/bash

log_file=/home/tuttu/system.log

date=$(date "+%d-%m-%Y %H:%M:%S")

hostname=$(hostname)

cpu_load=$( top -b -n 2 -d1 | grep "Cpu(s)"| tail -n1 | awk '{print $8}'| cut -c1-2)

load_average=$( uptime| awk '{print $9,$10,$11}')

memory_usage=$( free -mh | xargs | awk '{ print "Total/Free memory : " $8 " / " $12   }')

echo "$date $hostname Load_average: $load_average CPU_load: $cpu_load Memory_usage: $memory_usage" >>  $log_file

if [ $cpu_load -le 10 ]; then

  cpu_load_1="$date CPU: $cpu_load"
  echo "CRITICAL CPU USAGE !!!! : Idle_time : $cpu_load_1% >> /home/tuttu/cpu_usage.txt
  cat /home/tuttu/cpu_usage.txt | tail -5 >> /home/tuttu/cpu_usage.tmp
  mail -s "Cpu utilization of `hostname`" tuttu.777@gmail.com < /home/tuttu/cpu_usage.tmp

elif [ $cpu_load -ge 10 ] && [ $cpu_load -le 20 ]; then

  echo "$date: Warning !!!! : Idle_time : $cpu_load_1% >> /home/tuttu/cpu_usage.txt
  cat /home/tuttu/cpu_usage.txt | tail -5 >> /home/tuttu/cpu_usage.tmp
  mail -s "Cpu utilization of `hostname`" tuttu.777@gmail.com < /home/tuttu/cpu_usage.tmp

else

 echo "$date : Cpu usage is okay : Idle_time : $cpu_load%" >> /home/tuttu/cpu_usage.txt

fi
