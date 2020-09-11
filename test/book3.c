#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <pthread.h>

pthread_mutex_t m;
int t=0;
void *thread1(void *arg) {
	pthread_mutex_lock(&m);
	
	while(1){		
		printf("thread1, t=%d\n", t++);
		if (t == 3) {
			break;			
		}
	}
	
	pthread_mutex_unlock(&m);
}

void *thread2(void *arg) {
	pthread_mutex_lock(&m);
        printf("thread2, t=%d\n", t++);
	pthread_mutex_unlock(&m);
}

 void *threaddo(void *arg) {
            pthread_mutex_lock(&m);
	    int p =   (int)arg;
            printf("thread%d, t=%d\n",p,  t++);
            pthread_mutex_unlock(&m);
}

int main(int argc, char *argv[])
{
	int ret = 0;
	pthread_t p1 = 0;
	pthread_t p2 = 0;
	ret = pthread_mutex_init(&m, NULL);
	if (ret < 0) {
		perror("pthread mutex error.\n");
		exit(EXIT_FAILURE);
	}

	ret = pthread_create(&p1, NULL, threaddo, (void *)1);

	if (ret < 0) {
		perror("pthread1_create error");
		exit(EXIT_FAILURE);
	}
	
	ret = pthread_create(&p2, NULL, threaddo, (void *)2);

	if (ret < 0) {
               perror("pthread2_create error");
               exit(EXIT_FAILURE);
       }

	pthread_join(p1, NULL);// 线程1一定先退出，因为这里等待线程1结束的pthread_join先执行,但这不意味着线程1一定会在线程2前执行S
	printf("p1 out\n");
	pthread_join(p2, NULL);
	printf("p2 out\n");
	printf("parent is out\n");
	return 0;
}
