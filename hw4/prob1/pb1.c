// g++ -fopenmp pb1.c -o pb1
// ./pb1

#include <stdio.h>
#include <omp.h>
#define N 32

int main(int argc, char **argv)
{
    int a[N];
    omp_set_num_threads(8);

#pragma omp parallel
    {
        int t_id = omp_get_thread_num();
        int num_threads = omp_get_num_threads();

        for (int i = t_id; i < N; i += num_threads)
        {
            a[i] = 0;
            printf("Thread %d is assigning zero to a[%d]\n", t_id, i);
        }
    }

    return 0;
}
