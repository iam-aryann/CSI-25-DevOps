## Task 4: Create a Docker Image Using Multiple Methods (Dockerfile & Running Containers)

**Objective**:  
Learn to create Docker images using two methods:  
1. **Declarative**: Using a Dockerfile to define and build an image.  
2. **Imperative/Manual**: Committing changes from a running container to create an image.

---

## Method 1: Create Docker Image Using a Dockerfile

### Step 1: Create a Dockerfile
1. In your project directory, create a file named `Dockerfile` (no extension) and an `index.html` file.
2. Add the following content to `Dockerfile`:
   ```dockerfile
   # Use an official base image
   FROM ubuntu:20.04

   # Install packages
   RUN apt update && apt install -y nginx

   # Copy static content
   COPY index.html /var/www/html/index.html

   # Expose a port and run service
   EXPOSE 80
   CMD ["nginx", "-g", "daemon off;"]
   ```
3. Create an `index.html` file in the same directory:
   ```html
   <!DOCTYPE html>
   <html>
     <head><title>Docker Nginx</title></head>
     <body>
       <h1>Welcome to my Nginx Docker Image!</h1>
     </body>
   </html>
   ```

### Step 2: Build the Image
1. Build the Docker image:
   ```bash
   docker build -t custom-nginx-image .
   ```
   - `-t custom-nginx-image`: Tags the image with the name `custom-nginx-image`.
   - `.`: Refers to the current directory containing the `Dockerfile`.

### Step 3: Run the Image
1. Run a container from the image:
   ```bash
   docker run -d -p 8080:80 custom-nginx-image
   ```
   - `-d`: Runs the container in detached mode.
   - `-p 8080:80`: Maps host port 8080 to container port 80.
2. Access the application at [http://localhost:8080](http://localhost:8080) in your browser. You should see "Welcome to my Nginx Docker Image!".

---

## Method 2: Commit a Running Container to Create an Image

### Step 1: Run a Base Container
1. Start an interactive Ubuntu container:
   ```bash
   docker run -it ubuntu:20.04 bash
   ```

### Step 2: Make Changes Inside Container
1. Inside the container, install `curl`:
   ```bash
   apt update && apt install -y curl
   ```
2. Exit the container:
   ```bash
   exit
   ```

### Step 3: Commit the Container as an Image
1. Find the container ID:
   ```bash
   docker ps -a
   ```
2. Commit the container to create a new image:
   ```bash
   docker commit <container_id> ubuntu-with-curl
   ```

### Step 4: Run the New Image
1. Run a container from the new image:
   ```bash
   docker run -it ubuntu-with-curl bash
   ```
2. Inside the container, verify `curl` is installed:
   ```bash
   curl google.com
   ```

---

## Expected Outcome
- **Method 1**: Created a Docker image (`custom-nginx-image`) using a Dockerfile and ran a container serving a simple web page at [http://localhost:8080](http://localhost:8080).
- **Method 2**: Created a Docker image (`ubuntu-with-curl`) by committing changes from a running container and verified the installed `curl` command in a new container.

---

## Resources
- [YouTube: Complete Git and GitHub Tutorial
](https://www.youtube.com/watch?v=apGV9Kg7ics)
- [Docker Curriculum](https://docker-curriculum.com/)
