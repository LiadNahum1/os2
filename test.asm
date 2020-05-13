
_test:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:

	}

}
int
main(int argc, char *argv[]){
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	51                   	push   %ecx
   e:	83 ec 0c             	sub    $0xc,%esp
	printf(1, "---------------test 1---------------\n");
  11:	68 b4 0c 00 00       	push   $0xcb4
  16:	6a 01                	push   $0x1
  18:	e8 c3 07 00 00       	call   7e0 <printf>
	test1();
  1d:	e8 ae 00 00 00       	call   d0 <test1>
	sleep(400);
  22:	c7 04 24 90 01 00 00 	movl   $0x190,(%esp)
  29:	e8 e4 06 00 00       	call   712 <sleep>
	printf(1, "---------------test 2---------------\n");
  2e:	58                   	pop    %eax
  2f:	5a                   	pop    %edx
  30:	68 dc 0c 00 00       	push   $0xcdc
  35:	6a 01                	push   $0x1
  37:	e8 a4 07 00 00       	call   7e0 <printf>
	test2();
  3c:	e8 3f 01 00 00       	call   180 <test2>
	sleep(400);
  41:	c7 04 24 90 01 00 00 	movl   $0x190,(%esp)
  48:	e8 c5 06 00 00       	call   712 <sleep>
	printf(1, "---------------test 3---------------\n");
  4d:	59                   	pop    %ecx
  4e:	58                   	pop    %eax
  4f:	68 04 0d 00 00       	push   $0xd04
  54:	6a 01                	push   $0x1
  56:	e8 85 07 00 00       	call   7e0 <printf>
	test3();
  5b:	e8 80 01 00 00       	call   1e0 <test3>
	sleep(400);
  60:	c7 04 24 90 01 00 00 	movl   $0x190,(%esp)
  67:	e8 a6 06 00 00       	call   712 <sleep>
	printf(1, "---------------test 4---------------\n");
  6c:	58                   	pop    %eax
  6d:	5a                   	pop    %edx
  6e:	68 2c 0d 00 00       	push   $0xd2c
  73:	6a 01                	push   $0x1
  75:	e8 66 07 00 00       	call   7e0 <printf>
	test4();
  7a:	e8 71 02 00 00       	call   2f0 <test4>
	sleep(400);
  7f:	c7 04 24 90 01 00 00 	movl   $0x190,(%esp)
  86:	e8 87 06 00 00       	call   712 <sleep>
	exit();
  8b:	e8 f2 05 00 00       	call   682 <exit>

00000090 <signal_handler>:
void signal_handler(int signum){
  90:	55                   	push   %ebp
  91:	89 e5                	mov    %esp,%ebp
  93:	83 ec 0c             	sub    $0xc,%esp
    printf(1, "In signal handler %d\n", signum);
  96:	ff 75 08             	pushl  0x8(%ebp)
  99:	68 38 0b 00 00       	push   $0xb38
  9e:	6a 01                	push   $0x1
  a0:	e8 3b 07 00 00       	call   7e0 <printf>
}
  a5:	83 c4 10             	add    $0x10,%esp
  a8:	c9                   	leave  
  a9:	c3                   	ret    
  aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000000b0 <signal_handler_2>:
void signal_handler_2(int signum){
  b0:	55                   	push   %ebp
  b1:	89 e5                	mov    %esp,%ebp
  b3:	83 ec 10             	sub    $0x10,%esp
    printf(1, "another function\n");
  b6:	68 4e 0b 00 00       	push   $0xb4e
  bb:	6a 01                	push   $0x1
  bd:	e8 1e 07 00 00       	call   7e0 <printf>
}
  c2:	83 c4 10             	add    $0x10,%esp
  c5:	c9                   	leave  
  c6:	c3                   	ret    
  c7:	89 f6                	mov    %esi,%esi
  c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000000d0 <test1>:
void test1(){
  d0:	55                   	push   %ebp
  d1:	89 e5                	mov    %esp,%ebp
  d3:	53                   	push   %ebx
  d4:	83 ec 04             	sub    $0x4,%esp
	if((pid=fork()) == 0){
  d7:	e8 9e 05 00 00       	call   67a <fork>
  dc:	85 c0                	test   %eax,%eax
  de:	75 20                	jne    100 <test1+0x30>
			printf(1, "Child Process\n");
  e0:	83 ec 08             	sub    $0x8,%esp
  e3:	68 60 0b 00 00       	push   $0xb60
  e8:	6a 01                	push   $0x1
  ea:	e8 f1 06 00 00       	call   7e0 <printf>
			sleep(50);
  ef:	c7 04 24 32 00 00 00 	movl   $0x32,(%esp)
  f6:	e8 17 06 00 00       	call   712 <sleep>
  fb:	83 c4 10             	add    $0x10,%esp
  fe:	eb e0                	jmp    e0 <test1+0x10>
		sleep(100);
 100:	83 ec 0c             	sub    $0xc,%esp
 103:	89 c3                	mov    %eax,%ebx
 105:	6a 64                	push   $0x64
 107:	e8 06 06 00 00       	call   712 <sleep>
		kill(pid, SIGSTOP);
 10c:	58                   	pop    %eax
 10d:	5a                   	pop    %edx
 10e:	6a 11                	push   $0x11
 110:	53                   	push   %ebx
 111:	e8 9c 05 00 00       	call   6b2 <kill>
		printf(1, "Sent SIGSTOP to child\n");
 116:	59                   	pop    %ecx
 117:	58                   	pop    %eax
 118:	68 6f 0b 00 00       	push   $0xb6f
 11d:	6a 01                	push   $0x1
 11f:	e8 bc 06 00 00       	call   7e0 <printf>
		sleep(100);
 124:	c7 04 24 64 00 00 00 	movl   $0x64,(%esp)
 12b:	e8 e2 05 00 00       	call   712 <sleep>
		kill(pid, SIGCONT);
 130:	58                   	pop    %eax
 131:	5a                   	pop    %edx
 132:	6a 13                	push   $0x13
 134:	53                   	push   %ebx
 135:	e8 78 05 00 00       	call   6b2 <kill>
		printf(1, "Sent SIGCONT to child\n");
 13a:	59                   	pop    %ecx
 13b:	58                   	pop    %eax
 13c:	68 86 0b 00 00       	push   $0xb86
 141:	6a 01                	push   $0x1
 143:	e8 98 06 00 00       	call   7e0 <printf>
		sleep(100);
 148:	c7 04 24 64 00 00 00 	movl   $0x64,(%esp)
 14f:	e8 be 05 00 00       	call   712 <sleep>
		kill(pid, SIGKILL);
 154:	58                   	pop    %eax
 155:	5a                   	pop    %edx
 156:	6a 09                	push   $0x9
 158:	53                   	push   %ebx
 159:	e8 54 05 00 00       	call   6b2 <kill>
		printf(1, "Sent SIGKILL to child\n");
 15e:	59                   	pop    %ecx
 15f:	5b                   	pop    %ebx
 160:	68 9d 0b 00 00       	push   $0xb9d
 165:	6a 01                	push   $0x1
 167:	e8 74 06 00 00       	call   7e0 <printf>
}
 16c:	83 c4 10             	add    $0x10,%esp
 16f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 172:	c9                   	leave  
 173:	c3                   	ret    
 174:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 17a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000180 <test2>:
void test2(){
 180:	55                   	push   %ebp
 181:	89 e5                	mov    %esp,%ebp
 183:	83 ec 14             	sub    $0x14,%esp
	if(sigprocmask(1<<SIGSTOP) != -1)
 186:	68 00 00 02 00       	push   $0x20000
 18b:	e8 92 05 00 00       	call   722 <sigprocmask>
 190:	83 c4 10             	add    $0x10,%esp
 193:	83 f8 ff             	cmp    $0xffffffff,%eax
 196:	74 12                	je     1aa <test2+0x2a>
		printf(1, "panic"); 
 198:	83 ec 08             	sub    $0x8,%esp
 19b:	68 b4 0b 00 00       	push   $0xbb4
 1a0:	6a 01                	push   $0x1
 1a2:	e8 39 06 00 00       	call   7e0 <printf>
 1a7:	83 c4 10             	add    $0x10,%esp
	if(sigprocmask(1<<SIGKILL) != -1)
 1aa:	83 ec 0c             	sub    $0xc,%esp
 1ad:	68 00 02 00 00       	push   $0x200
 1b2:	e8 6b 05 00 00       	call   722 <sigprocmask>
 1b7:	83 c4 10             	add    $0x10,%esp
 1ba:	83 f8 ff             	cmp    $0xffffffff,%eax
 1bd:	74 12                	je     1d1 <test2+0x51>
		printf(1, "panic"); 
 1bf:	83 ec 08             	sub    $0x8,%esp
 1c2:	68 b4 0b 00 00       	push   $0xbb4
 1c7:	6a 01                	push   $0x1
 1c9:	e8 12 06 00 00       	call   7e0 <printf>
 1ce:	83 c4 10             	add    $0x10,%esp
}
 1d1:	c9                   	leave  
 1d2:	c3                   	ret    
 1d3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 1d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000001e0 <test3>:
void test3(){
 1e0:	55                   	push   %ebp
 1e1:	89 e5                	mov    %esp,%ebp
 1e3:	53                   	push   %ebx
	sigaction(signum, &act , &old); //check child inherit signal handlers of parent
 1e4:	8d 45 f0             	lea    -0x10(%ebp),%eax
void test3(){
 1e7:	83 ec 18             	sub    $0x18,%esp
    act.sa_handler = &signal_handler;
 1ea:	c7 45 e8 90 00 00 00 	movl   $0x90,-0x18(%ebp)
    act.sigmask = 0;
 1f1:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
	sigaction(signum, &act , &old); //check child inherit signal handlers of parent
 1f8:	50                   	push   %eax
 1f9:	8d 45 e8             	lea    -0x18(%ebp),%eax
 1fc:	50                   	push   %eax
 1fd:	6a 07                	push   $0x7
 1ff:	e8 26 05 00 00       	call   72a <sigaction>
	if((pid=fork()) == 0){	
 204:	e8 71 04 00 00       	call   67a <fork>
 209:	83 c4 10             	add    $0x10,%esp
 20c:	85 c0                	test   %eax,%eax
 20e:	0f 84 8c 00 00 00    	je     2a0 <test3+0xc0>
		sleep(100);
 214:	83 ec 0c             	sub    $0xc,%esp
 217:	89 c3                	mov    %eax,%ebx
 219:	6a 64                	push   $0x64
 21b:	e8 f2 04 00 00       	call   712 <sleep>
		kill(pid, signum);
 220:	58                   	pop    %eax
 221:	5a                   	pop    %edx
 222:	6a 07                	push   $0x7
 224:	53                   	push   %ebx
 225:	e8 88 04 00 00       	call   6b2 <kill>
		printf(1, "Sent signal %d to child\n", signum);
 22a:	83 c4 0c             	add    $0xc,%esp
 22d:	6a 07                	push   $0x7
 22f:	68 cb 0b 00 00       	push   $0xbcb
 234:	6a 01                	push   $0x1
 236:	e8 a5 05 00 00       	call   7e0 <printf>
		sleep(100);
 23b:	c7 04 24 64 00 00 00 	movl   $0x64,(%esp)
 242:	e8 cb 04 00 00       	call   712 <sleep>
		kill(pid, signum);
 247:	59                   	pop    %ecx
 248:	58                   	pop    %eax
 249:	6a 07                	push   $0x7
 24b:	53                   	push   %ebx
 24c:	e8 61 04 00 00       	call   6b2 <kill>
		printf(1, "Sent signal %d to child\n", signum);
 251:	83 c4 0c             	add    $0xc,%esp
 254:	6a 07                	push   $0x7
 256:	68 cb 0b 00 00       	push   $0xbcb
 25b:	6a 01                	push   $0x1
 25d:	e8 7e 05 00 00       	call   7e0 <printf>
		sleep(100);
 262:	c7 04 24 64 00 00 00 	movl   $0x64,(%esp)
 269:	e8 a4 04 00 00       	call   712 <sleep>
		kill(pid, SIGKILL);
 26e:	58                   	pop    %eax
 26f:	5a                   	pop    %edx
 270:	6a 09                	push   $0x9
 272:	53                   	push   %ebx
 273:	e8 3a 04 00 00       	call   6b2 <kill>
		sleep(100);
 278:	c7 04 24 64 00 00 00 	movl   $0x64,(%esp)
 27f:	e8 8e 04 00 00       	call   712 <sleep>
		printf(1, "Sent SIGKILL to child\n");
 284:	59                   	pop    %ecx
 285:	5b                   	pop    %ebx
 286:	68 9d 0b 00 00       	push   $0xb9d
 28b:	6a 01                	push   $0x1
 28d:	e8 4e 05 00 00       	call   7e0 <printf>
 292:	83 c4 10             	add    $0x10,%esp
}
 295:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 298:	c9                   	leave  
 299:	c3                   	ret    
 29a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
		printf(1, "Child Process\n");
 2a0:	83 ec 08             	sub    $0x8,%esp
 2a3:	68 60 0b 00 00       	push   $0xb60
 2a8:	6a 01                	push   $0x1
 2aa:	e8 31 05 00 00       	call   7e0 <printf>
		sleep(100);
 2af:	c7 04 24 64 00 00 00 	movl   $0x64,(%esp)
 2b6:	e8 57 04 00 00       	call   712 <sleep>
		sigprocmask(1<<signum);
 2bb:	c7 04 24 80 00 00 00 	movl   $0x80,(%esp)
 2c2:	e8 5b 04 00 00       	call   722 <sigprocmask>
		printf(1, "Block signal %d\n", signum);
 2c7:	83 c4 0c             	add    $0xc,%esp
 2ca:	6a 07                	push   $0x7
 2cc:	68 ba 0b 00 00       	push   $0xbba
 2d1:	6a 01                	push   $0x1
 2d3:	e8 08 05 00 00       	call   7e0 <printf>
		sleep(200);
 2d8:	c7 04 24 c8 00 00 00 	movl   $0xc8,(%esp)
 2df:	e8 2e 04 00 00       	call   712 <sleep>
 2e4:	83 c4 10             	add    $0x10,%esp
}
 2e7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 2ea:	c9                   	leave  
 2eb:	c3                   	ret    
 2ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000002f0 <test4>:
void test4(){
 2f0:	55                   	push   %ebp
 2f1:	89 e5                	mov    %esp,%ebp
 2f3:	56                   	push   %esi
 2f4:	53                   	push   %ebx
 2f5:	83 ec 10             	sub    $0x10,%esp
	act.sa_handler = signal_handler;
 2f8:	c7 45 e8 90 00 00 00 	movl   $0x90,-0x18(%ebp)
    act.sigmask = 0;
 2ff:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
	if((pid=fork()) == 0){	
 306:	e8 6f 03 00 00       	call   67a <fork>
 30b:	85 c0                	test   %eax,%eax
 30d:	0f 84 8d 00 00 00    	je     3a0 <test4+0xb0>
		sleep(100);
 313:	83 ec 0c             	sub    $0xc,%esp
 316:	89 c3                	mov    %eax,%ebx
 318:	6a 64                	push   $0x64
 31a:	e8 f3 03 00 00       	call   712 <sleep>
		kill(pid, signum);
 31f:	58                   	pop    %eax
 320:	5a                   	pop    %edx
 321:	6a 07                	push   $0x7
 323:	53                   	push   %ebx
 324:	e8 89 03 00 00       	call   6b2 <kill>
		printf(1, "Sent signal %d to child", signum);
 329:	83 c4 0c             	add    $0xc,%esp
 32c:	6a 07                	push   $0x7
 32e:	68 e4 0b 00 00       	push   $0xbe4
 333:	6a 01                	push   $0x1
 335:	e8 a6 04 00 00       	call   7e0 <printf>
		sleep(100);
 33a:	c7 04 24 64 00 00 00 	movl   $0x64,(%esp)
 341:	e8 cc 03 00 00       	call   712 <sleep>
		kill(pid, signum);
 346:	59                   	pop    %ecx
 347:	5e                   	pop    %esi
 348:	6a 07                	push   $0x7
 34a:	53                   	push   %ebx
 34b:	e8 62 03 00 00       	call   6b2 <kill>
		printf(1, "Sent signal %d to child", signum);
 350:	83 c4 0c             	add    $0xc,%esp
 353:	6a 07                	push   $0x7
 355:	68 e4 0b 00 00       	push   $0xbe4
 35a:	6a 01                	push   $0x1
 35c:	e8 7f 04 00 00       	call   7e0 <printf>
		sleep(100);
 361:	c7 04 24 64 00 00 00 	movl   $0x64,(%esp)
 368:	e8 a5 03 00 00       	call   712 <sleep>
		kill(pid, signum);
 36d:	58                   	pop    %eax
 36e:	5a                   	pop    %edx
 36f:	6a 07                	push   $0x7
 371:	53                   	push   %ebx
 372:	e8 3b 03 00 00       	call   6b2 <kill>
		printf(1, "Sent signal %d to child - suppose to kill it", signum);
 377:	83 c4 0c             	add    $0xc,%esp
 37a:	6a 07                	push   $0x7
 37c:	68 84 0c 00 00       	push   $0xc84
 381:	6a 01                	push   $0x1
 383:	e8 58 04 00 00       	call   7e0 <printf>
		sleep(100);
 388:	c7 04 24 64 00 00 00 	movl   $0x64,(%esp)
 38f:	e8 7e 03 00 00       	call   712 <sleep>
 394:	83 c4 10             	add    $0x10,%esp
}
 397:	8d 65 f8             	lea    -0x8(%ebp),%esp
 39a:	5b                   	pop    %ebx
 39b:	5e                   	pop    %esi
 39c:	5d                   	pop    %ebp
 39d:	c3                   	ret    
 39e:	66 90                	xchg   %ax,%ax
		printf(1, "Child Process\n");
 3a0:	83 ec 08             	sub    $0x8,%esp
		sigaction(signum, &act , &old);
 3a3:	8d 5d f0             	lea    -0x10(%ebp),%ebx
 3a6:	8d 75 e8             	lea    -0x18(%ebp),%esi
		printf(1, "Child Process\n");
 3a9:	68 60 0b 00 00       	push   $0xb60
 3ae:	6a 01                	push   $0x1
 3b0:	e8 2b 04 00 00       	call   7e0 <printf>
		sigaction(signum, &act , &old);
 3b5:	83 c4 0c             	add    $0xc,%esp
 3b8:	53                   	push   %ebx
 3b9:	56                   	push   %esi
 3ba:	6a 07                	push   $0x7
 3bc:	e8 69 03 00 00       	call   72a <sigaction>
		printf(1, "signal handler changed to be signal_handler\n");
 3c1:	59                   	pop    %ecx
 3c2:	58                   	pop    %eax
 3c3:	68 fc 0b 00 00       	push   $0xbfc
 3c8:	6a 01                	push   $0x1
 3ca:	e8 11 04 00 00       	call   7e0 <printf>
	    sleep(100);
 3cf:	c7 04 24 64 00 00 00 	movl   $0x64,(%esp)
 3d6:	e8 37 03 00 00       	call   712 <sleep>
		sigaction(signum, &act, null);
 3db:	83 c4 0c             	add    $0xc,%esp
		act.sa_handler = signal_handler_2;
 3de:	c7 45 e8 b0 00 00 00 	movl   $0xb0,-0x18(%ebp)
		sigaction(signum, &act, null);
 3e5:	6a 00                	push   $0x0
 3e7:	56                   	push   %esi
 3e8:	6a 07                	push   $0x7
 3ea:	e8 3b 03 00 00       	call   72a <sigaction>
		printf(1, "signal handler changed to be signal_handler2\n");
 3ef:	58                   	pop    %eax
 3f0:	5a                   	pop    %edx
 3f1:	68 2c 0c 00 00       	push   $0xc2c
 3f6:	6a 01                	push   $0x1
 3f8:	e8 e3 03 00 00       	call   7e0 <printf>
		sleep(100);
 3fd:	c7 04 24 64 00 00 00 	movl   $0x64,(%esp)
 404:	e8 09 03 00 00       	call   712 <sleep>
		sigaction(signum, &old, null);
 409:	83 c4 0c             	add    $0xc,%esp
 40c:	6a 00                	push   $0x0
 40e:	53                   	push   %ebx
 40f:	6a 07                	push   $0x7
 411:	e8 14 03 00 00       	call   72a <sigaction>
		printf(1, "signal handler changed to be SIGKILL\n");
 416:	59                   	pop    %ecx
 417:	5b                   	pop    %ebx
 418:	68 5c 0c 00 00       	push   $0xc5c
 41d:	e9 5f ff ff ff       	jmp    381 <test4+0x91>
 422:	66 90                	xchg   %ax,%ax
 424:	66 90                	xchg   %ax,%ax
 426:	66 90                	xchg   %ax,%ax
 428:	66 90                	xchg   %ax,%ax
 42a:	66 90                	xchg   %ax,%ax
 42c:	66 90                	xchg   %ax,%ax
 42e:	66 90                	xchg   %ax,%ax

00000430 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 430:	55                   	push   %ebp
 431:	89 e5                	mov    %esp,%ebp
 433:	53                   	push   %ebx
 434:	8b 45 08             	mov    0x8(%ebp),%eax
 437:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 43a:	89 c2                	mov    %eax,%edx
 43c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 440:	83 c1 01             	add    $0x1,%ecx
 443:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 447:	83 c2 01             	add    $0x1,%edx
 44a:	84 db                	test   %bl,%bl
 44c:	88 5a ff             	mov    %bl,-0x1(%edx)
 44f:	75 ef                	jne    440 <strcpy+0x10>
    ;
  return os;
}
 451:	5b                   	pop    %ebx
 452:	5d                   	pop    %ebp
 453:	c3                   	ret    
 454:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 45a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000460 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 460:	55                   	push   %ebp
 461:	89 e5                	mov    %esp,%ebp
 463:	53                   	push   %ebx
 464:	8b 55 08             	mov    0x8(%ebp),%edx
 467:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 46a:	0f b6 02             	movzbl (%edx),%eax
 46d:	0f b6 19             	movzbl (%ecx),%ebx
 470:	84 c0                	test   %al,%al
 472:	75 1c                	jne    490 <strcmp+0x30>
 474:	eb 2a                	jmp    4a0 <strcmp+0x40>
 476:	8d 76 00             	lea    0x0(%esi),%esi
 479:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 480:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 483:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 486:	83 c1 01             	add    $0x1,%ecx
 489:	0f b6 19             	movzbl (%ecx),%ebx
  while(*p && *p == *q)
 48c:	84 c0                	test   %al,%al
 48e:	74 10                	je     4a0 <strcmp+0x40>
 490:	38 d8                	cmp    %bl,%al
 492:	74 ec                	je     480 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
 494:	29 d8                	sub    %ebx,%eax
}
 496:	5b                   	pop    %ebx
 497:	5d                   	pop    %ebp
 498:	c3                   	ret    
 499:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 4a0:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 4a2:	29 d8                	sub    %ebx,%eax
}
 4a4:	5b                   	pop    %ebx
 4a5:	5d                   	pop    %ebp
 4a6:	c3                   	ret    
 4a7:	89 f6                	mov    %esi,%esi
 4a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000004b0 <strlen>:

uint
strlen(const char *s)
{
 4b0:	55                   	push   %ebp
 4b1:	89 e5                	mov    %esp,%ebp
 4b3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 4b6:	80 39 00             	cmpb   $0x0,(%ecx)
 4b9:	74 15                	je     4d0 <strlen+0x20>
 4bb:	31 d2                	xor    %edx,%edx
 4bd:	8d 76 00             	lea    0x0(%esi),%esi
 4c0:	83 c2 01             	add    $0x1,%edx
 4c3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 4c7:	89 d0                	mov    %edx,%eax
 4c9:	75 f5                	jne    4c0 <strlen+0x10>
    ;
  return n;
}
 4cb:	5d                   	pop    %ebp
 4cc:	c3                   	ret    
 4cd:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
 4d0:	31 c0                	xor    %eax,%eax
}
 4d2:	5d                   	pop    %ebp
 4d3:	c3                   	ret    
 4d4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 4da:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000004e0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 4e0:	55                   	push   %ebp
 4e1:	89 e5                	mov    %esp,%ebp
 4e3:	57                   	push   %edi
 4e4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 4e7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 4ea:	8b 45 0c             	mov    0xc(%ebp),%eax
 4ed:	89 d7                	mov    %edx,%edi
 4ef:	fc                   	cld    
 4f0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 4f2:	89 d0                	mov    %edx,%eax
 4f4:	5f                   	pop    %edi
 4f5:	5d                   	pop    %ebp
 4f6:	c3                   	ret    
 4f7:	89 f6                	mov    %esi,%esi
 4f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000500 <strchr>:

char*
strchr(const char *s, char c)
{
 500:	55                   	push   %ebp
 501:	89 e5                	mov    %esp,%ebp
 503:	53                   	push   %ebx
 504:	8b 45 08             	mov    0x8(%ebp),%eax
 507:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 50a:	0f b6 10             	movzbl (%eax),%edx
 50d:	84 d2                	test   %dl,%dl
 50f:	74 1d                	je     52e <strchr+0x2e>
    if(*s == c)
 511:	38 d3                	cmp    %dl,%bl
 513:	89 d9                	mov    %ebx,%ecx
 515:	75 0d                	jne    524 <strchr+0x24>
 517:	eb 17                	jmp    530 <strchr+0x30>
 519:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 520:	38 ca                	cmp    %cl,%dl
 522:	74 0c                	je     530 <strchr+0x30>
  for(; *s; s++)
 524:	83 c0 01             	add    $0x1,%eax
 527:	0f b6 10             	movzbl (%eax),%edx
 52a:	84 d2                	test   %dl,%dl
 52c:	75 f2                	jne    520 <strchr+0x20>
      return (char*)s;
  return 0;
 52e:	31 c0                	xor    %eax,%eax
}
 530:	5b                   	pop    %ebx
 531:	5d                   	pop    %ebp
 532:	c3                   	ret    
 533:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 539:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000540 <gets>:

char*
gets(char *buf, int max)
{
 540:	55                   	push   %ebp
 541:	89 e5                	mov    %esp,%ebp
 543:	57                   	push   %edi
 544:	56                   	push   %esi
 545:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 546:	31 f6                	xor    %esi,%esi
 548:	89 f3                	mov    %esi,%ebx
{
 54a:	83 ec 1c             	sub    $0x1c,%esp
 54d:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 550:	eb 2f                	jmp    581 <gets+0x41>
 552:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 558:	8d 45 e7             	lea    -0x19(%ebp),%eax
 55b:	83 ec 04             	sub    $0x4,%esp
 55e:	6a 01                	push   $0x1
 560:	50                   	push   %eax
 561:	6a 00                	push   $0x0
 563:	e8 32 01 00 00       	call   69a <read>
    if(cc < 1)
 568:	83 c4 10             	add    $0x10,%esp
 56b:	85 c0                	test   %eax,%eax
 56d:	7e 1c                	jle    58b <gets+0x4b>
      break;
    buf[i++] = c;
 56f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 573:	83 c7 01             	add    $0x1,%edi
 576:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 579:	3c 0a                	cmp    $0xa,%al
 57b:	74 23                	je     5a0 <gets+0x60>
 57d:	3c 0d                	cmp    $0xd,%al
 57f:	74 1f                	je     5a0 <gets+0x60>
  for(i=0; i+1 < max; ){
 581:	83 c3 01             	add    $0x1,%ebx
 584:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 587:	89 fe                	mov    %edi,%esi
 589:	7c cd                	jl     558 <gets+0x18>
 58b:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 58d:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 590:	c6 03 00             	movb   $0x0,(%ebx)
}
 593:	8d 65 f4             	lea    -0xc(%ebp),%esp
 596:	5b                   	pop    %ebx
 597:	5e                   	pop    %esi
 598:	5f                   	pop    %edi
 599:	5d                   	pop    %ebp
 59a:	c3                   	ret    
 59b:	90                   	nop
 59c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 5a0:	8b 75 08             	mov    0x8(%ebp),%esi
 5a3:	8b 45 08             	mov    0x8(%ebp),%eax
 5a6:	01 de                	add    %ebx,%esi
 5a8:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
 5aa:	c6 03 00             	movb   $0x0,(%ebx)
}
 5ad:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5b0:	5b                   	pop    %ebx
 5b1:	5e                   	pop    %esi
 5b2:	5f                   	pop    %edi
 5b3:	5d                   	pop    %ebp
 5b4:	c3                   	ret    
 5b5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 5b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000005c0 <stat>:

int
stat(const char *n, struct stat *st)
{
 5c0:	55                   	push   %ebp
 5c1:	89 e5                	mov    %esp,%ebp
 5c3:	56                   	push   %esi
 5c4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 5c5:	83 ec 08             	sub    $0x8,%esp
 5c8:	6a 00                	push   $0x0
 5ca:	ff 75 08             	pushl  0x8(%ebp)
 5cd:	e8 f0 00 00 00       	call   6c2 <open>
  if(fd < 0)
 5d2:	83 c4 10             	add    $0x10,%esp
 5d5:	85 c0                	test   %eax,%eax
 5d7:	78 27                	js     600 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 5d9:	83 ec 08             	sub    $0x8,%esp
 5dc:	ff 75 0c             	pushl  0xc(%ebp)
 5df:	89 c3                	mov    %eax,%ebx
 5e1:	50                   	push   %eax
 5e2:	e8 f3 00 00 00       	call   6da <fstat>
  close(fd);
 5e7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 5ea:	89 c6                	mov    %eax,%esi
  close(fd);
 5ec:	e8 b9 00 00 00       	call   6aa <close>
  return r;
 5f1:	83 c4 10             	add    $0x10,%esp
}
 5f4:	8d 65 f8             	lea    -0x8(%ebp),%esp
 5f7:	89 f0                	mov    %esi,%eax
 5f9:	5b                   	pop    %ebx
 5fa:	5e                   	pop    %esi
 5fb:	5d                   	pop    %ebp
 5fc:	c3                   	ret    
 5fd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 600:	be ff ff ff ff       	mov    $0xffffffff,%esi
 605:	eb ed                	jmp    5f4 <stat+0x34>
 607:	89 f6                	mov    %esi,%esi
 609:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000610 <atoi>:

int
atoi(const char *s)
{
 610:	55                   	push   %ebp
 611:	89 e5                	mov    %esp,%ebp
 613:	53                   	push   %ebx
 614:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 617:	0f be 11             	movsbl (%ecx),%edx
 61a:	8d 42 d0             	lea    -0x30(%edx),%eax
 61d:	3c 09                	cmp    $0x9,%al
  n = 0;
 61f:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 624:	77 1f                	ja     645 <atoi+0x35>
 626:	8d 76 00             	lea    0x0(%esi),%esi
 629:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 630:	8d 04 80             	lea    (%eax,%eax,4),%eax
 633:	83 c1 01             	add    $0x1,%ecx
 636:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 63a:	0f be 11             	movsbl (%ecx),%edx
 63d:	8d 5a d0             	lea    -0x30(%edx),%ebx
 640:	80 fb 09             	cmp    $0x9,%bl
 643:	76 eb                	jbe    630 <atoi+0x20>
  return n;
}
 645:	5b                   	pop    %ebx
 646:	5d                   	pop    %ebp
 647:	c3                   	ret    
 648:	90                   	nop
 649:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000650 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 650:	55                   	push   %ebp
 651:	89 e5                	mov    %esp,%ebp
 653:	56                   	push   %esi
 654:	53                   	push   %ebx
 655:	8b 5d 10             	mov    0x10(%ebp),%ebx
 658:	8b 45 08             	mov    0x8(%ebp),%eax
 65b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 65e:	85 db                	test   %ebx,%ebx
 660:	7e 14                	jle    676 <memmove+0x26>
 662:	31 d2                	xor    %edx,%edx
 664:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 668:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 66c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 66f:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 672:	39 d3                	cmp    %edx,%ebx
 674:	75 f2                	jne    668 <memmove+0x18>
  return vdst;
}
 676:	5b                   	pop    %ebx
 677:	5e                   	pop    %esi
 678:	5d                   	pop    %ebp
 679:	c3                   	ret    

0000067a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 67a:	b8 01 00 00 00       	mov    $0x1,%eax
 67f:	cd 40                	int    $0x40
 681:	c3                   	ret    

00000682 <exit>:
SYSCALL(exit)
 682:	b8 02 00 00 00       	mov    $0x2,%eax
 687:	cd 40                	int    $0x40
 689:	c3                   	ret    

0000068a <wait>:
SYSCALL(wait)
 68a:	b8 03 00 00 00       	mov    $0x3,%eax
 68f:	cd 40                	int    $0x40
 691:	c3                   	ret    

00000692 <pipe>:
SYSCALL(pipe)
 692:	b8 04 00 00 00       	mov    $0x4,%eax
 697:	cd 40                	int    $0x40
 699:	c3                   	ret    

0000069a <read>:
SYSCALL(read)
 69a:	b8 05 00 00 00       	mov    $0x5,%eax
 69f:	cd 40                	int    $0x40
 6a1:	c3                   	ret    

000006a2 <write>:
SYSCALL(write)
 6a2:	b8 10 00 00 00       	mov    $0x10,%eax
 6a7:	cd 40                	int    $0x40
 6a9:	c3                   	ret    

000006aa <close>:
SYSCALL(close)
 6aa:	b8 15 00 00 00       	mov    $0x15,%eax
 6af:	cd 40                	int    $0x40
 6b1:	c3                   	ret    

000006b2 <kill>:
SYSCALL(kill)
 6b2:	b8 06 00 00 00       	mov    $0x6,%eax
 6b7:	cd 40                	int    $0x40
 6b9:	c3                   	ret    

000006ba <exec>:
SYSCALL(exec)
 6ba:	b8 07 00 00 00       	mov    $0x7,%eax
 6bf:	cd 40                	int    $0x40
 6c1:	c3                   	ret    

000006c2 <open>:
SYSCALL(open)
 6c2:	b8 0f 00 00 00       	mov    $0xf,%eax
 6c7:	cd 40                	int    $0x40
 6c9:	c3                   	ret    

000006ca <mknod>:
SYSCALL(mknod)
 6ca:	b8 11 00 00 00       	mov    $0x11,%eax
 6cf:	cd 40                	int    $0x40
 6d1:	c3                   	ret    

000006d2 <unlink>:
SYSCALL(unlink)
 6d2:	b8 12 00 00 00       	mov    $0x12,%eax
 6d7:	cd 40                	int    $0x40
 6d9:	c3                   	ret    

000006da <fstat>:
SYSCALL(fstat)
 6da:	b8 08 00 00 00       	mov    $0x8,%eax
 6df:	cd 40                	int    $0x40
 6e1:	c3                   	ret    

000006e2 <link>:
SYSCALL(link)
 6e2:	b8 13 00 00 00       	mov    $0x13,%eax
 6e7:	cd 40                	int    $0x40
 6e9:	c3                   	ret    

000006ea <mkdir>:
SYSCALL(mkdir)
 6ea:	b8 14 00 00 00       	mov    $0x14,%eax
 6ef:	cd 40                	int    $0x40
 6f1:	c3                   	ret    

000006f2 <chdir>:
SYSCALL(chdir)
 6f2:	b8 09 00 00 00       	mov    $0x9,%eax
 6f7:	cd 40                	int    $0x40
 6f9:	c3                   	ret    

000006fa <dup>:
SYSCALL(dup)
 6fa:	b8 0a 00 00 00       	mov    $0xa,%eax
 6ff:	cd 40                	int    $0x40
 701:	c3                   	ret    

00000702 <getpid>:
SYSCALL(getpid)
 702:	b8 0b 00 00 00       	mov    $0xb,%eax
 707:	cd 40                	int    $0x40
 709:	c3                   	ret    

0000070a <sbrk>:
SYSCALL(sbrk)
 70a:	b8 0c 00 00 00       	mov    $0xc,%eax
 70f:	cd 40                	int    $0x40
 711:	c3                   	ret    

00000712 <sleep>:
SYSCALL(sleep)
 712:	b8 0d 00 00 00       	mov    $0xd,%eax
 717:	cd 40                	int    $0x40
 719:	c3                   	ret    

0000071a <uptime>:
SYSCALL(uptime)
 71a:	b8 0e 00 00 00       	mov    $0xe,%eax
 71f:	cd 40                	int    $0x40
 721:	c3                   	ret    

00000722 <sigprocmask>:
SYSCALL(sigprocmask)
 722:	b8 16 00 00 00       	mov    $0x16,%eax
 727:	cd 40                	int    $0x40
 729:	c3                   	ret    

0000072a <sigaction>:
SYSCALL(sigaction)
 72a:	b8 17 00 00 00       	mov    $0x17,%eax
 72f:	cd 40                	int    $0x40
 731:	c3                   	ret    

00000732 <sigret>:
SYSCALL(sigret)
 732:	b8 18 00 00 00       	mov    $0x18,%eax
 737:	cd 40                	int    $0x40
 739:	c3                   	ret    
 73a:	66 90                	xchg   %ax,%ax
 73c:	66 90                	xchg   %ax,%ax
 73e:	66 90                	xchg   %ax,%ax

00000740 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 740:	55                   	push   %ebp
 741:	89 e5                	mov    %esp,%ebp
 743:	57                   	push   %edi
 744:	56                   	push   %esi
 745:	53                   	push   %ebx
 746:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 749:	85 d2                	test   %edx,%edx
{
 74b:	89 45 c0             	mov    %eax,-0x40(%ebp)
    neg = 1;
    x = -xx;
 74e:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
 750:	79 76                	jns    7c8 <printint+0x88>
 752:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 756:	74 70                	je     7c8 <printint+0x88>
    x = -xx;
 758:	f7 d8                	neg    %eax
    neg = 1;
 75a:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 761:	31 f6                	xor    %esi,%esi
 763:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 766:	eb 0a                	jmp    772 <printint+0x32>
 768:	90                   	nop
 769:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
 770:	89 fe                	mov    %edi,%esi
 772:	31 d2                	xor    %edx,%edx
 774:	8d 7e 01             	lea    0x1(%esi),%edi
 777:	f7 f1                	div    %ecx
 779:	0f b6 92 5c 0d 00 00 	movzbl 0xd5c(%edx),%edx
  }while((x /= base) != 0);
 780:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 782:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
 785:	75 e9                	jne    770 <printint+0x30>
  if(neg)
 787:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 78a:	85 c0                	test   %eax,%eax
 78c:	74 08                	je     796 <printint+0x56>
    buf[i++] = '-';
 78e:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 793:	8d 7e 02             	lea    0x2(%esi),%edi
 796:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
 79a:	8b 7d c0             	mov    -0x40(%ebp),%edi
 79d:	8d 76 00             	lea    0x0(%esi),%esi
 7a0:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
 7a3:	83 ec 04             	sub    $0x4,%esp
 7a6:	83 ee 01             	sub    $0x1,%esi
 7a9:	6a 01                	push   $0x1
 7ab:	53                   	push   %ebx
 7ac:	57                   	push   %edi
 7ad:	88 45 d7             	mov    %al,-0x29(%ebp)
 7b0:	e8 ed fe ff ff       	call   6a2 <write>

  while(--i >= 0)
 7b5:	83 c4 10             	add    $0x10,%esp
 7b8:	39 de                	cmp    %ebx,%esi
 7ba:	75 e4                	jne    7a0 <printint+0x60>
    putc(fd, buf[i]);
}
 7bc:	8d 65 f4             	lea    -0xc(%ebp),%esp
 7bf:	5b                   	pop    %ebx
 7c0:	5e                   	pop    %esi
 7c1:	5f                   	pop    %edi
 7c2:	5d                   	pop    %ebp
 7c3:	c3                   	ret    
 7c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 7c8:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 7cf:	eb 90                	jmp    761 <printint+0x21>
 7d1:	eb 0d                	jmp    7e0 <printf>
 7d3:	90                   	nop
 7d4:	90                   	nop
 7d5:	90                   	nop
 7d6:	90                   	nop
 7d7:	90                   	nop
 7d8:	90                   	nop
 7d9:	90                   	nop
 7da:	90                   	nop
 7db:	90                   	nop
 7dc:	90                   	nop
 7dd:	90                   	nop
 7de:	90                   	nop
 7df:	90                   	nop

000007e0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 7e0:	55                   	push   %ebp
 7e1:	89 e5                	mov    %esp,%ebp
 7e3:	57                   	push   %edi
 7e4:	56                   	push   %esi
 7e5:	53                   	push   %ebx
 7e6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 7e9:	8b 75 0c             	mov    0xc(%ebp),%esi
 7ec:	0f b6 1e             	movzbl (%esi),%ebx
 7ef:	84 db                	test   %bl,%bl
 7f1:	0f 84 b3 00 00 00    	je     8aa <printf+0xca>
  ap = (uint*)(void*)&fmt + 1;
 7f7:	8d 45 10             	lea    0x10(%ebp),%eax
 7fa:	83 c6 01             	add    $0x1,%esi
  state = 0;
 7fd:	31 ff                	xor    %edi,%edi
  ap = (uint*)(void*)&fmt + 1;
 7ff:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 802:	eb 2f                	jmp    833 <printf+0x53>
 804:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 808:	83 f8 25             	cmp    $0x25,%eax
 80b:	0f 84 a7 00 00 00    	je     8b8 <printf+0xd8>
  write(fd, &c, 1);
 811:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 814:	83 ec 04             	sub    $0x4,%esp
 817:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 81a:	6a 01                	push   $0x1
 81c:	50                   	push   %eax
 81d:	ff 75 08             	pushl  0x8(%ebp)
 820:	e8 7d fe ff ff       	call   6a2 <write>
 825:	83 c4 10             	add    $0x10,%esp
 828:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
 82b:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 82f:	84 db                	test   %bl,%bl
 831:	74 77                	je     8aa <printf+0xca>
    if(state == 0){
 833:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
 835:	0f be cb             	movsbl %bl,%ecx
 838:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 83b:	74 cb                	je     808 <printf+0x28>
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 83d:	83 ff 25             	cmp    $0x25,%edi
 840:	75 e6                	jne    828 <printf+0x48>
      if(c == 'd'){
 842:	83 f8 64             	cmp    $0x64,%eax
 845:	0f 84 05 01 00 00    	je     950 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 84b:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 851:	83 f9 70             	cmp    $0x70,%ecx
 854:	74 72                	je     8c8 <printf+0xe8>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 856:	83 f8 73             	cmp    $0x73,%eax
 859:	0f 84 99 00 00 00    	je     8f8 <printf+0x118>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 85f:	83 f8 63             	cmp    $0x63,%eax
 862:	0f 84 08 01 00 00    	je     970 <printf+0x190>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 868:	83 f8 25             	cmp    $0x25,%eax
 86b:	0f 84 ef 00 00 00    	je     960 <printf+0x180>
  write(fd, &c, 1);
 871:	8d 45 e7             	lea    -0x19(%ebp),%eax
 874:	83 ec 04             	sub    $0x4,%esp
 877:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 87b:	6a 01                	push   $0x1
 87d:	50                   	push   %eax
 87e:	ff 75 08             	pushl  0x8(%ebp)
 881:	e8 1c fe ff ff       	call   6a2 <write>
 886:	83 c4 0c             	add    $0xc,%esp
 889:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 88c:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 88f:	6a 01                	push   $0x1
 891:	50                   	push   %eax
 892:	ff 75 08             	pushl  0x8(%ebp)
 895:	83 c6 01             	add    $0x1,%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 898:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 89a:	e8 03 fe ff ff       	call   6a2 <write>
  for(i = 0; fmt[i]; i++){
 89f:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
  write(fd, &c, 1);
 8a3:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 8a6:	84 db                	test   %bl,%bl
 8a8:	75 89                	jne    833 <printf+0x53>
    }
  }
}
 8aa:	8d 65 f4             	lea    -0xc(%ebp),%esp
 8ad:	5b                   	pop    %ebx
 8ae:	5e                   	pop    %esi
 8af:	5f                   	pop    %edi
 8b0:	5d                   	pop    %ebp
 8b1:	c3                   	ret    
 8b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        state = '%';
 8b8:	bf 25 00 00 00       	mov    $0x25,%edi
 8bd:	e9 66 ff ff ff       	jmp    828 <printf+0x48>
 8c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 8c8:	83 ec 0c             	sub    $0xc,%esp
 8cb:	b9 10 00 00 00       	mov    $0x10,%ecx
 8d0:	6a 00                	push   $0x0
 8d2:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 8d5:	8b 45 08             	mov    0x8(%ebp),%eax
 8d8:	8b 17                	mov    (%edi),%edx
 8da:	e8 61 fe ff ff       	call   740 <printint>
        ap++;
 8df:	89 f8                	mov    %edi,%eax
 8e1:	83 c4 10             	add    $0x10,%esp
      state = 0;
 8e4:	31 ff                	xor    %edi,%edi
        ap++;
 8e6:	83 c0 04             	add    $0x4,%eax
 8e9:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 8ec:	e9 37 ff ff ff       	jmp    828 <printf+0x48>
 8f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 8f8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 8fb:	8b 08                	mov    (%eax),%ecx
        ap++;
 8fd:	83 c0 04             	add    $0x4,%eax
 900:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 903:	85 c9                	test   %ecx,%ecx
 905:	0f 84 8e 00 00 00    	je     999 <printf+0x1b9>
        while(*s != 0){
 90b:	0f b6 01             	movzbl (%ecx),%eax
      state = 0;
 90e:	31 ff                	xor    %edi,%edi
        s = (char*)*ap;
 910:	89 cb                	mov    %ecx,%ebx
        while(*s != 0){
 912:	84 c0                	test   %al,%al
 914:	0f 84 0e ff ff ff    	je     828 <printf+0x48>
 91a:	89 75 d0             	mov    %esi,-0x30(%ebp)
 91d:	89 de                	mov    %ebx,%esi
 91f:	8b 5d 08             	mov    0x8(%ebp),%ebx
 922:	8d 7d e3             	lea    -0x1d(%ebp),%edi
 925:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 928:	83 ec 04             	sub    $0x4,%esp
          s++;
 92b:	83 c6 01             	add    $0x1,%esi
 92e:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 931:	6a 01                	push   $0x1
 933:	57                   	push   %edi
 934:	53                   	push   %ebx
 935:	e8 68 fd ff ff       	call   6a2 <write>
        while(*s != 0){
 93a:	0f b6 06             	movzbl (%esi),%eax
 93d:	83 c4 10             	add    $0x10,%esp
 940:	84 c0                	test   %al,%al
 942:	75 e4                	jne    928 <printf+0x148>
 944:	8b 75 d0             	mov    -0x30(%ebp),%esi
      state = 0;
 947:	31 ff                	xor    %edi,%edi
 949:	e9 da fe ff ff       	jmp    828 <printf+0x48>
 94e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 10, 1);
 950:	83 ec 0c             	sub    $0xc,%esp
 953:	b9 0a 00 00 00       	mov    $0xa,%ecx
 958:	6a 01                	push   $0x1
 95a:	e9 73 ff ff ff       	jmp    8d2 <printf+0xf2>
 95f:	90                   	nop
  write(fd, &c, 1);
 960:	83 ec 04             	sub    $0x4,%esp
 963:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 966:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 969:	6a 01                	push   $0x1
 96b:	e9 21 ff ff ff       	jmp    891 <printf+0xb1>
        putc(fd, *ap);
 970:	8b 7d d4             	mov    -0x2c(%ebp),%edi
  write(fd, &c, 1);
 973:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 976:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
 978:	6a 01                	push   $0x1
        ap++;
 97a:	83 c7 04             	add    $0x4,%edi
        putc(fd, *ap);
 97d:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 980:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 983:	50                   	push   %eax
 984:	ff 75 08             	pushl  0x8(%ebp)
 987:	e8 16 fd ff ff       	call   6a2 <write>
        ap++;
 98c:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 98f:	83 c4 10             	add    $0x10,%esp
      state = 0;
 992:	31 ff                	xor    %edi,%edi
 994:	e9 8f fe ff ff       	jmp    828 <printf+0x48>
          s = "(null)";
 999:	bb 54 0d 00 00       	mov    $0xd54,%ebx
        while(*s != 0){
 99e:	b8 28 00 00 00       	mov    $0x28,%eax
 9a3:	e9 72 ff ff ff       	jmp    91a <printf+0x13a>
 9a8:	66 90                	xchg   %ax,%ax
 9aa:	66 90                	xchg   %ax,%ax
 9ac:	66 90                	xchg   %ax,%ax
 9ae:	66 90                	xchg   %ax,%ax

000009b0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 9b0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9b1:	a1 e0 10 00 00       	mov    0x10e0,%eax
{
 9b6:	89 e5                	mov    %esp,%ebp
 9b8:	57                   	push   %edi
 9b9:	56                   	push   %esi
 9ba:	53                   	push   %ebx
 9bb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 9be:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 9c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9c8:	39 c8                	cmp    %ecx,%eax
 9ca:	8b 10                	mov    (%eax),%edx
 9cc:	73 32                	jae    a00 <free+0x50>
 9ce:	39 d1                	cmp    %edx,%ecx
 9d0:	72 04                	jb     9d6 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 9d2:	39 d0                	cmp    %edx,%eax
 9d4:	72 32                	jb     a08 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
 9d6:	8b 73 fc             	mov    -0x4(%ebx),%esi
 9d9:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 9dc:	39 fa                	cmp    %edi,%edx
 9de:	74 30                	je     a10 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 9e0:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 9e3:	8b 50 04             	mov    0x4(%eax),%edx
 9e6:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 9e9:	39 f1                	cmp    %esi,%ecx
 9eb:	74 3a                	je     a27 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 9ed:	89 08                	mov    %ecx,(%eax)
  freep = p;
 9ef:	a3 e0 10 00 00       	mov    %eax,0x10e0
}
 9f4:	5b                   	pop    %ebx
 9f5:	5e                   	pop    %esi
 9f6:	5f                   	pop    %edi
 9f7:	5d                   	pop    %ebp
 9f8:	c3                   	ret    
 9f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a00:	39 d0                	cmp    %edx,%eax
 a02:	72 04                	jb     a08 <free+0x58>
 a04:	39 d1                	cmp    %edx,%ecx
 a06:	72 ce                	jb     9d6 <free+0x26>
{
 a08:	89 d0                	mov    %edx,%eax
 a0a:	eb bc                	jmp    9c8 <free+0x18>
 a0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 a10:	03 72 04             	add    0x4(%edx),%esi
 a13:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 a16:	8b 10                	mov    (%eax),%edx
 a18:	8b 12                	mov    (%edx),%edx
 a1a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 a1d:	8b 50 04             	mov    0x4(%eax),%edx
 a20:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 a23:	39 f1                	cmp    %esi,%ecx
 a25:	75 c6                	jne    9ed <free+0x3d>
    p->s.size += bp->s.size;
 a27:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 a2a:	a3 e0 10 00 00       	mov    %eax,0x10e0
    p->s.size += bp->s.size;
 a2f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 a32:	8b 53 f8             	mov    -0x8(%ebx),%edx
 a35:	89 10                	mov    %edx,(%eax)
}
 a37:	5b                   	pop    %ebx
 a38:	5e                   	pop    %esi
 a39:	5f                   	pop    %edi
 a3a:	5d                   	pop    %ebp
 a3b:	c3                   	ret    
 a3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000a40 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 a40:	55                   	push   %ebp
 a41:	89 e5                	mov    %esp,%ebp
 a43:	57                   	push   %edi
 a44:	56                   	push   %esi
 a45:	53                   	push   %ebx
 a46:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a49:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 a4c:	8b 15 e0 10 00 00    	mov    0x10e0,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a52:	8d 78 07             	lea    0x7(%eax),%edi
 a55:	c1 ef 03             	shr    $0x3,%edi
 a58:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 a5b:	85 d2                	test   %edx,%edx
 a5d:	0f 84 9d 00 00 00    	je     b00 <malloc+0xc0>
 a63:	8b 02                	mov    (%edx),%eax
 a65:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 a68:	39 cf                	cmp    %ecx,%edi
 a6a:	76 6c                	jbe    ad8 <malloc+0x98>
 a6c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 a72:	bb 00 10 00 00       	mov    $0x1000,%ebx
 a77:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 a7a:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 a81:	eb 0e                	jmp    a91 <malloc+0x51>
 a83:	90                   	nop
 a84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a88:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 a8a:	8b 48 04             	mov    0x4(%eax),%ecx
 a8d:	39 f9                	cmp    %edi,%ecx
 a8f:	73 47                	jae    ad8 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 a91:	39 05 e0 10 00 00    	cmp    %eax,0x10e0
 a97:	89 c2                	mov    %eax,%edx
 a99:	75 ed                	jne    a88 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 a9b:	83 ec 0c             	sub    $0xc,%esp
 a9e:	56                   	push   %esi
 a9f:	e8 66 fc ff ff       	call   70a <sbrk>
  if(p == (char*)-1)
 aa4:	83 c4 10             	add    $0x10,%esp
 aa7:	83 f8 ff             	cmp    $0xffffffff,%eax
 aaa:	74 1c                	je     ac8 <malloc+0x88>
  hp->s.size = nu;
 aac:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 aaf:	83 ec 0c             	sub    $0xc,%esp
 ab2:	83 c0 08             	add    $0x8,%eax
 ab5:	50                   	push   %eax
 ab6:	e8 f5 fe ff ff       	call   9b0 <free>
  return freep;
 abb:	8b 15 e0 10 00 00    	mov    0x10e0,%edx
      if((p = morecore(nunits)) == 0)
 ac1:	83 c4 10             	add    $0x10,%esp
 ac4:	85 d2                	test   %edx,%edx
 ac6:	75 c0                	jne    a88 <malloc+0x48>
        return 0;
  }
}
 ac8:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 acb:	31 c0                	xor    %eax,%eax
}
 acd:	5b                   	pop    %ebx
 ace:	5e                   	pop    %esi
 acf:	5f                   	pop    %edi
 ad0:	5d                   	pop    %ebp
 ad1:	c3                   	ret    
 ad2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 ad8:	39 cf                	cmp    %ecx,%edi
 ada:	74 54                	je     b30 <malloc+0xf0>
        p->s.size -= nunits;
 adc:	29 f9                	sub    %edi,%ecx
 ade:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 ae1:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 ae4:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 ae7:	89 15 e0 10 00 00    	mov    %edx,0x10e0
}
 aed:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 af0:	83 c0 08             	add    $0x8,%eax
}
 af3:	5b                   	pop    %ebx
 af4:	5e                   	pop    %esi
 af5:	5f                   	pop    %edi
 af6:	5d                   	pop    %ebp
 af7:	c3                   	ret    
 af8:	90                   	nop
 af9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
 b00:	c7 05 e0 10 00 00 e4 	movl   $0x10e4,0x10e0
 b07:	10 00 00 
 b0a:	c7 05 e4 10 00 00 e4 	movl   $0x10e4,0x10e4
 b11:	10 00 00 
    base.s.size = 0;
 b14:	b8 e4 10 00 00       	mov    $0x10e4,%eax
 b19:	c7 05 e8 10 00 00 00 	movl   $0x0,0x10e8
 b20:	00 00 00 
 b23:	e9 44 ff ff ff       	jmp    a6c <malloc+0x2c>
 b28:	90                   	nop
 b29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
 b30:	8b 08                	mov    (%eax),%ecx
 b32:	89 0a                	mov    %ecx,(%edx)
 b34:	eb b1                	jmp    ae7 <malloc+0xa7>
