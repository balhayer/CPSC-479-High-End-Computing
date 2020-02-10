

#include <stdio.h>
#include <stdlib.h>
#include <mpi.h>

int main( int argc, char *argv[]) {
    int rank, size;
    MPI_Init(&argc, &argv);
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    MPI_Comm_size(MPI_COMM_WORLD, &size);

    double before, after, to_send = 1.5;
    if (rank == 0) {
        before = MPI_Wtime();
        MPI_Send(&before, 1, MPI_DOUBLE, 1, 0, MPI_COMM_WORLD);

    } else if (rank == 1) {
        MPI_Recv(&before, 1, MPI_DOUBLE, 0, 0, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
        after = MPI_Wtime();
        double elapsed = after - before;
        printf("It took %f for a blocking message to be sent\n", elapsed);
    }
    MPI_Finalize();
    return 0;
}
