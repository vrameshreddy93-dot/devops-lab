#!/bin/bash

LOG_FILE="$HOME/devops-lab/logs/system-health.log"

exec > >(tee -a "$LOG_FILE") 2>&1

TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

echo "===== DEVOPS SYSTEM CHECK ====="

echo "Timestamp : $TIMESTAMP"

# Disk check
DISK_USAGE=$(df -P / | awk 'NR==2 {gsub("%","",$5); print $5}')

echo
echo "Disk Usage: ${DISK_USAGE}%"

if [ "$DISK_USAGE" -ge 80 ]; then
    echo "Disk Status: WARNING"
elif [ "$DISK_USAGE" -ge 60 ]; then
    echo "Disk Status: CAUTION"
else
    echo "Disk Status: OK"
fi

# Cpu Check

CPU_USAGE=$(top -bn1 | awk '/Cpu\(s\)/ {print 100 - $8}')

CPU_USAGE=${CPU_USAGE%.*}

echo
echo "CPU usage : ${CPU_USAGE}%"

if [ "$CPU_USAGE"  -ge 80 ]; then
	echo "CPU Status : Warning"
elif [ "$CPU_USAGE" -ge 60 ]; then
	echo "CPU Status : Caution"
else
	echo "CPU Status : OK"
fi 

# Memory Check
 
Memory_Usage=$(free | awk '/Mem:/ {printf "%.0f", ($3/$2)*100}')

echo
echo "Memory Usage : ${Memory_Usage}%"

if [ "$Memory_Usage" -ge 80 ]; then 
	echo "Memory Status : Warning"
elif [ "$Memory_Usage" -ge 60 ]; then
	echo "Memory Status : Critical"
else
	echo "Memory Status : OK"
fi

# Function to check services
check_service() {
    SERVICE=$1

    if systemctl is-active --quiet "$SERVICE"; then
        echo "$SERVICE : Running"
    else
        echo "$SERVICE : Not Running"
    fi
}

echo
echo "Services:"
check_service ssh
check_service cron

echo
echo "===== CHECK COMPLETED ====="
