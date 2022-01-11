# build our images
docker build -t abdallasr/multi-client:latest -t abdallasr/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t abdallasr/multi-server:latest -t abdallasr/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t abdallasr/multi-worker:latest -t abdallasr/multi-worker:$SHA -f ./worker/Dockerfile ./worker
# push them to docker hub
docker push abdallasr/multi-client:latest
docker push abdallasr/multi-client:$SHA
docker push abdallasr/multi-server:latest
docker push abdallasr/multi-server:$SHA
docker push abdallasr/multi-worker:latest
docker push abdallasr/multi-worker:$SHA
# apply the k8s configurations
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=abdallasr/multi-server:$SHA
kubectl set image deployments/client-deployment client=abdallasr/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=abdallasr/multi-worker:$SHA