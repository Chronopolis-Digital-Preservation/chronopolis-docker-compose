# Running a replication node

The docker compose in this directory will bring up just the parts of the chronopolis system needed to add an additional replication node to an existing chronopolis installation.

The key differences between this and a full chronopolis stack are:

### There are no ingest or ACE IMS servers
This installation brings up only a replication container, which needs to be configured to run against an external ingest server in order to copy data.  This entails changing settings in the replication application.yaml file ( chronopolis-docker-compose/chron-replication/files/replication ) so that it points to that external ingest server and has a username and password in it which matches a node user in that system.  You will NOT need to follow any of the directions for setting up the ingest server.  However, you WILL need to add the user mentioned above as a replication target to any ingest sources you want copied to it.

The script brings up an audit manager for the node, but that audit manager needs to be configured to go against an external ACE IMS server.  In the spin up directions for the ACE server, instead of putting the word 'integrity' into the box labelled 'IMS Host', you would put the host name of the external IMS host.  You will also need to check the 'IMS Port' setting to make sure it is correct ( usually 8080 ).

### The replication rsync goes against an external ingest server

Normally, the key materials and account setup for the rsync process that copies data from the ingest server to replication nodes is configured automatically in docker-compose.  For a replication node spin up, the ssh keys in the chronopolis home directory ( sourced from chronopolis-docker-compose/artifacts/chronopolishome/.ssh ) need to be regenerated and put into the authorized keys for the chronopolis account on the external ingest server.  In addition, the host key for the ingest server needs to be added to authorized host file for the chronopolis user on the node.

After the changes mentioned above are made made, then follow the build instructions as usual through to the ACE configuration step and you should have an operating replication node with just a ./nodeup.sh command in this directory.

