FROM openjdk:8-jdk

RUN apt-get update && \
    apt-get install -y --no-install-recommends supervisor python-pip && \
    pip install awscli && \
    apt-get remove -y python-pip && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/log/supervisor

RUN mkdir -p /data && \
    mkdir -p /graphhopper

COPY . /graphhopper/

WORKDIR /graphhopper

RUN ./graphhopper.sh build

VOLUME [ "/data" ]

EXPOSE 8989 9001
