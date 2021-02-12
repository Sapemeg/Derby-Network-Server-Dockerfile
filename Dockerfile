FROM adoptopenjdk:8-jre-hotspot-focal

LABEL maintainer="sarantos@meglis.com"

RUN apt-get -y update; \
    apt-get -y install wget 

RUN mkdir /opt/Apache ; \
    cd /opt/Apache; \
    wget https://ftp.cc.uoc.gr/mirrors/apache/db/derby/db-derby-10.14.2.0/db-derby-10.14.2.0-bin.tar.gz ; \
    tar xzvf db-derby-10.14.2.0-bin.tar.gz ; \
    rm -rf db-derby-10.14.2.0-bin.tar.gz  ; \
    mkdir  /var/log/db-derby;

COPY entrypoint.sh /root/entrypoint.sh

ENTRYPOINT [ "/bin/sh", "/root/entrypoint.sh" ]
