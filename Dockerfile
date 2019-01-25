FROM openjdk:8-jdk

ENV JAVA_OPTS "-server -Xconcurrentio -Xmx8g -Xms8g -XX:+UseG1GC -XX:MetaspaceSize=1000M -Ddw.server.applicationConnectors[0].bindHost=0.0.0.0 -Ddw.server.applicationConnectors[0].port=8989"

RUN mkdir -p /data && \
    mkdir -p /graphhopper

#RUN apt-get upgrade
RUN apt-get update
RUN apt-get -y install python-pip
RUN pip install awscli
RUN apt-get -y install --no-install-recommends supervisor
RUN rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/log/supervisor

# RUN apt-get update && \
#     apt-get install -y --no-install-recommends supervisor python-pip && \
#     pip install awscli && \
#     apt-get remove -y python-pip && \
#     rm -rf /var/lib/apt/lists/*
# 

COPY . /graphhopper/

WORKDIR /graphhopper

RUN ./graphhopper.sh build

VOLUME [ "/data" ]

EXPOSE 8989 9001
