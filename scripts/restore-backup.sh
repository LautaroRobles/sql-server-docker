#!/bin/bash

sqlcmd -U sa -P $MSSQL_SA_PASSWORD -S localhost -C \
  -v DBNAME="$DATABASE" \
  -v BACKUPFILE="/var/opt/mssql/backup/$BACKUP_FILE" \
  -v DATAPATH="/var/opt/mssql/data" \
  -i /usr/scripts/restore-backup.sql