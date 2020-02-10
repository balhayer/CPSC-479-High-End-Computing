// execute by typing nvcc que1.cu
// ./a.out

#include <stdio.h>
#include <cuda.h>
#define N 32

__global__ void initArray(int *arr)
{
    int tidx = threadIdx.x + blockDim.x * blockIdx.x;
    arr[tidx] = tidx;
}
__global__ void square (int *matrix,  int *result, int matrixsize) {
    int id = blockIdx.x * blockDim.x + threadIdx.x;
    int ii = id / matrixsize;
    int jj = id % matrixsize;
    int index = ii * matrixsize + jj;

    for (int kk = 0; kk < matrixsize; ++kk) {
        int ix = ii * matrixsize + kk;
        int jx = kk * matrixsize + jj;
        int r = matrix[ix] * matrix[jx];
        printf("Mresult_arr[%d] = %d\n", index, r);
        printf("ix = %d; jx = ;\n", ix, jx);

        result[index] += kk;
    }
}

int main()
{
    int *arr; 
    int *result_arr; 
    int *d_arr; 
    int *d_result_arr; 
    int raw_size = (N * 2);
    int size = raw_size * sizeof(int); 
    arr = (int *)malloc(size);
    result_arr = (int *)malloc(size);
    cudaMalloc((void **)&d_arr, size);
    cudaMalloc((void **)&d_result_arr, size);

    initArray<<<raw_size,1>>>(d_arr);
    square<<<raw_size,1>>>(d_arr, d_result_arr, raw_size);
    cudaMemcpy(result_arr, d_result_arr, size, cudaMemcpyDeviceToHost);
    free(arr);
    cudaFree(d_arr);
    return 0;
}

