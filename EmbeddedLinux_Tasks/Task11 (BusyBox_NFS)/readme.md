# Task 11 (NFS_BusyBox)

### **Objective:**

Set up an NFS server on the host machine and configure QEMU as a client to boot the root filesystem from the NFS server.

### **Steps:**

1. **Install NFS Kernel Server:**

   ```bash
   sudo apt install nfs-kernel-server
   ```
![Screenshot from 2024-02-16 03-38-42](https://github.com/HodaBekhit/Embedded-Linux/assets/151033711/627f2a11-4d64-413a-9955-0c308c6eaceb)

2. **Check NFS Kernel Server Status:**
   ```bash
   systemctl status nfs-kernel-server
   ```
![Screenshot from 2024-02-16 03-39-14](https://github.com/HodaBekhit/Embedded-Linux/assets/151033711/6cb51e51-86d3-4c02-8a45-55c8ed9f32e8)

3. **Check NFS Port Availability:**
   ```bash
   ss -tulpen | grep 2049
   ```
![Screenshot from 2024-02-16 03-41-56](https://github.com/HodaBekhit/Embedded-Linux/assets/151033711/4bfc74c3-6afe-4264-bacf-08381f6628ec)

4. **Check NFS Kernel Module:**

   ```bash
   lsmod | grep nfs
   ```
![Screenshot from 2024-02-16 03-42-20](https://github.com/HodaBekhit/Embedded-Linux/assets/151033711/9641667c-0f61-47c1-ab3d-e0ca638b0c8b)

5. **View NFS Exports Configuration:**
   ```bash
   cat /etc/exports
   ```

   The `/etc/exports` file is used to define the directories  that will be shared via NFS (Network File System) and the access  permissions for those directories. Each line in this file represents a  directory that is exported to remote clients along with the associated  options. It should be empty for now
![Screenshot from 2024-02-16 03-42-37](https://github.com/HodaBekhit/Embedded-Linux/assets/151033711/73507aa8-5b56-4039-b2b6-4c4a07ac7912)

6. **Create NFS Share Directory:**

   ```bash
   sudo mkdir /srv/nfs_share
   ```
![Screenshot from 2024-02-22 17-55-58](https://github.com/HodaBekhit/Embedded-Linux/assets/151033711/2f389c96-338b-4ef3-8be9-9a28fb939e1f)

7. **Copy rootfs dynamic Files to NFS Share:**

   ```bash
   sudo cp -rp ~/rootfs_d/* /srv/nfs_share
   ```
![Screenshot from 2024-02-22 18-06-21](https://github.com/HodaBekhit/Embedded-Linux/assets/151033711/9a980eef-7cfc-48d2-817f-8dd0b736e8a5)


8. **Install Net Tools :**
   ```bash
   sudo apt install net-tools
   ```
![Screenshot from 2024-02-22 18-07-15](https://github.com/HodaBekhit/Embedded-Linux/assets/151033711/dad56ae8-a7b2-44e0-b43b-0a99f9d15f87)

9. **Check Network Configuration:**
   ```bash
   ifconfig
   ```

   run this command to know the server(your host machine) ip server. in my case the ip add=192.168.100.7, i will assign 192.168.100.100 to the client (qemu)
![Screenshot from 2024-02-22 18-08-39](https://github.com/HodaBekhit/Embedded-Linux/assets/151033711/71f6daaf-fc2a-48ec-bd4a-0bf6c949a6f8)

10. **Check Connectivity with Client (Optional):**

    ```bash
    ping 192.168.100.100
    ```

    run this to check that the chosen ip wasn't assigned to any client else.
![Screenshot from 2024-02-22 18-15-50](https://github.com/HodaBekhit/Embedded-Linux/assets/151033711/f0f0ddbb-8ff4-4534-8d8a-019fd198239c)

11. **Configure NFS Export:**
    Edit the `/etc/exports` file and add the following line:

    ```
    /srv/nfs-share 192.168.100.100(rw,no_root_squash,no_subtree_check)
    ```
    This line specifies that the `/srv/nfs-share` directory will be exported, and the remote client with IP address `192.168.100.100` will have read-write (`rw`) access to it.

    The `no_root_squash` option ensures that remote root users have full access to the directory without being mapped to an anonymous user.

    The `no_subtree_check` option disables subtree checking for this export, which can improve performance in certain situations.

    Save the file.
![Screenshot from 2024-02-22 18-22-02](https://github.com/HodaBekhit/Embedded-Linux/assets/151033711/630ba068-92dc-437f-a468-aafea5949c66)

12. **Restart NFS Kernel Server:**
    ```bash
    sudo systemctl restart nfs-kernel-server
    ```
![Screenshot from 2024-02-22 18-24-35](https://github.com/HodaBekhit/Embedded-Linux/assets/151033711/6add1fd5-3737-4e02-bcf0-daf404e73af7)

13. **Check NFS Processes:**

    ```bash
    ps -ef | grep nfs
    ```

    the `ps -ef | grep nfs` command is useful for identifying  processes related to NFS (Network File System) by searching for any  processes whose names or descriptions contain the term "nfs".
![Screenshot from 2024-02-22 18-26-13](https://github.com/HodaBekhit/Embedded-Linux/assets/151033711/452864e1-411a-4145-adf6-bff497cfc0ca)

14. **Boot QEMU with NFS Root:**

    ```bash
    sudo qemu-system-arm -M vexpress-a9 -m 128M -nographic -kernel u-boot -sd sd.img -net tap,script=./qemu-ifup -net nic
    ```
![Screenshot from 2024-02-22 18-29-42](https://github.com/HodaBekhit/Embedded-Linux/assets/151033711/e7491633-a9e7-42e8-b0d5-c07888bef7f7)

15. **Set U-Boot Environment Variables:**
    Execute the following commands in U-Boot:
    ```bash
    setenv serverip 192.168.100.7
    setenv ipaddr 192.168.100.100
    setenv bootargs 'console=ttyAMA0  root=/dev/nfs ip=192.168.100.100:::::eth0 nfsroot=192.168.100.4:/srv/nfs_share,nfsvers=3,tcp rw init=/sbin/init'
    setenv Zimag_RAM_Add 60000000
    setenv dtb_hardware_Add 65000000
    ```
![Screenshot from 2024-02-22 18-32-49](https://github.com/HodaBekhit/Embedded-Linux/assets/151033711/79ef58cc-bd42-4d76-aea7-23915d289f2e)
![Screenshot from 2024-02-22 18-37-26](https://github.com/HodaBekhit/Embedded-Linux/assets/151033711/818ffb7d-07ca-43c2-8a46-c417fdc04916)
![Screenshot from 2024-02-22 18-38-54](https://github.com/HodaBekhit/Embedded-Linux/assets/151033711/815e59dc-7be5-43b9-baa2-e08356c8232d)

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
![Screenshot from 2024-02-22 18-39-41](https://github.com/HodaBekhit/Embedded-Linux/assets/151033711/024c365b-94fe-4d7b-8b76-2b548f43fb47)
![Screenshot from 2024-02-22 18-41-18](https://github.com/HodaBekhit/Embedded-Linux/assets/151033711/4b5d3a55-a91c-4a4e-bf22-e0a8194b2c36)

18. **Set Boot Command:**
    Execute the following command in U-Boot to set the boot command:
    ```bash
    setenv bootcmd "echo "welcome back, hoda!"; tftp $Zimag_RAM_Add zImage;tftp $dtb_hardware_Add vexpress-v2p-ca9.dtb"
    ```
![Screenshot from 2024-02-22 18-43-38](https://github.com/HodaBekhit/Embedded-Linux/assets/151033711/460bc4a6-e5ff-45a7-94aa-8914965c2308)


    you can automate the kernel load at booting step by setting the bootcmd variable by this value.

19. **Boot the System:**
    Execute the following command in U-Boot to boot the system:

    ```bash
    bootz $Zimag_RAM_Add - $dtb_hardware_Add
    ```

    **By reaching this step, you have successfully launched your created  operating system by booting from the TFTP server and mounting your root  filesystem from the NFS server.**
    

    Now let's navigate our file system, and run some commands 

![Screenshot from 2024-02-22 18-53-55](https://github.com/HodaBekhit/Embedded-Linux/assets/151033711/71d4c097-de9a-4384-8a19-1987a9d7c410)


21. **reboot**
![Screenshot from 2024-02-22 18-54-51](https://github.com/HodaBekhit/Embedded-Linux/assets/151033711/caca3fe9-e80e-41e9-acae-1059acf010c3)

    

22. **Shutdown QEMU:**

    ```bash
    poweroff
    ```
![Screenshot from 2024-02-22 19-11-26](https://github.com/HodaBekhit/Embedded-Linux/assets/151033711/2c747c8f-49bd-4475-8ff1-1aac551deded)

