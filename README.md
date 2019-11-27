# Docker MSSQL  

Docker image for running dev instances of SQL Server.

## Build

Build the image with the following

```bash
#!/bin/bash
docker build -t mssql .
```

## Run with Wide World Importers

Run the container and configure the Wide World Importers sample database.

```bash
#!/bin/bash
docker run -d -p 1433:1433 mssql
```

Run the container and configure the Wide World Importers sample database.
Use a volume for database files.

```bash
#!/bin/bash
docker run -d -p 1433:1433 -v $(pwd)/db:/tmp/mssql mssql
```

## Run and attach databases

Place all database files in the container's `/tmp/mssql` path and run the container.

```bash
#!/bin/bash
docker run -d -p 1433:1433 -v $(pwd)/db:/tmp/mssql mssql
```

The container will attempt to attach all databases with files in the `/tmp/mssql` folder.

