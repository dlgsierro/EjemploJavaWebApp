FROM tomcat
MAINTAINER "Gonzalo Sierro <gsierro@gmail.com>"

RUN apt-get update
RUN apt-get maven
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD docker/settings.xml /usr/local/tomcat/conf/
ADD docker/tomcat-users.xml /usr/local/tomcat/conf/

EXPOSE 8080