# If not installed in cluster
helm init

kubectl create namespace elastic
kubectl create namespace rabbitmq
kubectl create namespace mongo



helm install --name elasticsearch elastic/elasticsearch
Helm install --name kibana elastic/kibana 
helm install --name rabbit stable/rabbitmq
helm install --name mongo stable/mongodb

export MONGODB_ROOT_PASSWORD=$(kubectl get secret --namespace mongo mongo-mongodb -o jsonpath="{.data.mongodb-root-password}" | base64 --decode)
kubectl run --namespace mongo mongo-mongodb-client --rm --tty -i --restart='Never' --image bitnami/mongodb --command -- mongo admin --host mongo-mongodb --authenticationDatabase admin -u root -p $MONGODB_ROOT_PASSWORD
kubectl port-forward --namespace mongo svc/mongo-mongodb 27017:27017 &
    mongo --host 127.0.0.1 --authenticationDatabase admin -p $MONGODB_ROOT_PASSWORD
