# Task 3: Create Virtual Machine and Virtual Network using Azure CLI

**Objective**:  
Use Azure CLI to create a Virtual Network (VNet), a Subnet, a Network Interface, and a Linux or Windows Virtual Machine attached to the configuration, via Azure Cloud Shell or a local terminal.

---

## Pre-requisites
- Azure CLI installed locally or use [Azure Cloud Shell](https://shell.azure.com).
- Logged into your Azure account:
  ```sh
  az login
  ```

---

## Steps

### 1. Create a Resource Group
```sh
az group create --name RG-CLI-DEMO --location eastus
```

### 2. Create a Virtual Network and Subnet
```sh
az network vnet create \
  --resource-group RG-CLI-DEMO \
  --name CLI-VNet \
  --address-prefix 10.0.0.0/16 \
  --subnet-name CLI-Subnet \
  --subnet-prefix 10.0.1.0/24
```

### 3. Create a Public IP Address
```sh
az network public-ip create \
  --resource-group RG-CLI-DEMO \
  --name CLI-PublicIP
```

### 4. Create a Network Security Group (Optional but Recommended)
```sh
az network nsg create \
  --resource-group RG-CLI-DEMO \
  --name CLI-NSG
```
Add SSH rule (for Linux) or RDP rule (for Windows):
```sh
az network nsg rule create \
  --resource-group RG-CLI-DEMO \
  --nsg-name CLI-NSG \
  --name AllowSSH \
  --priority 1000 \
  --destination-port-ranges 22 \
  --access Allow \
  --protocol Tcp \
  --direction Inbound
```
For Windows, replace `--name AllowSSH` with `--name AllowRDP` and `--destination-port-ranges 22` with `--destination-port-ranges 3389`.

### 5. Create a Network Interface
```sh
az network nic create \
  --resource-group RG-CLI-DEMO \
  --name CLI-NIC \
  --vnet-name CLI-VNet \
  --subnet CLI-Subnet \
  --network-security-group CLI-NSG \
  --public-ip-address CLI-PublicIP
```

### 6. Create a Virtual Machine

#### Linux VM
```sh
az vm create \
  --resource-group RG-CLI-DEMO \
  --name CLI-LinuxVM \
  --nics CLI-NIC \
  --image UbuntuLTS \
  --admin-username azureuser \
  --generate-ssh-keys
```

#### Windows VM (Alternative)
```sh
az vm create \
  --resource-group RG-CLI-DEMO \
  --name CLI-WindowsVM \
  --nics CLI-NIC \
  --image Win2019Datacenter \
  --admin-username azureuser \
  --admin-password StrongP@ssw0rd123
```

### 7. Verify VM Status
```sh
az vm show \
  --resource-group RG-CLI-DEMO \
  --name CLI-LinuxVM \
  --show-details \
  --query '[powerState,publicIps]' \
  --output table
```
Replace `CLI-LinuxVM` with `CLI-WindowsVM` if you created a Windows VM.

---

## Outcome
- Virtual Network (VNet) and Subnet created using Azure CLI.
- Virtual Machine (Linux or Windows) deployed using Azure CLI.
- Public IP and Network Security Group (NSG) configured.
- CLI-based deployment pipeline tested successfully.

---

## Resources
- [Microsoft Docs – Azure CLI VM Quickstart](https://learn.microsoft.com/azure/virtual-machines/linux/quick-create-cli)
- [AZ CLI Overview and Demo Super Show](https://www.youtube.com/watch?v=DOywwse_j8I)
