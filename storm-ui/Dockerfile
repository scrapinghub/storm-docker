FROM vshlapakov/storm-base:0.9.4
MAINTAINER vshlapakov

RUN /usr/bin/config-supervisord.sh ui

EXPOSE 8080
CMD /usr/bin/start-supervisor.sh
