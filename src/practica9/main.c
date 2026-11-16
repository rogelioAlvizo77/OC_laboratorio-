#include <stdio.h>

#define MAX 5

extern int maximo(int*,int);
extern int minimo(int*,int);
extern int sumatoria(int*,int);

int main(void)
{
    int arreglo[MAX];
    int cantidad;

    printf("Ingrese la cantidad de elementos (1-5): ");
    scanf("%d",&cantidad);

    if(cantidad < 1 || cantidad > MAX)
    {
        printf("Cantidad no valida\n");
        return 1;
    }

    printf("\nIngrese los elementos:\n");

    for(int i=0; i<cantidad; i++)
    {
        printf("Elemento %d: ",i+1);
        scanf("%d",&arreglo[i]);
    }

    printf("\n ARREGLO: ");

    for(int i=0; i<cantidad; i++)
    {
        printf("%d ",arreglo[i]);
    }

    printf("\n\n Maximo: %d",maximo(arreglo,cantidad));

    printf("\n Minimo: %d",minimo(arreglo,cantidad));

    printf("\n Sumatoria: %d\n",sumatoria(arreglo,cantidad));

    return 0;
}