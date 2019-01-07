# interrobangc/helm

EKS compatible helm/kubectl container.

# Configuration

## Mount Kube Config
A kube config file can be mounted into `/root/.kube/config` using volumes:

```
docker run -ti --rm \
    -v $(pwd):/app \
    -v ~/.kube/config:/root/.kube/config \
    interrobangc/helm:2.12.0
```


## Use Environment Variables
A kube config file can be produced using env variables.

The image supports token based authentication:
```
docker run --rm -it --name $(IMAGE_BASE)-$(IMAGE) \
		-e GENERATE_KUBECONF=true \
		-e SERVER=server \
		-e NAMESPACE=namespace \
		-e USER=user \
		-e TOKEN=token \
		$(IMAGE_BASE)/$(IMAGE) \
		cat /root/.kube/config
```

It also supports EKS authentication:
```
docker run --rm -it --name $(IMAGE_BASE)-$(IMAGE) \
		-e GENERATE_KUBECONF=true \
		-e SERVER=server \
		-e NAMESPACE=namespace \
		-e USER=user \
		-e EKS_CLUSTER=eks-cluster \
		-e EKS_ROLE_ARN=eks-role-arn \
		-e SSL_CERTIFICATE=ssl-certificate \
		interrobangc/helm:2.12.0 \
		cat /root/.kube/config
```
