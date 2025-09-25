#!/bin/bash

# Minecraft 1d backup script
# Runs daily, keeps 5 most recent 1d backups

BACKUP_DIR="/backup/daily"
MINECRAFT_DIR="/app"
TIMESTAMP=$(date +"%Y%m%d")
BACKUP_NAME="minecraft_1d_${TIMESTAMP}.tar.gz"

# Create backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

# Create backup
echo "$(date): Creating 1d backup $BACKUP_NAME" >> /var/log/backup.log
tar -czf "$BACKUP_DIR/$BACKUP_NAME" -C "$MINECRAFT_DIR" .

# Keep only the 5 most recent 1d backups
cd "$BACKUP_DIR"
ls -t minecraft_1d_*.tar.gz | tail -n +6 | xargs -r rm -f

echo "$(date): 1d backup completed, kept 5 most recent 1d backups" >> /var/log/backup.log
