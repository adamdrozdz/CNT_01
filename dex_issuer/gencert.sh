#!/bin/bash

mkdir -p ssl

cat << EOF > ssl/req.cnf
[req]
req_extensions = v3_req
distinguished_name = req_distinguished_name
[req_distinguished_name]
[ v3_req ]
basicConstraints = CA:FALSE
keyUsage = nonRepudiation, digitalSignature, keyEncipherment
subjectAltName = IP:192.168.99.100
EOF

openssl genrsa -out ssl/key.pem 2048
openssl req -new -key ssl/key.pem -out ssl/csr.pem -subj "/CN=dex" -config ssl/req.cnf
openssl x509 -req -in ssl/csr.pem -CA ~/.minikube/ca.crt -CAkey ~/.minikube/ca.key -CAcreateserial -out ssl/cert.pem -days 3650 -extensions v3_req -extfile ssl/req.cnf
