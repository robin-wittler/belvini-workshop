#!/bin/bash

IP=$(kubectl get svc stateful-demo --template="{{range .status.loadBalancer.ingress}}{{.ip}}{{end}}")

COUNTER=0
MAX=${1:-10}

while true; do
  curl -X 'GET' "http://$IP/" -H 'accept: application/json'; echo;
  COUNTER=$((COUNTER+1))
  if [ "$COUNTER" -ge "$MAX" ]; then
    break
  fi
done