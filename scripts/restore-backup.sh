#!/bin/bash

sqlcmd -U sa -P $MSSQL_SA_PASSWORD -S localhost -C -Q "RESTORE FILELISTONLY FROM DISK = '/var/opt/mssql/backup/GD2015C1.BAK'"
sqlcmd -U sa -P $MSSQL_SA_PASSWORD -S localhost -C -Q "
RESTORE DATABASE BDD2026
FROM DISK = '/var/opt/mssql/backup/GD2015C1.BAK'
WITH MOVE 'GESTION2009_Data' TO '/var/opt/mssql/data/BDD2026.mdf',
     MOVE 'GESTION2009_Log' TO '/var/opt/mssql/data/BDD2026_log.ldf',
     REPLACE
"