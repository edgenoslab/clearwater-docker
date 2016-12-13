# FROM clearwater/base
FROM docker.io/tangfeixiong/clearwater-base-onbuild:1611180614.gitrev-c2da9c9
MAINTAINER tangfeixiong <tangfx128@gmail.com>
# inspired by: maintainers@projectclearwater.org

COPY *supervisord.conf /etc/supervisor/conf.d/
COPY start_cassandra.sh /usr/bin/start_cassandra.sh

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --force-yes --no-install-recommends \
        homestead-cassandra \
        homestead-prov-cassandra \
        homer-cassandra \
    && sed -e 's/-c cassandra/-c root/g' -i /etc/init.d/cassandra \
    && mv /etc/supervisor/conf.d/cassandra.supervisord.conf /etc/supervisor/conf.d/cassandra.conf \
    && mv /etc/supervisor/conf.d/clearwater-group.supervisord.conf /etc/supervisor/conf.d/clearwater-group.conf \
    && rm -rf /var/lib/apt/lists/*

EXPOSE 9160 7001 9142 7000 9042