IMG_NAME = docker.io/tangfeixiong/clearwater-homestead

IMG_TAG = 1.0

DOCKER_BIN := $(shell which docker)

BLD_CTX := ../../../../homestead

.PHONY: all
all:
        $(shell cp Dockerfile $(BLD_CTX)/Dockerfile.tangfx)
        $(DOCKER_BIN) build --tag=$(IMG_NAME):$(IMG_TAG) --file=$(BLD_CTX)/Dockerfile.tangfx $(BLD_CTX)
