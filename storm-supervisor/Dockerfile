FROM vshlapakov/storm-base:0.9.4
MAINTAINER vshlapakov

# Install Leiningen.
ENV LEIN_ROOT 1
RUN wget -q -O /usr/bin/lein \
    https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein \
    && chmod +x /usr/bin/lein

# Pre-install all needed jar-dependencies for Storm.
ADD lein_base.clj /root/project.clj
WORKDIR /root/
RUN lein deps
RUN cd /root/.m2 && find . -name '*.jar' -exec cp -nt $STORM_HOME/lib {} +

# Install task python requirements

ADD requirements.txt /root/requirements.txt
RUN pip install -r requirements.txt

EXPOSE 6700
EXPOSE 6701
EXPOSE 6702
EXPOSE 6703
EXPOSE 8000

RUN /usr/bin/config-supervisord.sh supervisor
RUN /usr/bin/config-supervisord.sh logviewer

CMD /usr/bin/start-supervisor.sh
