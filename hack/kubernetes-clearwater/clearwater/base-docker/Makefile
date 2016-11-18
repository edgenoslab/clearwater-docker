IMG_NAME = docker.io/tangfeixiong/clearwater-base-onbuild

IMG_TAG = $(shell date +%y%m%d%H%M).gitrev-$(shell git rev-parse --short=7 HEAD)

DOCKER_BIN := $(shell which docker)

BLD_CTX := ../../../../base

.PHONY: all
all:
        $(shell cp Dockerfile $(BLD_CTX)/Dockerfile.tangfx)
        $(DOCKER_BIN) build --tag=$(IMG_NAME):$(IMG_TAG) --file=$(BLD_CTX)/Dockerfile.tangfx $(BLD_CTX)
