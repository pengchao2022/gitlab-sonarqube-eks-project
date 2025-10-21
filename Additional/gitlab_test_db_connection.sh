# 从 GitLab Pod 测试连接
kubectl exec -it gitlab-6554f5bc8c-ldx9n -n gitlab -- bash

# 在 GitLab Pod 中执行：
apt-get update && apt-get install -y postgresql-client

# 测试连接
psql -h postgresql.postgresql.svc.cluster.local -U gitlab -d gitlabhq_production -W
# 输入密码: gitlab12345
