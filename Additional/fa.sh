# 删除所有相关的负载均衡器
echo "删除负载均衡器..."
aws elbv2 describe-load-balancers --query 'LoadBalancers[?contains(LoadBalancerName, `sonarqub`)].LoadBalancerArn' --output text | while read lb_arn; do
    if [ ! -z "$lb_arn" ]; then
        echo "删除负载均衡器: $lb_arn"
        aws elbv2 delete-load-balancer --load-balancer-arn $lb_arn
    fi
done

# 强制删除卡住的目标组
echo "删除目标组..."
aws elbv2 delete-target-group --target-group-arn arn:aws:elasticloadbalancing:us-east-1:319998871902:targetgroup/k8s-sonarqub-sonarqub-40968ff86b/91ac907fbbd5c7c5 --region us-east-1 2>/dev/null || echo "目标组可能已删除"

# 重启 ALB 控制器
echo "重启 ALB 控制器..."
kubectl rollout restart deployment/aws-load-balancer-controller -n kube-system
