# Jaeger K8s example

This is intended to be a very simple example of how to setup Jaeger tracing in a development environment.
It has been inspired by this blog post: https://medium.com/@masroor.hasan/tracing-infrastructure-with-jaeger-on-kubernetes-6800132a677

And resources have been taken from:
- https://github.com/jaegertracing/jaeger-kubernetes
- https://github.com/open-telemetry/opentelemetry-go/tree/master/example/jaeger

Once deploy the application will publish a trace every two seconds, with no meaningful information.
This came together to let me play a little bit with a Jaeger deployment on top of Kubernetes.

## Setup

The easiest way to replicate this example is to run it on local `kind` cluster.
If don't know what `kind` is you can find more informations at https://github.com/kubernetes-sigs/kind

If you need to install kinf you can find instructions here: https://github.com/kubernetes-sigs/kind#installation-and-usage


Start with setting up a cluster (you can use an existing one if it's already running):

```
kind create cluster
```

Deploy the development image of `Jaeger`:
> This template is slightly modified from the one available in `jaeger-kubernetes` to get it to work on kubernetes 1.16 and run in a different namespace

```
kubectl create -f jaeger-all-in-one-template.yml
```

Build the example application container:

```
docker build -t teone/jaeger-k8s-example .
```

Deploy the container on top of kubernetes
> we are manually loading the container in `kind`, if you're running your cluster somewhere else you may need to load it in a different way

```
kind load docker-image teone/jaeger-k8s-example:latest
kubectl create -f jaeger-k8s-example.yml
```

Expose the Jaeger dashboard:

```
kubectl port-forward -n tracing service/jaeger-query 3000:80
```

and check your traces [http://localhost:3000](http://localhost:3000)

## TODOs

[ ] Expose a rest endpoint to trigger the creation of the span instead of using a loop