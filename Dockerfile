FROM openjdk:8-jdk

RUN apt-get update
RUN apt-get -y install python-pip
RUN pip install awscli

RUN mkdir -p /data && \
    mkdir -p /graphhopper

COPY . /graphhopper/

WORKDIR /graphhopper

RUN ./graphhopper.sh build

VOLUME [ "/data" ]

EXPOSE 8989
