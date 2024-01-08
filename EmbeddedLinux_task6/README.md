# Task 6:

### objective:

1. create a sd.img of size:1GB
2. Divided to two partition: FAT partition of 200 mb /  EXT4 partition of 800 mb
3. The name of the partition are: For the 1st partition boot / For the 2nd Partition rootfs
4. Explain the usage of /dev/loop in this task.

   

   ### Steps :

   1- Create a file with 1 GB filled with zeros. (use dd command)
![Screenshot from 2024-01-08 23-05-58](https://github.com/HodaBekhit/Embedded-Linux/assets/151033711/292fa449-0def-4f04-b9e8-742a7f61c6c5)

   2- Configure the Partition Table for the SD card
![Screenshot from 2024-01-08 23-06-14](https://github.com/HodaBekhit/Embedded-Linux/assets/151033711/19a46bcd-4e29-4c54-8bd4-0b7bad73132e)

   3- Apply the following configurations 

    ![Screenshot from 2024-01-08 15-27-13](https://github.com/HodaBekhit/Embedded-Linux/assets/151033711/aba17c30-a843-4df3-99ab-b0a9675e12c4)


   | Device  | primary / extended | bootable | type  | size |
   | ------- | ------------------ | -------- | ----- | ---- |
   | sd.img1 | Primary            | yes      | FAT16 | 200M |
   | sd.img2 | extended           | no       | Linux | 823M |

   4- To emulate the sd.img file as a sd card we need to attach it to **loop driver** to be as a **block storage**, as shown the sd is attached to loop14
![Screenshot from 2024-01-08 15-37-26](https://github.com/HodaBekhit/Embedded-Linux/assets/151033711/b142ca59-99dc-46a6-b66e-4f08a386290b)

   5- Format Partition Table: Create filesystems on the two partitions. The name of the partition are, for the 1st partition boot / For the 2nd Partition rootfs
![Screenshot from 2024-01-08 15-37-39](https://github.com/HodaBekhit/Embedded-Linux/assets/151033711/65b42aac-31d9-4f56-9a93-132dd7eaccbd)

   6- Mount and umount partitions 

   ![Screenshot from 2024-01-08 15-58-54](https://github.com/HodaBekhit/Embedded-Linux/assets/151033711/812fb77a-c48c-4f1b-86cb-3f4fdd699248)
![Screenshot from 2024-01-08 15-59-07](https://github.com/HodaBekhit/Embedded-Linux/assets/151033711/f5b0ce22-da13-45c7-b3e5-f8856b4ae358)

![Screenshot from 2024-01-08 16-00-20](https://github.com/HodaBekhit/Embedded-Linux/assets/151033711/98ec48ed-c0ba-4a3b-a621-9338ff11badf)

   ### the usage of /dev/loop in this task.

The `/dev/loop` devices are loop devices that allow a regular file to be accessed as a block device. The `-P` option in the `losetup` command tells it to scan for partitions. After using `losetup` to associate the file (`sd.img`) with a loop device (`/dev/loop14), you can then treat `/dev/loop14p1` and `/dev/loop14p2` as if they were separate block devices corresponding to the two partitions.

