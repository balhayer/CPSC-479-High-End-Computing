// Homework_5
// Problem_4 
// change the array size to 8000. Check if answer to problem 3 still works.

// RUN as
// nvcc prob4.cu
// ./a.out

#include <cuda_runtime.h>
#include <stdio.h>
#include <stdlib.h>

//Kernel function to initialize array
__global__
void initialize(int *arr, int size){
  int sectors = blockIdx.x * blockDim.x + threadIdx.x;
  int increment = gridDim.x * blockDim.x; 

  for (int i = sectors; i < size; i += increment){ 
           arr[i] = 0; 
        }
}

//add kernel function to add i to a[i]
__global__
void addIValue(int *arr, int size){
  int sectors = blockIdx.x * blockDim.x + threadIdx.x;
  int increment = gridDim.x * blockDim.x;

  for (int i = sectors; i < size; i+= increment){ 
         arr[i] += i; 
      }
}

//loop
void print(int *ar, int size){
  printf("\n");
  for (int i = 0; i < size; i++){
    printf("%d ", ar[i]);
  }
  printf("\n");
}

// it prints out message of running
int main(void){
printf("Homework#5\nProblem 4:Change the array size to 8000. Check if answer to problem 3 still works\n---Successfully initiated---\n---Check the code---");

//here declare int array
int size = 8000;
int *array;
int GPU = 32;
int arraySize = size * sizeof(int);
cudaMallocManaged(&array, arraySize);
int blocks = (size + GPU - 1) / GPU;
initialize<<<blocks, GPU>>>(array, size);

//here add value of i to array 
addIValue<<<blocks, GPU>>>(array, size);
cudaDeviceSynchronize();

print(array, size);

cudaFree(array);
cudaDeviceReset();
return 0;
}
