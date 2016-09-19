FROM frolvlad/alpine-oraclejdk8:slim

MAINTAINER Andrei Varabyeu <andrei_varabyeu@epam.com>

# Copy ssh key to enable access to repository
COPY id_rsa /root/.ssh/id_rsa
# Change access rights of id_rsa
RUN chmod 700 /root/.ssh/id_rsa

# Since container is based on Alpine Linux, there is no ssh-keyscan (openssh-client) by default.
# Install it
RUN apk update \
  && apk upgrade \
  && apk add openssh-client \
  && rm -rf /var/cache/apk/*

#ADD EPAM's GIT to known hosts
RUN ssh-keyscan git.epam.com >> /root/.ssh/known_hosts

VOLUME /tmp
ADD registry-service-${version}.jar app.jar


RUN sh -c 'touch /app.jar'
EXPOSE 8761
ENTRYPOINT ["java","-Xmx256m","-Djava.security.egd=file:/dev/./urandom","-jar","/app.jar"]
