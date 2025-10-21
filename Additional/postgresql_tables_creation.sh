# 进入 PostgreSQL Pod
kubectl exec -it -n postgresql $(kubectl get pods -n postgresql -l app=postgresql -o name) -- bash

# 创建 GitLab 用户和数据库
psql -U postgres -c "CREATE USER gitlab WITH PASSWORD 'gitlab12345';"
psql -U postgres -c "CREATE USER gitlab_replicator WITH REPLICATION PASSWORD 'replicator123';"
psql -U postgres -c "CREATE USER registry WITH PASSWORD 'registry123';"
psql -U postgres -c "CREATE DATABASE gitlabhq_production OWNER gitlab;"
psql -U postgres -c "CREATE DATABASE registry OWNER registry;"
psql -U postgres -c "GRANT ALL PRIVILEGES ON DATABASE gitlabhq_production TO gitlab;"
psql -U postgres -c "GRANT ALL PRIVILEGES ON DATABASE registry TO registry;"

# 为 GitLab 数据库启用必要的扩展
psql -U postgres -d gitlabhq_production -c "CREATE EXTENSION IF NOT EXISTS pg_trgm;"
psql -U postgres -d gitlabhq_production -c "CREATE EXTENSION IF NOT EXISTS btree_gist;"
psql -U postgres -d gitlabhq_production -c "CREATE EXTENSION IF NOT EXISTS amcheck;"

# 验证创建结果
psql -U postgres -c "\du"  # 应该看到 gitlab, gitlab_replicator, registry 用户
psql -U postgres -c "\l"   # 应该看到 gitlabhq_production 和 registry 数据库
