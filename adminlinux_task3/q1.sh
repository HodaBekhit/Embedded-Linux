#!/bin/bash

# Check if .bashrc file exists
if [[ -f ~/.bashrc ]]; then
  echo ".bashrc file exists"
  
  # Append new environment variables
  echo "export HELLO=$HOSTNAME" >> ~/.bashrc
  echo "LOCAL=$(whoami)" >> ~/.bashrc
  
  # Source the updated .bashrc file
  source ~/.bashrc

else
  echo ".bashrc file does not exist"
fi

# Open another terminal
  gnome-terminal
