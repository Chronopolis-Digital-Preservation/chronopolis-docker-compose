#!/bin/bash
cp -R ../artifacts/chronopolishome ..
cp -R ../artifacts/postgresql ..
mkdir -p ../export/outgoing/bags
mkdir -p ../export/outgoing/tokens
mkdir -p ../scratch1/chronopolis-preservation
mkdir -p ../postgresql/data
chmod 755 ../postgresql/docker-entrypoint-initdb.d/init-user-db.sh
cp ../../audit-control-environment/ace-dist/target/ace-dist-1.14.1-RELEASE-bin.tar.gz ../ace-am/
cp ../../audit-control-environment/ace-ims-ear/target/ace-ims.ear ../ace-ims/docker/
cp ../../audit-control-environment/ace-am/src/main/sql/ace-am.sql ../ace-ims/docker/ace-ims.sql
cp ../../audit-control-environment/ace-am/src/main/sql/ace-am.sql ../ace-dbstore/docker/ace-am.sql
