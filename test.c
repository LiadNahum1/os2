#include "types.h"
#include "stat.h"
#include "user.h"

#include "x86.h"

/*
void signal_handler(int signum){
    printf(1, "In signal handler");
}
*/
int
main(int argc, char *argv[]){
    printf(1, "starting....\n");
    int addr =3;
    printf(1, "cas : %d addr: %d", cas(&addr, 3, 5), addr);
    /*int pid = getpid();
    struct sigaction* act = malloc(sizeof(struct sigaction*));
    printf(1, "malloc\n");
    act->sa_handler = signal_handler;
    act->sigmask = 0;
    sigaction(6, act, null); 
    printf(1, "sigaction\n");
  
    printf(1, "kill %d",   kill(pid, 6));
    sigaction(1, act, null);*/
    exit();
}