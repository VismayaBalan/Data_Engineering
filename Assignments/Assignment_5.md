# Big Data (HDFS) Assignment

## Problem Statement: Using Command line of HDFS, perform following tasks.

### a) Create a directory /hadoop/hdfs/ in HDFS
```bash
hdfs dfs -mkdir /hadoop
hdfs dfs -mkdir /hadoop/hdfs/
```
![alt text](Assignment_5_Outputs/img1.PNG "Title")

![alt text](Assignment_5_Outputs/img2.PNG "Title")

### b) Create a temp directory in Hadoop. Run HDFS command to delete “temp” directory.
```bash
hdfs dfs -mkdir /temp
hdfs dfs -rm -r /temp
```
![alt text](Assignment_5_Outputs/img3.PNG "Title")

### c) List all the files/directories for the given hdfs destination path.
```bash
hdfs dfs -ls <HDFS_PATH>
```
#### To list the contents of the /user/hadoop directory:
```bash
hdfs dfs -ls /user/hadoop 
```
![alt text](Assignment_5_Outputs/img4.PNG "Title")

### d) Command that will list the directories in /hadoop folder.
```bash
hdfs dfs -ls /hadoop | grep '^d'
```
![alt text](Assignment_5_Outputs/img5.PNG "Title")

### e) Command to list recursively all files in hadoop directory and all subdirectories in hadoop directory
```bash
hdfs dfs -ls -R /hadoop
```
![alt text](Assignment_5_Outputs/img6.PNG "Title")

### f) List all the directory inside /hadoop/hdfs/ directory which starts with &#39;dir&#39;.
```bash
hdfs dfs -ls /hadoop/hdfs/ | grep '^d.* dir'
```
![alt text](image-5.png)

### g) Create a temp.txt file. Copies this file from local file system to HDFS
```bash
echo "Hi, This is Vismaya" > temp.txt
```
```bash
hdfs dfs -put temp.txt /hadoop/hdfs/
```
![alt text](Assignment_5_Outputs/img8.PNG "Title")

### h) Copies the file from HDFS to local file system.
```bash
hdfs dfs -get /hadoop/hdfs/temp.txt /home/hadoop/Downloads/
```
![alt text](image.png)


### i) Command to copy from local directory with the source being restricted to a local file reference.
```bash
hdfs dfs -put /home/hadoop/Downloads/Harry_Potter_and_the _Deathly_Hallows.txt /hadoop/hdfs
```
![alt text](image-1.png)

### j) Command to copies to local directory with the source being restricted to a local file reference.
```bash
hdfs dfs -get /hadoop/hdfs/Harry_Potter_and_the _Deathly_Hallows.txt /home/hadoop/Desktop/
```
![alt text](image-2.png)

### k) Command to move from local directory source to Hadoop directory.
```bash
hdfs dfs -moveFromLocal /home/hadoop/Desktop/Harry_Potter_and_the _Deathly_Hallows.txt /hadoop/
```
![alt text](image-3.png)
![alt text](image-4.png)

### l) Deletes the directory and any content under it recursively.
```bash
hdfs dfs -rm -r /hadoop/hdfs
```
![alt text](image-6.png)

### m) List the files and show Format file sizes in a human-readable fashion.
```bash
hdfs dfs -ls -h /hadoop/
```
![alt text](image-7.png)

### n) Take a source file and outputs the file in text format on the terminal.
```bash
hdfs dfs -cat /hadoop/sample.txt
```

![alt text](image-8.png)

### o) Display the content of the HDFS file test on your /user/hadoop2 directory.
```bash
hdfs dfs -cat /user/hadoop/test1.txt
```
![alt text](image-9.png)

### p) Append the content of a local file test1 to a hdfs file test2.
```bash
hdfs dfs -appendToFile test2.txt /user/hadoop/test1.txt
```
![alt text](image-11.png)
![alt text](image-10.png)
### q) Show the capacity, free and used space of the filesystem

![alt text](image-12.png)

### r) Shows the capacity, free and used space of the filesystem. Add parameter Formats the sizes of files in a human-readable fashion.
![alt text](image-13.png)

### s) Show the amount of space, in bytes, used by the files that match the specified file pattern.

![alt text](image-14.png)

### t) Show the amount of space, in bytes, used by the files that match the specified file pattern. Formats the sizes of files in a human-readable fashion.

![alt text](image-15.png)

### u) Check the health of the Hadoop file system.

![alt text](image-16.png)

### v) Command to turn off the safemode of Name Node.
```bash
hdfs dfsadmin -safemode leave
```
![alt text](image-22.png)
### w) HDFS command to format NameNode.
```bash
hdfs namenode -format
```

### x) Create a file named hdfstest.txt and change it number of replications to 3.
```bash
hdfs dfs -put hdfstest.txt /user/hadoop/
hdfs dfs -setrep 3 /user/hadoop/hdfstest.txt
```
![alt text](image-18.png)
![alt text](image-17.png)

### y) Write command to display number of replicas for hdfstest.txt file.
```bash
hdfs dfs -stat %r /user/hadoop/hdfstest.txt
```
![alt text](image-19.png)

### z) Write command to Display the status of file “hdfstest.txt” like block size, filesize in bytes.
```bash
hdfs dfs -stat "%b %o" /user/hadoop/hdfstest.txt
```
![alt text](image-20.png)

### aa) Write HDFS command to change file permission from rw – r – r to rwx-rw-x for hdfstest.txt.
```bash
hdfs dfs -chmod 761 /user/hadoop/hdfstest.txt
```
![alt text](image-21.png)