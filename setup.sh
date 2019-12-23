#! /bin/sh

sleep 15

# Execute Shell Statements
if [ "$shcmd" ]
then
    echo "*******************************************"
    echo "        Executing: Shell Commands"
    echo "*******************************************"

    echo $shcmd
    eval $shcmd
fi


# Download and restore the Wide World Importers sample database
if [ "$wwi" ]
then

    restoreSql='
        RESTORE DATABASE WideWorldImporters
        FROM DISK = "/tmp/wwi.bak"
        WITH REPLACE, MOVE "WWI_Primary" TO "/tmp/mssql/WideWorldImporters.mdf",
        MOVE "WWI_UserData" TO "/tmp/mssql/WideWorldImporters_userdata.ndf",
        MOVE "WWI_Log" TO "/tmp/mssql/WideWorldImporters.ldf",
        MOVE "WWI_InMemory_Data_1" TO "/tmp/mssql/WideWorldImporters_InMemory_Data_1",
        STATS = 50;'

    echo "*******************************************"
    echo "        Setting up WWI sample database."
    echo "*******************************************"

    curl -L -o /tmp/wwi.bak https://github.com/microsoft/sql-server-samples/releases/download/wide-world-importers-v1.0/WideWorldImporters-Full.bak \
        && sqlcmd -S . -U sa -P "$SA_PASSWORD" -Q "$restoreSql"
fi

# Execute all sql scripts
if [ "$scripts" ]
then
    echo "*******************************************"
    echo "        Executing: $scripts"
    echo "*******************************************"

    sqlcmd -S . -U sa -P "$SA_PASSWORD" -i "$scripts"
fi
