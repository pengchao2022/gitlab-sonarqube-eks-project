# 使用最简单的 Ingress 配置
cat > clean-ingress.yaml << 'EOF'
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: sonarqube-clean
  namespace: sonarqube
  annotations:
    alb.ingress.kubernetes.io/scheme: internet-facing
    alb.ingress.kubernetes.io/target-type: ip
spec:
  ingressClassName: alb
  rules:
  - http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: sonarqube-service
            port:
              number: 9000
EOF

kubectl apply -f clean-ingress.yaml -n sonarqube

echo "等待 ALB 创建..."
sleep 180
