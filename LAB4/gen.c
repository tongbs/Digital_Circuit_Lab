#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int main(int argc, char **argv)
{
    int col, idx = 0;

    srand(time(NULL));
    for (idx = 0; idx < 8; idx++)
    {
      for (col = 0; col < 32; col++)
      {
        printf(" data%d[%2d] <= %3d;", idx, col,
               (int) (256*rand()/32768));
      }
      printf("\n");
    }

    return 0;
}
