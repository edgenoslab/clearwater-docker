FROM ubuntu:14.04
MAINTAINER tangfeixiong <tangfx128@gmail.com>
# Inspired by: maintainers@projectclearwater.org

ENV UBUNTU_REPO_MIRROR="http://mirrors.aliyun.com/" \
  CW_NGV_REPO_MIRROR="http://10.64.33.1:48080/mirror/repo.cw-ngv.com" \
  CW_NGV_REPO_GPG_KEY_URL=http://10.64.33.1:48080/gpg-key/http%253A%252F%252Frepo.cw-ngv.com

ADD sysctl /sbin/sysctl
ADD *supervisord.conf /etc/supervisor/conf.d/

RUN ( [ -n $UBUNTU_REPO_MIRROR ] && \
  sed -i "s%http://archive.ubuntu.com/%$UBUNTU_REPO_MIRROR%g;s%http://security.ubuntu.com/%$UBUNTU_REPO_MIRROR%g" /etc/apt/sources.list ) && \
  apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y openssh-server supervisor curl && \
  mkdir -p /var/run/sshd /var/log/supervisor && \
  echo 'root:root' | chpasswd && \
  sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
  locale-gen en_US.UTF-8 && \
  sed -e 's/\#\(precedence ::ffff:0:0\/96  100\)/\1/g' -i /etc/gai.conf && \
  ( [ -n $CW_NGV_REPO_MIRROR ] && \
  echo deb $CW_NGV_REPO_MIRROR/stable binary/ > /etc/apt/sources.list.d/clearwater.list || \
  echo deb http://repo.cw-ngv.com/stable binary/ > /etc/apt/sources.list.d/clearwater.list ) && \
  ( [ -n $CW_NGV_REPO_GPG_KEY_URL ] && \
  curl -sL $CW_NGV_REPO_MIRROR/repo_key | apt-key add - || \
  curl -L http://repo.cw-ngv.com/repo_key | apt-key add - ) && \
  apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y --force-yes clearwater-infrastructure clearwater-auto-config-docker clearwater-management && \
  /etc/init.d/clearwater-auto-config-docker restart && \
  /etc/init.d/clearwater-infrastructure restart && \
  mv /etc/supervisor/conf.d/clearwater-infrastructure.supervisord.conf /etc/supervisor/conf.d/clearwater-infrastructure.conf && \
  mv /etc/supervisor/conf.d/clearwater-group.supervisord.conf /etc/supervisor/conf.d/clearwater-group.conf

ENV LANG=en_US.UTF-8 \
  LANGUAGE=en_US:en \
  LC_ALL=en_US.UTF-8

ONBUILD USER root
ONBUILD EXPOSE 22
ONBUILD CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]
