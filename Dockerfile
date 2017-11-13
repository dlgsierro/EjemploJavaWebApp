FROM tomcat
MAINTAINER "Gonzalo Sierro <gsierro@gmail.com>"

ADD docker/settings.xml /usr/local/tomcat/conf/
ADD docker/tomcat-users.xml /usr/local/tomcat/conf/