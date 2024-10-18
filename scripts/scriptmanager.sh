# 3 scripts in crontab stringmn.py | alert_system.py | cleanup.sh
# run this script or add manually to crontab -e to run the last 3 scripts in order sequentially

# stringmn.py: filters important logs to escalate.log, then adds eeach entry from escalate.log to database table, splittingeach line into its different fields
# cleanup.sh: deletes old log entries in db, clears app.log and escalate.log for fresh log files
# alertsystem.py: runs query to check threshholds and send alerts if those threshholds are met

# AFTER - run generate_logs.sh to print logs indefinetly
# generate_logs.sh: generates random logs and prints them to app.log, run this after to indefinetly print logs



#GENERATESPATH="/home/isaacabdi/revature/project1/scripts/generate_logs.sh"
CLEANUPPATH="/home/isaacabdi/revature/project1/scripts/cleanup.sh"
#MONITORPATH="/home/isaacabdi/revature/project1/scripts/log_monitor.sh"
PYTHONALERTS="/home/isaacabdi/revature/project1/src/alert_system.py"
VENV_PYTHON_PATH="/home/isaacabdi/revature/project1/venv/bin/python"
INSERTPYTHONPATH="/home/isaacabdi/revature/project1/src/stringmn.py"


#2>&1 means redirect stderr (2) to the same place stdout (1) is being sent."
#set up cron job\

# CLEANUPPATH and MONITORPATH and PYTHONALERTS run every 1 minutes, run generatespath seperately
(crontab -l ; echo "*/1 * * * * $VENV_PYTHON_PATH $INSERTPYTHONPATH; $VENV_PYTHON_PATH $PYTHONALERTS; $CLEANUPPATH >> /home/isaacabdi/revature/project1/logfiles/test.txt 2>&1") | crontab -

#Display the updated crontab
echo "Cron jobs have been set up:"
crontab -l


#GENERATESPATH runs in the background, CLEANUPPATH and MONITORPATH run every 1 minutes && vs &
#(crontab -l ; echo "*/2 * * * * $GENERATESPATH & $CLEANUPPATH && $MONITORPATH && $PYTHONALERTS >> /home/isaacabdi/revature/project1/logfiles/test.txt 2>&1") | crontab -
