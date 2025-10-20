# 1. 删除当前的 SonarQube 部署
kubectl delete -f k8s/sonarqube/deployment-fixed.yaml -n sonarqube

# 2. 检查 SonarQube 的日志以了解退出原因
kubectl logs -n sonarqube -l app=sonarqube --previous

# 3. 创建正确的 SonarQube 部署（使用正确的启动命令）
cat > k8s/sonarqube/deployment-corrected.yaml << 'EOF'
apiVersion: apps/v1
kind: Deployment
metadata:
  name: sonarqube
  namespace: sonarqube
  labels:
    app: sonarqube
spec:
  replicas: 1
  selector:
    matchLabels:
      app: sonarqube
  template:
    metadata:
      labels:
        app: sonarqube
    spec:
      containers:
      - name: sonarqube
        image: sonarqube:lts-community
        ports:
        - containerPort: 9000
          name: http
        env:
        - name: SONAR_JDBC_URL
          value: "jdbc:h2:tcp://localhost:9092/sonar"
        - name: SONAR_JDBC_USERNAME
          value: "sonar"
        - name: SONAR_JDBC_PASSWORD
          value: "sonar"
        - name: SONAR_ES_BOOTSTRAP_CHECKS_DISABLE
          value: "true"
        # 设置正确的 Java 内存参数
        - name: SONAR_WEB_JAVAOPTS
          value: "-Xmx512m -Xms128m"
        - name: SONAR_CE_JAVAOPTS
          value: "-Xmx512m -Xms128m"
        - name: SONAR_SEARCH_JAVAOPTS
          value: "-Xmx512m -Xms128m"
        resources:
          requests:
            memory: "1Gi"
            cpu: "500m"
          limits:
            memory: "2Gi"
            cpu: "1000m"
        # 添加健康检查
        livenessProbe:
          httpGet:
            path: /api/system/status
            port: 9000
          initialDelaySeconds: 60
          periodSeconds: 30
        readinessProbe:
          httpGet:
            path: /api/system/status
            port: 9000
          initialDelaySeconds: 60
          periodSeconds: 30
EOF

# 4. 部署修正后的版本
kubectl apply -f k8s/sonarqube/deployment-corrected.yaml -n sonarqube

# 5. 监控启动过程
echo "监控 SonarQube 启动..."
kubectl get pods -n sonarqube -w
