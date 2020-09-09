#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>

int main(int argc, char *argv[])
{
	pid_t pid;
	int fd;
	pid = fork();
	if (pid == 0) {
		chdir("/");
		setsid();
		fd = open("/dev/null", O_RDWR);
		if(fd == -1)
		{
			perror("open null file faild.\n");
			return -1;
		}	
		dup2(fd, 0);
		dup2(fd, 1);
		dup2(fd, 2);
		while(1){
			printf("hello\n");
			sleep(1);
		}
		return 0;
	}	
	return 0;
}
