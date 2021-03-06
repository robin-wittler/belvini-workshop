apiVersion: apps/v1
kind: Deployment
metadata:
  name: stateful-demo
spec:
  selector:
    matchLabels:
      app: stateful-demo
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
          image: $REMOTE_TAG
          command:
            - "/venv/bin/uvicorn"
            - --host=0.0.0.0
            - --port=8000
            - "main:app"
          imagePullPolicy: Always
          ports:
          - containerPort: 8000
            name: fastapi
          volumeMounts:
            - name: data
              mountPath: /data
      volumes:
        - name: data
          emptyDir: {}
      restartPolicy: Always