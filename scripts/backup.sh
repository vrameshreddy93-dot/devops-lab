#!/bin/bash

SOURCE="$HOME/devops-lab"
BACKUP_DIR="$HOME/devops-lab/backups"
TIMESTAMP=$(date '+%Y-%m-%d_%H-%M-%S')
BACKUP_FILE="$BACKUP_DIR/devops-lab-$TIMESTAMP.tar.gz"

echo "===== BACKUP STARTED ====="
echo "Timestamp : $(date '+%Y-%m-%d %H:%M:%S')"

mkdir -p "$BACKUP_DIR"

 sudo tar -czf "$BACKUP_FILE" \
    --exclude="$BACKUP_DIR" \
    "$SOURCE"

if [ $? -eq 0 ]; then
    sudo chown "$USER:$USER" "$BACKUP_FILE"
    echo "Backup Status : SUCCESS"
    echo "Backup File   : $BACKUP_FILE"
else
    echo "Backup Status : FAILED"
fi

echo "===== BACKUP COMPLETED ====="
