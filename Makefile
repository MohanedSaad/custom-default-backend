REGISTRY := eu.gcr.io/oceanus-235213
IMAGE_NAME := oceanus-ingress-nginx-default-backend-docker
BUILD_TAGS := build
IMAGE_TAGS := canary
IMAGE_TAG := latest

docker_build:
	docker build -t $(REGISTRY)/$(IMAGE_NAME):$(BUILD_TAGS) .

docker_push: docker_build
	set -e; \
		for tag in $(IMAGE_TAGS); do \
			docker tag $(REGISTRY)/$(IMAGE_NAME):$(BUILD_TAGS) $(REGISTRY)/$(IMAGE_NAME):$${tag} ; \
			gcloud docker -- push $(REGISTRY)/$(IMAGE_NAME):$${tag}; \
		done