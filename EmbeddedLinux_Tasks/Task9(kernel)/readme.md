# Task9: (Kernel)

### Objective :

1. ***configure the kernel image*** 
2. ***copy image and dtb file to tftp server***
3. ***boot from tftp server*** 

### Steps:

1-  **Download Linux Kernel**

**2-  Configure the Kernel to specific Target (Vexpress a9) and kernel version** 

**3-  Export the compiler and the architecture used** 

**4-  configure the kernel with the configuration below:**

this configuration must be checked

-  Enable **devtmpfs**
-  Change kernel compression to **XZ**
-  Change your kernel local version to your name and append on it -v1.0

**5- Build the kernel**

**6-  Compile kernel modules and organize them in a specific directory within a root filesystem**

**7- Copy the zImage and dtb file to the tftp server**

**8- Start Qemu to boot on U-boot**

**9- Set the bootargs to:** 

**10- load kernel image `zImage` and DTB `vexpress-v2p-ca9.dtb` from TFTP into RAM**

**11- boot the kernel with its device tree**



\########## THE KERNEL WILL NOT BOOT IT WILL **PANIC** ###########