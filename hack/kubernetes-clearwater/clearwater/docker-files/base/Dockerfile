FROM ubuntu:14.04
MAINTAINER tangfeixiong <tangfx128@gmail.com>
# Inspired by: maintainers@projectclearwater.org

ARG UBUNTU_REPO_MIRROR="http://mirrors.aliyun.com/"
ARG CW_NGV_REPO_MIRROR="http://192.168.1.100:48080/16-mirror/ubuntu/trusty/apt-mirror/mirror/repo.cw-ngv.com/stable"
ARG CW_NGV_REPO_GPG_KEY_URL="http://192.168.1.100:48080/16-mirror/ubuntu/trusty/apt-mirror/gpg-key/http%253A%252F%252Frepo.cw-ngv.com/repo_key"

ADD sysctl /sbin/sysctl
ADD *supervisord.conf /etc/supervisor/conf.d/
ADD liveness.sh /usr/share/kubernetes/

RUN ( [ -n $UBUNTU_REPO_MIRROR ] \
        && sed -i "s%http://archive.ubuntu.com/%$UBUNTU_REPO_MIRROR%g;s%http://security.ubuntu.com/%$UBUNTU_REPO_MIRROR%g" /etc/apt/sources.list ) \
    && apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        openssh-server \
        supervisor \
        curl \
    && mkdir -p /var/run/sshd /var/log/supervisor \
    && echo 'root:root' | chpasswd \
    && sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config \
    && locale-gen en_US.UTF-8 \
    && sed -e 's/\#\(precedence ::ffff:0:0\/96  100\)/\1/g' -i /etc/gai.conf \
    && ( [ -n $CW_NGV_REPO_MIRROR ] \
        && echo deb $CW_NGV_REPO_MIRROR binary/ > /etc/apt/sources.list.d/clearwater.list \
        || echo deb http://repo.cw-ngv.com/stable binary/ > /etc/apt/sources.list.d/clearwater.list ) \
    && ( [ -n $CW_NGV_REPO_GPG_KEY_URL ] \
        && curl -sL $CW_NGV_REPO_GPG_KEY_URL | apt-key add - \
        || curl -L http://repo.cw-ngv.com/repo_key | apt-key add - ) \
    && apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --force-yes --no-install-recommends \
        clearwater-infrastructure \
        clearwater-auto-config-docker \
        clearwater-management \
    && sed -i 's/#user=.*/user=root/' /etc/dnsmasq.conf \
    && sed -i 's/\(mv \/tmp\/hosts\.\$\$.*\)/# \1/' /usr/share/clearwater/infrastructure/scripts/1hosts \
    && sed -i 's/ > \/etc\/hostname//;s/\(hostname \$(cat.*\)/# \1/;s/\(mv \/tmp\/hosts\.\$\$.*\)/# \1/' /usr/share/clearwater/infrastructure/scripts/hostname \
  && /etc/init.d/clearwater-auto-config-docker restart \
  && /etc/init.d/clearwater-infrastructure restart \
  && mv /etc/supervisor/conf.d/clearwater-infrastructure.supervisord.conf /etc/supervisor/conf.d/clearwater-infrastructure.conf \
  && mv /etc/supervisor/conf.d/clearwater-group.supervisord.conf /etc/supervisor/conf.d/clearwater-group.conf \
  && apt-get install -y netcat-openbsd \
  && sed -i 's/SCTP_streams.*/No_SCTP;/' /usr/share/clearwater/bin/generic_create_diameterconf \
  && sed -i 's/scscf.sprout/sprout/' /etc/init.d/clearwater-auto-config-docker \

    && sed -i 's/^\s*sprout_hostname=sprout$/        sprout_hostname=sprout.default.svc.cluster.local/' /etc/init.d/clearwater-auto-config-docker \
    && sed -i 's/^\s*chronos_hostname=chronos$/        chronos_hostname=chronos.default.svc.cluster.local/' /etc/init.d/clearwater-auto-config-docker \
    && sed -i 's/^\s*cassandra_hostname=cassandra$/        cassandra_hostname=cassandra.default.svc.cluster.local/' /etc/init.d/clearwater-auto-config-docker \
    && sed -i 's/^\s*hs_hostname=homestead:8888$/        hs_hostname=homestead.default.svc.cluster.local:8888/' /etc/init.d/clearwater-auto-config-docker \
    && sed -i 's/^\s*hs_provisioning_hostname=homestead:8889$/        hs_provisioning_hostname=homestead.default.svc.cluster.local:8889/' /etc/init.d/clearwater-auto-config-docker \
    && sed -i 's/^\s*xdms_hostname=homer:7888$/        xdms_hostname=homer.default.svc.cluster.local:7888/' /etc/init.d/clearwater-auto-config-docker \
    && sed -i 's/^\s*upstream_hostname=sprout$/        upstream_hostname=sprout.default.svc.cluster.local/' /etc/init.d/clearwater-auto-config-docker \
    && sed -i 's/^\s*ralf_hostname=ralf:10888$/        ralf_hostname=ralf.default.svc.cluster.local:10888/' /etc/init.d/clearwater-auto-config-docker \
    && sed -i 's/home_domain="example.com"/home_domain="default.svc.cluster.local"/' /etc/init.d/clearwater-auto-config-docker \
  && sed -i 's/^\( \+sprout_hostname=.*\)/\1\n    icscf_uri="sip:\$sprout_hostname:5052;transport=tcp"/' /etc/init.d/clearwater-auto-config-docker \
  && sed -i 's/^\( \+sprout_hostname=.*\)/\1\n    scscf_uri="sip:\$sprout_hostname:5054;transport=tcp"/' /etc/init.d/clearwater-auto-config-docker \
  && sed -i 's/^\( \+s\/^sprout_hostname=.*\)/\1\n    s\/^icscf_uri=.*\/icscf_uri="'\''$icscf_uri'\''"\//' /etc/init.d/clearwater-auto-config-docker \
  && sed -i 's/^\( \+s\/^sprout_hostname=.*\)/\1\n    s\/^scscf_uri=.*\/scscf_uri="'\''$scscf_uri'\''"\//' /etc/init.d/clearwater-auto-config-docker \
  ### echo "scscf_uri=\"sip:sprout:5054;transport=tcp\"" >> /etc/clearwater/shared_config
  ### echo "icscf_uri=\"sip:sprout:5052;transport=tcp\"" >> /etc/clearwater/shared_config
    && echo "scscf_uri=\"sip:sprout.default.svc.cluster.local:5054;transport=tcp\"" >> /etc/clearwater/shared_config \
    && echo "icscf_uri=\"sip:sprout.default.svc.cluster.local:5052;transport=tcp\"" >> /etc/clearwater/shared_config \
    && sed -i 's/home_domain=example.com/home_domain=default.svc.cluster.local/' /etc/clearwater/shared_config \
    && sed -i 's/sprout_hostname=sprout/sprout_hostname=sprout.default.svc.cluster.local/' /etc/clearwater/shared_config \
    && sed -i 's/hs_hostname=homestead:8888/hs_hostname=homestead.default.svc.cluster.local:8888/' /etc/clearwater/shared_config \
    && sed -i 's/hs_provisioning_hostname=homestead:8889/hs_provisioning_hostname=homestead.default.svc.cluster.local:8889/' /etc/clearwater/shared_config \
    && sed -i 's/xdms_hostname=homer:7888/xdms_hostname=homer.default.svc.cluster.local:7888/' /etc/clearwater/shared_config \
    && sed -i 's/ralf_hostname=ralf:10888/ralf_hostname=ralf.default.svc.cluster.local:10888/' /etc/clearwater/shared_config \
    && sed -i 's/chronos_hostname=chronos/chronos_hostname=chronos.default.svc.cluster.local/' /etc/clearwater/shared_config \
    && sed -i 's/cassandra_hostname=cassandra/cassandra_hostname=cassandra.default.svc.cluster.local/' /etc/clearwater/shared_config \
    && rm -rf /var/lib/apt/lists/*

ENV LANG=en_US.UTF-8 \
  LANGUAGE=en_US:en \
  LC_ALL=en_US.UTF-8

ONBUILD USER root
ONBUILD EXPOSE 22
ONBUILD CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]