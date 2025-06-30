## Task 3: Docker Registry, DockerHub, and Multi-Stage Build

**Objective**:  
- Understand Docker registries and DockerHub.
- Push and pull images from DockerHub.
- Implement multi-stage builds to optimize Docker images.

---

## Part A: DockerHub & Docker Registry

### Step 1: Login to DockerHub
1. Log in to your DockerHub account:
   ```bash
   docker login
   ```
2. Provide your DockerHub username and password.

### Step 2: Tag the Local Image
1. Tag the local image (`my-web-app` from Task 2) for DockerHub:
   ```bash
   docker tag my-web-app <your-dockerhub-username>/my-web-app:latest
   ```

### Step 3: Push the Image to DockerHub
1. Push the tagged image to DockerHub:
   ```bash
   docker push <your-dockerhub-username>/my-web-app:latest
   ```

### Step 4: Pull the Image from DockerHub
1. Test pulling the image (on another machine or after removing locally):
   ```bash
   docker pull <your-dockerhub-username>/my-web-app:latest
   ```

---

## Part B: Multi-Stage Docker Build
Multi-stage builds reduce image size by separating build-time dependencies from the final runtime image, improving security and performance.

### Example: Node.js App with Multi-Stage Dockerfile
**Folder Structure**:
```
/app
  ├── Dockerfile
  ├── package.json
  ├── server.js
```

**Sample Files**:
- `package.json`:
  ```json
  {
    "name": "node-app",
    "version": "1.0.0",
    "dependencies": {
      "express": "^4.17.1"
    },
    "scripts": {
      "start": "node server.js"
    }
  }
  ```
- `server.js`:
  ```javascript
  const express = require('express');
  const app = express();
  app.get('/', (req, res) => res.send('Hello from Node.js!'));
  app.listen(3000, () => console.log('Server running on port 3000'));
  ```

**Dockerfile**:
```dockerfile
# Stage 1: Build
FROM node:18-alpine AS build
WORKDIR /app
COPY package.json .
RUN npm install
COPY . .

# Stage 2: Runtime
FROM node:18-alpine
WORKDIR /app
COPY --from=build /app .
EXPOSE 3000
CMD ["node", "server.js"]
```

### Step 1: Build the Multi-Stage Image
1. Navigate to the `/app` directory containing the `Dockerfile`, `package.json`, and `server.js`.
2. Build the multi-stage image:
   ```bash
   docker build -t node-multistage-app .
   ```

### Step 2: Run the Image
1. Run the container from the image:
   ```bash
   docker run -d -p 3000:3000 node-multistage-app
   ```
2. Access the application at [http://localhost:3000](http://localhost:3000) in your browser. You should see "Hello from Node.js!".

---

## Why Multi-Stage Builds?
- **Smaller Image Size**: Excludes build-time dependencies, reducing the final image size.
- **Improved Security**: Minimizes the attack surface by including only runtime essentials.
- **Better Performance**: Smaller images lead to faster deployment and execution.

---
## Resources
- [YouTube: Multi-stage Docker file with Demo
](https://www.youtube.com/watch?v=VyO8MPIfHnE)
- [Docker Curriculum](https://docker-curriculum.com/)
