## Task 2: Kubernetes Service Types (ClusterIP, NodePort, LoadBalancer)

**Objective**:  
Understand and deploy the three primary Kubernetes Service types—`ClusterIP`, `NodePort`, and `LoadBalancer`—to expose applications and learn their use cases.

---

## Prerequisites
- A running Kubernetes cluster (e.g., Minikube, AKS, or kubeadm from previous tasks).
- `kubectl` configured to interact with the cluster (e.g., `kubectl cluster-info`).
- A deployed application with a label selector (e.g., `app: myapp`). For this task, we assume a deployment exists with the label `app: myapp` (e.g., NGINX from Task 1).

---

## Steps to Complete the Task

### 1. ClusterIP (Default Service Type)
- **Scope**: Internal access within the cluster only.
- **Use Case**: Communication between microservices inside the cluster.
- **YAML Example** (`clusterip.yaml`):
  ```yaml
  apiVersion: v1
  kind: Service
  metadata:
    name: clusterip-service
  spec:
    selector:
      app: myapp
    ports:
      - protocol: TCP
        port: 80
        targetPort: 80
    type: ClusterIP
  ```
- **Commands**:
  ```bash
  kubectl apply -f clusterip.yaml
  kubectl get svc
  ```
- **Verification**: The service is only accessible within the cluster. To test, create a temporary pod:
  ```bash
  kubectl run -i --tty --rm test-pod --image=busybox -- sh
  wget -qO- http://clusterip-service
  ```

---

### 2. NodePort
- **Scope**: External access using `<NodeIP>:<NodePort>`.
- **Port Range**: 30000–32767 by default.
- **Use Case**: Quick external access for development or testing environments.
- **YAML Example** (`nodeport.yaml`):
  ```yaml
  apiVersion: v1
  kind: Service
  metadata:
    name: nodeport-service
  spec:
    selector:
      app: myapp
    ports:
      - protocol: TCP
        port: 80
        targetPort: 80
        nodePort: 30080
    type: NodePort
  ```
- **Commands**:
  ```bash
  kubectl apply -f nodeport.yaml
  kubectl get svc
  ```
- **Access**: 
  - Get the node’s external IP:
    ```bash
    kubectl get nodes -o wide
    ```
    - For Minikube, use:
      ```bash
      minikube ip
      ```
  - Access the application at `http://<NodeIP>:30080`.

---

### 3. LoadBalancer
- **Scope**: External access via a cloud provider’s load balancer (e.g., Azure, AWS, GCP).
- **Use Case**: Public-facing production applications.
- **YAML Example** (`loadbalancer.yaml`):
  ```yaml
  apiVersion: v1
  kind: Service
  metadata:
    name: loadbalancer-service
  spec:
    selector:
      app: myapp
    ports:
      - protocol: TCP
        port: 80
        targetPort: 80
    type: LoadBalancer
  ```
- **Commands**:
  ```bash
  kubectl apply -f loadbalancer.yaml
  kubectl get svc
  ```
- **Access**: 
  - Wait 1–2 minutes for the `EXTERNAL-IP` to be provisioned by the cloud provider.
  - Access the application at `http://<EXTERNAL-IP>`.
  - For Minikube, simulate a `LoadBalancer` by running:
    ```bash
    minikube tunnel
    ```

---

## Comparison Table

| **Service Type** | **Accessible From**         | **Use Case**                     | **Default** |
|------------------|-----------------------------|----------------------------------|-------------|
| **ClusterIP**    | Inside cluster only         | Internal service communication   | ✅          |
| **NodePort**     | External (IP:Port)          | Quick external access            | ❌          |
| **LoadBalancer** | Public IP via cloud provider | Production-level public access   | ❌          |

---

## Outcome
- Deployed `ClusterIP`, `NodePort`, and `LoadBalancer` services to expose an application in a Kubernetes cluster.
- Verified access for each service type:
  - `ClusterIP`: Internal access within the cluster.
  - `NodePort`: External access via node IP and port.
  - `LoadBalancer`: Public access via a cloud provider’s load balancer.
- Understood the use cases and scope of each service type.

---

## Resources
- [YouTube: Kubernetes Services explained | ClusterIP vs NodePort vs LoadBalancer vs Headless Service
](https://www.youtube.com/watch?v=T4Z7visMM4E)
- [YouTube: Kubernetes Service Types](https://www.youtube.com/results?search_query=kubernetes+service+types)
- [Kubernetes Services Documentation](https://kubernetes.io/docs/concepts/services-networking/service/)
- [AKS Networking Documentation](https://learn.microsoft.com/azure/aks/concepts-network)
