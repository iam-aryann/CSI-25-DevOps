## Task 5: Expose Services in the Cluster with NodePort, ClusterIP, and LoadBalancer

**Objective**:  
Learn to expose applications in a Kubernetes cluster using three service types:  
- **ClusterIP**: For internal cluster access only.  
- **NodePort**: For access via any cluster node’s IP and an exposed port.  
- **LoadBalancer**: For public internet access through a cloud provider’s load balancer.

---

## Prerequisites
- A running Kubernetes cluster (e.g., Minikube, AKS, or kubeadm cluster from previous tasks).  
- `kubectl` configured to interact with the cluster (e.g., `az aks get-credentials` for AKS or `minikube start` for Minikube).  
- For `LoadBalancer`, a cloud-based Kubernetes cluster (e.g., AKS) is required, as Minikube may not provision a public load balancer without additional configuration.  

---

## Steps to Complete the Task

### Step 1: Deploy a Sample App
1. Create a file named `nginx-deployment.yaml` to deploy an NGINX application:
   ```yaml
   apiVersion: apps/v1
   kind: Deployment
   metadata:
     name: nginx-deployment
   spec:
     replicas: 2
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
   ```
2. Deploy the application:
   ```bash
   kubectl apply -f nginx-deployment.yaml
   ```

---

### Step 2: Expose with ClusterIP (Default)
1. Create a `ClusterIP` service to expose the NGINX deployment internally:
   ```bash
   kubectl expose deployment nginx-deployment --name=nginx-clusterip --port=80 --target-port=80 --type=ClusterIP
   ```
2. Verify the service:
   ```bash
   kubectl get svc nginx-clusterip
   ```
   - The `ClusterIP` service is only accessible within the cluster.  
   - To test, you can create a temporary pod (e.g., `busybox`) and use `curl`:
     ```bash
     kubectl run -i --tty --rm test-pod --image=busybox -- sh
     wget -qO- http://nginx-clusterip
     ```

---

### Step 3: Expose with NodePort
1. Create a `NodePort` service to expose the NGINX deployment:
   ```bash
   kubectl expose deployment nginx-deployment --name=nginx-nodeport --port=80 --target-port=80 --type=NodePort
   ```
2. Check the service details to find the assigned `NodePort` (e.g., 30080):
   ```bash
   kubectl get svc nginx-nodeport
   ```
3. Get the external IP of a node in the cluster:
   ```bash
   kubectl get nodes -o wide
   ```
   - If using Minikube, get the Minikube IP:
     ```bash
     minikube ip
     ```
4. Access the application at:
   ```
   http://<Node-External-IP>:<NodePort>
   ```
   - Example: `http://192.168.49.2:30080` (for Minikube) or use the node’s external IP for AKS.

---

### Step 4: Expose with LoadBalancer
1. Create a `LoadBalancer` service to expose the NGINX deployment publicly (works best on cloud providers like AKS):
   ```bash
   kubectl expose deployment nginx-deployment --name=nginx-lb --port=80 --target-port=80 --type=LoadBalancer
   ```
2. Check the public IP assigned to the `LoadBalancer`:
   ```bash
   kubectl get svc nginx-lb
   ```
   - Wait 1–2 minutes for the `EXTERNAL-IP` to appear (e.g., `20.123.456.789`).  
   - If using Minikube, you may need to run `minikube tunnel` in a separate terminal to simulate a `LoadBalancer` and assign an external IP.
3. Access the application at:
   ```
   http://<EXTERNAL-IP>
   ```
   - You should see the NGINX welcome page.

---

### Step 5: Clean Up (Optional)
1. Remove the services and deployment:
   ```bash
   kubectl delete svc nginx-clusterip nginx-nodeport nginx-lb
   kubectl delete deployment nginx-deployment
   ```

---

## Conclusion
- Created a Kubernetes deployment (`nginx-deployment`) with 2 replicas.  
- Exposed the application using:  
  - `ClusterIP`: For internal cluster access.  
  - `NodePort`: For access via a node’s IP and port.  
  - `LoadBalancer`: For public internet access via a cloud provider’s load balancer.  
- Understood the scope and use cases for each service type.

---

## Resources
- [YouTube: Configure Application Access in AKS](https://www.youtube.com/results?search_query=configure+application+access+in+aks)
- [Application Deployment on AKS | Azure Kubernetes Service
](https://www.youtube.com/watch?v=uCh3iym4HZ8)
- [Kubernetes Services Documentation](https://kubernetes.io/docs/concepts/services-networking/service/)
- [AKS Documentation](https://learn.microsoft.com/azure/aks/)
