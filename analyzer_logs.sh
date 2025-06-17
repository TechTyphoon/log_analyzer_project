#!/bin/bash
echo "Starting log analysis..."

echo "--- Errors in app.log ---"
grep "ERROR" logs/app.log
APP_ERROR_COUNT=$(grep "ERROR" logs/app.log | wc -l)
echo "Total errors in app.log: $APP_ERROR_COUNT"

echo ""

echo "--- Errors in system.log ---"
grep "ERROR" logs/system.log
SYSTEM_ERROR_COUNT=$(grep "ERROR" logs/system.log | wc -l)
echo "Total errors in system.log: $SYSTEM_ERROR_COUNT"

echo ""
echo "Log analysis complete."

# --- Archiving Section ---
echo "--- Starting log archiving ---"

mkdir -p archives

ARCHIVE_NAME="logs_$(date +%Y%m%d_%H%M%S).tar.gz"

# Find files in 'logs/' directory older than 1 day (-mtime +1)
# and pass them to tar for archiving.
# -P: don't strip leading slashes (keeps 'logs/' in archive structure)
# --remove-files: tells tar to delete original files AFTER successful archiving.
# This is safer than a separate rm command as it only deletes if tar succeeds.
find logs/ -type f -mtime +1 -print0 | xargs -0 tar -czvf archives/"$ARCHIVE_NAME" --remove-files

# Check if any files were actually archived before reporting
if [ -f archives/"$ARCHIVE_NAME" ]; then
    echo "Logs older than 1 day archived to: archives/$ARCHIVE_NAME"
else
    echo "No logs older than 1 day to archive."
    # If no files were archived, remove the empty tar.gz file that might have been created by tar
    rm -f archives/"$ARCHIVE_NAME"
fi

echo "Archiving complete."

# --- Cleanup Section ---
# We removed the generic 'rm -f logs/*' here, as 'tar --remove-files' handles it for old logs.
# If you still wanted to aggressively clear ALL logs (even fresh ones) after archiving,
# you could put `rm -f logs/*` back. For now, let's let new logs stay.
# echo "--- Cleaning up original log files ---"
# rm -f logs/*
# echo "Original log files cleaned up."
