# 3 scripts generate_logs.sh | log_monitor.sh | cleanup.sh
# can either run this script or add manually to crontab -e to run the 3 scripts in order sequentially
# generate_logs.sh: generates random logs and prints them to app.log
# log_monitor.sh: filters important logs to escalate.log, then adds eeach entry from escalate.log to database table, splittingeach line into its different fields
# cleanup.sh: deletes old log entries in db, clears app.log and escalate.log for fresh log files

GENERATESPATH="/home/isaacabdi/revature/project1/scripts/generate_logs.sh"
CLEANUPPATH="/home/isaacabdi/revature/project1/scripts/cleanup.sh"
MONITORPATH="/home/isaacabdi/revature/project1/scripts/log_monitor.sh"


#set up cron jobs run every 2 min
(crontab -l ; echo "*/2 * * * * $CLEANUPPATH && $GENERATESPATH && $MONITORPATH >> /home/isaacabdi/revature/project1/logfiles/test.txt 2>&1") | crontab -

#Display the updated crontab
echo "Cron jobs have been set up:"
crontab -l