#include <stdio.h>
#include <stdlib.h>

int find_min(int *tab, int size) {

  int result = tab[0];

  for (int i = 0; i < size; i++) {
    if (result > tab[i])
      result = tab[i];
  }

  return result;
}

int main() {

  int tab[] = {12, 6, -9,  7,  1,  4,   -4, 99, -7,
               42, 7, -46, 87, 45, -87, 56, 36, 15};
  int size = sizeof(tab) / sizeof(int);
  printf("size is %d\n", size);

  int min = find_min(tab, size);

  printf("minimum is %d\n", min);
}
