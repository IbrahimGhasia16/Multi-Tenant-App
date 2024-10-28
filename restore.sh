#!/bin/bash

# Define variables
BACKUP_FILE=backup/$1
CONTAINER_NAME=multi-tenant-postgres
DATABASE_NAME=payload-multi-tenant
USERNAME=keytoz
PASSWORD=qwedsa

# Check if backup file argument is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <backup_file>"
  exit 1
fi

# Check if backup file exists
if [ ! -f "$BACKUP_FILE" ]; then
  echo "Backup file '$BACKUP_FILE' not found."
  exit 1
fi

 /usr/bin/docker cp $BACKUP_FILE $CONTAINER_NAME:.

# Run pg_restore inside the PostgreSQL Docker container
 /usr/bin/docker exec -e PGPASSWORD=$PASSWORD -i $CONTAINER_NAME psql -U $USERNAME -h postgres $DATABASE_NAME < backup/$1

echo "Restore completed."


# step to restore the backup file (Don't remove the comments)
# chmod +x restore.sh
# ./restore.sh temp-20240418_173554.sql