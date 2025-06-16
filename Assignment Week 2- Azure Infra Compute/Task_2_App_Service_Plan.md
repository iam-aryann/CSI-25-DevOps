# Task 2: Create an App Service Plan, Provision a Web App, and Deploy a Welcome Page

## Objective:
Create an **App Service Plan**, provision a **Web App** within that plan, and deploy a **simple welcome page** using the Azure Portal.

## Steps to Create an App Service Plan

1. **Log in** to the Azure Portal.
2. Search for **App Service Plans** in the search bar.
3. Click **Create** and fill in the following details:
   * **Subscription**: Your active subscription
   * **Resource Group**: Select existing or create new
   * **Name**: Choose a name
   * **Region**: Select a preferred region
   * **Pricing Tier**: Use a free or basic tier for testing (e.g., `F1 Free`)
4. Click **Review + create** and then **Create**.

## Steps to Provision a Web App

1. After the App Service Plan is created, search for **App Services** → Click **Create**.
2. Fill in the Web App details:
   * **Subscription** and **Resource Group**
   * **Name**: Choose a unique name (e.g., `my-welcome-app`)
   * **Publish**: Code
   * **Runtime stack**: e.g., PHP, .NET, Node.js, or Python (choose based on preference)
     
     ![image](https://github.com/user-attachments/assets/c944eb90-bd7d-4878-88ce-11799c8568bc)

   * **Operating System**: Windows or Linux
   * **Region**: Same as App Service Plan
   * **App Service Plan**: If not available automatically creates new

     ![image](https://github.com/user-attachments/assets/24475190-5761-4484-b11e-88a2de0800ad)

3. Click **Review + create**, then **Create**.

## Deploying a Simple Welcome Page

# Use Windows PowerShell (if file is on Windows)

If you prefer to use **PowerShell** on Windows (and not WSL or Bash), then:
1. Open **PowerShell** (not WSL or Bash).
2. Run the correct command:

```powershell
az webapp deploy --resource-group azure4everyone-appservice-intro --name a4edemoapp --src-path "D:\CSI_25_DevOps\Assignment_2\DEMO.zip" --type zip
```
   ![image](https://github.com/user-attachments/assets/deabe0c1-42d1-4277-ba6a-50a7a7842b46)

3. Visit the app at: http://a4edemoapp-fygafubjdpckhsft.centralindia-01.azurewebsites.net

## Resources:
- [Azure App Service (Web Apps) Tutorial
](https://www.youtube.com/watch?v=4BwyqmRTrx8)
