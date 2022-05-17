FROM payara/server-full:5.181

ENV ACE_V=1.12 MAVEN_V=3.5.3 MAVEN=apache-maven-3.5.3 MYSQL_JCONNECT_V=5.1.46 MYSQL_JCONNECT=mysql-connector-java-5.1.46 J2EE_INIT_SLEEP=40

COPY docker/ace-ims.ear  ../../deployments

RUN \ 
mkdir -p /opt/ace-ims && \
mkdir -p build && cd build && \
curl -kL https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-$MYSQL_JCONNECT_V.tar.gz | tar xz && \
cp $MYSQL_JCONNECT/$MYSQL_JCONNECT-bin.jar ../glassfish/domains/domain1/lib 

COPY docker/* /opt/ace-ims/

ENTRYPOINT [ `ls -1A deployments | wc -l` -eq 0 ] && ${PAYARA_PATH}/bin/asadmin start-domain -v ${PAYARA_DOMAIN} || ( /opt/ace-ims/setup.sh && ${PAYARA_PATH}/bin/asadmin start-domain -v ${PAYARA_DOMAIN} )
