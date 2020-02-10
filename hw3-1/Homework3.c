//mpicc -o test try.c
//mpirun -np 4 ./try

#include <mpi.h>
#include <stdio.h>
#include <stdlib.h>

int main(int argc, char **argv) {
    int size, rank;

    MPI_Init(&argc, &argv);
    MPI_Comm_size(MPI_COMM_WORLD, &size);
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);

    int *globalValue=NULL;
    int localValue;

    if (rank == 0) {
        globalValue = malloc(size * sizeof(int) );
        for (int i=0; i<size; i++)
            globalValue[i] = 5*i+1;

        printf("Processor %d has: ", rank);
        for (int i=0; i<size; i++)
            printf("%d ", globalValue[i]);
        printf("\n");
    }

    MPI_Scatter(globalValue, 1, MPI_INT, &localValue, 1, MPI_INT, 0, MPI_COMM_WORLD);

    printf("Processor %d will receive the array %d\n", rank, localValue);
    localValue *= 2;
    printf("Processor %d will receive the array %d\n", rank, localValue);

    MPI_Gather(&localValue, 1, MPI_INT, globalValue, 1, MPI_INT, 0, MPI_COMM_WORLD);

    if (rank == 0) {
        printf("Processor %d has: ", rank);
        for (int i=0; i<size; i++)
            printf("%d ", globalValue[i]);
        printf("\n");
    }

    if (rank == 0)
        free(globalValue);

    MPI_Finalize();
    return 0;
}
