// g++ -fopenmp pb1.c -o pb1
// ./pb3

#include <stdio.h>
#include <omp.h>
#define N 32

int main(int argc, char **argv)
{
    int a[N];
    int totalEvenValues = 0;
    omp_set_num_threads(8);

#pragma omp parallel
    {
        int t_id = omp_get_thread_num();
        int num_threads = omp_get_num_threads();

        for (int i = t_id; i < N; i += num_threads)
        {
            a[i] = 0;
        }
    }

#pragma omp parallel
    {
        int t_id = omp_get_thread_num();
        int num_threads = omp_get_num_threads();

        for (int i = t_id; i < N; i += num_threads)
        {
            a[i] += i;
        }
    }

#pragma omp parallel reduction(+ : totalEvenValues)
    {
        int t_id = omp_get_thread_num();
        int num_threads = omp_get_num_threads();

        for (int i = t_id; i < N; i += num_threads)
        {
            if (a[i] % 2 == 0)
            {
                totalEvenValues += +(totalEvenValues, 1);
            }
        }
    }

    printf("Total of even values are: %d\n", totalEvenValues);

    return 0;
}
