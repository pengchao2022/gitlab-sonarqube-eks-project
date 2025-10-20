# 获取目标组信息
aws elbv2 describe-target-groups --query 'TargetGroups[?contains(TargetGroupName, `sonarqub`)]'

# 获取目标组 ARN 并检查健康状态
TARGET_GROUP_ARN=$(aws elbv2 describe-target-groups --query 'TargetGroups[?contains(TargetGroupName, `sonarqub`)].TargetGroupArn' --output text)
aws elbv2 describe-target-health --target-group-arn $TARGET_GROUP_ARN
