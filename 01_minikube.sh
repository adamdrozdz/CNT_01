#! /bin/bash

set -exu

# The following api server flags are equal to the following in the apiserver binary:
# --oidc-client-id
# --oidc-issuer-url
# --oidc-username-claim
# --oidc-groups-claim

minikube start \
  --vm-driver virtualbox \
  --extra-config=apiserver.Authorization.Mode=RBAC \
  --extra-config apiserver.Authentication.OIDC.ClientID=$CLIENT_ID \
  --extra-config apiserver.Authentication.OIDC.IssuerURL=https://192.168.99.100:32001 \
  --extra-config apiserver.Authentication.OIDC.UsernameClaim=email \
  --extra-config apiserver.Authentication.OIDC.GroupsClaim=groups \
  --extra-config apiserver.Authentication.OIDC.CAFile=/var/lib/localkube/certs/ca.crt \
  --memory 4096 \
  --cpus 4

minikube ip 

kubectl cluster-info
