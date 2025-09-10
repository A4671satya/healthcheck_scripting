git push -u origin main#!/bin/bash

# healthcheck.sh
# A simple health check script that logs system information

LOG_FILE="healthlog.txt"
TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")

{
  echo "================= System Health Check ================="
  echo "Timestamp: $TIMESTAMP"
  echo "--------------------------------------------------------"
  
  echo " Date & Time:"
  date
  echo "--------------------------------------------------------"

  echo " Uptime:"
  uptime
  echo "--------------------------------------------------------"

  echo " CPU Load (uptime):"
  uptime | awk -F'load average:' '{ print $2 }'
  echo "--------------------------------------------------------"

  echo " Memory Usage (MB):"
  free -m
  echo "--------------------------------------------------------"

  echo " Disk Usage:"
  df -h
  echo "--------------------------------------------------------"

  echo " Top 5 Memory-Consuming Processes:"
  ps aux --sort=-%mem | head -n 6
  echo "--------------------------------------------------------"

  echo " Service Status:"
  for service in nginx ssh; do
    if systemctl is-active --quiet $service; then
      echo "$service is running "
    else
      echo "$service is NOT running "
    fi
  done
  echo "========================================================"
  echo
} >> "$LOG_FILE"

echo "Health check completed. Results appended to $LOG_FILE"

