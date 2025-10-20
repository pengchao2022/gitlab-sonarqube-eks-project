echo "验证清理结果:"
kubectl get ingress -n sonarqube
aws elbv2 describe-load-balancers --query 'LoadBalancers[?contains(LoadBalancerName, `sonarqub`)]'
aws elbv2 describe-target-groups --query 'TargetGroups[?contains(TargetGroupName, `sonarqub`)]'
