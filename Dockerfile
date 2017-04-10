FROM openjdk:8-jdk

RUN apt-get update
RUN apt-get -y install python-pip
RUN pip install awscli

RUN mkdir -p /data

COPY . /graphhopper/

RUN cd /graphhopper && \
    ./graphhopper.sh buildweb

WORKDIR /graphhopper
VOLUME ["/data"]

EXPOSE 8989
