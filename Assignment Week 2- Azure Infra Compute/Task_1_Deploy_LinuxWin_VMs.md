# Task 1: Deploy Linux and Windows Virtual Machines on Azure

**Objective:**
Deploy a **Linux** and **Windows** Virtual Machine (VM) using the Azure portal and access them using **SSH** (for Linux) and **RDP** (for Windows).

## Steps to Deploy a Linux VM

1. **Log in** to Azure Portal.
2. Go to **"Virtual Machines"** → click **"Create"** → **"Azure virtual machine"**.
3. Fill in the **Basic Details**:

   ![image](https://github.com/user-attachments/assets/91b6134d-01f1-4d80-80c5-b98f9f8b197f)

   * Subscription & Resource Group
   * Virtual Machine Name: `linux-vm01`
   * Region: Select any region (e.g., East US)
   * Image: `Ubuntu 22.04 LTS`
   * Size: e.g., `Standard B1s`
   * Authentication type: `SSH public key`
   * Username: `azureuser`
   * Generate a new key pair or use an existing `.pem` file

5. Under **Inbound ports**, allow **SSH (port 22)**.

   ![image](https://github.com/user-attachments/assets/fd2da15b-7e6b-48bc-b679-7753f8326881)

   
7. Click **"Review + create"**, then **"Create"**.

## Access Linux VM Using SSH

Once the VM is deployed:

![image](https://github.com/user-attachments/assets/5ce53cb3-8878-47de-bd59-f6412ae699a8)


```bash
ssh -i <private key path> azureuser@<public-ip-address>
```

Replace `<public-ip-address>` with the VM's actual IP from Azure.

![image](https://github.com/user-attachments/assets/2f5c1882-b9f7-4122-8437-b311360d4045)
![image](https://github.com/user-attachments/assets/9eda8464-4dee-4cf7-aa08-4564a4dbbab2)

## Steps to Deploy a Windows VM

1. In the Azure portal, go to **"Virtual Machines"** → click **"Create"** → **"Azure virtual machine"**.
2. Fill in the **Basic Details**:
   * VM Name: `windows-vm01`
   * Image: `Windows Server 2022 Datacenter`
   * Size: e.g., `Standard B1ms`
   * Authentication: Username + Password
3. Allow **RDP (port 3389)** under inbound port rules.
4. Click **"Review + create"**, then **"Create"**.

## Access Windows VM Using RDP

Once deployed:
1. Copy the **Public IP address** of the VM.
2. Open **Remote Desktop Connection** (on your local machine):
   * Paste the IP address
   * Click Connect → Enter the credentials
3. You should be able to access the Windows VM's desktop interface.

## Resources:
* Deploy a Linux VM in Azure
* Deploy a Windows VM in Azure
* How to SSH into Azure Linux VM
* Connect to Windows VM using RDP
