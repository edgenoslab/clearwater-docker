# FROM clearwater/base
FROM docker.io/tangfeixiong/clearwater-base-onbuild:1611180614.gitrev-c2da9c9
MAINTAINER tangfeixiong<tangfx128@gmail.com>
# maintainers@projectclearwater.org

USER root

ADD *supervisord.conf /etc/supervisor/conf.d/

RUN apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y --force-yes sprout && \
  sed -e 's/\(echo 0 > \/proc\/sys\/kernel\/yama\/ptrace_scope\)/# \0/g' -i /etc/init.d/sprout && \
  mv /etc/supervisor/conf.d/sprout.supervisord.conf /etc/supervisor/conf.d/sprout.conf && \
  mv /etc/supervisor/conf.d/clearwater-group.supervisord.conf /etc/supervisor/conf.d/clearwater-group.conf

ADD plugins/* /usr/share/clearwater/clearwater-cluster-manager/plugins/
ADD reload_memcached_users /usr/share/clearwater/bin/reload_memcached_users

EXPOSE 5052 5054
