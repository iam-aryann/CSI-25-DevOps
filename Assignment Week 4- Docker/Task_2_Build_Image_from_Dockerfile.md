## Task 2: Docker Installation and Basic Container Operations – Build an Image from Dockerfile

**Objective**:  
Learn how to install Docker, create and configure a Dockerfile, build an image from the Dockerfile, and run a container from the image.

---

## Steps

### Step 1: Install Docker
1. Download and install **Docker Desktop** from [https://www.docker.com/products/docker-desktop](https://www.docker.com/products/docker-desktop).
2. Verify installation:
   ```bash
   docker --version
   docker info
   ```
   
    ![460499848-ec38ca7b-4509-4173-9f9f-e778e2d76e95](https://github.com/user-attachments/assets/1577d6f5-e42d-4db8-acc4-8087a8c4d8be)

---

### Step 2: Create a File Named Dockerfile
1. In your project directory, create a file named `Dockerfile` (no file extension):
   ```bash
   touch Dockerfile
   ```

---

### Step 3: Add Instructions in Dockerfile

   ```dockerfile
   #getting base image ubuntu
   FROM ubuntu
   LABEL maintainer="aryan choudhary <aryanchoudhary06ac@gmail.com>"
   RUN apt-get update
   CMD ["echo", "Hello World...! from my first docker image"]
   ```
  ![image](https://github.com/user-attachments/assets/ec1e1096-e4e2-455f-8780-048f7d646911)

  ![image](https://github.com/user-attachments/assets/55392e69-2c90-423b-9858-2ffeb2e9e88a)
  
---

### Step 4: Build Dockerfile to Create an Image
1. Build the Docker image from the `Dockerfile`:
   ```bash
   docker build -t myimage1:1.0 .
   ```
   - `-t myimage01`: Tags the image with the name `myimage01`.
   - `.`: Refers to the current directory containing the `Dockerfile`.
   
    ![image](https://github.com/user-attachments/assets/f94e4586-dc62-4fad-9fa8-4799c4bb68de)
    
---

### Step 5: Run Image to Create a Container
1. Run the container from the image:
   ```bash
   docker run <image-id>
   ```
   ![image](https://github.com/user-attachments/assets/ebab55e5-cef8-4c3e-8029-852eefa50a11)
   
---

## Verification Commands
- List all running containers:
  ```bash
  docker ps
  ```
- Stop a running container:
  ```bash
  docker stop <container_id>
  ```
- Remove an image:
  ```bash
  docker rmi <image_id>
  ```

---

## Resources
- [YouTube: What is Dockerfile | How to create and build Dockerfile | Dockerfile Basic Commands](https://www.youtube.com/watch?v=LQjaJINkQXY)
- [Docker Curriculum](https://docker-curriculum.com/)
