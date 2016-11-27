IMG_NS ?= docker.io/tangfeixiong

IMG_TAG ?= $(shell date +%y%m%d%H%M).gitrev-$(shell git rev-parse --short=7 HEAD)

BASE_NAME ?= clearwater-base-onbuild
BONO_NAME ?= clearwater-bono
ELLIS_NAME ?= clearwater-ellis
HOMER_NAME ?= clearwater-homer
HOMESTEAD_NAME ?= clearwater-homestead
RALF_NAME ?= clearwater-ralf
SPROUT_NAME ?= clearwater-sprout
CASSANDRA_NAME ?= clearwater-cassandra
CHRONOS_NAME ?= clearwater-chronos
MEMCACHED_NAME ?= clearwater-memcached

CTX_ROOT := ../../../..

DOCKER_BIN := $(shell which docker)
CP_BIN := $(shell which cp)
SED_BIN := $(shell which sed)

COMPONENTS := bono ellis homer homestead ralf sprout cassandra chronos memcached

.PHONY: all $(COMPONENTS)

all: $(COMPONENTS)

base : CTX := $(CTX_ROOT)/base
base : IMG := $(IMG_NS)/$(BASE_NAME):$(IMG_TAG)
base :
		$(CP_BIN) $@/Dockerfile.$@ $(CTX)/
		$(DOCKER_BIN) build --tag=$(IMG) --file=$(CTX)/Dockerfile.$@ $(CTX)

$(COMPONENTS) : | base
		$(SED_BIN) "s%^FROM .*%FROM $(IMG_NS)/$(BASE_NAME):$(IMG_TAG)%" $@/Dockerfile.$@ > $(CTX_ROOT)/$@/Dockerfile.$@
		$(DOCKER_BIN) build --tag=$(IMG_NS)/$(value $(shell echo $@ | tr a-z A-Z)_NAME):$(IMG_TAG) --file=$(CTX_ROOT)/$@/Dockerfile.$@ $(CTX_ROOT)/$@

# Deprecated
cw-bono : TGT := bono
cw-bono : IMG := $(IMG_NS)/$(BONO_NAME):$(IMG_TAG)
cw-bono :
		$(SED_BIN) "s%^FROM .*%FROM $(IMG_NS)/$(BASE_NAME):$(IMG_TAG)%" $(TGT)/Dockerfile > $(CTX_ROOT)/$(TGT)/Dockerfile.$(TGT)
		$(DOCKER_BIN) build --tag=$(IMG) --file=$(CTX_ROOT)/$(TGT)/Dockerfile.$(TGT) $(CTX_ROOT)/$(TGT)

cw-ellis : TGT := ellis
cw-ellis : IMG := $(IMG_NS)/$(ELLIS_NAME):$(IMG_TAG)
cw-ellis :
		$(SED_BIN) "s%^FROM .*%FROM $(IMG_NS)/$(BASE_NAME):$(IMG_TAG)%" $(TGT)/Dockerfile > $(CTX_ROOT)/$(TGT)/Dockerfile.$(TGT)
		$(DOCKER_BIN) build --tag=$(IMG) --file=$(CTX_ROOT)/$(TGT)/Dockerfile.$(TGT) $(CTX_ROOT)/$(TGT)

cw-homer : TGT := homer
cw-homer : IMG := $(IMG_NS)/$(HOMER_NAME):$(IMG_TAG)
cw-homer :
		$(SED_BIN) "s%^FROM .*%FROM $(IMG_NS)/$(BASE_NAME):$(IMG_TAG)%" $(TGT)/Dockerfile > $(CTX_ROOT)/$(TGT)/Dockerfile.$(TGT)
		$(DOCKER_BIN) build --tag=$(IMG) --file=$(CTX_ROOT)/$(TGT)/Dockerfile.$(TGT) $(CTX_ROOT)/$(TGT)

cw-homestead : TGT := homestead
cw-homestead : IMG := $(IMG_NS)/$(HOMESTEAD_NAME):$(IMG_TAG)
cw-homestead :
		$(SED_BIN) "s%^FROM .*%FROM $(IMG_NS)/$(BASE_NAME):$(IMG_TAG)%" $(TGT)/Dockerfile > $(CTX_ROOT)/$(TGT)/Dockerfile.$(TGT)
		$(DOCKER_BIN) build --tag=$(IMG) --file=$(CTX_ROOT)/$(TGT)/Dockerfile.$(TGT) $(CTX_ROOT)/$(TGT)

cw-ralf : TGT := ralf
cw-ralf : IMG := $(IMG_NS)/$(RALF_NAME):$(IMG_TAG)
cw-ralf :
		$(SED_BIN) "s%^FROM .*%FROM $(IMG_NS)/$(BASE_NAME):$(IMG_TAG)%" $(TGT)/Dockerfile > $(CTX_ROOT)/$(TGT)/Dockerfile.$(TGT)
		$(DOCKER_BIN) build --tag=$(IMG) --file=$(CTX_ROOT)/$(TGT)/Dockerfile.$(TGT) $(CTX_ROOT)/$(TGT)

cw-sprout : TGT := sprout
cw-sprout : IMG := $(IMG_NS)/$(SPROUT_NAME):$(IMG_TAG)
cw-sprout :
		$(SED_BIN) "s%^FROM .*%FROM $(IMG_NS)/$(BASE_NAME):$(IMG_TAG)%" $(TGT)/Dockerfile > $(CTX_ROOT)/$(TGT)/Dockerfile.$(TGT)
		$(DOCKER_BIN) build --tag=$(IMG) --file=$(CTX_ROOT)/$(TGT)/Dockerfile.$(TGT) $(CTX_ROOT)/$(TGT)
