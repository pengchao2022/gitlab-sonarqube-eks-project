pengchaoma@Pengchaos-MacBook-Pro gitlab-sonarqube-eks-project % kubectl apply -f k8s/namespaces.yaml
namespace/gitlab created
namespace/sonarqube created
pengchaoma@Pengchaos-MacBook-Pro gitlab-sonarqube-eks-project % kubectl get namespaces | grep -E "(gitlab|sonarqube)"
gitlab            Active   17s
sonarqube         Active   17s
pengchaoma@Pengchaos-MacBook-Pro gitlab-sonarqube-eks-project % kubectl apply -f k8s/gitlab/pvc.yaml -n gitlab
persistentvolumeclaim/gitlab-pvc created
pengchaoma@Pengchaos-MacBook-Pro gitlab-sonarqube-eks-project % kubectl apply -f k8s/gitlab/deployment.yaml -n gitlab
deployment.apps/gitlab created
pengchaoma@Pengchaos-MacBook-Pro gitlab-sonarqube-eks-project % kubectl apply -f k8s/gitlab/service.yaml -n gitlab
service/gitlab-service created
pengchaoma@Pengchaos-MacBook-Pro gitlab-sonarqube-eks-project % kubectl apply -f k8s/gitlab/ingress.yaml -n gitlab
ingress.networking.k8s.io/gitlab-ingress created
pengchaoma@Pengchaos-MacBook-Pro gitlab-sonarqube-eks-project % kubectl apply -f k8s/sonarqube/pvc.yaml -n sonarqube
persistentvolumeclaim/sonarqube-data-pvc created
persistentvolumeclaim/sonarqube-extensions-pvc created
pengchaoma@Pengchaos-MacBook-Pro gitlab-sonarqube-eks-project % kubectl apply -f k8s/sonarqube/deployment.yaml -n sonarqube
deployment.apps/sonarqube created
pengchaoma@Pengchaos-MacBook-Pro gitlab-sonarqube-eks-project % kubectl apply -f k8s/sonarqube/service.yaml -n sonarqube
service/sonarqube-service created
pengchaoma@Pengchaos-MacBook-Pro gitlab-sonarqube-eks-project % kubectl apply -f k8s/sonarqube/ingress.yaml -n sonarqube
ingress.networking.k8s.io/sonarqube-ingress created
pengchaoma@Pengchaos-MacBook-Pro gitlab-sonarqube-eks-project % 

