#! /bin/sh

sleep 20

if [ "$(ls -A /tmp/mssql/data)" ]
then
    echo "ToDo: Add Attach Logic"
else
    echo "Downloading Wide World Importers Sample Database."
    curl -L -o /tmp/mssql/backup/wwi.bak https://github.com/microsoft/sql-server-samples/releases/download/wide-world-importers-v1.0/WideWorldImporters-Full.bak

    restoreSql='
        RESTORE DATABASE WideWorldImporters
        FROM DISK = "/tmp/mssql/backup/wwi.bak"
        WITH MOVE "WWI_Primary" TO "/tmp/mssql/data/WideWorldImporters.mdf",
        MOVE "WWI_UserData" TO "/tmp/mssql/data/WideWorldImporters_userdata.ndf",
        MOVE "WWI_Log" TO "/tmp/mssql/log/WideWorldImporters.ldf",
        MOVE "WWI_InMemory_Data_1" TO "/tmp/mssql/data/WideWorldImporters_InMemory_Data_1",
        STATS = 10'
    
    echo "Restoring Wide World Importers."
    sqlcmd -S . -U sa -P "$SA_PASSWORD" -Q "$restoreSql"
fi