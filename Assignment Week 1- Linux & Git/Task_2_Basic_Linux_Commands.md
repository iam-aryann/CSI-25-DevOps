# Task 2: Basic Linux Commands

## Description
Execute basic Linux commands to manipulate files and directories, with an emphasis on understanding their usage. This task includes listing files, creating and deleting directories, changing directories, and more.

---

## Instructions and Commands

### List Files and Directories

- `ls`: List the files and directories in the current directory.
```bash
ls
```

- `ls -l`: List files and directories with detailed information.
```bash
ls -l
```

- `ls -a`: List all files, including hidden files (those starting with a dot).
```bash
ls -a
```

- `ls -la`: Combine detailed and hidden file listing.
```bash
ls -la
```

---

### Change Directory

- `cd directory_name`: Change to the specified directory.
```bash
cd directory_name
```

- `cd ..`: Move up one directory level.
```bash
cd ..
```

- `cd ~`: Change to the home directory.
```bash
cd ~
```

---

### Make Directory

- `mkdir new_directory`: Create a new directory.
```bash
mkdir new_directory
```

- `mkdir -p parent_directory/new_directory`: Create nested directories with a single command.
```bash
mkdir -p parent_directory/new_directory
```

---

### Remove Directory

- `rmdir directory_name`: Remove an empty directory.
```bash
rmdir directory_name
```

- `rm -r directory_name`: Remove a directory and its contents recursively.
```bash
rm -r directory_name
```

---

### Create a File

- `touch newfile.txt`: Create a new, empty file.
```bash
touch newfile.txt
```

---

### Remove a File

- `rm filename`: Remove a file.
```bash
rm filename
```

---

### Move/Rename a File or Directory

- `mv old_name new_name`: Rename a file or directory.
```bash
mv old_name new_name
```

- `mv filename /path/to/destination`: Move a file to a different directory.
```bash
mv filename /path/to/destination
```

---

### Copy a File or Directory

- `cp filename /path/to/destination`: Copy a file to a different directory.
```bash
cp filename /path/to/destination
```

- `cp -r source_directory /path/to/destination`: Copy a directory and its contents recursively.
```bash
cp -r source_directory /path/to/destination
```

---

### Display File Contents

- `cat > filename`: Add content in a file.
```bash
cat > filename
```

- `cat filename`: Display the contents of a file.
```bash
cat filename
```

---

### Print Working Directory

- `pwd`: Display the current directory.
```bash
pwd
```

---

## Resources

- [YouTube: Understanding File Permissions](https://www.youtube.com/watch?v=iwolPf6kN-k) 
- [Red Hat: Create and Delete Files and Directories in Linux](https://www.redhat.com/sysadmin/create-delete-files-directories-linux)
