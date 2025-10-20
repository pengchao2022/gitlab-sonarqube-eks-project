# 修复安全组规则
ALB_SG="sg-0412394032bf6b924"
CLUSTER_SG="sg-043b8fb44b1436997"

echo "添加安全组规则..."
aws ec2 authorize-security-group-ingress --region us-east-1 \
  --group-id $CLUSTER_SG \
  --protocol tcp \
  --port 9000 \
  --source-group $ALB_SG

echo "安全组规则已添加"
