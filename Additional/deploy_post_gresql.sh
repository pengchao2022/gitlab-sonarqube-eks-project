kubectl apply -f postgresql/namespace.yaml
kubectl apply -f postgresql/secrets.yaml
kubectl apply -f postgresql/pvc.yaml
kubectl apply -f postgresql/configmap.yaml
kubectl apply -f postgresql/deployment.yaml
kubectl apply -f postgresql/service.yaml
