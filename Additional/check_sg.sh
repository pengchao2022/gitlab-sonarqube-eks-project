# 获取 ALB 安全组 ID
ALB_SG="sg-0412394032bf6b924"

# 检查 ALB 安全组的出站规则
echo "=== ALB 安全组出站规则 ==="
aws ec2 describe-security-groups --region us-east-1 --group-ids $ALB_SG --query "SecurityGroups[0].IpPermissionsEgress" --output table

# 检查节点安全组
CLUSTER_SG=$(aws ec2 describe-security-groups --region us-east-1 --filters "Name=tag:Name,Values=*comic-website-prod*" --query "SecurityGroups[0].GroupId" --output text)
echo "集群安全组: $CLUSTER_SG"

# 检查节点安全组的入站规则（9000端口）
echo "=== 节点安全组入站规则（9000端口）==="
aws ec2 describe-security-groups --region us-east-1 --group-ids $CLUSTER_SG --query "SecurityGroups[0].IpPermissions[?ToPort==\`9000\`]" --output table
