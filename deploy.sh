echo "Creating namespace"
kubectl apply -f ./install/00-kateyes-ns.yaml
echo "Creating Ingress Controller"
helm upgrade -n kateyes kateyes-nginx ingress-nginx/ingress-nginx --version $INGRESS_VERSION --install -f ./install/ingress-controller/values.yaml
echo "Installing Kateyes"