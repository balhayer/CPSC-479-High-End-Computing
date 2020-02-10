// Homework #3
// Balwinder Singh Hayer


// Commands to run under MPI

//mpicc -o hw hw.c
//mpirun -np 8 ./hw

#include <mpi.h>
#include <stdio.h>
#include <stdlib.h>
int main(int argc, char** argv) {

        int rank,size,i=0;

        int *dataset, localdata, localrecv;
        //declared static array from the problem
        int local_array[10] = {3,1,7,1,4,1,6,3};

        int StartingDex[10], EndingDex[10];

        const int root=0;

        MPI_Init(&argc, &argv);
        MPI_Comm_rank(MPI_COMM_WORLD, &rank);
        MPI_Comm_size(MPI_COMM_WORLD, &size);

        i = rank;
        localdata = local_array[i];
        printf("[Process %d]: has data %d\n", rank, localdata);



        //MPI_Scan(sendbuf,recvbuf, count, MPI_INT, MPI_SUM, MPI_COMM_WORLD);
        MPI_Scan(&localdata,&localrecv, 1, MPI_INT, MPI_SUM, MPI_COMM_WORLD);
        MPI_Barrier(MPI_COMM_WORLD);

        //Calcualting starting and ending index for each process
        EndingDex[rank] = localrecv;
        StartingDex[rank] = ((EndingDex[rank] - localdata) + 1);
        printf("Process %d will receive the array portion between index %d - %d \n", rank, StartingDex[rank] , 	EndingDex[rank]);

        MPI_Finalize();
        return 0;

}

//OUTPUT:

//Process 7 will receive the array portion between index 24 - 26 
//Process 5 will receive the array portion between index 17 - 17 
//Process 1 will receive the array portion between index 4 - 4 
//Process 3 will receive the array portion between index 12 - 12 
//Process 6 will receive the array portion between index 18 - 23 
//Process 4 will receive the array portion between index 13 - 16 
//Process 0 will receive the array portion between index 1 - 3 
//Process 2 will receive the array portion between index 5 - 11 



