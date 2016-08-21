FROM ubuntu:16.04
MAINTAINER Peri Inc.

### Basic Configuration
RUN apt-get -q update
RUN apt-get install -q -y software-properties-common wget curl
RUN apt-get install -qq -y git vim zip

RUN wget -q -O -  http://pkg.jenkins.io/debian/jenkins.io.key | apt-key add - && \
sh -c 'echo deb http://pkg.jenkins-ci.org/debian binary/ > /etc/apt/sources.list.d/jenkins.list' && \
apt-get update && \
apt-get install -q -y jenkins



RUN service jenkins start && sleep 10 && cd /var/lib/jenkins/plugins && wget http://updates.jenkins-ci.org/download/plugins/scm-api/1.2/scm-api.hpi && \
wget http://updates.jenkins-ci.org/download/plugins/junit/1.13/junit.hpi && \
wget http://updates.jenkins-ci.org/download/plugins/script-security/1.20/script-security.hpi && \
wget http://updates.jenkins-ci.org/download/plugins/matrix-project/1.7.1/matrix-project.hpi && \
wget http://updates.jenkins-ci.org/download/plugins/windows-slaves/1.1/windows-slaves.hpi && \
wget http://updates.jenkins-ci.org/download/plugins/icon-shim/2.0.3/icon-shim.hpi && \
wget http://updates.jenkins-ci.org/download/plugins/matrix-auth/1.4/matrix-auth.hpi && \
wget http://updates.jenkins-ci.org/download/plugins/javadoc/1.4/javadoc.hpi && \
wget http://updates.jenkins-ci.org/download/plugins/antisamy-markup-formatter/1.5/antisamy-markup-formatter.hpi && \
wget http://updates.jenkins-ci.org/download/plugins/mailer/1.17/mailer.hpi && \
wget http://updates.jenkins-ci.org/download/plugins/maven-plugin/2.13/maven-plugin.hpi && \

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

#Set EST Timezone
RUN ln -sf /usr/share/zoneinfo/America/New_York /etc/localtime

EXPOSE 8080:8080

ENTRYPOINT service jenkins start && tail -f /dev/null