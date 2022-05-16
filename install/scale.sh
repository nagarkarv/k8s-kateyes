kubectl scale deployment -n kateyes --replicas=0 kateyes-client-deployment 
kubectl scale deployment -n kateyes --replicas=1 kateyes-client-deployment 
kubectl scale deployment -n kateyes --replicas=0 kateyes-server-deployment 
kubectl scale deployment -n kateyes --replicas=1 kateyes-server-deployment 
