import psycopg2
import os

# Database connection details
DB_NAME = 'project1' 
USER = 'isaacabdi' 
PASSWORD = 'temp1x556!' 
HOST = 'localhost'  
PORT = '5432'  

# Function to insert a log entry into the database
def insert_to_db(timestamp, level, message):
    try:
        # Establish a database connection
        conn = psycopg2.connect(
            dbname=DB_NAME,
            user=USER,
            password=PASSWORD,
            host=HOST,
            port=PORT
        )
        cur = conn.cursor()

        # Prepare the SQL command, parameterized query with psycopg2 escapes single quotes 
        query = "INSERT INTO urgentlog_entries (timestamplogged, level, message) VALUES (%s, %s, %s)"
        cur.execute(query, (timestamp, level, message))

        # Commit the transaction
        conn.commit()

        # Close the cursor and connection
        cur.close()
        conn.close()

    except Exception as e:
        print(f"Error inserting log entry: {e}")

# Function to process log file and insert entries into the database
def process_log_file(log_file):
    with open(log_file, 'r') as file:
        for line in file:
            # Split the line by '[' and ']', and strip whitespace from each part
            try:
                timestamp, rest = line.split('[', 1)
                level, message = rest.split(']', 1)

                # Strip whitespace from the extracted parts
                timestamp = timestamp.strip()
                level = level.strip()
                message = message.strip()

                # Insert the log entry into the database
                if level in ['ERROR', 'FATAL']:
                    # Print the extracted values (optional for debugging)
                    print(f"Timestamp: {timestamp}")
                    print(f"Level: {level}")
                    print(f"Message: {message}")
                    print("-------------------")
                    insert_to_db(timestamp, level, message)

            except ValueError:
                print(f"Skipping malformed log line: {line}")

if __name__ == "__main__":

    log_file_path = '/home/isaacabdi/revature/project1/logfiles/app.log'
    process_log_file(log_file_path)