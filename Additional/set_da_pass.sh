# 为 gitlab 用户设置密码
kubectl exec -it -n postgresql postgresql-64786b49cc-fk6mp -- psql -U postgres << EOF
-- 为 gitlab 用户设置密码
ALTER USER gitlab WITH PASSWORD 'gitlab12345';

-- 确保有足够的权限
GRANT ALL PRIVILEGES ON DATABASE gitlabhq_production TO gitlab;

-- 连接到数据库并授予模式权限
\c gitlabhq_production
GRANT ALL ON SCHEMA public TO gitlab;
GRANT ALL ON ALL TABLES IN SCHEMA public TO gitlab;
GRANT ALL ON ALL SEQUENCES IN SCHEMA public TO gitlab;
GRANT ALL ON ALL FUNCTIONS IN SCHEMA public TO gitlab;

\q
EOF
