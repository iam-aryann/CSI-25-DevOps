# Task 6: Create an Internal and External Load Balancer

## Part A: External Load Balancer (Public-facing)

#### 1. Create Virtual Network & Subnet
1. Go to [Azure Portal](https://portal.azure.com) → Search for **Virtual Networks** → Click **Create**.
2. Configure:
   - **VNet name**: `LB-VNet`
   - **Subnet name**: `LB-Subnet`
   - **Address range**: `10.0.0.0/24`
3. Click **Review + Create** → **Create**.

#### 2. Create Two Virtual Machines
1. Go to **Virtual Machines** → Click **Create** → Select **Azure virtual machine**.
2. Create two identical VMs (`vm1`, `vm2`) with:
   - **Resource Group**: Same as `LB-VNet`
   - **Region**: Same as VNet (e.g., East US)
   - **Image**: Ubuntu or Windows (your preference)
   - **Networking**: Select `LB-VNet` and `LB-Subnet`
3. Ensure both VMs are in the same availability set or proximity placement group.
4. Complete other settings (e.g., size, authentication) → Click **Review + Create** → **Create**.

#### 3. Install Web Server on Each VM
1. SSH into `vm1`:
   ```bash
   sudo apt update && sudo apt install nginx -y
   echo "Welcome from VM1" | sudo tee /var/www/html/index.html
   ```
2. SSH into `vm2`:
   ```bash
   sudo apt update && sudo apt install nginx -y
   echo "Welcome from VM2" | sudo tee /var/www/html/index.html
   ```
3. Verify web server is running on each VM:
   ```bash
   curl localhost
   ```

#### 4. Create a Public Load Balancer
1. Go to **Load Balancers** → Click **Create**.
2. Configure:
   - **Name**: `Public-LB`
   - **Type**: Public
   - **SKU**: Standard
   - **Frontend IP configuration**: Create a new Public IP (e.g., `Public-IP-LB`)
   - **Backend Pool**: Add `vm1` and `vm2` to the same pool (ensure they are in the same region and availability set or proximity placement group)
   - **Health Probe**: HTTP on port `80`
   - **Load Balancing Rule**:
     - **Name**: `HTTPRule`
     - **Frontend Port**: `80`
     - **Backend Port**: `80`
     - **Backend Pool**: Select created backend pool
     - **Health Probe**: Select created probe
3. Click **Review + Create** → **Create**.

#### 5. Test Load Balancer
1. Get the public IP of the Load Balancer from the **Public-LB** overview page.
2. Access the public IP in a browser:
   ```
   http://<public-ip>
   ```
3. Refresh multiple times; you should see alternating messages: "Welcome from VM1" and "Welcome from VM2".

---

## Part B: Internal Load Balancer (Private-facing)

#### 1. Create New VMs in a New Backend Pool
1. Use the existing VNet (`LB-VNet`) and subnet (`LB-Subnet`).
2. Create two new VMs (`vm3`, `vm4`):
   - **Resource Group**: Same as `LB-VNet`
   - **Region**: Same as VNet (e.g., East US)
   - **Image**: Linux or Windows (your preference)
   - **Networking**: Select `LB-VNet` and `LB-Subnet`
3. Install web server on each VM:
   - SSH into `vm3`:
     ```bash
     sudo apt update && sudo apt install nginx -y
     echo "Internal LB VM3" | sudo tee /var/www/html/index.html
     ```
   - SSH into `vm4`:
     ```bash
     sudo apt update && sudo apt install nginx -y
     echo "Internal LB VM4" | sudo tee /var/www/html/index.html
     ```

#### 2. Create Internal Load Balancer
1. Go to **Load Balancers** → Click **Create**.
2. Configure:
   - **Name**: `Internal-LB`
   - **Type**: Internal
   - **Virtual Network**: `LB-VNet`
   - **Subnet**: `LB-Subnet`
   - **Private IP address**: Assign one (e.g., `10.0.0.10`) or use dynamic
   - **Backend Pool**: Add `vm3` and `vm4`
   - **Health Probe**: HTTP on port `80`
   - **Load Balancing Rule**:
     - **Frontend Port**: `80`
     - **Backend Port**: `80`
     - **Backend Pool**: Select created backend pool
     - **Health Probe**: Select created probe
3. Click **Review + Create** → **Create**.

#### 3. Test Internal Load Balancer
1. SSH into one of the external VMs (`vm1` or `vm2`).
2. From inside the network, test the Internal Load Balancer:
   ```bash
   curl http://<internal-lb-private-ip>
   ```
3. You should see responses alternating between "Internal LB VM3" and "Internal LB VM4" in a round-robin manner.

---

## 🧩 Resources
- [Azure Load Balancer Documentation](https://docs.microsoft.com/azure/load-balancer/)
- [Azure Load Balancer Tutorial
](https://www.youtube.com/watch?v=T7XU6Lz8lJw&pp=ygUbYXp1cmUgbG9hZCBiYWxhbmNlciBzZXJ2aWNl)
- [Tutorial: Create a Public Load Balancer](https://docs.microsoft.com/azure/load-balancer/quickstart-load-balancer-standard-public-portal)
- [Tutorial: Create an Internal Load Balancer](https://docs.microsoft.com/azure/load-balancer/tutorial-load-balancer-standard-internal-portal)  
