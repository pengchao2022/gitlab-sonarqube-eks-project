# 确认安全组规则已生效
echo "=== 检查安全组规则 ==="
CLUSTER_SG="sg-043b8fb44b1436997"
aws ec2 describe-security-groups --region us-east-1 --group-ids $CLUSTER_SG --query "SecurityGroups[0].IpPermissions[?ToPort==\`9000\`]" --output table
