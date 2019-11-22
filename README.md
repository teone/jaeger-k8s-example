# Jaeger K8s example

Setup a kubernetes cluster, or use an existing one:

```
kind create cluster
```

Deploy the development image of `Jaeger`:

```
kubectl create -f jaeger-all-in-one-template.yml
```

Build the container:

```
docker build -t matteoscandolo/jaeger-k8s-example .
```

Deploy the container on top of kubernetes

```
kind load docker-image matteoscandolo/jaeger-k8s-example:latest
kubectl create -f jaeger-k8s-example.yml
```

Open the Jaeger dashboard and see your metrics:

```
kubectl port-forward service/jaeger-query 3000:80
```