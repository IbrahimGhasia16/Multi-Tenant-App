#!/bin/bash

# Define variables
NAME=$1
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_DIR=$(dirname "$0")/backup  # Backup directory located in the same directory as the script
CONTAINER_NAME=multi-tenant-postgres
DATABASE_NAME=payload-multi-tenant
USERNAME=keytoz
PASSWORD=qwedsa

# Create backup directory if it doesn't exist
mkdir -p $BACKUP_DIR

# Run pg_dump inside the PostgreSQL Docker container and save the backup to a file
docker exec -t $CONTAINER_NAME pg_dump -U $USERNAME -d $DATABASE_NAME -c > $BACKUP_DIR/$NAME-$TIMESTAMP.sql

# Optional: Compress the backup file

echo "Backup completed: $BACKUP_DIR/$NAME-$TIMESTAMP.sql"


# command to run in terminal to take backup
# chmod +x backup.sh NameOfBackupFile
# ./backup.sh