echo "Creating namespace"
kubectl apply -f ./install/00-kateyes-ns.yaml
echo "Creating Ingress Controller"
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update
helm upgrade -n kateyes kateyes-nginx ingress-nginx/ingress-nginx --version 4.2.1 --install -f ./install/ingress-controller/values.yaml
echo "Installing Kateyes"