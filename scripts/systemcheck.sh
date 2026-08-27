#!/bin/bash

HOSTNAME=$(hostname)
CURRENT_USER=$(whoami)
IP_ADDRESS=$(hostname -I)
UPTIME=$(uptime -p)

echo "======SYSTEM HEALTH CHECK======"

echo
echo "Hostname     : $HOSTNAME"
echo "Curreny user : $CURRENT_USER"
echo "IP Address   : $IP_ADDRESS"
echo "Uptime       : $UPTIME"


echo
echo "Memory:"
free -h

CPU_IDLE=$(top -bn1 | awk '/Cpu\(s\)/ {print $8}')
CPU_USAGE=$(awk "BEGIN {print 100 - $CPU_IDLE}")

echo
echo "CPU Usage : $CPU_USAGE%"

if awk "BEGIN {exit !($CPU_USAGE >= 80)}"; then
    echo "CPU Status : WARNING - CPU usage is high"
else
    echo "CPU Status : OK"
fi

echo
echo "Disk Usage:"
df -h /

DISK_USAGE=$(df -P / | awk 'NR==2 {gsub("%","",$5); print $5}')

echo
echo "Disk Usage Percentage: $DISK_USAGE%"

if [ "$DISK_USAGE"  -ge 80 ]; then
	echo "Disk Status : Warning - Disk usage is high"
else  
	echo "Disk Status : OK"
fi

echo 
echo "Checking SSH Service"

if systemctl is-active --quiet ssh; then
	echo "SSH Status   : Running"
else 
	echo " SSH status  : Not Running"
fi

echo
echo "Checking CRON service"
if systemctl is-active --quiet cron; then
	echo "Cron status  : Running"
else
	echo "Cron status  : Not Running"
fi

echo
echo "=======Check Completed======"
