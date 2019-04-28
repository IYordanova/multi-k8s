docker build -t iyordanova/multi-client:latest -t iyordanova/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t iyordanova/multi-server:latest -t iyordanova/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t iyordanova/multi-worker:latest -t iyordanova/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push iyordanova/multi-client:latest
docker push iyordanova/multi-server:latest
docker push iyordanova/multi-worker:latest

docker push iyordanova/multi-client:$SHA
docker push iyordanova/multi-server:$SHA
docker push iyordanova/multi-worker :$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=iyordanova/multi-server:$SHA
kubectl set image deployments/client-deployment client=iyordanova/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=iyordanova/multi-worker:$SHA