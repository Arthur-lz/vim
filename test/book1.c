#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>

int main(int argc, char *argv[])
{
	int num = 1;
	pid_t pid = fork();
	if(pid < 0)
	{
		perror("vfork error");
	}
	else if(pid == 0) //当前在子进程中
	{
		printf("child exit, num is %d, child is: %d, parent is: %d\n", ++num, getpid(), getppid());
		int i;
		int count = 100;
		if (argc == 1) {
			count = (int)argv[0];	
		}
		
		printf("count is %d\n", count);
		for (i = 0; i < count; i++) {
			printf("%d\n",i);
		}	
		exit(0);
	}
	else// pid > 0，当前在父进程中 
	{
		printf("num is %d, parent is: %d\n", ++num, getpid());
		exit(0);
	}
	return EXIT_SUCCESS;

}
