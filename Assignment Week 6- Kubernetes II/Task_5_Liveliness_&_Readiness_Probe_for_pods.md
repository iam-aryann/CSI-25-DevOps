## Task 5: Configure Liveness and Readiness Probes for Pods in AKS Cluster

**Objective**:  
Understand and implement liveness and readiness probes in an Azure Kubernetes Service (AKS) cluster to monitor pod health and availability.

---

## Prerequisites
- An AKS cluster deployed (e.g., from Week 6, Task 4 or Week 5, Task 3).
- `kubectl` configured with cluster credentials:
  ```bash
  az aks get-credentials --resource-group <your-resource-group> --name <aks-cluster-name>
  ```
- Basic familiarity with Kubernetes YAML manifests.

---

## What Are Probes?
- **Liveness Probe**: Determines if a container is running. If the probe fails, Kubernetes restarts the container.
- **Readiness Probe**: Determines if a container is ready to handle requests. If the probe fails, the pod is removed from service endpoints, preventing traffic from reaching it.

---

## Steps to Complete the Task

### Step 1: Create a YAML File for Deployment with Probes
1. Create a file named `nginx-probes.yaml`:
   ```yaml
   apiVersion: v1
   kind: Pod
   metadata:
     name: nginx-pod
     labels:
       app: nginx
   spec:
     containers:
     - name: nginx
       image: nginx
       ports:
       - containerPort: 80
       livenessProbe:
         httpGet:
           path: /
           port: 80
         initialDelaySeconds: 5
         periodSeconds: 10
       readinessProbe:
         httpGet:
           path: /
           port: 80
         initialDelaySeconds: 5
         periodSeconds: 10
   ```
   - **Liveness Probe**: Checks the root path (`/`) on port 80 every 10 seconds, starting after a 5-second delay.
   - **Readiness Probe**: Ensures the container is ready to receive traffic by checking the same path and port.

---

### Step 2: Apply the Deployment
1. Apply the pod configuration to the AKS cluster:
   ```bash
   kubectl apply -f nginx-probes.yaml
   ```

---

### Step 3: Check Pod and Probe Status
1. Verify the pod is running:
   ```bash
   kubectl get pods
   ```
2. Check the probe statuses:
   ```bash
   kubectl describe pod nginx-pod
   ```
   - Look for the `Liveness` and `Readiness` sections in the output to confirm the probes are configured and functioning.

---

### Step 4: Simulate Failures (Optional)
1. To test the liveness probe, modify `nginx-probes.yaml` to use an invalid path for the liveness probe:
   ```yaml
   livenessProbe:
     httpGet:
       path: /invalid
       port: 80
     initialDelaySeconds: 5
     periodSeconds: 10
   ```
2. Re-apply the updated configuration:
   ```bash
   kubectl apply -f nginx-probes.yaml
   ```
3. Observe the pod status:
   ```bash
   kubectl get pods
   ```
   - Kubernetes will restart the pod repeatedly due to the failing liveness probe (since `/invalid` does not exist).

---

### Step 5: Clean Up
1. Delete the pod:
   ```bash
   kubectl delete pod nginx-pod
   ```

---

## Why Probes Are Important
- **Liveness Probes**: Detect and recover from deadlocks or frozen containers by restarting them.
- **Readiness Probes**: Ensure only healthy pods receive traffic, improving application reliability.

---

## Outcome
- Configured liveness and readiness probes for an NGINX pod in an AKS cluster.
- Verified probe functionality using `kubectl describe`.
- Optionally simulated a liveness probe failure to observe Kubernetes restarting the pod.
- Understood the importance of probes for maintaining application health and availability.

---

## Resources
- [YouTube: Probes in Kubernetes](https://www.youtube.com/results?search_query=kubernetes+probes)
- [YouTube: How Autoscaling Works In Kubernetes (And Beyond)? Kubernetes Tutorial
](https://www.youtube.com/watch?v=BUAFNfdarBQ)
- [AKS Probes Documentation](https://learn.microsoft.com/azure/aks/)
- [Kubernetes Probes Documentation](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/)
