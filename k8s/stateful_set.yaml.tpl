apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: stateful-demo
spec:
  selector:
    matchLabels:
      app: stateful-demo
  serviceName: "stateful-demo"
  replicas: 3
  updateStrategy:
    type: RollingUpdate
  template:
    metadata:
      labels:
        app: stateful-demo
    spec:
      securityContext:
        fsGroup: 65532
        runAsUser: 65532
        runAsGroup: 65532
      containers:
      - name: stateful-demo
        command:
          - "/venv/bin/uvicorn"
          - --host=0.0.0.0
          - --port=8000
          - "main:app"
        image: $REMOTE_TAG
        imagePullPolicy: Always
        ports:
        - containerPort: 8000
          name: fastapi
        volumeMounts:
        - name: "pvc-stateful-demo"
          mountPath: /data
  volumeClaimTemplates:
  - metadata:
      name: "pvc-stateful-demo"
    spec:
      accessModes: [ "ReadWriteOnce" ]
      #storageClassName: "stateful-demo"
      resources:
        requests:
          storage: 1Gi