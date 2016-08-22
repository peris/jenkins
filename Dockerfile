FROM jenkins
MAINTAINER Peri Inc.

#Set EST Timezone
USER root
RUN ln -sf /usr/share/zoneinfo/America/New_York /etc/localtime
RUN mkdir /root/.ssh
USER jenkins

COPY plugins/ /var/jenkins_home/plugins/

COPY id_rsa /root/.ssh/

EXPOSE 8080:8080