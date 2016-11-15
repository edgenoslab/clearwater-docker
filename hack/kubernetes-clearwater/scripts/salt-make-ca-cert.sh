#!/bin/bash -e

#sudo groupadd -f -r kube-cert
CERT_DIR=$HOME
CERT_GRP=$(id -gn)

MASTER_IP="10.64.33.81"
# Same as GKE, cluster CIDR: 10.120.0.0/14, service CIDR: 10.123.240.0/20
MASTER_SERVICE="10.123.240.1"

EXTRA_SANS=(
    IP:$MASTER_IP
    IP:$MASTER_SERVICE
    DNS:kubernetes
    DNS:kubernetes.default
    DNS:kubernetes.default.svc
    DNS:kubernetes.default.svc.cluster.local
  )

ARG_CERT_IP=$MASTER_IP
ARG_EXTRA_SANS=$(echo "${EXTRA_SANS[@]}" | tr ' ' ,)

echo $ARG_EXTRA_SANS
echo "Generate ca certs into $CERT_DIR"

debug='true' CERT_DIR=$CERT_DIR CERT_GROUP=$CERT_GRP $HOME/kubernetes/saltbase/salt/generate-cert/make-ca-cert.sh $ARG_CERT_IP $ARG_EXTRA_SANS
