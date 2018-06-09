#include <unistd.h>
#include <sys/types.h>
#include <wait.h>
#include <sys/utsname.h>
#include <stdio.h>
#include <time.h>
#include <stdlib.h>


int main(void)
{
	printf("Podaj liczbe dzieci (jedna liczba dla ilosci \"wglab\" i \"wszerz\", musi byc wieksza od 0)");
	int liczba;
	scanf("%d",&liczba);
	if (liczba<=0)
	{
		printf("Bardzo smieszne.\n");
		return;
	}
	int i=0;
	int j=0;
	pid_t child_wide;
	pid_t child_deep;
	pid_t parent=getpid();
	pid_t parent_of_all_parents=getpid();
	time_t czas;
	do
	{
		child_wide=fork();
//		wait(NULL);
		++i;
	}
	while ((i<liczba)&&(child_wide!=0));
	
	if (child_wide==0)
	do
	{
		++j;
		printf("pid parent: %d,pid self: %d\n",(int)parent,(int)getpid());
		czas=time(NULL);	
		printf("%s",ctime(&czas));
		parent=getpid();
		child_deep=fork();
//		wait(NULL);
	
	} 
	while ((j<liczba)&&(child_deep==0));

	if (parent==parent_of_all_parents)
	{
		printf("Rodzic rodziców się żegna (możliwe tylko przy własnych kopiach zmiennych) --- Cześć!\n");
	}
	
}

