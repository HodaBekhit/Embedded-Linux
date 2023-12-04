#!/bin/bash
echo $USER
echo $HOSTNAME

if [ -d /home/hodaahmed/exam_directory ]
then
echo "exam_directory is present"

if  [  -f ~/exam_directory/*. ] 
then 
echo "files present"
cd /home/hodaahmed/exam_directory 
ls -lh

else   
echo "files  not present"
cd /home/hodaahmed/exam_directory 
touch file1.txt file2.txt file3.txt
echo "three files are touched"
fi        

else
echo "exam_directory is not present"
mkdir /home/hodaahmed/exam_directory
echo "exam diectory is created"
cd /home/hodaahmed/exam_directory
touch file1.txt file2.txt file3.txt
echo "created three files inside the diectory"
fi


