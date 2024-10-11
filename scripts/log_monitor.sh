
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

# Process escalate.log with awk
awk -F' \\[|\\] ' -v dbname="$DB_NAME" -v user="$USER" -v host="$HOST" -v port="$PORT" -v password="$PASSWORD" '
{
    TIMESTAMP=$1;   # Extract timestamp
    LEVEL=$2;       # Extract log level
    MESSAGE = substr($0, index($0, $3));  # Extract the message part

    # Escape single quotes in the MESSAGE field
    gsub(/\047/, "\047\047", MESSAGE)

    # Prepare the PostgreSQL command
    PSQL="INSERT INTO urgentlog_entries (timestamplogged, level, message) VALUES (\047" TIMESTAMP "\047, \047" LEVEL "\047, \047" MESSAGE "\047);"
    
    # Execute the command using psql and check for errors
    cmd="PGPASSWORD=\"" password "\" psql -h " host " -U " user " -d " dbname " -p " port " -c \"" PSQL "\""
    
    if (system(cmd) != 0) {
        print "Error inserting entry into database:", PSQL;
    }
}' "$ESCALATEFILE" 2>> "$SCRIPT_LOGFILE"


# Insert into PostgreSQL
# system("PGPASSWORD=" DB_PASS " psql -U " DB_USER " -d " DB_NAME " -c \"INSERT INTO logs (timestamp, level, message) VALUES (\'" TIMESTAMP "\', \'" LEVEL "\', \'" MESSAGE "\');\"");