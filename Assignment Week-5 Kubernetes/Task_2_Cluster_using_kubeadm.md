# Week 5: Kubernetes
## Task 2: Create a Kubernetes Cluster Using Kubeadm

**Objective**:  
Set up a multi-node Kubernetes cluster manually using `kubeadm` to understand the Kubernetes control plane, worker nodes, and networking.

---

## Prerequisites
- Minimum 2 Linux VMs (e.g., on VirtualBox, VMware, or a cloud provider like Azure):
  - 1 Master Node
  - 1 Worker Node
- **OS**: Ubuntu 20.04 or higher (recommended)
- **System Requirements (per node)**:
  - 2 vCPUs
  - 2GB RAM (minimum)
  - Internet access
  - `sudo` privileges
- Docker installed (for container runtime)
- Swap disabled on all nodes:
  ```bash
  sudo swapoff -a
  ```
  - To disable swap permanently, edit `/etc/fstab` and comment out the swap entry.

---

## Steps to Complete the Task

### Step 1: Install Docker on All Nodes
1. Install Docker on each node (master and worker):
   ```bash
   sudo apt update
   sudo apt install -y docker.io
   sudo systemctl enable docker
   sudo systemctl start docker
   ```
2. Verify Docker is running:
   ```bash
   docker --version
   ```

---

### Step 2: Install kubeadm, kubelet, and kubectl on All Nodes
1. Set up the Kubernetes repository:
   ```bash
   sudo apt update && sudo apt install -y apt-transport-https curl
   curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
   echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
   ```
2. Install `kubeadm`, `kubelet`, and `kubectl`:
   ```bash
   sudo apt update
   sudo apt install -y kubelet kubeadm kubectl
   sudo apt-mark hold kubelet kubeadm kubectl
   ```
   - The `apt-mark hold` command prevents these packages from being upgraded automatically.

---

### Step 3: Initialize Kubernetes Cluster on Master Node
1. On the **master node**, initialize the cluster:
   ```bash
   sudo kubeadm init --pod-network-cidr=192.168.0.0/16
   ```
   - The `--pod-network-cidr` specifies the IP range for the pod network (required for Calico).
2. Save the `kubeadm join` command output at the end of initialization (e.g., `kubeadm join <master-ip>:<port> --token <token> --discovery-token-ca-cert-hash <hash>`). You will need this to join worker nodes.

---

### Step 4: Set Up kubeconfig for kubectl on Master
1. Configure `kubectl` to interact with the cluster:
   ```bash
   mkdir -p $HOME/.kube
   sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
   sudo chown $(id -u):$(id -g) $HOME/.kube/config
   ```

---

### Step 5: Install Pod Network Add-on (e.g., Calico)
1. Install the Calico network add-on:
   ```bash
   kubectl apply -f https://raw.githubusercontent.com/projectcalico/calico/v3.26.1/manifests/calico.yaml
   ```
   - Alternatively, you can use Flannel or another CNI plugin:
     ```bash
     kubectl apply -f https://raw.githubusercontent.com/flannel-io/flannel/master/Documentation/kube-flannel.yml
     ```

---

### Step 6: Join Worker Nodes
1. On each **worker node**, run the `kubeadm join` command provided in Step 3. For example:
   ```bash
   sudo kubeadm join <master-ip>:<port> --token <token> --discovery-token-ca-cert-hash <hash>
   ```

---

### Step 7: Verify the Cluster
1. On the **master node**, check the status of all nodes:
   ```bash
   kubectl get nodes
   ```
2. You should see the master and worker nodes in the `Ready` state.

---

## Outcome
- A functional multi-node Kubernetes cluster is set up using `kubeadm`.
- The cluster includes a master node, at least one worker node, and a pod network (e.g., Calico).
- You have full control over the cluster's installation and configuration.

---

## Resources
- [Video Guide: Kubeadm Tutorial](https://www.youtube.com/results?search_query=kubeadm+tutorial)
- [Understanding Affinity in Kubernetes: Improve Pod Scheduling and High Availability | AKS tutorials
](https://www.youtube.com/watch?v=gyjFNkk3QxY)
- [Kubeadm Official Docs](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/)
- [Calico Documentation](https://docs.tigera.io/calico/latest/about/)
- [Flannel Documentation](https://github.com/flannel-io/flannel)
