# 让 Kubernetes 自动选择（可能会选 74 或 154）
kubectl patch deployment sonarqube -n sonarqube -p '{"spec":{"template":{"spec":{"nodeSelector":null}}}}'

kubectl delete pods -n sonarqube -l app=sonarqube --force --grace-period=0
kubectl wait --for=condition=ready pod -l app=sonarqube -n sonarqube --timeout=180s
kubectl get pods -n sonarqube -o wide
