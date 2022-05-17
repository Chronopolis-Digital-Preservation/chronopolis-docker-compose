FROM tomcat:8.5.51-jdk8

ENV ACE_V=1.14.1
ENV ACE_AUDIT_TAR=ace-am-1.14.1-RELEASE MYSQL_JCONNECT_V=5.1.48 MYSQL_JCONNECT=mysql-connector-java-5.1.48

COPY ace-dist-1.14.1-RELEASE-bin.tar.gz /opt

WORKDIR /opt
RUN curl -kL https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-$MYSQL_JCONNECT_V.tar.gz | tar xz
RUN cp $MYSQL_JCONNECT/$MYSQL_JCONNECT-bin.jar $CATALINA_HOME/lib
RUN pwd
RUN ls
RUN tar xzf ace-dist-1.14.1-RELEASE-bin.tar.gz
RUN mkdir -p $CATALINA_HOME/conf/Catalina/localhost
RUN mkdir -p /opt/ace-am
RUN mkdir /opt/initdb.d
RUN cp $ACE_AUDIT_TAR/ace-am.sql /opt/initdb.d
RUN sed -i -e "s|MyISAM|InnoDB|g" /opt/initdb.d/ace-am.sql

WORKDIR /usr/local/tomcat

COPY docker/* /opt/ace-am/

VOLUME ["/opt/initdb.d"]

CMD [ -d "$CATALINA_HOME/webapps/ace-am" ] && catalina.sh run || ( /opt/ace-am/setup.sh && catalina.sh run)
