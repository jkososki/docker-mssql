# Docker MSSQL  

Docker image for running dev instances of SQL Server.

## Build

Build the image with the following:

```bash
#!/bin/bash
docker build -t mssql .
```

## Configuration

The following environment variables have been set to configure sql server:
|Variable|Value|
|---|---|
|MSSQL_DATA_DIR|/tmp/mssql|
|MSSQL_LOG_DIR|/tmp/mssql|
|MSSQL_BACKUP_DIR|/tmp/mssql|

The following environment variables can be used within this build:
|Variable|Description|
|---|---|
|wwi|If set a new copy of the Wide World Importers sample database will be downloaded and restored.|
|scripts|A comma delimited list of scripts that will be executed at container instansiation.|

## Run with Wide World Importers

Set the environment variable `wwi` to download and install the Wide World Importers sample database.

```bash
#!/bin/bash
docker run -d -p 1433:1433 -e wwi=true mssql
```

Run the container and configure the Wide World Importers sample database.
Use a volume for database files.

```bash
#!/bin/bash
docker run -d -p 1433:1433 -v $(pwd)/db:/tmp/mssql mssql
```

## Execute sql scripts

This is a good way to attach database files.
Place all database files and sql scripts in the container's `/tmp/mssql` path and run the container.

```bash
#!/bin/bash
docker run -d -p 1433:1433 -e scripts="attachdb.sql" -v $(pwd)/db:/tmp/mssql mssql
```
