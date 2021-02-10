# Chronopolis Docker ( DockerChron )

To enable better development and broader environment, we need a self-contained docker environment for developers.

The ACE components used in this build are available and documented here:

[https://github.com/ualibraries/ace-dbstore-mysql](https://github.com/ualibraries/ace-dbstore-mysql)

# Building the docker infrastructure

Since the chronopolis system has a large number of dependencies, this process was designed to allow developers to easily edit and modify the source code on their local disk using local tools, then shut down the chronopolis system, recompile the code, and bring it all back up with state still intact.

First we grab the chronopolis-core source from gitlab.
```
git clone https://gitlab.com/chronopolis/chronopolis-core.git
```
Then we get the chronopolis-docker-compose source.
```
git clone https://gitlab.com/chronopolis/chronopolis-docker-compose.git
```
Now, we copy the chronopolis-docker-compose directory into the chronopolis-core directory.
```
mv chronopolis-docker-compose chronopolis-core
```
The build scripts are meant to work with bash, so if you are on a Mac ( which is now zsh ), or aren't sure, run the shell with this command.
```
bash
```
Then build the docker images we need and start up the build environment.

**[note: If you are building a replication node only using the docker compose in the node sub-directory, you should make the changes documented in that readme BEFORE you perform the build.]**
```
cd chronopolis-core/chronopolis-docker-compose/build
./buildenv.sh
sudo ./buildimages.sh
sudo ./buildup.sh
```
Ssh into the build container and compile the source code. The first build can be quite long, since it downloads source from external repositories and uses them in compiling the rest of chronopolis.  The system stores these external resources going forward and subsequent compiles are MUCH faster.  This relies on Maven caching things in the chronopolis-core/chronopolis-docker-compose/chronopolishome/.m2 directory.  If for some reason you need to download/refresh/empty that cache, just delete everything in that .m2 directory.
```
sudo ./buildssh.sh
su - chronopolis
cd /chronopolis-core
./mvnw clean install
```
Once all that compiling is done and the build test have passed, initialize the postgresql db with the tables we will need...
```
cd ingest-rest
../mvnw -Dflyway.user=postgres -Dflyway.password=password -Dflyway.url=jdbc:postgresql://postgresql:5432/ingestdb flyway:migrate
```
The build environment includes a pgadmin container that you can use to examine the postgresql db running on the postgresql container.  The URL is http://localhost:8060.  The username is chronopolis@localhost.localdomain and the password is 'password'.  I know, I know.  Once on the pgadmin interface, you can add a server pointing to host 'postgresql' with user 'postgres' and password...yes...you guessed it...'password'.

Finally, we exit out of the build environment, shut it down, and then bring up chronopolis.

**[Note: If you are building a replication node only, issue a 'sudo ./nodeup.sh' command in the node directory rather than the chronup statement below.**
```
exit
exit
sudo ./builddown.sh
cd ..
sudo ./chronup.sh
```

Your infrastructure should be up and running about 3 minutes after the chronup.sh is run.

# Setting up a test environment

## Ace

First, we go to the ACE audit manager interface ( [http://localhost:8090/ace-am](http://localhost:8090/ace-am)  ).  Occasionally, this container has trouble coming up the first time.  If need be, restart the environment and that usually works.
```
sudo ./chrondown.sh
sudo ./chronup.sh
```
Once there, click on the status link at the top and it will ask you to log in ( username:admin password:admin ).  A link called 'System Settings' will appear at the top and when you click on it, a configuration window will appear.  Put the word 'integrity' into the box labelled 'IMS Host'.

Hit the submit link at the bottom.

The configuration and mysql data for ACE is stored in a persistent volume associated with the container group the docker compose creates and will survive stopping and starting of containers within the environment during development.  If you prune or remove these volumes, the token, audit, and configuration will need to be recreated.

**[note] If you are building a node only from the node sub-directory, you can stop here and simply add it to your current ingest server.**

## Chronopolis

The ingest server webUI is at: [http://localhost:8070/](http://localhost:8070/)  The login button is at the top right.

```
username: admin
password: admin
```

To set up the environment, select 'User Config'

Add a user as follows:

```
Username: developer
Password: developer
Role: Role_User
**Make sure to click the check box for 'Is a node'**
Click 'Create User'
```

Now select Depositors from the admin menu, then click Add Depositor.

```
Organization Name: development
Organization Address: development
Namespace: development
**Select the user 'developer' we just created in the Replicating Nodes box so that it is highlighted.**
Click on 'Add Depositor'
```

**Make sure you click on the word 'developer' in the replicating nodes box before you select Add Depositor.**

Now select Storage Region Create and create two storage regions:

The first should have these values:
```
Owning Node: developer
Data Type: BAG
Storage Type: LOCAL
Total Capacity: 1
Storage Unity: GB
Replication Server: chron-ingest
Replication Path: /bags
Replication Username: chronopolis
```

The second should have these values:
```
Owning Node: developer
Data Type: TOKEN
Storage Type: LOCAL
Storage Unit: GB
Replication Server: chron-ingest
Replication Path: /tokens
Replication Username: chronopolis
```

You now have a basic environment to test in.

The database that holds the configuration you just created is persistent on disk in the chronopolis-core/docker-compose/postgresql/data directory.  This directory will persist regardless of actions take within docker.  If you need to clean up, shutdown the chron environment, delete everything inside that directory, bring up the build environment, and re-run the database initialization step executed during the build process.

# Testing Ingest

Both the ingest and replication servers have scripts in the docker-compose directory that will give you a terminal session on those containers.

Run the ingest.sh command in  and you will be on the ingest server ( chron-ingest ) container.

First we need to make something to ingest...

```jsx
./ingestssh.sh
su - chronopolis
cd /export/outgoing/bags
mkdir development
cd development
mkdir devbag
cd devbag
echo "This is some content." > test.txt
cd ..
bag baginplace --tagmanifestalgorithm sha256 --payloadmanifestalgorithm sha256 devbag
cd
./generate.sh development devbag
./ingest.sh devbag
```

The web page on the ingest web server should show a replication is in progress.  The ingest will go through several stages, about one every minute, until it reaches the state 'preserved'.

If you want to watch what is going on, ssh into the chron-ingest and chron-replication containers and tail -f * in the /var/log/chronopolis directories.

Once the collection is preserved, you have successfully created a chronopolis store.  You can also look at the ace interface and check that the collection has been audited.

> Written with [StackEdit](https://stackedit.io/).

