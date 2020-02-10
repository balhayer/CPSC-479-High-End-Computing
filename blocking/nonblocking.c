

#include <stdio.h>
#include <stdlib.h>
#include <mpi.h>

int main( int argc, char *argv[]) {
    int rank, size;
    MPI_Init(&argc, &argv);
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    MPI_Comm_size(MPI_COMM_WORLD, &size);

    double before, after;
    MPI_Request ireq;
    MPI_Status istatus;
    int temp = 1;
    if (rank == 0) {
        before = MPI_Wtime();

        MPI_Isend(&before, 1, MPI_DOUBLE, 1, 0, MPI_COMM_WORLD, &ireq);
        MPI_Wait(&ireq, &istatus);
    } else if (rank == 1) {
        MPI_Irecv(&before, 1, MPI_DOUBLE, 0, 0, MPI_COMM_WORLD, &ireq);
        MPI_Wait(&ireq, &istatus);

	//start = MPI_Wtime();
	//localComputation();
	//end = MPI_Wtime();

        after = MPI_Wtime();
        double elapsed = after - before;
        printf("It took %f for a nonblocking message to be sent\n", elapsed);
    }
    MPI_Finalize();
    return 0;
}

