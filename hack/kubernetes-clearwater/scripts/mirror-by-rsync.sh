#!/bin/bash -e

ALIYUN_MIRROR_URL="http://mirrors.aliyun.com/centos/7"
CENTOS_MIRROR_URL="http://mirror.centos.org/centos/7"
YUN_IDC_URL="rsync://mirrors.yun-idc.com/centos/7"

SRC_URL="rsync://mirrors.yun-idc.com/centos/7"

TGT=${SRC_URL//\//\%2F}
TGT=${TGT/\:/\%3A}

DEST_HOME=$(dirname "${BASH_SOURCE}")

if [[ ! -d $DEST_HOME/$TGT ]]; then mkdir -p $DEST_HOME/$TGT; fi

#rsync -av \
#  --list-only \
#  --delete-excluded \
#  ${SRC_URL}
  
# CentOS Extras
rsync -av --delete \
  --filter=". ${DEST_HOME}/centos-rsync.filter" \
  --filter=":n- .rsync.filter" \
  --exclude-from="${DEST_HOME}/extras.exclude" \
  --include-from="${DEST_HOME}/extras.include" \
  ${SRC_URL}/extras ${DEST_HOME}/$TGT  
  
# CentOS PaaS
rsync -av --delete \
  --filter=". ${DEST_HOME}/centos-rsync.filter" \
  --filter=":n- .rsync.filter" \
  --exclude-from="${DEST_HOME}/paas.exclude" \
  --include-from="${DEST_HOME}/paas.include" \
  ${SRC_URL}/paas ${DEST_HOME}/$TGT
