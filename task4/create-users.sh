#!/bin/bash

mkdir -p ~/.kube/users
cd ~/.kube/users

# 1. viewer-user (только просмотр)
openssl genrsa -out viewer-user.key 2048
openssl req -new -key viewer-user.key -out viewer-user.csr -subj "/CN=viewer-user/O=viewers"
openssl x509 -req -in viewer-user.csr -CA ~/.minikube/ca.crt -CAkey ~/.minikube/ca.key -CAcreateserial -out viewer-user.crt -days 365

# 2. developer-user (настройка кластера)
openssl genrsa -out developer-user.key 2048
openssl req -new -key developer-user.key -out developer-user.csr -subj "/CN=developer-user/O=developers"
openssl x509 -req -in developer-user.csr -CA ~/.minikube/ca.crt -CAkey ~/.minikube/ca.key -CAcreateserial -out developer-user.crt -days 365

# 3. auditor-user (привилегированный доступ к секретам)
openssl genrsa -out auditor-user.key 2048
openssl req -new -key auditor-user.key -out auditor-user.csr -subj "/CN=auditor-user/O=auditors"
openssl x509 -req -in auditor-user.csr -CA ~/.minikube/ca.crt -CAkey ~/.minikube/ca.key -CAcreateserial -out auditor-user.crt -days 365

# 4. admin-user (cluster-admin)
openssl genrsa -out admin-user.key 2048
openssl req -new -key admin-user.key -out admin-user.csr -subj "/CN=admin-user/O=admins"
openssl x509 -req -in admin-user.csr -CA ~/.minikube/ca.crt -CAkey ~/.minikube/ca.key -CAcreateserial -out admin-user.crt -days 365

kubectl config set-credentials viewer-user --client-certificate=viewer-user.crt --client-key=viewer-user.key
kubectl config set-credentials developer-user --client-certificate=developer-user.crt --client-key=developer-user.key
kubectl config set-credentials auditor-user --client-certificate=auditor-user.crt --client-key=auditor-user.key
kubectl config set-credentials admin-user --client-certificate=admin-user.crt --client-key=admin-user.key