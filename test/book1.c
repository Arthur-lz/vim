#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>

int main()
{
	int num = 1;
	pid_t pid = vfork();
	if(pid < 0)
	{
		perror("vfork error");
	}
	else if(pid == 0)
	{
		printf("num is %d, child is: %d\n", ++num, getpid());
		exit(0);
	}
	else 
	{
		printf("num is %d, parent is: %d\n", ++num, getpid());
		exit(0);
	}
	return EXIT_SUCCESS;

}
