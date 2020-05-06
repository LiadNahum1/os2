#include "types.h"
#include "stat.h"
#include "user.h"

void signal_handler(int signum){
    printf(1, "In signal handler %d\n", signum);
}

void signal_handler_2(int signum){
    printf(1, "another function\n");
}

void test1(){
	int pid;

	//check SIGSTOP SGITCONT SIGKILL default handlers 
	if((pid=fork()) == 0){
		while(1){
			printf(1, "Child Process\n");
			sleep(50);
		}
	}

	else{
		sleep(100);
		kill(pid, SIGSTOP);
		printf(1, "Sent SIGSTOP to child\n");
		sleep(100);
		kill(pid, SIGCONT);
		printf(1, "Sent SIGCONT to child\n");
		sleep(100);
		kill(pid, SIGKILL);
		printf(1, "Sent SIGKILL to child\n");
		wait();

	}

}

void test2(){
	if(sigprocmask(1<<SIGSTOP) != -1)
		printf(1, "panic"); 
	if(sigprocmask(1<<SIGKILL) != -1)
		printf(1, "panic"); 

}

void test3(){
	int pid;
	int signum = 7; 
	struct sigaction act;
	struct sigaction old;
    act.sa_handler = &signal_handler;
    act.sigmask = 0;
	sigaction(signum, &act , &old); //check child inherit signal handlers of parent

	//check user signal handlers 
	if((pid=fork()) == 0){	
		printf(1, "Child Process\n");
		sleep(100);
		sigprocmask(1<<signum);
		printf(1, "Block signal %d\n", signum);
		sleep(200);
	}

	else{
		sleep(100);
		kill(pid, signum);
		printf(1, "Sent signal %d to child\n", signum);
		sleep(100);
		kill(pid, signum);
		printf(1, "Sent signal %d to child\n", signum);
		sleep(100);
		kill(pid, SIGKILL);
		sleep(100);
		printf(1, "Sent SIGKILL to child\n");
		wait();

	}

}

void test4(){
	int pid;
	int signum = 7; 
	struct sigaction act;
	struct sigaction old;

	act.sa_handler = signal_handler;
    act.sigmask = 0;
	//change signal handler  
	if((pid=fork()) == 0){	
		printf(1, "Child Process\n");
		sigaction(signum, &act , &old);
		printf(1, "signal handler changed to be signal_handler\n");
	    sleep(100);
		act.sa_handler = signal_handler_2;
		sigaction(signum, &act, null);
		printf(1, "signal handler changed to be signal_handler2\n");
		sleep(100);
		sigaction(signum, &old, null);
		printf(1, "signal handler changed to be SIGKILL\n");
		sleep(100);

	}

	else{
		sleep(100);
		kill(pid, signum);
		printf(1, "Sent signal %d to child", signum);
		sleep(100);
		kill(pid, signum);
		printf(1, "Sent signal %d to child", signum);
		sleep(100);
		kill(pid, signum);
		printf(1, "Sent signal %d to child - suppose to kill it", signum);
		sleep(100);
		wait();

	}

}
int
main(int argc, char *argv[]){
	printf(1, "---------------test 1---------------\n");
	test1();
	sleep(400);
	printf(1, "---------------test 2---------------\n");
	test2();
	sleep(400);
	printf(1, "---------------test 3---------------\n");
	test3();
	sleep(400);
	printf(1, "---------------test 4---------------\n");
	test4();
	sleep(400);
	exit();

	
}
