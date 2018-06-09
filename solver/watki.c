#include <pthread.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>

typedef struct do_ackermanna
{
	unsigned long long m;
	unsigned long long n;
} do_ackermanna;


unsigned long long ackermann(unsigned long long m, unsigned long long n)
{
	if (m==0)
		return n+1;
	if (n==0)
		return ackermann(m-1,1);
	
	return ackermann(m-1,ackermann(m,n-1));
}



void* funkcja_watkowa(void* zmienne)
{
	do_ackermanna* dane=(do_ackermanna*)zmienne;
	
	unsigned long long wynik=ackermann(dane->m,dane->n);
	
	free(dane);
	printf("%llu\n",wynik);
	
	pthread_exit(NULL);
}


int main(int argc, char* argv[])
{
	int liczba_watkow=(argc-1)/2;
	
	pthread_t* watek=malloc(liczba_watkow*sizeof(pthread_t));

	
	int i;
	int czy_watek;
	for	(i=0;i<liczba_watkow;++i)
	{
		do_ackermanna* dane=malloc(sizeof(do_ackermanna));
		dane->m=strtoull(argv[i*2+1],NULL,10);
		dane->n=strtoull(argv[i*2+2],NULL,10);		
		czy_watek=pthread_create(&(watek[i]),NULL,funkcja_watkowa,(void*)dane);
		if(czy_watek)
		{
			printf("Nie moglem stworzyc watku %d\n",i);
			return -1;
		}
	}
/*	
	unsigned long long* wynik;

	for (i=0;i<liczba_watkow;++i)
	{
		pthread_join(watek[i],(void**)&wynik);
		printf("%llu\n",*wynik);
	}
*/	
	free(watek);
//	free(wynik);
	pthread_exit(NULL);
}


