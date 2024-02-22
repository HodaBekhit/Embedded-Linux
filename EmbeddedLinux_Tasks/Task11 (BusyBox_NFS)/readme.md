# Task 11 (NFS_BusyBox)

### **Objective:**

Set up an NFS server on the host machine and configure QEMU as a client to boot the root filesystem from the NFS server.

### **Steps:**

1. **Install NFS Kernel Server:**

   ```bash
   sudo apt install nfs-kernel-server
   ```

2. **Check NFS Kernel Server Status:**
   ```bash
   systemctl status nfs-kernel-server
   ```

3. **Check NFS Port Availability:**
   ```bash
   ss -tulpen | grep 2049
   ```

4. **Check NFS Kernel Module:**

   ```bash
   lsmod | grep nfs
   ```

5. **View NFS Exports Configuration:**
   ```bash
   cat /etc/exports
   ```

   The `/etc/exports` file is used to define the directories  that will be shared via NFS (Network File System) and the access  permissions for those directories. Each line in this file represents a  directory that is exported to remote clients along with the associated  options. It should be empty for now

6. **Create NFS Share Directory:**

   ```bash
   sudo mkdir /srv/nfs_share
   ```

7. **Copy rootfs dynamic Files to NFS Share:**

   ```bash
   sudo cp -rp ~/rootfs_d/* /srv/nfs_share
   ```

8. **Install Net Tools (Optional):**
   ```bash
   sudo apt install net-tools
   ```

9. **Check Network Configuration:**
   ```bash
   ifconfig
   ```

   run this command to know the server(your host machine) ip server. in my case the ip add=192.168.100.7, i will assign 192.168.100.100 to the client (qemu)

10. **Check Connectivity with Client (Optional):**

    ```bash
    ping 192.168.100.100
    ```

    run this to check that thus ip wasn't assigned to any client else.

11. **Configure NFS Export:**
    Edit the `/etc/exports` file and add the following line:

    ```
    /srv/nfs-share 192.168.100.100(rw,no_root_squash,no_subtree_check)
    ```
    This line specifies that the `/srv/nfs-share` directory will be exported, and the remote client with IP address `192.168.100.100` will have read-write (`rw`) access to it.

    The `no_root_squash` option ensures that remote root users have full access to the directory without being mapped to an anonymous user.

    The `no_subtree_check` option disables subtree checking for this export, which can improve performance in certain situations.

    Save the file.

12. **Restart NFS Kernel Server:**
    ```bash
    sudo systemctl restart nfs-kernel-server
    ```

13. **Check NFS Processes:**

    ```bash
    ps -ef | grep nfs
    ```

    the `ps -ef | grep nfs` command is useful for identifying  processes related to NFS (Network File System) by searching for any  processes whose names or descriptions contain the term "nfs".

14. **Boot QEMU with NFS Root:**

    ```bash
    sudo qemu-system-arm -M vexpress-a9 -m 128M -nographic -kernel u-boot -sd sd.img -net tap,script=./qemu-ifup -net nic
    ```

15. **Set U-Boot Environment Variables:**
    Execute the following commands in U-Boot:
    ```bash
    setenv serverip 192.168.100.7
    setenv ipaddr 192.168.100.100
    setenv bootargs 'console=ttyAMA0  root=/dev/nfs ip=192.168.100.100:::::eth0 nfsroot=192.168.100.4:/srv/nfs_share,nfsvers=3,tcp rw init=/sbin/init'
    setenv Zimag_RAM_Add 60000000
    setenv dtb_hardware_Add 65000000
    ```

16. **Save U-Boot Environment:**
    ```bash
    saveenv
    ```

17. **Load Kernel Image and Device Tree Blob:**
    Execute the following commands in U-Boot:
    ```bash
    tftp $Zimag_RAM_Add zImage
    md $Zimag_RAM_Add
    tftp $dtb_hardware_Add vexpress-v2p-ca9.dtb
    ```

18. **Set Boot Command:**
    Execute the following command in U-Boot to set the boot command:
    ```bash
    setenv bootcmd "echo "welcome back, hoda!"; tftp $Zimag_RAM_Add zImage;tftp $dtb_hardware_Add vexpress-v2p-ca9.dtb"
    ```

    you can automate the kernel load at booting step by setting the bootcmd variable by this value.

19. **Boot the System:**
    Execute the following command in U-Boot to boot the system:

    ```bash
    bootz $Zimag_RAM_Add - $dtb_hardware_Add
    ```

    By reaching this step, you have successfully launched your created  operating system by booting from the TFTP server and mounting your root  filesystem from the NFS server.

    Now let's navigate our file system, and run some commands 

    

20. **reboot**

    

21. **Shutdown QEMU:**

    ```bash
    poweroff
    ```

