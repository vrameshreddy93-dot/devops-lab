#!/bin/bash

DISK_USAGE=$(df -P / | awk 'NR==2 {gsub("%","",$5); print $5}')

if [ "$DISK_USAGE" -ge 80 ]; then
    echo "Disk Status : WARNING - Usage is ${DISK_USAGE}%"
elif [ "$DISK_USAGE" -ge 60 ]; then
    echo "Disk Status : CAUTION - Usage is ${DISK_USAGE}%"
else
    echo "Disk Status : OK - Usage is ${DISK_USAGE}%"
fi
