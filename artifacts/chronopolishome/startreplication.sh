#!/bin/bash
chown -R chronopolis:chronopolis /scratch1
chown -R chronopolis:chronopolis /export
chown -R chronopolis:chronopolis /home/chronopolis
chmod -R 755 /home/chronopolis/.ssh
chmod 740 /home/chronopolis/.ssh/*
chmod 700 /home/chronopolis/.ssh/id_rsa

su - chronopolis <<ENDOFSU
cd /usr/local/chronopolis/replication
/usr/bin/java -Dspring.config.location=file:/usr/local/chronopolis/replication/application.yml -jar /chronopolis-core/replication-shell/target/replication-shell-3.3.0-SNAPSHOT.jar
ENDOFSU

while true; do
    sleep 30
done
