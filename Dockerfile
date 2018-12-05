FROM openjdk:7-jre

ARG TOMCAT_ID=1000
ARG TOMCAT_HOME=/opt/tomcat
ARG TOMCAT_VERSION=7.0.91

RUN wget -O /opt/tomcat.zip https://archive.apache.org/dist/tomcat/tomcat-7/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.zip && \
cd $(dirname ${TOMCAT_HOME}) && unzip tomcat.zip && \
mv apache-tomcat-${TOMCAT_VERSION} tomcat && \
rm -f /opt/tomcat/tomcat.zip && \
useradd tomcat -u ${TOMCAT_ID} --no-create-home -d ${TOMCAT_HOME} && \
chown -R tomcat: ${TOMCAT_HOME}

COPY . /opt/tomcat/webapps/

USER tomcat

ENV CATALINA_HOME=${TOMCAT_HOME}

EXPOSE 8080

CMD bash /opt/tomcat/bin/catalina.sh run
