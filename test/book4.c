#include <stdio.h>
#include <linux/input.h>
#include <unistd.h>
#include <stdlib.h>
#include <fcntl.h>

/* 11,cs
 *struct input_event{
 *        struct timeval time;
 *        __u16 type;
 *        __u16 code;
 *        __s32 value;
 *};
 *
 *#define EV_SYN  0x00
 *#define EV_KEY  0x01
 *#define EV_REL  0x02
 *#define EV_ABS  0x03
 */


int main(int argc, char *argv[])
{
	struct input_event em;

	int fd = open("/dev/input/event5",O_RDWR); //cd /dev/input/, cat event5 移动鼠标会有输出
	int value;
	int type;
	int buffer[10] = {0};
	if (fd == -1) {
		printf("open mouse event faild.\n");
		return -1;
	}

	while(1){
		read(fd, &em, sizeof(em));
		switch (em.type) {
			case EV_SYN/* variable case */:
				printf("sync\n");	
				break;
			case EV_REL:
				if (em.code == REL_X) {
					printf("event_mouse.code_x: %d\n",em.code);
					printf("event_mouse.value_x: %d\n",em.value);
				}	
				if (em.code == REL_Y) {
					
					printf("event_mouse.code_y: %d\n",em.code);
					printf("event_mouse.value_y: %d\n",em.value);
				}
				break;
			default:
				break;
				
		}
	}
	return 0;
}

