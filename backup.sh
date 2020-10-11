#!/bin/sh

# rm any backups older than 30 days
find /backups/* -mtime +30 -exec rm {} \;

# create backup filename
BACKUP_FILE="db.sqlite3_$(date "+%F-%H%M%S")"

# use sqlite3 to create backup (avoids corruption if db write in progress)
sqlite3 /db.sqlite3 ".backup '/tmp/db.sqlite3'"

# tar up backup and encrypt with openssl and encryption key
tar -czf - /tmp/db.sqlite3 | openssl enc -e -aes256 -salt -pbkdf2 -pass pass:${BACKUP_ENCRYPTION_KEY} -out /backups/${BACKUP_FILE}.tar.gz

# cleanup tmp folder
rm -rf /tmp/*