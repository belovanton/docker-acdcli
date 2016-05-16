#!/bin/bash
# Database credentials
 if [ -z "$DB_USER" ]; then
    echo "Empty DB_USER var" 
    exit
 fi
 user=$DB_USER
 if [ -z "$DB_PASS" ]; then
    echo "Empty DB_PASS var"
    exit
 fi
 password=$DB_PASS
 if [ -z "$DB_HOST" ]; then
    echo "Empty DB_HOST var"
    exit
 fi
 host=$DB_HOST
 if [ -z "$1" ]; then
    echo "Empty first argument (DB_NAME)"
    exit
 fi
 db_name=$1
# Other options
 backup_main_path=/tmp/db/backups		 
 backup_path="$backup_main_path/$db_name"
 mkdir -p $backup_path
 date=$(date +"%d-%b-%Y-%s")
 folder=$(date +"%d-%b-%Y")
# Set default file permissions
 umask 177
 mkdir $backup_path/$folder
# Dump database into SQL file
 time mysqldump --lock-tables=false --user=$user --password=$password --host=$ho
st $db_name |gzip > $backup_path/$folder/$db_name-$date.sql.gz
# Delete files older than 30 days
 find $backup_path/* -mtime +10 -exec rm {} \;

/usr/local/bin/acdcli sync 
/usr/local/bin/acdcli ul  $backup_main_path /
rm -rf $backup_main_path
