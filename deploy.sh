docker build -t tumenzul/multi-client:latest -t tumenzul/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t tumenzul/multi-server:latest -t tumenzul/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t tumenzul/multi-worker:latest -t tumenzul/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push tumenzul/multi-client:latest
docker push tumenzul/multi-server:latest
docker push tumenzul/multi-worker:latest

docker push tumenzul/multi-client:$SHA
docker push tumenzul/multi-server:$SHA
docker push tumenzul/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=tumenzul/multi-server:$SHA
kubectl set image deployments/client-deployment client=tumenzul/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=tumenzul/multi-worker:$SHA