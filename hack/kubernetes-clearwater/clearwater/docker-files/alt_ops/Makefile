IMG_NS ?= 10.64.33.81:5000/admin

IMG_TAG ?= latest

BASE_NAME ?= clearwater_base-onbuild
BONO_NAME ?= clearwater_bono
ELLIS_NAME ?= clearwater_ellis
HOMER_NAME ?= clearwater_homer
HOMESTEAD_NAME ?= clearwater_homestead
RALF_NAME ?= clearwater_ralf
SPROUT_NAME ?= clearwater_sprout
CASSANDRA_NAME ?= clearwater_cassandra
CHRONOS_NAME ?= clearwater_chronos
MEMCACHED_NAME ?= clearwater_memcached

CTX_ROOT := ../../../../..

DOCKER_BIN := $(shell which docker)
CP_BIN := $(shell which cp)
SED_BIN := $(shell which sed)

.PHONY: all base bono ellis homer homestead ralf sprout cassandra chronos memcached

all: base bono ellis homer homestead ralf sprout cassandra chronos memcached

base : CTX := $(CTX_ROOT)/base
base : IMG := $(IMG_NS)/$(BASE_NAME):$(IMG_TAG)
base :
        $(CP_BIN) ../$@/Dockerfile $(CTX)/Dockerfile.tmp
        $(DOCKER_BIN) build --tag=$(IMG) --file=$(CTX)/Dockerfile.tmp $(CTX)

bono : CTX := $(CTX_ROOT)/bono
bono : IMG := $(IMG_NS)/$(BONO_NAME):$(IMG_TAG)
bono :
        $(SED_BIN) "s%^FROM .*%FROM $(IMG_NS)/$(BASE_NAME):$(IMG_TAG)%" ../$@/Dockerfile > $(CTX)/Dockerfile.tmp
        $(DOCKER_BIN) build --tag=$(IMG) --file=$(CTX)/Dockerfile.tmp $(CTX)

ellis : CTX := $(CTX_ROOT)/ellis
ellis : IMG := $(IMG_NS)/$(ELLIS_NAME):$(IMG_TAG)
ellis :
        $(SED_BIN) "s%^FROM .*%FROM $(IMG_NS)/$(BASE_NAME):$(IMG_TAG)%" ../$@/Dockerfile > $(CTX)/Dockerfile.tmp
        $(DOCKER_BIN) build --tag=$(IMG) --file=$(CTX)/Dockerfile.tmp $(CTX)

homer : CTX := $(CTX_ROOT)/homer
homer : IMG := $(IMG_NS)/$(HOMER_NAME):$(IMG_TAG)
homer :
        $(SED_BIN) "s%^FROM .*%FROM $(IMG_NS)/$(BASE_NAME):$(IMG_TAG)%" ../$@/Dockerfile > $(CTX)/Dockerfile.tmp
        $(DOCKER_BIN) build --tag=$(IMG) --file=$(CTX)/Dockerfile.tmp $(CTX)

homestead : CTX := $(CTX_ROOT)/homestead
homestead : IMG := $(IMG_NS)/$(HOMESTEAD_NAME):$(IMG_TAG)
homestead :
        $(SED_BIN) "s%^FROM .*%FROM $(IMG_NS)/$(BASE_NAME):$(IMG_TAG)%" ../$@/Dockerfile > $(CTX)/Dockerfile.tmp
        $(DOCKER_BIN) build --tag=$(IMG) --file=$(CTX)/Dockerfile.tmp $(CTX)

ralf : CTX := $(CTX_ROOT)/ralf
ralf : IMG := $(IMG_NS)/$(RALF_NAME):$(IMG_TAG)
ralf :
        $(SED_BIN) "s%^FROM .*%FROM $(IMG_NS)/$(BASE_NAME):$(IMG_TAG)%" ../$@/Dockerfile > $(CTX)/Dockerfile.tmp
        $(DOCKER_BIN) build --tag=$(IMG) --file=$(CTX)/Dockerfile.tmp $(CTX)

sprout : CTX := $(CTX_ROOT)/sprout
sprout : IMG := $(IMG_NS)/$(SPROUT_NAME):$(IMG_TAG)
sprout :
        $(SED_BIN) "s%^FROM .*%FROM $(IMG_NS)/$(BASE_NAME):$(IMG_TAG)%" ../$@/Dockerfile > $(CTX)/Dockerfile.tmp
        $(DOCKER_BIN) build --tag=$(IMG) --file=$(CTX)/Dockerfile.tmp $(CTX)

cassandra : CTX := $(CTX_ROOT)/cassandra
cassandra : IMG := $(IMG_NS)/$(CASSANDRA_NAME):$(IMG_TAG)
cassandra :
        $(SED_BIN) "s%^FROM .*%FROM $(IMG_NS)/$(BASE_NAME):$(IMG_TAG)%" ../$@/Dockerfile > $(CTX)/Dockerfile.tmp
        $(DOCKER_BIN) build --tag=$(IMG) --file=$(CTX)/Dockerfile.tmp $(CTX)

chronos : CTX := $(CTX_ROOT)/chronos
chronos : IMG := $(IMG_NS)/$(CHRONOS_NAME):$(IMG_TAG)
chronos :
        $(SED_BIN) "s%^FROM .*%FROM $(IMG_NS)/$(BASE_NAME):$(IMG_TAG)%" ../$@/Dockerfile > $(CTX)/Dockerfile.tmp
        $(DOCKER_BIN) build --tag=$(IMG) --file=$(CTX)/Dockerfile.tmp $(CTX)

memcached : CTX := $(CTX_ROOT)/memcached
memcached : IMG := $(IMG_NS)/$(MEMCACHED_NAME):$(IMG_TAG)
memcached :
        $(SED_BIN) "s%^FROM .*%FROM $(IMG_NS)/$(BASE_NAME):$(IMG_TAG)%" ../$@/Dockerfile > $(CTX)/Dockerfile.tmp
        $(DOCKER_BIN) build --tag=$(IMG) --file=$(CTX)/Dockerfile.tmp $(CTX)
