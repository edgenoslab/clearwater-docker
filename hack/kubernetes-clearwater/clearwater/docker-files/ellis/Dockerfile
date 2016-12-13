# FROM clearwater/base
FROM docker.io/tangfeixiong/clearwater-base-onbuild:1611180614.gitrev-c2da9c9
MAINTAINER tangfeixiong <tangfx128@gmail.com>
# Inspired by: maintainers@projectclearwater.org

ADD *supervisord.conf /etc/supervisor/conf.d/

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --force-yes --no-install-recommends \
        mysql-server \
    && /etc/init.d/mysql start \
    ### apt-get update
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --force-yes --no-install-recommends \
        ellis \
    && /etc/init.d/mysql start \
    && /usr/share/clearwater/ellis/env/bin/python /usr/share/clearwater/ellis/src/metaswitch/ellis/tools/create_numbers.py --start 6505550000 --count 1000 \
    && mv /etc/supervisor/conf.d/ellis.supervisord.conf /etc/supervisor/conf.d/ellis.conf \
    && mv /etc/supervisor/conf.d/mysql.supervisord.conf /etc/supervisor/conf.d/mysql.conf \
    && mv /etc/supervisor/conf.d/nginx.supervisord.conf /etc/supervisor/conf.d/nginx.conf \
    && mv /etc/supervisor/conf.d/clearwater-group.supervisord.conf /etc/supervisor/conf.d/clearwater-group.conf \
    && rm -rf /var/lib/apt/lists/*

EXPOSE 80