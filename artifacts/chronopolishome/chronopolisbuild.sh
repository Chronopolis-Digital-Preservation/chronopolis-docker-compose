#!/bin/bash

chown -R chronopolis:chronopolis /home/chronopolis
mkdir -p /export/outgoing/bags
mkdir -p /export/outgoing/tokens
chown -R chronopolis:chronopolis /export
chown -R chronopolis:chronopolis /chronopolis-core

su chronopolis <<ENDOFSU
  # Do things as chronopolis when the build environment comes up.
ENDOFSU 

while true; do
    sleep 30
done
