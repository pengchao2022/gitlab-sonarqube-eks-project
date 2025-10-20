# 获取 ALB 安全组 ID
ALB_ARN="arn:aws:elasticloadbalancing:us-east-1:319998871902:loadbalancer/app/k8s-sonarqub-sonarqub-b981fee97b/6be1f5279f0fcfae"
ALB_SG=$(aws elbv2 describe-load-balancers --load-balancer-arns $ALB_ARN --query 'LoadBalancers[0].SecurityGroups[0]' --output text)

echo "ALB 安全组: $ALB_SG"

# 检查 ALB 安全组的出站规则
aws ec2 describe-security-groups --group-ids $ALB_SG --query 'SecurityGroups[0].IpPermissionsEgress'
