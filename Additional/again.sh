# 获取 SonarQube Pod IP
SONAR_POD_IP=$(kubectl get pods -n sonarqube -l app=sonarqube -o jsonpath='{.items[0].status.podIP}')
echo "SonarQube Pod IP: $SONAR_POD_IP"

# 在每个网络测试 Pod 中测试连接
kubectl get pods -n sonarqube -l name=network-test -o name | while read pod; do
    echo "测试 $pod 到 SonarQube 的连接:"
    kubectl exec -n sonarqube $pod -- curl -s -o /dev/null -w "%{http_code}" http://$SONAR_POD_IP:9000/api/system/status --connect-timeout 5
    echo " - $pod"
done
