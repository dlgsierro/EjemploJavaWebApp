FROM tomcat
MAINTAINER "Gonzalo Sierro <gsierro@dl.cl>"

RUN apt-get update
RUN apt-get install -y wget
RUN wget --no-verbose -O /tmp/apache-maven.tar.gz http://www-us.apache.org/dist/maven/maven-3/3.5.2/binaries/apache-maven-3.5.2-bin.tar.gz
RUN echo "948110de4aab290033c23bf4894f7d9a /tmp/apache-maven.tar.gz" | md5sum -c
RUN tar xzf /tmp/apache-maven.tar.gz -C /opt/
RUN ln -s /opt/apache-maven-3.5.2 /opt/maven
RUN ln -s /opt/maven/bin/mvn /usr/local/bin
ENV MAVEN_HOME /opt/maven

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD docker/settings.xml /usr/local/tomcat/conf/
ADD docker/tomcat-users.xml /usr/local/tomcat/conf/

EXPOSE 8080
CMD ["catalina.sh", "run"]