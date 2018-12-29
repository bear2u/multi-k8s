docker build -t bear2u/multi-client:latest -t bear2u/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t bear2u/multi-server:latest -t bear2u/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t bear2u/multi-worker:latest -t bear2u/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push bear2u/multi-client:latest
docker push bear2u/multi-server:latest
docker push bear2u/multi-worker:latest

docker push bear2u/multi-client:$SHA
docker push bear2u/multi-server:$SHA
docker push bear2u/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployment/server-deployment server=bear2u/multi-server:$SHA
kubectl set image deployment/client-deployment client=bear2u/multi-client:$SHA
kubectl set image deployment/worker-deployment worker=bear2u/multi-worker:$SHA