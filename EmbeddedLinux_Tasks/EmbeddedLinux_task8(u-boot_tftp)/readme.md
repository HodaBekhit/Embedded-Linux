# Task 8: (uboot_tftp)

### Objectives:

##### Install a TFTP server and utilize it for booting. The TFTP server will  later be employed to load the kernel image and device tree file from it  to RAM during the boot process.

### Steps:

#### <u>Set up a TFTP server, configure its options</u>

1. **switch to root** 

2. **install tftp server package on linux** 

3. **Lists the network interfaces and their respective IP addresses. You'll need this information later.**

4. **Change TFTP Configuration:**

   ```
   bash
   nano /etc/default/tftpd-hpa
   ```

   Opens the configuration file for the TFTP server. Inside the file, set the TFTP options:

   ```
   bash
   TFTP_OPTIONS="--secure --create"
   ```

   Save the file.

   5. **Restarts the TFTP server to apply the new configuration.**

   6. **Verifies the status of the TFTP server to ensure it is running without errors.**

   7. **Changes the ownership of the TFTP server directory (`/srv/tftp`) to the `tftp` user and group.**

   8. **Create 2 files into `tftp` directory (`/srv/tftp`).**                                                                                                                                                                               the files are zimage and hardware.dtb, these are not the real kernel image file, we are just using them here for tftp testing.

   9. **open files and write any thing inside them** 

      #### <u>Connect the Server (computer) with the target (qemu)</u>

   10. **We need to Create a script `qemu-ifup`**

       This script is executed to configure the Server network interface (TAP). Write your server(pc) ip in the script ( you should know your server ip at step 3)

   11. **Save the script qemu-ifup in the u-boot** 

   12. **Make the script executable: `chmod +x qemu-ifup`.**

   13. **Start Qemu**

       In order to start Qemu with the tftp configuration , write the following command 

       note: the uboot will be load from the sd.img not from the tftp server because u-boot will be needed initially for the network (tftp) initialization , so it is not logical to make tftp load u-boot. 

       ### <u>Set U-boot environment variables</u>

   14. **Set the server ip address that we get from step 3**

   15. **Apply ip address for embedded device ((Apply IP address bigger than server))**

   16. **Now write the following script to Load the files from the TFTP Server or SD card to target RAM**

       we used if condition here to check for the files existence on sd and tftp server 

       

       

       
       
       