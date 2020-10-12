# bitwarden_rs-local-backup
Create encrypted backups of your Bitwarden_RS database locally every 6 hours. Maintains backups from the last 30 days.

## How to Use

Use this in conjuction with `rsync` running over `cron` on a remote machine (e.g. your computer) to remotely save the backups. Use at least 2 remote machines for redundancy. For example:

```
rsync -azP --delete user@bw_server_ip:/path/to/backups ~/local/path/to/store/backups
```

## Required `.env` File
```
BACKUP_ENCRYPTION_KEY=xxx
```

## Decrypting Backups
1. `docker exec -it CONTAINER_ID /bin/ash`
2. `openssl enc -d -aes256 -salt -pbkdf2 -pass pass:BACKUP_ENCRYPTION_KEY -in /backups/DESIRED_BACKUP_NAME.tar.gz | tar xz -C /backups`
3. Grab your `db.sqlite3` file from `/host/path/to/backups/tmp/`