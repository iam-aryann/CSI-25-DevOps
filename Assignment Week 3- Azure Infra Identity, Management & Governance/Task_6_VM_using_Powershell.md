# Task 6: Create a Virtual Machine Using Azure PowerShell

**Objective**:  
Use Azure PowerShell to create a Virtual Machine (VM) from scratch, including a Virtual Network, Subnet, Public IP, Network Security Group, and Network Interface.

---

## Prerequisites
- Azure PowerShell installed locally:
  ```powershell
  Install-Module -Name Az -AllowClobber -Scope CurrentUser
  ```
- Logged into your Azure account:
  ```powershell
  Connect-AzAccount
  ```

---

## Steps to Create VM via Azure PowerShell

### 1. Set Variables
```powershell
$resourceGroup = "MyResourceGroup"
$location = "EastUS"
$vmName = "MyPowerShellVM"
```

### 2. Create Resource Group
```powershell
New-AzResourceGroup -Name $resourceGroup -Location $location
```

### 3. Create Virtual Network and Subnet
```powershell
$vnet = New-AzVirtualNetwork -ResourceGroupName $resourceGroup -Location $location `
  -Name "$vmName-VNet" -AddressPrefix "10.0.0.0/16"

$subnet = Add-AzVirtualNetworkSubnetConfig -Name "$vmName-Subnet" `
  -AddressPrefix "10.0.0.0/24" -VirtualNetwork $vnet

$vnet | Set-AzVirtualNetwork
```

### 4. Create Public IP Address
```powershell
$publicIp = New-AzPublicIpAddress -Name "$vmName-PublicIP" -ResourceGroupName $resourceGroup `
  -Location $location -AllocationMethod Dynamic
```

### 5. Create Network Security Group
```powershell
$nsg = New-AzNetworkSecurityGroup -ResourceGroupName $resourceGroup `
  -Location $location -Name "$vmName-NSG"

# Add RDP rule for Windows
$rdpRule = New-AzNetworkSecurityRuleConfig -Name "AllowRDP" -Description "Allow RDP" `
  -Access Allow -Protocol Tcp -Direction Inbound -Priority 1000 `
  -SourceAddressPrefix Internet -SourcePortRange * `
  -DestinationAddressPrefix * -DestinationPortRange 3389

$nsg.SecurityRules.Add($rdpRule)
Set-AzNetworkSecurityGroup -NetworkSecurityGroup $nsg
```

### 6. Create NIC (Network Interface)
```powershell
$nic = New-AzNetworkInterface -Name "$vmName-NIC" -ResourceGroupName $resourceGroup `
  -Location $location -SubnetId $vnet.Subnets[0].Id -PublicIpAddressId $publicIp.Id `
  -NetworkSecurityGroupId $nsg.Id
```

### 7. Set VM Credentials
```powershell
$cred = Get-Credential -Message "Enter local admin credentials for the VM"
```

### 8. Configure VM and OS
```powershell
$vmConfig = New-AzVMConfig -VMName $vmName -VMSize "Standard_B1s" |
  Set-AzVMOperatingSystem -Windows -ComputerName $vmName -Credential $cred -ProvisionVMAgent -EnableAutoUpdate |
  Set-AzVMSourceImage -PublisherName "MicrosoftWindowsServer" -Offer "WindowsServer" -Skus "2022-datacenter" -Version "latest" |
  Add-AzVMNetworkInterface -Id $nic.Id
```

### 9. Create the VM
```powershell
New-AzVM -ResourceGroupName $resourceGroup -Location $location -VM $vmConfig
```

---

## Expected Outcome
- A Windows VM named `MyPowerShellVM` is deployed in your Azure subscription.
- The VM is accessible via RDP using the public IP created.

---

## Resources
- [YouTube: Create VM using Azure PowerShell](https://www.youtube.com/results?search_query=create+vm+using+azure+powershell)
- [Microsoft Docs – Azure PowerShell Overview](https://learn.microsoft.com/powershell/azure/)
