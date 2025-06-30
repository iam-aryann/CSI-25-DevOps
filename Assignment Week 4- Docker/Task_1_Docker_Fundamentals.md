# Week 4: Docker
## Task 1: Introduction to Containerization and Docker Fundamentals, Basic Commands

**Description**:  
This task introduces containerization and Docker, covering Docker architecture and basic commands for managing containers and images.

---

## What is Containerization?
Containerization is a lightweight alternative to full machine virtualization, encapsulating an application and its dependencies into a single container. Containers are portable and can run on any system with Docker installed, regardless of the underlying operating system.

---

## Docker Fundamentals
Docker is a platform that automates the deployment of applications inside lightweight containers. Key components include:

- **Docker Engine**: The runtime that builds and runs containers.
- **Docker Images**: Templates used to create containers.
- **Docker Containers**: Running instances of Docker images.
- **Dockerfile**: Script with instructions to build a Docker image.
- **Docker Hub**: A public registry for Docker images.

---

## Basic Docker Commands

### 1. Check Docker Installation
```bash
docker --version
```
![image](https://github.com/user-attachments/assets/63abdbd4-6c0a-4db4-8afb-e3dadf883813)

![image](https://github.com/user-attachments/assets/5e3a9a8c-d21d-4d3e-a329-72e3d943762d)

![image](https://github.com/user-attachments/assets/928838f6-edb2-4eff-84bf-163e68fd5ae8)

![image](https://github.com/user-attachments/assets/ec38ca7b-4509-4173-9f9f-e778e2d76e95)

### 2. Run a Container from Image
```bash
docker run hello-world
```
Pulls the `hello-world` image from Docker Hub and runs it in a container to verify Docker is working.

![image](https://github.com/user-attachments/assets/0e9f5860-3e2b-4b6f-9279-92e07470de52)

### 3. Pull an Image
```bash
docker pull ubuntu
```
Downloads the `ubuntu` image from Docker Hub.

![image](https://github.com/user-attachments/assets/979b2cff-46b6-4787-9784-488fc11fb0af)

### 4. List All Docker Images
```bash
docker images
```
Displays all locally stored Docker images.

![image](https://github.com/user-attachments/assets/14aebfe7-ff4f-4862-b117-20fe1c2d5a83)

### 5. List Running Containers
```bash
docker ps
```
Shows currently running containers.

![image](https://github.com/user-attachments/assets/45df5b70-07dc-4bab-a663-66e6127ba6f8)

### 6. List All Containers (Running + Exited)
```bash
docker ps -a
```
Displays all containers, including stopped ones.

### 7. Run Ubuntu Container Interactively
```bash
docker run -it ubuntu
```
Starts an interactive Ubuntu container with a terminal session.
![image](https://github.com/user-attachments/assets/c93c0387-526b-42fc-b577-63865b1ed809)

### 8. Exit a Running Container
```bash
exit
```
Exits the container’s interactive session.

![image](https://github.com/user-attachments/assets/0b46658a-fa14-466c-8249-ff6f8a668715)

### 9. Remove a Container
```bash
docker rm <container_id>
```
Removes a specified container (use `docker ps -a` to find the container ID).

![image](https://github.com/user-attachments/assets/ac1a5673-84f0-4df4-b910-81961b24120a)

### 10. Remove an Image
```bash
docker rmi <image_id>
```
Deletes a specified Docker image (use `docker images` to find the image ID).

![image](https://github.com/user-attachments/assets/1ac9e6e3-715b-4d2e-97c8-71c21eea93ca)

### 11. Start/Stop a Container
```bash
docker start <container_id>
docker stop <container_id>
```
Starts or stops a container by its ID.
![image](https://github.com/user-attachments/assets/ab7f22a3-03c4-4f87-ba5a-1c9a06c98529)

---

## Resources
- [Docker Curriculum](https://docker-curriculum.com/)
- [YouTube: Docker Tutorial for Beginners](https://www.youtube.com/results?search_query=docker+tutorial+for+beginners)
