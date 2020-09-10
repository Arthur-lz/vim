/*
 *
 * 客户端
 *
 */

#include <stdio.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netinet/ip.h>
#include <pthread.h>

void *do_thread(void *arg);

int main(int argc, char *argv[])
{
	int sd;

	sd = socket(AF_INET, SOCK_STREAM, 0);
	if (sd < 0) {
		perror("get socket error\n");
		return -1;		
	}

	struct sockaddr_in addr;
	addr.sin_family = AF_INET;
	addr.sin_port = htons(10086);
	addr.sin_addr.s_addr = inet_addr("127.0.0.1");

	int ret;

	ret = connect(sd, (struct sockaddr *)&addr, sizeof(struct sockaddr_in));
	if (ret != 0) {
		perror("connect faild\n");
		return -2;
	}
	printf("connect success...\n");
	pthread_t tid;

	pthread_create(&tid, NULL, do_thread, (void *)sd);
	pthread_detach(tid);

	char buffer[1024] = {0};

	while (1) {
		ret = read(0, buffer, 1024);
		if (ret > 1024) {
			continue;			
		}
		write(sd, buffer, ret);
	}
	return 0;
}

void *do_thread(void *arg)
{
	int sd = (int)arg;
	int ret;

	char buffer[1024] = {0};

	while (1) {
		ret = read(sd, buffer, 1024);
		if (ret <= 0) {
			break;			
		}
		buffer[ret] = '\0';
		printf("recv:%s",buffer);
		
	}
}

