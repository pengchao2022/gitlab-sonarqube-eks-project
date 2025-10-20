# ALB 有两个安全组，分别检查
SG1="sg-041e4cdf3325feef6"  # 节点安全组
SG2="sg-0a3ab3fd6427eb842"  # 新的 ALB 安全组

echo "检查安全组 1 (节点安全组): $SG1"
aws ec2 describe-security-groups --group-ids $SG1 --query 'SecurityGroups[0].{GroupName:GroupName,GroupId:GroupId,IpPermissionsEgress:IpPermissionsEgress}'

echo -e "\n检查安全组 2 (ALB 安全组): $SG2"
aws ec2 describe-security-groups --group-ids $SG2 --query 'SecurityGroups[0].{GroupName:GroupName,GroupId:GroupId,IpPermissionsEgress:IpPermissionsEgress}'
