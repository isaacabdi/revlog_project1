
# python3 db_utility.py


# monitors generated logfile txt app.log? use tail or grep

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

echo "$(date '+%Y-%m-%d %H:%M:%S') - Starting log monitor script." >> "$SCRIPT_LOGFILE"

grep -E "ERROR|FATAL" $LOGFILE > $ESCALATEFILE

#grep "ERROR" /home/isaacabdi/revature/project1/logfiles/app.log > $ESCALATEFILE
#grep "FATAL" /home/isaacabdi/revature/project1/logfiles/app.log > $ESCALATEFILE

# Process escalate.log with awk inserts to psql database 



# Insert into PostgreSQL
# system("PGPASSWORD=" DB_PASS " psql -U " DB_USER " -d " DB_NAME " -c \"INSERT INTO logs (timestamp, level, message) VALUES (\'" TIMESTAMP "\', \'" LEVEL "\', \'" MESSAGE "\');\"");