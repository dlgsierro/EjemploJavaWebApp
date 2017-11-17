FROM tomcat
MAINTAINER "Gonzalo Sierro <gsierro@dl.cl>"

ADD docker/settings.xml /usr/local/tomcat/conf/
ADD docker/tomcat-users.xml /usr/local/tomcat/conf/
ADD target/webapp.war /usr/local/tomcat/webapps/

EXPOSE 8080
CMD ["catalina.sh", "run"]