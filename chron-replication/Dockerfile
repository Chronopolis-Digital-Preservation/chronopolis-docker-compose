FROM --platform=linux/amd64 centos:7

RUN adduser chronopolis

RUN mkdir /var/log/chronopolis
RUN chown chronopolis:chronopolis /var/log/chronopolis

RUN chmod 777 /var/run

# RUN yum -y update
RUN yum -y install java-1.8.0-openjdk-devel

RUN yum -y install openssh-server openssh-clients

# We also need rsync
RUN yum -y install rsync
RUN yum -y install perl

ENTRYPOINT ["/home/chronopolis/startreplication.sh"]
