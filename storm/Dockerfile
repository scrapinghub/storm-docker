FROM ubuntu:14.10
MAINTAINER vshlapakov

ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64/

RUN apt-get update \
    && apt-get install -y unzip openjdk-7-jre-headless wget supervisor \
    && apt-get install -y build-essential python-dev python-pip git \
    && rm -rf /var/lib/apt/lists/*

# Download, install and config Storm
ENV STORM_HOME /usr/share/storm
ENV STORM_VERSION 0.9.4
ENV STORM_DOWNLOAD_URL http://mirrors.sonic.net/apache/storm/apache-storm-$STORM_VERSION/apache-storm-$STORM_VERSION.tar.gz
VOLUME ["/var/log/storm"]

RUN wget -q -O - $STORM_DOWNLOAD_URL | tar -xzf - -C /usr/share
RUN ln -s /usr/share/apache-storm-$STORM_VERSION $STORM_HOME

RUN groupadd storm \
    && useradd --gid storm --home-dir /home/storm --create-home --shell /bin/bash storm \
    && chown -R storm:storm $STORM_HOME \
    && chown -R storm:storm /var/log/storm

RUN ln -s $STORM_HOME/bin/storm /usr/bin/storm

ADD storm.yaml $STORM_HOME/conf/storm.yaml
ADD cluster.xml $STORM_HOME/logback/cluster.xml
ADD config-supervisord.sh /usr/bin/config-supervisord.sh
ADD start-supervisor.sh /usr/bin/start-supervisor.sh 

RUN echo [supervisord] | tee -a /etc/supervisor/supervisord.conf \
    && echo nodaemon=true | tee -a /etc/supervisor/supervisord.conf
