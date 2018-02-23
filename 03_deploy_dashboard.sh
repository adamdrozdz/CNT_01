#! /bin/bash

set -exu


kubectl create secret \
  -n kube-system \
  generic \
  kube-dashboard-secrets \
  --from-literal=client_id=$CLIENT_ID \
  --from-literal=client_secret=$CLIENT_SECRET \
  --from-literal=session=secretsessionsdasadsdsdssa


#deploy k8s dashboard
kubectl create -f kubernetes-dashboard-oidc/dashboard.yaml

# check if already running 
kubectl rollout status -n kube-system deployment/kubernetes-dashboard-oidc
