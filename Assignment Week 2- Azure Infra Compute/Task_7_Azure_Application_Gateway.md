# Task 7: Create and Test Azure Application Gateway

## What is Azure Application Gateway?
Azure Application Gateway is a Layer 7 load balancer that provides:
- URL path-based or host header-based traffic routing
- SSL termination
- Web Application Firewall (WAF) capabilities
- Advanced routing for HTTP/HTTPS (Application layer), unlike a regular Load Balancer

---

## Step 1: Create a Virtual Network and Subnet
1. Go to [Azure Portal](https://portal.azure.com) → Search for **Virtual Networks** → Click **Create**.
2. Configure:
   - **Name**: `AGW-VNet`
   - **Address space**: `10.0.0.0/16`
   - **Subnet 1** (for backend VMs):
     - **Name**: `backend-subnet`
     - **Address range**: `10.0.1.0/24`
   - **Subnet 2** (dedicated for Application Gateway, required):
     - **Name**: `appgw-subnet`
     - **Address range**: `10.0.2.0/24`
3. Click **Review + Create** → **Create**.

**Note**: Azure requires a dedicated subnet for the Application Gateway.

---

## Step 2: Create Two Virtual Machines
1. Go to **Virtual Machines** → Click **Create** → Select **Azure virtual machine**.
2. Create two VMs (`vm1` and `vm2`) with:
   - **Resource Group**: Same as `AGW-VNet`
   - **VNet**: `AGW-VNet`
   - **Subnet**: `backend-subnet`
   - **Image**: Ubuntu (or your preferred OS)
3. Install a web server on each VM:
   - SSH into `vm1`:
     ```bash
     sudo apt update && sudo apt install nginx -y
     echo "Welcome to VM1" | sudo tee /var/www/html/index.html
     ```
   - SSH into `vm2`:
     ```bash
     sudo apt update && sudo apt install nginx -y
     echo "Welcome to VM2" | sudo tee /var/www/html/index.html
     ```
4. Ensure the **Network Security Group (NSG)** for both VMs allows inbound **HTTP (port 80)** traffic.

---

## Step 3: Create Application Gateway
1. Go to **Application Gateways** → Click **Create**.
2. Configure:
   - **Basics**:
     - **Name**: `myAppGateway`
     - **Tier**: Standard V2 (or WAF V2 if needed)
     - **VNet**: `AGW-VNet`
     - **Subnet**: `appgw-subnet`
   - **Frontend IP**:
     - **Type**: Public
     - Create a new public IP (e.g., `AppGWPublicIP`)
   - **Backend Pool**:
     - Add both VMs (`vm1`, `vm2`) by their private IP addresses
   - **Health Probe**:
     - **Protocol**: HTTP
     - **Port**: 80
     - **Path**: `/`
   - **HTTP Settings**:
     - **Name**: `httpSetting`
     - **Backend port**: 80
     - **Enable Cookie-based affinity**: No
   - **Listener**:
     - **Protocol**: HTTP
     - **Port**: 80
   - **Routing Rule**:
     - Create a basic routing rule
     - Link the listener, backend pool, and HTTP settings
3. Click **Review + Create** → **Create**.

---

## Step 4: Test the Application Gateway
1. Get the public IP of the Application Gateway from the **myAppGateway** overview page.
2. Open the public IP in a browser:
   ```
   http://<app-gateway-public-ip>
   ```
3. Refresh the page multiple times. You should see alternating responses: "Welcome to VM1" and "Welcome to VM2" (indicating load balancing is working).

---

## Resources
- [Microsoft Azure Private Link Deep Dive
](https://www.youtube.com/watch?v=57ZwdztCx2w)
- [Azure Application Gateway Documentation](https://docs.microsoft.com/azure/application-gateway/)
- [Tutorial: Create an Application Gateway](https://docs.microsoft.com/azure/application-gateway/quick-create-portal)
