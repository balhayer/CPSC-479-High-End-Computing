// Homework 5 
// Problem_2
// Change the array size to 1024

// RUN as:
// nvcc prob2.cu

#include <cuda_runtime.h>
#include <stdio.h>
#include <stdlib.h>

//This is kernel function to initialize array
__global__
void initialize(int *arr, int size){
  int indexing = blockIdx.x * blockDim.x + threadIdx.x;
  int increment = gridDim.x * blockDim.x; 

  for (int i = indexing; i < size; i += increment){ 
           arr[i] = 0; 
        }
}

// loop
void print(int *ar, int size){
  printf("\n");
  for (int i = 0; i < size; i++){
    printf("%d ", ar[i]);
  }
  printf("\n");
}


int main(void){
printf("Homework#4\nProblem 2: Change the array size to 1024 in Problem_1\n---Successfully initiated---\n---Check the code---");

//we declare int array
int size = 1024;
int *array;
int GPU = 32;
int arraySize = size * sizeof(int);
cudaMallocManaged(&array, arraySize);
int sectors = (size + GPU - 1) / GPU;
initialize<<<sectors, GPU>>>(array, size);


//prints
print(array, size);

cudaFree(array);
cudaDeviceReset();
return 0;
}
