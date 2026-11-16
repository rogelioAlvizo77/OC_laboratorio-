#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define SENSORS 2

extern void _setbit(unsigned char*, unsigned char);
extern unsigned char _getbit(unsigned char, unsigned char);

void update_temp(int *temps);
void update_flags(int *temps, int *last_temps, unsigned char *flags);
void print_flag(unsigned char flag);

int main(void)
{
    srand(time(NULL));

    int temps[SENSORS] = {25,25};
    int last_temps[SENSORS] = {25,25};

    unsigned char flags[SENSORS] = {1,1};

    int opcion;

    do
    {
        printf("\n\r SENSOR 1: ~%d °C ",temps[0]);
        print_flag(flags[0]);

        printf("\n\r SENSOR 2: ~%d °C ",temps[1]);
        print_flag(flags[1]);

        printf("\n\n[1] Actualizar");
        printf("\n[2] Salir");

        printf("\n\nSeleccionar opcion: ");
        scanf("%d",&opcion);

        if(opcion == 1)
        {
            update_temp(temps);
            update_flags(temps,last_temps,flags);
        }

    }while(opcion != 2);

    printf("\n\rFIN DE PROGRAMA\n\n\r");

    return 0;
}


void update_temp(int *temps)
{
    int min = -5,max = 5;

    for(int i = 0; i < SENSORS; i++)
    {
        temps[i] += rand() % (max - min + 1) + min;
    }
}


void update_flags(int *temps,int *last_temps,unsigned char *flags)
{
    int diferencia;

    for(int i = 0; i < SENSORS; i++)
    {
        diferencia = temps[i] - last_temps[i];

        flags[i] = 0;

        if(diferencia > 0)
        {
            _setbit(&flags[i],5);
        }
        else if(diferencia < 0)
        {
            _setbit(&flags[i],4);
        }

        if(abs(diferencia) >= 3)
        {
            _setbit(&flags[i],3);
        }
        else if(abs(diferencia) == 2)
        {
            _setbit(&flags[i],2);
        }
        else if(abs(diferencia) == 1)
        {
            _setbit(&flags[i],1);
        }
        else
        {
            _setbit(&flags[i],0);
        }

        last_temps[i] = temps[i];
    }
}


void print_flag(unsigned char flag)
{
    int cantidad = 0;

    if(_getbit(flag,0) == 1)
    {
        printf("-");
        return;
    }

    if(_getbit(flag,1) == 1)
    {
        cantidad = 1;
    }
    else if(_getbit(flag,2) == 1)
    {
        cantidad = 2;
    }
    else if(_getbit(flag,3) == 1)
    {
        cantidad = 3;
    }

    if(_getbit(flag,5) == 1)
    {
        for(int i = 0; i < cantidad; i++)
        {
            printf(">");
        }
    }
    else if(_getbit(flag,4) == 1)
    {
        for(int i = 0; i < cantidad; i++)
        {
            printf("<");
        }
    }
}