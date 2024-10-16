# Log Monitoring and Alert System

## Description

Log monitoring and alert system using Bash, PostgreSQL, and Python. The system will monitor logs, store them in PostgreSQL, and trigger alerts when error thresholds are reached. This project aims to simulate real-world production support tasks.

## Goals

- Monitor log files for specific error levels (ERROR, FATAL).
- Insert log entries into a PostgreSQL database.
- Implement a Python-based alert system that tracks error thresholds.
- Automate log generation, monitoring, and alerting with cron jobs.

## Instructions
- 3 scripts stringmn.py | alert_system.py | cleanup.sh
- run scriptmanager.sh script or add manually to crontab -e to run the above 3 scripts in order sequentially
- then run the generate_logs.sh: indefinitely generates random logs and prints them to app.log, run this after scriptmanager.sh

## Technologies

- **Bash** for scripting.
- **PostgreSQL** for database storage.
- **Python** for alerting.
- **Cron** (or equivalent) for task automation.
- **psql** for database queries.
