#include <stdio.h>

int binary_search(int* arr,int size,int key);

int main()
{
int arr[]={2,4,5,6,12,20};
int size=sizeof(arr)/sizeof(arr[0]);
int key=5;
int result=binary_search(arr,size,key);
if(result!=-1)
{
printf("index of %d :%d \n",key,result);
}
else
{
printf("result not found");
}
return 0;
}

int binary_search(int*arr,int size,int key)
{
int low=0;
int high=size-1;
while(low<=high)
{
int mid=(low+high)/2;
if(arr[mid]==key)
{
return mid;
}
else if(arr[mid]<key)
{
low=mid-1;
}
else
{
high=mid-1;
}
}
return -1;
}
