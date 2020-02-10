// Problem 1
// Write a CUDA program to initialize an array of size 32 to all zeros in parallel.
// Homework_5

// RUN by
// nvcc prob1.cu
// ./a.out

#include <cuda_runtime.h>
#include <stdio.h>
#include <stdlib.h>

//We use kernel function to initialize array
__global__
void initialize(int *arr, int size){
  int index = blockIdx.x * blockDim.x + threadIdx.x;
  int increment = gridDim.x * blockDim.x; 

  for (int i = index; i < size; i += increment){ 
           arr[i] = 0; 
        }
}
//loop
void print(int *ar, int size){
  printf("\n");a
  for (int i = 0; i < size; i++){
    printf("%d ", ar[i]);
  }
  printf("\n");
}


int main(void){
printf("Homework#5\nProblem 1: Initialized an array of size 32 to all zeros in parallel\n---Successfully initiated---\n---Check the Code---");

//here we declare int array
int size = 32;
int *array;
int GPU = 32;
int arraySize = size * sizeof(int);
cudaMallocManaged(&array, arraySize);
int sectors = (size + GPU - 1) / GPU;
initialize<<<sectors, GPU>>>(array, size);

// prints
print(array, size);

cudaFree(array);
cudaDeviceReset();
return 0;
}
