## Task 4: Deploy a Microservice Application on AKS Cluster and Access It Publicly

**Objective**:  
Deploy a sample microservices-based application on an Azure Kubernetes Service (AKS) cluster and expose it to the public internet using a Kubernetes `LoadBalancer` service.

---

## Prerequisites
- An AKS cluster deployed (e.g., from Task 3).
- `kubectl` configured with cluster credentials:
  ```bash
  az aks get-credentials --resource-group <your-resource-group> --name <aks-cluster-name>
  ```
- Azure CLI installed (verify with `az --version`).
- Access to the [Azure Portal](https://portal.azure.com) with sufficient permissions (Owner or Contributor).

---

## Steps to Complete the Task

### Step 1: Prepare Deployment YAML
1. Create a file named `app-deployment.yaml` for a sample microservice (using a simple static site image):
   ```yaml
   apiVersion: apps/v1
   kind: Deployment
   metadata:
     name: demo-app
   spec:
     replicas: 2
     selector:
       matchLabels:
         app: demo
     template:
       metadata:
         labels:
           app: demo
       spec:
         containers:
         - name: demo-container
           image: dockersamples/static-site
           ports:
           - containerPort: 80
   ```

### Step 2: Expose the Application
1. Create a file named `app-service.yaml` to expose the deployment with a `LoadBalancer` service:
   ```yaml
   apiVersion: v1
   kind: Service
   metadata:
     name: demo-service
   spec:
     type: LoadBalancer
     selector:
       app: demo
     ports:
       - protocol: TCP
         port: 80
         targetPort: 80
   ```

---

### Step 3: Deploy on AKS
1. Apply the deployment and service to the AKS cluster:
   ```bash
   kubectl apply -f app-deployment.yaml
   kubectl apply -f app-service.yaml
   ```

---

### Step 4: Get Public IP
1. Check the external IP assigned to the `LoadBalancer` service:
   ```bash
   kubectl get svc demo-service
   ```
2. Wait 1–2 minutes for the `EXTERNAL-IP` column to show an actual IP address (e.g., `20.123.456.789`).
3. Access the application in a browser at:
   ```
   http://<EXTERNAL-IP>
   ```
   You should see the static site from the `dockersamples/static-site` image.

---

### Step 5: Optional - Use Helm for Complex Apps
For more complex microservices (e.g., frontend, backend, database), consider using a Helm chart:
- Create a Helm chart:
  ```bash
  helm create my-app
  ```
- Modify the `values.yaml` file to define deployments and services for each microservice.
- Deploy the Helm chart:
  ```bash
  helm install my-app-release ./my-app
  ```
- This simplifies managing multiple services and configurations.

---

## Outcome
- A microservice application (`demo-app`) is deployed on the AKS cluster with 2 replicas for high availability.
- The application is accessible publicly via a `LoadBalancer` service at `http://<EXTERNAL-IP>`.
- Optional Helm usage is understood for managing complex multi-service applications.

---

## Resources
- [YouTube: Deploy Microservices on AKS](https://www.youtube.com/results?search_query=deploy+microservices+on+aks)
- [Rollback Kubernetes Deployment: Complete Guide with Rolling Update and Rollout Undo
](https://www.youtube.com/watch?v=JDoRXJNr4es)
- [Kubernetes Service Types](https://kubernetes.io/docs/concepts/services-networking/service/)
- [AKS Documentation](https://learn.microsoft.com/azure/aks/)
