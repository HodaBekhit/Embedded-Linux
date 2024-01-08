# Task 6:

### objective:

1. create a sd.img of size:1GB
2. Divided to two partition: FAT partition of 200 mb /  EXT4 partition of 800 mb

3. The name of the partition are: For the 1st partition boot / For the 2nd Partition rootfs

4. Explain the usage of /dev/loop in this task.

   

   ### Steps :

   1- Create a file with 1 GB filled with zeros. (use dd command)

   2- Configure the Partition Table for the SD card

   3- Apply the following configurations 

    

   | Device  | primary / extended | bootable | type  | size |
   | ------- | ------------------ | -------- | ----- | ---- |
   | sd.img1 | Primary            | yes      | FAT16 | 200M |
   | sd.img2 | extended           | no       | Linux | 823M |

   4- To emulate the sd.img file as a sd card we need to attach it to **loop driver** to be as a **block storage**

   5- Format Partition Table: Create filesystems on the two partitions. The name of the partition are, for the 1st partition boot / For the 2nd Partition rootfs

   6- Mount and umount partitions 

   

   ### the usage of /dev/loop in this task.

The `/dev/loop` devices are loop devices that allow a regular file to be accessed as a block device. The `-P` option in the `losetup` command tells it to scan for partitions. After using `losetup` to associate the file (`sd.img`) with a loop device (`/dev/loop14), you can then treat `/dev/loop14p1` and `/dev/loop14p2` as if they were separate block devices corresponding to the two partitions.

