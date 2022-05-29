# KATEYES™ (beta) - Visual Kubernetes Explorer

## Introduction

Kateyes™ is a client server application that provides an eye into your kubernetes cluster. To visualize the cluster, kateyes - beta needs to be deployed into the cluster. 

## Motivation
Kubernetes is hard! but it solves lots of key problems that we have been experincing in the good old days. When an application gets deployed into the cluster, there are a set of kubernetes objects that get created with certain relationships between them. As the cluster grows and you deploy more and more applications, it gets seriously complex.

There is a standard tool 'kubectl' that most of us would use to explore the cluster but then you need to understand how to use it to get the best results in a short time. More over you would need to fire atleast a couple of kubectl commands with different options to find out related information from within your cluster. 

And just imagine you are handed over a cluster that has grown in the past years from its previous owner!

## Features
In its first beta release, Kateyes provides a deep insights of your applications deployed in the cluster and most importantly the relationships between few of its important kubernetes objects in a explorable tree format. The relationship is limited to a single namespace for now. The following objects are supported and we may add more objects in future releases.
- [namespace](https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/)
- [pods](https://kubernetes.io/docs/concepts/workloads/pods/)
- [deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/)
- [replicaset](https://kubernetes.io/docs/concepts/workloads/controllers/replicaset/)
- [service](https://kubernetes.io/docs/concepts/services-networking/service/)
- [ingress](https://kubernetes.io/docs/concepts/services-networking/ingress/)
- [service endpoints](https://kubernetes.io/docs/concepts/services-networking/service/)

## Installation Requirements

You will need a working kubernetes cluster and may incur cost depending on your cloud subscriptions.

## Compatibility

This application has been tested on Google Kubernetes Engine (GKE)

```bash
$ kubectl version
Client Version: version.Info{Major:"1", Minor:"23", GitVersion:"v1.23.6", GitCommit:"ad3338546da947756e8a88aa6822e9c11e7eac22", GitTreeState:"clean", BuildDate:"2022-04-14T08:49:13Z", GoVersion:"go1.17.9", Compiler:"gc", Platform:"linux/amd64"}
Server Version: version.Info{Major:"1", Minor:"21", GitVersion:"v1.21.10-gke.2000", GitCommit:"0823380786b063c3f71d5e7c76826a972e30550d", GitTreeState:"clean", BuildDate:"2022-03-17T09:22:22Z", GoVersion:"go1.16.14b7", Compiler:"gc", Platform:"linux/amd64"}

$ kubectl version --short
Client Version: v1.23.6
Server Version: v1.21.10-gke.2000
```

## Docker Hub

- Client: https://hub.docker.com/repository/docker/kateyes/kateyes-client 
- Server: https://hub.docker.com/repository/docker/kateyes/kateyes-server 

## How to Deploy

Kateyes is easy to deploy.

This repository consists of a several yaml manifests in the "install" folder that needs to be applied with a simple command as below

```bash
kubectl apply -f install/.
```
This will install the client and server into a dedicated namespace 'kateyes'. It also deploys an nginx ingress controller configured with class name as 'kateyes-nginx'. After successfull deployment, you should get an external loadbalancer ip for the controller which can be used to access the application.

Use the following command to grab the LoadBalancer IP

```bash
$ kubectl get svc -n kateyes ingress-nginx-controller
NAME                       TYPE           CLUSTER-IP   EXTERNAL-IP     PORT(S)                      AGE
ingress-nginx-controller   LoadBalancer   10.72.9.38   <THIS-IP>       80:31974/TCP,443:31568/TCP   76s
```

**NOTE:**
While deploying you may get an error message 'no endpoints available for service "ingress-nginx-controller-admission'. To resolve, wait for a short while for the endpoints to get registered and re-run the command again.

## Custom Ingress
If you do not want to deploy a new ingress controller and would like to connect to your existing controller in the cluster
1. Do not apply the file '01-kateyes-nginx-ingress-ctrl.yaml'
2. Update the annotations kubernetes. io/ingress. class with appropriate ingress class 
   - 05-kateyes-client-ingress.yaml
   - 05-kateyes-server-ingress.yaml
3. Apply the changed configurations.


## TestData

If you want to use a new empty cluster to check the application, a TestData folder has been included containing a set of manifests that can be installed into the cluster. Once deployed it can be explored using Kateyes™

Use the command below to install  TestData

```bash
kubectl apply -f TestData/.
```

The TestData folder includes a folder 'load' which has manifests to deploy a large number of pods(40).

## Examples

Exploring 'default' namespace

![plot](./images/default-namespace.png)

Exploring 'kube-system' namespace

![plot](./images/kube-system.png)

Exploring 'kubernetes-dashboard' namespace

![plot](./images/kubernetes-dashboard.png)

Exploring 'prod-env' namespace (from TestData)

![plot](./images/prd-env.png)

## LICENSE
The Kateyes™ beta is licensed under MIT License
