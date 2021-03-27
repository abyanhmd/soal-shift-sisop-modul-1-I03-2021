#!/bin/bash

# 1A
loginfo="$(grep -E 'INFO' /var/log/syslog)"
logerror="$(grep -E 'ERROR' /var/log/syslog)"
echo $loginfo >> pertama.txt
echo $logerror >> pertama.txt

# 1B
echo $logerror >> pertama.txt
sumloginfo="$(grep -E 'ERROR' /var/log/syslog | wc -l)"
echo $sumloginfo >> pertama.txt"

# 1C
