## Task 8: Configure Health Probes for Pods in AKS

**Objective**:  
Implement and configure liveness and readiness probes for pods in Azure Kubernetes Service (AKS) to ensure high availability, proper scaling, and self-healing of applications.

---

## Prerequisites
- An AKS cluster deployed (e.g., from Week 6, Task 4 or Week 5, Task 3).
- `kubectl` configured with cluster credentials:
  ```bash
  az aks get-credentials --resource-group <your-resource-group> --name <aks-cluster-name>
  ```
- Basic familiarity with Kubernetes YAML manifests.

---

## What Are Health Probes?
- **Liveness Probe**: Checks if a container is running. If the probe fails, Kubernetes restarts the container to recover it.
- **Readiness Probe**: Checks if a container is ready to serve traffic. If the probe fails, the pod is temporarily removed from service endpoints until it recovers.

---

## Steps to Complete the Task

### Step 1: Create a Pod with Liveness and Readiness Probes
1. Create a file named `pod-health-check.yaml`:
   ```yaml
   apiVersion: v1
   kind: Pod
   metadata:
     name: health-probe-app
   spec:
     containers:
     - name: health-container
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
         periodSeconds: 5
   ```
   - **Liveness Probe**: Checks the root path (`/`) on port 80 every 10 seconds, starting after a 5-second delay.
   - **Readiness Probe**: Checks the same path every 5 seconds to ensure the pod is ready to receive traffic.

2. Apply the configuration:
   ```bash
   kubectl apply -f pod-health-check.yaml
   ```

---

### Step 2: Verify Probes
1. Check the pod status:
   ```bash
   kubectl get pods
   ```
   - Ensure the `health-probe-app` pod is in the `Running` state.
2. Inspect probe details and status:
   ```bash
   kubectl describe pod health-probe-app
   ```
   - Look for the `Liveness` and `Readiness` sections in the output to confirm the probes are active and succeeding.

---

### Step 3: Alternative Probes (Optional)
You can use different probe types based on your application needs.

#### TCP Liveness Probe Example
Modify the `livenessProbe` section in `pod-health-check.yaml`:
```yaml
livenessProbe:
  tcpSocket:
    port: 80
  initialDelaySeconds: 15
  periodSeconds: 20
```
- This checks if port 80 is open, indicating the container is alive.

#### Exec Probe Example
Modify the `readinessProbe` section in `pod-health-check.yaml`:
```yaml
readinessProbe:
  exec:
    command:
    - cat
    - /tmp/healthy
  initialDelaySeconds: 5
  periodSeconds: 5
```
- This checks for the existence of a `/tmp/healthy` file to determine readiness.

Re-apply the updated YAML:
```bash
kubectl apply -f pod-health-check.yaml
```

---

### Step 4: Clean Up
1. Delete the pod:
   ```bash
   kubectl delete pod health-probe-app
   ```

---

## Best Practices
- **Readiness Probes**: Use for applications with long startup times (e.g., APIs, databases) to prevent traffic until ready.
- **Liveness Probes**: Use to detect and recover from deadlocks or crashes by restarting containers.
- **Customization**: Adjust `initialDelaySeconds`, `periodSeconds`, and `failureThreshold` to match your application’s behavior.
- **Probe Types**: Choose `httpGet` for web servers, `tcpSocket` for non-HTTP services, or `exec` for custom checks.

---

## Outcome
- Configured liveness and readiness probes for an NGINX pod in an AKS cluster.
- Verified probe functionality using `kubectl describe`.
- Explored alternative probe types (TCP and Exec).

---

## Resources
- [YouTube: Kubernetes Health Probes](https://www.youtube.com/results?search_query=kubernetes+health+probes)
- [Azure Storage Options with Azure Kubernetes Services
](https://www.youtube.com/watch?v=XJB1RO32HVo&t=2978s)
- [Azure AKS Probes Documentation](https://learn.microsoft.com/azure/aks/)
- [Kubernetes Probes Documentation](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/)
