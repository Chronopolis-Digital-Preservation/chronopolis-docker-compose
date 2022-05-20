FROM --platform=linux/amd64 centos:7

RUN adduser chronopolis

RUN yum -y update
RUN yum install -y java-1.8.0-openjdk

# We are going to need Maven
RUN yum install -y maven

ENTRYPOINT ["/home/chronopolis/chronopolisbuild.sh"]
