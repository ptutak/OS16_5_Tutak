#include <stdio.h>
#include <stdlib.h>
#include <sys/msg.h>
#include <string.h>
#include <ctype.h>
#include <time.h>

struct moj_msg {
	long mtype;
	char msg[30];
}wiadomosc;

int main(void)
{
	key_t klucz=ftok("./kolejka-send",(long)'Z');
	int msgid=msgget(klucz,0600);
	time_t rawtime;
	struct tm* timeinfo;
	time(&rawtime);
	timeinfo=localtime(&rawtime);
	
	if ((timeinfo->tm_wday>=5)||(timeinfo->tm_wday==0))
	{
		if(msgrcv(msgid,&wiadomosc, sizeof(wiadomosc.msg),255,IPC_NOWAIT)==-1)
		{
			perror("msgrcv error");
			exit(-1);
		}
		if (isalpha(wiadomosc.msg[0]))
		{
			int x=1;
			int bool=1;
			do
			{
				if (((int)wiadomosc.msg[x])<0)
					bool=0;
				
				x++;
			} while ((wiadomosc.msg[x]!='\0')&&(x<30));
			if (bool)
				printf("wyraz poprawny:%s\n",wiadomosc.msg);
			else
				printf("wyraz niepoprawny\n");
			
		}
		else
		{
			printf("wyraz niepoprawny\n");
		}
		if (msgctl(msgid, IPC_RMID, NULL) == -1)
		{
			perror("msgctl error");
			exit(-1);
		}
	}
	else
		printf("dzis nie jest weekend\n");
	return 0;
}
