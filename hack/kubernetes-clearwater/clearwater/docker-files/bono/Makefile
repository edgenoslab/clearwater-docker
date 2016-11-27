IMG_NAME = docker.io/tangfeixiong/clearwater-bono

IMG_TAG = 1.0

DOCKER_BIN := $(shell which docker)

BLD_CTX := ../../../../../bono

.PHONY: all
all:
		$(shell cp Dockerfile $(BLD_CTX)/Dockerfile.1)
		$(DOCKER_BIN) build --tag=$(IMG_NAME):$(IMG_TAG) --file=$(BLD_CTX)/Dockerfile.1 $(BLD_CTX)
