# Week 5: Kubernetes
## Task 1: Create a Kubernetes Cluster using Minikube

**Objective**:  
Set up a local Kubernetes cluster using Minikube to understand Kubernetes architecture and prepare for container orchestration practices.

---

## Prerequisites
- A system with sufficient resources (e.g., 2 CPUs, 2GB RAM, 20GB disk space)
- Internet access for downloading tools and images

---

## Steps to Complete the Task

### Step 1: Install Prerequisites

1. **Install Docker** (required for container runtime):
   - Download and install Docker Desktop from [https://www.docker.com/products/docker-desktop](https://www.docker.com/products/docker-desktop).
   - Verify installation:
     ```bash
     docker --version
     ```

2. **Install Minikube**:
   - Follow the installation instructions for your operating system from the [Minikube Installation Docs](https://minikube.sigs.k8s.io/docs/start/).
   - For example, on macOS/Linux:
     ```bash
     curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-<os> && \
     sudo install minikube-<os> /usr/local/bin/minikube
     ```
     Replace `<os>` with `darwin-amd64` (macOS), `linux-amd64` (Linux), or `windows-amd64` (Windows).
   - Verify installation:
     ```bash
     minikube version
     ```

3. **Install kubectl** (Kubernetes CLI):
   - Follow instructions from [Kubernetes Install kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/).
   - For example, on macOS/Linux:
     ```bash
     curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/<os>/amd64/kubectl" && \
     chmod +x kubectl && \
     sudo mv kubectl /usr/local/bin/
     ```
     Replace `<os>` with `darwin` (macOS) or `linux` (Linux).
   - For Windows, download the `kubectl.exe` binary and add it to your PATH.
   - Verify installation:
     ```bash
     kubectl version --client
     ```

---

### Step 2: Start Minikube
1. Launch a single-node Kubernetes cluster:
   ```bash
   minikube start
   ```
   - This command sets up a local Kubernetes cluster using Docker as the container runtime.
   - If you encounter issues, ensure Docker is running and you have sufficient resources.

---

### Step 3: Verify the Cluster
1. Check the status of the Minikube cluster:
   ```bash
   minikube status
   ```
   - Expected output: Cluster running with `host`, `kubelet`, and `apiserver` in `Running` state.

2. View cluster information:
   ```bash
   kubectl cluster-info
   ```
   - Displays the Kubernetes control plane and DNS endpoints.

3. Check the nodes:
   ```bash
   kubectl get nodes
   ```
   - You should see a single node (e.g., `minikube`) in the `Ready` state.

---

### Step 4: Access Minikube Dashboard (Optional but Recommended)
1. Open the Minikube dashboard to visually inspect the cluster:
   ```bash
   minikube dashboard
   ```
   - This opens a web browser with the Kubernetes dashboard, showing cluster resources like Pods, Services, and Deployments.

---

## Outcome
- A fully functioning single-node Kubernetes cluster is running locally via Minikube.
- The cluster is ready for testing Kubernetes resources such as Pods, Services, and Deployments.
- The Minikube dashboard provides a visual interface for cluster management.

---

## Resources
- [Video Guide: Minikube Tutorial](https://www.youtube.com/results?search_query=minikube+tutorial)
- [Kubernetes Official Docs](https://kubernetes.io/docs/)
- [Minikube Documentation](https://minikube.sigs.k8s.io/docs/)
