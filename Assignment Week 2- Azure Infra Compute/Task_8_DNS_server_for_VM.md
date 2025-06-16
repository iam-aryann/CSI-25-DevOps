# Task 8: Set Up a Domain, Host Server on VM, and Configure DNS

**Objective**:  
Purchase or configure a custom domain and use Azure DNS to map it to a Virtual Machine's public IP, hosting a web server.

---

## Step 1: Create and Configure a Virtual Machine (Web Server)
1. Go to [Azure Portal](https://portal.azure.com) → Search for **Virtual Machines** → Click **Create** → Select **Azure virtual machine**.
2. Configure:
   - **OS**: Ubuntu
   - **Size**: Standard B1s (for testing)
   - **Public IP**: Enabled
   - **Inbound Port Rules**: Allow **HTTP (80)** and **SSH (22)**
3. Complete other settings (e.g., resource group, authentication) → Click **Review + Create** → **Create**.
4. SSH into the VM and install a web server:
   ```bash
   sudo apt update
   sudo apt install nginx -y
   echo "Welcome to my Azure Web Server!" | sudo tee /var/www/html/index.html
   ```
5. Test the web server:
   - Open the VM’s **public IP** in a browser (e.g., `http://<vm-public-ip>`).
   - You should see the message: "Welcome to my Azure Web Server!"

---

## Step 2: Purchase or Use a Custom Domain
1. **Option 1**: Purchase a domain from a registrar like GoDaddy, Namecheap, or Google Domains.
   - Example domain: `yourdomain.com`
2. **Option 2**: Use an existing domain you already own.

---

## Step 3: Create Azure DNS Zone
1. Go to [Azure Portal](https://portal.azure.com) → Search for **DNS Zones** → Click **Create**.
2. Configure:
   - **Resource Group**: Choose existing or create new
   - **Name**: Same as your domain (e.g., `yourdomain.com`)
3. Click **Review + Create** → **Create**.
4. Once created, note the Azure-provided nameservers, e.g.:
   ```
   ns1-08.azure-dns.com
   ns2-08.azure-dns.net
   ns3-08.azure-dns.org
   ns4-08.azure-dns.info
   ```

---

## Step 4: Configure Your Domain to Use Azure DNS
1. Log in to your domain registrar (e.g., GoDaddy, Namecheap).
2. Navigate to the DNS management or nameserver settings for your domain.
3. Replace the default nameservers with the Azure nameservers listed in Step 3.

---

## Step 5: Create ‘A’ Record in Azure DNS Zone
1. Go to your **DNS Zone** in the Azure Portal.
2. Click **+ Record Set** and configure:
   - **Name**: `www` or `@` (for the root domain)
   - **Type**: A
   - **TTL**: 300
   - **IP Address**: Public IP of your Azure VM
3. Click **OK** to save the record.

---

## Step 6: Test the Domain
1. Wait for DNS propagation (typically 5–15 minutes, but can take up to 24 hours).
2. Open a browser and navigate to:
   ```
   http://yourdomain.com
   http://www.yourdomain.com
   ```
3. You should see the message: "Welcome to my Azure Web Server!" from the VM.

---

## 🧩 Resources
- [Microsoft Azure Private Link Deep Dive
](https://www.youtube.com/watch?v=57ZwdztCx2w)
- [Azure DNS Documentation](https://docs.microsoft.com/azure/dns/)
- [Tutorial: Host a domain in Azure DNS](https://docs.microsoft.com/azure/dns/dns-delegate-domain-azure-dns)
- [Tutorial: Configure a custom domain for a VM](https://docs.microsoft.com/azure/virtual-machines/custom-dns)
