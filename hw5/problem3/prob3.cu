// Homework_5
// Problem_3 
// create another kernel that adds i to array[i]

// RUN as:
// nvcc prob3.cu
// ./a.out

#include <cuda_runtime.h>
#include <stdio.h>
#include <stdlib.h>

//Kernel function to initialize array
__global__
void initialize(int *arr, int size){
  int indexing = blockIdx.x * blockDim.x + threadIdx.x;
  int increment = gridDim.x * blockDim.x; 
	//loop for index then increment
  for (int i = indexing; i < size; i += increment){ 
           arr[i] = 0; 
        }
}

//Kernel function to add i to a[i]
__global__
void add_I_Value(int *arr, int size){
  int indexing = blockIdx.x * blockDim.x + threadIdx.x;
  int increment = gridDim.x * blockDim.x;

  for (int i = indexing; i < size; i+= increment){ 
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


int main(void){
printf("Homework#5\nProblem 3: create another kernel that adds i to array[i]\n---Successfully initiated---\n---Check the code---");

//here we declare int array
int size = 1024;
int *array;
int gpuThread = 32;
int arraySize = size * sizeof(int);
cudaMallocManaged(&array, arraySize);
int sectors = (size + gpuThread - 1) / gpuThread;
initialize<<<sectors, gpuThread>>>(array, size);

//here we add value of i to array 
add_I_Value<<<sectors, gpuThread>>>(array, size);
cudaDeviceSynchronize();

//prints the array and takes the size
print(array, size);

cudaFree(array);
cudaDeviceReset();
return 0;
}
