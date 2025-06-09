# Task 4: User and Group Management

## Description
Create a new user and group, set their permissions, and explore user management commands like `useradd`, `usermod`, and `userdel`.

## Instructions

### 1. Create a New User

```sh
sudo useradd newuser
```

### 2. Create a New Group

```sh
sudo groupadd newgroup
```

### 3. Add User to Group

```sh
sudo usermod -aG newgroup newuser
```

### 4. Set Permissions for User and Group

```sh
sudo chmod 750 /path/to/directory
```

`750` permission means:
* Owner: Read, write, execute (7)
* Group: Read, execute (5)
* Others: No permissions (0)

### 5. Delete a User

```sh
sudo userdel newuser
```

To delete the user and their home directory:

```sh
sudo userdel -r newuser
```

## Resources
* Red Hat: Manage Permissions
* Linux User Management (YouTube)
