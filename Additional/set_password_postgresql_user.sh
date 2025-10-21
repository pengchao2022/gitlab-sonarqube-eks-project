# 进入 PostgreSQL Pod
kubectl exec -it -n postgresql $(kubectl get pods -n postgresql -l app=postgresql -o name) -- bash

# 为用户设置密码
psql -U postgres -c "ALTER USER gitlab WITH PASSWORD 'gitlab12345';"
psql -U postgres -c "ALTER USER gitlab_replicator WITH PASSWORD 'replicator123';"
psql -U postgres -c "ALTER USER registry WITH PASSWORD 'registry123';"

# 验证密码设置
psql -U postgres -c "SELECT usename, passwd IS NOT NULL as has_password FROM pg_shadow WHERE usename IN ('gitlab', 'gitlab_replicator', 'registry');"
