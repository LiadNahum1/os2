#include "types.h"
#include "defs.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "x86.h"
#include "proc.h"
#include "spinlock.h"

struct {
  struct spinlock lock;
  struct proc proc[NPROC];
} ptable;

static struct proc *initproc;

int nextpid = 1;
extern void forkret(void);
extern void trapret(void);
extern void trapret_handler(struct trapframe * tf);

static void wakeup1(void *chan);

void
pinit(void)
{
  initlock(&ptable.lock, "ptable");
}

// Must be called with interrupts disabled
int
cpuid() {
  return mycpu()-cpus;
}

// Must be called with interrupts disabled to avoid the caller being
// rescheduled between reading lapicid and running through the loop.
struct cpu*
mycpu(void)
{
  int apicid, i;
  
  if(readeflags()&FL_IF)
    panic("mycpu called with interrupts enabled\n");
  
  apicid = lapicid();
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
    if (cpus[i].apicid == apicid)
      return &cpus[i];
  }
  panic("unknown apicid\n");
}

// Disable interrupts so that we are not rescheduled
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
  c = mycpu();
  p = c->proc;
  popcli();
  return p;
}


int 
allocpid(void) 
{
   int pid;
   pushcli(); 
  do{
    pid = nextpid;
     
  }while (!cas(&nextpid , pid, pid+1));
  popcli(); 
  return pid+1;
}

//PAGEBREAK: 32
// Look in the process table for an UNUSED proc.
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
  struct proc *p;
  char *sp;

  pushcli();

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(cas(&p->state, UNUSED, EMBRYO))
      goto found;

  popcli();
  return 0;

found:
  popcli();
  
  p->pid = allocpid();
  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
    p->state = UNUSED;
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
  p->tf = (struct trapframe*)sp;

  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
  p->context->eip = (uint)forkret;

  //add assignment 2 
  p->backup = (struct trapframe*)kalloc();
  //initialize handlers to be default  
  for(int i=0; i<32; i++){
    p->signal_handlers[i].sa_handler = SIG_DFL;
    p->signal_handlers[i].sigmask = 0;
  }
  p->pending_signals =0;
  p->signal_mask = 0;
  p->signal_mask_backup = 0;
  p->suspended =0;
  p->already_in_signal = 0;
  return p;
}

//PAGEBREAK: 32
// Set up first user process.
void
userinit(void)
{
  struct proc *p;
  extern char _binary_initcode_start[], _binary_initcode_size[];

  p = allocproc();
  
  initproc = p;
  if((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
  p->sz = PGSIZE;
  memset(p->tf, 0, sizeof(*p->tf));
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
  p->tf->es = p->tf->ds;
  p->tf->ss = p->tf->ds;
  p->tf->eflags = FL_IF;
  p->tf->esp = PGSIZE;
  p->tf->eip = 0;  // beginning of initcode.S

  safestrcpy(p->name, "initcode", sizeof(p->name));
  p->cwd = namei("/");

  // this assignment to p->state lets other cores
  // run this process. the acquire forces the above
  // writes to be visible, and the lock is also needed
  // because the assignment might not be atomic.
  pushcli();
  
  cas(&p->state, EMBRYO, RUNNABLE);
  popcli();
}

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
  uint sz;
  struct proc *curproc = myproc();

  sz = curproc->sz;
  if(n > 0){
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  } else if(n < 0){
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  }
  curproc->sz = sz;
  switchuvm(curproc);
  return 0;
}

// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int
fork(void)
{
  int i, pid;
  struct proc *np;
  struct proc *curproc = myproc();

  // Allocate process.
  if((np = allocproc()) == 0){
    return -1;
  }
  
  // Copy process state from proc.
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
    kfree(np->kstack);
    np->kstack = 0;
    np->state = UNUSED;
    return -1;
  }
  np->sz = curproc->sz;
  np->parent = curproc;
  *np->tf = *curproc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
    if(curproc->ofile[i])
      np->ofile[i] = filedup(curproc->ofile[i]);
  np->cwd = idup(curproc->cwd);

  safestrcpy(np->name, curproc->name, sizeof(curproc->name));

  pid = np->pid;

  //copy signal handlers and signal mask from parent 
  np->signal_mask = curproc->signal_mask;
  for(int i=0; i<32; i++){
    np->signal_handlers[i] = curproc->signal_handlers[i];
  }

  pushcli();

  cas(&np->state, EMBRYO, RUNNABLE);
  popcli();

  return pid;
}

// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(void)
{
  struct proc *curproc = myproc();
  struct proc *p;
  int fd;

  if(curproc == initproc)
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd]){
      fileclose(curproc->ofile[fd]);
      curproc->ofile[fd] = 0;
    }
  }

  begin_op();
  iput(curproc->cwd);
  end_op();
  curproc->cwd = 0;

  pushcli();

  // Jump into the scheduler, never to return.
 
  cas(&curproc->state, RUNNING, -ZOMBIE);

     
    // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->parent == curproc){
      p->parent = initproc;
      if(p->state == ZOMBIE || p->state == -ZOMBIE){
        wakeup1(initproc);
      }
    }
  }

  // Parent might be sleeping in wait().
  wakeup1(curproc->parent);
  sched();
  panic("zombie exit");
  
}
int
wait(void)
{
  struct proc *p;
  int havekids, pid;
  struct proc *curproc = myproc();

  for(;;){
    pushcli();
    cas(&(curproc->state), RUNNING, -SLEEPING);
    curproc->chan = (void*) curproc;

    // Scan through table looking for exited children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
      if(p->parent != curproc)
        continue;
      havekids = 1;

      if (p->state == -ZOMBIE){
        curproc->chan = 0;
        cas(&(curproc->state), curproc->state, RUNNING);
      }
      while(cas(&(p->state), -ZOMBIE, -ZOMBIE));
      if(cas(&(p->state), ZOMBIE, -UNUSED)){
        cas(&(curproc->state), curproc->state, RUNNING);
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
        p->kstack = 0;
        freevm(p->pgdir);
        p->pid = 0;
        p->parent = 0;
        p->name[0] = 0;
        p->killed = 0;
        //p->state = UNUSED;
        cas(&p->state, ZOMBIE, UNUSED);
        kfree((char *)p->backup);
        p->backup = null;
        popcli();
        return pid;
      }
  
    }

    if(!havekids || curproc->killed){
      curproc->chan = null;
      cas(&(curproc->state), -SLEEPING, RUNNING);
      popcli();
      return -1;
    }

    sched();
    popcli();

  }
}


//PAGEBREAK: 42
// Per-CPU process scheduler.
// Each CPU calls scheduler() after setting itself up.
// Scheduler never returns.  It loops, doing:
//  - choose a process to run
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void)
{
  struct proc *p;
  struct cpu *c = mycpu();
  c->proc = 0;
  
  for(;;){
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    pushcli();
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
       //cprintf("in scheduler %d!!!!!", p->state );
     
      int result = cas( &p->state , RUNNABLE , RUNNING);
      if (!result)
        continue;    

      
      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.

      c->proc = p;
      switchuvm(p);
      p->state = RUNNING;

      swtch(&(c->scheduler), p->context);
      switchkvm();

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      
       // transform from -x to x
     
      cas( &p->state , -SLEEPING , SLEEPING);
      cas( &p->state , -RUNNABLE , RUNNABLE);
      cas( &p->state , -ZOMBIE , ZOMBIE);
      c->proc = 0;
    }
    popcli();
}

}

// Enter scheduler.  Must hold only ptable.lock
// and have changed proc->state. Saves and restores
// intena because intena is a property of this
// kernel thread, not this CPU. It should
// be proc->intena and proc->ncli, but that would
// break in the few places where a lock is held but
// there's no process.
void
sched(void)
{
  int intena;
  struct proc *p = myproc();

  //if(!holding(&ptable.lock))
    //panic("sched ptable.lock");
  if(mycpu()->ncli != 1)
    panic("sched locks");
  if(p->state == RUNNING)
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
  intena = mycpu()->intena;
  swtch(&p->context, mycpu()->scheduler);
  mycpu()->intena = intena;
}

// Give up the CPU for one scheduling round.
void
yield(void)
{
  pushcli();  //DOC: yieldlock
  cas(&myproc()->state, RUNNING, -RUNNABLE);
  sched();
  popcli();
}

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  popcli();

  if (first) {
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot
    // be run from main().
    first = 0;
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
  struct proc *p = myproc();
  
  if(p == 0)
    panic("sleep");

  if(lk == 0)
    panic("sleep without lk");

  // Must acquire ptable.lock in order to
  // change p->state and then call sched.
  // Once we hold ptable.lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with ptable.lock locked),
  // so it's okay to release lk.
  if(lk != &ptable.lock){  //DOC: sleeplock0
    pushcli();  //DOC: sleeplock1
    release(lk);
  }
  // Go to sleep.
  p->chan = chan;
  cas(&p->state, RUNNING, -SLEEPING);

  sched();

  // Tidy up.
  p->chan = 0;

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    popcli();
    acquire(lk);
  }
}

//PAGEBREAK!
// Wake up all processes sleeping on chan.
// The ptable lock must be held.
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if((p->state == SLEEPING || p->state == -SLEEPING) && p->chan == chan){
      cas(&p->state, -SLEEPING, -RUNNABLE);
      cas(&p->state, SLEEPING, RUNNABLE);
    }
  }
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
  pushcli();
  wakeup1(chan);
  popcli();
}

// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid , int signum)
{
  struct proc *p;
  int is_blocked =0;
  if (signum > 31 || signum < 0)
  return -1;
  pushcli();
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
      while(!cas(&p->pending_signals, p->pending_signals, p->pending_signals | (1<<signum)));
      is_blocked = (p->signal_mask & 1<<signum) == 1<<signum; //check if signal is blocked 
      if((signum == SIGKILL) || (((int)(p->signal_handlers[signum].sa_handler) == SIGKILL) && !is_blocked )){
        while(p->state == SLEEPING || p->state == -SLEEPING){
           cas(&p->state, -SLEEPING, -RUNNABLE);
           cas(&p->state, SLEEPING, RUNNABLE);
        }
      } 
      popcli();
      return 0;
    }
  }
  popcli();
  return -1;
}

void kill_handler(void){
  struct proc *p = myproc();
  p->killed = 1;
}

//PAGEBREAK: 36
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
  static char *states[] = {
  [UNUSED]    "unused",
  [EMBRYO]    "embryo",
  [SLEEPING]  "sleep ",
  [RUNNABLE]  "runble",
  [RUNNING]   "run   ",
  [ZOMBIE]    "zombie"
  };
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
      state = states[p->state];
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
  }
}

uint sigprocmask (uint sigmask){
  struct proc *p = myproc();
  if (((sigmask & 1<<SIGSTOP) == 1<<SIGSTOP))
    return -1; 
  if (((sigmask & 1<<SIGKILL) == 1<<SIGKILL))
    return -1; 

  uint oldmask = p->signal_mask;
  p->signal_mask = sigmask;
  return oldmask;
}

int sigaction(int signum , const struct sigaction *act, struct sigaction *oldact){
    struct proc *p = myproc();
    if (signum > 31 || signum < 0 || signum == SIGSTOP || signum == SIGKILL)
      return -1;
    if (oldact != null){
      *oldact = p->signal_handlers[signum];
    }
    p->signal_handlers[signum].sa_handler = act->sa_handler;
    p->signal_handlers[signum].sigmask = act->sigmask;
    
    return 0;
}

void sigret(void){
  struct proc *p = myproc();
  *p->tf = *p->backup; 
   p->already_in_signal = 0;
   p->signal_mask = p->signal_mask_backup;
       
}

void stop_handler(void){
  struct proc *p = myproc();
  p->suspended = 1;
  yield(); 
}

void cont_handler(void){
  struct proc *p = myproc();
  if (p-> suspended == 1)
    p->suspended = 0; 
}

void call_sigret(void){
   asm("movl $24 , %eax;");
   asm("int $64;");
}


void user_handlers(int i, struct proc * p){
    int functionSize = ((int)user_handlers - (int)call_sigret); 
    //backup trapframe 
    *p->backup = *p->tf;

    //put functionn
    p->tf->esp -= functionSize;
    memmove((int*)p->tf->esp, &call_sigret, functionSize);
    uint returnAdress = p->tf->esp;

    // push argumants
    p->tf->esp -= sizeof i;
    *(int*)p->tf->esp = i;
    //push return address
    p->tf->esp -= sizeof(int);
    *(int*)p->tf->esp = returnAdress; //adrees to the function that calls sigret 
    struct sigaction handler = p->signal_handlers[i]; 
    p->tf->eip = (uint)handler.sa_handler; 
    trapret_handler(p->tf);

}

void return_from_sig_stop_handler(void){
  struct proc *p = myproc();
  if (p == 0)
    return; 
  int signal_index_in_stop;
  int is_blocked_in_stop;
  //check if p is suspended and has SIGCOUNT
  while(p->suspended){
    for(int j=0; j<32; j=j+1){
      signal_index_in_stop = 1<<j; 
      is_blocked_in_stop = (p->signal_mask & signal_index_in_stop) == signal_index_in_stop;
      if(((p->pending_signals & signal_index_in_stop) == signal_index_in_stop) & !is_blocked_in_stop ){
        if((j == SIGCONT) || ((int)p->signal_handlers[j].sa_handler == SIGCONT)){
            cont_handler();
            p->pending_signals = p->pending_signals & (~signal_index_in_stop); //discard signal
        }
        else if((j == SIGKILL) || ((int)p->signal_handlers[j].sa_handler == SIGKILL)){
            kill_handler();
            p->suspended = 0;
            p->pending_signals = p->pending_signals & (~signal_index_in_stop); //discard signal
        }
      }
    }
    if(p->suspended)
    yield();
  }
}

void default_handlers(int i){
  if(i == SIGCONT)
    cont_handler();
  else if(i==SIGSTOP){
    stop_handler();
    return_from_sig_stop_handler();
  }
  else
    kill_handler();
}

void check_for_signals(void){
  struct proc *p = myproc();
  if (p == 0)
    return; 

  if(p->already_in_signal)
    return; 

  int signal_index;
  int is_blocked;
  
  for(int i=0; i<32; i=i+1){
    signal_index = 1<<i; 
    is_blocked = (p->signal_mask & signal_index) == signal_index; //check if signal is blocked 
    //check if signal's flag is on and it is not blocked 
    if(((p->pending_signals & signal_index) == signal_index) & !is_blocked){
      p->pending_signals = p->pending_signals & (~signal_index); //discard signal
      if(p->signal_handlers[i].sa_handler != (void*)SIG_IGN){
        p->signal_mask_backup = p->signal_mask;
        p->signal_mask = p->signal_handlers[i].sigmask;
        if (p->signal_handlers[i].sa_handler == SIG_DFL){
          default_handlers(i);
          p->signal_mask = p->signal_mask_backup;
        }
        else if ((int)p->signal_handlers[i].sa_handler == SIGSTOP){
          stop_handler();
          p->signal_mask = p->signal_mask_backup; 
          return_from_sig_stop_handler();         
        }
        else if ((int)p->signal_handlers[i].sa_handler == SIGKILL){
          kill_handler();
          p->signal_mask = p->signal_mask_backup;
        }

        else if ((int)p->signal_handlers[i].sa_handler == SIGCONT){
          cont_handler();
          p->signal_mask = p->signal_mask_backup;
        }
       
        else{
          p->already_in_signal = 1; 
          user_handlers(i, p);
        }      
     }
    }
  }


}

  