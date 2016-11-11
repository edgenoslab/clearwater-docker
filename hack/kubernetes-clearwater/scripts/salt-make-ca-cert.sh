#!/bin/bash -e

sudo groupadd -f -r kube-cert

MASTER_IP="10.64.33.81"
SERVING_IP="172.30.0.1"

EXTRA_SANS=(
    IP:$MASTER_IP
    IP:$SERVING_IP
    DNS:kubernetes
    DNS:kubernetes.default
    DNS:kubernetes.default.svc
    DNS:kubernetes.default.svc.cluster.local
  )

ARG_CERT_IP=$MASTER_IP
ARG_EXTRA_SANS=$(echo "${EXTRA_SANS[@]}" | tr ' ' ,)

echo $ARG_EXTRA_SANS
echo "Create ca certs into /srv/kubernetes"

sudo $HOME/kubernetes/saltbase/salt/generate-cert/make-ca-cert.sh $ARG_CERT_IP $ARG_EXTRA_SANS
