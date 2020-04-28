#include "types.h"
#include "stat.h"
#include "user.h"

void signal_handler(int signum){
    printf(1, "In signal handler");
}

int
main(int argc, char *argv[]){
    printf(1, "starting....");
    //int pid = getpid();
    /*struct sigaction* act = malloc(sizeof(struct sigaction*));
    printf(1, "malloc");
    act->sa_handler = signal_handler;
    act->sigmask = 0;
    sigaction(6, act, null); 
    printf(1, "sigaction");
    //kill(pid, 6); 
    //printf(1, "kill");*/
    exit();
}