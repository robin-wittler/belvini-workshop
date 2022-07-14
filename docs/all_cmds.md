##All Cmds from the presentation

###Page 9

```bash
export GCP_PROJECT=<replace-with-your-project-name>
export GCP_REGION=europe-west1
export GCP_ZONE=${GCP_REGION}-b
export GCP_CLUSTER=cluster-1
export USE_GKE_GCLOUD_AUTH_PLUGIN=True
gcloud config set project $GCP_PROJECT
gcloud config set compute/region $GCP_REGION
gcloud config set compute/zone $GCP_ZONE
```


###Page 11

```bash
gcloud --project=$GCP_PROJECT container clusters create --zone $GCP_ZONE --enable-ip-alias $GCP_CLUSTER
```


###Page 12

```bash
gcloud --project=$GCP_PROJECT artifacts repositories create belvini-repo --repository-format=docker --location=$GCP_REGION --description="belvini docker repository"
```


###Page 13

```bash
git clone https://github.com/robin-wittler/belvini-workshop.git
```


###Page 14

```bash
cd  belvini-workshop
docker build -t belvini-workshop:v0.1 .
```


###Page 15

```bash
docker run -it -p 8000:8000 belvini-workshop:v0.1 /venv/bin/uvicorn --host=0.0.0.0 --port=8000 main:app
```


###Page 18

```bash
mkdir /tmp/data && chmod o+rwx /tmp/data
docker run -it -p 8000:8000 -v /tmp/data:/data belvini-workshop:v0.1 /venv/bin/uvicorn --host=0.0.0.0 --port=8000 main:app
wget -q -O - "http://127.0.0.1:8000"
```


###Page 19

```bash
export DOCKER_REGISTRY=europe-west1-docker.pkg.dev
export REMOTE_TAG=$DOCKER_REGISTRY/$GCP_PROJECT/belvini-repo/belvini-workshop:v0.1
gcloud auth configure-docker $DOCKER_REGISTRY
docker tag belvini-workshop:v0.1 $REMOTE_TAG
docker push $REMOTE_TAG
```


###Page 20

```bash
gcloud --project=$GCP_PROJECT container clusters get-credentials $GCP_CLUSTER --zone $GCP_ZONE
source <(kubectl completion bash)
envsubst < ./k8s/deployment.yaml.tpl > ./k8s/deployment.yaml
kubectl apply -f ./k8s/deployment.yaml
kubectl apply -f ./k8s/service.yaml
```

###Page 21
```bash
kubectl get deployments.apps --watch
kubectl logs --selector app=stateful-demo --follow
```


###Page 22

```bash
./validate.sh 2
```


###Page 23

```bash
kubectl scale deployment stateful-demo –replicas=3
kubectl scale deployment stateful-demo –replicas=0
kubectl scale deployment stateful-demo –replicas=1
```


###Page 24

```bash
kubectl delete -f ./k8s/deployment.yaml
```


###Page 25

```bash
envsubst < ./k8s/stateful_set.yaml.tpl > ./k8s/stateful_set.yaml
kubectl apply -f ./k8s/stateful_set.yaml
./validate.sh 20
```


###Page 26

```bash
kubectl scale statefulset stateful-demo –replicas=5
kubectl scale statefulset stateful-demo –replicas=0
kubectl scale statefulset stateful-demo –replicas=1
```


###Page 27

```bash
kubectl delete -f ./k8s/stateful_set.yaml
Kubectl delete -f ./k8s/service.yaml
gcloud --project=$GCP_PROJECT container clusters delete $GCP_CLUSTER
gcloud --project=$GCP_PROJECT artifacts repositories delete belvini-repo --location=$GCP_REGION
```

