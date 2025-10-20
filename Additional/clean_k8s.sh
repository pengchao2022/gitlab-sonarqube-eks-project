# 删除所有 Ingress
kubectl get ingress -n sonarqube -o name | while read ingress; do
    kubectl patch "$ingress" -n sonarqube -p '{"metadata":{"finalizers":[]}}' --type=merge
    kubectl delete "$ingress" -n sonarqube --grace-period=0
done

# 重启 ALB 控制器
kubectl rollout restart deployment/aws-load-balancer-controller -n kube-system
