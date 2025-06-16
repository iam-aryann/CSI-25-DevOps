# Task 5: VNet, Subnets & Hub-Spoke Architecture

## A. Create a VNet with 2 Subnets
**Objective**: Create a Virtual Network (VNet) with two subnets:  
- **Subnet-1**: Host a Linux VM and a Windows VM  
- **Subnet-2**: Host an Azure SQL Database  

### Steps via Azure Portal

#### 1. Create a Virtual Network (VNet)
1. Go to [Azure Portal](https://portal.azure.com) → Search for **Virtual Networks** → Click **Create**.
2. Configure the VNet:
   - **Resource Group**: Use an existing one or create new
   - **Name**: e.g., `Main-VNet`
   - **Region**: e.g., East US
3. Under **IP Addresses**, configure:
   - **Address space**: `10.0.0.0/16`
   - Add **Subnet-1**: Name = `Subnet-1`, Range = `10.0.1.0/24`
   - Add **Subnet-2**: Name = `Subnet-2`, Range = `10.0.2.0/24`
4. Leave other settings as default → Click **Review + Create** → **Create**.

#### 2. Deploy VMs in Subnet-1
**Linux VM**:
1. Go to **Virtual Machines** → Click **Create**.
2. Configure:
   - **Resource Group**: Same as `Main-VNet`
   - **Region**: East US
   - **Image**: Choose Ubuntu or preferred Linux image
   - **Networking**: Select `Main-VNet` → Subnet = `Subnet-1`
3. Complete other settings (e.g., size, authentication) → Click **Review + Create** → **Create**.

**Windows VM**:
1. Repeat the same steps as above, but choose a **Windows Server** image.
2. Ensure **Networking** is set to `Main-VNet` and `Subnet-1`.

#### 3. Deploy Azure SQL in Subnet-2
1. Search for **SQL Database** → Click **Create**.
2. Configure:
   - **Resource Group**: Same as `Main-VNet`
   - **Region**: East US
   - **Networking**: Select `Main-VNet` → Subnet = `Subnet-2`
3. Complete other settings (e.g., server name, authentication) → Click **Review + Create** → **Create**.

---

## B. Create 4 VNets and Configure Hub-Spoke Architecture
**Objective**: Create a hub-and-spoke network topology with one hub VNet and three spoke VNets, deploy VMs, and configure VNet peering for connectivity.

### VNet Setup
Create the following VNets in the same region (e.g., East US):
- **Management-VNet (Hub)**: Address space = `10.1.0.0/16`
- **Production-VNet (Spoke)**: Address space = `10.2.0.0/16`
- **Testing-VNet (Spoke)**: Address space = `10.3.0.0/16`
- **Development-VNet (Spoke)**: Address space = `10.4.0.0/16`

For each VNet:
1. Add one subnet (e.g., `Subnet-A`) with range `/24` (e.g., `10.x.1.0/24`).
2. Configure via Azure Portal:
   - Go to **Virtual Networks** → **Create**.
   - Set the address space and add the subnet as specified.
   - Click **Review + Create** → **Create**.

### Deploy 1 VM in Each VNet
1. For each VNet, create one **Linux VM**:
   - Go to **Virtual Machines** → **Create**.
   - Select the respective VNet and its default subnet (`Subnet-A`).
   - Enable **SSH access** for connectivity.
   - Ensure the **Network Security Group (NSG)** allows **ICMP** (for ping) or temporarily allow all traffic for testing.
2. Complete other settings (e.g., size, authentication) → Click **Review + Create** → **Create**.

### Configure Hub-and-Spoke Peering
For each Spoke VNet, create VNet peering with the **Management-VNet**:
1. Go to **Management-VNet** → **Peerings** → Click **Add**.
2. Configure:
   - **Name**: e.g., `Management-To-Production`
   - **Remote VNet**: Select `Production-VNet`
   - **Enable**: "Allow traffic to remote virtual network"
   - **Enable**: "Allow gateway transit" (optional)
3. Repeat for `Testing-VNet` and `Development-VNet`.
4. In each Spoke VNet (`Production-VNet`, `Testing-VNet`, `Development-VNet`), add reverse peerings back to `Management-VNet`:
   - Go to the Spoke VNet → **Peerings** → **Add**.
   - Configure reverse peering (e.g., `Production-To-Management`).

### Verify Connectivity
1. SSH into the **Management VM** (in `Management-VNet`).
2. Use `ping` to test connectivity to the private IPs of VMs in the spoke VNets:
   ```bash
   ping <private-IP-of-production-VM>
   ping <private-IP-of-testing-VM>
   ping <private-IP-of-development-VM>
   ```
3. Ensure **ICMP** is allowed via the NSG or temporarily allow all inbound traffic for testing.

---

## Resources
- [Azure Virtual Network Documentation](https://docs.microsoft.com/azure/virtual-network/)
- [Azure Network Security Groups | Azure NSG | Azure Security Groups | NSG in Azure | Security Groups
](https://www.youtube.com/watch?v=f7sTlsjcaxw)
- [VNet Peering Documentation](https://docs.microsoft.com/azure/virtual-network/virtual-network-peering-overview)
