#!/bin/bash

# Path to the log file where log entries will be written
LOGFILE="/var/log/app.log"

# Infinite loop to continuously generate logs
while true; do
    # Get the current timestamp in the format 'YYYY-MM-DD HH:MM:SS'
    TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")
    
    # Randomly select a log level from INFO, WARNING, ERROR, and FATAL
    LEVEL=$(shuf -n 1 -e INFO WARNING ERROR FATAL)
    
    # Generate a log message based on the log level
    MESSAGE="This is a $LEVEL message"
    
    # Write the timestamp, log level, and message to the log file
    echo "$TIMESTAMP [$LEVEL] $MESSAGE" >> $LOGFILE
    
    # Wait for 5 seconds before generating the next log entry
    sleep 5
done