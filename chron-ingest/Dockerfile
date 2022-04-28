FROM --platform=linux/amd64 centos:7

RUN adduser chronopolis

RUN mkdir /var/log/chronopolis
RUN chown chronopolis:chronopolis /var/log/chronopolis

RUN chmod 777 /var/run

# RUN yum -y update
RUN yum -y install java-1.8.0-openjdk-devel

# We are going to need Maven
RUN yum -y install maven

# We need ssh for rsync to connect to...
RUN yum -y install openssh-server passwd openssh-clients
COPY files/ssh/ /etc/ssh/
RUN chmod 755 /etc/ssh
RUN chmod 744 /etc/ssh/*
RUN chmod 700 /etc/ssh/ssh_host_rsa_key
RUN mkdir /var/run/sshd

# We also need rsync
RUN yum -y install rsync
RUN yum -y install perl

EXPOSE 8080
EXPOSE 8009

ENTRYPOINT ["/home/chronopolis/startingest.sh"]
