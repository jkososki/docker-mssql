FROM mcr.microsoft.com/mssql/server:2017-latest-ubuntu

RUN apt-get update && apt-get install -y  \
	curl apt-transport-https

RUN apt-get install -y locales \
    && echo "en_US.UTF-8 UTF-8" > /etc/locale.gen \
    && locale-gen

RUN mkdir /tmp/mssql

COPY ./setup.sh /setup.sh
RUN chmod +x /setup.sh

ENV MSSQL_DATA_DIR=/tmp/mssql
ENV MSSQL_LOG_DIR=/tmp/mssql
ENV MSSQL_BACKUP_DIR=/tmp/mssql

ENV ACCEPT_EULA=Y
ENV SA_PASSWORD=DevP@!!w0rd
ENV MSSQL_PID=Developer
ENV PATH="/opt/mssql-tools/bin:${PATH}"

EXPOSE 1433


WORKDIR /tmp/mssql
ENTRYPOINT /setup.sh & /opt/mssql/bin/sqlservr