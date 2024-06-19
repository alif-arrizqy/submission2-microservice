#!/bin/bash

echo "KarsaJobs Deployment Script"

echo "Creating karsajobs-ns namespace"
# create karsajobs namespace
kubectl create namespace karsajobs-ns

# get all resources in karsajobs namespace
kubectl get statefulset,service,po,pv,pvc -n karsajobs-ns

kubectl get statefulset,service,po,pv,pvc -n karsajobs-ns -o wide

echo "Deploying resources in karsajobs-ns namespace ...."
echo "Deploying mongo resources in karsajobs-ns namespace"
# deploy mongo resources in karsajobs namespace
kubectl apply -f mongo-secret.yaml -f mongo-configmap.yaml -f mongo-pv-pvc.yaml -f mongo-statefulset.yaml -f mongo-service.yaml -n karsajobs-ns

echo "Deploying karsajobs (Backend)"
# deploy karsajobs (backend) resources in karsajobs namespace
kubectl apply -f karsajobs-deployment.yaml -f karsajobs-service.yaml -n karsajobs-ns

echo "Deploying karsajobs-ui (Frontend)"
# deploy karsajobs-ui (frontend) resources in karsajobs namespace
kubectl apply -f karsajobs-ui-deployment.yaml -f karsajobs-ui-service.yaml -n karsajobs-ns

echo "==============================================="

echo "Deploying monitoring resources in monitoring namespace"
# create monitoring namespace
kubectl create namespace monitoring

echo "Installing Helm"
# monitoring configuration
# install Helm
curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash

# add prometheus community repo
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts

# update helm repo
helm repo update

echo "Installing Prometheus"
# install prometheus
helm install prometheus prometheus-community/prometheus -n monitoring

# add grafana repo
helm repo add grafana https://grafana.github.io/helm-charts

# update helm repo
helm repo update

echo "Installing Grafana"
# install grafana
helm install grafana grafana/grafana -n monitoring

echo "==============================================="

echo "Get password login for Grafana"
# retrieve grafana admin password
kubectl get secret --namespace monitoring grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo



# Port Forwarding
echo "karsajobs port-forwarding to 8009:8080"
# set up port-forwarding to access karsajobs API
# kubectl port-forward pod/karsajobs-7d89497658-shhfh -n karsajobs-ns 8009:8080

echo "karsajobs-ui port-forwarding to 3003:8000"
# set up port-forwarding to access karsajobs UI
# kubectl port-forward pod/karsajobs-ui-6478bd5f4-db5vj -n karsajobs-ns 3003:8000

echo "Grafana port-forwarding to 3000:80"
# set up port-forwarding to access grafana dashboard
kubectl port-forward --namespace monitoring svc/grafana 3000:80

# mongodb execute command
# kubectl exec -it <mongo-pod-name> -- /bin/bash

# mongo --username admin --password supersecretpassword --authenticationDatabase admin

