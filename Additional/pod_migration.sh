# 迁移到内存使用较低的节点
kubectl patch deployment sonarqube -n sonarqube -p '{"spec":{"template":{"spec":{"nodeSelector":{"kubernetes.io/hostname":"ip-10-0-101-74.ec2.internal"}}}}}'

# 等待 Pod 迁移
echo "等待 SonarQube 迁移到新节点..."
kubectl rollout status deployment/sonarqube -n sonarqube --timeout=180s

# 检查新 Pod 位置
kubectl get pods -n sonarqube -o wide
