helm uninstall -n kateyes kateyes-nginx
kubectl delete ns kateyes --grace-period=0 --force
