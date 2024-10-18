#!/usr/bin/env python3
import psycopg2
from psycopg2 import sql

DB_NAME = 'project1'  # Replace with your database name
USER = 'isaacabdi'  # Replace with your PostgreSQL username
PASSWORD = 'temp1x556!'  # Replace with your PostgreSQL password
HOST = 'localhost'  # or '127.0.0.1'
PORT = '5432'  # Default PostgreSQL port

def alertcheck(connection, cursor):
    try:
        #check if 5 errors or 1 fatal are exceeded in db
        alert_query = "SELECT COUNT(level),level FROM urgentlog_entries GROUP BY level;"

        cursor.execute(alert_query)

        result = cursor.fetchall()
        error_count = 0
        fatal_count = 0

        # Iterate over the result to identify error or fatal alerts
        for row in result:
            # save count and level
            count, level = row
            if level == 'ERROR':
                error_count = count
            elif level == 'FATAL':
                fatal_count = count
        return error_count, fatal_count

    except Exception as e:
        print(f"Error with alertcheck function: {e}")

def executealert(connection, cursor):
    try:
        # Get the count of errors and fatal alerts
        error_count, fatal_count = alertcheck(connection, cursor)
        
        # Open the log file to write the alerts
        with open("/home/isaacabdi/revature/project1/logfiles/alert.log", "a") as file:
            # Check if conditions are met for alerts
            if fatal_count >= 1:
                alert_message = f"ALERT: {fatal_count} fatal error(s) detected!\n"
                print(alert_message)  # Print to console for debugging
                file.write(alert_message)

            if error_count >= 5:
                alert_message = f"ALERT: {error_count} error(s) detected!\n"
                print(alert_message)  # Print to console for debugging
                file.write(alert_message)

    except Exception as e:
        print(f"Error with executealert function: {e}")

if __name__ == "__main__":
    try:
        connection = psycopg2.connect(
            dbname=DB_NAME,
            user=USER,
            password=PASSWORD,
            host=HOST,
            port=PORT
        )
        cursor = connection.cursor()

        executealert(connection, cursor)

    except (Exception, psycopg2.Error) as error:
        print(f"Error connecting to the database: {error}")

    finally:
        if connection:
            cursor.close()
            connection.close()
            print("Database connection closed.")