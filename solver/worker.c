#include <stdio.h>
#include <stdlib.h>
unsigned long long ackermann(unsigned long long m, unsigned long long n)
{
	if (m==0)
		return n+1;
	if (n==0)
		return ackermann(m-1,1);
	
	return ackermann(m-1,ackermann(m,n-1));
}

int main(int argc,char* argv[])
{
	if (argc<3)
		return -1;
	
	unsigned long long m,n;
	m=strtoull(argv[1],NULL,10);
	n=strtoull(argv[2],NULL,10);
	
	printf("%llu\n",ackermann(m,n));
}
