#!/bin/bash

# Minecraft 1w backup script
# Runs weekly, keeps 5 most recent 1w backups

BACKUP_DIR="/backup/weekly"
MINECRAFT_DIR="/app"
TIMESTAMP=$(date +"%Y%m%d")
BACKUP_NAME="minecraft_1w_${TIMESTAMP}.tar.gz"

# Create backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

# Create backup
echo "$(date): Creating 1w backup $BACKUP_NAME" >> /var/log/backup.log
tar -czf "$BACKUP_DIR/$BACKUP_NAME" -C "$MINECRAFT_DIR" .

# Keep only the 5 most recent 1w backups
cd "$BACKUP_DIR"
ls -t minecraft_1w_*.tar.gz | tail -n +6 | xargs -r rm -f

echo "$(date): 1w backup completed, kept 5 most recent 1w backups" >> /var/log/backup.log
