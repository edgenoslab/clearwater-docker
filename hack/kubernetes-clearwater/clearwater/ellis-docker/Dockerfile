# FROM clearwater/base
FROM docker.io/tangfeixiong/clearwater-base-onbuild
MAINTAINER tangfeixiong<tangfx128@gmail.com>
# Inspired by maintainers@projectclearwater.org

USER root

ADD *supervisord.conf /etc/supervisor/conf.d/

RUN apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y --force-yes mysql-server && \
  /etc/init.d/mysql start && \
  apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y --force-yes ellis && \
  /etc/init.d/mysql start && \
  /usr/share/clearwater/ellis/env/bin/python /usr/share/clearwater/ellis/src/metaswitch/ellis/tools/create_numbers.py --start 6505550000 --count 1000 && \
  mv /etc/supervisor/conf.d/ellis.supervisord.conf /etc/supervisor/conf.d/ellis.conf && \
  mv /etc/supervisor/conf.d/mysql.supervisord.conf /etc/supervisor/conf.d/mysql.conf && \
  mv /etc/supervisor/conf.d/nginx.supervisord.conf /etc/supervisor/conf.d/nginx.conf && \
  mv /etc/supervisor/conf.d/clearwater-group.supervisord.conf /etc/supervisor/conf.d/clearwater-group.conf

EXPOSE 80
