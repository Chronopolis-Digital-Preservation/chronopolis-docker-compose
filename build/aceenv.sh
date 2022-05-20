#!/bin/bash
cp ../../audit-control-environment/ace-dist/target/ace-dist-1.14.1-RELEASE-bin.tar.gz ../ace-am/
cp ../../audit-control-environment/ace-ims-ear/target/ace-ims.ear ../ace-ims/docker/
cp ../../audit-control-environment/ace-am/src/main/sql/ace-am.sql ../ace-ims/docker/ace-ims.sql
cp ../../audit-control-environment/ace-am/src/main/sql/ace-am.sql ../ace-dbstore/docker/ace-am.sql
