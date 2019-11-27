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