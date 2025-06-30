## Task 7: Create a Docker Volume and Mount It to a Container

**Objective**:  
Learn to create a Docker volume, mount it to a container, and persist data even after the container is removed.

---

## Step-by-Step Instructions

### Step 1: Create a Docker Volume
1. Create a Docker volume:
   ```bash
   docker volume create myvolume
   ```
2. Verify the volume was created:
   ```bash
   docker volume ls
   ```
   You should see `myvolume` listed.

---

### Step 2: Run a Container and Mount the Volume
1. Run a container with the volume mounted at `/data`:
   ```bash
   docker run -dit --name volume-test -v myvolume:/data ubuntu
   ```
   - `-v myvolume:/data`: Mounts `myvolume` to the `/data` directory in the container.

---

### Step 3: Write Data to the Volume
1. Access the container:
   ```bash
   docker exec -it volume-test bash
   ```
2. Inside the container, write data to the volume:
   ```bash
   echo "Hello Docker Volume" > /data/hello.txt
   cat /data/hello.txt
   ```
   You should see the output: `Hello Docker Volume`.
3. Exit the container:
   ```bash
   exit
   ```

---

### Step 4: Remove the Container and Reattach Volume
1. Remove the container:
   ```bash
   docker rm -f volume-test
   ```
2. Run a new container using the same volume:
   ```bash
   docker run -it --rm -v myvolume:/data ubuntu cat /data/hello.txt
   ```
3. You should see the persisted data:
   ```
   Hello Docker Volume
   ```
   This confirms that the data persists in the volume even after the original container is removed.

---

## Notes
- Docker volumes are stored on the host at `/var/lib/docker/volumes/`.
- Volumes are the recommended method for persisting container data, as they are managed by Docker and independent of the container lifecycle.

---

## Expected Outcome
- A Docker volume (`myvolume`) is created and verified.
- A container is run with the volume mounted, and data is written to it.
- Data persists after the container is removed and is accessible in a new container using the same volume.

---

## Resources
- [YouTube: 
22. Docker (in Hindi) : Docker Volume ( Docker Storage), mysql data persist in docker container](https://www.youtube.com/watch?v=u_0O4DOo2GI)
- [Docker Curriculum](https://docker-curriculum.com/)
- [Docker Volumes Documentation](https://docs.docker.com/storage/volumes/)
