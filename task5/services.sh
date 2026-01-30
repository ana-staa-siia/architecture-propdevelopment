kubectl create namespace app-namespace

# Создание сервисов с метками
kubectl run front-end-app --image=nginx --labels role=front-end --expose --port 80 -n app-namespace
kubectl run back-end-api-app --image=nginx --labels role=back-end-api --expose --port 80 -n app-namespace
kubectl run admin-front-end-app --image=nginx --labels role=admin-front-end --expose --port 80 -n app-namespace
kubectl run admin-back-end-api-app --image=nginx --labels role=admin-back-end-api --expose --port 80 -n app-namespace

# Применение политик
kubectl apply -f non-admin-api-allow.yaml
kubectl apply -f admin-api-allow.yaml
