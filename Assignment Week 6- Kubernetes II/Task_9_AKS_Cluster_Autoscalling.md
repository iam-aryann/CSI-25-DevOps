## Task 9: Configure Autoscaling in Your AKS Cluster (Horizontal Scaling)

**Objective**:  
Set up a Horizontal Pod Autoscaler (HPA) in an Azure Kubernetes Service (AKS) cluster to automatically scale the number of pods in a deployment based on CPU utilization or other metrics.

---

## Prerequisites
- An AKS cluster deployed (e.g., from Week 6, Task 4 or Week 5, Task 3).
- `kubectl` configured with cluster credentials:
  ```bash
  az aks get-credentials --resource-group <your-resource-group> --name <aks-cluster-name>
  ```
- Azure CLI installed (verify with `az --version`).
- Metrics Server installed in the cluster (required for HPA).

---

## What is Horizontal Pod Autoscaler (HPA)?
The HPA automatically scales the number of pod replicas in a deployment, replication controller, or stateful set based on observed CPU utilization or custom metrics (if configured). It adjusts replicas within defined minimum and maximum bounds to handle load changes efficiently.

---

## Steps to Complete the Task

### Step 1: Install the Metrics Server (If Not Already Installed)
1. Deploy the Metrics Server to provide resource usage data:
   ```bash
   kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
   ```
2. Verify the Metrics Server is running:
   ```bash
   kubectl get deployment metrics-server -n kube-system
   ```
   - Ensure the deployment is in the `Running` state.

---

### Step 2: Deploy a Sample Application
1. Create a file named `nginx-deployment.yaml`:
   ```yaml
   apiVersion: apps/v1
   kind: Deployment
   metadata:
     name: nginx-app
   spec:
     replicas: 1
     selector:
       matchLabels:
         app: nginx
     template:
       metadata:
         labels:
           app: nginx
       spec:
         containers:
         - name: nginx
           image: nginx
           ports:
           - containerPort: 80
           resources:
             requests:
               cpu: 100m
             limits:
               cpu: 200m
   ```
   - `resources`: Specifies CPU requests (100m = 0.1 CPU) and limits (200m = 0.2 CPU) to enable HPA based on CPU utilization.
2. Apply the deployment:
   ```bash
   kubectl apply -f nginx-deployment.yaml
   ```

---

### Step 3: Expose the Deployment (Optional)
1. Expose the deployment as a service to allow load testing:
   ```bash
   kubectl expose deployment nginx-app --port=80 --type=LoadBalancer
   ```
2. Verify the service:
   ```bash
   kubectl get svc nginx-app
   ```
   - Note the `EXTERNAL-IP` for load testing (if using AKS). For Minikube, use `minikube service nginx-app --url`.

---

### Step 4: Create Horizontal Pod Autoscaler
1. Create an HPA to scale the `nginx-app` deployment based on 50% CPU utilization:
   ```bash
   kubectl autoscale deployment nginx-app --cpu-percent=50 --min=1 --max=5
   ```
   - This scales the deployment between 1 and 5 replicas when CPU usage exceeds 50%.
2. Verify the HPA:
   ```bash
   kubectl get hpa
   ```

---

### Step 5: Generate Load to Trigger Scaling
1. Open a new terminal and create a load generator pod:
   ```bash
   kubectl run -i --tty load-generator --image=busybox -- sh
   ```
2. Inside the `load-generator` pod, run a loop to generate HTTP requests:
   ```sh
   while true; do wget -q -O- http://nginx-app; done
   ```
3. Monitor the HPA in another terminal:
   ```bash
   kubectl get hpa -w
   ```
   - Observe the `REPLICAS` column increasing as CPU usage exceeds 50%.

---

### Step 6: Clean Up
1. Delete the resources:
   ```bash
   kubectl delete deployment nginx-app
   kubectl delete service nginx-app
   kubectl delete hpa nginx-app
   ```

---

## Outcome
- Installed the Metrics Server to enable resource monitoring.
- Deployed an NGINX application with defined CPU resources.
- Configured an HPA to scale the deployment based on CPU utilization.
- Tested autoscaling by generating load and observing replica changes.
- Cleaned up resources to avoid unnecessary costs.

---

## Resources
- [YouTube: AKS Autoscaling](https://www.youtube.com/results?search_query=aks+autoscaling)
- [YouTube: Azure Kubernetes Service (AKS) Networking Deep Dive
](https://www.youtube.com/watch?v=6TZsd4toIbg)
- [Azure Docs: AKS Horizontal Pod Autoscaler](https://learn.microsoft.com/azure/aks/horizontal-pod-autoscaler)
- [Kubernetes HPA Documentation](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/)
