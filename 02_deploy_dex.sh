#! /bin/bash

set -exu


kubectl create secret \
  -n kube-system \
  generic \
  github-client \
  --from-literal=client-id=$GITHUB_CLIENT_ID \
  --from-literal=client-secret=$GITHUB_CLIENT_SECRET \

#generate your own certs
dex_issuer/gencert.sh 
#rbac role for k8s dashboard
kubectl create clusterrolebinding kube-system-cluster-admin --clusterrole=cluster-admin --serviceaccount=kube-system:default 
# secret with your certs
kubectl create secret tls -n kube-system dex --cert=ssl/cert.pem --key=ssl/key.pem 
#deploy dex issuer 
kubectl create -f dex_issuer/issuer.yaml 


