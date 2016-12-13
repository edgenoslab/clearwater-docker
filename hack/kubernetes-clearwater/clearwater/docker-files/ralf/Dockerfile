# FROM clearwater/base
FROM docker.io/tangfeixiong/clearwater-base-onbuild:1611180614.gitrev-c2da9c9
MAINTAINER tangfeixiong <tangfx128@gmail.com>
# Inspired by: maintainers@projectclearwater.org

ADD *supervisord.conf /etc/supervisor/conf.d/
COPY plugins/* /usr/share/clearwater/clearwater-cluster-manager/plugins/
ADD reload_memcached_users /usr/share/clearwater/bin/reload_memcached_users

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --force-yes --no-install-recommends \
        ralf \
    && sed -e 's/\(echo 0 > \/proc\/sys\/kernel\/yama\/ptrace_scope\)/# \0/g' -i /etc/init.d/ralf \
    && mv /etc/supervisor/conf.d/ralf.supervisord.conf /etc/supervisor/conf.d/ralf.conf \
    && mv /etc/supervisor/conf.d/clearwater-group.supervisord.conf /etc/supervisor/conf.d/clearwater-group.conf \
    && rm -rf /var/lib/apt/lists/*

EXPOSE 10888