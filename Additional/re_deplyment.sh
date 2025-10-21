# 1. 缩放到 0 个副本
kubectl scale deployment gitlab -n gitlab --replicas=0

# 2. 等待所有 Pod 终止
kubectl get pods -n gitlab -w

# 3. 重新缩放到 1 个副本
kubectl scale deployment gitlab -n gitlab --replicas=1

# 4. 查看新 Pod
kubectl get pods -n gitlab
