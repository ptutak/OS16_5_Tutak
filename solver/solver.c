#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>

int main(int argc, char* argv[])
{
	int liczba_procesow=(argc-1)/2;
	
	pid_t* proces=malloc(liczba_procesow*sizeof(pid_t));
	
	pid_t parent=getpid();
	
	pid_t child;
	int i=0;
	do
	{	
		i++;
		child=fork();
	} while((child!=0)&&(i<liczba_procesow));
	
	if (child==0)
	{
		int status;
		status=execl("./worker","./worker",argv[2*i-1],argv[2*i],(char*)NULL);
	}
	
	while (wait(NULL)!=-1);
}
