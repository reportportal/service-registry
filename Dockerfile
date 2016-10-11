FROM frolvlad/alpine-oraclejdk8:slim

MAINTAINER Andrei Varabyeu <andrei_varabyeu@epam.com>

VOLUME /tmp
ADD https://dl.bintray.com/reportportal/reportportal/com/epam/reportportal/service-registry/2.6.0/service-registry-2.6.0.jar /app.jar
RUN sh -c 'touch /app.jar'
EXPOSE 8080
ENTRYPOINT ["java","-Xmx192m","-Djava.security.egd=file:/dev/./urandom","-jar","/app.jar"]
