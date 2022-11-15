echo "Creating namespace"
kubectl apply -f ./install/00-kateyes-ns.yaml
echo "Creating Ingress Controller"
helm upgrade -n kateyes kateyes-nginx ingress-nginx/ingress-nginx --version 4.2.1 --install -f ./install/ingress-controller/values.yaml
echo "Installing Kateyes"