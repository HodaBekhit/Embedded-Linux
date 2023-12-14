#!/bin/bash
username="Hoda"
groupname="Bekhit"

# Create the user and group
sudo useradd -m $username
sudo groupadd $groupname
sudo usermod -aG $groupname $username  

# Check if user exists
if id "$username" >/dev/null 2>&1; then
    echo "The information of the new added user:"
   sudo cat /etc/passwd | grep $username
   sudo cat /etc/shadow | grep $username
else
    echo "User not found"
fi

# Check if group exists
if grep -q "^$groupname:" /etc/group; then
    echo "The information of the new added group:"
  sudo cat /etc/group | grep $groupname
  sudo cat /etc/gshadow | grep $groupname
else
    echo "Group not found"
fi
