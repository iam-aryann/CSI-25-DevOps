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
   * Image: `Windows Server 2025 Datacenter`
   
      ![image](https://github.com/user-attachments/assets/9a32f34a-1612-4465-acdd-08711f5c4337)

   * Size: e.g., `Standard B1ms`
   * Authentication: Username + Password
3. Allow **RDP (port 3389)** under inbound port rules.

   ![image](https://github.com/user-attachments/assets/ae58db03-3580-4098-8ed5-dedfe65b12d3)

5. Click **"Review + create"**, then **"Create"**.

## Access Windows VM Using RDP

Once deployed:
1. Copy the **Public IP address** of the VM.

   ![image](https://github.com/user-attachments/assets/9cf1a72a-73de-434c-bc0a-1fa608605c9e)

3. Open **Remote Desktop Connection** (on your local machine):
   * Paste the IP address

      ![image](https://github.com/user-attachments/assets/b4403051-2e8f-4511-b217-b64f16dd9490)

   * Click Connect → Enter the credentials

      ![image](https://github.com/user-attachments/assets/cdf86f54-8278-4d45-a87c-cd3b81509f83)
       
3. You should be able to access the Windows VM's desktop interface.

   ![image](https://github.com/user-attachments/assets/3905245a-02d9-43b8-9b83-4e90e64f6cd8)

## Resources:
- [Deploy a Linux VM in Azure](https://learn.microsoft.com/en-us/azure/virtual-machines/linux/quick-create-portal)
- [Deploy a Windows VM in Azure](https://learn.microsoft.com/en-us/azure/virtual-machines/windows/quick-create-portal)
- [How to SSH into Azure Linux VM](https://learn.microsoft.com/en-us/azure/virtual-machines/linux/ssh-from-windows)
- [Connect to Windows VM using RDP](https://learn.microsoft.com/en-us/azure/virtual-machines/windows/connect-logon)
