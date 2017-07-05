FROM openjdk:8-jdk

RUN apt-get update && \
    apt-get install -y --no-install-recommends supervisor python-pip && \
    pip install awscli && \
    apt-get remove -y python-pip && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/log/supervisor

RUN mkdir -p /data

COPY . /graphhopper/

RUN cd /graphhopper && \
    ./graphhopper.sh buildweb

WORKDIR /graphhopper
VOLUME ["/data"]

EXPOSE 8989 9001
