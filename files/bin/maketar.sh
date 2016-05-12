#!/bin/sh
DATE=`date +%Y-%m-%d:%H:%M:%S`
mkdir -p /tmp/files/$NAME/$DATE
tar cvzf - /backup/ | split --bytes=1500MB - /tmp/files/$NAME/$DATE/backup.tar.gz.
acdcli sync
acdcli ul -x 5 /tmp/files /backups/
rm -rf /tmp/files/$NAME
