#!/bin/bash

check-service() { 
     
    SERVICE=$1

    if systemctl is-active --quiet "$SERVICE"; then
	    echo "$SERVICE : Running"
     else
	     echo "$SERVICE : Not Running"
     fi
}



check-service ssh
check-service cron
