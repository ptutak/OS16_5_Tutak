#include <stdio.h>
#include <stdlib.h>
#include <sys/msg.h>
#include <string.h>

struct moj_msg {
	long mtype;
	char msg[40];
}wiadomosc;

int main(void)
{
	wiadomosc.mtype=255;
	printf("Podaj wyraz:\n");
	
	scanf("%s",wiadomosc.msg);
	
	key_t klucz=ftok("./kolejka-send",(int)'Z');
	int msgid=msgget(klucz,0600 | IPC_CREAT);
	if (msgid==-1)
	{
		perror("msgget error");
		exit(-1);
	}
	
	if(msgsnd(msgid,&wiadomosc,sizeof(wiadomosc.msg),IPC_NOWAIT))
	{
		perror("msgsend error");
		exit(-1);
	}
	
	
}
