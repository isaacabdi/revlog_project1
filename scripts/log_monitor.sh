
# python3 db_utility.py
# Filter ERROR and FATAL entries and insert them 
# into a PostgreSQL database using db_utility.py

#!/bin/bash
ESCALATEFILE="/home/isaacabdi/revature/project1/logfiles/escalate.log"
LOGFILE="/home/isaacabdi/revature/project1/logfiles/app.log"
SCRIPT_LOGFILE="/home/isaacabdi/revature/project1/logfiles/test.txt"


DB_NAME='project1'  # Replace with your database name
USER='isaacabdi'  # Replace with your PostgreSQL username
PASSWORD='temp1x556!'    # Your PostgreSQL password
HOST='localhost'  # or '127.0.0.1'
PORT='5432'  # Default PostgreSQL port

while read line; do
	# timestamp field
	TIMESTAMP=$(echo $line | awk '{print $1, $2}')
	# level field
	LEVEL=$(echo $line | grep -o 'ERROR\|FATAL')
	# message field
	MESSAGE=$(echo $line | awk -F '] ' '{print $2}' | sed "s/'/''/g")
    #insertion
	PGPASSWORD=$PASSWORD psql -U $USER -d $DB_NAME -c "INSERT INTO urgentlog_entries (timestamplogged, level, message) VALUES ('$TIMESTAMP', '$LEVEL', '$MESSAGE')";

done < "$LOGFILE"