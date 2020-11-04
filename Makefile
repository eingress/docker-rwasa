
include .env
export

SHELL := /bin/bash

.PHONY: build push release

build:
	docker build \
		--build-arg FASM_VERSION=$$FASM_VERSION \
		--build-arg HEAVYTHING_VERSION=$$HEAVYTHING_VERSION \
		-t $$IMAGE_NAME:$$IMAGE_VERSION \
		-t $$IMAGE_NAME:latest \
		.

push:
	docker push $$IMAGE_NAME

release: build push