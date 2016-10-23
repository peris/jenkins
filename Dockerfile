FROM ubuntu:16.04
MAINTAINER Peri Inc. (periinc@periinc.com)

### Basic Configuration
RUN apt-get -q update
RUN apt-get install -q -y software-properties-common wget curl
RUN apt-get install -qq -y git vim zip

RUN wget -q -O -  http://pkg.jenkins.io/debian/jenkins.io.key | apt-key add - && \
sh -c 'echo deb http://pkg.jenkins-ci.org/debian binary/ > /etc/apt/sources.list.d/jenkins.list' && \
apt-get update && \
apt-get install -q -y jenkins

RUN wget \
    --no-cookies \
    --no-check-certificate \
    --header "Cookie: oraclelicense=accept-securebackup-cookie" \
    -qO- \
    "http://download.oracle.com/otn-pub/java/jdk/8u51-b16/jdk-8u51-linux-x64.tar.gz" | tar -zx -C /opt/

ENV JAVA_HOME /opt/jdk1.8.0_51
ENV PATH $JAVA_HOME/bin:$PATH

RUN echo ${JAVA_HOME}

#Install SSH Plugin
RUN service jenkins start && sleep 10 && cd /var/lib/jenkins/plugins && wget https://updates.jenkins-ci.org/download/plugins/ssh/2.4/ssh.hpi

RUN mkdir /opt/keys

#Set EST Timezone
RUN ln -sf /usr/share/zoneinfo/America/New_York /etc/localtime

EXPOSE 8080:8080

ENTRYPOINT service jenkins start && tail -f /dev/null