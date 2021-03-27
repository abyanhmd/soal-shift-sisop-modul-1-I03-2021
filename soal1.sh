#!/bin/bash

# 1A
loginfo="$(grep -E 'INFO' syslog.log)"
logerror="$(grep -E 'ERROR' syslog.log)"
echo $loginfo >> report.csv
echo $logerror >> report.csv

# 1B
denyinfo="$(grep -E 'Permission denied while closing ticket' syslog.log | wc -l)"
modinfo="$(grep -E 'The ticket was modified while updating' syslog.log | wc -l)"
closedinfo="$(grep -E 'Tried to add information to closed ticket' syslog.log | wc -l)"
timeinfo="$(grep -E 'Timeout while retrieving information' syslog.log | wc -l)"
existinfo="$(grep -E 'exist' syslog.log | wc -l)"
connectinfo="$(grep -E 'Connection to DB failed' syslog.log | wc -l)"
echo "Permission denied while closing ticket: $denyinfo" >> report.csv
echo "The ticket was modified while updating: $modinfo" >> report.csv
echo "Tried to add information to closed ticket: $closedinfo" >> report.csv
echo "Timeout while retrieving information: $timeinfo" >> report.csv
echo "Ticket doesn't exist: $existinfo" >> report.csv
echo "Connection to DB failed: $connectinfo" >> report.csv

# 1C
totalinf="$(grep -E -o 'INFO.*' syslog.log | cut -d"(" -f2 | cut -d")" -f1 | sort -d | uniq -c)"
totalerr="$(grep -E -o 'ERROR.*' syslog.log | cut -d"(" -f2 | cut -d")" -f1 | sort -d | uniq -c)"

# 1D
echo "Error, Count" >> error_message.csv
echo "Timeout while retrieving information, $timeinfo" >> error_message.csv
echo "Failed to connect to DB, $connectinfo" >> error_message.csv
echo "Tried to add information to closed ticket, $closedinfo" >> error_message.csv
echo "Permission denied, $denyinfo" >> error_message.csv
echo "The ticket was modified while updating, $modinfo" >> error_message.csv
echo "File not found, $existinfo" >> error_message.csv
