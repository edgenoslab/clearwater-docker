# FROM clearwater/base
FROM docker.io/tangfeixiong/clearwater-base-onbuild:1611180614.gitrev-c2da9c9
MAINTAINER tangfeixiong <tangfx128@gmail.com>
# Inspired by: maintainers@projectclearwater.org

ADD *supervisord.conf /etc/supervisor/conf.d/

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --force-yes --no-install-recommends \
        homer \
    && mv /etc/supervisor/conf.d/homer.supervisord.conf /etc/supervisor/conf.d/homer.conf \
    && mv /etc/supervisor/conf.d/nginx.supervisord.conf /etc/supervisor/conf.d/nginx.conf \
    && mv /etc/supervisor/conf.d/clearwater-group.supervisord.conf /etc/supervisor/conf.d/clearwater-group.conf \
    && rm -rf /var/lib/apt/lists/*

EXPOSE 7888