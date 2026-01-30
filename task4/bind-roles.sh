#!/bin/bash

# 1. viewer-user → viewer-role
cat <<EOF | kubectl apply -f -
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: viewer-binding
  namespace: test-namespace
subjects:
- kind: User
  name: viewer-user
  apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: Role
  name: viewer-role
  apiGroup: rbac.authorization.k8s.io
EOF

# 2. developer-user → developer-role
cat <<EOF | kubectl apply -f -
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: developer-binding
  namespace: test-namespace
subjects:
- kind: User
  name: developer-user
  apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: Role
  name: developer-role
  apiGroup: rbac.authorization.k8s.io
EOF

# 3. auditor-user → auditor-role
cat <<EOF | kubectl apply -f -
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: auditor-binding
subjects:
- kind: User
  name: auditor-user
  apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: ClusterRole
  name: auditor-role
  apiGroup: rbac.authorization.k8s.io
EOF

# 4. admin-user → cluster-admin
cat <<EOF | kubectl apply -f -
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: admin-binding
subjects:
- kind: User
  name: admin-user
  apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: ClusterRole
  name: cluster-admin
  apiGroup: rbac.authorization.k8s.io
EOF

# Создание контекстов для удобства
echo "Создание контекстов..."
kubectl config set-context viewer-context --cluster=minikube --user=viewer-user --namespace=test-namespace
kubectl config set-context developer-context --cluster=minikube --user=developer-user --namespace=test-namespace
kubectl config set-context auditor-context --cluster=minikube --user=auditor-user
kubectl config set-context admin-context --cluster=minikube --user=admin-user