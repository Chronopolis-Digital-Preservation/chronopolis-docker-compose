#!/bin/bash
cp -R ../artifacts/chronopolishome ..
cp -R ../artifacts/postgresql ..
mkdir -p ../export/outgoing/bags
mkdir -p ../export/outgoing/tokens
mkdir -p ../scratch1/chronopolis-preservation
mkdir -p ../postgresql/data
chmod 755 ../postresql/docker-entrypoint-initdb.d/ini-user-db.sh