#include "types.h"
#include "stat.h"
#include "user.h"
void test2()
{
	int pid;
	if((pid=fork()) == 0){
		printf(1, "child procses1\n");
		sleep(100);
        exit();
	}
	else{
		if((pid=fork()) == 0){
			printf(1, "child procses2\n");
			sleep(150);
            exit();
		}
		else{
			if((pid=fork()) == 0){
				printf(1, "child procses3\n");
				sleep(200);
                exit();
			}
			else{
				for (int i =0; i<3; i++){
					printf(1,"wating for children\n");
					wait();
					printf(1,"one child ended\n");
				}
				printf(1, "all children ended\n");
				//printf(1, "check yield");
			}
		}
	}
}

void test1(){
	int pid;
	if((pid = fork()) == 0){
		printf(1,"in childern\n");
		sleep(400);
		printf(1,"wokeup\n");
		exit();
	}
	else
	{
		printf(1,"in father\n");
		wait();
		printf(1,"dane waiting\n");
	}
	
}

int
main(int argc, char *argv[]){
    printf(1,"--------------test 1-----------\n");
    test1();
    printf(1,"--------------test 2-----------\n");
    test2();
    printf(1,"dane!!!!");
    exit();
}