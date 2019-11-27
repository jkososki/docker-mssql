#! /bin/sh

sleep 15

mdfs=$(ls -1 /tmp/mssql/*.mdf 2>/dev/null | wc -l)
if ((mdfs > 0))
then
    echo "ToDo: Add Attach Logic"
else

    restoreSql='
        RESTORE DATABASE WideWorldImporters
        FROM DISK = "/tmp/mssql/wwi.bak"
        WITH MOVE "WWI_Primary" TO "/tmp/mssql/WideWorldImporters.mdf",
        MOVE "WWI_UserData" TO "/tmp/mssql/WideWorldImporters_userdata.ndf",
        MOVE "WWI_Log" TO "/tmp/mssql/WideWorldImporters.ldf",
        MOVE "WWI_InMemory_Data_1" TO "/tmp/mssql/WideWorldImporters_InMemory_Data_1",
        STATS = 50;'

    echo "Downloading Wide World Importers Sample Database." \
        && curl -L -o /tmp/mssql/wwi.bak https://github.com/microsoft/sql-server-samples/releases/download/wide-world-importers-v1.0/WideWorldImporters-Full.bak \
        && echo "Restoring Wide World Importers." \
        && sqlcmd -S . -U sa -P "$SA_PASSWORD" -Q "$restoreSql"

fi