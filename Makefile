.PHONY: build run

IMAGE_BASE = interrobangc
IMAGE = helm
MY_PWD = $(shell pwd)

all: build

build:
ifdef NOCACHE
	docker build --no-cache -t $(IMAGE_BASE)/$(IMAGE) .
else
	docker build -t $(IMAGE_BASE)/$(IMAGE) .
endif

build-and-push:
	IMAGE=$(IMAGE_BASE)/$(IMAGE) \
	./buildAndPush.sh

shell:
	docker run --rm -it --name $(IMAGE_BASE)-$(IMAGE) $(IMAGE_BASE)/$(IMAGE) sh

dump-kubeconfig-token:
	docker run --rm -it --name $(IMAGE_BASE)-$(IMAGE) \
		-e GENERATE_KUBECONF=true \
		-e SERVER=server \
		-e NAMESPACE=namespace \
		-e USER=user \
		-e TOKEN=token \
		$(IMAGE_BASE)/$(IMAGE) \
		cat /root/.kube/config

dump-kubeconfig-eks:
	docker run --rm -it --name $(IMAGE_BASE)-$(IMAGE) \
		-e GENERATE_KUBECONF=true \
		-e SERVER=server \
		-e NAMESPACE=namespace \
		-e USER=user \
		-e EKS_CLUSTER=eks-cluster \
		-e EKS_ROLE_ARN=eks-role-arn \
		-e SSL_CERTIFICATE=ssl-certificate \
		$(IMAGE_BASE)/$(IMAGE) \
		cat /root/.kube/config
