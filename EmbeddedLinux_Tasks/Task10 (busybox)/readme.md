# Task 10 (busybox)

### Objectives:

Create a Linux image root filesystem using statically  and dynamically built BusyBox for an ARM architecture system.

#### <u>busybox statically compiled</u>

### Steps:

1. **Clone BusyBox Repository:**
   
   ```bash
   git clone https://github.com/mirror/busybox.git
   ```
   
   
2. **Set Cross-Compiler and Architecture:**
   
   ```bash
   export CROSS_COMPILE=path/to/compiler/arm-cortexa9_neon-linux-musleabihf-
   export ARCH=arm
   ```
   
   
3. **Configure BusyBox:**
   ```bash
   make menuconfig
   ```
   This command opens the configuration menu for BusyBox where you can select desired features.

   select build static library
   
4. **Compile BusyBox with selected configurations:**
   
   ```bash
   make
   ```
   
   
5. **Install BusyBox:**
   ```bash
   make install
   ```
   

6. **View Installed Files:**
   
   ```bash
   ls -l _install/
   ```
   This command lists the binary files installed by BusyBox, that will be copied to my rootfs. since that the busybox is statically compiled,the files copied here contains the executable binaries and their libraries.
   
7. **Create Root Filesystem Directory:**
   
   ```bash
   mkdir rootfs_static
   ```
   
   
8. **Copy BusyBox Files to rootfs_static:**
   
   ```bash
   rsync -av ~/busybox/_install/* ~/rootfs_static/
   ```
   
   
9. **Copy Dynamic Kernel Modules to Root Filesystem:**
   
   ```bash
   cp -rp ~/rootfs/* ~/rootfs_static
   ```
   
   
10. **Create Directory Structure:**
    ```bash
    mkdir boot dev etc home mnt proc root srv sys
    ```
    some of these directories will be filled by kernel during booting 

11. **Create init.d Directory and rcS Script:**
    
    ```bash
    mkdir etc/init.d
    touch etc/init.d/rcS
    vim etc/init.d/rcS
    chmod +x etc/init.d/rcS
    ```
    These commands create a directory for init scripts and a script named `rcS` for system initialization.
    
12. **Create and Edit inittab File:**
    ```bash
    touch etc/inittab
    vim etc/inittab
    ```
    These commands create and edit the `inittab` file which is configuration file used by the init process on Linux OS to determine the behavior of the system initialization process. The`inittab` file is responsible for run some initialization scripts.

13. **View Root Filesystem Contents:**
    
    ```bash
    ls -lh ~/rootfs_static
    ```
    
    
14. **Set Ownership of Root Filesystem:**
    ```bash
    sudo chown -R root:root ~/rootfs_static
    ```
    the created rootfs hold the ownership of user "hodaahmed" and this user is not known for the target machine which will hold the rootfs, so this command sets the ownership of the root filesystem directory to `root:root`.

15. **Mount SD Card Image:**
    ```bash
    sudo losetup -f --show --partscan sd.img
    sudo mkdir /media/hodaahmed/rootfs
    sudo mount -o rw /dev/loop17p2 /media/hodaahmed/rootfs
    ```
    These commands mount the SD card image to a directory for further modifications.

16. **Copy Root Filesystem to  rootfs partation at mounted SD Card Image**
    
    ```bash
    cp -rp ~/rootfs_static/* /media/hodaahmed/rootfs
    ```
    
    
17. **Copy Kernel Image to Boot Partition:**
    
    ```bash
    sudo cp ~/linux/arch/arm/boot/zImage /media/hodaahmed/boot/
    ```
    
    
19. **Copy dtb file to Boot Partition:**
    
    ```bash
    sudo cp ~/linux/arch/arm/boot/dts/arm/*-ca9.dtb /media/hodaahmed/boot
    ```
    
    
20. **Boot with QEMU:**
    ```bash
    qemu-system-arm -M vexpress-a9 -m 128M -nographic -kernel u-boot -sd sd.img
    ```
    

21. **Set Environment Variables in U-Boot:**
    ```bash
    setenv bootargs 'console=ttyAMA0 root=/dev/mmcblk0p2 rootfstype=ext4 rw rootwait init=/sbin/init'
    setenv Zimag_RAM_Add 0x60000000
    setenv dtb_hardware_Add 0x65000000
    ```
    These commands set environment variables in U-Boot for boot arguments and memory addresses. 

    bootargs: this command sets the boot arguments that will be used by the Linux  kernel during the boot process, including parameters such as the console device, root filesystem device, filesystem type, and the path to the  init process.
    
    
    
22. **Load Kernel Image and dtb in U-Boot:**
    
    ```bash
    fatload mmc 0:1 $Zimage_RAMAdd zImage
    md $Zimage_RAMAdd
    fatload mmc 0:1 $dtb_hardwareAdd vexpress-v2p-ca9.dtb
    md $dtb_hardwareAdd
    ```
    
    
23. **Boot the System in U-Boot:**
    ```bash
    bootz $Zimage_RAMAdd - $dtb_hardwareAdd
    ```
    This command boots the system using the loaded kernel image and dtb in U-Boot.
    
    #### kernel panic will not appear, and the systems boot successfully 
    
    Now you are in the target machine rootfs, let's navigate it and try out some commands to ensure that the created rootfs_static is found and running.
    
    
    
    

#### <u>busybox dynamically  compiled</u>

#### Steps:

1. **Repeat what you have done in busybox static until step 3** 

2. **Configure BusyBox:**
   ```bash
   make menuconfig
   ```
   This command opens the configuration menu for BusyBox where you should uncheck the static library options.

3. **Repeat step 4/5/6**

4. **Create Root Filesystem Directory:**
   ```bash
   cd ~
   mkdir rootfs_d
   ```
   This command creates a directory to hold the dynamic root filesystem.

5. **Copy BusyBox Files:**
   ```bash
   cp -rp ~/busybox/_install/* ~/rootfs_d/
   ```
   This command copies BusyBox files, including the binary, to the dynamic  root filesystem directory. However, in the case of dynamically compiled  BusyBox, the required libraries are not included in the BusyBox binary.  Instead, they need to be copied manually from the sysroot directory  where they are located. 

6. **Create Directory Structure:**
   ```bash
   cd rootfs_d
   mkdir boot dev etc home mnt proc root srv sys
   ```
   

7. **Copy Libraries and Includes:**
   ```bash
   cd ~/x-tools/arm-cortexa9_neon-linux-musleabihf/arm-cortexa9_neon-linux-musleabihf/sysroot
   cp -rp ./lib/ ~/rootfs_Dynamic/
   cp -rp ./usr/lib/ ~/rootfs_Dynamic/usr/
   cp -rp ./usr/include/ ~/rootfs_Dynamic/usr/
   ```
   These commands copy necessary libraries and includes to the dynamic root filesystem.

8. **Repeat the same static busybox steps from step 9 to 22** 

   Let's navigate our rootfs 

   

   
