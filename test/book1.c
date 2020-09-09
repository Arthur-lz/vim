#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>

void testnoparentprocess();
int main(int argc, char *argv[])
{
	int num = 1;
	char *arg[] = {"ls","-al",NULL};
	pid_t pid = fork();
	if(pid < 0)
	{
		perror("vfork error");
	}
	else if(pid == 0) //当前在子进程中
	{
		printf("1th process, num is %d, child is: %d, parent is: %d\n", ++num, getpid(), getppid());
		if (execl("/bin/ls","ls","-a",NULL) == -1) {
			perror("execl error");
			exit(1);
		}
	
	//	int i;
	//	int count = 100;
	//	if (argc == 1) {
	//		count = (int)argv[0];	
	//	}
	//	
	//	printf("count is %d\n", count);
	//	for (i = 0; i < count; i++) {
	//		printf("%d\n",i);
	//	}	
	//	exit(0);
	}
	else// pid > 0，当前在父进程中 
	{
		printf("parent, num is %d, parent is: %d\n", ++num, getpid());
		//exit(0);
	}

		if (fork() == 0) {
			printf("2th process, id is %d, parent is: %d\n", getpid(), getppid());
			if (execve("/bin/ls",arg,NULL) == 0) {
				perror("execve error");
				exit(1);
			}
			exit(1);
		}

	//testnoparentprocess();
	printf("parent is over, pid is :%d.\n", getpid());
	return EXIT_SUCCESS;

}

void testnoparentprocess()
{
	int i = fork();
	if (i < 0) {
		perror("fork error");
		exit(1);
	}
	else if(i == 0){
		printf("current process id: %d, parent id: %d\n", getpid(), getppid());
		sleep(5);
		printf("after sleep 5 sec, current process id: %d, parent id: %d\n", getpid(), getppid());
		while(1)
			wait(1);
	}
}
