# 1. 删除现有的部署和 PVC
kubectl delete -f k8s/gitlab/ -n gitlab --ignore-not-found=true
kubectl delete -f k8s/sonarqube/ -n sonarqube --ignore-not-found=true

# 2. 创建无 PVC 的 GitLab 部署
cat > k8s/gitlab/deployment-no-pvc.yaml << 'EOF'
apiVersion: apps/v1
kind: Deployment
metadata:
  name: gitlab
  namespace: gitlab
  labels:
    app: gitlab
spec:
  replicas: 1
  selector:
    matchLabels:
      app: gitlab
  template:
    metadata:
      labels:
        app: gitlab
    spec:
      containers:
      - name: gitlab
        image: gitlab/gitlab-ce:latest
        ports:
        - containerPort: 80
          name: http
        - containerPort: 443
          name: https
        - containerPort: 22
          name: ssh
        env:
        - name: GITLAB_OMNIBUS_CONFIG
          value: |
            external_url 'http://gitlab.example.com'
            gitlab_rails['gitlab_shell_ssh_port'] = 2222
            gitlab_rails['time_zone'] = 'UTC'
        resources:
          requests:
            memory: "512Mi"
            cpu: "250m"
          limits:
            memory: "1Gi"
            cpu: "500m"
EOF

# 3. 创建无 PVC 的 SonarQube 部署
cat > k8s/sonarqube/deployment-no-pvc.yaml << 'EOF'
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
        resources:
          requests:
            memory: "512Mi"
            cpu: "250m"
          limits:
            memory: "1Gi"
            cpu: "500m"
EOF

# 4. 部署无 PVC 版本
kubectl apply -f k8s/gitlab/deployment-no-pvc.yaml -n gitlab
kubectl apply -f k8s/gitlab/service.yaml -n gitlab
kubectl apply -f k8s/gitlab/ingress.yaml -n gitlab

kubectl apply -f k8s/sonarqube/deployment-no-pvc.yaml -n sonarqube
kubectl apply -f k8s/sonarqube/service.yaml -n sonarqube
kubectl apply -f k8s/sonarqube/ingress.yaml -n sonarqube

# 5. 监控部署
echo "监控部署进度..."
kubectl get pods -n gitlab -w &
kubectl get pods -n sonarqube -w &
