#include <stdio.h>
#include <ctype.h>

int main(void)
{
	char buf;
	int i=0;
	while(1)
		{
			fread(&buf,1,1,stdin);
			
			if (isalnum((int)buf))
			{
				fwrite(&buf,1,1,stdout);
				i++;
				if (i==8)
				{
					i=0;
					fwrite("\n",1,1,stdout);
				}
			}
		}
	
}
