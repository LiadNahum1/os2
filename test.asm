
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
  11:	68 d4 0c 00 00       	push   $0xcd4
  16:	6a 01                	push   $0x1
  18:	e8 e3 07 00 00       	call   800 <printf>
	test1();
  1d:	e8 ae 00 00 00       	call   d0 <test1>
	sleep(400);
  22:	c7 04 24 90 01 00 00 	movl   $0x190,(%esp)
  29:	e8 04 07 00 00       	call   732 <sleep>
	printf(1, "---------------test 2---------------\n");
  2e:	58                   	pop    %eax
  2f:	5a                   	pop    %edx
  30:	68 fc 0c 00 00       	push   $0xcfc
  35:	6a 01                	push   $0x1
  37:	e8 c4 07 00 00       	call   800 <printf>
	test2();
  3c:	e8 3f 01 00 00       	call   180 <test2>
	sleep(400);
  41:	c7 04 24 90 01 00 00 	movl   $0x190,(%esp)
  48:	e8 e5 06 00 00       	call   732 <sleep>
	printf(1, "---------------test 3---------------\n");
  4d:	59                   	pop    %ecx
  4e:	58                   	pop    %eax
  4f:	68 24 0d 00 00       	push   $0xd24
  54:	6a 01                	push   $0x1
  56:	e8 a5 07 00 00       	call   800 <printf>
	test3();
  5b:	e8 80 01 00 00       	call   1e0 <test3>
	sleep(400);
  60:	c7 04 24 90 01 00 00 	movl   $0x190,(%esp)
  67:	e8 c6 06 00 00       	call   732 <sleep>
	printf(1, "---------------test 4---------------\n");
  6c:	58                   	pop    %eax
  6d:	5a                   	pop    %edx
  6e:	68 4c 0d 00 00       	push   $0xd4c
  73:	6a 01                	push   $0x1
  75:	e8 86 07 00 00       	call   800 <printf>
	test4();
  7a:	e8 71 02 00 00       	call   2f0 <test4>
	sleep(400);
  7f:	c7 04 24 90 01 00 00 	movl   $0x190,(%esp)
  86:	e8 a7 06 00 00       	call   732 <sleep>
	exit();
  8b:	e8 12 06 00 00       	call   6a2 <exit>

00000090 <signal_handler>:
void signal_handler(int signum){
  90:	55                   	push   %ebp
  91:	89 e5                	mov    %esp,%ebp
  93:	83 ec 0c             	sub    $0xc,%esp
    printf(1, "In signal handler %d\n", signum);
  96:	ff 75 08             	pushl  0x8(%ebp)
  99:	68 58 0b 00 00       	push   $0xb58
  9e:	6a 01                	push   $0x1
  a0:	e8 5b 07 00 00       	call   800 <printf>
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
  b6:	68 6e 0b 00 00       	push   $0xb6e
  bb:	6a 01                	push   $0x1
  bd:	e8 3e 07 00 00       	call   800 <printf>
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
  d7:	e8 be 05 00 00       	call   69a <fork>
  dc:	85 c0                	test   %eax,%eax
  de:	75 20                	jne    100 <test1+0x30>
			printf(1, "Child Process\n");
  e0:	83 ec 08             	sub    $0x8,%esp
  e3:	68 80 0b 00 00       	push   $0xb80
  e8:	6a 01                	push   $0x1
  ea:	e8 11 07 00 00       	call   800 <printf>
			sleep(50);
  ef:	c7 04 24 32 00 00 00 	movl   $0x32,(%esp)
  f6:	e8 37 06 00 00       	call   732 <sleep>
  fb:	83 c4 10             	add    $0x10,%esp
  fe:	eb e0                	jmp    e0 <test1+0x10>
		sleep(100);
 100:	83 ec 0c             	sub    $0xc,%esp
 103:	89 c3                	mov    %eax,%ebx
 105:	6a 64                	push   $0x64
 107:	e8 26 06 00 00       	call   732 <sleep>
		kill(pid, SIGSTOP);
 10c:	58                   	pop    %eax
 10d:	5a                   	pop    %edx
 10e:	6a 11                	push   $0x11
 110:	53                   	push   %ebx
 111:	e8 bc 05 00 00       	call   6d2 <kill>
		printf(1, "Sent SIGSTOP to child\n");
 116:	59                   	pop    %ecx
 117:	58                   	pop    %eax
 118:	68 8f 0b 00 00       	push   $0xb8f
 11d:	6a 01                	push   $0x1
 11f:	e8 dc 06 00 00       	call   800 <printf>
		sleep(100);
 124:	c7 04 24 64 00 00 00 	movl   $0x64,(%esp)
 12b:	e8 02 06 00 00       	call   732 <sleep>
		kill(pid, SIGCONT);
 130:	58                   	pop    %eax
 131:	5a                   	pop    %edx
 132:	6a 13                	push   $0x13
 134:	53                   	push   %ebx
 135:	e8 98 05 00 00       	call   6d2 <kill>
		printf(1, "Sent SIGCONT to child\n");
 13a:	59                   	pop    %ecx
 13b:	58                   	pop    %eax
 13c:	68 a6 0b 00 00       	push   $0xba6
 141:	6a 01                	push   $0x1
 143:	e8 b8 06 00 00       	call   800 <printf>
		sleep(100);
 148:	c7 04 24 64 00 00 00 	movl   $0x64,(%esp)
 14f:	e8 de 05 00 00       	call   732 <sleep>
		kill(pid, SIGKILL);
 154:	58                   	pop    %eax
 155:	5a                   	pop    %edx
 156:	6a 09                	push   $0x9
 158:	53                   	push   %ebx
 159:	e8 74 05 00 00       	call   6d2 <kill>
		printf(1, "Sent SIGKILL to child\n");
 15e:	59                   	pop    %ecx
 15f:	5b                   	pop    %ebx
 160:	68 bd 0b 00 00       	push   $0xbbd
 165:	6a 01                	push   $0x1
 167:	e8 94 06 00 00       	call   800 <printf>
		wait();
 16c:	83 c4 10             	add    $0x10,%esp
}
 16f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 172:	c9                   	leave  
		wait();
 173:	e9 32 05 00 00       	jmp    6aa <wait>
 178:	90                   	nop
 179:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000180 <test2>:
void test2(){
 180:	55                   	push   %ebp
 181:	89 e5                	mov    %esp,%ebp
 183:	83 ec 14             	sub    $0x14,%esp
	if(sigprocmask(1<<SIGSTOP) != -1)
 186:	68 00 00 02 00       	push   $0x20000
 18b:	e8 b2 05 00 00       	call   742 <sigprocmask>
 190:	83 c4 10             	add    $0x10,%esp
 193:	83 f8 ff             	cmp    $0xffffffff,%eax
 196:	74 12                	je     1aa <test2+0x2a>
		printf(1, "panic"); 
 198:	83 ec 08             	sub    $0x8,%esp
 19b:	68 d4 0b 00 00       	push   $0xbd4
 1a0:	6a 01                	push   $0x1
 1a2:	e8 59 06 00 00       	call   800 <printf>
 1a7:	83 c4 10             	add    $0x10,%esp
	if(sigprocmask(1<<SIGKILL) != -1)
 1aa:	83 ec 0c             	sub    $0xc,%esp
 1ad:	68 00 02 00 00       	push   $0x200
 1b2:	e8 8b 05 00 00       	call   742 <sigprocmask>
 1b7:	83 c4 10             	add    $0x10,%esp
 1ba:	83 f8 ff             	cmp    $0xffffffff,%eax
 1bd:	74 12                	je     1d1 <test2+0x51>
		printf(1, "panic"); 
 1bf:	83 ec 08             	sub    $0x8,%esp
 1c2:	68 d4 0b 00 00       	push   $0xbd4
 1c7:	6a 01                	push   $0x1
 1c9:	e8 32 06 00 00       	call   800 <printf>
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
 1ff:	e8 46 05 00 00       	call   74a <sigaction>
	if((pid=fork()) == 0){	
 204:	e8 91 04 00 00       	call   69a <fork>
 209:	83 c4 10             	add    $0x10,%esp
 20c:	85 c0                	test   %eax,%eax
 20e:	0f 84 8c 00 00 00    	je     2a0 <test3+0xc0>
		sleep(100);
 214:	83 ec 0c             	sub    $0xc,%esp
 217:	89 c3                	mov    %eax,%ebx
 219:	6a 64                	push   $0x64
 21b:	e8 12 05 00 00       	call   732 <sleep>
		kill(pid, signum);
 220:	58                   	pop    %eax
 221:	5a                   	pop    %edx
 222:	6a 07                	push   $0x7
 224:	53                   	push   %ebx
 225:	e8 a8 04 00 00       	call   6d2 <kill>
		printf(1, "Sent signal %d to child\n", signum);
 22a:	83 c4 0c             	add    $0xc,%esp
 22d:	6a 07                	push   $0x7
 22f:	68 eb 0b 00 00       	push   $0xbeb
 234:	6a 01                	push   $0x1
 236:	e8 c5 05 00 00       	call   800 <printf>
		sleep(100);
 23b:	c7 04 24 64 00 00 00 	movl   $0x64,(%esp)
 242:	e8 eb 04 00 00       	call   732 <sleep>
		kill(pid, signum);
 247:	59                   	pop    %ecx
 248:	58                   	pop    %eax
 249:	6a 07                	push   $0x7
 24b:	53                   	push   %ebx
 24c:	e8 81 04 00 00       	call   6d2 <kill>
		printf(1, "Sent signal %d to child\n", signum);
 251:	83 c4 0c             	add    $0xc,%esp
 254:	6a 07                	push   $0x7
 256:	68 eb 0b 00 00       	push   $0xbeb
 25b:	6a 01                	push   $0x1
 25d:	e8 9e 05 00 00       	call   800 <printf>
		sleep(100);
 262:	c7 04 24 64 00 00 00 	movl   $0x64,(%esp)
 269:	e8 c4 04 00 00       	call   732 <sleep>
		kill(pid, SIGKILL);
 26e:	58                   	pop    %eax
 26f:	5a                   	pop    %edx
 270:	6a 09                	push   $0x9
 272:	53                   	push   %ebx
 273:	e8 5a 04 00 00       	call   6d2 <kill>
		sleep(100);
 278:	c7 04 24 64 00 00 00 	movl   $0x64,(%esp)
 27f:	e8 ae 04 00 00       	call   732 <sleep>
		printf(1, "Sent SIGKILL to child\n");
 284:	59                   	pop    %ecx
 285:	5b                   	pop    %ebx
 286:	68 bd 0b 00 00       	push   $0xbbd
 28b:	6a 01                	push   $0x1
 28d:	e8 6e 05 00 00       	call   800 <printf>
		wait();
 292:	e8 13 04 00 00       	call   6aa <wait>
 297:	83 c4 10             	add    $0x10,%esp
}
 29a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 29d:	c9                   	leave  
 29e:	c3                   	ret    
 29f:	90                   	nop
		printf(1, "Child Process\n");
 2a0:	83 ec 08             	sub    $0x8,%esp
 2a3:	68 80 0b 00 00       	push   $0xb80
 2a8:	6a 01                	push   $0x1
 2aa:	e8 51 05 00 00       	call   800 <printf>
		sleep(100);
 2af:	c7 04 24 64 00 00 00 	movl   $0x64,(%esp)
 2b6:	e8 77 04 00 00       	call   732 <sleep>
		sigprocmask(1<<signum);
 2bb:	c7 04 24 80 00 00 00 	movl   $0x80,(%esp)
 2c2:	e8 7b 04 00 00       	call   742 <sigprocmask>
		printf(1, "Block signal %d\n", signum);
 2c7:	83 c4 0c             	add    $0xc,%esp
 2ca:	6a 07                	push   $0x7
 2cc:	68 da 0b 00 00       	push   $0xbda
 2d1:	6a 01                	push   $0x1
 2d3:	e8 28 05 00 00       	call   800 <printf>
		sleep(200);
 2d8:	c7 04 24 c8 00 00 00 	movl   $0xc8,(%esp)
 2df:	e8 4e 04 00 00       	call   732 <sleep>
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
 306:	e8 8f 03 00 00       	call   69a <fork>
 30b:	85 c0                	test   %eax,%eax
 30d:	0f 84 95 00 00 00    	je     3a8 <test4+0xb8>
		sleep(100);
 313:	83 ec 0c             	sub    $0xc,%esp
 316:	89 c3                	mov    %eax,%ebx
 318:	6a 64                	push   $0x64
 31a:	e8 13 04 00 00       	call   732 <sleep>
		kill(pid, signum);
 31f:	58                   	pop    %eax
 320:	5a                   	pop    %edx
 321:	6a 07                	push   $0x7
 323:	53                   	push   %ebx
 324:	e8 a9 03 00 00       	call   6d2 <kill>
		printf(1, "Sent signal %d to child", signum);
 329:	83 c4 0c             	add    $0xc,%esp
 32c:	6a 07                	push   $0x7
 32e:	68 04 0c 00 00       	push   $0xc04
 333:	6a 01                	push   $0x1
 335:	e8 c6 04 00 00       	call   800 <printf>
		sleep(100);
 33a:	c7 04 24 64 00 00 00 	movl   $0x64,(%esp)
 341:	e8 ec 03 00 00       	call   732 <sleep>
		kill(pid, signum);
 346:	59                   	pop    %ecx
 347:	5e                   	pop    %esi
 348:	6a 07                	push   $0x7
 34a:	53                   	push   %ebx
 34b:	e8 82 03 00 00       	call   6d2 <kill>
		printf(1, "Sent signal %d to child", signum);
 350:	83 c4 0c             	add    $0xc,%esp
 353:	6a 07                	push   $0x7
 355:	68 04 0c 00 00       	push   $0xc04
 35a:	6a 01                	push   $0x1
 35c:	e8 9f 04 00 00       	call   800 <printf>
		sleep(100);
 361:	c7 04 24 64 00 00 00 	movl   $0x64,(%esp)
 368:	e8 c5 03 00 00       	call   732 <sleep>
		kill(pid, signum);
 36d:	58                   	pop    %eax
 36e:	5a                   	pop    %edx
 36f:	6a 07                	push   $0x7
 371:	53                   	push   %ebx
 372:	e8 5b 03 00 00       	call   6d2 <kill>
		printf(1, "Sent signal %d to child - suppose to kill it", signum);
 377:	83 c4 0c             	add    $0xc,%esp
 37a:	6a 07                	push   $0x7
 37c:	68 a4 0c 00 00       	push   $0xca4
 381:	6a 01                	push   $0x1
 383:	e8 78 04 00 00       	call   800 <printf>
		sleep(100);
 388:	c7 04 24 64 00 00 00 	movl   $0x64,(%esp)
 38f:	e8 9e 03 00 00       	call   732 <sleep>
		wait();
 394:	e8 11 03 00 00       	call   6aa <wait>
 399:	83 c4 10             	add    $0x10,%esp
}
 39c:	8d 65 f8             	lea    -0x8(%ebp),%esp
 39f:	5b                   	pop    %ebx
 3a0:	5e                   	pop    %esi
 3a1:	5d                   	pop    %ebp
 3a2:	c3                   	ret    
 3a3:	90                   	nop
 3a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		printf(1, "Child Process\n");
 3a8:	83 ec 08             	sub    $0x8,%esp
		sigaction(signum, &act , &old);
 3ab:	8d 5d f0             	lea    -0x10(%ebp),%ebx
 3ae:	8d 75 e8             	lea    -0x18(%ebp),%esi
		printf(1, "Child Process\n");
 3b1:	68 80 0b 00 00       	push   $0xb80
 3b6:	6a 01                	push   $0x1
 3b8:	e8 43 04 00 00       	call   800 <printf>
		sigaction(signum, &act , &old);
 3bd:	83 c4 0c             	add    $0xc,%esp
 3c0:	53                   	push   %ebx
 3c1:	56                   	push   %esi
 3c2:	6a 07                	push   $0x7
 3c4:	e8 81 03 00 00       	call   74a <sigaction>
		printf(1, "signal handler changed to be signal_handler\n");
 3c9:	59                   	pop    %ecx
 3ca:	58                   	pop    %eax
 3cb:	68 1c 0c 00 00       	push   $0xc1c
 3d0:	6a 01                	push   $0x1
 3d2:	e8 29 04 00 00       	call   800 <printf>
	    sleep(100);
 3d7:	c7 04 24 64 00 00 00 	movl   $0x64,(%esp)
 3de:	e8 4f 03 00 00       	call   732 <sleep>
		sigaction(signum, &act, null);
 3e3:	83 c4 0c             	add    $0xc,%esp
		act.sa_handler = signal_handler_2;
 3e6:	c7 45 e8 b0 00 00 00 	movl   $0xb0,-0x18(%ebp)
		sigaction(signum, &act, null);
 3ed:	6a 00                	push   $0x0
 3ef:	56                   	push   %esi
 3f0:	6a 07                	push   $0x7
 3f2:	e8 53 03 00 00       	call   74a <sigaction>
		printf(1, "signal handler changed to be signal_handler2\n");
 3f7:	58                   	pop    %eax
 3f8:	5a                   	pop    %edx
 3f9:	68 4c 0c 00 00       	push   $0xc4c
 3fe:	6a 01                	push   $0x1
 400:	e8 fb 03 00 00       	call   800 <printf>
		sleep(100);
 405:	c7 04 24 64 00 00 00 	movl   $0x64,(%esp)
 40c:	e8 21 03 00 00       	call   732 <sleep>
		sigaction(signum, &old, null);
 411:	83 c4 0c             	add    $0xc,%esp
 414:	6a 00                	push   $0x0
 416:	53                   	push   %ebx
 417:	6a 07                	push   $0x7
 419:	e8 2c 03 00 00       	call   74a <sigaction>
		printf(1, "signal handler changed to be SIGKILL\n");
 41e:	59                   	pop    %ecx
 41f:	5b                   	pop    %ebx
 420:	68 7c 0c 00 00       	push   $0xc7c
 425:	6a 01                	push   $0x1
 427:	e8 d4 03 00 00       	call   800 <printf>
		sleep(100);
 42c:	c7 04 24 64 00 00 00 	movl   $0x64,(%esp)
 433:	e8 fa 02 00 00       	call   732 <sleep>
 438:	83 c4 10             	add    $0x10,%esp
}
 43b:	8d 65 f8             	lea    -0x8(%ebp),%esp
 43e:	5b                   	pop    %ebx
 43f:	5e                   	pop    %esi
 440:	5d                   	pop    %ebp
 441:	c3                   	ret    
 442:	66 90                	xchg   %ax,%ax
 444:	66 90                	xchg   %ax,%ax
 446:	66 90                	xchg   %ax,%ax
 448:	66 90                	xchg   %ax,%ax
 44a:	66 90                	xchg   %ax,%ax
 44c:	66 90                	xchg   %ax,%ax
 44e:	66 90                	xchg   %ax,%ax

00000450 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 450:	55                   	push   %ebp
 451:	89 e5                	mov    %esp,%ebp
 453:	53                   	push   %ebx
 454:	8b 45 08             	mov    0x8(%ebp),%eax
 457:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 45a:	89 c2                	mov    %eax,%edx
 45c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 460:	83 c1 01             	add    $0x1,%ecx
 463:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 467:	83 c2 01             	add    $0x1,%edx
 46a:	84 db                	test   %bl,%bl
 46c:	88 5a ff             	mov    %bl,-0x1(%edx)
 46f:	75 ef                	jne    460 <strcpy+0x10>
    ;
  return os;
}
 471:	5b                   	pop    %ebx
 472:	5d                   	pop    %ebp
 473:	c3                   	ret    
 474:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 47a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000480 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 480:	55                   	push   %ebp
 481:	89 e5                	mov    %esp,%ebp
 483:	53                   	push   %ebx
 484:	8b 55 08             	mov    0x8(%ebp),%edx
 487:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 48a:	0f b6 02             	movzbl (%edx),%eax
 48d:	0f b6 19             	movzbl (%ecx),%ebx
 490:	84 c0                	test   %al,%al
 492:	75 1c                	jne    4b0 <strcmp+0x30>
 494:	eb 2a                	jmp    4c0 <strcmp+0x40>
 496:	8d 76 00             	lea    0x0(%esi),%esi
 499:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 4a0:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 4a3:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 4a6:	83 c1 01             	add    $0x1,%ecx
 4a9:	0f b6 19             	movzbl (%ecx),%ebx
  while(*p && *p == *q)
 4ac:	84 c0                	test   %al,%al
 4ae:	74 10                	je     4c0 <strcmp+0x40>
 4b0:	38 d8                	cmp    %bl,%al
 4b2:	74 ec                	je     4a0 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
 4b4:	29 d8                	sub    %ebx,%eax
}
 4b6:	5b                   	pop    %ebx
 4b7:	5d                   	pop    %ebp
 4b8:	c3                   	ret    
 4b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 4c0:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 4c2:	29 d8                	sub    %ebx,%eax
}
 4c4:	5b                   	pop    %ebx
 4c5:	5d                   	pop    %ebp
 4c6:	c3                   	ret    
 4c7:	89 f6                	mov    %esi,%esi
 4c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000004d0 <strlen>:

uint
strlen(const char *s)
{
 4d0:	55                   	push   %ebp
 4d1:	89 e5                	mov    %esp,%ebp
 4d3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 4d6:	80 39 00             	cmpb   $0x0,(%ecx)
 4d9:	74 15                	je     4f0 <strlen+0x20>
 4db:	31 d2                	xor    %edx,%edx
 4dd:	8d 76 00             	lea    0x0(%esi),%esi
 4e0:	83 c2 01             	add    $0x1,%edx
 4e3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 4e7:	89 d0                	mov    %edx,%eax
 4e9:	75 f5                	jne    4e0 <strlen+0x10>
    ;
  return n;
}
 4eb:	5d                   	pop    %ebp
 4ec:	c3                   	ret    
 4ed:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
 4f0:	31 c0                	xor    %eax,%eax
}
 4f2:	5d                   	pop    %ebp
 4f3:	c3                   	ret    
 4f4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 4fa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000500 <memset>:

void*
memset(void *dst, int c, uint n)
{
 500:	55                   	push   %ebp
 501:	89 e5                	mov    %esp,%ebp
 503:	57                   	push   %edi
 504:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 507:	8b 4d 10             	mov    0x10(%ebp),%ecx
 50a:	8b 45 0c             	mov    0xc(%ebp),%eax
 50d:	89 d7                	mov    %edx,%edi
 50f:	fc                   	cld    
 510:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 512:	89 d0                	mov    %edx,%eax
 514:	5f                   	pop    %edi
 515:	5d                   	pop    %ebp
 516:	c3                   	ret    
 517:	89 f6                	mov    %esi,%esi
 519:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000520 <strchr>:

char*
strchr(const char *s, char c)
{
 520:	55                   	push   %ebp
 521:	89 e5                	mov    %esp,%ebp
 523:	53                   	push   %ebx
 524:	8b 45 08             	mov    0x8(%ebp),%eax
 527:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 52a:	0f b6 10             	movzbl (%eax),%edx
 52d:	84 d2                	test   %dl,%dl
 52f:	74 1d                	je     54e <strchr+0x2e>
    if(*s == c)
 531:	38 d3                	cmp    %dl,%bl
 533:	89 d9                	mov    %ebx,%ecx
 535:	75 0d                	jne    544 <strchr+0x24>
 537:	eb 17                	jmp    550 <strchr+0x30>
 539:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 540:	38 ca                	cmp    %cl,%dl
 542:	74 0c                	je     550 <strchr+0x30>
  for(; *s; s++)
 544:	83 c0 01             	add    $0x1,%eax
 547:	0f b6 10             	movzbl (%eax),%edx
 54a:	84 d2                	test   %dl,%dl
 54c:	75 f2                	jne    540 <strchr+0x20>
      return (char*)s;
  return 0;
 54e:	31 c0                	xor    %eax,%eax
}
 550:	5b                   	pop    %ebx
 551:	5d                   	pop    %ebp
 552:	c3                   	ret    
 553:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 559:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000560 <gets>:

char*
gets(char *buf, int max)
{
 560:	55                   	push   %ebp
 561:	89 e5                	mov    %esp,%ebp
 563:	57                   	push   %edi
 564:	56                   	push   %esi
 565:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 566:	31 f6                	xor    %esi,%esi
 568:	89 f3                	mov    %esi,%ebx
{
 56a:	83 ec 1c             	sub    $0x1c,%esp
 56d:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 570:	eb 2f                	jmp    5a1 <gets+0x41>
 572:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 578:	8d 45 e7             	lea    -0x19(%ebp),%eax
 57b:	83 ec 04             	sub    $0x4,%esp
 57e:	6a 01                	push   $0x1
 580:	50                   	push   %eax
 581:	6a 00                	push   $0x0
 583:	e8 32 01 00 00       	call   6ba <read>
    if(cc < 1)
 588:	83 c4 10             	add    $0x10,%esp
 58b:	85 c0                	test   %eax,%eax
 58d:	7e 1c                	jle    5ab <gets+0x4b>
      break;
    buf[i++] = c;
 58f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 593:	83 c7 01             	add    $0x1,%edi
 596:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 599:	3c 0a                	cmp    $0xa,%al
 59b:	74 23                	je     5c0 <gets+0x60>
 59d:	3c 0d                	cmp    $0xd,%al
 59f:	74 1f                	je     5c0 <gets+0x60>
  for(i=0; i+1 < max; ){
 5a1:	83 c3 01             	add    $0x1,%ebx
 5a4:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 5a7:	89 fe                	mov    %edi,%esi
 5a9:	7c cd                	jl     578 <gets+0x18>
 5ab:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 5ad:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 5b0:	c6 03 00             	movb   $0x0,(%ebx)
}
 5b3:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5b6:	5b                   	pop    %ebx
 5b7:	5e                   	pop    %esi
 5b8:	5f                   	pop    %edi
 5b9:	5d                   	pop    %ebp
 5ba:	c3                   	ret    
 5bb:	90                   	nop
 5bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 5c0:	8b 75 08             	mov    0x8(%ebp),%esi
 5c3:	8b 45 08             	mov    0x8(%ebp),%eax
 5c6:	01 de                	add    %ebx,%esi
 5c8:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
 5ca:	c6 03 00             	movb   $0x0,(%ebx)
}
 5cd:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5d0:	5b                   	pop    %ebx
 5d1:	5e                   	pop    %esi
 5d2:	5f                   	pop    %edi
 5d3:	5d                   	pop    %ebp
 5d4:	c3                   	ret    
 5d5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 5d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000005e0 <stat>:

int
stat(const char *n, struct stat *st)
{
 5e0:	55                   	push   %ebp
 5e1:	89 e5                	mov    %esp,%ebp
 5e3:	56                   	push   %esi
 5e4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 5e5:	83 ec 08             	sub    $0x8,%esp
 5e8:	6a 00                	push   $0x0
 5ea:	ff 75 08             	pushl  0x8(%ebp)
 5ed:	e8 f0 00 00 00       	call   6e2 <open>
  if(fd < 0)
 5f2:	83 c4 10             	add    $0x10,%esp
 5f5:	85 c0                	test   %eax,%eax
 5f7:	78 27                	js     620 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 5f9:	83 ec 08             	sub    $0x8,%esp
 5fc:	ff 75 0c             	pushl  0xc(%ebp)
 5ff:	89 c3                	mov    %eax,%ebx
 601:	50                   	push   %eax
 602:	e8 f3 00 00 00       	call   6fa <fstat>
  close(fd);
 607:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 60a:	89 c6                	mov    %eax,%esi
  close(fd);
 60c:	e8 b9 00 00 00       	call   6ca <close>
  return r;
 611:	83 c4 10             	add    $0x10,%esp
}
 614:	8d 65 f8             	lea    -0x8(%ebp),%esp
 617:	89 f0                	mov    %esi,%eax
 619:	5b                   	pop    %ebx
 61a:	5e                   	pop    %esi
 61b:	5d                   	pop    %ebp
 61c:	c3                   	ret    
 61d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 620:	be ff ff ff ff       	mov    $0xffffffff,%esi
 625:	eb ed                	jmp    614 <stat+0x34>
 627:	89 f6                	mov    %esi,%esi
 629:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000630 <atoi>:

int
atoi(const char *s)
{
 630:	55                   	push   %ebp
 631:	89 e5                	mov    %esp,%ebp
 633:	53                   	push   %ebx
 634:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 637:	0f be 11             	movsbl (%ecx),%edx
 63a:	8d 42 d0             	lea    -0x30(%edx),%eax
 63d:	3c 09                	cmp    $0x9,%al
  n = 0;
 63f:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 644:	77 1f                	ja     665 <atoi+0x35>
 646:	8d 76 00             	lea    0x0(%esi),%esi
 649:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 650:	8d 04 80             	lea    (%eax,%eax,4),%eax
 653:	83 c1 01             	add    $0x1,%ecx
 656:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 65a:	0f be 11             	movsbl (%ecx),%edx
 65d:	8d 5a d0             	lea    -0x30(%edx),%ebx
 660:	80 fb 09             	cmp    $0x9,%bl
 663:	76 eb                	jbe    650 <atoi+0x20>
  return n;
}
 665:	5b                   	pop    %ebx
 666:	5d                   	pop    %ebp
 667:	c3                   	ret    
 668:	90                   	nop
 669:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000670 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 670:	55                   	push   %ebp
 671:	89 e5                	mov    %esp,%ebp
 673:	56                   	push   %esi
 674:	53                   	push   %ebx
 675:	8b 5d 10             	mov    0x10(%ebp),%ebx
 678:	8b 45 08             	mov    0x8(%ebp),%eax
 67b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 67e:	85 db                	test   %ebx,%ebx
 680:	7e 14                	jle    696 <memmove+0x26>
 682:	31 d2                	xor    %edx,%edx
 684:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 688:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 68c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 68f:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 692:	39 d3                	cmp    %edx,%ebx
 694:	75 f2                	jne    688 <memmove+0x18>
  return vdst;
}
 696:	5b                   	pop    %ebx
 697:	5e                   	pop    %esi
 698:	5d                   	pop    %ebp
 699:	c3                   	ret    

0000069a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 69a:	b8 01 00 00 00       	mov    $0x1,%eax
 69f:	cd 40                	int    $0x40
 6a1:	c3                   	ret    

000006a2 <exit>:
SYSCALL(exit)
 6a2:	b8 02 00 00 00       	mov    $0x2,%eax
 6a7:	cd 40                	int    $0x40
 6a9:	c3                   	ret    

000006aa <wait>:
SYSCALL(wait)
 6aa:	b8 03 00 00 00       	mov    $0x3,%eax
 6af:	cd 40                	int    $0x40
 6b1:	c3                   	ret    

000006b2 <pipe>:
SYSCALL(pipe)
 6b2:	b8 04 00 00 00       	mov    $0x4,%eax
 6b7:	cd 40                	int    $0x40
 6b9:	c3                   	ret    

000006ba <read>:
SYSCALL(read)
 6ba:	b8 05 00 00 00       	mov    $0x5,%eax
 6bf:	cd 40                	int    $0x40
 6c1:	c3                   	ret    

000006c2 <write>:
SYSCALL(write)
 6c2:	b8 10 00 00 00       	mov    $0x10,%eax
 6c7:	cd 40                	int    $0x40
 6c9:	c3                   	ret    

000006ca <close>:
SYSCALL(close)
 6ca:	b8 15 00 00 00       	mov    $0x15,%eax
 6cf:	cd 40                	int    $0x40
 6d1:	c3                   	ret    

000006d2 <kill>:
SYSCALL(kill)
 6d2:	b8 06 00 00 00       	mov    $0x6,%eax
 6d7:	cd 40                	int    $0x40
 6d9:	c3                   	ret    

000006da <exec>:
SYSCALL(exec)
 6da:	b8 07 00 00 00       	mov    $0x7,%eax
 6df:	cd 40                	int    $0x40
 6e1:	c3                   	ret    

000006e2 <open>:
SYSCALL(open)
 6e2:	b8 0f 00 00 00       	mov    $0xf,%eax
 6e7:	cd 40                	int    $0x40
 6e9:	c3                   	ret    

000006ea <mknod>:
SYSCALL(mknod)
 6ea:	b8 11 00 00 00       	mov    $0x11,%eax
 6ef:	cd 40                	int    $0x40
 6f1:	c3                   	ret    

000006f2 <unlink>:
SYSCALL(unlink)
 6f2:	b8 12 00 00 00       	mov    $0x12,%eax
 6f7:	cd 40                	int    $0x40
 6f9:	c3                   	ret    

000006fa <fstat>:
SYSCALL(fstat)
 6fa:	b8 08 00 00 00       	mov    $0x8,%eax
 6ff:	cd 40                	int    $0x40
 701:	c3                   	ret    

00000702 <link>:
SYSCALL(link)
 702:	b8 13 00 00 00       	mov    $0x13,%eax
 707:	cd 40                	int    $0x40
 709:	c3                   	ret    

0000070a <mkdir>:
SYSCALL(mkdir)
 70a:	b8 14 00 00 00       	mov    $0x14,%eax
 70f:	cd 40                	int    $0x40
 711:	c3                   	ret    

00000712 <chdir>:
SYSCALL(chdir)
 712:	b8 09 00 00 00       	mov    $0x9,%eax
 717:	cd 40                	int    $0x40
 719:	c3                   	ret    

0000071a <dup>:
SYSCALL(dup)
 71a:	b8 0a 00 00 00       	mov    $0xa,%eax
 71f:	cd 40                	int    $0x40
 721:	c3                   	ret    

00000722 <getpid>:
SYSCALL(getpid)
 722:	b8 0b 00 00 00       	mov    $0xb,%eax
 727:	cd 40                	int    $0x40
 729:	c3                   	ret    

0000072a <sbrk>:
SYSCALL(sbrk)
 72a:	b8 0c 00 00 00       	mov    $0xc,%eax
 72f:	cd 40                	int    $0x40
 731:	c3                   	ret    

00000732 <sleep>:
SYSCALL(sleep)
 732:	b8 0d 00 00 00       	mov    $0xd,%eax
 737:	cd 40                	int    $0x40
 739:	c3                   	ret    

0000073a <uptime>:
SYSCALL(uptime)
 73a:	b8 0e 00 00 00       	mov    $0xe,%eax
 73f:	cd 40                	int    $0x40
 741:	c3                   	ret    

00000742 <sigprocmask>:
SYSCALL(sigprocmask)
 742:	b8 16 00 00 00       	mov    $0x16,%eax
 747:	cd 40                	int    $0x40
 749:	c3                   	ret    

0000074a <sigaction>:
SYSCALL(sigaction)
 74a:	b8 17 00 00 00       	mov    $0x17,%eax
 74f:	cd 40                	int    $0x40
 751:	c3                   	ret    

00000752 <sigret>:
SYSCALL(sigret)
 752:	b8 18 00 00 00       	mov    $0x18,%eax
 757:	cd 40                	int    $0x40
 759:	c3                   	ret    
 75a:	66 90                	xchg   %ax,%ax
 75c:	66 90                	xchg   %ax,%ax
 75e:	66 90                	xchg   %ax,%ax

00000760 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 760:	55                   	push   %ebp
 761:	89 e5                	mov    %esp,%ebp
 763:	57                   	push   %edi
 764:	56                   	push   %esi
 765:	53                   	push   %ebx
 766:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 769:	85 d2                	test   %edx,%edx
{
 76b:	89 45 c0             	mov    %eax,-0x40(%ebp)
    neg = 1;
    x = -xx;
 76e:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
 770:	79 76                	jns    7e8 <printint+0x88>
 772:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 776:	74 70                	je     7e8 <printint+0x88>
    x = -xx;
 778:	f7 d8                	neg    %eax
    neg = 1;
 77a:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 781:	31 f6                	xor    %esi,%esi
 783:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 786:	eb 0a                	jmp    792 <printint+0x32>
 788:	90                   	nop
 789:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
 790:	89 fe                	mov    %edi,%esi
 792:	31 d2                	xor    %edx,%edx
 794:	8d 7e 01             	lea    0x1(%esi),%edi
 797:	f7 f1                	div    %ecx
 799:	0f b6 92 7c 0d 00 00 	movzbl 0xd7c(%edx),%edx
  }while((x /= base) != 0);
 7a0:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 7a2:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
 7a5:	75 e9                	jne    790 <printint+0x30>
  if(neg)
 7a7:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 7aa:	85 c0                	test   %eax,%eax
 7ac:	74 08                	je     7b6 <printint+0x56>
    buf[i++] = '-';
 7ae:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 7b3:	8d 7e 02             	lea    0x2(%esi),%edi
 7b6:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
 7ba:	8b 7d c0             	mov    -0x40(%ebp),%edi
 7bd:	8d 76 00             	lea    0x0(%esi),%esi
 7c0:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
 7c3:	83 ec 04             	sub    $0x4,%esp
 7c6:	83 ee 01             	sub    $0x1,%esi
 7c9:	6a 01                	push   $0x1
 7cb:	53                   	push   %ebx
 7cc:	57                   	push   %edi
 7cd:	88 45 d7             	mov    %al,-0x29(%ebp)
 7d0:	e8 ed fe ff ff       	call   6c2 <write>

  while(--i >= 0)
 7d5:	83 c4 10             	add    $0x10,%esp
 7d8:	39 de                	cmp    %ebx,%esi
 7da:	75 e4                	jne    7c0 <printint+0x60>
    putc(fd, buf[i]);
}
 7dc:	8d 65 f4             	lea    -0xc(%ebp),%esp
 7df:	5b                   	pop    %ebx
 7e0:	5e                   	pop    %esi
 7e1:	5f                   	pop    %edi
 7e2:	5d                   	pop    %ebp
 7e3:	c3                   	ret    
 7e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 7e8:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 7ef:	eb 90                	jmp    781 <printint+0x21>
 7f1:	eb 0d                	jmp    800 <printf>
 7f3:	90                   	nop
 7f4:	90                   	nop
 7f5:	90                   	nop
 7f6:	90                   	nop
 7f7:	90                   	nop
 7f8:	90                   	nop
 7f9:	90                   	nop
 7fa:	90                   	nop
 7fb:	90                   	nop
 7fc:	90                   	nop
 7fd:	90                   	nop
 7fe:	90                   	nop
 7ff:	90                   	nop

00000800 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 800:	55                   	push   %ebp
 801:	89 e5                	mov    %esp,%ebp
 803:	57                   	push   %edi
 804:	56                   	push   %esi
 805:	53                   	push   %ebx
 806:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 809:	8b 75 0c             	mov    0xc(%ebp),%esi
 80c:	0f b6 1e             	movzbl (%esi),%ebx
 80f:	84 db                	test   %bl,%bl
 811:	0f 84 b3 00 00 00    	je     8ca <printf+0xca>
  ap = (uint*)(void*)&fmt + 1;
 817:	8d 45 10             	lea    0x10(%ebp),%eax
 81a:	83 c6 01             	add    $0x1,%esi
  state = 0;
 81d:	31 ff                	xor    %edi,%edi
  ap = (uint*)(void*)&fmt + 1;
 81f:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 822:	eb 2f                	jmp    853 <printf+0x53>
 824:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 828:	83 f8 25             	cmp    $0x25,%eax
 82b:	0f 84 a7 00 00 00    	je     8d8 <printf+0xd8>
  write(fd, &c, 1);
 831:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 834:	83 ec 04             	sub    $0x4,%esp
 837:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 83a:	6a 01                	push   $0x1
 83c:	50                   	push   %eax
 83d:	ff 75 08             	pushl  0x8(%ebp)
 840:	e8 7d fe ff ff       	call   6c2 <write>
 845:	83 c4 10             	add    $0x10,%esp
 848:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
 84b:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 84f:	84 db                	test   %bl,%bl
 851:	74 77                	je     8ca <printf+0xca>
    if(state == 0){
 853:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
 855:	0f be cb             	movsbl %bl,%ecx
 858:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 85b:	74 cb                	je     828 <printf+0x28>
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 85d:	83 ff 25             	cmp    $0x25,%edi
 860:	75 e6                	jne    848 <printf+0x48>
      if(c == 'd'){
 862:	83 f8 64             	cmp    $0x64,%eax
 865:	0f 84 05 01 00 00    	je     970 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 86b:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 871:	83 f9 70             	cmp    $0x70,%ecx
 874:	74 72                	je     8e8 <printf+0xe8>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 876:	83 f8 73             	cmp    $0x73,%eax
 879:	0f 84 99 00 00 00    	je     918 <printf+0x118>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 87f:	83 f8 63             	cmp    $0x63,%eax
 882:	0f 84 08 01 00 00    	je     990 <printf+0x190>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 888:	83 f8 25             	cmp    $0x25,%eax
 88b:	0f 84 ef 00 00 00    	je     980 <printf+0x180>
  write(fd, &c, 1);
 891:	8d 45 e7             	lea    -0x19(%ebp),%eax
 894:	83 ec 04             	sub    $0x4,%esp
 897:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 89b:	6a 01                	push   $0x1
 89d:	50                   	push   %eax
 89e:	ff 75 08             	pushl  0x8(%ebp)
 8a1:	e8 1c fe ff ff       	call   6c2 <write>
 8a6:	83 c4 0c             	add    $0xc,%esp
 8a9:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 8ac:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 8af:	6a 01                	push   $0x1
 8b1:	50                   	push   %eax
 8b2:	ff 75 08             	pushl  0x8(%ebp)
 8b5:	83 c6 01             	add    $0x1,%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 8b8:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 8ba:	e8 03 fe ff ff       	call   6c2 <write>
  for(i = 0; fmt[i]; i++){
 8bf:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
  write(fd, &c, 1);
 8c3:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 8c6:	84 db                	test   %bl,%bl
 8c8:	75 89                	jne    853 <printf+0x53>
    }
  }
}
 8ca:	8d 65 f4             	lea    -0xc(%ebp),%esp
 8cd:	5b                   	pop    %ebx
 8ce:	5e                   	pop    %esi
 8cf:	5f                   	pop    %edi
 8d0:	5d                   	pop    %ebp
 8d1:	c3                   	ret    
 8d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        state = '%';
 8d8:	bf 25 00 00 00       	mov    $0x25,%edi
 8dd:	e9 66 ff ff ff       	jmp    848 <printf+0x48>
 8e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 8e8:	83 ec 0c             	sub    $0xc,%esp
 8eb:	b9 10 00 00 00       	mov    $0x10,%ecx
 8f0:	6a 00                	push   $0x0
 8f2:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 8f5:	8b 45 08             	mov    0x8(%ebp),%eax
 8f8:	8b 17                	mov    (%edi),%edx
 8fa:	e8 61 fe ff ff       	call   760 <printint>
        ap++;
 8ff:	89 f8                	mov    %edi,%eax
 901:	83 c4 10             	add    $0x10,%esp
      state = 0;
 904:	31 ff                	xor    %edi,%edi
        ap++;
 906:	83 c0 04             	add    $0x4,%eax
 909:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 90c:	e9 37 ff ff ff       	jmp    848 <printf+0x48>
 911:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 918:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 91b:	8b 08                	mov    (%eax),%ecx
        ap++;
 91d:	83 c0 04             	add    $0x4,%eax
 920:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 923:	85 c9                	test   %ecx,%ecx
 925:	0f 84 8e 00 00 00    	je     9b9 <printf+0x1b9>
        while(*s != 0){
 92b:	0f b6 01             	movzbl (%ecx),%eax
      state = 0;
 92e:	31 ff                	xor    %edi,%edi
        s = (char*)*ap;
 930:	89 cb                	mov    %ecx,%ebx
        while(*s != 0){
 932:	84 c0                	test   %al,%al
 934:	0f 84 0e ff ff ff    	je     848 <printf+0x48>
 93a:	89 75 d0             	mov    %esi,-0x30(%ebp)
 93d:	89 de                	mov    %ebx,%esi
 93f:	8b 5d 08             	mov    0x8(%ebp),%ebx
 942:	8d 7d e3             	lea    -0x1d(%ebp),%edi
 945:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 948:	83 ec 04             	sub    $0x4,%esp
          s++;
 94b:	83 c6 01             	add    $0x1,%esi
 94e:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 951:	6a 01                	push   $0x1
 953:	57                   	push   %edi
 954:	53                   	push   %ebx
 955:	e8 68 fd ff ff       	call   6c2 <write>
        while(*s != 0){
 95a:	0f b6 06             	movzbl (%esi),%eax
 95d:	83 c4 10             	add    $0x10,%esp
 960:	84 c0                	test   %al,%al
 962:	75 e4                	jne    948 <printf+0x148>
 964:	8b 75 d0             	mov    -0x30(%ebp),%esi
      state = 0;
 967:	31 ff                	xor    %edi,%edi
 969:	e9 da fe ff ff       	jmp    848 <printf+0x48>
 96e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 10, 1);
 970:	83 ec 0c             	sub    $0xc,%esp
 973:	b9 0a 00 00 00       	mov    $0xa,%ecx
 978:	6a 01                	push   $0x1
 97a:	e9 73 ff ff ff       	jmp    8f2 <printf+0xf2>
 97f:	90                   	nop
  write(fd, &c, 1);
 980:	83 ec 04             	sub    $0x4,%esp
 983:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 986:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 989:	6a 01                	push   $0x1
 98b:	e9 21 ff ff ff       	jmp    8b1 <printf+0xb1>
        putc(fd, *ap);
 990:	8b 7d d4             	mov    -0x2c(%ebp),%edi
  write(fd, &c, 1);
 993:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 996:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
 998:	6a 01                	push   $0x1
        ap++;
 99a:	83 c7 04             	add    $0x4,%edi
        putc(fd, *ap);
 99d:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 9a0:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 9a3:	50                   	push   %eax
 9a4:	ff 75 08             	pushl  0x8(%ebp)
 9a7:	e8 16 fd ff ff       	call   6c2 <write>
        ap++;
 9ac:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 9af:	83 c4 10             	add    $0x10,%esp
      state = 0;
 9b2:	31 ff                	xor    %edi,%edi
 9b4:	e9 8f fe ff ff       	jmp    848 <printf+0x48>
          s = "(null)";
 9b9:	bb 74 0d 00 00       	mov    $0xd74,%ebx
        while(*s != 0){
 9be:	b8 28 00 00 00       	mov    $0x28,%eax
 9c3:	e9 72 ff ff ff       	jmp    93a <printf+0x13a>
 9c8:	66 90                	xchg   %ax,%ax
 9ca:	66 90                	xchg   %ax,%ax
 9cc:	66 90                	xchg   %ax,%ax
 9ce:	66 90                	xchg   %ax,%ax

000009d0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 9d0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9d1:	a1 0c 11 00 00       	mov    0x110c,%eax
{
 9d6:	89 e5                	mov    %esp,%ebp
 9d8:	57                   	push   %edi
 9d9:	56                   	push   %esi
 9da:	53                   	push   %ebx
 9db:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 9de:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 9e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9e8:	39 c8                	cmp    %ecx,%eax
 9ea:	8b 10                	mov    (%eax),%edx
 9ec:	73 32                	jae    a20 <free+0x50>
 9ee:	39 d1                	cmp    %edx,%ecx
 9f0:	72 04                	jb     9f6 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 9f2:	39 d0                	cmp    %edx,%eax
 9f4:	72 32                	jb     a28 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
 9f6:	8b 73 fc             	mov    -0x4(%ebx),%esi
 9f9:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 9fc:	39 fa                	cmp    %edi,%edx
 9fe:	74 30                	je     a30 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 a00:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 a03:	8b 50 04             	mov    0x4(%eax),%edx
 a06:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 a09:	39 f1                	cmp    %esi,%ecx
 a0b:	74 3a                	je     a47 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 a0d:	89 08                	mov    %ecx,(%eax)
  freep = p;
 a0f:	a3 0c 11 00 00       	mov    %eax,0x110c
}
 a14:	5b                   	pop    %ebx
 a15:	5e                   	pop    %esi
 a16:	5f                   	pop    %edi
 a17:	5d                   	pop    %ebp
 a18:	c3                   	ret    
 a19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a20:	39 d0                	cmp    %edx,%eax
 a22:	72 04                	jb     a28 <free+0x58>
 a24:	39 d1                	cmp    %edx,%ecx
 a26:	72 ce                	jb     9f6 <free+0x26>
{
 a28:	89 d0                	mov    %edx,%eax
 a2a:	eb bc                	jmp    9e8 <free+0x18>
 a2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 a30:	03 72 04             	add    0x4(%edx),%esi
 a33:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 a36:	8b 10                	mov    (%eax),%edx
 a38:	8b 12                	mov    (%edx),%edx
 a3a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 a3d:	8b 50 04             	mov    0x4(%eax),%edx
 a40:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 a43:	39 f1                	cmp    %esi,%ecx
 a45:	75 c6                	jne    a0d <free+0x3d>
    p->s.size += bp->s.size;
 a47:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 a4a:	a3 0c 11 00 00       	mov    %eax,0x110c
    p->s.size += bp->s.size;
 a4f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 a52:	8b 53 f8             	mov    -0x8(%ebx),%edx
 a55:	89 10                	mov    %edx,(%eax)
}
 a57:	5b                   	pop    %ebx
 a58:	5e                   	pop    %esi
 a59:	5f                   	pop    %edi
 a5a:	5d                   	pop    %ebp
 a5b:	c3                   	ret    
 a5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000a60 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 a60:	55                   	push   %ebp
 a61:	89 e5                	mov    %esp,%ebp
 a63:	57                   	push   %edi
 a64:	56                   	push   %esi
 a65:	53                   	push   %ebx
 a66:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a69:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 a6c:	8b 15 0c 11 00 00    	mov    0x110c,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a72:	8d 78 07             	lea    0x7(%eax),%edi
 a75:	c1 ef 03             	shr    $0x3,%edi
 a78:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 a7b:	85 d2                	test   %edx,%edx
 a7d:	0f 84 9d 00 00 00    	je     b20 <malloc+0xc0>
 a83:	8b 02                	mov    (%edx),%eax
 a85:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 a88:	39 cf                	cmp    %ecx,%edi
 a8a:	76 6c                	jbe    af8 <malloc+0x98>
 a8c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 a92:	bb 00 10 00 00       	mov    $0x1000,%ebx
 a97:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 a9a:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 aa1:	eb 0e                	jmp    ab1 <malloc+0x51>
 aa3:	90                   	nop
 aa4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 aa8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 aaa:	8b 48 04             	mov    0x4(%eax),%ecx
 aad:	39 f9                	cmp    %edi,%ecx
 aaf:	73 47                	jae    af8 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 ab1:	39 05 0c 11 00 00    	cmp    %eax,0x110c
 ab7:	89 c2                	mov    %eax,%edx
 ab9:	75 ed                	jne    aa8 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 abb:	83 ec 0c             	sub    $0xc,%esp
 abe:	56                   	push   %esi
 abf:	e8 66 fc ff ff       	call   72a <sbrk>
  if(p == (char*)-1)
 ac4:	83 c4 10             	add    $0x10,%esp
 ac7:	83 f8 ff             	cmp    $0xffffffff,%eax
 aca:	74 1c                	je     ae8 <malloc+0x88>
  hp->s.size = nu;
 acc:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 acf:	83 ec 0c             	sub    $0xc,%esp
 ad2:	83 c0 08             	add    $0x8,%eax
 ad5:	50                   	push   %eax
 ad6:	e8 f5 fe ff ff       	call   9d0 <free>
  return freep;
 adb:	8b 15 0c 11 00 00    	mov    0x110c,%edx
      if((p = morecore(nunits)) == 0)
 ae1:	83 c4 10             	add    $0x10,%esp
 ae4:	85 d2                	test   %edx,%edx
 ae6:	75 c0                	jne    aa8 <malloc+0x48>
        return 0;
  }
}
 ae8:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 aeb:	31 c0                	xor    %eax,%eax
}
 aed:	5b                   	pop    %ebx
 aee:	5e                   	pop    %esi
 aef:	5f                   	pop    %edi
 af0:	5d                   	pop    %ebp
 af1:	c3                   	ret    
 af2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 af8:	39 cf                	cmp    %ecx,%edi
 afa:	74 54                	je     b50 <malloc+0xf0>
        p->s.size -= nunits;
 afc:	29 f9                	sub    %edi,%ecx
 afe:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 b01:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 b04:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 b07:	89 15 0c 11 00 00    	mov    %edx,0x110c
}
 b0d:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 b10:	83 c0 08             	add    $0x8,%eax
}
 b13:	5b                   	pop    %ebx
 b14:	5e                   	pop    %esi
 b15:	5f                   	pop    %edi
 b16:	5d                   	pop    %ebp
 b17:	c3                   	ret    
 b18:	90                   	nop
 b19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
 b20:	c7 05 0c 11 00 00 10 	movl   $0x1110,0x110c
 b27:	11 00 00 
 b2a:	c7 05 10 11 00 00 10 	movl   $0x1110,0x1110
 b31:	11 00 00 
    base.s.size = 0;
 b34:	b8 10 11 00 00       	mov    $0x1110,%eax
 b39:	c7 05 14 11 00 00 00 	movl   $0x0,0x1114
 b40:	00 00 00 
 b43:	e9 44 ff ff ff       	jmp    a8c <malloc+0x2c>
 b48:	90                   	nop
 b49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
 b50:	8b 08                	mov    (%eax),%ecx
 b52:	89 0a                	mov    %ecx,(%edx)
 b54:	eb b1                	jmp    b07 <malloc+0xa7>
