# Task 4: Create a Container Instance, Deploy a Simple Docker App, Create Container Groups, and Test Functionality

## Part 1: Create a Container Instance and Deploy a Docker App

### Option A: Using Azure Portal
1. Go to the [Azure Portal](https://portal.azure.com).
2. Search for **Container Instances** > Click **Create**.
3. Fill in the container instance details:
   - **Subscription**: Your active subscription
   - **Resource Group**: Use existing or create new
   - **Container Name**: e.g., `my-container-instance`
   - **Region**: Choose any region
   - **Image Source**: Docker Hub
   - **Image Type**: Public
   - **Image Name**: e.g., `nginx` or any other Docker image
   - **OS type**: Linux (unless deploying a Windows container)
   - **Size**: Default or choose based on needs
   - **Ports**: Expose port `80` if using a web app
4. Click **Review + create** and then **Create**.
5. Once deployed, go to the container instance overview page and copy the **FQDN** or **IP address** to access the app in your browser.

### Option B: Using Azure CLI
```bash
az container create \
  --resource-group myResourceGroup \
  --name myContainer \
  --image nginx \
  --ports 80
```
To get the public IP:
```bash
az container show --resource-group myResourceGroup --name myContainer --query ipAddress.fqdn
```
Visit the output URL in your browser.

---

## Part 2: Create a Container Group (Multi-container Setup)
Container Groups allow multiple containers to run on the same host and share resources like volumes and network.  
**Example**: Nginx as front-end and a simple backend container (e.g., `mcr.microsoft.com/azuredocs/aci-helloworld`).

### Azure CLI Example
```bash
az container create \
  --resource-group myResourceGroup \
  --name myContainerGroup \
  --image mcr.microsoft.com/azuredocs/aci-helloworld \
  --cpu 1 --memory 1.5 \
  --ports 80 \
  --dns-name-label mycontainergroupdemo \
  --restart-policy OnFailure
```

### Sample YAML for Container Group (Advanced)
Create a file `multi-container-group.yml`:
```yaml
apiVersion: 2019-12-01
location: eastus
name: myContainerGroup
properties:
  containers:
  - name: frontend
    properties:
      image: nginx
      ports:
      - port: 80
      resources:
        requests:
          cpu: 1
          memoryInGb: 1.5
  - name: backend
    properties:
      image: mcr.microsoft.com/azuredocs/aci-helloworld
      ports:
      - port: 80
      resources:
        requests:
          cpu: 1
          memoryInGb: 1
  osType: Linux
  ipAddress:
    type: Public
    ports:
    - protocol: tcp
      port: 80
  restartPolicy: Always
type: Microsoft.ContainerInstance/containerGroups
```
Deploy with:
```bash
az container create --resource-group myResourceGroup --file multi-container-group.yml
```

---

## Verification
1. Go to the [Azure Portal](https://portal.azure.com).
2. Open your container group instance.
3. Access the **FQDN** or **public IP** in the browser.
4. You should see the default welcome pages (e.g., Nginx or Hello World).

---

## Resources
- [Azure Container Instances Tutorial | Serverless containers in cloud
](https://www.youtube.com/watch?v=jAWLQFi4USk)
