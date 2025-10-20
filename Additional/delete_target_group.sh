# 获取目标组 ARN
TARGET_GROUP_ARN="arn:aws:elasticloadbalancing:us-east-1:319998871902:targetgroup/k8s-sonarqub-sonarqub-40968ff86b/91ac907fbbd5c7c5"

# 手动删除目标组
aws elbv2 delete-target-group --target-group-arn $TARGET_GROUP_ARN
