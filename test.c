/*#include "types.h"
#include "stat.h"
#include "user.h"

#include "x86.h"


void signal_handler(int signum){
    printf(1, "In signal handler");
}

int
main(int argc, char *argv[]){
    
    int pid = getpid();
    struct sigaction act;
    printf(1, "malloc\n");
    act.sa_handler = &signal_handler;
    act.sigmask = 0;
    sigaction(6, &act, null); 
    printf(1, "sigaction\n");
  
    printf(1, "kill %d",   kill(pid, 6));
    printf(1, "after sig handler");
    exit();
}*/


#include "types.h"
#include "stat.h"
#include "user.h"

void some_handler(int signum) {
	printf(1, "Recevied signal %d\n", signum);
}

int
main(int argc, char **argv)
{
  int child = fork();
  int signum = 4;
  struct sigaction handler;

  /*if (child == 0) {
  	while(1) {
		printf(1, "CHILD\n");
		sleep(100);  		
  	}
  }
  else {
  	sleep(300);
  	kill(child, SIGSTOP);
  	printf(1, "Sent SIGSTOP to child\n");
  	sleep(300);
  	kill(child, SIGCONT);
  	printf(1, "Sent SIGCONT to child\n");
  	sleep(300);
  	kill(child, SIGKILL);
  	printf(1, "Sent SIGKILL to child\n");
  	wait();
  }


  child = fork();*/
  if (child == 0) {

  	handler.sa_handler = &some_handler;
  	handler.sigmask = 0;
  	
  	sigaction(signum, &handler, null);
  	
  	while(1) {
		printf(1, "CHILD\n");
		sleep(100);  		
  	}
  }
  else {
  	sleep(300);
  	
  	kill(child, signum);
  	printf(1, "Send signal 4 to child\n");
  	sleep(300);
  	kill(child, SIGKILL);
  	printf(1, "Sent SIGKILL to child\n");
  	wait();
  }

  exit();
}

/*

    
}*/