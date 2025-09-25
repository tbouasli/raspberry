#!/bin/bash

# Minecraft backup script
# Runs every 5 minutes, keeps 5 most recent backups

BACKUP_DIR="/app/backup/recent"
MINECRAFT_DIR="/app/server"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_NAME="minecraft_backup_${TIMESTAMP}.tar.gz"

# Create backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

# Create backup
echo "$(date): Creating backup $BACKUP_NAME" >> /var/log/backup.log
tar -czf "$BACKUP_DIR/$BACKUP_NAME" -C "$MINECRAFT_DIR" .

# Keep only the 5 most recent backups
cd "$BACKUP_DIR"
ls -t minecraft_backup_*.tar.gz | tail -n +6 | xargs -r rm -f

echo "$(date): Backup completed, kept 5 most recent backups" >> /var/log/backup.log
