#!/bin/bash

for f in *.yaml
do
	echo "Removing k8s artefact for - $f"
    kubectl delete -f $f
done

kubectl apply -f kubernetes-secrets.yaml
kubectl apply -f postgres-deployment.yaml
kubectl apply -f postgres-service.yaml
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml

