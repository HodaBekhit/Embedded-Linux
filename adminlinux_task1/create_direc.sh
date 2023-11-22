#!/bin/bash

# Step 1: Create "myDirectory" in the home folder
mkdir ~/myDirectory

# Step 2: Create "secondDirectory" inside "myDirectory"
mkdir ~/myDirectory/secondDirectory

# Step 3: Create "myNotePaper"file  inside "secondDirectory"
touch ~/myDirectory/secondDirectory/myNotePaper

# Step 4: Copy "myNotePaper" from "secondDirectory" to "myDirectory"
cp ~/myDirectory/secondDirectory/myNotePaper  ~/myDirectory

# Step 5: rename the copied file in"myDirectory" to "MyOldNotePaper"
mv ~/myDirectory/myNotePaper ~/myDirectory/myOldPaper
