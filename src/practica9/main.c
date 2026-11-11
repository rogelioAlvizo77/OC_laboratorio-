#include <stdio.h>
#define MAX 6

extern int _minimo(int*,int);
int minimoC(int *arreglo,int len);

int main(void)
{
    int arreglo[MAX] = {5,-2,9,22,-11,10};
	printf("\n ARREGLO:");	
	for(int i=0; i<MAX ; i++)
		printf("%d ",arreglo[i]);
    printf("\n\r Minimo: %d",minimoC(arreglo,MAX));
    printf("\n\r Minimo Ensamblador: %d\n\r",_minimo(arreglo,MAX));
	return 0;
}

int minimoC(int *arreglo,int len)
{
	int min = arreglo[0];
	for(int i=0; i<len;i++)
	{
		if( arreglo[i] < min)
			min = arreglo[i];
	}
	
	return min;
}