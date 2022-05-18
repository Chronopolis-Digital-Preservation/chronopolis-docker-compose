FROM --platform=linux/amd64 ubuntu:latest

RUN adduser chronopolis

RUN apt update
RUN apt install -y openjdk-8-jdk

# We are going to need Maven
RUN apt install -y maven

ENTRYPOINT ["/home/chronopolis/chronopolisbuild.sh"]
