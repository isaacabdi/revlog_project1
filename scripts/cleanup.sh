#!/bin/bash

# Paths to log files
APP_LOG="/home/isaacabdi/revature/project1/logfiles/app.log"
ARCHIVE_LOG="/home/isaacabdi/revature/project1/logfiles/archive.log"
ESCALATE_LOG="/home/isaacabdi/revature/project1/logfiles/escalate.log"
TEST_LOG="/home/isaacabdi/revature/project1/logfiles/test.txt"

# Database connection details
DB_NAME='project1'  # Replace with your database name
USER='isaacabdi'  # Replace with your PostgreSQL username
PASSWORD='temp1x556!'    # Your PostgreSQL password
HOST='localhost'  # or '127.0.0.1'
PORT='5432'  # Default PostgreSQL port

# SQL query to delete entries older than 1 hour
SQL_QUERY="DELETE FROM urgentlog_entries WHERE timestampdatabase < NOW() - INTERVAL '1 hour';"

# Execute the deletion
PGPASSWORD="$PASSWORD" psql -h "$HOST" -U "$USER" -d "$DB_NAME" -p "$PORT" -c "$SQL_QUERY"

# Check the exit status of the psql command
if [ $? -eq 0 ]; then
    echo "Entries older than 1 hour deleted successfully."
else
    echo "Error deleting entries from the database."
fi

# Append the contents of app.log to archive.log before clearing
if [ -s "$APP_LOG" ]; then
    cat "$APP_LOG" >> "$ARCHIVE_LOG"
    echo "app.log contents archived to archive.log." >> "$TEST_LOG"
else
    echo "app.log is empty, nothing to archive." >> "$TEST_LOG"
fi

# Clear app.log and escalate.log
: > "$APP_LOG" && : > "$ESCALATE_LOG"

# Log that the files have been cleared
echo "Cleared app.log and escalate.log files." >> "$TEST_LOG"