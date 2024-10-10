# monitors database, counts logs to see if threshholds are exceeded
#queries the log_entries table in PostgreSQL to count how many ERRORs and FATALs occurred within a certain time window (e.g., the last minute).\
#
# trigger the alert by writing ot alertlog file and email later 