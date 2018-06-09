#include <sys/wait.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main(void)
{
    int pipefd[2];
    
    if(pipe(pipefd))
	{
		perror("blad pipe");
		exit(-1);
	}
	
//	printf("%d %d",pipefd[0],pipefd[1]);
    pid_t child_gen_rand, child_dziel_8;
    
    child_gen_rand=fork();
    if(child_gen_rand!=0)
		child_dziel_8=fork();
	
	if (child_gen_rand==0)
	{
		close(STDOUT_FILENO);
		dup2(pipefd[1],1);
		close(pipefd[0]);
		close(pipefd[1]);
		execlp("timeout","timeout","20s","parec","-r",(char*)NULL);
		perror("parec failed\n");
		exit(-1);
    }
    if (child_dziel_8==0)
    {
		close(STDIN_FILENO);
		dup2(pipefd[0],0);
		close(pipefd[0]);
		close(pipefd[1]);
		execlp("timeout","timeout","21s","./czytaj",(char*)NULL);
//		execlp("./czytaj","czytaj",(char*)NULL);
		
		perror("czytaj failed\n");
		exit(-1);
	}
	
	close(pipefd[0]);
	close(pipefd[1]);
	
	wait(NULL);
	wait(NULL);
	exit(0);
}
