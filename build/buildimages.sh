#!/bin/bash

docker pull dpage/pgadmin4
docker pull postgres:12.2
docker build --network host --rm -t local/chron-build .
cd ../chron-ingest
./build.sh
cd ../chron-replication
./build.sh
cd ../ace-am
./build.sh
cd ../ace-dbstore
./build.sh
cd ../ace-ims
./build.sh
