#!/usr/bin/env bash

dirout=certs
filea=authority
filec=development_dev

[ -d ${dirout} ] && sudo rm -r ${dirout}
mkdir ${dirout}

openssl genrsa -out ${dirout}/${filea}.key 4096

openssl req \
    -x509 \
    -new \
    -nodes \
    -config authority.cnf \
    -key ${dirout}/${filea}.key \
    -sha256 \
    -days 365 \
    -out ${dirout}/${filea}.pem

openssl genrsa -out ${dirout}/${filec}.key 4096

openssl req \
    -new \
    -config selfsigned.cnf \
    -key ${dirout}/${filec}.key \
    -out ${dirout}/${filec}.csr

openssl x509 \
    -req \
    -in ${dirout}/${filec}.csr \
    -CA ${dirout}/${filea}.pem \
    -CAkey ${dirout}/${filea}.key \
    -CAcreateserial \
    -out ${dirout}/${filec}.crt \
    -days 365 \
    -sha256

# Check your signed certificates capabilities:
# 
# openssl x509 -noout -in ${dirout}/${filec}.crt -text -purpose

