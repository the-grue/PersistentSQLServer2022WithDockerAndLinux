FROM        ubuntu:20.04

LABEL       author="James T. Sprinkle"

ARG         PACKAGES="wget gnupg software-properties-common"

ENV         TERM xterm

RUN         apt-get update && apt-get install -y --no-install-recommends $PACKAGES && \
            wget -qO- https://packages.microsoft.com/keys/microsoft.asc | apt-key add - && \
            apt-add-repository "$(wget -qO- https://packages.microsoft.com/config/ubuntu/20.04/mssql-server-2022.list)" && \
            apt-get update && apt-get install -y --no-install-recommends mssql-server && \
            apt-get purge -y $PACKAGES && rm -rf /var/lib/apt/lists/*

WORKDIR     /var/opt

RUN         tar -cvf extract.tar ./mssql
