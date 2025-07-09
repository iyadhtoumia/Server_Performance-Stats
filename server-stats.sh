#!/bin/bash

echo "===== SERVER STATISTICS ====="
echo ""

# Total CPU usage
echo ">> Total CPU Usage:"
top -bn1 | grep "Cpu(s)" | awk '{print "Used: " $2 + $4 "%", " | Idle: " $8 "%"}'
echo ""

# Total memory usage (free vs used)
echo ">> Memory Usage:"
free -m | awk 'NR==2{ 
    total=$2; 
    used=$3; 
    free=$4;
    printf "Total: %s MB | Used: %s MB (%.2f%%) | Free: %s MB (%.2f%%)\n", total, used, used*100/total, free, free*100/total 
}'
echo ""

# Total disk usage (free vs used)
echo ">> Disk Usage (/):"
df -h / | awk 'NR==2{ 
    printf "Total: %s | Used: %s (%.2f%%) | Free: %s\n", $2, $3, ($3/$2)*100, $4 
}'
echo ""

# Top 5 processes by CPU usage
echo ">> Top 5 processes by CPU usage:"
ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6
echo ""

# Top 5 processes by memory usage
echo ">> Top 5 processes by Memory usage:"
ps -eo pid,comm,%mem --sort=-%mem | head -n 6
echo ""
