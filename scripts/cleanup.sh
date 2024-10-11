#cleanup old db logs
#clear app.log txt file?
#!/bin/bash

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

#Clear app.log txt
: > "/home/isaacabdi/revature/project1/logfiles/app.log"
# Log that the file has been cleared
echo "Cleared app.log file." >> "/home/isaacabdi/revature/project1/logfiles/test.txt"