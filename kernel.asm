
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

8010000c <entry>:
8010000c:	0f 20 e0             	mov    %cr4,%eax
8010000f:	83 c8 10             	or     $0x10,%eax
80100012:	0f 22 e0             	mov    %eax,%cr4
80100015:	b8 00 90 10 00       	mov    $0x109000,%eax
8010001a:	0f 22 d8             	mov    %eax,%cr3
8010001d:	0f 20 c0             	mov    %cr0,%eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
80100025:	0f 22 c0             	mov    %eax,%cr0
80100028:	bc c0 b5 10 80       	mov    $0x8010b5c0,%esp
8010002d:	b8 d0 2e 10 80       	mov    $0x80102ed0,%eax
80100032:	ff e0                	jmp    *%eax
80100034:	66 90                	xchg   %ax,%ax
80100036:	66 90                	xchg   %ax,%ax
80100038:	66 90                	xchg   %ax,%ax
8010003a:	66 90                	xchg   %ax,%ax
8010003c:	66 90                	xchg   %ax,%ax
8010003e:	66 90                	xchg   %ax,%ax

80100040 <binit>:
80100040:	55                   	push   %ebp
80100041:	89 e5                	mov    %esp,%ebp
80100043:	53                   	push   %ebx
80100044:	bb f4 b5 10 80       	mov    $0x8010b5f4,%ebx
80100049:	83 ec 0c             	sub    $0xc,%esp
8010004c:	68 60 75 10 80       	push   $0x80107560
80100051:	68 c0 b5 10 80       	push   $0x8010b5c0
80100056:	e8 05 47 00 00       	call   80104760 <initlock>
8010005b:	c7 05 0c fd 10 80 bc 	movl   $0x8010fcbc,0x8010fd0c
80100062:	fc 10 80 
80100065:	c7 05 10 fd 10 80 bc 	movl   $0x8010fcbc,0x8010fd10
8010006c:	fc 10 80 
8010006f:	83 c4 10             	add    $0x10,%esp
80100072:	ba bc fc 10 80       	mov    $0x8010fcbc,%edx
80100077:	eb 09                	jmp    80100082 <binit+0x42>
80100079:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100080:	89 c3                	mov    %eax,%ebx
80100082:	8d 43 0c             	lea    0xc(%ebx),%eax
80100085:	83 ec 08             	sub    $0x8,%esp
80100088:	89 53 54             	mov    %edx,0x54(%ebx)
8010008b:	c7 43 50 bc fc 10 80 	movl   $0x8010fcbc,0x50(%ebx)
80100092:	68 67 75 10 80       	push   $0x80107567
80100097:	50                   	push   %eax
80100098:	e8 93 45 00 00       	call   80104630 <initsleeplock>
8010009d:	a1 10 fd 10 80       	mov    0x8010fd10,%eax
801000a2:	83 c4 10             	add    $0x10,%esp
801000a5:	89 da                	mov    %ebx,%edx
801000a7:	89 58 50             	mov    %ebx,0x50(%eax)
801000aa:	8d 83 5c 02 00 00    	lea    0x25c(%ebx),%eax
801000b0:	89 1d 10 fd 10 80    	mov    %ebx,0x8010fd10
801000b6:	3d bc fc 10 80       	cmp    $0x8010fcbc,%eax
801000bb:	72 c3                	jb     80100080 <binit+0x40>
801000bd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801000c0:	c9                   	leave  
801000c1:	c3                   	ret    
801000c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801000c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801000d0 <bread>:
801000d0:	55                   	push   %ebp
801000d1:	89 e5                	mov    %esp,%ebp
801000d3:	57                   	push   %edi
801000d4:	56                   	push   %esi
801000d5:	53                   	push   %ebx
801000d6:	83 ec 18             	sub    $0x18,%esp
801000d9:	8b 75 08             	mov    0x8(%ebp),%esi
801000dc:	8b 7d 0c             	mov    0xc(%ebp),%edi
801000df:	68 c0 b5 10 80       	push   $0x8010b5c0
801000e4:	e8 b7 47 00 00       	call   801048a0 <acquire>
801000e9:	8b 1d 10 fd 10 80    	mov    0x8010fd10,%ebx
801000ef:	83 c4 10             	add    $0x10,%esp
801000f2:	81 fb bc fc 10 80    	cmp    $0x8010fcbc,%ebx
801000f8:	75 11                	jne    8010010b <bread+0x3b>
801000fa:	eb 24                	jmp    80100120 <bread+0x50>
801000fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb bc fc 10 80    	cmp    $0x8010fcbc,%ebx
80100109:	74 15                	je     80100120 <bread+0x50>
8010010b:	3b 73 04             	cmp    0x4(%ebx),%esi
8010010e:	75 f0                	jne    80100100 <bread+0x30>
80100110:	3b 7b 08             	cmp    0x8(%ebx),%edi
80100113:	75 eb                	jne    80100100 <bread+0x30>
80100115:	83 43 4c 01          	addl   $0x1,0x4c(%ebx)
80100119:	eb 3f                	jmp    8010015a <bread+0x8a>
8010011b:	90                   	nop
8010011c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100120:	8b 1d 0c fd 10 80    	mov    0x8010fd0c,%ebx
80100126:	81 fb bc fc 10 80    	cmp    $0x8010fcbc,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 60                	jmp    80100190 <bread+0xc0>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb bc fc 10 80    	cmp    $0x8010fcbc,%ebx
80100139:	74 55                	je     80100190 <bread+0xc0>
8010013b:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010013e:	85 c0                	test   %eax,%eax
80100140:	75 ee                	jne    80100130 <bread+0x60>
80100142:	f6 03 04             	testb  $0x4,(%ebx)
80100145:	75 e9                	jne    80100130 <bread+0x60>
80100147:	89 73 04             	mov    %esi,0x4(%ebx)
8010014a:	89 7b 08             	mov    %edi,0x8(%ebx)
8010014d:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80100153:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
8010015a:	83 ec 0c             	sub    $0xc,%esp
8010015d:	68 c0 b5 10 80       	push   $0x8010b5c0
80100162:	e8 f9 47 00 00       	call   80104960 <release>
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 fe 44 00 00       	call   80104670 <acquiresleep>
80100172:	83 c4 10             	add    $0x10,%esp
80100175:	f6 03 02             	testb  $0x2,(%ebx)
80100178:	75 0c                	jne    80100186 <bread+0xb6>
8010017a:	83 ec 0c             	sub    $0xc,%esp
8010017d:	53                   	push   %ebx
8010017e:	e8 cd 1f 00 00       	call   80102150 <iderw>
80100183:	83 c4 10             	add    $0x10,%esp
80100186:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100189:	89 d8                	mov    %ebx,%eax
8010018b:	5b                   	pop    %ebx
8010018c:	5e                   	pop    %esi
8010018d:	5f                   	pop    %edi
8010018e:	5d                   	pop    %ebp
8010018f:	c3                   	ret    
80100190:	83 ec 0c             	sub    $0xc,%esp
80100193:	68 6e 75 10 80       	push   $0x8010756e
80100198:	e8 f3 01 00 00       	call   80100390 <panic>
8010019d:	8d 76 00             	lea    0x0(%esi),%esi

801001a0 <bwrite>:
801001a0:	55                   	push   %ebp
801001a1:	89 e5                	mov    %esp,%ebp
801001a3:	53                   	push   %ebx
801001a4:	83 ec 10             	sub    $0x10,%esp
801001a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
801001aa:	8d 43 0c             	lea    0xc(%ebx),%eax
801001ad:	50                   	push   %eax
801001ae:	e8 5d 45 00 00       	call   80104710 <holdingsleep>
801001b3:	83 c4 10             	add    $0x10,%esp
801001b6:	85 c0                	test   %eax,%eax
801001b8:	74 0f                	je     801001c9 <bwrite+0x29>
801001ba:	83 0b 04             	orl    $0x4,(%ebx)
801001bd:	89 5d 08             	mov    %ebx,0x8(%ebp)
801001c0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801001c3:	c9                   	leave  
801001c4:	e9 87 1f 00 00       	jmp    80102150 <iderw>
801001c9:	83 ec 0c             	sub    $0xc,%esp
801001cc:	68 7f 75 10 80       	push   $0x8010757f
801001d1:	e8 ba 01 00 00       	call   80100390 <panic>
801001d6:	8d 76 00             	lea    0x0(%esi),%esi
801001d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801001e0 <brelse>:
801001e0:	55                   	push   %ebp
801001e1:	89 e5                	mov    %esp,%ebp
801001e3:	56                   	push   %esi
801001e4:	53                   	push   %ebx
801001e5:	8b 5d 08             	mov    0x8(%ebp),%ebx
801001e8:	83 ec 0c             	sub    $0xc,%esp
801001eb:	8d 73 0c             	lea    0xc(%ebx),%esi
801001ee:	56                   	push   %esi
801001ef:	e8 1c 45 00 00       	call   80104710 <holdingsleep>
801001f4:	83 c4 10             	add    $0x10,%esp
801001f7:	85 c0                	test   %eax,%eax
801001f9:	74 66                	je     80100261 <brelse+0x81>
801001fb:	83 ec 0c             	sub    $0xc,%esp
801001fe:	56                   	push   %esi
801001ff:	e8 cc 44 00 00       	call   801046d0 <releasesleep>
80100204:	c7 04 24 c0 b5 10 80 	movl   $0x8010b5c0,(%esp)
8010020b:	e8 90 46 00 00       	call   801048a0 <acquire>
80100210:	8b 43 4c             	mov    0x4c(%ebx),%eax
80100213:	83 c4 10             	add    $0x10,%esp
80100216:	83 e8 01             	sub    $0x1,%eax
80100219:	85 c0                	test   %eax,%eax
8010021b:	89 43 4c             	mov    %eax,0x4c(%ebx)
8010021e:	75 2f                	jne    8010024f <brelse+0x6f>
80100220:	8b 43 54             	mov    0x54(%ebx),%eax
80100223:	8b 53 50             	mov    0x50(%ebx),%edx
80100226:	89 50 50             	mov    %edx,0x50(%eax)
80100229:	8b 43 50             	mov    0x50(%ebx),%eax
8010022c:	8b 53 54             	mov    0x54(%ebx),%edx
8010022f:	89 50 54             	mov    %edx,0x54(%eax)
80100232:	a1 10 fd 10 80       	mov    0x8010fd10,%eax
80100237:	c7 43 50 bc fc 10 80 	movl   $0x8010fcbc,0x50(%ebx)
8010023e:	89 43 54             	mov    %eax,0x54(%ebx)
80100241:	a1 10 fd 10 80       	mov    0x8010fd10,%eax
80100246:	89 58 50             	mov    %ebx,0x50(%eax)
80100249:	89 1d 10 fd 10 80    	mov    %ebx,0x8010fd10
8010024f:	c7 45 08 c0 b5 10 80 	movl   $0x8010b5c0,0x8(%ebp)
80100256:	8d 65 f8             	lea    -0x8(%ebp),%esp
80100259:	5b                   	pop    %ebx
8010025a:	5e                   	pop    %esi
8010025b:	5d                   	pop    %ebp
8010025c:	e9 ff 46 00 00       	jmp    80104960 <release>
80100261:	83 ec 0c             	sub    $0xc,%esp
80100264:	68 86 75 10 80       	push   $0x80107586
80100269:	e8 22 01 00 00       	call   80100390 <panic>
8010026e:	66 90                	xchg   %ax,%ax

80100270 <consoleread>:
  }
}

int
consoleread(struct inode *ip, char *dst, int n)
{
80100270:	55                   	push   %ebp
80100271:	89 e5                	mov    %esp,%ebp
80100273:	57                   	push   %edi
80100274:	56                   	push   %esi
80100275:	53                   	push   %ebx
80100276:	83 ec 28             	sub    $0x28,%esp
80100279:	8b 7d 08             	mov    0x8(%ebp),%edi
8010027c:	8b 75 0c             	mov    0xc(%ebp),%esi
  uint target;
  int c;

  iunlock(ip);
8010027f:	57                   	push   %edi
80100280:	e8 0b 15 00 00       	call   80101790 <iunlock>
  target = n;
  acquire(&cons.lock);
80100285:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
8010028c:	e8 0f 46 00 00       	call   801048a0 <acquire>
  while(n > 0){
80100291:	8b 5d 10             	mov    0x10(%ebp),%ebx
80100294:	83 c4 10             	add    $0x10,%esp
80100297:	31 c0                	xor    %eax,%eax
80100299:	85 db                	test   %ebx,%ebx
8010029b:	0f 8e a1 00 00 00    	jle    80100342 <consoleread+0xd2>
    while(input.r == input.w){
801002a1:	8b 15 a0 ff 10 80    	mov    0x8010ffa0,%edx
801002a7:	39 15 a4 ff 10 80    	cmp    %edx,0x8010ffa4
801002ad:	74 2c                	je     801002db <consoleread+0x6b>
801002af:	eb 5f                	jmp    80100310 <consoleread+0xa0>
801002b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(myproc()->killed){
        release(&cons.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
801002b8:	83 ec 08             	sub    $0x8,%esp
801002bb:	68 20 a5 10 80       	push   $0x8010a520
801002c0:	68 a0 ff 10 80       	push   $0x8010ffa0
801002c5:	e8 56 3c 00 00       	call   80103f20 <sleep>
    while(input.r == input.w){
801002ca:	8b 15 a0 ff 10 80    	mov    0x8010ffa0,%edx
801002d0:	83 c4 10             	add    $0x10,%esp
801002d3:	3b 15 a4 ff 10 80    	cmp    0x8010ffa4,%edx
801002d9:	75 35                	jne    80100310 <consoleread+0xa0>
      if(myproc()->killed){
801002db:	e8 30 36 00 00       	call   80103910 <myproc>
801002e0:	8b 40 24             	mov    0x24(%eax),%eax
801002e3:	85 c0                	test   %eax,%eax
801002e5:	74 d1                	je     801002b8 <consoleread+0x48>
        release(&cons.lock);
801002e7:	83 ec 0c             	sub    $0xc,%esp
801002ea:	68 20 a5 10 80       	push   $0x8010a520
801002ef:	e8 6c 46 00 00       	call   80104960 <release>
        ilock(ip);
801002f4:	89 3c 24             	mov    %edi,(%esp)
801002f7:	e8 b4 13 00 00       	call   801016b0 <ilock>
        return -1;
801002fc:	83 c4 10             	add    $0x10,%esp
  }
  release(&cons.lock);
  ilock(ip);

  return target - n;
}
801002ff:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return -1;
80100302:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100307:	5b                   	pop    %ebx
80100308:	5e                   	pop    %esi
80100309:	5f                   	pop    %edi
8010030a:	5d                   	pop    %ebp
8010030b:	c3                   	ret    
8010030c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = input.buf[input.r++ % INPUT_BUF];
80100310:	8d 42 01             	lea    0x1(%edx),%eax
80100313:	a3 a0 ff 10 80       	mov    %eax,0x8010ffa0
80100318:	89 d0                	mov    %edx,%eax
8010031a:	83 e0 7f             	and    $0x7f,%eax
8010031d:	0f be 80 20 ff 10 80 	movsbl -0x7fef00e0(%eax),%eax
    if(c == C('D')){  // EOF
80100324:	83 f8 04             	cmp    $0x4,%eax
80100327:	74 3f                	je     80100368 <consoleread+0xf8>
    *dst++ = c;
80100329:	83 c6 01             	add    $0x1,%esi
    --n;
8010032c:	83 eb 01             	sub    $0x1,%ebx
    if(c == '\n')
8010032f:	83 f8 0a             	cmp    $0xa,%eax
    *dst++ = c;
80100332:	88 46 ff             	mov    %al,-0x1(%esi)
    if(c == '\n')
80100335:	74 43                	je     8010037a <consoleread+0x10a>
  while(n > 0){
80100337:	85 db                	test   %ebx,%ebx
80100339:	0f 85 62 ff ff ff    	jne    801002a1 <consoleread+0x31>
8010033f:	8b 45 10             	mov    0x10(%ebp),%eax
  release(&cons.lock);
80100342:	83 ec 0c             	sub    $0xc,%esp
80100345:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100348:	68 20 a5 10 80       	push   $0x8010a520
8010034d:	e8 0e 46 00 00       	call   80104960 <release>
  ilock(ip);
80100352:	89 3c 24             	mov    %edi,(%esp)
80100355:	e8 56 13 00 00       	call   801016b0 <ilock>
  return target - n;
8010035a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010035d:	83 c4 10             	add    $0x10,%esp
}
80100360:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100363:	5b                   	pop    %ebx
80100364:	5e                   	pop    %esi
80100365:	5f                   	pop    %edi
80100366:	5d                   	pop    %ebp
80100367:	c3                   	ret    
80100368:	8b 45 10             	mov    0x10(%ebp),%eax
8010036b:	29 d8                	sub    %ebx,%eax
      if(n < target){
8010036d:	3b 5d 10             	cmp    0x10(%ebp),%ebx
80100370:	73 d0                	jae    80100342 <consoleread+0xd2>
        input.r--;
80100372:	89 15 a0 ff 10 80    	mov    %edx,0x8010ffa0
80100378:	eb c8                	jmp    80100342 <consoleread+0xd2>
8010037a:	8b 45 10             	mov    0x10(%ebp),%eax
8010037d:	29 d8                	sub    %ebx,%eax
8010037f:	eb c1                	jmp    80100342 <consoleread+0xd2>
80100381:	eb 0d                	jmp    80100390 <panic>
80100383:	90                   	nop
80100384:	90                   	nop
80100385:	90                   	nop
80100386:	90                   	nop
80100387:	90                   	nop
80100388:	90                   	nop
80100389:	90                   	nop
8010038a:	90                   	nop
8010038b:	90                   	nop
8010038c:	90                   	nop
8010038d:	90                   	nop
8010038e:	90                   	nop
8010038f:	90                   	nop

80100390 <panic>:
{
80100390:	55                   	push   %ebp
80100391:	89 e5                	mov    %esp,%ebp
80100393:	56                   	push   %esi
80100394:	53                   	push   %ebx
80100395:	83 ec 30             	sub    $0x30,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
80100398:	fa                   	cli    
  cons.locking = 0;
80100399:	c7 05 54 a5 10 80 00 	movl   $0x0,0x8010a554
801003a0:	00 00 00 
  getcallerpcs(&s, pcs);
801003a3:	8d 5d d0             	lea    -0x30(%ebp),%ebx
801003a6:	8d 75 f8             	lea    -0x8(%ebp),%esi
  cprintf("lapicid %d: panic: ", lapicid());
801003a9:	e8 b2 23 00 00       	call   80102760 <lapicid>
801003ae:	83 ec 08             	sub    $0x8,%esp
801003b1:	50                   	push   %eax
801003b2:	68 8d 75 10 80       	push   $0x8010758d
801003b7:	e8 a4 02 00 00       	call   80100660 <cprintf>
  cprintf(s);
801003bc:	58                   	pop    %eax
801003bd:	ff 75 08             	pushl  0x8(%ebp)
801003c0:	e8 9b 02 00 00       	call   80100660 <cprintf>
  cprintf("\n");
801003c5:	c7 04 24 c3 7e 10 80 	movl   $0x80107ec3,(%esp)
801003cc:	e8 8f 02 00 00       	call   80100660 <cprintf>
  getcallerpcs(&s, pcs);
801003d1:	5a                   	pop    %edx
801003d2:	8d 45 08             	lea    0x8(%ebp),%eax
801003d5:	59                   	pop    %ecx
801003d6:	53                   	push   %ebx
801003d7:	50                   	push   %eax
801003d8:	e8 a3 43 00 00       	call   80104780 <getcallerpcs>
801003dd:	83 c4 10             	add    $0x10,%esp
    cprintf(" %p", pcs[i]);
801003e0:	83 ec 08             	sub    $0x8,%esp
801003e3:	ff 33                	pushl  (%ebx)
801003e5:	83 c3 04             	add    $0x4,%ebx
801003e8:	68 a1 75 10 80       	push   $0x801075a1
801003ed:	e8 6e 02 00 00       	call   80100660 <cprintf>
  for(i=0; i<10; i++)
801003f2:	83 c4 10             	add    $0x10,%esp
801003f5:	39 f3                	cmp    %esi,%ebx
801003f7:	75 e7                	jne    801003e0 <panic+0x50>
  panicked = 1; // freeze other CPU
801003f9:	c7 05 58 a5 10 80 01 	movl   $0x1,0x8010a558
80100400:	00 00 00 
80100403:	eb fe                	jmp    80100403 <panic+0x73>
80100405:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100409:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100410 <consputc>:
  if(panicked){
80100410:	8b 0d 58 a5 10 80    	mov    0x8010a558,%ecx
80100416:	85 c9                	test   %ecx,%ecx
80100418:	74 06                	je     80100420 <consputc+0x10>
8010041a:	fa                   	cli    
8010041b:	eb fe                	jmp    8010041b <consputc+0xb>
8010041d:	8d 76 00             	lea    0x0(%esi),%esi
{
80100420:	55                   	push   %ebp
80100421:	89 e5                	mov    %esp,%ebp
80100423:	57                   	push   %edi
80100424:	56                   	push   %esi
80100425:	53                   	push   %ebx
80100426:	89 c6                	mov    %eax,%esi
80100428:	83 ec 0c             	sub    $0xc,%esp
  if(c == BACKSPACE){
8010042b:	3d 00 01 00 00       	cmp    $0x100,%eax
80100430:	0f 84 b1 00 00 00    	je     801004e7 <consputc+0xd7>
    uartputc(c);
80100436:	83 ec 0c             	sub    $0xc,%esp
80100439:	50                   	push   %eax
8010043a:	e8 21 5d 00 00       	call   80106160 <uartputc>
8010043f:	83 c4 10             	add    $0x10,%esp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100442:	bb d4 03 00 00       	mov    $0x3d4,%ebx
80100447:	b8 0e 00 00 00       	mov    $0xe,%eax
8010044c:	89 da                	mov    %ebx,%edx
8010044e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010044f:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
80100454:	89 ca                	mov    %ecx,%edx
80100456:	ec                   	in     (%dx),%al
  pos = inb(CRTPORT+1) << 8;
80100457:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010045a:	89 da                	mov    %ebx,%edx
8010045c:	c1 e0 08             	shl    $0x8,%eax
8010045f:	89 c7                	mov    %eax,%edi
80100461:	b8 0f 00 00 00       	mov    $0xf,%eax
80100466:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100467:	89 ca                	mov    %ecx,%edx
80100469:	ec                   	in     (%dx),%al
8010046a:	0f b6 d8             	movzbl %al,%ebx
  pos |= inb(CRTPORT+1);
8010046d:	09 fb                	or     %edi,%ebx
  if(c == '\n')
8010046f:	83 fe 0a             	cmp    $0xa,%esi
80100472:	0f 84 f3 00 00 00    	je     8010056b <consputc+0x15b>
  else if(c == BACKSPACE){
80100478:	81 fe 00 01 00 00    	cmp    $0x100,%esi
8010047e:	0f 84 d7 00 00 00    	je     8010055b <consputc+0x14b>
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
80100484:	89 f0                	mov    %esi,%eax
80100486:	0f b6 c0             	movzbl %al,%eax
80100489:	80 cc 07             	or     $0x7,%ah
8010048c:	66 89 84 1b 00 80 0b 	mov    %ax,-0x7ff48000(%ebx,%ebx,1)
80100493:	80 
80100494:	83 c3 01             	add    $0x1,%ebx
  if(pos < 0 || pos > 25*80)
80100497:	81 fb d0 07 00 00    	cmp    $0x7d0,%ebx
8010049d:	0f 8f ab 00 00 00    	jg     8010054e <consputc+0x13e>
  if((pos/80) >= 24){  // Scroll up.
801004a3:	81 fb 7f 07 00 00    	cmp    $0x77f,%ebx
801004a9:	7f 66                	jg     80100511 <consputc+0x101>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801004ab:	be d4 03 00 00       	mov    $0x3d4,%esi
801004b0:	b8 0e 00 00 00       	mov    $0xe,%eax
801004b5:	89 f2                	mov    %esi,%edx
801004b7:	ee                   	out    %al,(%dx)
801004b8:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
  outb(CRTPORT+1, pos>>8);
801004bd:	89 d8                	mov    %ebx,%eax
801004bf:	c1 f8 08             	sar    $0x8,%eax
801004c2:	89 ca                	mov    %ecx,%edx
801004c4:	ee                   	out    %al,(%dx)
801004c5:	b8 0f 00 00 00       	mov    $0xf,%eax
801004ca:	89 f2                	mov    %esi,%edx
801004cc:	ee                   	out    %al,(%dx)
801004cd:	89 d8                	mov    %ebx,%eax
801004cf:	89 ca                	mov    %ecx,%edx
801004d1:	ee                   	out    %al,(%dx)
  crt[pos] = ' ' | 0x0700;
801004d2:	b8 20 07 00 00       	mov    $0x720,%eax
801004d7:	66 89 84 1b 00 80 0b 	mov    %ax,-0x7ff48000(%ebx,%ebx,1)
801004de:	80 
}
801004df:	8d 65 f4             	lea    -0xc(%ebp),%esp
801004e2:	5b                   	pop    %ebx
801004e3:	5e                   	pop    %esi
801004e4:	5f                   	pop    %edi
801004e5:	5d                   	pop    %ebp
801004e6:	c3                   	ret    
    uartputc('\b'); uartputc(' '); uartputc('\b');
801004e7:	83 ec 0c             	sub    $0xc,%esp
801004ea:	6a 08                	push   $0x8
801004ec:	e8 6f 5c 00 00       	call   80106160 <uartputc>
801004f1:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801004f8:	e8 63 5c 00 00       	call   80106160 <uartputc>
801004fd:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80100504:	e8 57 5c 00 00       	call   80106160 <uartputc>
80100509:	83 c4 10             	add    $0x10,%esp
8010050c:	e9 31 ff ff ff       	jmp    80100442 <consputc+0x32>
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100511:	52                   	push   %edx
80100512:	68 60 0e 00 00       	push   $0xe60
    pos -= 80;
80100517:	83 eb 50             	sub    $0x50,%ebx
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
8010051a:	68 a0 80 0b 80       	push   $0x800b80a0
8010051f:	68 00 80 0b 80       	push   $0x800b8000
80100524:	e8 37 45 00 00       	call   80104a60 <memmove>
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100529:	b8 80 07 00 00       	mov    $0x780,%eax
8010052e:	83 c4 0c             	add    $0xc,%esp
80100531:	29 d8                	sub    %ebx,%eax
80100533:	01 c0                	add    %eax,%eax
80100535:	50                   	push   %eax
80100536:	8d 04 1b             	lea    (%ebx,%ebx,1),%eax
80100539:	6a 00                	push   $0x0
8010053b:	2d 00 80 f4 7f       	sub    $0x7ff48000,%eax
80100540:	50                   	push   %eax
80100541:	e8 6a 44 00 00       	call   801049b0 <memset>
80100546:	83 c4 10             	add    $0x10,%esp
80100549:	e9 5d ff ff ff       	jmp    801004ab <consputc+0x9b>
    panic("pos under/overflow");
8010054e:	83 ec 0c             	sub    $0xc,%esp
80100551:	68 a5 75 10 80       	push   $0x801075a5
80100556:	e8 35 fe ff ff       	call   80100390 <panic>
    if(pos > 0) --pos;
8010055b:	85 db                	test   %ebx,%ebx
8010055d:	0f 84 48 ff ff ff    	je     801004ab <consputc+0x9b>
80100563:	83 eb 01             	sub    $0x1,%ebx
80100566:	e9 2c ff ff ff       	jmp    80100497 <consputc+0x87>
    pos += 80 - pos%80;
8010056b:	89 d8                	mov    %ebx,%eax
8010056d:	b9 50 00 00 00       	mov    $0x50,%ecx
80100572:	99                   	cltd   
80100573:	f7 f9                	idiv   %ecx
80100575:	29 d1                	sub    %edx,%ecx
80100577:	01 cb                	add    %ecx,%ebx
80100579:	e9 19 ff ff ff       	jmp    80100497 <consputc+0x87>
8010057e:	66 90                	xchg   %ax,%ax

80100580 <printint>:
{
80100580:	55                   	push   %ebp
80100581:	89 e5                	mov    %esp,%ebp
80100583:	57                   	push   %edi
80100584:	56                   	push   %esi
80100585:	53                   	push   %ebx
80100586:	89 d3                	mov    %edx,%ebx
80100588:	83 ec 2c             	sub    $0x2c,%esp
  if(sign && (sign = xx < 0))
8010058b:	85 c9                	test   %ecx,%ecx
{
8010058d:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
  if(sign && (sign = xx < 0))
80100590:	74 04                	je     80100596 <printint+0x16>
80100592:	85 c0                	test   %eax,%eax
80100594:	78 5a                	js     801005f0 <printint+0x70>
    x = xx;
80100596:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
  i = 0;
8010059d:	31 c9                	xor    %ecx,%ecx
8010059f:	8d 75 d7             	lea    -0x29(%ebp),%esi
801005a2:	eb 06                	jmp    801005aa <printint+0x2a>
801005a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    buf[i++] = digits[x % base];
801005a8:	89 f9                	mov    %edi,%ecx
801005aa:	31 d2                	xor    %edx,%edx
801005ac:	8d 79 01             	lea    0x1(%ecx),%edi
801005af:	f7 f3                	div    %ebx
801005b1:	0f b6 92 d0 75 10 80 	movzbl -0x7fef8a30(%edx),%edx
  }while((x /= base) != 0);
801005b8:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
801005ba:	88 14 3e             	mov    %dl,(%esi,%edi,1)
  }while((x /= base) != 0);
801005bd:	75 e9                	jne    801005a8 <printint+0x28>
  if(sign)
801005bf:	8b 45 d4             	mov    -0x2c(%ebp),%eax
801005c2:	85 c0                	test   %eax,%eax
801005c4:	74 08                	je     801005ce <printint+0x4e>
    buf[i++] = '-';
801005c6:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
801005cb:	8d 79 02             	lea    0x2(%ecx),%edi
801005ce:	8d 5c 3d d7          	lea    -0x29(%ebp,%edi,1),%ebx
801005d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    consputc(buf[i]);
801005d8:	0f be 03             	movsbl (%ebx),%eax
801005db:	83 eb 01             	sub    $0x1,%ebx
801005de:	e8 2d fe ff ff       	call   80100410 <consputc>
  while(--i >= 0)
801005e3:	39 f3                	cmp    %esi,%ebx
801005e5:	75 f1                	jne    801005d8 <printint+0x58>
}
801005e7:	83 c4 2c             	add    $0x2c,%esp
801005ea:	5b                   	pop    %ebx
801005eb:	5e                   	pop    %esi
801005ec:	5f                   	pop    %edi
801005ed:	5d                   	pop    %ebp
801005ee:	c3                   	ret    
801005ef:	90                   	nop
    x = -xx;
801005f0:	f7 d8                	neg    %eax
801005f2:	eb a9                	jmp    8010059d <printint+0x1d>
801005f4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801005fa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80100600 <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
80100600:	55                   	push   %ebp
80100601:	89 e5                	mov    %esp,%ebp
80100603:	57                   	push   %edi
80100604:	56                   	push   %esi
80100605:	53                   	push   %ebx
80100606:	83 ec 18             	sub    $0x18,%esp
80100609:	8b 75 10             	mov    0x10(%ebp),%esi
  int i;

  iunlock(ip);
8010060c:	ff 75 08             	pushl  0x8(%ebp)
8010060f:	e8 7c 11 00 00       	call   80101790 <iunlock>
  acquire(&cons.lock);
80100614:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
8010061b:	e8 80 42 00 00       	call   801048a0 <acquire>
  for(i = 0; i < n; i++)
80100620:	83 c4 10             	add    $0x10,%esp
80100623:	85 f6                	test   %esi,%esi
80100625:	7e 18                	jle    8010063f <consolewrite+0x3f>
80100627:	8b 7d 0c             	mov    0xc(%ebp),%edi
8010062a:	8d 1c 37             	lea    (%edi,%esi,1),%ebx
8010062d:	8d 76 00             	lea    0x0(%esi),%esi
    consputc(buf[i] & 0xff);
80100630:	0f b6 07             	movzbl (%edi),%eax
80100633:	83 c7 01             	add    $0x1,%edi
80100636:	e8 d5 fd ff ff       	call   80100410 <consputc>
  for(i = 0; i < n; i++)
8010063b:	39 fb                	cmp    %edi,%ebx
8010063d:	75 f1                	jne    80100630 <consolewrite+0x30>
  release(&cons.lock);
8010063f:	83 ec 0c             	sub    $0xc,%esp
80100642:	68 20 a5 10 80       	push   $0x8010a520
80100647:	e8 14 43 00 00       	call   80104960 <release>
  ilock(ip);
8010064c:	58                   	pop    %eax
8010064d:	ff 75 08             	pushl  0x8(%ebp)
80100650:	e8 5b 10 00 00       	call   801016b0 <ilock>

  return n;
}
80100655:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100658:	89 f0                	mov    %esi,%eax
8010065a:	5b                   	pop    %ebx
8010065b:	5e                   	pop    %esi
8010065c:	5f                   	pop    %edi
8010065d:	5d                   	pop    %ebp
8010065e:	c3                   	ret    
8010065f:	90                   	nop

80100660 <cprintf>:
{
80100660:	55                   	push   %ebp
80100661:	89 e5                	mov    %esp,%ebp
80100663:	57                   	push   %edi
80100664:	56                   	push   %esi
80100665:	53                   	push   %ebx
80100666:	83 ec 1c             	sub    $0x1c,%esp
  locking = cons.locking;
80100669:	a1 54 a5 10 80       	mov    0x8010a554,%eax
  if(locking)
8010066e:	85 c0                	test   %eax,%eax
  locking = cons.locking;
80100670:	89 45 dc             	mov    %eax,-0x24(%ebp)
  if(locking)
80100673:	0f 85 6f 01 00 00    	jne    801007e8 <cprintf+0x188>
  if (fmt == 0)
80100679:	8b 45 08             	mov    0x8(%ebp),%eax
8010067c:	85 c0                	test   %eax,%eax
8010067e:	89 c7                	mov    %eax,%edi
80100680:	0f 84 77 01 00 00    	je     801007fd <cprintf+0x19d>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100686:	0f b6 00             	movzbl (%eax),%eax
  argp = (uint*)(void*)(&fmt + 1);
80100689:	8d 4d 0c             	lea    0xc(%ebp),%ecx
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
8010068c:	31 db                	xor    %ebx,%ebx
  argp = (uint*)(void*)(&fmt + 1);
8010068e:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100691:	85 c0                	test   %eax,%eax
80100693:	75 56                	jne    801006eb <cprintf+0x8b>
80100695:	eb 79                	jmp    80100710 <cprintf+0xb0>
80100697:	89 f6                	mov    %esi,%esi
80100699:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[++i] & 0xff;
801006a0:	0f b6 16             	movzbl (%esi),%edx
    if(c == 0)
801006a3:	85 d2                	test   %edx,%edx
801006a5:	74 69                	je     80100710 <cprintf+0xb0>
801006a7:	83 c3 02             	add    $0x2,%ebx
    switch(c){
801006aa:	83 fa 70             	cmp    $0x70,%edx
801006ad:	8d 34 1f             	lea    (%edi,%ebx,1),%esi
801006b0:	0f 84 84 00 00 00    	je     8010073a <cprintf+0xda>
801006b6:	7f 78                	jg     80100730 <cprintf+0xd0>
801006b8:	83 fa 25             	cmp    $0x25,%edx
801006bb:	0f 84 ff 00 00 00    	je     801007c0 <cprintf+0x160>
801006c1:	83 fa 64             	cmp    $0x64,%edx
801006c4:	0f 85 8e 00 00 00    	jne    80100758 <cprintf+0xf8>
      printint(*argp++, 10, 1);
801006ca:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801006cd:	ba 0a 00 00 00       	mov    $0xa,%edx
801006d2:	8d 48 04             	lea    0x4(%eax),%ecx
801006d5:	8b 00                	mov    (%eax),%eax
801006d7:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
801006da:	b9 01 00 00 00       	mov    $0x1,%ecx
801006df:	e8 9c fe ff ff       	call   80100580 <printint>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006e4:	0f b6 06             	movzbl (%esi),%eax
801006e7:	85 c0                	test   %eax,%eax
801006e9:	74 25                	je     80100710 <cprintf+0xb0>
801006eb:	8d 53 01             	lea    0x1(%ebx),%edx
    if(c != '%'){
801006ee:	83 f8 25             	cmp    $0x25,%eax
801006f1:	8d 34 17             	lea    (%edi,%edx,1),%esi
801006f4:	74 aa                	je     801006a0 <cprintf+0x40>
801006f6:	89 55 e0             	mov    %edx,-0x20(%ebp)
      consputc(c);
801006f9:	e8 12 fd ff ff       	call   80100410 <consputc>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006fe:	0f b6 06             	movzbl (%esi),%eax
      continue;
80100701:	8b 55 e0             	mov    -0x20(%ebp),%edx
80100704:	89 d3                	mov    %edx,%ebx
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100706:	85 c0                	test   %eax,%eax
80100708:	75 e1                	jne    801006eb <cprintf+0x8b>
8010070a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if(locking)
80100710:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100713:	85 c0                	test   %eax,%eax
80100715:	74 10                	je     80100727 <cprintf+0xc7>
    release(&cons.lock);
80100717:	83 ec 0c             	sub    $0xc,%esp
8010071a:	68 20 a5 10 80       	push   $0x8010a520
8010071f:	e8 3c 42 00 00       	call   80104960 <release>
80100724:	83 c4 10             	add    $0x10,%esp
}
80100727:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010072a:	5b                   	pop    %ebx
8010072b:	5e                   	pop    %esi
8010072c:	5f                   	pop    %edi
8010072d:	5d                   	pop    %ebp
8010072e:	c3                   	ret    
8010072f:	90                   	nop
    switch(c){
80100730:	83 fa 73             	cmp    $0x73,%edx
80100733:	74 43                	je     80100778 <cprintf+0x118>
80100735:	83 fa 78             	cmp    $0x78,%edx
80100738:	75 1e                	jne    80100758 <cprintf+0xf8>
      printint(*argp++, 16, 0);
8010073a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010073d:	ba 10 00 00 00       	mov    $0x10,%edx
80100742:	8d 48 04             	lea    0x4(%eax),%ecx
80100745:	8b 00                	mov    (%eax),%eax
80100747:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
8010074a:	31 c9                	xor    %ecx,%ecx
8010074c:	e8 2f fe ff ff       	call   80100580 <printint>
      break;
80100751:	eb 91                	jmp    801006e4 <cprintf+0x84>
80100753:	90                   	nop
80100754:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      consputc('%');
80100758:	b8 25 00 00 00       	mov    $0x25,%eax
8010075d:	89 55 e0             	mov    %edx,-0x20(%ebp)
80100760:	e8 ab fc ff ff       	call   80100410 <consputc>
      consputc(c);
80100765:	8b 55 e0             	mov    -0x20(%ebp),%edx
80100768:	89 d0                	mov    %edx,%eax
8010076a:	e8 a1 fc ff ff       	call   80100410 <consputc>
      break;
8010076f:	e9 70 ff ff ff       	jmp    801006e4 <cprintf+0x84>
80100774:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if((s = (char*)*argp++) == 0)
80100778:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010077b:	8b 10                	mov    (%eax),%edx
8010077d:	8d 48 04             	lea    0x4(%eax),%ecx
80100780:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80100783:	85 d2                	test   %edx,%edx
80100785:	74 49                	je     801007d0 <cprintf+0x170>
      for(; *s; s++)
80100787:	0f be 02             	movsbl (%edx),%eax
      if((s = (char*)*argp++) == 0)
8010078a:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
      for(; *s; s++)
8010078d:	84 c0                	test   %al,%al
8010078f:	0f 84 4f ff ff ff    	je     801006e4 <cprintf+0x84>
80100795:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
80100798:	89 d3                	mov    %edx,%ebx
8010079a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801007a0:	83 c3 01             	add    $0x1,%ebx
        consputc(*s);
801007a3:	e8 68 fc ff ff       	call   80100410 <consputc>
      for(; *s; s++)
801007a8:	0f be 03             	movsbl (%ebx),%eax
801007ab:	84 c0                	test   %al,%al
801007ad:	75 f1                	jne    801007a0 <cprintf+0x140>
      if((s = (char*)*argp++) == 0)
801007af:	8b 45 e0             	mov    -0x20(%ebp),%eax
801007b2:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
801007b5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801007b8:	e9 27 ff ff ff       	jmp    801006e4 <cprintf+0x84>
801007bd:	8d 76 00             	lea    0x0(%esi),%esi
      consputc('%');
801007c0:	b8 25 00 00 00       	mov    $0x25,%eax
801007c5:	e8 46 fc ff ff       	call   80100410 <consputc>
      break;
801007ca:	e9 15 ff ff ff       	jmp    801006e4 <cprintf+0x84>
801007cf:	90                   	nop
        s = "(null)";
801007d0:	ba b8 75 10 80       	mov    $0x801075b8,%edx
      for(; *s; s++)
801007d5:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
801007d8:	b8 28 00 00 00       	mov    $0x28,%eax
801007dd:	89 d3                	mov    %edx,%ebx
801007df:	eb bf                	jmp    801007a0 <cprintf+0x140>
801007e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    acquire(&cons.lock);
801007e8:	83 ec 0c             	sub    $0xc,%esp
801007eb:	68 20 a5 10 80       	push   $0x8010a520
801007f0:	e8 ab 40 00 00       	call   801048a0 <acquire>
801007f5:	83 c4 10             	add    $0x10,%esp
801007f8:	e9 7c fe ff ff       	jmp    80100679 <cprintf+0x19>
    panic("null fmt");
801007fd:	83 ec 0c             	sub    $0xc,%esp
80100800:	68 bf 75 10 80       	push   $0x801075bf
80100805:	e8 86 fb ff ff       	call   80100390 <panic>
8010080a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100810 <consoleintr>:
{
80100810:	55                   	push   %ebp
80100811:	89 e5                	mov    %esp,%ebp
80100813:	57                   	push   %edi
80100814:	56                   	push   %esi
80100815:	53                   	push   %ebx
  int c, doprocdump = 0;
80100816:	31 f6                	xor    %esi,%esi
{
80100818:	83 ec 18             	sub    $0x18,%esp
8010081b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&cons.lock);
8010081e:	68 20 a5 10 80       	push   $0x8010a520
80100823:	e8 78 40 00 00       	call   801048a0 <acquire>
  while((c = getc()) >= 0){
80100828:	83 c4 10             	add    $0x10,%esp
8010082b:	90                   	nop
8010082c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100830:	ff d3                	call   *%ebx
80100832:	85 c0                	test   %eax,%eax
80100834:	89 c7                	mov    %eax,%edi
80100836:	78 48                	js     80100880 <consoleintr+0x70>
    switch(c){
80100838:	83 ff 10             	cmp    $0x10,%edi
8010083b:	0f 84 e7 00 00 00    	je     80100928 <consoleintr+0x118>
80100841:	7e 5d                	jle    801008a0 <consoleintr+0x90>
80100843:	83 ff 15             	cmp    $0x15,%edi
80100846:	0f 84 ec 00 00 00    	je     80100938 <consoleintr+0x128>
8010084c:	83 ff 7f             	cmp    $0x7f,%edi
8010084f:	75 54                	jne    801008a5 <consoleintr+0x95>
      if(input.e != input.w){
80100851:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
80100856:	3b 05 a4 ff 10 80    	cmp    0x8010ffa4,%eax
8010085c:	74 d2                	je     80100830 <consoleintr+0x20>
        input.e--;
8010085e:	83 e8 01             	sub    $0x1,%eax
80100861:	a3 a8 ff 10 80       	mov    %eax,0x8010ffa8
        consputc(BACKSPACE);
80100866:	b8 00 01 00 00       	mov    $0x100,%eax
8010086b:	e8 a0 fb ff ff       	call   80100410 <consputc>
  while((c = getc()) >= 0){
80100870:	ff d3                	call   *%ebx
80100872:	85 c0                	test   %eax,%eax
80100874:	89 c7                	mov    %eax,%edi
80100876:	79 c0                	jns    80100838 <consoleintr+0x28>
80100878:	90                   	nop
80100879:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  release(&cons.lock);
80100880:	83 ec 0c             	sub    $0xc,%esp
80100883:	68 20 a5 10 80       	push   $0x8010a520
80100888:	e8 d3 40 00 00       	call   80104960 <release>
  if(doprocdump) {
8010088d:	83 c4 10             	add    $0x10,%esp
80100890:	85 f6                	test   %esi,%esi
80100892:	0f 85 f8 00 00 00    	jne    80100990 <consoleintr+0x180>
}
80100898:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010089b:	5b                   	pop    %ebx
8010089c:	5e                   	pop    %esi
8010089d:	5f                   	pop    %edi
8010089e:	5d                   	pop    %ebp
8010089f:	c3                   	ret    
    switch(c){
801008a0:	83 ff 08             	cmp    $0x8,%edi
801008a3:	74 ac                	je     80100851 <consoleintr+0x41>
      if(c != 0 && input.e-input.r < INPUT_BUF){
801008a5:	85 ff                	test   %edi,%edi
801008a7:	74 87                	je     80100830 <consoleintr+0x20>
801008a9:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
801008ae:	89 c2                	mov    %eax,%edx
801008b0:	2b 15 a0 ff 10 80    	sub    0x8010ffa0,%edx
801008b6:	83 fa 7f             	cmp    $0x7f,%edx
801008b9:	0f 87 71 ff ff ff    	ja     80100830 <consoleintr+0x20>
801008bf:	8d 50 01             	lea    0x1(%eax),%edx
801008c2:	83 e0 7f             	and    $0x7f,%eax
        c = (c == '\r') ? '\n' : c;
801008c5:	83 ff 0d             	cmp    $0xd,%edi
        input.buf[input.e++ % INPUT_BUF] = c;
801008c8:	89 15 a8 ff 10 80    	mov    %edx,0x8010ffa8
        c = (c == '\r') ? '\n' : c;
801008ce:	0f 84 cc 00 00 00    	je     801009a0 <consoleintr+0x190>
        input.buf[input.e++ % INPUT_BUF] = c;
801008d4:	89 f9                	mov    %edi,%ecx
801008d6:	88 88 20 ff 10 80    	mov    %cl,-0x7fef00e0(%eax)
        consputc(c);
801008dc:	89 f8                	mov    %edi,%eax
801008de:	e8 2d fb ff ff       	call   80100410 <consputc>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
801008e3:	83 ff 0a             	cmp    $0xa,%edi
801008e6:	0f 84 c5 00 00 00    	je     801009b1 <consoleintr+0x1a1>
801008ec:	83 ff 04             	cmp    $0x4,%edi
801008ef:	0f 84 bc 00 00 00    	je     801009b1 <consoleintr+0x1a1>
801008f5:	a1 a0 ff 10 80       	mov    0x8010ffa0,%eax
801008fa:	83 e8 80             	sub    $0xffffff80,%eax
801008fd:	39 05 a8 ff 10 80    	cmp    %eax,0x8010ffa8
80100903:	0f 85 27 ff ff ff    	jne    80100830 <consoleintr+0x20>
          wakeup(&input.r);
80100909:	83 ec 0c             	sub    $0xc,%esp
          input.w = input.e;
8010090c:	a3 a4 ff 10 80       	mov    %eax,0x8010ffa4
          wakeup(&input.r);
80100911:	68 a0 ff 10 80       	push   $0x8010ffa0
80100916:	e8 b5 37 00 00       	call   801040d0 <wakeup>
8010091b:	83 c4 10             	add    $0x10,%esp
8010091e:	e9 0d ff ff ff       	jmp    80100830 <consoleintr+0x20>
80100923:	90                   	nop
80100924:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      doprocdump = 1;
80100928:	be 01 00 00 00       	mov    $0x1,%esi
8010092d:	e9 fe fe ff ff       	jmp    80100830 <consoleintr+0x20>
80100932:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      while(input.e != input.w &&
80100938:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
8010093d:	39 05 a4 ff 10 80    	cmp    %eax,0x8010ffa4
80100943:	75 2b                	jne    80100970 <consoleintr+0x160>
80100945:	e9 e6 fe ff ff       	jmp    80100830 <consoleintr+0x20>
8010094a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        input.e--;
80100950:	a3 a8 ff 10 80       	mov    %eax,0x8010ffa8
        consputc(BACKSPACE);
80100955:	b8 00 01 00 00       	mov    $0x100,%eax
8010095a:	e8 b1 fa ff ff       	call   80100410 <consputc>
      while(input.e != input.w &&
8010095f:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
80100964:	3b 05 a4 ff 10 80    	cmp    0x8010ffa4,%eax
8010096a:	0f 84 c0 fe ff ff    	je     80100830 <consoleintr+0x20>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100970:	83 e8 01             	sub    $0x1,%eax
80100973:	89 c2                	mov    %eax,%edx
80100975:	83 e2 7f             	and    $0x7f,%edx
      while(input.e != input.w &&
80100978:	80 ba 20 ff 10 80 0a 	cmpb   $0xa,-0x7fef00e0(%edx)
8010097f:	75 cf                	jne    80100950 <consoleintr+0x140>
80100981:	e9 aa fe ff ff       	jmp    80100830 <consoleintr+0x20>
80100986:	8d 76 00             	lea    0x0(%esi),%esi
80100989:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
}
80100990:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100993:	5b                   	pop    %ebx
80100994:	5e                   	pop    %esi
80100995:	5f                   	pop    %edi
80100996:	5d                   	pop    %ebp
    procdump();  // now call procdump() wo. cons.lock held
80100997:	e9 44 38 00 00       	jmp    801041e0 <procdump>
8010099c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        input.buf[input.e++ % INPUT_BUF] = c;
801009a0:	c6 80 20 ff 10 80 0a 	movb   $0xa,-0x7fef00e0(%eax)
        consputc(c);
801009a7:	b8 0a 00 00 00       	mov    $0xa,%eax
801009ac:	e8 5f fa ff ff       	call   80100410 <consputc>
801009b1:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
801009b6:	e9 4e ff ff ff       	jmp    80100909 <consoleintr+0xf9>
801009bb:	90                   	nop
801009bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801009c0 <consoleinit>:

void
consoleinit(void)
{
801009c0:	55                   	push   %ebp
801009c1:	89 e5                	mov    %esp,%ebp
801009c3:	83 ec 10             	sub    $0x10,%esp
  initlock(&cons.lock, "console");
801009c6:	68 c8 75 10 80       	push   $0x801075c8
801009cb:	68 20 a5 10 80       	push   $0x8010a520
801009d0:	e8 8b 3d 00 00       	call   80104760 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  ioapicenable(IRQ_KBD, 0);
801009d5:	58                   	pop    %eax
801009d6:	5a                   	pop    %edx
801009d7:	6a 00                	push   $0x0
801009d9:	6a 01                	push   $0x1
  devsw[CONSOLE].write = consolewrite;
801009db:	c7 05 6c 09 11 80 00 	movl   $0x80100600,0x8011096c
801009e2:	06 10 80 
  devsw[CONSOLE].read = consoleread;
801009e5:	c7 05 68 09 11 80 70 	movl   $0x80100270,0x80110968
801009ec:	02 10 80 
  cons.locking = 1;
801009ef:	c7 05 54 a5 10 80 01 	movl   $0x1,0x8010a554
801009f6:	00 00 00 
  ioapicenable(IRQ_KBD, 0);
801009f9:	e8 02 19 00 00       	call   80102300 <ioapicenable>
}
801009fe:	83 c4 10             	add    $0x10,%esp
80100a01:	c9                   	leave  
80100a02:	c3                   	ret    
80100a03:	66 90                	xchg   %ax,%ax
80100a05:	66 90                	xchg   %ax,%ax
80100a07:	66 90                	xchg   %ax,%ax
80100a09:	66 90                	xchg   %ax,%ax
80100a0b:	66 90                	xchg   %ax,%ax
80100a0d:	66 90                	xchg   %ax,%ax
80100a0f:	90                   	nop

80100a10 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
80100a10:	55                   	push   %ebp
80100a11:	89 e5                	mov    %esp,%ebp
80100a13:	57                   	push   %edi
80100a14:	56                   	push   %esi
80100a15:	53                   	push   %ebx
80100a16:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
80100a1c:	e8 ef 2e 00 00       	call   80103910 <myproc>
80100a21:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)

  begin_op();
80100a27:	e8 a4 21 00 00       	call   80102bd0 <begin_op>

  if((ip = namei(path)) == 0){
80100a2c:	83 ec 0c             	sub    $0xc,%esp
80100a2f:	ff 75 08             	pushl  0x8(%ebp)
80100a32:	e8 d9 14 00 00       	call   80101f10 <namei>
80100a37:	83 c4 10             	add    $0x10,%esp
80100a3a:	85 c0                	test   %eax,%eax
80100a3c:	0f 84 91 01 00 00    	je     80100bd3 <exec+0x1c3>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
80100a42:	83 ec 0c             	sub    $0xc,%esp
80100a45:	89 c3                	mov    %eax,%ebx
80100a47:	50                   	push   %eax
80100a48:	e8 63 0c 00 00       	call   801016b0 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80100a4d:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80100a53:	6a 34                	push   $0x34
80100a55:	6a 00                	push   $0x0
80100a57:	50                   	push   %eax
80100a58:	53                   	push   %ebx
80100a59:	e8 32 0f 00 00       	call   80101990 <readi>
80100a5e:	83 c4 20             	add    $0x20,%esp
80100a61:	83 f8 34             	cmp    $0x34,%eax
80100a64:	74 22                	je     80100a88 <exec+0x78>

 bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
80100a66:	83 ec 0c             	sub    $0xc,%esp
80100a69:	53                   	push   %ebx
80100a6a:	e8 d1 0e 00 00       	call   80101940 <iunlockput>
    end_op();
80100a6f:	e8 cc 21 00 00       	call   80102c40 <end_op>
80100a74:	83 c4 10             	add    $0x10,%esp
  }
  return -1;
80100a77:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100a7c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100a7f:	5b                   	pop    %ebx
80100a80:	5e                   	pop    %esi
80100a81:	5f                   	pop    %edi
80100a82:	5d                   	pop    %ebp
80100a83:	c3                   	ret    
80100a84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(elf.magic != ELF_MAGIC)
80100a88:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100a8f:	45 4c 46 
80100a92:	75 d2                	jne    80100a66 <exec+0x56>
  if((pgdir = setupkvm()) == 0)
80100a94:	e8 17 68 00 00       	call   801072b0 <setupkvm>
80100a99:	85 c0                	test   %eax,%eax
80100a9b:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100aa1:	74 c3                	je     80100a66 <exec+0x56>
  sz = 0;
80100aa3:	31 ff                	xor    %edi,%edi
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100aa5:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80100aac:	00 
80100aad:	8b 85 40 ff ff ff    	mov    -0xc0(%ebp),%eax
80100ab3:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)
80100ab9:	0f 84 bb 02 00 00    	je     80100d7a <exec+0x36a>
80100abf:	31 f6                	xor    %esi,%esi
80100ac1:	eb 7f                	jmp    80100b42 <exec+0x132>
80100ac3:	90                   	nop
80100ac4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ph.type != ELF_PROG_LOAD)
80100ac8:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80100acf:	75 63                	jne    80100b34 <exec+0x124>
    if(ph.memsz < ph.filesz)
80100ad1:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80100ad7:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80100add:	0f 82 86 00 00 00    	jb     80100b69 <exec+0x159>
80100ae3:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80100ae9:	72 7e                	jb     80100b69 <exec+0x159>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100aeb:	83 ec 04             	sub    $0x4,%esp
80100aee:	50                   	push   %eax
80100aef:	57                   	push   %edi
80100af0:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100af6:	e8 d5 65 00 00       	call   801070d0 <allocuvm>
80100afb:	83 c4 10             	add    $0x10,%esp
80100afe:	85 c0                	test   %eax,%eax
80100b00:	89 c7                	mov    %eax,%edi
80100b02:	74 65                	je     80100b69 <exec+0x159>
    if(ph.vaddr % PGSIZE != 0)
80100b04:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100b0a:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100b0f:	75 58                	jne    80100b69 <exec+0x159>
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100b11:	83 ec 0c             	sub    $0xc,%esp
80100b14:	ff b5 14 ff ff ff    	pushl  -0xec(%ebp)
80100b1a:	ff b5 08 ff ff ff    	pushl  -0xf8(%ebp)
80100b20:	53                   	push   %ebx
80100b21:	50                   	push   %eax
80100b22:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100b28:	e8 e3 64 00 00       	call   80107010 <loaduvm>
80100b2d:	83 c4 20             	add    $0x20,%esp
80100b30:	85 c0                	test   %eax,%eax
80100b32:	78 35                	js     80100b69 <exec+0x159>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100b34:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80100b3b:	83 c6 01             	add    $0x1,%esi
80100b3e:	39 f0                	cmp    %esi,%eax
80100b40:	7e 3d                	jle    80100b7f <exec+0x16f>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100b42:	89 f0                	mov    %esi,%eax
80100b44:	6a 20                	push   $0x20
80100b46:	c1 e0 05             	shl    $0x5,%eax
80100b49:	03 85 ec fe ff ff    	add    -0x114(%ebp),%eax
80100b4f:	50                   	push   %eax
80100b50:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80100b56:	50                   	push   %eax
80100b57:	53                   	push   %ebx
80100b58:	e8 33 0e 00 00       	call   80101990 <readi>
80100b5d:	83 c4 10             	add    $0x10,%esp
80100b60:	83 f8 20             	cmp    $0x20,%eax
80100b63:	0f 84 5f ff ff ff    	je     80100ac8 <exec+0xb8>
    freevm(pgdir);
80100b69:	83 ec 0c             	sub    $0xc,%esp
80100b6c:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100b72:	e8 b9 66 00 00       	call   80107230 <freevm>
80100b77:	83 c4 10             	add    $0x10,%esp
80100b7a:	e9 e7 fe ff ff       	jmp    80100a66 <exec+0x56>
80100b7f:	81 c7 ff 0f 00 00    	add    $0xfff,%edi
80100b85:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
80100b8b:	8d b7 00 20 00 00    	lea    0x2000(%edi),%esi
  iunlockput(ip);
80100b91:	83 ec 0c             	sub    $0xc,%esp
80100b94:	53                   	push   %ebx
80100b95:	e8 a6 0d 00 00       	call   80101940 <iunlockput>
  end_op();
80100b9a:	e8 a1 20 00 00       	call   80102c40 <end_op>
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100b9f:	83 c4 0c             	add    $0xc,%esp
80100ba2:	56                   	push   %esi
80100ba3:	57                   	push   %edi
80100ba4:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100baa:	e8 21 65 00 00       	call   801070d0 <allocuvm>
80100baf:	83 c4 10             	add    $0x10,%esp
80100bb2:	85 c0                	test   %eax,%eax
80100bb4:	89 c6                	mov    %eax,%esi
80100bb6:	75 3a                	jne    80100bf2 <exec+0x1e2>
    freevm(pgdir);
80100bb8:	83 ec 0c             	sub    $0xc,%esp
80100bbb:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100bc1:	e8 6a 66 00 00       	call   80107230 <freevm>
80100bc6:	83 c4 10             	add    $0x10,%esp
  return -1;
80100bc9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100bce:	e9 a9 fe ff ff       	jmp    80100a7c <exec+0x6c>
    end_op();
80100bd3:	e8 68 20 00 00       	call   80102c40 <end_op>
    cprintf("exec: fail\n");
80100bd8:	83 ec 0c             	sub    $0xc,%esp
80100bdb:	68 e1 75 10 80       	push   $0x801075e1
80100be0:	e8 7b fa ff ff       	call   80100660 <cprintf>
    return -1;
80100be5:	83 c4 10             	add    $0x10,%esp
80100be8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100bed:	e9 8a fe ff ff       	jmp    80100a7c <exec+0x6c>
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100bf2:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
80100bf8:	83 ec 08             	sub    $0x8,%esp
  for(argc = 0; argv[argc]; argc++) {
80100bfb:	31 ff                	xor    %edi,%edi
80100bfd:	89 f3                	mov    %esi,%ebx
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100bff:	50                   	push   %eax
80100c00:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100c06:	e8 45 67 00 00       	call   80107350 <clearpteu>
  for(argc = 0; argv[argc]; argc++) {
80100c0b:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c0e:	83 c4 10             	add    $0x10,%esp
80100c11:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
80100c17:	8b 00                	mov    (%eax),%eax
80100c19:	85 c0                	test   %eax,%eax
80100c1b:	74 70                	je     80100c8d <exec+0x27d>
80100c1d:	89 b5 ec fe ff ff    	mov    %esi,-0x114(%ebp)
80100c23:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
80100c29:	eb 0a                	jmp    80100c35 <exec+0x225>
80100c2b:	90                   	nop
80100c2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(argc >= MAXARG)
80100c30:	83 ff 20             	cmp    $0x20,%edi
80100c33:	74 83                	je     80100bb8 <exec+0x1a8>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100c35:	83 ec 0c             	sub    $0xc,%esp
80100c38:	50                   	push   %eax
80100c39:	e8 92 3f 00 00       	call   80104bd0 <strlen>
80100c3e:	f7 d0                	not    %eax
80100c40:	01 c3                	add    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c42:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c45:	5a                   	pop    %edx
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100c46:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c49:	ff 34 b8             	pushl  (%eax,%edi,4)
80100c4c:	e8 7f 3f 00 00       	call   80104bd0 <strlen>
80100c51:	83 c0 01             	add    $0x1,%eax
80100c54:	50                   	push   %eax
80100c55:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c58:	ff 34 b8             	pushl  (%eax,%edi,4)
80100c5b:	53                   	push   %ebx
80100c5c:	56                   	push   %esi
80100c5d:	e8 4e 68 00 00       	call   801074b0 <copyout>
80100c62:	83 c4 20             	add    $0x20,%esp
80100c65:	85 c0                	test   %eax,%eax
80100c67:	0f 88 4b ff ff ff    	js     80100bb8 <exec+0x1a8>
  for(argc = 0; argv[argc]; argc++) {
80100c6d:	8b 45 0c             	mov    0xc(%ebp),%eax
    ustack[3+argc] = sp;
80100c70:	89 9c bd 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%edi,4)
  for(argc = 0; argv[argc]; argc++) {
80100c77:	83 c7 01             	add    $0x1,%edi
    ustack[3+argc] = sp;
80100c7a:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
  for(argc = 0; argv[argc]; argc++) {
80100c80:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80100c83:	85 c0                	test   %eax,%eax
80100c85:	75 a9                	jne    80100c30 <exec+0x220>
80100c87:	8b b5 ec fe ff ff    	mov    -0x114(%ebp),%esi
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100c8d:	8d 04 bd 04 00 00 00 	lea    0x4(,%edi,4),%eax
80100c94:	89 d9                	mov    %ebx,%ecx
  ustack[3+argc] = 0;
80100c96:	c7 84 bd 64 ff ff ff 	movl   $0x0,-0x9c(%ebp,%edi,4)
80100c9d:	00 00 00 00 
  ustack[0] = 0xffffffff;  // fake return PC
80100ca1:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
80100ca8:	ff ff ff 
  ustack[1] = argc;
80100cab:	89 bd 5c ff ff ff    	mov    %edi,-0xa4(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100cb1:	29 c1                	sub    %eax,%ecx
  sp -= (3+argc+1) * 4;
80100cb3:	83 c0 0c             	add    $0xc,%eax
80100cb6:	29 c3                	sub    %eax,%ebx
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100cb8:	50                   	push   %eax
80100cb9:	52                   	push   %edx
80100cba:	53                   	push   %ebx
80100cbb:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100cc1:	89 8d 60 ff ff ff    	mov    %ecx,-0xa0(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100cc7:	e8 e4 67 00 00       	call   801074b0 <copyout>
80100ccc:	83 c4 10             	add    $0x10,%esp
80100ccf:	85 c0                	test   %eax,%eax
80100cd1:	0f 88 e1 fe ff ff    	js     80100bb8 <exec+0x1a8>
  for(last=s=path; *s; s++)
80100cd7:	8b 45 08             	mov    0x8(%ebp),%eax
80100cda:	0f b6 00             	movzbl (%eax),%eax
80100cdd:	84 c0                	test   %al,%al
80100cdf:	74 17                	je     80100cf8 <exec+0x2e8>
80100ce1:	8b 55 08             	mov    0x8(%ebp),%edx
80100ce4:	89 d1                	mov    %edx,%ecx
80100ce6:	83 c1 01             	add    $0x1,%ecx
80100ce9:	3c 2f                	cmp    $0x2f,%al
80100ceb:	0f b6 01             	movzbl (%ecx),%eax
80100cee:	0f 44 d1             	cmove  %ecx,%edx
80100cf1:	84 c0                	test   %al,%al
80100cf3:	75 f1                	jne    80100ce6 <exec+0x2d6>
80100cf5:	89 55 08             	mov    %edx,0x8(%ebp)
  safestrcpy(curproc->name, last, sizeof(curproc->name));
80100cf8:	8b bd f4 fe ff ff    	mov    -0x10c(%ebp),%edi
80100cfe:	50                   	push   %eax
80100cff:	6a 10                	push   $0x10
80100d01:	ff 75 08             	pushl  0x8(%ebp)
80100d04:	8d 47 6c             	lea    0x6c(%edi),%eax
80100d07:	50                   	push   %eax
80100d08:	e8 83 3e 00 00       	call   80104b90 <safestrcpy>
  curproc->pgdir = pgdir;
80100d0d:	8b 8d f0 fe ff ff    	mov    -0x110(%ebp),%ecx
  oldpgdir = curproc->pgdir;
80100d13:	89 fa                	mov    %edi,%edx
80100d15:	8b 7f 04             	mov    0x4(%edi),%edi
  curproc->tf->eip = elf.entry;  // main
80100d18:	8b 42 18             	mov    0x18(%edx),%eax
  curproc->sz = sz;
80100d1b:	89 32                	mov    %esi,(%edx)
80100d1d:	83 c4 10             	add    $0x10,%esp
  curproc->pgdir = pgdir;
80100d20:	89 4a 04             	mov    %ecx,0x4(%edx)
  curproc->tf->eip = elf.entry;  // main
80100d23:	89 d1                	mov    %edx,%ecx
80100d25:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
80100d2b:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
80100d2e:	8b 41 18             	mov    0x18(%ecx),%eax
80100d31:	89 ca                	mov    %ecx,%edx
80100d33:	81 c2 8c 01 00 00    	add    $0x18c,%edx
80100d39:	89 58 44             	mov    %ebx,0x44(%eax)
80100d3c:	89 c8                	mov    %ecx,%eax
80100d3e:	05 8c 00 00 00       	add    $0x8c,%eax
80100d43:	90                   	nop
80100d44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if ((int)curproc->signal_handlers[i].sa_handler != SIG_IGN)
80100d48:	83 38 01             	cmpl   $0x1,(%eax)
80100d4b:	74 06                	je     80100d53 <exec+0x343>
      curproc->signal_handlers[i].sa_handler = SIG_DFL;
80100d4d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80100d53:	83 c0 08             	add    $0x8,%eax
  for(int i=0; i<32; i++){
80100d56:	39 c2                	cmp    %eax,%edx
80100d58:	75 ee                	jne    80100d48 <exec+0x338>
  switchuvm(curproc);
80100d5a:	83 ec 0c             	sub    $0xc,%esp
80100d5d:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100d63:	e8 18 61 00 00       	call   80106e80 <switchuvm>
  freevm(oldpgdir);
80100d68:	89 3c 24             	mov    %edi,(%esp)
80100d6b:	e8 c0 64 00 00       	call   80107230 <freevm>
  return 0;
80100d70:	83 c4 10             	add    $0x10,%esp
80100d73:	31 c0                	xor    %eax,%eax
80100d75:	e9 02 fd ff ff       	jmp    80100a7c <exec+0x6c>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100d7a:	be 00 20 00 00       	mov    $0x2000,%esi
80100d7f:	e9 0d fe ff ff       	jmp    80100b91 <exec+0x181>
80100d84:	66 90                	xchg   %ax,%ax
80100d86:	66 90                	xchg   %ax,%ax
80100d88:	66 90                	xchg   %ax,%ax
80100d8a:	66 90                	xchg   %ax,%ax
80100d8c:	66 90                	xchg   %ax,%ax
80100d8e:	66 90                	xchg   %ax,%ax

80100d90 <fileinit>:
80100d90:	55                   	push   %ebp
80100d91:	89 e5                	mov    %esp,%ebp
80100d93:	83 ec 10             	sub    $0x10,%esp
80100d96:	68 ed 75 10 80       	push   $0x801075ed
80100d9b:	68 c0 ff 10 80       	push   $0x8010ffc0
80100da0:	e8 bb 39 00 00       	call   80104760 <initlock>
80100da5:	83 c4 10             	add    $0x10,%esp
80100da8:	c9                   	leave  
80100da9:	c3                   	ret    
80100daa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100db0 <filealloc>:
80100db0:	55                   	push   %ebp
80100db1:	89 e5                	mov    %esp,%ebp
80100db3:	53                   	push   %ebx
80100db4:	bb f4 ff 10 80       	mov    $0x8010fff4,%ebx
80100db9:	83 ec 10             	sub    $0x10,%esp
80100dbc:	68 c0 ff 10 80       	push   $0x8010ffc0
80100dc1:	e8 da 3a 00 00       	call   801048a0 <acquire>
80100dc6:	83 c4 10             	add    $0x10,%esp
80100dc9:	eb 10                	jmp    80100ddb <filealloc+0x2b>
80100dcb:	90                   	nop
80100dcc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100dd0:	83 c3 18             	add    $0x18,%ebx
80100dd3:	81 fb 54 09 11 80    	cmp    $0x80110954,%ebx
80100dd9:	73 25                	jae    80100e00 <filealloc+0x50>
80100ddb:	8b 43 04             	mov    0x4(%ebx),%eax
80100dde:	85 c0                	test   %eax,%eax
80100de0:	75 ee                	jne    80100dd0 <filealloc+0x20>
80100de2:	83 ec 0c             	sub    $0xc,%esp
80100de5:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
80100dec:	68 c0 ff 10 80       	push   $0x8010ffc0
80100df1:	e8 6a 3b 00 00       	call   80104960 <release>
80100df6:	89 d8                	mov    %ebx,%eax
80100df8:	83 c4 10             	add    $0x10,%esp
80100dfb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100dfe:	c9                   	leave  
80100dff:	c3                   	ret    
80100e00:	83 ec 0c             	sub    $0xc,%esp
80100e03:	31 db                	xor    %ebx,%ebx
80100e05:	68 c0 ff 10 80       	push   $0x8010ffc0
80100e0a:	e8 51 3b 00 00       	call   80104960 <release>
80100e0f:	89 d8                	mov    %ebx,%eax
80100e11:	83 c4 10             	add    $0x10,%esp
80100e14:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100e17:	c9                   	leave  
80100e18:	c3                   	ret    
80100e19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100e20 <filedup>:
80100e20:	55                   	push   %ebp
80100e21:	89 e5                	mov    %esp,%ebp
80100e23:	53                   	push   %ebx
80100e24:	83 ec 10             	sub    $0x10,%esp
80100e27:	8b 5d 08             	mov    0x8(%ebp),%ebx
80100e2a:	68 c0 ff 10 80       	push   $0x8010ffc0
80100e2f:	e8 6c 3a 00 00       	call   801048a0 <acquire>
80100e34:	8b 43 04             	mov    0x4(%ebx),%eax
80100e37:	83 c4 10             	add    $0x10,%esp
80100e3a:	85 c0                	test   %eax,%eax
80100e3c:	7e 1a                	jle    80100e58 <filedup+0x38>
80100e3e:	83 c0 01             	add    $0x1,%eax
80100e41:	83 ec 0c             	sub    $0xc,%esp
80100e44:	89 43 04             	mov    %eax,0x4(%ebx)
80100e47:	68 c0 ff 10 80       	push   $0x8010ffc0
80100e4c:	e8 0f 3b 00 00       	call   80104960 <release>
80100e51:	89 d8                	mov    %ebx,%eax
80100e53:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100e56:	c9                   	leave  
80100e57:	c3                   	ret    
80100e58:	83 ec 0c             	sub    $0xc,%esp
80100e5b:	68 f4 75 10 80       	push   $0x801075f4
80100e60:	e8 2b f5 ff ff       	call   80100390 <panic>
80100e65:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100e69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100e70 <fileclose>:
80100e70:	55                   	push   %ebp
80100e71:	89 e5                	mov    %esp,%ebp
80100e73:	57                   	push   %edi
80100e74:	56                   	push   %esi
80100e75:	53                   	push   %ebx
80100e76:	83 ec 28             	sub    $0x28,%esp
80100e79:	8b 5d 08             	mov    0x8(%ebp),%ebx
80100e7c:	68 c0 ff 10 80       	push   $0x8010ffc0
80100e81:	e8 1a 3a 00 00       	call   801048a0 <acquire>
80100e86:	8b 43 04             	mov    0x4(%ebx),%eax
80100e89:	83 c4 10             	add    $0x10,%esp
80100e8c:	85 c0                	test   %eax,%eax
80100e8e:	0f 8e 9b 00 00 00    	jle    80100f2f <fileclose+0xbf>
80100e94:	83 e8 01             	sub    $0x1,%eax
80100e97:	85 c0                	test   %eax,%eax
80100e99:	89 43 04             	mov    %eax,0x4(%ebx)
80100e9c:	74 1a                	je     80100eb8 <fileclose+0x48>
80100e9e:	c7 45 08 c0 ff 10 80 	movl   $0x8010ffc0,0x8(%ebp)
80100ea5:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100ea8:	5b                   	pop    %ebx
80100ea9:	5e                   	pop    %esi
80100eaa:	5f                   	pop    %edi
80100eab:	5d                   	pop    %ebp
80100eac:	e9 af 3a 00 00       	jmp    80104960 <release>
80100eb1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100eb8:	0f b6 43 09          	movzbl 0x9(%ebx),%eax
80100ebc:	8b 3b                	mov    (%ebx),%edi
80100ebe:	83 ec 0c             	sub    $0xc,%esp
80100ec1:	8b 73 0c             	mov    0xc(%ebx),%esi
80100ec4:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80100eca:	88 45 e7             	mov    %al,-0x19(%ebp)
80100ecd:	8b 43 10             	mov    0x10(%ebx),%eax
80100ed0:	68 c0 ff 10 80       	push   $0x8010ffc0
80100ed5:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100ed8:	e8 83 3a 00 00       	call   80104960 <release>
80100edd:	83 c4 10             	add    $0x10,%esp
80100ee0:	83 ff 01             	cmp    $0x1,%edi
80100ee3:	74 13                	je     80100ef8 <fileclose+0x88>
80100ee5:	83 ff 02             	cmp    $0x2,%edi
80100ee8:	74 26                	je     80100f10 <fileclose+0xa0>
80100eea:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100eed:	5b                   	pop    %ebx
80100eee:	5e                   	pop    %esi
80100eef:	5f                   	pop    %edi
80100ef0:	5d                   	pop    %ebp
80100ef1:	c3                   	ret    
80100ef2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100ef8:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
80100efc:	83 ec 08             	sub    $0x8,%esp
80100eff:	53                   	push   %ebx
80100f00:	56                   	push   %esi
80100f01:	e8 7a 24 00 00       	call   80103380 <pipeclose>
80100f06:	83 c4 10             	add    $0x10,%esp
80100f09:	eb df                	jmp    80100eea <fileclose+0x7a>
80100f0b:	90                   	nop
80100f0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100f10:	e8 bb 1c 00 00       	call   80102bd0 <begin_op>
80100f15:	83 ec 0c             	sub    $0xc,%esp
80100f18:	ff 75 e0             	pushl  -0x20(%ebp)
80100f1b:	e8 c0 08 00 00       	call   801017e0 <iput>
80100f20:	83 c4 10             	add    $0x10,%esp
80100f23:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100f26:	5b                   	pop    %ebx
80100f27:	5e                   	pop    %esi
80100f28:	5f                   	pop    %edi
80100f29:	5d                   	pop    %ebp
80100f2a:	e9 11 1d 00 00       	jmp    80102c40 <end_op>
80100f2f:	83 ec 0c             	sub    $0xc,%esp
80100f32:	68 fc 75 10 80       	push   $0x801075fc
80100f37:	e8 54 f4 ff ff       	call   80100390 <panic>
80100f3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100f40 <filestat>:
80100f40:	55                   	push   %ebp
80100f41:	89 e5                	mov    %esp,%ebp
80100f43:	53                   	push   %ebx
80100f44:	83 ec 04             	sub    $0x4,%esp
80100f47:	8b 5d 08             	mov    0x8(%ebp),%ebx
80100f4a:	83 3b 02             	cmpl   $0x2,(%ebx)
80100f4d:	75 31                	jne    80100f80 <filestat+0x40>
80100f4f:	83 ec 0c             	sub    $0xc,%esp
80100f52:	ff 73 10             	pushl  0x10(%ebx)
80100f55:	e8 56 07 00 00       	call   801016b0 <ilock>
80100f5a:	58                   	pop    %eax
80100f5b:	5a                   	pop    %edx
80100f5c:	ff 75 0c             	pushl  0xc(%ebp)
80100f5f:	ff 73 10             	pushl  0x10(%ebx)
80100f62:	e8 f9 09 00 00       	call   80101960 <stati>
80100f67:	59                   	pop    %ecx
80100f68:	ff 73 10             	pushl  0x10(%ebx)
80100f6b:	e8 20 08 00 00       	call   80101790 <iunlock>
80100f70:	83 c4 10             	add    $0x10,%esp
80100f73:	31 c0                	xor    %eax,%eax
80100f75:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100f78:	c9                   	leave  
80100f79:	c3                   	ret    
80100f7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100f80:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100f85:	eb ee                	jmp    80100f75 <filestat+0x35>
80100f87:	89 f6                	mov    %esi,%esi
80100f89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100f90 <fileread>:
80100f90:	55                   	push   %ebp
80100f91:	89 e5                	mov    %esp,%ebp
80100f93:	57                   	push   %edi
80100f94:	56                   	push   %esi
80100f95:	53                   	push   %ebx
80100f96:	83 ec 0c             	sub    $0xc,%esp
80100f99:	8b 5d 08             	mov    0x8(%ebp),%ebx
80100f9c:	8b 75 0c             	mov    0xc(%ebp),%esi
80100f9f:	8b 7d 10             	mov    0x10(%ebp),%edi
80100fa2:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80100fa6:	74 60                	je     80101008 <fileread+0x78>
80100fa8:	8b 03                	mov    (%ebx),%eax
80100faa:	83 f8 01             	cmp    $0x1,%eax
80100fad:	74 41                	je     80100ff0 <fileread+0x60>
80100faf:	83 f8 02             	cmp    $0x2,%eax
80100fb2:	75 5b                	jne    8010100f <fileread+0x7f>
80100fb4:	83 ec 0c             	sub    $0xc,%esp
80100fb7:	ff 73 10             	pushl  0x10(%ebx)
80100fba:	e8 f1 06 00 00       	call   801016b0 <ilock>
80100fbf:	57                   	push   %edi
80100fc0:	ff 73 14             	pushl  0x14(%ebx)
80100fc3:	56                   	push   %esi
80100fc4:	ff 73 10             	pushl  0x10(%ebx)
80100fc7:	e8 c4 09 00 00       	call   80101990 <readi>
80100fcc:	83 c4 20             	add    $0x20,%esp
80100fcf:	85 c0                	test   %eax,%eax
80100fd1:	89 c6                	mov    %eax,%esi
80100fd3:	7e 03                	jle    80100fd8 <fileread+0x48>
80100fd5:	01 43 14             	add    %eax,0x14(%ebx)
80100fd8:	83 ec 0c             	sub    $0xc,%esp
80100fdb:	ff 73 10             	pushl  0x10(%ebx)
80100fde:	e8 ad 07 00 00       	call   80101790 <iunlock>
80100fe3:	83 c4 10             	add    $0x10,%esp
80100fe6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100fe9:	89 f0                	mov    %esi,%eax
80100feb:	5b                   	pop    %ebx
80100fec:	5e                   	pop    %esi
80100fed:	5f                   	pop    %edi
80100fee:	5d                   	pop    %ebp
80100fef:	c3                   	ret    
80100ff0:	8b 43 0c             	mov    0xc(%ebx),%eax
80100ff3:	89 45 08             	mov    %eax,0x8(%ebp)
80100ff6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100ff9:	5b                   	pop    %ebx
80100ffa:	5e                   	pop    %esi
80100ffb:	5f                   	pop    %edi
80100ffc:	5d                   	pop    %ebp
80100ffd:	e9 2e 25 00 00       	jmp    80103530 <piperead>
80101002:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101008:	be ff ff ff ff       	mov    $0xffffffff,%esi
8010100d:	eb d7                	jmp    80100fe6 <fileread+0x56>
8010100f:	83 ec 0c             	sub    $0xc,%esp
80101012:	68 06 76 10 80       	push   $0x80107606
80101017:	e8 74 f3 ff ff       	call   80100390 <panic>
8010101c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101020 <filewrite>:
80101020:	55                   	push   %ebp
80101021:	89 e5                	mov    %esp,%ebp
80101023:	57                   	push   %edi
80101024:	56                   	push   %esi
80101025:	53                   	push   %ebx
80101026:	83 ec 1c             	sub    $0x1c,%esp
80101029:	8b 75 08             	mov    0x8(%ebp),%esi
8010102c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010102f:	80 7e 09 00          	cmpb   $0x0,0x9(%esi)
80101033:	89 45 dc             	mov    %eax,-0x24(%ebp)
80101036:	8b 45 10             	mov    0x10(%ebp),%eax
80101039:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010103c:	0f 84 aa 00 00 00    	je     801010ec <filewrite+0xcc>
80101042:	8b 06                	mov    (%esi),%eax
80101044:	83 f8 01             	cmp    $0x1,%eax
80101047:	0f 84 c3 00 00 00    	je     80101110 <filewrite+0xf0>
8010104d:	83 f8 02             	cmp    $0x2,%eax
80101050:	0f 85 d9 00 00 00    	jne    8010112f <filewrite+0x10f>
80101056:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101059:	31 ff                	xor    %edi,%edi
8010105b:	85 c0                	test   %eax,%eax
8010105d:	7f 34                	jg     80101093 <filewrite+0x73>
8010105f:	e9 9c 00 00 00       	jmp    80101100 <filewrite+0xe0>
80101064:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101068:	01 46 14             	add    %eax,0x14(%esi)
8010106b:	83 ec 0c             	sub    $0xc,%esp
8010106e:	ff 76 10             	pushl  0x10(%esi)
80101071:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101074:	e8 17 07 00 00       	call   80101790 <iunlock>
80101079:	e8 c2 1b 00 00       	call   80102c40 <end_op>
8010107e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101081:	83 c4 10             	add    $0x10,%esp
80101084:	39 c3                	cmp    %eax,%ebx
80101086:	0f 85 96 00 00 00    	jne    80101122 <filewrite+0x102>
8010108c:	01 df                	add    %ebx,%edi
8010108e:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101091:	7e 6d                	jle    80101100 <filewrite+0xe0>
80101093:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101096:	b8 00 06 00 00       	mov    $0x600,%eax
8010109b:	29 fb                	sub    %edi,%ebx
8010109d:	81 fb 00 06 00 00    	cmp    $0x600,%ebx
801010a3:	0f 4f d8             	cmovg  %eax,%ebx
801010a6:	e8 25 1b 00 00       	call   80102bd0 <begin_op>
801010ab:	83 ec 0c             	sub    $0xc,%esp
801010ae:	ff 76 10             	pushl  0x10(%esi)
801010b1:	e8 fa 05 00 00       	call   801016b0 <ilock>
801010b6:	8b 45 dc             	mov    -0x24(%ebp),%eax
801010b9:	53                   	push   %ebx
801010ba:	ff 76 14             	pushl  0x14(%esi)
801010bd:	01 f8                	add    %edi,%eax
801010bf:	50                   	push   %eax
801010c0:	ff 76 10             	pushl  0x10(%esi)
801010c3:	e8 c8 09 00 00       	call   80101a90 <writei>
801010c8:	83 c4 20             	add    $0x20,%esp
801010cb:	85 c0                	test   %eax,%eax
801010cd:	7f 99                	jg     80101068 <filewrite+0x48>
801010cf:	83 ec 0c             	sub    $0xc,%esp
801010d2:	ff 76 10             	pushl  0x10(%esi)
801010d5:	89 45 e0             	mov    %eax,-0x20(%ebp)
801010d8:	e8 b3 06 00 00       	call   80101790 <iunlock>
801010dd:	e8 5e 1b 00 00       	call   80102c40 <end_op>
801010e2:	8b 45 e0             	mov    -0x20(%ebp),%eax
801010e5:	83 c4 10             	add    $0x10,%esp
801010e8:	85 c0                	test   %eax,%eax
801010ea:	74 98                	je     80101084 <filewrite+0x64>
801010ec:	8d 65 f4             	lea    -0xc(%ebp),%esp
801010ef:	bf ff ff ff ff       	mov    $0xffffffff,%edi
801010f4:	89 f8                	mov    %edi,%eax
801010f6:	5b                   	pop    %ebx
801010f7:	5e                   	pop    %esi
801010f8:	5f                   	pop    %edi
801010f9:	5d                   	pop    %ebp
801010fa:	c3                   	ret    
801010fb:	90                   	nop
801010fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101100:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101103:	75 e7                	jne    801010ec <filewrite+0xcc>
80101105:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101108:	89 f8                	mov    %edi,%eax
8010110a:	5b                   	pop    %ebx
8010110b:	5e                   	pop    %esi
8010110c:	5f                   	pop    %edi
8010110d:	5d                   	pop    %ebp
8010110e:	c3                   	ret    
8010110f:	90                   	nop
80101110:	8b 46 0c             	mov    0xc(%esi),%eax
80101113:	89 45 08             	mov    %eax,0x8(%ebp)
80101116:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101119:	5b                   	pop    %ebx
8010111a:	5e                   	pop    %esi
8010111b:	5f                   	pop    %edi
8010111c:	5d                   	pop    %ebp
8010111d:	e9 fe 22 00 00       	jmp    80103420 <pipewrite>
80101122:	83 ec 0c             	sub    $0xc,%esp
80101125:	68 0f 76 10 80       	push   $0x8010760f
8010112a:	e8 61 f2 ff ff       	call   80100390 <panic>
8010112f:	83 ec 0c             	sub    $0xc,%esp
80101132:	68 15 76 10 80       	push   $0x80107615
80101137:	e8 54 f2 ff ff       	call   80100390 <panic>
8010113c:	66 90                	xchg   %ax,%ax
8010113e:	66 90                	xchg   %ax,%ax

80101140 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
80101140:	55                   	push   %ebp
80101141:	89 e5                	mov    %esp,%ebp
80101143:	56                   	push   %esi
80101144:	53                   	push   %ebx
80101145:	89 d3                	mov    %edx,%ebx
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
80101147:	c1 ea 0c             	shr    $0xc,%edx
8010114a:	03 15 d8 09 11 80    	add    0x801109d8,%edx
80101150:	83 ec 08             	sub    $0x8,%esp
80101153:	52                   	push   %edx
80101154:	50                   	push   %eax
80101155:	e8 76 ef ff ff       	call   801000d0 <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
8010115a:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
8010115c:	c1 fb 03             	sar    $0x3,%ebx
  m = 1 << (bi % 8);
8010115f:	ba 01 00 00 00       	mov    $0x1,%edx
80101164:	83 e1 07             	and    $0x7,%ecx
  if((bp->data[bi/8] & m) == 0)
80101167:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
8010116d:	83 c4 10             	add    $0x10,%esp
  m = 1 << (bi % 8);
80101170:	d3 e2                	shl    %cl,%edx
  if((bp->data[bi/8] & m) == 0)
80101172:	0f b6 4c 18 5c       	movzbl 0x5c(%eax,%ebx,1),%ecx
80101177:	85 d1                	test   %edx,%ecx
80101179:	74 25                	je     801011a0 <bfree+0x60>
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
8010117b:	f7 d2                	not    %edx
8010117d:	89 c6                	mov    %eax,%esi
  log_write(bp);
8010117f:	83 ec 0c             	sub    $0xc,%esp
  bp->data[bi/8] &= ~m;
80101182:	21 ca                	and    %ecx,%edx
80101184:	88 54 1e 5c          	mov    %dl,0x5c(%esi,%ebx,1)
  log_write(bp);
80101188:	56                   	push   %esi
80101189:	e8 12 1c 00 00       	call   80102da0 <log_write>
  brelse(bp);
8010118e:	89 34 24             	mov    %esi,(%esp)
80101191:	e8 4a f0 ff ff       	call   801001e0 <brelse>
}
80101196:	83 c4 10             	add    $0x10,%esp
80101199:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010119c:	5b                   	pop    %ebx
8010119d:	5e                   	pop    %esi
8010119e:	5d                   	pop    %ebp
8010119f:	c3                   	ret    
    panic("freeing free block");
801011a0:	83 ec 0c             	sub    $0xc,%esp
801011a3:	68 1f 76 10 80       	push   $0x8010761f
801011a8:	e8 e3 f1 ff ff       	call   80100390 <panic>
801011ad:	8d 76 00             	lea    0x0(%esi),%esi

801011b0 <balloc>:
{
801011b0:	55                   	push   %ebp
801011b1:	89 e5                	mov    %esp,%ebp
801011b3:	57                   	push   %edi
801011b4:	56                   	push   %esi
801011b5:	53                   	push   %ebx
801011b6:	83 ec 1c             	sub    $0x1c,%esp
  for(b = 0; b < sb.size; b += BPB){
801011b9:	8b 0d c0 09 11 80    	mov    0x801109c0,%ecx
{
801011bf:	89 45 d8             	mov    %eax,-0x28(%ebp)
  for(b = 0; b < sb.size; b += BPB){
801011c2:	85 c9                	test   %ecx,%ecx
801011c4:	0f 84 87 00 00 00    	je     80101251 <balloc+0xa1>
801011ca:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
801011d1:	8b 75 dc             	mov    -0x24(%ebp),%esi
801011d4:	83 ec 08             	sub    $0x8,%esp
801011d7:	89 f0                	mov    %esi,%eax
801011d9:	c1 f8 0c             	sar    $0xc,%eax
801011dc:	03 05 d8 09 11 80    	add    0x801109d8,%eax
801011e2:	50                   	push   %eax
801011e3:	ff 75 d8             	pushl  -0x28(%ebp)
801011e6:	e8 e5 ee ff ff       	call   801000d0 <bread>
801011eb:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801011ee:	a1 c0 09 11 80       	mov    0x801109c0,%eax
801011f3:	83 c4 10             	add    $0x10,%esp
801011f6:	89 45 e0             	mov    %eax,-0x20(%ebp)
801011f9:	31 c0                	xor    %eax,%eax
801011fb:	eb 2f                	jmp    8010122c <balloc+0x7c>
801011fd:	8d 76 00             	lea    0x0(%esi),%esi
      m = 1 << (bi % 8);
80101200:	89 c1                	mov    %eax,%ecx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80101202:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      m = 1 << (bi % 8);
80101205:	bb 01 00 00 00       	mov    $0x1,%ebx
8010120a:	83 e1 07             	and    $0x7,%ecx
8010120d:	d3 e3                	shl    %cl,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
8010120f:	89 c1                	mov    %eax,%ecx
80101211:	c1 f9 03             	sar    $0x3,%ecx
80101214:	0f b6 7c 0a 5c       	movzbl 0x5c(%edx,%ecx,1),%edi
80101219:	85 df                	test   %ebx,%edi
8010121b:	89 fa                	mov    %edi,%edx
8010121d:	74 41                	je     80101260 <balloc+0xb0>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
8010121f:	83 c0 01             	add    $0x1,%eax
80101222:	83 c6 01             	add    $0x1,%esi
80101225:	3d 00 10 00 00       	cmp    $0x1000,%eax
8010122a:	74 05                	je     80101231 <balloc+0x81>
8010122c:	39 75 e0             	cmp    %esi,-0x20(%ebp)
8010122f:	77 cf                	ja     80101200 <balloc+0x50>
    brelse(bp);
80101231:	83 ec 0c             	sub    $0xc,%esp
80101234:	ff 75 e4             	pushl  -0x1c(%ebp)
80101237:	e8 a4 ef ff ff       	call   801001e0 <brelse>
  for(b = 0; b < sb.size; b += BPB){
8010123c:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
80101243:	83 c4 10             	add    $0x10,%esp
80101246:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101249:	39 05 c0 09 11 80    	cmp    %eax,0x801109c0
8010124f:	77 80                	ja     801011d1 <balloc+0x21>
  panic("balloc: out of blocks");
80101251:	83 ec 0c             	sub    $0xc,%esp
80101254:	68 32 76 10 80       	push   $0x80107632
80101259:	e8 32 f1 ff ff       	call   80100390 <panic>
8010125e:	66 90                	xchg   %ax,%ax
        bp->data[bi/8] |= m;  // Mark block in use.
80101260:	8b 7d e4             	mov    -0x1c(%ebp),%edi
        log_write(bp);
80101263:	83 ec 0c             	sub    $0xc,%esp
        bp->data[bi/8] |= m;  // Mark block in use.
80101266:	09 da                	or     %ebx,%edx
80101268:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
        log_write(bp);
8010126c:	57                   	push   %edi
8010126d:	e8 2e 1b 00 00       	call   80102da0 <log_write>
        brelse(bp);
80101272:	89 3c 24             	mov    %edi,(%esp)
80101275:	e8 66 ef ff ff       	call   801001e0 <brelse>
  bp = bread(dev, bno);
8010127a:	58                   	pop    %eax
8010127b:	5a                   	pop    %edx
8010127c:	56                   	push   %esi
8010127d:	ff 75 d8             	pushl  -0x28(%ebp)
80101280:	e8 4b ee ff ff       	call   801000d0 <bread>
80101285:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
80101287:	8d 40 5c             	lea    0x5c(%eax),%eax
8010128a:	83 c4 0c             	add    $0xc,%esp
8010128d:	68 00 02 00 00       	push   $0x200
80101292:	6a 00                	push   $0x0
80101294:	50                   	push   %eax
80101295:	e8 16 37 00 00       	call   801049b0 <memset>
  log_write(bp);
8010129a:	89 1c 24             	mov    %ebx,(%esp)
8010129d:	e8 fe 1a 00 00       	call   80102da0 <log_write>
  brelse(bp);
801012a2:	89 1c 24             	mov    %ebx,(%esp)
801012a5:	e8 36 ef ff ff       	call   801001e0 <brelse>
}
801012aa:	8d 65 f4             	lea    -0xc(%ebp),%esp
801012ad:	89 f0                	mov    %esi,%eax
801012af:	5b                   	pop    %ebx
801012b0:	5e                   	pop    %esi
801012b1:	5f                   	pop    %edi
801012b2:	5d                   	pop    %ebp
801012b3:	c3                   	ret    
801012b4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801012ba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801012c0 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
801012c0:	55                   	push   %ebp
801012c1:	89 e5                	mov    %esp,%ebp
801012c3:	57                   	push   %edi
801012c4:	56                   	push   %esi
801012c5:	53                   	push   %ebx
801012c6:	89 c7                	mov    %eax,%edi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
801012c8:	31 f6                	xor    %esi,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801012ca:	bb 14 0a 11 80       	mov    $0x80110a14,%ebx
{
801012cf:	83 ec 28             	sub    $0x28,%esp
801012d2:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  acquire(&icache.lock);
801012d5:	68 e0 09 11 80       	push   $0x801109e0
801012da:	e8 c1 35 00 00       	call   801048a0 <acquire>
801012df:	83 c4 10             	add    $0x10,%esp
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801012e2:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801012e5:	eb 17                	jmp    801012fe <iget+0x3e>
801012e7:	89 f6                	mov    %esi,%esi
801012e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801012f0:	81 c3 90 00 00 00    	add    $0x90,%ebx
801012f6:	81 fb 34 26 11 80    	cmp    $0x80112634,%ebx
801012fc:	73 22                	jae    80101320 <iget+0x60>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801012fe:	8b 4b 08             	mov    0x8(%ebx),%ecx
80101301:	85 c9                	test   %ecx,%ecx
80101303:	7e 04                	jle    80101309 <iget+0x49>
80101305:	39 3b                	cmp    %edi,(%ebx)
80101307:	74 4f                	je     80101358 <iget+0x98>
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101309:	85 f6                	test   %esi,%esi
8010130b:	75 e3                	jne    801012f0 <iget+0x30>
8010130d:	85 c9                	test   %ecx,%ecx
8010130f:	0f 44 f3             	cmove  %ebx,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101312:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101318:	81 fb 34 26 11 80    	cmp    $0x80112634,%ebx
8010131e:	72 de                	jb     801012fe <iget+0x3e>
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
80101320:	85 f6                	test   %esi,%esi
80101322:	74 5b                	je     8010137f <iget+0xbf>
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);
80101324:	83 ec 0c             	sub    $0xc,%esp
  ip->dev = dev;
80101327:	89 3e                	mov    %edi,(%esi)
  ip->inum = inum;
80101329:	89 56 04             	mov    %edx,0x4(%esi)
  ip->ref = 1;
8010132c:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->valid = 0;
80101333:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  release(&icache.lock);
8010133a:	68 e0 09 11 80       	push   $0x801109e0
8010133f:	e8 1c 36 00 00       	call   80104960 <release>

  return ip;
80101344:	83 c4 10             	add    $0x10,%esp
}
80101347:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010134a:	89 f0                	mov    %esi,%eax
8010134c:	5b                   	pop    %ebx
8010134d:	5e                   	pop    %esi
8010134e:	5f                   	pop    %edi
8010134f:	5d                   	pop    %ebp
80101350:	c3                   	ret    
80101351:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101358:	39 53 04             	cmp    %edx,0x4(%ebx)
8010135b:	75 ac                	jne    80101309 <iget+0x49>
      release(&icache.lock);
8010135d:	83 ec 0c             	sub    $0xc,%esp
      ip->ref++;
80101360:	83 c1 01             	add    $0x1,%ecx
      return ip;
80101363:	89 de                	mov    %ebx,%esi
      release(&icache.lock);
80101365:	68 e0 09 11 80       	push   $0x801109e0
      ip->ref++;
8010136a:	89 4b 08             	mov    %ecx,0x8(%ebx)
      release(&icache.lock);
8010136d:	e8 ee 35 00 00       	call   80104960 <release>
      return ip;
80101372:	83 c4 10             	add    $0x10,%esp
}
80101375:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101378:	89 f0                	mov    %esi,%eax
8010137a:	5b                   	pop    %ebx
8010137b:	5e                   	pop    %esi
8010137c:	5f                   	pop    %edi
8010137d:	5d                   	pop    %ebp
8010137e:	c3                   	ret    
    panic("iget: no inodes");
8010137f:	83 ec 0c             	sub    $0xc,%esp
80101382:	68 48 76 10 80       	push   $0x80107648
80101387:	e8 04 f0 ff ff       	call   80100390 <panic>
8010138c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101390 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
80101390:	55                   	push   %ebp
80101391:	89 e5                	mov    %esp,%ebp
80101393:	57                   	push   %edi
80101394:	56                   	push   %esi
80101395:	53                   	push   %ebx
80101396:	89 c6                	mov    %eax,%esi
80101398:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
8010139b:	83 fa 0b             	cmp    $0xb,%edx
8010139e:	77 18                	ja     801013b8 <bmap+0x28>
801013a0:	8d 3c 90             	lea    (%eax,%edx,4),%edi
    if((addr = ip->addrs[bn]) == 0)
801013a3:	8b 5f 5c             	mov    0x5c(%edi),%ebx
801013a6:	85 db                	test   %ebx,%ebx
801013a8:	74 76                	je     80101420 <bmap+0x90>
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
801013aa:	8d 65 f4             	lea    -0xc(%ebp),%esp
801013ad:	89 d8                	mov    %ebx,%eax
801013af:	5b                   	pop    %ebx
801013b0:	5e                   	pop    %esi
801013b1:	5f                   	pop    %edi
801013b2:	5d                   	pop    %ebp
801013b3:	c3                   	ret    
801013b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  bn -= NDIRECT;
801013b8:	8d 5a f4             	lea    -0xc(%edx),%ebx
  if(bn < NINDIRECT){
801013bb:	83 fb 7f             	cmp    $0x7f,%ebx
801013be:	0f 87 90 00 00 00    	ja     80101454 <bmap+0xc4>
    if((addr = ip->addrs[NDIRECT]) == 0)
801013c4:	8b 90 8c 00 00 00    	mov    0x8c(%eax),%edx
801013ca:	8b 00                	mov    (%eax),%eax
801013cc:	85 d2                	test   %edx,%edx
801013ce:	74 70                	je     80101440 <bmap+0xb0>
    bp = bread(ip->dev, addr);
801013d0:	83 ec 08             	sub    $0x8,%esp
801013d3:	52                   	push   %edx
801013d4:	50                   	push   %eax
801013d5:	e8 f6 ec ff ff       	call   801000d0 <bread>
    if((addr = a[bn]) == 0){
801013da:	8d 54 98 5c          	lea    0x5c(%eax,%ebx,4),%edx
801013de:	83 c4 10             	add    $0x10,%esp
    bp = bread(ip->dev, addr);
801013e1:	89 c7                	mov    %eax,%edi
    if((addr = a[bn]) == 0){
801013e3:	8b 1a                	mov    (%edx),%ebx
801013e5:	85 db                	test   %ebx,%ebx
801013e7:	75 1d                	jne    80101406 <bmap+0x76>
      a[bn] = addr = balloc(ip->dev);
801013e9:	8b 06                	mov    (%esi),%eax
801013eb:	89 55 e4             	mov    %edx,-0x1c(%ebp)
801013ee:	e8 bd fd ff ff       	call   801011b0 <balloc>
801013f3:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      log_write(bp);
801013f6:	83 ec 0c             	sub    $0xc,%esp
      a[bn] = addr = balloc(ip->dev);
801013f9:	89 c3                	mov    %eax,%ebx
801013fb:	89 02                	mov    %eax,(%edx)
      log_write(bp);
801013fd:	57                   	push   %edi
801013fe:	e8 9d 19 00 00       	call   80102da0 <log_write>
80101403:	83 c4 10             	add    $0x10,%esp
    brelse(bp);
80101406:	83 ec 0c             	sub    $0xc,%esp
80101409:	57                   	push   %edi
8010140a:	e8 d1 ed ff ff       	call   801001e0 <brelse>
8010140f:	83 c4 10             	add    $0x10,%esp
}
80101412:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101415:	89 d8                	mov    %ebx,%eax
80101417:	5b                   	pop    %ebx
80101418:	5e                   	pop    %esi
80101419:	5f                   	pop    %edi
8010141a:	5d                   	pop    %ebp
8010141b:	c3                   	ret    
8010141c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      ip->addrs[bn] = addr = balloc(ip->dev);
80101420:	8b 00                	mov    (%eax),%eax
80101422:	e8 89 fd ff ff       	call   801011b0 <balloc>
80101427:	89 47 5c             	mov    %eax,0x5c(%edi)
}
8010142a:	8d 65 f4             	lea    -0xc(%ebp),%esp
      ip->addrs[bn] = addr = balloc(ip->dev);
8010142d:	89 c3                	mov    %eax,%ebx
}
8010142f:	89 d8                	mov    %ebx,%eax
80101431:	5b                   	pop    %ebx
80101432:	5e                   	pop    %esi
80101433:	5f                   	pop    %edi
80101434:	5d                   	pop    %ebp
80101435:	c3                   	ret    
80101436:	8d 76 00             	lea    0x0(%esi),%esi
80101439:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80101440:	e8 6b fd ff ff       	call   801011b0 <balloc>
80101445:	89 c2                	mov    %eax,%edx
80101447:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
8010144d:	8b 06                	mov    (%esi),%eax
8010144f:	e9 7c ff ff ff       	jmp    801013d0 <bmap+0x40>
  panic("bmap: out of range");
80101454:	83 ec 0c             	sub    $0xc,%esp
80101457:	68 58 76 10 80       	push   $0x80107658
8010145c:	e8 2f ef ff ff       	call   80100390 <panic>
80101461:	eb 0d                	jmp    80101470 <readsb>
80101463:	90                   	nop
80101464:	90                   	nop
80101465:	90                   	nop
80101466:	90                   	nop
80101467:	90                   	nop
80101468:	90                   	nop
80101469:	90                   	nop
8010146a:	90                   	nop
8010146b:	90                   	nop
8010146c:	90                   	nop
8010146d:	90                   	nop
8010146e:	90                   	nop
8010146f:	90                   	nop

80101470 <readsb>:
{
80101470:	55                   	push   %ebp
80101471:	89 e5                	mov    %esp,%ebp
80101473:	56                   	push   %esi
80101474:	53                   	push   %ebx
80101475:	8b 75 0c             	mov    0xc(%ebp),%esi
  bp = bread(dev, 1);
80101478:	83 ec 08             	sub    $0x8,%esp
8010147b:	6a 01                	push   $0x1
8010147d:	ff 75 08             	pushl  0x8(%ebp)
80101480:	e8 4b ec ff ff       	call   801000d0 <bread>
80101485:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
80101487:	8d 40 5c             	lea    0x5c(%eax),%eax
8010148a:	83 c4 0c             	add    $0xc,%esp
8010148d:	6a 1c                	push   $0x1c
8010148f:	50                   	push   %eax
80101490:	56                   	push   %esi
80101491:	e8 ca 35 00 00       	call   80104a60 <memmove>
  brelse(bp);
80101496:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101499:	83 c4 10             	add    $0x10,%esp
}
8010149c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010149f:	5b                   	pop    %ebx
801014a0:	5e                   	pop    %esi
801014a1:	5d                   	pop    %ebp
  brelse(bp);
801014a2:	e9 39 ed ff ff       	jmp    801001e0 <brelse>
801014a7:	89 f6                	mov    %esi,%esi
801014a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801014b0 <iinit>:
{
801014b0:	55                   	push   %ebp
801014b1:	89 e5                	mov    %esp,%ebp
801014b3:	53                   	push   %ebx
801014b4:	bb 20 0a 11 80       	mov    $0x80110a20,%ebx
801014b9:	83 ec 0c             	sub    $0xc,%esp
  initlock(&icache.lock, "icache");
801014bc:	68 6b 76 10 80       	push   $0x8010766b
801014c1:	68 e0 09 11 80       	push   $0x801109e0
801014c6:	e8 95 32 00 00       	call   80104760 <initlock>
801014cb:	83 c4 10             	add    $0x10,%esp
801014ce:	66 90                	xchg   %ax,%ax
    initsleeplock(&icache.inode[i].lock, "inode");
801014d0:	83 ec 08             	sub    $0x8,%esp
801014d3:	68 72 76 10 80       	push   $0x80107672
801014d8:	53                   	push   %ebx
801014d9:	81 c3 90 00 00 00    	add    $0x90,%ebx
801014df:	e8 4c 31 00 00       	call   80104630 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
801014e4:	83 c4 10             	add    $0x10,%esp
801014e7:	81 fb 40 26 11 80    	cmp    $0x80112640,%ebx
801014ed:	75 e1                	jne    801014d0 <iinit+0x20>
  readsb(dev, &sb);
801014ef:	83 ec 08             	sub    $0x8,%esp
801014f2:	68 c0 09 11 80       	push   $0x801109c0
801014f7:	ff 75 08             	pushl  0x8(%ebp)
801014fa:	e8 71 ff ff ff       	call   80101470 <readsb>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
801014ff:	ff 35 d8 09 11 80    	pushl  0x801109d8
80101505:	ff 35 d4 09 11 80    	pushl  0x801109d4
8010150b:	ff 35 d0 09 11 80    	pushl  0x801109d0
80101511:	ff 35 cc 09 11 80    	pushl  0x801109cc
80101517:	ff 35 c8 09 11 80    	pushl  0x801109c8
8010151d:	ff 35 c4 09 11 80    	pushl  0x801109c4
80101523:	ff 35 c0 09 11 80    	pushl  0x801109c0
80101529:	68 d8 76 10 80       	push   $0x801076d8
8010152e:	e8 2d f1 ff ff       	call   80100660 <cprintf>
}
80101533:	83 c4 30             	add    $0x30,%esp
80101536:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101539:	c9                   	leave  
8010153a:	c3                   	ret    
8010153b:	90                   	nop
8010153c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101540 <ialloc>:
{
80101540:	55                   	push   %ebp
80101541:	89 e5                	mov    %esp,%ebp
80101543:	57                   	push   %edi
80101544:	56                   	push   %esi
80101545:	53                   	push   %ebx
80101546:	83 ec 1c             	sub    $0x1c,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
80101549:	83 3d c8 09 11 80 01 	cmpl   $0x1,0x801109c8
{
80101550:	8b 45 0c             	mov    0xc(%ebp),%eax
80101553:	8b 75 08             	mov    0x8(%ebp),%esi
80101556:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(inum = 1; inum < sb.ninodes; inum++){
80101559:	0f 86 91 00 00 00    	jbe    801015f0 <ialloc+0xb0>
8010155f:	bb 01 00 00 00       	mov    $0x1,%ebx
80101564:	eb 21                	jmp    80101587 <ialloc+0x47>
80101566:	8d 76 00             	lea    0x0(%esi),%esi
80101569:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    brelse(bp);
80101570:	83 ec 0c             	sub    $0xc,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
80101573:	83 c3 01             	add    $0x1,%ebx
    brelse(bp);
80101576:	57                   	push   %edi
80101577:	e8 64 ec ff ff       	call   801001e0 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
8010157c:	83 c4 10             	add    $0x10,%esp
8010157f:	39 1d c8 09 11 80    	cmp    %ebx,0x801109c8
80101585:	76 69                	jbe    801015f0 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
80101587:	89 d8                	mov    %ebx,%eax
80101589:	83 ec 08             	sub    $0x8,%esp
8010158c:	c1 e8 03             	shr    $0x3,%eax
8010158f:	03 05 d4 09 11 80    	add    0x801109d4,%eax
80101595:	50                   	push   %eax
80101596:	56                   	push   %esi
80101597:	e8 34 eb ff ff       	call   801000d0 <bread>
8010159c:	89 c7                	mov    %eax,%edi
    dip = (struct dinode*)bp->data + inum%IPB;
8010159e:	89 d8                	mov    %ebx,%eax
    if(dip->type == 0){  // a free inode
801015a0:	83 c4 10             	add    $0x10,%esp
    dip = (struct dinode*)bp->data + inum%IPB;
801015a3:	83 e0 07             	and    $0x7,%eax
801015a6:	c1 e0 06             	shl    $0x6,%eax
801015a9:	8d 4c 07 5c          	lea    0x5c(%edi,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
801015ad:	66 83 39 00          	cmpw   $0x0,(%ecx)
801015b1:	75 bd                	jne    80101570 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
801015b3:	83 ec 04             	sub    $0x4,%esp
801015b6:	89 4d e0             	mov    %ecx,-0x20(%ebp)
801015b9:	6a 40                	push   $0x40
801015bb:	6a 00                	push   $0x0
801015bd:	51                   	push   %ecx
801015be:	e8 ed 33 00 00       	call   801049b0 <memset>
      dip->type = type;
801015c3:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
801015c7:	8b 4d e0             	mov    -0x20(%ebp),%ecx
801015ca:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
801015cd:	89 3c 24             	mov    %edi,(%esp)
801015d0:	e8 cb 17 00 00       	call   80102da0 <log_write>
      brelse(bp);
801015d5:	89 3c 24             	mov    %edi,(%esp)
801015d8:	e8 03 ec ff ff       	call   801001e0 <brelse>
      return iget(dev, inum);
801015dd:	83 c4 10             	add    $0x10,%esp
}
801015e0:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return iget(dev, inum);
801015e3:	89 da                	mov    %ebx,%edx
801015e5:	89 f0                	mov    %esi,%eax
}
801015e7:	5b                   	pop    %ebx
801015e8:	5e                   	pop    %esi
801015e9:	5f                   	pop    %edi
801015ea:	5d                   	pop    %ebp
      return iget(dev, inum);
801015eb:	e9 d0 fc ff ff       	jmp    801012c0 <iget>
  panic("ialloc: no inodes");
801015f0:	83 ec 0c             	sub    $0xc,%esp
801015f3:	68 78 76 10 80       	push   $0x80107678
801015f8:	e8 93 ed ff ff       	call   80100390 <panic>
801015fd:	8d 76 00             	lea    0x0(%esi),%esi

80101600 <iupdate>:
{
80101600:	55                   	push   %ebp
80101601:	89 e5                	mov    %esp,%ebp
80101603:	56                   	push   %esi
80101604:	53                   	push   %ebx
80101605:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101608:	83 ec 08             	sub    $0x8,%esp
8010160b:	8b 43 04             	mov    0x4(%ebx),%eax
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010160e:	83 c3 5c             	add    $0x5c,%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101611:	c1 e8 03             	shr    $0x3,%eax
80101614:	03 05 d4 09 11 80    	add    0x801109d4,%eax
8010161a:	50                   	push   %eax
8010161b:	ff 73 a4             	pushl  -0x5c(%ebx)
8010161e:	e8 ad ea ff ff       	call   801000d0 <bread>
80101623:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
80101625:	8b 43 a8             	mov    -0x58(%ebx),%eax
  dip->type = ip->type;
80101628:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010162c:	83 c4 0c             	add    $0xc,%esp
  dip = (struct dinode*)bp->data + ip->inum%IPB;
8010162f:	83 e0 07             	and    $0x7,%eax
80101632:	c1 e0 06             	shl    $0x6,%eax
80101635:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
80101639:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
8010163c:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101640:	83 c0 0c             	add    $0xc,%eax
  dip->major = ip->major;
80101643:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
80101647:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
8010164b:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
8010164f:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
80101653:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
80101657:	8b 53 fc             	mov    -0x4(%ebx),%edx
8010165a:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010165d:	6a 34                	push   $0x34
8010165f:	53                   	push   %ebx
80101660:	50                   	push   %eax
80101661:	e8 fa 33 00 00       	call   80104a60 <memmove>
  log_write(bp);
80101666:	89 34 24             	mov    %esi,(%esp)
80101669:	e8 32 17 00 00       	call   80102da0 <log_write>
  brelse(bp);
8010166e:	89 75 08             	mov    %esi,0x8(%ebp)
80101671:	83 c4 10             	add    $0x10,%esp
}
80101674:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101677:	5b                   	pop    %ebx
80101678:	5e                   	pop    %esi
80101679:	5d                   	pop    %ebp
  brelse(bp);
8010167a:	e9 61 eb ff ff       	jmp    801001e0 <brelse>
8010167f:	90                   	nop

80101680 <idup>:
{
80101680:	55                   	push   %ebp
80101681:	89 e5                	mov    %esp,%ebp
80101683:	53                   	push   %ebx
80101684:	83 ec 10             	sub    $0x10,%esp
80101687:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
8010168a:	68 e0 09 11 80       	push   $0x801109e0
8010168f:	e8 0c 32 00 00       	call   801048a0 <acquire>
  ip->ref++;
80101694:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101698:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
8010169f:	e8 bc 32 00 00       	call   80104960 <release>
}
801016a4:	89 d8                	mov    %ebx,%eax
801016a6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801016a9:	c9                   	leave  
801016aa:	c3                   	ret    
801016ab:	90                   	nop
801016ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801016b0 <ilock>:
{
801016b0:	55                   	push   %ebp
801016b1:	89 e5                	mov    %esp,%ebp
801016b3:	56                   	push   %esi
801016b4:	53                   	push   %ebx
801016b5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || ip->ref < 1)
801016b8:	85 db                	test   %ebx,%ebx
801016ba:	0f 84 b7 00 00 00    	je     80101777 <ilock+0xc7>
801016c0:	8b 53 08             	mov    0x8(%ebx),%edx
801016c3:	85 d2                	test   %edx,%edx
801016c5:	0f 8e ac 00 00 00    	jle    80101777 <ilock+0xc7>
  acquiresleep(&ip->lock);
801016cb:	8d 43 0c             	lea    0xc(%ebx),%eax
801016ce:	83 ec 0c             	sub    $0xc,%esp
801016d1:	50                   	push   %eax
801016d2:	e8 99 2f 00 00       	call   80104670 <acquiresleep>
  if(ip->valid == 0){
801016d7:	8b 43 4c             	mov    0x4c(%ebx),%eax
801016da:	83 c4 10             	add    $0x10,%esp
801016dd:	85 c0                	test   %eax,%eax
801016df:	74 0f                	je     801016f0 <ilock+0x40>
}
801016e1:	8d 65 f8             	lea    -0x8(%ebp),%esp
801016e4:	5b                   	pop    %ebx
801016e5:	5e                   	pop    %esi
801016e6:	5d                   	pop    %ebp
801016e7:	c3                   	ret    
801016e8:	90                   	nop
801016e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801016f0:	8b 43 04             	mov    0x4(%ebx),%eax
801016f3:	83 ec 08             	sub    $0x8,%esp
801016f6:	c1 e8 03             	shr    $0x3,%eax
801016f9:	03 05 d4 09 11 80    	add    0x801109d4,%eax
801016ff:	50                   	push   %eax
80101700:	ff 33                	pushl  (%ebx)
80101702:	e8 c9 e9 ff ff       	call   801000d0 <bread>
80101707:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
80101709:	8b 43 04             	mov    0x4(%ebx),%eax
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
8010170c:	83 c4 0c             	add    $0xc,%esp
    dip = (struct dinode*)bp->data + ip->inum%IPB;
8010170f:	83 e0 07             	and    $0x7,%eax
80101712:	c1 e0 06             	shl    $0x6,%eax
80101715:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
80101719:	0f b7 10             	movzwl (%eax),%edx
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
8010171c:	83 c0 0c             	add    $0xc,%eax
    ip->type = dip->type;
8010171f:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
80101723:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
80101727:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
8010172b:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
8010172f:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
80101733:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
80101737:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
8010173b:	8b 50 fc             	mov    -0x4(%eax),%edx
8010173e:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101741:	6a 34                	push   $0x34
80101743:	50                   	push   %eax
80101744:	8d 43 5c             	lea    0x5c(%ebx),%eax
80101747:	50                   	push   %eax
80101748:	e8 13 33 00 00       	call   80104a60 <memmove>
    brelse(bp);
8010174d:	89 34 24             	mov    %esi,(%esp)
80101750:	e8 8b ea ff ff       	call   801001e0 <brelse>
    if(ip->type == 0)
80101755:	83 c4 10             	add    $0x10,%esp
80101758:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
    ip->valid = 1;
8010175d:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
80101764:	0f 85 77 ff ff ff    	jne    801016e1 <ilock+0x31>
      panic("ilock: no type");
8010176a:	83 ec 0c             	sub    $0xc,%esp
8010176d:	68 90 76 10 80       	push   $0x80107690
80101772:	e8 19 ec ff ff       	call   80100390 <panic>
    panic("ilock");
80101777:	83 ec 0c             	sub    $0xc,%esp
8010177a:	68 8a 76 10 80       	push   $0x8010768a
8010177f:	e8 0c ec ff ff       	call   80100390 <panic>
80101784:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010178a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101790 <iunlock>:
{
80101790:	55                   	push   %ebp
80101791:	89 e5                	mov    %esp,%ebp
80101793:	56                   	push   %esi
80101794:	53                   	push   %ebx
80101795:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101798:	85 db                	test   %ebx,%ebx
8010179a:	74 28                	je     801017c4 <iunlock+0x34>
8010179c:	8d 73 0c             	lea    0xc(%ebx),%esi
8010179f:	83 ec 0c             	sub    $0xc,%esp
801017a2:	56                   	push   %esi
801017a3:	e8 68 2f 00 00       	call   80104710 <holdingsleep>
801017a8:	83 c4 10             	add    $0x10,%esp
801017ab:	85 c0                	test   %eax,%eax
801017ad:	74 15                	je     801017c4 <iunlock+0x34>
801017af:	8b 43 08             	mov    0x8(%ebx),%eax
801017b2:	85 c0                	test   %eax,%eax
801017b4:	7e 0e                	jle    801017c4 <iunlock+0x34>
  releasesleep(&ip->lock);
801017b6:	89 75 08             	mov    %esi,0x8(%ebp)
}
801017b9:	8d 65 f8             	lea    -0x8(%ebp),%esp
801017bc:	5b                   	pop    %ebx
801017bd:	5e                   	pop    %esi
801017be:	5d                   	pop    %ebp
  releasesleep(&ip->lock);
801017bf:	e9 0c 2f 00 00       	jmp    801046d0 <releasesleep>
    panic("iunlock");
801017c4:	83 ec 0c             	sub    $0xc,%esp
801017c7:	68 9f 76 10 80       	push   $0x8010769f
801017cc:	e8 bf eb ff ff       	call   80100390 <panic>
801017d1:	eb 0d                	jmp    801017e0 <iput>
801017d3:	90                   	nop
801017d4:	90                   	nop
801017d5:	90                   	nop
801017d6:	90                   	nop
801017d7:	90                   	nop
801017d8:	90                   	nop
801017d9:	90                   	nop
801017da:	90                   	nop
801017db:	90                   	nop
801017dc:	90                   	nop
801017dd:	90                   	nop
801017de:	90                   	nop
801017df:	90                   	nop

801017e0 <iput>:
{
801017e0:	55                   	push   %ebp
801017e1:	89 e5                	mov    %esp,%ebp
801017e3:	57                   	push   %edi
801017e4:	56                   	push   %esi
801017e5:	53                   	push   %ebx
801017e6:	83 ec 28             	sub    $0x28,%esp
801017e9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquiresleep(&ip->lock);
801017ec:	8d 7b 0c             	lea    0xc(%ebx),%edi
801017ef:	57                   	push   %edi
801017f0:	e8 7b 2e 00 00       	call   80104670 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
801017f5:	8b 53 4c             	mov    0x4c(%ebx),%edx
801017f8:	83 c4 10             	add    $0x10,%esp
801017fb:	85 d2                	test   %edx,%edx
801017fd:	74 07                	je     80101806 <iput+0x26>
801017ff:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80101804:	74 32                	je     80101838 <iput+0x58>
  releasesleep(&ip->lock);
80101806:	83 ec 0c             	sub    $0xc,%esp
80101809:	57                   	push   %edi
8010180a:	e8 c1 2e 00 00       	call   801046d0 <releasesleep>
  acquire(&icache.lock);
8010180f:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
80101816:	e8 85 30 00 00       	call   801048a0 <acquire>
  ip->ref--;
8010181b:	83 6b 08 01          	subl   $0x1,0x8(%ebx)
  release(&icache.lock);
8010181f:	83 c4 10             	add    $0x10,%esp
80101822:	c7 45 08 e0 09 11 80 	movl   $0x801109e0,0x8(%ebp)
}
80101829:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010182c:	5b                   	pop    %ebx
8010182d:	5e                   	pop    %esi
8010182e:	5f                   	pop    %edi
8010182f:	5d                   	pop    %ebp
  release(&icache.lock);
80101830:	e9 2b 31 00 00       	jmp    80104960 <release>
80101835:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&icache.lock);
80101838:	83 ec 0c             	sub    $0xc,%esp
8010183b:	68 e0 09 11 80       	push   $0x801109e0
80101840:	e8 5b 30 00 00       	call   801048a0 <acquire>
    int r = ip->ref;
80101845:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
80101848:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
8010184f:	e8 0c 31 00 00       	call   80104960 <release>
    if(r == 1){
80101854:	83 c4 10             	add    $0x10,%esp
80101857:	83 fe 01             	cmp    $0x1,%esi
8010185a:	75 aa                	jne    80101806 <iput+0x26>
8010185c:	8d 8b 8c 00 00 00    	lea    0x8c(%ebx),%ecx
80101862:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80101865:	8d 73 5c             	lea    0x5c(%ebx),%esi
80101868:	89 cf                	mov    %ecx,%edi
8010186a:	eb 0b                	jmp    80101877 <iput+0x97>
8010186c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101870:	83 c6 04             	add    $0x4,%esi
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101873:	39 fe                	cmp    %edi,%esi
80101875:	74 19                	je     80101890 <iput+0xb0>
    if(ip->addrs[i]){
80101877:	8b 16                	mov    (%esi),%edx
80101879:	85 d2                	test   %edx,%edx
8010187b:	74 f3                	je     80101870 <iput+0x90>
      bfree(ip->dev, ip->addrs[i]);
8010187d:	8b 03                	mov    (%ebx),%eax
8010187f:	e8 bc f8 ff ff       	call   80101140 <bfree>
      ip->addrs[i] = 0;
80101884:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
8010188a:	eb e4                	jmp    80101870 <iput+0x90>
8010188c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  if(ip->addrs[NDIRECT]){
80101890:	8b 83 8c 00 00 00    	mov    0x8c(%ebx),%eax
80101896:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101899:	85 c0                	test   %eax,%eax
8010189b:	75 33                	jne    801018d0 <iput+0xf0>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  iupdate(ip);
8010189d:	83 ec 0c             	sub    $0xc,%esp
  ip->size = 0;
801018a0:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  iupdate(ip);
801018a7:	53                   	push   %ebx
801018a8:	e8 53 fd ff ff       	call   80101600 <iupdate>
      ip->type = 0;
801018ad:	31 c0                	xor    %eax,%eax
801018af:	66 89 43 50          	mov    %ax,0x50(%ebx)
      iupdate(ip);
801018b3:	89 1c 24             	mov    %ebx,(%esp)
801018b6:	e8 45 fd ff ff       	call   80101600 <iupdate>
      ip->valid = 0;
801018bb:	c7 43 4c 00 00 00 00 	movl   $0x0,0x4c(%ebx)
801018c2:	83 c4 10             	add    $0x10,%esp
801018c5:	e9 3c ff ff ff       	jmp    80101806 <iput+0x26>
801018ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
801018d0:	83 ec 08             	sub    $0x8,%esp
801018d3:	50                   	push   %eax
801018d4:	ff 33                	pushl  (%ebx)
801018d6:	e8 f5 e7 ff ff       	call   801000d0 <bread>
801018db:	8d 88 5c 02 00 00    	lea    0x25c(%eax),%ecx
801018e1:	89 7d e0             	mov    %edi,-0x20(%ebp)
801018e4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    a = (uint*)bp->data;
801018e7:	8d 70 5c             	lea    0x5c(%eax),%esi
801018ea:	83 c4 10             	add    $0x10,%esp
801018ed:	89 cf                	mov    %ecx,%edi
801018ef:	eb 0e                	jmp    801018ff <iput+0x11f>
801018f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801018f8:	83 c6 04             	add    $0x4,%esi
    for(j = 0; j < NINDIRECT; j++){
801018fb:	39 fe                	cmp    %edi,%esi
801018fd:	74 0f                	je     8010190e <iput+0x12e>
      if(a[j])
801018ff:	8b 16                	mov    (%esi),%edx
80101901:	85 d2                	test   %edx,%edx
80101903:	74 f3                	je     801018f8 <iput+0x118>
        bfree(ip->dev, a[j]);
80101905:	8b 03                	mov    (%ebx),%eax
80101907:	e8 34 f8 ff ff       	call   80101140 <bfree>
8010190c:	eb ea                	jmp    801018f8 <iput+0x118>
    brelse(bp);
8010190e:	83 ec 0c             	sub    $0xc,%esp
80101911:	ff 75 e4             	pushl  -0x1c(%ebp)
80101914:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101917:	e8 c4 e8 ff ff       	call   801001e0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
8010191c:	8b 93 8c 00 00 00    	mov    0x8c(%ebx),%edx
80101922:	8b 03                	mov    (%ebx),%eax
80101924:	e8 17 f8 ff ff       	call   80101140 <bfree>
    ip->addrs[NDIRECT] = 0;
80101929:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
80101930:	00 00 00 
80101933:	83 c4 10             	add    $0x10,%esp
80101936:	e9 62 ff ff ff       	jmp    8010189d <iput+0xbd>
8010193b:	90                   	nop
8010193c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101940 <iunlockput>:
{
80101940:	55                   	push   %ebp
80101941:	89 e5                	mov    %esp,%ebp
80101943:	53                   	push   %ebx
80101944:	83 ec 10             	sub    $0x10,%esp
80101947:	8b 5d 08             	mov    0x8(%ebp),%ebx
  iunlock(ip);
8010194a:	53                   	push   %ebx
8010194b:	e8 40 fe ff ff       	call   80101790 <iunlock>
  iput(ip);
80101950:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101953:	83 c4 10             	add    $0x10,%esp
}
80101956:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101959:	c9                   	leave  
  iput(ip);
8010195a:	e9 81 fe ff ff       	jmp    801017e0 <iput>
8010195f:	90                   	nop

80101960 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
80101960:	55                   	push   %ebp
80101961:	89 e5                	mov    %esp,%ebp
80101963:	8b 55 08             	mov    0x8(%ebp),%edx
80101966:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
80101969:	8b 0a                	mov    (%edx),%ecx
8010196b:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
8010196e:	8b 4a 04             	mov    0x4(%edx),%ecx
80101971:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
80101974:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
80101978:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
8010197b:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
8010197f:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
80101983:	8b 52 58             	mov    0x58(%edx),%edx
80101986:	89 50 10             	mov    %edx,0x10(%eax)
}
80101989:	5d                   	pop    %ebp
8010198a:	c3                   	ret    
8010198b:	90                   	nop
8010198c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101990 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101990:	55                   	push   %ebp
80101991:	89 e5                	mov    %esp,%ebp
80101993:	57                   	push   %edi
80101994:	56                   	push   %esi
80101995:	53                   	push   %ebx
80101996:	83 ec 1c             	sub    $0x1c,%esp
80101999:	8b 45 08             	mov    0x8(%ebp),%eax
8010199c:	8b 75 0c             	mov    0xc(%ebp),%esi
8010199f:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
801019a2:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
801019a7:	89 75 e0             	mov    %esi,-0x20(%ebp)
801019aa:	89 45 d8             	mov    %eax,-0x28(%ebp)
801019ad:	8b 75 10             	mov    0x10(%ebp),%esi
801019b0:	89 7d e4             	mov    %edi,-0x1c(%ebp)
  if(ip->type == T_DEV){
801019b3:	0f 84 a7 00 00 00    	je     80101a60 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
801019b9:	8b 45 d8             	mov    -0x28(%ebp),%eax
801019bc:	8b 40 58             	mov    0x58(%eax),%eax
801019bf:	39 c6                	cmp    %eax,%esi
801019c1:	0f 87 ba 00 00 00    	ja     80101a81 <readi+0xf1>
801019c7:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801019ca:	89 f9                	mov    %edi,%ecx
801019cc:	01 f1                	add    %esi,%ecx
801019ce:	0f 82 ad 00 00 00    	jb     80101a81 <readi+0xf1>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
801019d4:	89 c2                	mov    %eax,%edx
801019d6:	29 f2                	sub    %esi,%edx
801019d8:	39 c8                	cmp    %ecx,%eax
801019da:	0f 43 d7             	cmovae %edi,%edx

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
801019dd:	31 ff                	xor    %edi,%edi
801019df:	85 d2                	test   %edx,%edx
    n = ip->size - off;
801019e1:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
801019e4:	74 6c                	je     80101a52 <readi+0xc2>
801019e6:	8d 76 00             	lea    0x0(%esi),%esi
801019e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
801019f0:	8b 5d d8             	mov    -0x28(%ebp),%ebx
801019f3:	89 f2                	mov    %esi,%edx
801019f5:	c1 ea 09             	shr    $0x9,%edx
801019f8:	89 d8                	mov    %ebx,%eax
801019fa:	e8 91 f9 ff ff       	call   80101390 <bmap>
801019ff:	83 ec 08             	sub    $0x8,%esp
80101a02:	50                   	push   %eax
80101a03:	ff 33                	pushl  (%ebx)
80101a05:	e8 c6 e6 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101a0a:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101a0d:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101a0f:	89 f0                	mov    %esi,%eax
80101a11:	25 ff 01 00 00       	and    $0x1ff,%eax
80101a16:	b9 00 02 00 00       	mov    $0x200,%ecx
80101a1b:	83 c4 0c             	add    $0xc,%esp
80101a1e:	29 c1                	sub    %eax,%ecx
    memmove(dst, bp->data + off%BSIZE, m);
80101a20:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
80101a24:	89 55 dc             	mov    %edx,-0x24(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
80101a27:	29 fb                	sub    %edi,%ebx
80101a29:	39 d9                	cmp    %ebx,%ecx
80101a2b:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101a2e:	53                   	push   %ebx
80101a2f:	50                   	push   %eax
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101a30:	01 df                	add    %ebx,%edi
    memmove(dst, bp->data + off%BSIZE, m);
80101a32:	ff 75 e0             	pushl  -0x20(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101a35:	01 de                	add    %ebx,%esi
    memmove(dst, bp->data + off%BSIZE, m);
80101a37:	e8 24 30 00 00       	call   80104a60 <memmove>
    brelse(bp);
80101a3c:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101a3f:	89 14 24             	mov    %edx,(%esp)
80101a42:	e8 99 e7 ff ff       	call   801001e0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101a47:	01 5d e0             	add    %ebx,-0x20(%ebp)
80101a4a:	83 c4 10             	add    $0x10,%esp
80101a4d:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101a50:	77 9e                	ja     801019f0 <readi+0x60>
  }
  return n;
80101a52:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
80101a55:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101a58:	5b                   	pop    %ebx
80101a59:	5e                   	pop    %esi
80101a5a:	5f                   	pop    %edi
80101a5b:	5d                   	pop    %ebp
80101a5c:	c3                   	ret    
80101a5d:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101a60:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101a64:	66 83 f8 09          	cmp    $0x9,%ax
80101a68:	77 17                	ja     80101a81 <readi+0xf1>
80101a6a:	8b 04 c5 60 09 11 80 	mov    -0x7feef6a0(,%eax,8),%eax
80101a71:	85 c0                	test   %eax,%eax
80101a73:	74 0c                	je     80101a81 <readi+0xf1>
    return devsw[ip->major].read(ip, dst, n);
80101a75:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80101a78:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101a7b:	5b                   	pop    %ebx
80101a7c:	5e                   	pop    %esi
80101a7d:	5f                   	pop    %edi
80101a7e:	5d                   	pop    %ebp
    return devsw[ip->major].read(ip, dst, n);
80101a7f:	ff e0                	jmp    *%eax
      return -1;
80101a81:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101a86:	eb cd                	jmp    80101a55 <readi+0xc5>
80101a88:	90                   	nop
80101a89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101a90 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101a90:	55                   	push   %ebp
80101a91:	89 e5                	mov    %esp,%ebp
80101a93:	57                   	push   %edi
80101a94:	56                   	push   %esi
80101a95:	53                   	push   %ebx
80101a96:	83 ec 1c             	sub    $0x1c,%esp
80101a99:	8b 45 08             	mov    0x8(%ebp),%eax
80101a9c:	8b 75 0c             	mov    0xc(%ebp),%esi
80101a9f:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101aa2:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101aa7:	89 75 dc             	mov    %esi,-0x24(%ebp)
80101aaa:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101aad:	8b 75 10             	mov    0x10(%ebp),%esi
80101ab0:	89 7d e0             	mov    %edi,-0x20(%ebp)
  if(ip->type == T_DEV){
80101ab3:	0f 84 b7 00 00 00    	je     80101b70 <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80101ab9:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101abc:	39 70 58             	cmp    %esi,0x58(%eax)
80101abf:	0f 82 eb 00 00 00    	jb     80101bb0 <writei+0x120>
80101ac5:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101ac8:	31 d2                	xor    %edx,%edx
80101aca:	89 f8                	mov    %edi,%eax
80101acc:	01 f0                	add    %esi,%eax
80101ace:	0f 92 c2             	setb   %dl
    return -1;
  if(off + n > MAXFILE*BSIZE)
80101ad1:	3d 00 18 01 00       	cmp    $0x11800,%eax
80101ad6:	0f 87 d4 00 00 00    	ja     80101bb0 <writei+0x120>
80101adc:	85 d2                	test   %edx,%edx
80101ade:	0f 85 cc 00 00 00    	jne    80101bb0 <writei+0x120>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101ae4:	85 ff                	test   %edi,%edi
80101ae6:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80101aed:	74 72                	je     80101b61 <writei+0xd1>
80101aef:	90                   	nop
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101af0:	8b 7d d8             	mov    -0x28(%ebp),%edi
80101af3:	89 f2                	mov    %esi,%edx
80101af5:	c1 ea 09             	shr    $0x9,%edx
80101af8:	89 f8                	mov    %edi,%eax
80101afa:	e8 91 f8 ff ff       	call   80101390 <bmap>
80101aff:	83 ec 08             	sub    $0x8,%esp
80101b02:	50                   	push   %eax
80101b03:	ff 37                	pushl  (%edi)
80101b05:	e8 c6 e5 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101b0a:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80101b0d:	2b 5d e4             	sub    -0x1c(%ebp),%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101b10:	89 c7                	mov    %eax,%edi
    m = min(n - tot, BSIZE - off%BSIZE);
80101b12:	89 f0                	mov    %esi,%eax
80101b14:	b9 00 02 00 00       	mov    $0x200,%ecx
80101b19:	83 c4 0c             	add    $0xc,%esp
80101b1c:	25 ff 01 00 00       	and    $0x1ff,%eax
80101b21:	29 c1                	sub    %eax,%ecx
    memmove(bp->data + off%BSIZE, src, m);
80101b23:	8d 44 07 5c          	lea    0x5c(%edi,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101b27:	39 d9                	cmp    %ebx,%ecx
80101b29:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80101b2c:	53                   	push   %ebx
80101b2d:	ff 75 dc             	pushl  -0x24(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101b30:	01 de                	add    %ebx,%esi
    memmove(bp->data + off%BSIZE, src, m);
80101b32:	50                   	push   %eax
80101b33:	e8 28 2f 00 00       	call   80104a60 <memmove>
    log_write(bp);
80101b38:	89 3c 24             	mov    %edi,(%esp)
80101b3b:	e8 60 12 00 00       	call   80102da0 <log_write>
    brelse(bp);
80101b40:	89 3c 24             	mov    %edi,(%esp)
80101b43:	e8 98 e6 ff ff       	call   801001e0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101b48:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101b4b:	01 5d dc             	add    %ebx,-0x24(%ebp)
80101b4e:	83 c4 10             	add    $0x10,%esp
80101b51:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101b54:	39 45 e0             	cmp    %eax,-0x20(%ebp)
80101b57:	77 97                	ja     80101af0 <writei+0x60>
  }

  if(n > 0 && off > ip->size){
80101b59:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101b5c:	3b 70 58             	cmp    0x58(%eax),%esi
80101b5f:	77 37                	ja     80101b98 <writei+0x108>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80101b61:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80101b64:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b67:	5b                   	pop    %ebx
80101b68:	5e                   	pop    %esi
80101b69:	5f                   	pop    %edi
80101b6a:	5d                   	pop    %ebp
80101b6b:	c3                   	ret    
80101b6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101b70:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101b74:	66 83 f8 09          	cmp    $0x9,%ax
80101b78:	77 36                	ja     80101bb0 <writei+0x120>
80101b7a:	8b 04 c5 64 09 11 80 	mov    -0x7feef69c(,%eax,8),%eax
80101b81:	85 c0                	test   %eax,%eax
80101b83:	74 2b                	je     80101bb0 <writei+0x120>
    return devsw[ip->major].write(ip, src, n);
80101b85:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80101b88:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b8b:	5b                   	pop    %ebx
80101b8c:	5e                   	pop    %esi
80101b8d:	5f                   	pop    %edi
80101b8e:	5d                   	pop    %ebp
    return devsw[ip->major].write(ip, src, n);
80101b8f:	ff e0                	jmp    *%eax
80101b91:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    ip->size = off;
80101b98:	8b 45 d8             	mov    -0x28(%ebp),%eax
    iupdate(ip);
80101b9b:	83 ec 0c             	sub    $0xc,%esp
    ip->size = off;
80101b9e:	89 70 58             	mov    %esi,0x58(%eax)
    iupdate(ip);
80101ba1:	50                   	push   %eax
80101ba2:	e8 59 fa ff ff       	call   80101600 <iupdate>
80101ba7:	83 c4 10             	add    $0x10,%esp
80101baa:	eb b5                	jmp    80101b61 <writei+0xd1>
80101bac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      return -1;
80101bb0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101bb5:	eb ad                	jmp    80101b64 <writei+0xd4>
80101bb7:	89 f6                	mov    %esi,%esi
80101bb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101bc0 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80101bc0:	55                   	push   %ebp
80101bc1:	89 e5                	mov    %esp,%ebp
80101bc3:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
80101bc6:	6a 0e                	push   $0xe
80101bc8:	ff 75 0c             	pushl  0xc(%ebp)
80101bcb:	ff 75 08             	pushl  0x8(%ebp)
80101bce:	e8 fd 2e 00 00       	call   80104ad0 <strncmp>
}
80101bd3:	c9                   	leave  
80101bd4:	c3                   	ret    
80101bd5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101bd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101be0 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80101be0:	55                   	push   %ebp
80101be1:	89 e5                	mov    %esp,%ebp
80101be3:	57                   	push   %edi
80101be4:	56                   	push   %esi
80101be5:	53                   	push   %ebx
80101be6:	83 ec 1c             	sub    $0x1c,%esp
80101be9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80101bec:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80101bf1:	0f 85 85 00 00 00    	jne    80101c7c <dirlookup+0x9c>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80101bf7:	8b 53 58             	mov    0x58(%ebx),%edx
80101bfa:	31 ff                	xor    %edi,%edi
80101bfc:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101bff:	85 d2                	test   %edx,%edx
80101c01:	74 3e                	je     80101c41 <dirlookup+0x61>
80101c03:	90                   	nop
80101c04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101c08:	6a 10                	push   $0x10
80101c0a:	57                   	push   %edi
80101c0b:	56                   	push   %esi
80101c0c:	53                   	push   %ebx
80101c0d:	e8 7e fd ff ff       	call   80101990 <readi>
80101c12:	83 c4 10             	add    $0x10,%esp
80101c15:	83 f8 10             	cmp    $0x10,%eax
80101c18:	75 55                	jne    80101c6f <dirlookup+0x8f>
      panic("dirlookup read");
    if(de.inum == 0)
80101c1a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101c1f:	74 18                	je     80101c39 <dirlookup+0x59>
  return strncmp(s, t, DIRSIZ);
80101c21:	8d 45 da             	lea    -0x26(%ebp),%eax
80101c24:	83 ec 04             	sub    $0x4,%esp
80101c27:	6a 0e                	push   $0xe
80101c29:	50                   	push   %eax
80101c2a:	ff 75 0c             	pushl  0xc(%ebp)
80101c2d:	e8 9e 2e 00 00       	call   80104ad0 <strncmp>
      continue;
    if(namecmp(name, de.name) == 0){
80101c32:	83 c4 10             	add    $0x10,%esp
80101c35:	85 c0                	test   %eax,%eax
80101c37:	74 17                	je     80101c50 <dirlookup+0x70>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101c39:	83 c7 10             	add    $0x10,%edi
80101c3c:	3b 7b 58             	cmp    0x58(%ebx),%edi
80101c3f:	72 c7                	jb     80101c08 <dirlookup+0x28>
      return iget(dp->dev, inum);
    }
  }

  return 0;
}
80101c41:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80101c44:	31 c0                	xor    %eax,%eax
}
80101c46:	5b                   	pop    %ebx
80101c47:	5e                   	pop    %esi
80101c48:	5f                   	pop    %edi
80101c49:	5d                   	pop    %ebp
80101c4a:	c3                   	ret    
80101c4b:	90                   	nop
80101c4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(poff)
80101c50:	8b 45 10             	mov    0x10(%ebp),%eax
80101c53:	85 c0                	test   %eax,%eax
80101c55:	74 05                	je     80101c5c <dirlookup+0x7c>
        *poff = off;
80101c57:	8b 45 10             	mov    0x10(%ebp),%eax
80101c5a:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
80101c5c:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
80101c60:	8b 03                	mov    (%ebx),%eax
80101c62:	e8 59 f6 ff ff       	call   801012c0 <iget>
}
80101c67:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101c6a:	5b                   	pop    %ebx
80101c6b:	5e                   	pop    %esi
80101c6c:	5f                   	pop    %edi
80101c6d:	5d                   	pop    %ebp
80101c6e:	c3                   	ret    
      panic("dirlookup read");
80101c6f:	83 ec 0c             	sub    $0xc,%esp
80101c72:	68 b9 76 10 80       	push   $0x801076b9
80101c77:	e8 14 e7 ff ff       	call   80100390 <panic>
    panic("dirlookup not DIR");
80101c7c:	83 ec 0c             	sub    $0xc,%esp
80101c7f:	68 a7 76 10 80       	push   $0x801076a7
80101c84:	e8 07 e7 ff ff       	call   80100390 <panic>
80101c89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101c90 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101c90:	55                   	push   %ebp
80101c91:	89 e5                	mov    %esp,%ebp
80101c93:	57                   	push   %edi
80101c94:	56                   	push   %esi
80101c95:	53                   	push   %ebx
80101c96:	89 cf                	mov    %ecx,%edi
80101c98:	89 c3                	mov    %eax,%ebx
80101c9a:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *next;

  if(*path == '/')
80101c9d:	80 38 2f             	cmpb   $0x2f,(%eax)
{
80101ca0:	89 55 e0             	mov    %edx,-0x20(%ebp)
  if(*path == '/')
80101ca3:	0f 84 67 01 00 00    	je     80101e10 <namex+0x180>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80101ca9:	e8 62 1c 00 00       	call   80103910 <myproc>
  acquire(&icache.lock);
80101cae:	83 ec 0c             	sub    $0xc,%esp
    ip = idup(myproc()->cwd);
80101cb1:	8b 70 68             	mov    0x68(%eax),%esi
  acquire(&icache.lock);
80101cb4:	68 e0 09 11 80       	push   $0x801109e0
80101cb9:	e8 e2 2b 00 00       	call   801048a0 <acquire>
  ip->ref++;
80101cbe:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80101cc2:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
80101cc9:	e8 92 2c 00 00       	call   80104960 <release>
80101cce:	83 c4 10             	add    $0x10,%esp
80101cd1:	eb 08                	jmp    80101cdb <namex+0x4b>
80101cd3:	90                   	nop
80101cd4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
80101cd8:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80101cdb:	0f b6 03             	movzbl (%ebx),%eax
80101cde:	3c 2f                	cmp    $0x2f,%al
80101ce0:	74 f6                	je     80101cd8 <namex+0x48>
  if(*path == 0)
80101ce2:	84 c0                	test   %al,%al
80101ce4:	0f 84 ee 00 00 00    	je     80101dd8 <namex+0x148>
  while(*path != '/' && *path != 0)
80101cea:	0f b6 03             	movzbl (%ebx),%eax
80101ced:	3c 2f                	cmp    $0x2f,%al
80101cef:	0f 84 b3 00 00 00    	je     80101da8 <namex+0x118>
80101cf5:	84 c0                	test   %al,%al
80101cf7:	89 da                	mov    %ebx,%edx
80101cf9:	75 09                	jne    80101d04 <namex+0x74>
80101cfb:	e9 a8 00 00 00       	jmp    80101da8 <namex+0x118>
80101d00:	84 c0                	test   %al,%al
80101d02:	74 0a                	je     80101d0e <namex+0x7e>
    path++;
80101d04:	83 c2 01             	add    $0x1,%edx
  while(*path != '/' && *path != 0)
80101d07:	0f b6 02             	movzbl (%edx),%eax
80101d0a:	3c 2f                	cmp    $0x2f,%al
80101d0c:	75 f2                	jne    80101d00 <namex+0x70>
80101d0e:	89 d1                	mov    %edx,%ecx
80101d10:	29 d9                	sub    %ebx,%ecx
  if(len >= DIRSIZ)
80101d12:	83 f9 0d             	cmp    $0xd,%ecx
80101d15:	0f 8e 91 00 00 00    	jle    80101dac <namex+0x11c>
    memmove(name, s, DIRSIZ);
80101d1b:	83 ec 04             	sub    $0x4,%esp
80101d1e:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101d21:	6a 0e                	push   $0xe
80101d23:	53                   	push   %ebx
80101d24:	57                   	push   %edi
80101d25:	e8 36 2d 00 00       	call   80104a60 <memmove>
    path++;
80101d2a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    memmove(name, s, DIRSIZ);
80101d2d:	83 c4 10             	add    $0x10,%esp
    path++;
80101d30:	89 d3                	mov    %edx,%ebx
  while(*path == '/')
80101d32:	80 3a 2f             	cmpb   $0x2f,(%edx)
80101d35:	75 11                	jne    80101d48 <namex+0xb8>
80101d37:	89 f6                	mov    %esi,%esi
80101d39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    path++;
80101d40:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80101d43:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80101d46:	74 f8                	je     80101d40 <namex+0xb0>

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80101d48:	83 ec 0c             	sub    $0xc,%esp
80101d4b:	56                   	push   %esi
80101d4c:	e8 5f f9 ff ff       	call   801016b0 <ilock>
    if(ip->type != T_DIR){
80101d51:	83 c4 10             	add    $0x10,%esp
80101d54:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80101d59:	0f 85 91 00 00 00    	jne    80101df0 <namex+0x160>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80101d5f:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101d62:	85 d2                	test   %edx,%edx
80101d64:	74 09                	je     80101d6f <namex+0xdf>
80101d66:	80 3b 00             	cmpb   $0x0,(%ebx)
80101d69:	0f 84 b7 00 00 00    	je     80101e26 <namex+0x196>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80101d6f:	83 ec 04             	sub    $0x4,%esp
80101d72:	6a 00                	push   $0x0
80101d74:	57                   	push   %edi
80101d75:	56                   	push   %esi
80101d76:	e8 65 fe ff ff       	call   80101be0 <dirlookup>
80101d7b:	83 c4 10             	add    $0x10,%esp
80101d7e:	85 c0                	test   %eax,%eax
80101d80:	74 6e                	je     80101df0 <namex+0x160>
  iunlock(ip);
80101d82:	83 ec 0c             	sub    $0xc,%esp
80101d85:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101d88:	56                   	push   %esi
80101d89:	e8 02 fa ff ff       	call   80101790 <iunlock>
  iput(ip);
80101d8e:	89 34 24             	mov    %esi,(%esp)
80101d91:	e8 4a fa ff ff       	call   801017e0 <iput>
80101d96:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101d99:	83 c4 10             	add    $0x10,%esp
80101d9c:	89 c6                	mov    %eax,%esi
80101d9e:	e9 38 ff ff ff       	jmp    80101cdb <namex+0x4b>
80101da3:	90                   	nop
80101da4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while(*path != '/' && *path != 0)
80101da8:	89 da                	mov    %ebx,%edx
80101daa:	31 c9                	xor    %ecx,%ecx
    memmove(name, s, len);
80101dac:	83 ec 04             	sub    $0x4,%esp
80101daf:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101db2:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80101db5:	51                   	push   %ecx
80101db6:	53                   	push   %ebx
80101db7:	57                   	push   %edi
80101db8:	e8 a3 2c 00 00       	call   80104a60 <memmove>
    name[len] = 0;
80101dbd:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80101dc0:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101dc3:	83 c4 10             	add    $0x10,%esp
80101dc6:	c6 04 0f 00          	movb   $0x0,(%edi,%ecx,1)
80101dca:	89 d3                	mov    %edx,%ebx
80101dcc:	e9 61 ff ff ff       	jmp    80101d32 <namex+0xa2>
80101dd1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
80101dd8:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101ddb:	85 c0                	test   %eax,%eax
80101ddd:	75 5d                	jne    80101e3c <namex+0x1ac>
    iput(ip);
    return 0;
  }
  return ip;
}
80101ddf:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101de2:	89 f0                	mov    %esi,%eax
80101de4:	5b                   	pop    %ebx
80101de5:	5e                   	pop    %esi
80101de6:	5f                   	pop    %edi
80101de7:	5d                   	pop    %ebp
80101de8:	c3                   	ret    
80101de9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  iunlock(ip);
80101df0:	83 ec 0c             	sub    $0xc,%esp
80101df3:	56                   	push   %esi
80101df4:	e8 97 f9 ff ff       	call   80101790 <iunlock>
  iput(ip);
80101df9:	89 34 24             	mov    %esi,(%esp)
      return 0;
80101dfc:	31 f6                	xor    %esi,%esi
  iput(ip);
80101dfe:	e8 dd f9 ff ff       	call   801017e0 <iput>
      return 0;
80101e03:	83 c4 10             	add    $0x10,%esp
}
80101e06:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101e09:	89 f0                	mov    %esi,%eax
80101e0b:	5b                   	pop    %ebx
80101e0c:	5e                   	pop    %esi
80101e0d:	5f                   	pop    %edi
80101e0e:	5d                   	pop    %ebp
80101e0f:	c3                   	ret    
    ip = iget(ROOTDEV, ROOTINO);
80101e10:	ba 01 00 00 00       	mov    $0x1,%edx
80101e15:	b8 01 00 00 00       	mov    $0x1,%eax
80101e1a:	e8 a1 f4 ff ff       	call   801012c0 <iget>
80101e1f:	89 c6                	mov    %eax,%esi
80101e21:	e9 b5 fe ff ff       	jmp    80101cdb <namex+0x4b>
      iunlock(ip);
80101e26:	83 ec 0c             	sub    $0xc,%esp
80101e29:	56                   	push   %esi
80101e2a:	e8 61 f9 ff ff       	call   80101790 <iunlock>
      return ip;
80101e2f:	83 c4 10             	add    $0x10,%esp
}
80101e32:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101e35:	89 f0                	mov    %esi,%eax
80101e37:	5b                   	pop    %ebx
80101e38:	5e                   	pop    %esi
80101e39:	5f                   	pop    %edi
80101e3a:	5d                   	pop    %ebp
80101e3b:	c3                   	ret    
    iput(ip);
80101e3c:	83 ec 0c             	sub    $0xc,%esp
80101e3f:	56                   	push   %esi
    return 0;
80101e40:	31 f6                	xor    %esi,%esi
    iput(ip);
80101e42:	e8 99 f9 ff ff       	call   801017e0 <iput>
    return 0;
80101e47:	83 c4 10             	add    $0x10,%esp
80101e4a:	eb 93                	jmp    80101ddf <namex+0x14f>
80101e4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101e50 <dirlink>:
{
80101e50:	55                   	push   %ebp
80101e51:	89 e5                	mov    %esp,%ebp
80101e53:	57                   	push   %edi
80101e54:	56                   	push   %esi
80101e55:	53                   	push   %ebx
80101e56:	83 ec 20             	sub    $0x20,%esp
80101e59:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((ip = dirlookup(dp, name, 0)) != 0){
80101e5c:	6a 00                	push   $0x0
80101e5e:	ff 75 0c             	pushl  0xc(%ebp)
80101e61:	53                   	push   %ebx
80101e62:	e8 79 fd ff ff       	call   80101be0 <dirlookup>
80101e67:	83 c4 10             	add    $0x10,%esp
80101e6a:	85 c0                	test   %eax,%eax
80101e6c:	75 67                	jne    80101ed5 <dirlink+0x85>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101e6e:	8b 7b 58             	mov    0x58(%ebx),%edi
80101e71:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101e74:	85 ff                	test   %edi,%edi
80101e76:	74 29                	je     80101ea1 <dirlink+0x51>
80101e78:	31 ff                	xor    %edi,%edi
80101e7a:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101e7d:	eb 09                	jmp    80101e88 <dirlink+0x38>
80101e7f:	90                   	nop
80101e80:	83 c7 10             	add    $0x10,%edi
80101e83:	3b 7b 58             	cmp    0x58(%ebx),%edi
80101e86:	73 19                	jae    80101ea1 <dirlink+0x51>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101e88:	6a 10                	push   $0x10
80101e8a:	57                   	push   %edi
80101e8b:	56                   	push   %esi
80101e8c:	53                   	push   %ebx
80101e8d:	e8 fe fa ff ff       	call   80101990 <readi>
80101e92:	83 c4 10             	add    $0x10,%esp
80101e95:	83 f8 10             	cmp    $0x10,%eax
80101e98:	75 4e                	jne    80101ee8 <dirlink+0x98>
    if(de.inum == 0)
80101e9a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101e9f:	75 df                	jne    80101e80 <dirlink+0x30>
  strncpy(de.name, name, DIRSIZ);
80101ea1:	8d 45 da             	lea    -0x26(%ebp),%eax
80101ea4:	83 ec 04             	sub    $0x4,%esp
80101ea7:	6a 0e                	push   $0xe
80101ea9:	ff 75 0c             	pushl  0xc(%ebp)
80101eac:	50                   	push   %eax
80101ead:	e8 7e 2c 00 00       	call   80104b30 <strncpy>
  de.inum = inum;
80101eb2:	8b 45 10             	mov    0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101eb5:	6a 10                	push   $0x10
80101eb7:	57                   	push   %edi
80101eb8:	56                   	push   %esi
80101eb9:	53                   	push   %ebx
  de.inum = inum;
80101eba:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101ebe:	e8 cd fb ff ff       	call   80101a90 <writei>
80101ec3:	83 c4 20             	add    $0x20,%esp
80101ec6:	83 f8 10             	cmp    $0x10,%eax
80101ec9:	75 2a                	jne    80101ef5 <dirlink+0xa5>
  return 0;
80101ecb:	31 c0                	xor    %eax,%eax
}
80101ecd:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101ed0:	5b                   	pop    %ebx
80101ed1:	5e                   	pop    %esi
80101ed2:	5f                   	pop    %edi
80101ed3:	5d                   	pop    %ebp
80101ed4:	c3                   	ret    
    iput(ip);
80101ed5:	83 ec 0c             	sub    $0xc,%esp
80101ed8:	50                   	push   %eax
80101ed9:	e8 02 f9 ff ff       	call   801017e0 <iput>
    return -1;
80101ede:	83 c4 10             	add    $0x10,%esp
80101ee1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101ee6:	eb e5                	jmp    80101ecd <dirlink+0x7d>
      panic("dirlink read");
80101ee8:	83 ec 0c             	sub    $0xc,%esp
80101eeb:	68 c8 76 10 80       	push   $0x801076c8
80101ef0:	e8 9b e4 ff ff       	call   80100390 <panic>
    panic("dirlink");
80101ef5:	83 ec 0c             	sub    $0xc,%esp
80101ef8:	68 aa 7c 10 80       	push   $0x80107caa
80101efd:	e8 8e e4 ff ff       	call   80100390 <panic>
80101f02:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101f09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101f10 <namei>:

struct inode*
namei(char *path)
{
80101f10:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
80101f11:	31 d2                	xor    %edx,%edx
{
80101f13:	89 e5                	mov    %esp,%ebp
80101f15:	83 ec 18             	sub    $0x18,%esp
  return namex(path, 0, name);
80101f18:	8b 45 08             	mov    0x8(%ebp),%eax
80101f1b:	8d 4d ea             	lea    -0x16(%ebp),%ecx
80101f1e:	e8 6d fd ff ff       	call   80101c90 <namex>
}
80101f23:	c9                   	leave  
80101f24:	c3                   	ret    
80101f25:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101f29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101f30 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80101f30:	55                   	push   %ebp
  return namex(path, 1, name);
80101f31:	ba 01 00 00 00       	mov    $0x1,%edx
{
80101f36:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
80101f38:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80101f3b:	8b 45 08             	mov    0x8(%ebp),%eax
}
80101f3e:	5d                   	pop    %ebp
  return namex(path, 1, name);
80101f3f:	e9 4c fd ff ff       	jmp    80101c90 <namex>
80101f44:	66 90                	xchg   %ax,%ax
80101f46:	66 90                	xchg   %ax,%ax
80101f48:	66 90                	xchg   %ax,%ax
80101f4a:	66 90                	xchg   %ax,%ax
80101f4c:	66 90                	xchg   %ax,%ax
80101f4e:	66 90                	xchg   %ax,%ax

80101f50 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80101f50:	55                   	push   %ebp
80101f51:	89 e5                	mov    %esp,%ebp
80101f53:	57                   	push   %edi
80101f54:	56                   	push   %esi
80101f55:	53                   	push   %ebx
80101f56:	83 ec 0c             	sub    $0xc,%esp
  if(b == 0)
80101f59:	85 c0                	test   %eax,%eax
80101f5b:	0f 84 b4 00 00 00    	je     80102015 <idestart+0xc5>
    panic("idestart");
  if(b->blockno >= FSSIZE)
80101f61:	8b 58 08             	mov    0x8(%eax),%ebx
80101f64:	89 c6                	mov    %eax,%esi
80101f66:	81 fb e7 03 00 00    	cmp    $0x3e7,%ebx
80101f6c:	0f 87 96 00 00 00    	ja     80102008 <idestart+0xb8>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80101f72:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
80101f77:	89 f6                	mov    %esi,%esi
80101f79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80101f80:	89 ca                	mov    %ecx,%edx
80101f82:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80101f83:	83 e0 c0             	and    $0xffffffc0,%eax
80101f86:	3c 40                	cmp    $0x40,%al
80101f88:	75 f6                	jne    80101f80 <idestart+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80101f8a:	31 ff                	xor    %edi,%edi
80101f8c:	ba f6 03 00 00       	mov    $0x3f6,%edx
80101f91:	89 f8                	mov    %edi,%eax
80101f93:	ee                   	out    %al,(%dx)
80101f94:	b8 01 00 00 00       	mov    $0x1,%eax
80101f99:	ba f2 01 00 00       	mov    $0x1f2,%edx
80101f9e:	ee                   	out    %al,(%dx)
80101f9f:	ba f3 01 00 00       	mov    $0x1f3,%edx
80101fa4:	89 d8                	mov    %ebx,%eax
80101fa6:	ee                   	out    %al,(%dx)

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
80101fa7:	89 d8                	mov    %ebx,%eax
80101fa9:	ba f4 01 00 00       	mov    $0x1f4,%edx
80101fae:	c1 f8 08             	sar    $0x8,%eax
80101fb1:	ee                   	out    %al,(%dx)
80101fb2:	ba f5 01 00 00       	mov    $0x1f5,%edx
80101fb7:	89 f8                	mov    %edi,%eax
80101fb9:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
80101fba:	0f b6 46 04          	movzbl 0x4(%esi),%eax
80101fbe:	ba f6 01 00 00       	mov    $0x1f6,%edx
80101fc3:	c1 e0 04             	shl    $0x4,%eax
80101fc6:	83 e0 10             	and    $0x10,%eax
80101fc9:	83 c8 e0             	or     $0xffffffe0,%eax
80101fcc:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
80101fcd:	f6 06 04             	testb  $0x4,(%esi)
80101fd0:	75 16                	jne    80101fe8 <idestart+0x98>
80101fd2:	b8 20 00 00 00       	mov    $0x20,%eax
80101fd7:	89 ca                	mov    %ecx,%edx
80101fd9:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
80101fda:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101fdd:	5b                   	pop    %ebx
80101fde:	5e                   	pop    %esi
80101fdf:	5f                   	pop    %edi
80101fe0:	5d                   	pop    %ebp
80101fe1:	c3                   	ret    
80101fe2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101fe8:	b8 30 00 00 00       	mov    $0x30,%eax
80101fed:	89 ca                	mov    %ecx,%edx
80101fef:	ee                   	out    %al,(%dx)
  asm volatile("cld; rep outsl" :
80101ff0:	b9 80 00 00 00       	mov    $0x80,%ecx
    outsl(0x1f0, b->data, BSIZE/4);
80101ff5:	83 c6 5c             	add    $0x5c,%esi
80101ff8:	ba f0 01 00 00       	mov    $0x1f0,%edx
80101ffd:	fc                   	cld    
80101ffe:	f3 6f                	rep outsl %ds:(%esi),(%dx)
}
80102000:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102003:	5b                   	pop    %ebx
80102004:	5e                   	pop    %esi
80102005:	5f                   	pop    %edi
80102006:	5d                   	pop    %ebp
80102007:	c3                   	ret    
    panic("incorrect blockno");
80102008:	83 ec 0c             	sub    $0xc,%esp
8010200b:	68 34 77 10 80       	push   $0x80107734
80102010:	e8 7b e3 ff ff       	call   80100390 <panic>
    panic("idestart");
80102015:	83 ec 0c             	sub    $0xc,%esp
80102018:	68 2b 77 10 80       	push   $0x8010772b
8010201d:	e8 6e e3 ff ff       	call   80100390 <panic>
80102022:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102029:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102030 <ideinit>:
{
80102030:	55                   	push   %ebp
80102031:	89 e5                	mov    %esp,%ebp
80102033:	83 ec 10             	sub    $0x10,%esp
  initlock(&idelock, "ide");
80102036:	68 46 77 10 80       	push   $0x80107746
8010203b:	68 80 a5 10 80       	push   $0x8010a580
80102040:	e8 1b 27 00 00       	call   80104760 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
80102045:	58                   	pop    %eax
80102046:	a1 00 2d 11 80       	mov    0x80112d00,%eax
8010204b:	5a                   	pop    %edx
8010204c:	83 e8 01             	sub    $0x1,%eax
8010204f:	50                   	push   %eax
80102050:	6a 0e                	push   $0xe
80102052:	e8 a9 02 00 00       	call   80102300 <ioapicenable>
80102057:	83 c4 10             	add    $0x10,%esp
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010205a:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010205f:	90                   	nop
80102060:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102061:	83 e0 c0             	and    $0xffffffc0,%eax
80102064:	3c 40                	cmp    $0x40,%al
80102066:	75 f8                	jne    80102060 <ideinit+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102068:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
8010206d:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102072:	ee                   	out    %al,(%dx)
80102073:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102078:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010207d:	eb 06                	jmp    80102085 <ideinit+0x55>
8010207f:	90                   	nop
  for(i=0; i<1000; i++){
80102080:	83 e9 01             	sub    $0x1,%ecx
80102083:	74 0f                	je     80102094 <ideinit+0x64>
80102085:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
80102086:	84 c0                	test   %al,%al
80102088:	74 f6                	je     80102080 <ideinit+0x50>
      havedisk1 = 1;
8010208a:	c7 05 60 a5 10 80 01 	movl   $0x1,0x8010a560
80102091:	00 00 00 
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102094:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
80102099:	ba f6 01 00 00       	mov    $0x1f6,%edx
8010209e:	ee                   	out    %al,(%dx)
}
8010209f:	c9                   	leave  
801020a0:	c3                   	ret    
801020a1:	eb 0d                	jmp    801020b0 <ideintr>
801020a3:	90                   	nop
801020a4:	90                   	nop
801020a5:	90                   	nop
801020a6:	90                   	nop
801020a7:	90                   	nop
801020a8:	90                   	nop
801020a9:	90                   	nop
801020aa:	90                   	nop
801020ab:	90                   	nop
801020ac:	90                   	nop
801020ad:	90                   	nop
801020ae:	90                   	nop
801020af:	90                   	nop

801020b0 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
801020b0:	55                   	push   %ebp
801020b1:	89 e5                	mov    %esp,%ebp
801020b3:	57                   	push   %edi
801020b4:	56                   	push   %esi
801020b5:	53                   	push   %ebx
801020b6:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
801020b9:	68 80 a5 10 80       	push   $0x8010a580
801020be:	e8 dd 27 00 00       	call   801048a0 <acquire>

  if((b = idequeue) == 0){
801020c3:	8b 1d 64 a5 10 80    	mov    0x8010a564,%ebx
801020c9:	83 c4 10             	add    $0x10,%esp
801020cc:	85 db                	test   %ebx,%ebx
801020ce:	74 67                	je     80102137 <ideintr+0x87>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
801020d0:	8b 43 58             	mov    0x58(%ebx),%eax
801020d3:	a3 64 a5 10 80       	mov    %eax,0x8010a564

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
801020d8:	8b 3b                	mov    (%ebx),%edi
801020da:	f7 c7 04 00 00 00    	test   $0x4,%edi
801020e0:	75 31                	jne    80102113 <ideintr+0x63>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801020e2:	ba f7 01 00 00       	mov    $0x1f7,%edx
801020e7:	89 f6                	mov    %esi,%esi
801020e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801020f0:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801020f1:	89 c6                	mov    %eax,%esi
801020f3:	83 e6 c0             	and    $0xffffffc0,%esi
801020f6:	89 f1                	mov    %esi,%ecx
801020f8:	80 f9 40             	cmp    $0x40,%cl
801020fb:	75 f3                	jne    801020f0 <ideintr+0x40>
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
801020fd:	a8 21                	test   $0x21,%al
801020ff:	75 12                	jne    80102113 <ideintr+0x63>
    insl(0x1f0, b->data, BSIZE/4);
80102101:	8d 7b 5c             	lea    0x5c(%ebx),%edi
  asm volatile("cld; rep insl" :
80102104:	b9 80 00 00 00       	mov    $0x80,%ecx
80102109:	ba f0 01 00 00       	mov    $0x1f0,%edx
8010210e:	fc                   	cld    
8010210f:	f3 6d                	rep insl (%dx),%es:(%edi)
80102111:	8b 3b                	mov    (%ebx),%edi

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
80102113:	83 e7 fb             	and    $0xfffffffb,%edi
  wakeup(b);
80102116:	83 ec 0c             	sub    $0xc,%esp
  b->flags &= ~B_DIRTY;
80102119:	89 f9                	mov    %edi,%ecx
8010211b:	83 c9 02             	or     $0x2,%ecx
8010211e:	89 0b                	mov    %ecx,(%ebx)
  wakeup(b);
80102120:	53                   	push   %ebx
80102121:	e8 aa 1f 00 00       	call   801040d0 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
80102126:	a1 64 a5 10 80       	mov    0x8010a564,%eax
8010212b:	83 c4 10             	add    $0x10,%esp
8010212e:	85 c0                	test   %eax,%eax
80102130:	74 05                	je     80102137 <ideintr+0x87>
    idestart(idequeue);
80102132:	e8 19 fe ff ff       	call   80101f50 <idestart>
    release(&idelock);
80102137:	83 ec 0c             	sub    $0xc,%esp
8010213a:	68 80 a5 10 80       	push   $0x8010a580
8010213f:	e8 1c 28 00 00       	call   80104960 <release>

  release(&idelock);
}
80102144:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102147:	5b                   	pop    %ebx
80102148:	5e                   	pop    %esi
80102149:	5f                   	pop    %edi
8010214a:	5d                   	pop    %ebp
8010214b:	c3                   	ret    
8010214c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102150 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
80102150:	55                   	push   %ebp
80102151:	89 e5                	mov    %esp,%ebp
80102153:	53                   	push   %ebx
80102154:	83 ec 10             	sub    $0x10,%esp
80102157:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
8010215a:	8d 43 0c             	lea    0xc(%ebx),%eax
8010215d:	50                   	push   %eax
8010215e:	e8 ad 25 00 00       	call   80104710 <holdingsleep>
80102163:	83 c4 10             	add    $0x10,%esp
80102166:	85 c0                	test   %eax,%eax
80102168:	0f 84 c6 00 00 00    	je     80102234 <iderw+0xe4>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
8010216e:	8b 03                	mov    (%ebx),%eax
80102170:	83 e0 06             	and    $0x6,%eax
80102173:	83 f8 02             	cmp    $0x2,%eax
80102176:	0f 84 ab 00 00 00    	je     80102227 <iderw+0xd7>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
8010217c:	8b 53 04             	mov    0x4(%ebx),%edx
8010217f:	85 d2                	test   %edx,%edx
80102181:	74 0d                	je     80102190 <iderw+0x40>
80102183:	a1 60 a5 10 80       	mov    0x8010a560,%eax
80102188:	85 c0                	test   %eax,%eax
8010218a:	0f 84 b1 00 00 00    	je     80102241 <iderw+0xf1>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
80102190:	83 ec 0c             	sub    $0xc,%esp
80102193:	68 80 a5 10 80       	push   $0x8010a580
80102198:	e8 03 27 00 00       	call   801048a0 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010219d:	8b 15 64 a5 10 80    	mov    0x8010a564,%edx
801021a3:	83 c4 10             	add    $0x10,%esp
  b->qnext = 0;
801021a6:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801021ad:	85 d2                	test   %edx,%edx
801021af:	75 09                	jne    801021ba <iderw+0x6a>
801021b1:	eb 6d                	jmp    80102220 <iderw+0xd0>
801021b3:	90                   	nop
801021b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801021b8:	89 c2                	mov    %eax,%edx
801021ba:	8b 42 58             	mov    0x58(%edx),%eax
801021bd:	85 c0                	test   %eax,%eax
801021bf:	75 f7                	jne    801021b8 <iderw+0x68>
801021c1:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
801021c4:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
801021c6:	39 1d 64 a5 10 80    	cmp    %ebx,0x8010a564
801021cc:	74 42                	je     80102210 <iderw+0xc0>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
801021ce:	8b 03                	mov    (%ebx),%eax
801021d0:	83 e0 06             	and    $0x6,%eax
801021d3:	83 f8 02             	cmp    $0x2,%eax
801021d6:	74 23                	je     801021fb <iderw+0xab>
801021d8:	90                   	nop
801021d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    sleep(b, &idelock);
801021e0:	83 ec 08             	sub    $0x8,%esp
801021e3:	68 80 a5 10 80       	push   $0x8010a580
801021e8:	53                   	push   %ebx
801021e9:	e8 32 1d 00 00       	call   80103f20 <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
801021ee:	8b 03                	mov    (%ebx),%eax
801021f0:	83 c4 10             	add    $0x10,%esp
801021f3:	83 e0 06             	and    $0x6,%eax
801021f6:	83 f8 02             	cmp    $0x2,%eax
801021f9:	75 e5                	jne    801021e0 <iderw+0x90>
  }


  release(&idelock);
801021fb:	c7 45 08 80 a5 10 80 	movl   $0x8010a580,0x8(%ebp)
}
80102202:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102205:	c9                   	leave  
  release(&idelock);
80102206:	e9 55 27 00 00       	jmp    80104960 <release>
8010220b:	90                   	nop
8010220c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    idestart(b);
80102210:	89 d8                	mov    %ebx,%eax
80102212:	e8 39 fd ff ff       	call   80101f50 <idestart>
80102217:	eb b5                	jmp    801021ce <iderw+0x7e>
80102219:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102220:	ba 64 a5 10 80       	mov    $0x8010a564,%edx
80102225:	eb 9d                	jmp    801021c4 <iderw+0x74>
    panic("iderw: nothing to do");
80102227:	83 ec 0c             	sub    $0xc,%esp
8010222a:	68 60 77 10 80       	push   $0x80107760
8010222f:	e8 5c e1 ff ff       	call   80100390 <panic>
    panic("iderw: buf not locked");
80102234:	83 ec 0c             	sub    $0xc,%esp
80102237:	68 4a 77 10 80       	push   $0x8010774a
8010223c:	e8 4f e1 ff ff       	call   80100390 <panic>
    panic("iderw: ide disk 1 not present");
80102241:	83 ec 0c             	sub    $0xc,%esp
80102244:	68 75 77 10 80       	push   $0x80107775
80102249:	e8 42 e1 ff ff       	call   80100390 <panic>
8010224e:	66 90                	xchg   %ax,%ax

80102250 <ioapicinit>:
80102250:	55                   	push   %ebp
80102251:	c7 05 34 26 11 80 00 	movl   $0xfec00000,0x80112634
80102258:	00 c0 fe 
8010225b:	89 e5                	mov    %esp,%ebp
8010225d:	56                   	push   %esi
8010225e:	53                   	push   %ebx
8010225f:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
80102266:	00 00 00 
80102269:	a1 34 26 11 80       	mov    0x80112634,%eax
8010226e:	8b 58 10             	mov    0x10(%eax),%ebx
80102271:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80102277:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
8010227d:	0f b6 15 60 27 11 80 	movzbl 0x80112760,%edx
80102284:	c1 eb 10             	shr    $0x10,%ebx
80102287:	8b 41 10             	mov    0x10(%ecx),%eax
8010228a:	0f b6 db             	movzbl %bl,%ebx
8010228d:	c1 e8 18             	shr    $0x18,%eax
80102290:	39 c2                	cmp    %eax,%edx
80102292:	74 16                	je     801022aa <ioapicinit+0x5a>
80102294:	83 ec 0c             	sub    $0xc,%esp
80102297:	68 94 77 10 80       	push   $0x80107794
8010229c:	e8 bf e3 ff ff       	call   80100660 <cprintf>
801022a1:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
801022a7:	83 c4 10             	add    $0x10,%esp
801022aa:	83 c3 21             	add    $0x21,%ebx
801022ad:	ba 10 00 00 00       	mov    $0x10,%edx
801022b2:	b8 20 00 00 00       	mov    $0x20,%eax
801022b7:	89 f6                	mov    %esi,%esi
801022b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801022c0:	89 11                	mov    %edx,(%ecx)
801022c2:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
801022c8:	89 c6                	mov    %eax,%esi
801022ca:	81 ce 00 00 01 00    	or     $0x10000,%esi
801022d0:	83 c0 01             	add    $0x1,%eax
801022d3:	89 71 10             	mov    %esi,0x10(%ecx)
801022d6:	8d 72 01             	lea    0x1(%edx),%esi
801022d9:	83 c2 02             	add    $0x2,%edx
801022dc:	39 d8                	cmp    %ebx,%eax
801022de:	89 31                	mov    %esi,(%ecx)
801022e0:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
801022e6:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
801022ed:	75 d1                	jne    801022c0 <ioapicinit+0x70>
801022ef:	8d 65 f8             	lea    -0x8(%ebp),%esp
801022f2:	5b                   	pop    %ebx
801022f3:	5e                   	pop    %esi
801022f4:	5d                   	pop    %ebp
801022f5:	c3                   	ret    
801022f6:	8d 76 00             	lea    0x0(%esi),%esi
801022f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102300 <ioapicenable>:
80102300:	55                   	push   %ebp
80102301:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
80102307:	89 e5                	mov    %esp,%ebp
80102309:	8b 45 08             	mov    0x8(%ebp),%eax
8010230c:	8d 50 20             	lea    0x20(%eax),%edx
8010230f:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
80102313:	89 01                	mov    %eax,(%ecx)
80102315:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
8010231b:	83 c0 01             	add    $0x1,%eax
8010231e:	89 51 10             	mov    %edx,0x10(%ecx)
80102321:	8b 55 0c             	mov    0xc(%ebp),%edx
80102324:	89 01                	mov    %eax,(%ecx)
80102326:	a1 34 26 11 80       	mov    0x80112634,%eax
8010232b:	c1 e2 18             	shl    $0x18,%edx
8010232e:	89 50 10             	mov    %edx,0x10(%eax)
80102331:	5d                   	pop    %ebp
80102332:	c3                   	ret    
80102333:	66 90                	xchg   %ax,%ax
80102335:	66 90                	xchg   %ax,%ax
80102337:	66 90                	xchg   %ax,%ax
80102339:	66 90                	xchg   %ax,%ax
8010233b:	66 90                	xchg   %ax,%ax
8010233d:	66 90                	xchg   %ax,%ax
8010233f:	90                   	nop

80102340 <kfree>:
80102340:	55                   	push   %ebp
80102341:	89 e5                	mov    %esp,%ebp
80102343:	53                   	push   %ebx
80102344:	83 ec 04             	sub    $0x4,%esp
80102347:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010234a:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
80102350:	75 70                	jne    801023c2 <kfree+0x82>
80102352:	81 fb a8 9a 11 80    	cmp    $0x80119aa8,%ebx
80102358:	72 68                	jb     801023c2 <kfree+0x82>
8010235a:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80102360:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80102365:	77 5b                	ja     801023c2 <kfree+0x82>
80102367:	83 ec 04             	sub    $0x4,%esp
8010236a:	68 00 10 00 00       	push   $0x1000
8010236f:	6a 01                	push   $0x1
80102371:	53                   	push   %ebx
80102372:	e8 39 26 00 00       	call   801049b0 <memset>
80102377:	8b 15 74 26 11 80    	mov    0x80112674,%edx
8010237d:	83 c4 10             	add    $0x10,%esp
80102380:	85 d2                	test   %edx,%edx
80102382:	75 2c                	jne    801023b0 <kfree+0x70>
80102384:	a1 78 26 11 80       	mov    0x80112678,%eax
80102389:	89 03                	mov    %eax,(%ebx)
8010238b:	a1 74 26 11 80       	mov    0x80112674,%eax
80102390:	89 1d 78 26 11 80    	mov    %ebx,0x80112678
80102396:	85 c0                	test   %eax,%eax
80102398:	75 06                	jne    801023a0 <kfree+0x60>
8010239a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010239d:	c9                   	leave  
8010239e:	c3                   	ret    
8010239f:	90                   	nop
801023a0:	c7 45 08 40 26 11 80 	movl   $0x80112640,0x8(%ebp)
801023a7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801023aa:	c9                   	leave  
801023ab:	e9 b0 25 00 00       	jmp    80104960 <release>
801023b0:	83 ec 0c             	sub    $0xc,%esp
801023b3:	68 40 26 11 80       	push   $0x80112640
801023b8:	e8 e3 24 00 00       	call   801048a0 <acquire>
801023bd:	83 c4 10             	add    $0x10,%esp
801023c0:	eb c2                	jmp    80102384 <kfree+0x44>
801023c2:	83 ec 0c             	sub    $0xc,%esp
801023c5:	68 c6 77 10 80       	push   $0x801077c6
801023ca:	e8 c1 df ff ff       	call   80100390 <panic>
801023cf:	90                   	nop

801023d0 <freerange>:
801023d0:	55                   	push   %ebp
801023d1:	89 e5                	mov    %esp,%ebp
801023d3:	56                   	push   %esi
801023d4:	53                   	push   %ebx
801023d5:	8b 45 08             	mov    0x8(%ebp),%eax
801023d8:	8b 75 0c             	mov    0xc(%ebp),%esi
801023db:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801023e1:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
801023e7:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801023ed:	39 de                	cmp    %ebx,%esi
801023ef:	72 23                	jb     80102414 <freerange+0x44>
801023f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801023f8:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
801023fe:	83 ec 0c             	sub    $0xc,%esp
80102401:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80102407:	50                   	push   %eax
80102408:	e8 33 ff ff ff       	call   80102340 <kfree>
8010240d:	83 c4 10             	add    $0x10,%esp
80102410:	39 f3                	cmp    %esi,%ebx
80102412:	76 e4                	jbe    801023f8 <freerange+0x28>
80102414:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102417:	5b                   	pop    %ebx
80102418:	5e                   	pop    %esi
80102419:	5d                   	pop    %ebp
8010241a:	c3                   	ret    
8010241b:	90                   	nop
8010241c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102420 <kinit1>:
80102420:	55                   	push   %ebp
80102421:	89 e5                	mov    %esp,%ebp
80102423:	56                   	push   %esi
80102424:	53                   	push   %ebx
80102425:	8b 75 0c             	mov    0xc(%ebp),%esi
80102428:	83 ec 08             	sub    $0x8,%esp
8010242b:	68 cc 77 10 80       	push   $0x801077cc
80102430:	68 40 26 11 80       	push   $0x80112640
80102435:	e8 26 23 00 00       	call   80104760 <initlock>
8010243a:	8b 45 08             	mov    0x8(%ebp),%eax
8010243d:	83 c4 10             	add    $0x10,%esp
80102440:	c7 05 74 26 11 80 00 	movl   $0x0,0x80112674
80102447:	00 00 00 
8010244a:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102450:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
80102456:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010245c:	39 de                	cmp    %ebx,%esi
8010245e:	72 1c                	jb     8010247c <kinit1+0x5c>
80102460:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
80102466:	83 ec 0c             	sub    $0xc,%esp
80102469:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010246f:	50                   	push   %eax
80102470:	e8 cb fe ff ff       	call   80102340 <kfree>
80102475:	83 c4 10             	add    $0x10,%esp
80102478:	39 de                	cmp    %ebx,%esi
8010247a:	73 e4                	jae    80102460 <kinit1+0x40>
8010247c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010247f:	5b                   	pop    %ebx
80102480:	5e                   	pop    %esi
80102481:	5d                   	pop    %ebp
80102482:	c3                   	ret    
80102483:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102489:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102490 <kinit2>:
80102490:	55                   	push   %ebp
80102491:	89 e5                	mov    %esp,%ebp
80102493:	56                   	push   %esi
80102494:	53                   	push   %ebx
80102495:	8b 45 08             	mov    0x8(%ebp),%eax
80102498:	8b 75 0c             	mov    0xc(%ebp),%esi
8010249b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801024a1:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
801024a7:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801024ad:	39 de                	cmp    %ebx,%esi
801024af:	72 23                	jb     801024d4 <kinit2+0x44>
801024b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801024b8:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
801024be:	83 ec 0c             	sub    $0xc,%esp
801024c1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801024c7:	50                   	push   %eax
801024c8:	e8 73 fe ff ff       	call   80102340 <kfree>
801024cd:	83 c4 10             	add    $0x10,%esp
801024d0:	39 de                	cmp    %ebx,%esi
801024d2:	73 e4                	jae    801024b8 <kinit2+0x28>
801024d4:	c7 05 74 26 11 80 01 	movl   $0x1,0x80112674
801024db:	00 00 00 
801024de:	8d 65 f8             	lea    -0x8(%ebp),%esp
801024e1:	5b                   	pop    %ebx
801024e2:	5e                   	pop    %esi
801024e3:	5d                   	pop    %ebp
801024e4:	c3                   	ret    
801024e5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801024e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801024f0 <kalloc>:
801024f0:	a1 74 26 11 80       	mov    0x80112674,%eax
801024f5:	85 c0                	test   %eax,%eax
801024f7:	75 1f                	jne    80102518 <kalloc+0x28>
801024f9:	a1 78 26 11 80       	mov    0x80112678,%eax
801024fe:	85 c0                	test   %eax,%eax
80102500:	74 0e                	je     80102510 <kalloc+0x20>
80102502:	8b 10                	mov    (%eax),%edx
80102504:	89 15 78 26 11 80    	mov    %edx,0x80112678
8010250a:	c3                   	ret    
8010250b:	90                   	nop
8010250c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102510:	f3 c3                	repz ret 
80102512:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102518:	55                   	push   %ebp
80102519:	89 e5                	mov    %esp,%ebp
8010251b:	83 ec 24             	sub    $0x24,%esp
8010251e:	68 40 26 11 80       	push   $0x80112640
80102523:	e8 78 23 00 00       	call   801048a0 <acquire>
80102528:	a1 78 26 11 80       	mov    0x80112678,%eax
8010252d:	83 c4 10             	add    $0x10,%esp
80102530:	8b 15 74 26 11 80    	mov    0x80112674,%edx
80102536:	85 c0                	test   %eax,%eax
80102538:	74 08                	je     80102542 <kalloc+0x52>
8010253a:	8b 08                	mov    (%eax),%ecx
8010253c:	89 0d 78 26 11 80    	mov    %ecx,0x80112678
80102542:	85 d2                	test   %edx,%edx
80102544:	74 16                	je     8010255c <kalloc+0x6c>
80102546:	83 ec 0c             	sub    $0xc,%esp
80102549:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010254c:	68 40 26 11 80       	push   $0x80112640
80102551:	e8 0a 24 00 00       	call   80104960 <release>
80102556:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102559:	83 c4 10             	add    $0x10,%esp
8010255c:	c9                   	leave  
8010255d:	c3                   	ret    
8010255e:	66 90                	xchg   %ax,%ax

80102560 <kbdgetc>:
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102560:	ba 64 00 00 00       	mov    $0x64,%edx
80102565:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
80102566:	a8 01                	test   $0x1,%al
80102568:	0f 84 c2 00 00 00    	je     80102630 <kbdgetc+0xd0>
8010256e:	ba 60 00 00 00       	mov    $0x60,%edx
80102573:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);
80102574:	0f b6 d0             	movzbl %al,%edx
80102577:	8b 0d b4 a5 10 80    	mov    0x8010a5b4,%ecx

  if(data == 0xE0){
8010257d:	81 fa e0 00 00 00    	cmp    $0xe0,%edx
80102583:	0f 84 7f 00 00 00    	je     80102608 <kbdgetc+0xa8>
{
80102589:	55                   	push   %ebp
8010258a:	89 e5                	mov    %esp,%ebp
8010258c:	53                   	push   %ebx
8010258d:	89 cb                	mov    %ecx,%ebx
8010258f:	83 e3 40             	and    $0x40,%ebx
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
80102592:	84 c0                	test   %al,%al
80102594:	78 4a                	js     801025e0 <kbdgetc+0x80>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
80102596:	85 db                	test   %ebx,%ebx
80102598:	74 09                	je     801025a3 <kbdgetc+0x43>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
8010259a:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
8010259d:	83 e1 bf             	and    $0xffffffbf,%ecx
    data |= 0x80;
801025a0:	0f b6 d0             	movzbl %al,%edx
  }

  shift |= shiftcode[data];
801025a3:	0f b6 82 00 79 10 80 	movzbl -0x7fef8700(%edx),%eax
801025aa:	09 c1                	or     %eax,%ecx
  shift ^= togglecode[data];
801025ac:	0f b6 82 00 78 10 80 	movzbl -0x7fef8800(%edx),%eax
801025b3:	31 c1                	xor    %eax,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
801025b5:	89 c8                	mov    %ecx,%eax
  shift ^= togglecode[data];
801025b7:	89 0d b4 a5 10 80    	mov    %ecx,0x8010a5b4
  c = charcode[shift & (CTL | SHIFT)][data];
801025bd:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
801025c0:	83 e1 08             	and    $0x8,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
801025c3:	8b 04 85 e0 77 10 80 	mov    -0x7fef8820(,%eax,4),%eax
801025ca:	0f b6 04 10          	movzbl (%eax,%edx,1),%eax
  if(shift & CAPSLOCK){
801025ce:	74 31                	je     80102601 <kbdgetc+0xa1>
    if('a' <= c && c <= 'z')
801025d0:	8d 50 9f             	lea    -0x61(%eax),%edx
801025d3:	83 fa 19             	cmp    $0x19,%edx
801025d6:	77 40                	ja     80102618 <kbdgetc+0xb8>
      c += 'A' - 'a';
801025d8:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
801025db:	5b                   	pop    %ebx
801025dc:	5d                   	pop    %ebp
801025dd:	c3                   	ret    
801025de:	66 90                	xchg   %ax,%ax
    data = (shift & E0ESC ? data : data & 0x7F);
801025e0:	83 e0 7f             	and    $0x7f,%eax
801025e3:	85 db                	test   %ebx,%ebx
801025e5:	0f 44 d0             	cmove  %eax,%edx
    shift &= ~(shiftcode[data] | E0ESC);
801025e8:	0f b6 82 00 79 10 80 	movzbl -0x7fef8700(%edx),%eax
801025ef:	83 c8 40             	or     $0x40,%eax
801025f2:	0f b6 c0             	movzbl %al,%eax
801025f5:	f7 d0                	not    %eax
801025f7:	21 c1                	and    %eax,%ecx
    return 0;
801025f9:	31 c0                	xor    %eax,%eax
    shift &= ~(shiftcode[data] | E0ESC);
801025fb:	89 0d b4 a5 10 80    	mov    %ecx,0x8010a5b4
}
80102601:	5b                   	pop    %ebx
80102602:	5d                   	pop    %ebp
80102603:	c3                   	ret    
80102604:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    shift |= E0ESC;
80102608:	83 c9 40             	or     $0x40,%ecx
    return 0;
8010260b:	31 c0                	xor    %eax,%eax
    shift |= E0ESC;
8010260d:	89 0d b4 a5 10 80    	mov    %ecx,0x8010a5b4
    return 0;
80102613:	c3                   	ret    
80102614:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    else if('A' <= c && c <= 'Z')
80102618:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
8010261b:	8d 50 20             	lea    0x20(%eax),%edx
}
8010261e:	5b                   	pop    %ebx
      c += 'a' - 'A';
8010261f:	83 f9 1a             	cmp    $0x1a,%ecx
80102622:	0f 42 c2             	cmovb  %edx,%eax
}
80102625:	5d                   	pop    %ebp
80102626:	c3                   	ret    
80102627:	89 f6                	mov    %esi,%esi
80102629:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80102630:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80102635:	c3                   	ret    
80102636:	8d 76 00             	lea    0x0(%esi),%esi
80102639:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102640 <kbdintr>:

void
kbdintr(void)
{
80102640:	55                   	push   %ebp
80102641:	89 e5                	mov    %esp,%ebp
80102643:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
80102646:	68 60 25 10 80       	push   $0x80102560
8010264b:	e8 c0 e1 ff ff       	call   80100810 <consoleintr>
}
80102650:	83 c4 10             	add    $0x10,%esp
80102653:	c9                   	leave  
80102654:	c3                   	ret    
80102655:	66 90                	xchg   %ax,%ax
80102657:	66 90                	xchg   %ax,%ax
80102659:	66 90                	xchg   %ax,%ax
8010265b:	66 90                	xchg   %ax,%ax
8010265d:	66 90                	xchg   %ax,%ax
8010265f:	90                   	nop

80102660 <lapicinit>:
}

void
lapicinit(void)
{
  if(!lapic)
80102660:	a1 7c 26 11 80       	mov    0x8011267c,%eax
{
80102665:	55                   	push   %ebp
80102666:	89 e5                	mov    %esp,%ebp
  if(!lapic)
80102668:	85 c0                	test   %eax,%eax
8010266a:	0f 84 c8 00 00 00    	je     80102738 <lapicinit+0xd8>
  lapic[index] = value;
80102670:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
80102677:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010267a:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010267d:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
80102684:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102687:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010268a:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
80102691:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
80102694:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102697:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
8010269e:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
801026a1:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801026a4:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
801026ab:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
801026ae:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801026b1:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
801026b8:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
801026bb:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
801026be:	8b 50 30             	mov    0x30(%eax),%edx
801026c1:	c1 ea 10             	shr    $0x10,%edx
801026c4:	80 fa 03             	cmp    $0x3,%dl
801026c7:	77 77                	ja     80102740 <lapicinit+0xe0>
  lapic[index] = value;
801026c9:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
801026d0:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026d3:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801026d6:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
801026dd:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026e0:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801026e3:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
801026ea:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026ed:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801026f0:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
801026f7:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026fa:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801026fd:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
80102704:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102707:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010270a:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
80102711:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
80102714:	8b 50 20             	mov    0x20(%eax),%edx
80102717:	89 f6                	mov    %esi,%esi
80102719:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
80102720:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
80102726:	80 e6 10             	and    $0x10,%dh
80102729:	75 f5                	jne    80102720 <lapicinit+0xc0>
  lapic[index] = value;
8010272b:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
80102732:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102735:	8b 40 20             	mov    0x20(%eax),%eax
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
80102738:	5d                   	pop    %ebp
80102739:	c3                   	ret    
8010273a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  lapic[index] = value;
80102740:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
80102747:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010274a:	8b 50 20             	mov    0x20(%eax),%edx
8010274d:	e9 77 ff ff ff       	jmp    801026c9 <lapicinit+0x69>
80102752:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102759:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102760 <lapicid>:

int
lapicid(void)
{
  if (!lapic)
80102760:	8b 15 7c 26 11 80    	mov    0x8011267c,%edx
{
80102766:	55                   	push   %ebp
80102767:	31 c0                	xor    %eax,%eax
80102769:	89 e5                	mov    %esp,%ebp
  if (!lapic)
8010276b:	85 d2                	test   %edx,%edx
8010276d:	74 06                	je     80102775 <lapicid+0x15>
    return 0;
  return lapic[ID] >> 24;
8010276f:	8b 42 20             	mov    0x20(%edx),%eax
80102772:	c1 e8 18             	shr    $0x18,%eax
}
80102775:	5d                   	pop    %ebp
80102776:	c3                   	ret    
80102777:	89 f6                	mov    %esi,%esi
80102779:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102780 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
80102780:	a1 7c 26 11 80       	mov    0x8011267c,%eax
{
80102785:	55                   	push   %ebp
80102786:	89 e5                	mov    %esp,%ebp
  if(lapic)
80102788:	85 c0                	test   %eax,%eax
8010278a:	74 0d                	je     80102799 <lapiceoi+0x19>
  lapic[index] = value;
8010278c:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102793:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102796:	8b 40 20             	mov    0x20(%eax),%eax
    lapicw(EOI, 0);
}
80102799:	5d                   	pop    %ebp
8010279a:	c3                   	ret    
8010279b:	90                   	nop
8010279c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801027a0 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
801027a0:	55                   	push   %ebp
801027a1:	89 e5                	mov    %esp,%ebp
}
801027a3:	5d                   	pop    %ebp
801027a4:	c3                   	ret    
801027a5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801027a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801027b0 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
801027b0:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801027b1:	b8 0f 00 00 00       	mov    $0xf,%eax
801027b6:	ba 70 00 00 00       	mov    $0x70,%edx
801027bb:	89 e5                	mov    %esp,%ebp
801027bd:	53                   	push   %ebx
801027be:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801027c1:	8b 5d 08             	mov    0x8(%ebp),%ebx
801027c4:	ee                   	out    %al,(%dx)
801027c5:	b8 0a 00 00 00       	mov    $0xa,%eax
801027ca:	ba 71 00 00 00       	mov    $0x71,%edx
801027cf:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
801027d0:	31 c0                	xor    %eax,%eax
  wrv[1] = addr >> 4;

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
801027d2:	c1 e3 18             	shl    $0x18,%ebx
  wrv[0] = 0;
801027d5:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
801027db:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
801027dd:	c1 e9 0c             	shr    $0xc,%ecx
  wrv[1] = addr >> 4;
801027e0:	c1 e8 04             	shr    $0x4,%eax
  lapicw(ICRHI, apicid<<24);
801027e3:	89 da                	mov    %ebx,%edx
    lapicw(ICRLO, STARTUP | (addr>>12));
801027e5:	80 cd 06             	or     $0x6,%ch
  wrv[1] = addr >> 4;
801027e8:	66 a3 69 04 00 80    	mov    %ax,0x80000469
  lapic[index] = value;
801027ee:	a1 7c 26 11 80       	mov    0x8011267c,%eax
801027f3:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801027f9:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801027fc:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
80102803:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102806:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102809:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
80102810:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102813:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102816:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
8010281c:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
8010281f:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102825:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102828:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
8010282e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102831:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102837:	8b 40 20             	mov    0x20(%eax),%eax
    microdelay(200);
  }
}
8010283a:	5b                   	pop    %ebx
8010283b:	5d                   	pop    %ebp
8010283c:	c3                   	ret    
8010283d:	8d 76 00             	lea    0x0(%esi),%esi

80102840 <cmostime>:
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void
cmostime(struct rtcdate *r)
{
80102840:	55                   	push   %ebp
80102841:	b8 0b 00 00 00       	mov    $0xb,%eax
80102846:	ba 70 00 00 00       	mov    $0x70,%edx
8010284b:	89 e5                	mov    %esp,%ebp
8010284d:	57                   	push   %edi
8010284e:	56                   	push   %esi
8010284f:	53                   	push   %ebx
80102850:	83 ec 4c             	sub    $0x4c,%esp
80102853:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102854:	ba 71 00 00 00       	mov    $0x71,%edx
80102859:	ec                   	in     (%dx),%al
8010285a:	83 e0 04             	and    $0x4,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010285d:	bb 70 00 00 00       	mov    $0x70,%ebx
80102862:	88 45 b3             	mov    %al,-0x4d(%ebp)
80102865:	8d 76 00             	lea    0x0(%esi),%esi
80102868:	31 c0                	xor    %eax,%eax
8010286a:	89 da                	mov    %ebx,%edx
8010286c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010286d:	b9 71 00 00 00       	mov    $0x71,%ecx
80102872:	89 ca                	mov    %ecx,%edx
80102874:	ec                   	in     (%dx),%al
80102875:	88 45 b7             	mov    %al,-0x49(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102878:	89 da                	mov    %ebx,%edx
8010287a:	b8 02 00 00 00       	mov    $0x2,%eax
8010287f:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102880:	89 ca                	mov    %ecx,%edx
80102882:	ec                   	in     (%dx),%al
80102883:	88 45 b6             	mov    %al,-0x4a(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102886:	89 da                	mov    %ebx,%edx
80102888:	b8 04 00 00 00       	mov    $0x4,%eax
8010288d:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010288e:	89 ca                	mov    %ecx,%edx
80102890:	ec                   	in     (%dx),%al
80102891:	88 45 b5             	mov    %al,-0x4b(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102894:	89 da                	mov    %ebx,%edx
80102896:	b8 07 00 00 00       	mov    $0x7,%eax
8010289b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010289c:	89 ca                	mov    %ecx,%edx
8010289e:	ec                   	in     (%dx),%al
8010289f:	88 45 b4             	mov    %al,-0x4c(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028a2:	89 da                	mov    %ebx,%edx
801028a4:	b8 08 00 00 00       	mov    $0x8,%eax
801028a9:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028aa:	89 ca                	mov    %ecx,%edx
801028ac:	ec                   	in     (%dx),%al
801028ad:	89 c7                	mov    %eax,%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028af:	89 da                	mov    %ebx,%edx
801028b1:	b8 09 00 00 00       	mov    $0x9,%eax
801028b6:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028b7:	89 ca                	mov    %ecx,%edx
801028b9:	ec                   	in     (%dx),%al
801028ba:	89 c6                	mov    %eax,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028bc:	89 da                	mov    %ebx,%edx
801028be:	b8 0a 00 00 00       	mov    $0xa,%eax
801028c3:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028c4:	89 ca                	mov    %ecx,%edx
801028c6:	ec                   	in     (%dx),%al
  bcd = (sb & (1 << 2)) == 0;

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
801028c7:	84 c0                	test   %al,%al
801028c9:	78 9d                	js     80102868 <cmostime+0x28>
  return inb(CMOS_RETURN);
801028cb:	0f b6 45 b7          	movzbl -0x49(%ebp),%eax
801028cf:	89 fa                	mov    %edi,%edx
801028d1:	0f b6 fa             	movzbl %dl,%edi
801028d4:	89 f2                	mov    %esi,%edx
801028d6:	0f b6 f2             	movzbl %dl,%esi
801028d9:	89 7d c8             	mov    %edi,-0x38(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028dc:	89 da                	mov    %ebx,%edx
801028de:	89 75 cc             	mov    %esi,-0x34(%ebp)
801028e1:	89 45 b8             	mov    %eax,-0x48(%ebp)
801028e4:	0f b6 45 b6          	movzbl -0x4a(%ebp),%eax
801028e8:	89 45 bc             	mov    %eax,-0x44(%ebp)
801028eb:	0f b6 45 b5          	movzbl -0x4b(%ebp),%eax
801028ef:	89 45 c0             	mov    %eax,-0x40(%ebp)
801028f2:	0f b6 45 b4          	movzbl -0x4c(%ebp),%eax
801028f6:	89 45 c4             	mov    %eax,-0x3c(%ebp)
801028f9:	31 c0                	xor    %eax,%eax
801028fb:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028fc:	89 ca                	mov    %ecx,%edx
801028fe:	ec                   	in     (%dx),%al
801028ff:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102902:	89 da                	mov    %ebx,%edx
80102904:	89 45 d0             	mov    %eax,-0x30(%ebp)
80102907:	b8 02 00 00 00       	mov    $0x2,%eax
8010290c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010290d:	89 ca                	mov    %ecx,%edx
8010290f:	ec                   	in     (%dx),%al
80102910:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102913:	89 da                	mov    %ebx,%edx
80102915:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80102918:	b8 04 00 00 00       	mov    $0x4,%eax
8010291d:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010291e:	89 ca                	mov    %ecx,%edx
80102920:	ec                   	in     (%dx),%al
80102921:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102924:	89 da                	mov    %ebx,%edx
80102926:	89 45 d8             	mov    %eax,-0x28(%ebp)
80102929:	b8 07 00 00 00       	mov    $0x7,%eax
8010292e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010292f:	89 ca                	mov    %ecx,%edx
80102931:	ec                   	in     (%dx),%al
80102932:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102935:	89 da                	mov    %ebx,%edx
80102937:	89 45 dc             	mov    %eax,-0x24(%ebp)
8010293a:	b8 08 00 00 00       	mov    $0x8,%eax
8010293f:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102940:	89 ca                	mov    %ecx,%edx
80102942:	ec                   	in     (%dx),%al
80102943:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102946:	89 da                	mov    %ebx,%edx
80102948:	89 45 e0             	mov    %eax,-0x20(%ebp)
8010294b:	b8 09 00 00 00       	mov    $0x9,%eax
80102950:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102951:	89 ca                	mov    %ecx,%edx
80102953:	ec                   	in     (%dx),%al
80102954:	0f b6 c0             	movzbl %al,%eax
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102957:	83 ec 04             	sub    $0x4,%esp
  return inb(CMOS_RETURN);
8010295a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
8010295d:	8d 45 d0             	lea    -0x30(%ebp),%eax
80102960:	6a 18                	push   $0x18
80102962:	50                   	push   %eax
80102963:	8d 45 b8             	lea    -0x48(%ebp),%eax
80102966:	50                   	push   %eax
80102967:	e8 94 20 00 00       	call   80104a00 <memcmp>
8010296c:	83 c4 10             	add    $0x10,%esp
8010296f:	85 c0                	test   %eax,%eax
80102971:	0f 85 f1 fe ff ff    	jne    80102868 <cmostime+0x28>
      break;
  }

  // convert
  if(bcd) {
80102977:	80 7d b3 00          	cmpb   $0x0,-0x4d(%ebp)
8010297b:	75 78                	jne    801029f5 <cmostime+0x1b5>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
8010297d:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102980:	89 c2                	mov    %eax,%edx
80102982:	83 e0 0f             	and    $0xf,%eax
80102985:	c1 ea 04             	shr    $0x4,%edx
80102988:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010298b:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010298e:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
80102991:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102994:	89 c2                	mov    %eax,%edx
80102996:	83 e0 0f             	and    $0xf,%eax
80102999:	c1 ea 04             	shr    $0x4,%edx
8010299c:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010299f:	8d 04 50             	lea    (%eax,%edx,2),%eax
801029a2:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
801029a5:	8b 45 c0             	mov    -0x40(%ebp),%eax
801029a8:	89 c2                	mov    %eax,%edx
801029aa:	83 e0 0f             	and    $0xf,%eax
801029ad:	c1 ea 04             	shr    $0x4,%edx
801029b0:	8d 14 92             	lea    (%edx,%edx,4),%edx
801029b3:	8d 04 50             	lea    (%eax,%edx,2),%eax
801029b6:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
801029b9:	8b 45 c4             	mov    -0x3c(%ebp),%eax
801029bc:	89 c2                	mov    %eax,%edx
801029be:	83 e0 0f             	and    $0xf,%eax
801029c1:	c1 ea 04             	shr    $0x4,%edx
801029c4:	8d 14 92             	lea    (%edx,%edx,4),%edx
801029c7:	8d 04 50             	lea    (%eax,%edx,2),%eax
801029ca:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
801029cd:	8b 45 c8             	mov    -0x38(%ebp),%eax
801029d0:	89 c2                	mov    %eax,%edx
801029d2:	83 e0 0f             	and    $0xf,%eax
801029d5:	c1 ea 04             	shr    $0x4,%edx
801029d8:	8d 14 92             	lea    (%edx,%edx,4),%edx
801029db:	8d 04 50             	lea    (%eax,%edx,2),%eax
801029de:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
801029e1:	8b 45 cc             	mov    -0x34(%ebp),%eax
801029e4:	89 c2                	mov    %eax,%edx
801029e6:	83 e0 0f             	and    $0xf,%eax
801029e9:	c1 ea 04             	shr    $0x4,%edx
801029ec:	8d 14 92             	lea    (%edx,%edx,4),%edx
801029ef:	8d 04 50             	lea    (%eax,%edx,2),%eax
801029f2:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
801029f5:	8b 75 08             	mov    0x8(%ebp),%esi
801029f8:	8b 45 b8             	mov    -0x48(%ebp),%eax
801029fb:	89 06                	mov    %eax,(%esi)
801029fd:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102a00:	89 46 04             	mov    %eax,0x4(%esi)
80102a03:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102a06:	89 46 08             	mov    %eax,0x8(%esi)
80102a09:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102a0c:	89 46 0c             	mov    %eax,0xc(%esi)
80102a0f:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102a12:	89 46 10             	mov    %eax,0x10(%esi)
80102a15:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102a18:	89 46 14             	mov    %eax,0x14(%esi)
  r->year += 2000;
80102a1b:	81 46 14 d0 07 00 00 	addl   $0x7d0,0x14(%esi)
}
80102a22:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102a25:	5b                   	pop    %ebx
80102a26:	5e                   	pop    %esi
80102a27:	5f                   	pop    %edi
80102a28:	5d                   	pop    %ebp
80102a29:	c3                   	ret    
80102a2a:	66 90                	xchg   %ax,%ax
80102a2c:	66 90                	xchg   %ax,%ax
80102a2e:	66 90                	xchg   %ax,%ax

80102a30 <install_trans>:
80102a30:	8b 0d c8 26 11 80    	mov    0x801126c8,%ecx
80102a36:	85 c9                	test   %ecx,%ecx
80102a38:	0f 8e 8a 00 00 00    	jle    80102ac8 <install_trans+0x98>
80102a3e:	55                   	push   %ebp
80102a3f:	89 e5                	mov    %esp,%ebp
80102a41:	57                   	push   %edi
80102a42:	56                   	push   %esi
80102a43:	53                   	push   %ebx
80102a44:	31 db                	xor    %ebx,%ebx
80102a46:	83 ec 0c             	sub    $0xc,%esp
80102a49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102a50:	a1 b4 26 11 80       	mov    0x801126b4,%eax
80102a55:	83 ec 08             	sub    $0x8,%esp
80102a58:	01 d8                	add    %ebx,%eax
80102a5a:	83 c0 01             	add    $0x1,%eax
80102a5d:	50                   	push   %eax
80102a5e:	ff 35 c4 26 11 80    	pushl  0x801126c4
80102a64:	e8 67 d6 ff ff       	call   801000d0 <bread>
80102a69:	89 c7                	mov    %eax,%edi
80102a6b:	58                   	pop    %eax
80102a6c:	5a                   	pop    %edx
80102a6d:	ff 34 9d cc 26 11 80 	pushl  -0x7feed934(,%ebx,4)
80102a74:	ff 35 c4 26 11 80    	pushl  0x801126c4
80102a7a:	83 c3 01             	add    $0x1,%ebx
80102a7d:	e8 4e d6 ff ff       	call   801000d0 <bread>
80102a82:	89 c6                	mov    %eax,%esi
80102a84:	8d 47 5c             	lea    0x5c(%edi),%eax
80102a87:	83 c4 0c             	add    $0xc,%esp
80102a8a:	68 00 02 00 00       	push   $0x200
80102a8f:	50                   	push   %eax
80102a90:	8d 46 5c             	lea    0x5c(%esi),%eax
80102a93:	50                   	push   %eax
80102a94:	e8 c7 1f 00 00       	call   80104a60 <memmove>
80102a99:	89 34 24             	mov    %esi,(%esp)
80102a9c:	e8 ff d6 ff ff       	call   801001a0 <bwrite>
80102aa1:	89 3c 24             	mov    %edi,(%esp)
80102aa4:	e8 37 d7 ff ff       	call   801001e0 <brelse>
80102aa9:	89 34 24             	mov    %esi,(%esp)
80102aac:	e8 2f d7 ff ff       	call   801001e0 <brelse>
80102ab1:	83 c4 10             	add    $0x10,%esp
80102ab4:	39 1d c8 26 11 80    	cmp    %ebx,0x801126c8
80102aba:	7f 94                	jg     80102a50 <install_trans+0x20>
80102abc:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102abf:	5b                   	pop    %ebx
80102ac0:	5e                   	pop    %esi
80102ac1:	5f                   	pop    %edi
80102ac2:	5d                   	pop    %ebp
80102ac3:	c3                   	ret    
80102ac4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102ac8:	f3 c3                	repz ret 
80102aca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102ad0 <write_head>:
80102ad0:	55                   	push   %ebp
80102ad1:	89 e5                	mov    %esp,%ebp
80102ad3:	56                   	push   %esi
80102ad4:	53                   	push   %ebx
80102ad5:	83 ec 08             	sub    $0x8,%esp
80102ad8:	ff 35 b4 26 11 80    	pushl  0x801126b4
80102ade:	ff 35 c4 26 11 80    	pushl  0x801126c4
80102ae4:	e8 e7 d5 ff ff       	call   801000d0 <bread>
80102ae9:	8b 1d c8 26 11 80    	mov    0x801126c8,%ebx
80102aef:	83 c4 10             	add    $0x10,%esp
80102af2:	89 c6                	mov    %eax,%esi
80102af4:	85 db                	test   %ebx,%ebx
80102af6:	89 58 5c             	mov    %ebx,0x5c(%eax)
80102af9:	7e 16                	jle    80102b11 <write_head+0x41>
80102afb:	c1 e3 02             	shl    $0x2,%ebx
80102afe:	31 d2                	xor    %edx,%edx
80102b00:	8b 8a cc 26 11 80    	mov    -0x7feed934(%edx),%ecx
80102b06:	89 4c 16 60          	mov    %ecx,0x60(%esi,%edx,1)
80102b0a:	83 c2 04             	add    $0x4,%edx
80102b0d:	39 da                	cmp    %ebx,%edx
80102b0f:	75 ef                	jne    80102b00 <write_head+0x30>
80102b11:	83 ec 0c             	sub    $0xc,%esp
80102b14:	56                   	push   %esi
80102b15:	e8 86 d6 ff ff       	call   801001a0 <bwrite>
80102b1a:	89 34 24             	mov    %esi,(%esp)
80102b1d:	e8 be d6 ff ff       	call   801001e0 <brelse>
80102b22:	83 c4 10             	add    $0x10,%esp
80102b25:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102b28:	5b                   	pop    %ebx
80102b29:	5e                   	pop    %esi
80102b2a:	5d                   	pop    %ebp
80102b2b:	c3                   	ret    
80102b2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102b30 <initlog>:
80102b30:	55                   	push   %ebp
80102b31:	89 e5                	mov    %esp,%ebp
80102b33:	53                   	push   %ebx
80102b34:	83 ec 2c             	sub    $0x2c,%esp
80102b37:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102b3a:	68 00 7a 10 80       	push   $0x80107a00
80102b3f:	68 80 26 11 80       	push   $0x80112680
80102b44:	e8 17 1c 00 00       	call   80104760 <initlock>
80102b49:	58                   	pop    %eax
80102b4a:	8d 45 dc             	lea    -0x24(%ebp),%eax
80102b4d:	5a                   	pop    %edx
80102b4e:	50                   	push   %eax
80102b4f:	53                   	push   %ebx
80102b50:	e8 1b e9 ff ff       	call   80101470 <readsb>
80102b55:	8b 55 e8             	mov    -0x18(%ebp),%edx
80102b58:	8b 45 ec             	mov    -0x14(%ebp),%eax
80102b5b:	59                   	pop    %ecx
80102b5c:	89 1d c4 26 11 80    	mov    %ebx,0x801126c4
80102b62:	89 15 b8 26 11 80    	mov    %edx,0x801126b8
80102b68:	a3 b4 26 11 80       	mov    %eax,0x801126b4
80102b6d:	5a                   	pop    %edx
80102b6e:	50                   	push   %eax
80102b6f:	53                   	push   %ebx
80102b70:	e8 5b d5 ff ff       	call   801000d0 <bread>
80102b75:	8b 58 5c             	mov    0x5c(%eax),%ebx
80102b78:	83 c4 10             	add    $0x10,%esp
80102b7b:	85 db                	test   %ebx,%ebx
80102b7d:	89 1d c8 26 11 80    	mov    %ebx,0x801126c8
80102b83:	7e 1c                	jle    80102ba1 <initlog+0x71>
80102b85:	c1 e3 02             	shl    $0x2,%ebx
80102b88:	31 d2                	xor    %edx,%edx
80102b8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102b90:	8b 4c 10 60          	mov    0x60(%eax,%edx,1),%ecx
80102b94:	83 c2 04             	add    $0x4,%edx
80102b97:	89 8a c8 26 11 80    	mov    %ecx,-0x7feed938(%edx)
80102b9d:	39 d3                	cmp    %edx,%ebx
80102b9f:	75 ef                	jne    80102b90 <initlog+0x60>
80102ba1:	83 ec 0c             	sub    $0xc,%esp
80102ba4:	50                   	push   %eax
80102ba5:	e8 36 d6 ff ff       	call   801001e0 <brelse>
80102baa:	e8 81 fe ff ff       	call   80102a30 <install_trans>
80102baf:	c7 05 c8 26 11 80 00 	movl   $0x0,0x801126c8
80102bb6:	00 00 00 
80102bb9:	e8 12 ff ff ff       	call   80102ad0 <write_head>
80102bbe:	83 c4 10             	add    $0x10,%esp
80102bc1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102bc4:	c9                   	leave  
80102bc5:	c3                   	ret    
80102bc6:	8d 76 00             	lea    0x0(%esi),%esi
80102bc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102bd0 <begin_op>:
80102bd0:	55                   	push   %ebp
80102bd1:	89 e5                	mov    %esp,%ebp
80102bd3:	83 ec 14             	sub    $0x14,%esp
80102bd6:	68 80 26 11 80       	push   $0x80112680
80102bdb:	e8 c0 1c 00 00       	call   801048a0 <acquire>
80102be0:	83 c4 10             	add    $0x10,%esp
80102be3:	eb 18                	jmp    80102bfd <begin_op+0x2d>
80102be5:	8d 76 00             	lea    0x0(%esi),%esi
80102be8:	83 ec 08             	sub    $0x8,%esp
80102beb:	68 80 26 11 80       	push   $0x80112680
80102bf0:	68 80 26 11 80       	push   $0x80112680
80102bf5:	e8 26 13 00 00       	call   80103f20 <sleep>
80102bfa:	83 c4 10             	add    $0x10,%esp
80102bfd:	a1 c0 26 11 80       	mov    0x801126c0,%eax
80102c02:	85 c0                	test   %eax,%eax
80102c04:	75 e2                	jne    80102be8 <begin_op+0x18>
80102c06:	a1 bc 26 11 80       	mov    0x801126bc,%eax
80102c0b:	8b 15 c8 26 11 80    	mov    0x801126c8,%edx
80102c11:	83 c0 01             	add    $0x1,%eax
80102c14:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80102c17:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80102c1a:	83 fa 1e             	cmp    $0x1e,%edx
80102c1d:	7f c9                	jg     80102be8 <begin_op+0x18>
80102c1f:	83 ec 0c             	sub    $0xc,%esp
80102c22:	a3 bc 26 11 80       	mov    %eax,0x801126bc
80102c27:	68 80 26 11 80       	push   $0x80112680
80102c2c:	e8 2f 1d 00 00       	call   80104960 <release>
80102c31:	83 c4 10             	add    $0x10,%esp
80102c34:	c9                   	leave  
80102c35:	c3                   	ret    
80102c36:	8d 76 00             	lea    0x0(%esi),%esi
80102c39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102c40 <end_op>:
80102c40:	55                   	push   %ebp
80102c41:	89 e5                	mov    %esp,%ebp
80102c43:	57                   	push   %edi
80102c44:	56                   	push   %esi
80102c45:	53                   	push   %ebx
80102c46:	83 ec 18             	sub    $0x18,%esp
80102c49:	68 80 26 11 80       	push   $0x80112680
80102c4e:	e8 4d 1c 00 00       	call   801048a0 <acquire>
80102c53:	a1 bc 26 11 80       	mov    0x801126bc,%eax
80102c58:	8b 35 c0 26 11 80    	mov    0x801126c0,%esi
80102c5e:	83 c4 10             	add    $0x10,%esp
80102c61:	8d 58 ff             	lea    -0x1(%eax),%ebx
80102c64:	85 f6                	test   %esi,%esi
80102c66:	89 1d bc 26 11 80    	mov    %ebx,0x801126bc
80102c6c:	0f 85 1a 01 00 00    	jne    80102d8c <end_op+0x14c>
80102c72:	85 db                	test   %ebx,%ebx
80102c74:	0f 85 ee 00 00 00    	jne    80102d68 <end_op+0x128>
80102c7a:	83 ec 0c             	sub    $0xc,%esp
80102c7d:	c7 05 c0 26 11 80 01 	movl   $0x1,0x801126c0
80102c84:	00 00 00 
80102c87:	68 80 26 11 80       	push   $0x80112680
80102c8c:	e8 cf 1c 00 00       	call   80104960 <release>
80102c91:	8b 0d c8 26 11 80    	mov    0x801126c8,%ecx
80102c97:	83 c4 10             	add    $0x10,%esp
80102c9a:	85 c9                	test   %ecx,%ecx
80102c9c:	0f 8e 85 00 00 00    	jle    80102d27 <end_op+0xe7>
80102ca2:	a1 b4 26 11 80       	mov    0x801126b4,%eax
80102ca7:	83 ec 08             	sub    $0x8,%esp
80102caa:	01 d8                	add    %ebx,%eax
80102cac:	83 c0 01             	add    $0x1,%eax
80102caf:	50                   	push   %eax
80102cb0:	ff 35 c4 26 11 80    	pushl  0x801126c4
80102cb6:	e8 15 d4 ff ff       	call   801000d0 <bread>
80102cbb:	89 c6                	mov    %eax,%esi
80102cbd:	58                   	pop    %eax
80102cbe:	5a                   	pop    %edx
80102cbf:	ff 34 9d cc 26 11 80 	pushl  -0x7feed934(,%ebx,4)
80102cc6:	ff 35 c4 26 11 80    	pushl  0x801126c4
80102ccc:	83 c3 01             	add    $0x1,%ebx
80102ccf:	e8 fc d3 ff ff       	call   801000d0 <bread>
80102cd4:	89 c7                	mov    %eax,%edi
80102cd6:	8d 40 5c             	lea    0x5c(%eax),%eax
80102cd9:	83 c4 0c             	add    $0xc,%esp
80102cdc:	68 00 02 00 00       	push   $0x200
80102ce1:	50                   	push   %eax
80102ce2:	8d 46 5c             	lea    0x5c(%esi),%eax
80102ce5:	50                   	push   %eax
80102ce6:	e8 75 1d 00 00       	call   80104a60 <memmove>
80102ceb:	89 34 24             	mov    %esi,(%esp)
80102cee:	e8 ad d4 ff ff       	call   801001a0 <bwrite>
80102cf3:	89 3c 24             	mov    %edi,(%esp)
80102cf6:	e8 e5 d4 ff ff       	call   801001e0 <brelse>
80102cfb:	89 34 24             	mov    %esi,(%esp)
80102cfe:	e8 dd d4 ff ff       	call   801001e0 <brelse>
80102d03:	83 c4 10             	add    $0x10,%esp
80102d06:	3b 1d c8 26 11 80    	cmp    0x801126c8,%ebx
80102d0c:	7c 94                	jl     80102ca2 <end_op+0x62>
80102d0e:	e8 bd fd ff ff       	call   80102ad0 <write_head>
80102d13:	e8 18 fd ff ff       	call   80102a30 <install_trans>
80102d18:	c7 05 c8 26 11 80 00 	movl   $0x0,0x801126c8
80102d1f:	00 00 00 
80102d22:	e8 a9 fd ff ff       	call   80102ad0 <write_head>
80102d27:	83 ec 0c             	sub    $0xc,%esp
80102d2a:	68 80 26 11 80       	push   $0x80112680
80102d2f:	e8 6c 1b 00 00       	call   801048a0 <acquire>
80102d34:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
80102d3b:	c7 05 c0 26 11 80 00 	movl   $0x0,0x801126c0
80102d42:	00 00 00 
80102d45:	e8 86 13 00 00       	call   801040d0 <wakeup>
80102d4a:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
80102d51:	e8 0a 1c 00 00       	call   80104960 <release>
80102d56:	83 c4 10             	add    $0x10,%esp
80102d59:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102d5c:	5b                   	pop    %ebx
80102d5d:	5e                   	pop    %esi
80102d5e:	5f                   	pop    %edi
80102d5f:	5d                   	pop    %ebp
80102d60:	c3                   	ret    
80102d61:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102d68:	83 ec 0c             	sub    $0xc,%esp
80102d6b:	68 80 26 11 80       	push   $0x80112680
80102d70:	e8 5b 13 00 00       	call   801040d0 <wakeup>
80102d75:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
80102d7c:	e8 df 1b 00 00       	call   80104960 <release>
80102d81:	83 c4 10             	add    $0x10,%esp
80102d84:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102d87:	5b                   	pop    %ebx
80102d88:	5e                   	pop    %esi
80102d89:	5f                   	pop    %edi
80102d8a:	5d                   	pop    %ebp
80102d8b:	c3                   	ret    
80102d8c:	83 ec 0c             	sub    $0xc,%esp
80102d8f:	68 04 7a 10 80       	push   $0x80107a04
80102d94:	e8 f7 d5 ff ff       	call   80100390 <panic>
80102d99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102da0 <log_write>:
80102da0:	55                   	push   %ebp
80102da1:	89 e5                	mov    %esp,%ebp
80102da3:	53                   	push   %ebx
80102da4:	83 ec 04             	sub    $0x4,%esp
80102da7:	8b 15 c8 26 11 80    	mov    0x801126c8,%edx
80102dad:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102db0:	83 fa 1d             	cmp    $0x1d,%edx
80102db3:	0f 8f 9d 00 00 00    	jg     80102e56 <log_write+0xb6>
80102db9:	a1 b8 26 11 80       	mov    0x801126b8,%eax
80102dbe:	83 e8 01             	sub    $0x1,%eax
80102dc1:	39 c2                	cmp    %eax,%edx
80102dc3:	0f 8d 8d 00 00 00    	jge    80102e56 <log_write+0xb6>
80102dc9:	a1 bc 26 11 80       	mov    0x801126bc,%eax
80102dce:	85 c0                	test   %eax,%eax
80102dd0:	0f 8e 8d 00 00 00    	jle    80102e63 <log_write+0xc3>
80102dd6:	83 ec 0c             	sub    $0xc,%esp
80102dd9:	68 80 26 11 80       	push   $0x80112680
80102dde:	e8 bd 1a 00 00       	call   801048a0 <acquire>
80102de3:	8b 0d c8 26 11 80    	mov    0x801126c8,%ecx
80102de9:	83 c4 10             	add    $0x10,%esp
80102dec:	83 f9 00             	cmp    $0x0,%ecx
80102def:	7e 57                	jle    80102e48 <log_write+0xa8>
80102df1:	8b 53 08             	mov    0x8(%ebx),%edx
80102df4:	31 c0                	xor    %eax,%eax
80102df6:	3b 15 cc 26 11 80    	cmp    0x801126cc,%edx
80102dfc:	75 0b                	jne    80102e09 <log_write+0x69>
80102dfe:	eb 38                	jmp    80102e38 <log_write+0x98>
80102e00:	39 14 85 cc 26 11 80 	cmp    %edx,-0x7feed934(,%eax,4)
80102e07:	74 2f                	je     80102e38 <log_write+0x98>
80102e09:	83 c0 01             	add    $0x1,%eax
80102e0c:	39 c1                	cmp    %eax,%ecx
80102e0e:	75 f0                	jne    80102e00 <log_write+0x60>
80102e10:	89 14 85 cc 26 11 80 	mov    %edx,-0x7feed934(,%eax,4)
80102e17:	83 c0 01             	add    $0x1,%eax
80102e1a:	a3 c8 26 11 80       	mov    %eax,0x801126c8
80102e1f:	83 0b 04             	orl    $0x4,(%ebx)
80102e22:	c7 45 08 80 26 11 80 	movl   $0x80112680,0x8(%ebp)
80102e29:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102e2c:	c9                   	leave  
80102e2d:	e9 2e 1b 00 00       	jmp    80104960 <release>
80102e32:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102e38:	89 14 85 cc 26 11 80 	mov    %edx,-0x7feed934(,%eax,4)
80102e3f:	eb de                	jmp    80102e1f <log_write+0x7f>
80102e41:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102e48:	8b 43 08             	mov    0x8(%ebx),%eax
80102e4b:	a3 cc 26 11 80       	mov    %eax,0x801126cc
80102e50:	75 cd                	jne    80102e1f <log_write+0x7f>
80102e52:	31 c0                	xor    %eax,%eax
80102e54:	eb c1                	jmp    80102e17 <log_write+0x77>
80102e56:	83 ec 0c             	sub    $0xc,%esp
80102e59:	68 13 7a 10 80       	push   $0x80107a13
80102e5e:	e8 2d d5 ff ff       	call   80100390 <panic>
80102e63:	83 ec 0c             	sub    $0xc,%esp
80102e66:	68 29 7a 10 80       	push   $0x80107a29
80102e6b:	e8 20 d5 ff ff       	call   80100390 <panic>

80102e70 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80102e70:	55                   	push   %ebp
80102e71:	89 e5                	mov    %esp,%ebp
80102e73:	53                   	push   %ebx
80102e74:	83 ec 04             	sub    $0x4,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
80102e77:	e8 74 0a 00 00       	call   801038f0 <cpuid>
80102e7c:	89 c3                	mov    %eax,%ebx
80102e7e:	e8 6d 0a 00 00       	call   801038f0 <cpuid>
80102e83:	83 ec 04             	sub    $0x4,%esp
80102e86:	53                   	push   %ebx
80102e87:	50                   	push   %eax
80102e88:	68 44 7a 10 80       	push   $0x80107a44
80102e8d:	e8 ce d7 ff ff       	call   80100660 <cprintf>
  idtinit();       // load idt register
80102e92:	e8 89 2e 00 00       	call   80105d20 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
80102e97:	e8 d4 09 00 00       	call   80103870 <mycpu>
80102e9c:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80102e9e:	b8 01 00 00 00       	mov    $0x1,%eax
80102ea3:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
80102eaa:	e8 81 0d 00 00       	call   80103c30 <scheduler>
80102eaf:	90                   	nop

80102eb0 <mpenter>:
{
80102eb0:	55                   	push   %ebp
80102eb1:	89 e5                	mov    %esp,%ebp
80102eb3:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80102eb6:	e8 a5 3f 00 00       	call   80106e60 <switchkvm>
  seginit();
80102ebb:	e8 10 3f 00 00       	call   80106dd0 <seginit>
  lapicinit();
80102ec0:	e8 9b f7 ff ff       	call   80102660 <lapicinit>
  mpmain();
80102ec5:	e8 a6 ff ff ff       	call   80102e70 <mpmain>
80102eca:	66 90                	xchg   %ax,%ax
80102ecc:	66 90                	xchg   %ax,%ax
80102ece:	66 90                	xchg   %ax,%ax

80102ed0 <main>:
{
80102ed0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80102ed4:	83 e4 f0             	and    $0xfffffff0,%esp
80102ed7:	ff 71 fc             	pushl  -0x4(%ecx)
80102eda:	55                   	push   %ebp
80102edb:	89 e5                	mov    %esp,%ebp
80102edd:	53                   	push   %ebx
80102ede:	51                   	push   %ecx
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
80102edf:	83 ec 08             	sub    $0x8,%esp
80102ee2:	68 00 00 40 80       	push   $0x80400000
80102ee7:	68 a8 9a 11 80       	push   $0x80119aa8
80102eec:	e8 2f f5 ff ff       	call   80102420 <kinit1>
  kvmalloc();      // kernel page table
80102ef1:	e8 3a 44 00 00       	call   80107330 <kvmalloc>
  mpinit();        // detect other processors
80102ef6:	e8 75 01 00 00       	call   80103070 <mpinit>
  lapicinit();     // interrupt controller
80102efb:	e8 60 f7 ff ff       	call   80102660 <lapicinit>
  seginit();       // segment descriptors
80102f00:	e8 cb 3e 00 00       	call   80106dd0 <seginit>
  picinit();       // disable pic
80102f05:	e8 46 03 00 00       	call   80103250 <picinit>
  ioapicinit();    // another interrupt controller
80102f0a:	e8 41 f3 ff ff       	call   80102250 <ioapicinit>
  consoleinit();   // console hardware
80102f0f:	e8 ac da ff ff       	call   801009c0 <consoleinit>
  uartinit();      // serial port
80102f14:	e8 87 31 00 00       	call   801060a0 <uartinit>
  pinit();         // process table
80102f19:	e8 32 09 00 00       	call   80103850 <pinit>
  tvinit();        // trap vectors
80102f1e:	e8 7d 2d 00 00       	call   80105ca0 <tvinit>
  binit();         // buffer cache
80102f23:	e8 18 d1 ff ff       	call   80100040 <binit>
  fileinit();      // file table
80102f28:	e8 63 de ff ff       	call   80100d90 <fileinit>
  ideinit();       // disk 
80102f2d:	e8 fe f0 ff ff       	call   80102030 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80102f32:	83 c4 0c             	add    $0xc,%esp
80102f35:	68 8a 00 00 00       	push   $0x8a
80102f3a:	68 8c a4 10 80       	push   $0x8010a48c
80102f3f:	68 00 70 00 80       	push   $0x80007000
80102f44:	e8 17 1b 00 00       	call   80104a60 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
80102f49:	69 05 00 2d 11 80 b0 	imul   $0xb0,0x80112d00,%eax
80102f50:	00 00 00 
80102f53:	83 c4 10             	add    $0x10,%esp
80102f56:	05 80 27 11 80       	add    $0x80112780,%eax
80102f5b:	3d 80 27 11 80       	cmp    $0x80112780,%eax
80102f60:	76 71                	jbe    80102fd3 <main+0x103>
80102f62:	bb 80 27 11 80       	mov    $0x80112780,%ebx
80102f67:	89 f6                	mov    %esi,%esi
80102f69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(c == mycpu())  // We've started already.
80102f70:	e8 fb 08 00 00       	call   80103870 <mycpu>
80102f75:	39 d8                	cmp    %ebx,%eax
80102f77:	74 41                	je     80102fba <main+0xea>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80102f79:	e8 72 f5 ff ff       	call   801024f0 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
80102f7e:	05 00 10 00 00       	add    $0x1000,%eax
    *(void(**)(void))(code-8) = mpenter;
80102f83:	c7 05 f8 6f 00 80 b0 	movl   $0x80102eb0,0x80006ff8
80102f8a:	2e 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
80102f8d:	c7 05 f4 6f 00 80 00 	movl   $0x109000,0x80006ff4
80102f94:	90 10 00 
    *(void**)(code-4) = stack + KSTACKSIZE;
80102f97:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc

    lapicstartap(c->apicid, V2P(code));
80102f9c:	0f b6 03             	movzbl (%ebx),%eax
80102f9f:	83 ec 08             	sub    $0x8,%esp
80102fa2:	68 00 70 00 00       	push   $0x7000
80102fa7:	50                   	push   %eax
80102fa8:	e8 03 f8 ff ff       	call   801027b0 <lapicstartap>
80102fad:	83 c4 10             	add    $0x10,%esp

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80102fb0:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80102fb6:	85 c0                	test   %eax,%eax
80102fb8:	74 f6                	je     80102fb0 <main+0xe0>
  for(c = cpus; c < cpus+ncpu; c++){
80102fba:	69 05 00 2d 11 80 b0 	imul   $0xb0,0x80112d00,%eax
80102fc1:	00 00 00 
80102fc4:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
80102fca:	05 80 27 11 80       	add    $0x80112780,%eax
80102fcf:	39 c3                	cmp    %eax,%ebx
80102fd1:	72 9d                	jb     80102f70 <main+0xa0>
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80102fd3:	83 ec 08             	sub    $0x8,%esp
80102fd6:	68 00 00 00 8e       	push   $0x8e000000
80102fdb:	68 00 00 40 80       	push   $0x80400000
80102fe0:	e8 ab f4 ff ff       	call   80102490 <kinit2>
  userinit();      // first user process
80102fe5:	e8 86 09 00 00       	call   80103970 <userinit>
  mpmain();        // finish this processor's setup
80102fea:	e8 81 fe ff ff       	call   80102e70 <mpmain>
80102fef:	90                   	nop

80102ff0 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80102ff0:	55                   	push   %ebp
80102ff1:	89 e5                	mov    %esp,%ebp
80102ff3:	57                   	push   %edi
80102ff4:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
80102ff5:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
{
80102ffb:	53                   	push   %ebx
  e = addr+len;
80102ffc:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
{
80102fff:	83 ec 0c             	sub    $0xc,%esp
  for(p = addr; p < e; p += sizeof(struct mp))
80103002:	39 de                	cmp    %ebx,%esi
80103004:	72 10                	jb     80103016 <mpsearch1+0x26>
80103006:	eb 50                	jmp    80103058 <mpsearch1+0x68>
80103008:	90                   	nop
80103009:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103010:	39 fb                	cmp    %edi,%ebx
80103012:	89 fe                	mov    %edi,%esi
80103014:	76 42                	jbe    80103058 <mpsearch1+0x68>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103016:	83 ec 04             	sub    $0x4,%esp
80103019:	8d 7e 10             	lea    0x10(%esi),%edi
8010301c:	6a 04                	push   $0x4
8010301e:	68 58 7a 10 80       	push   $0x80107a58
80103023:	56                   	push   %esi
80103024:	e8 d7 19 00 00       	call   80104a00 <memcmp>
80103029:	83 c4 10             	add    $0x10,%esp
8010302c:	85 c0                	test   %eax,%eax
8010302e:	75 e0                	jne    80103010 <mpsearch1+0x20>
80103030:	89 f1                	mov    %esi,%ecx
80103032:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    sum += addr[i];
80103038:	0f b6 11             	movzbl (%ecx),%edx
8010303b:	83 c1 01             	add    $0x1,%ecx
8010303e:	01 d0                	add    %edx,%eax
  for(i=0; i<len; i++)
80103040:	39 f9                	cmp    %edi,%ecx
80103042:	75 f4                	jne    80103038 <mpsearch1+0x48>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103044:	84 c0                	test   %al,%al
80103046:	75 c8                	jne    80103010 <mpsearch1+0x20>
      return (struct mp*)p;
  return 0;
}
80103048:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010304b:	89 f0                	mov    %esi,%eax
8010304d:	5b                   	pop    %ebx
8010304e:	5e                   	pop    %esi
8010304f:	5f                   	pop    %edi
80103050:	5d                   	pop    %ebp
80103051:	c3                   	ret    
80103052:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103058:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010305b:	31 f6                	xor    %esi,%esi
}
8010305d:	89 f0                	mov    %esi,%eax
8010305f:	5b                   	pop    %ebx
80103060:	5e                   	pop    %esi
80103061:	5f                   	pop    %edi
80103062:	5d                   	pop    %ebp
80103063:	c3                   	ret    
80103064:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010306a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103070 <mpinit>:
  return conf;
}

void
mpinit(void)
{
80103070:	55                   	push   %ebp
80103071:	89 e5                	mov    %esp,%ebp
80103073:	57                   	push   %edi
80103074:	56                   	push   %esi
80103075:	53                   	push   %ebx
80103076:	83 ec 1c             	sub    $0x1c,%esp
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80103079:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80103080:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
80103087:	c1 e0 08             	shl    $0x8,%eax
8010308a:	09 d0                	or     %edx,%eax
8010308c:	c1 e0 04             	shl    $0x4,%eax
8010308f:	85 c0                	test   %eax,%eax
80103091:	75 1b                	jne    801030ae <mpinit+0x3e>
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80103093:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
8010309a:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
801030a1:	c1 e0 08             	shl    $0x8,%eax
801030a4:	09 d0                	or     %edx,%eax
801030a6:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
801030a9:	2d 00 04 00 00       	sub    $0x400,%eax
    if((mp = mpsearch1(p, 1024)))
801030ae:	ba 00 04 00 00       	mov    $0x400,%edx
801030b3:	e8 38 ff ff ff       	call   80102ff0 <mpsearch1>
801030b8:	85 c0                	test   %eax,%eax
801030ba:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801030bd:	0f 84 3d 01 00 00    	je     80103200 <mpinit+0x190>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801030c3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801030c6:	8b 58 04             	mov    0x4(%eax),%ebx
801030c9:	85 db                	test   %ebx,%ebx
801030cb:	0f 84 4f 01 00 00    	je     80103220 <mpinit+0x1b0>
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
801030d1:	8d b3 00 00 00 80    	lea    -0x80000000(%ebx),%esi
  if(memcmp(conf, "PCMP", 4) != 0)
801030d7:	83 ec 04             	sub    $0x4,%esp
801030da:	6a 04                	push   $0x4
801030dc:	68 75 7a 10 80       	push   $0x80107a75
801030e1:	56                   	push   %esi
801030e2:	e8 19 19 00 00       	call   80104a00 <memcmp>
801030e7:	83 c4 10             	add    $0x10,%esp
801030ea:	85 c0                	test   %eax,%eax
801030ec:	0f 85 2e 01 00 00    	jne    80103220 <mpinit+0x1b0>
  if(conf->version != 1 && conf->version != 4)
801030f2:	0f b6 83 06 00 00 80 	movzbl -0x7ffffffa(%ebx),%eax
801030f9:	3c 01                	cmp    $0x1,%al
801030fb:	0f 95 c2             	setne  %dl
801030fe:	3c 04                	cmp    $0x4,%al
80103100:	0f 95 c0             	setne  %al
80103103:	20 c2                	and    %al,%dl
80103105:	0f 85 15 01 00 00    	jne    80103220 <mpinit+0x1b0>
  if(sum((uchar*)conf, conf->length) != 0)
8010310b:	0f b7 bb 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edi
  for(i=0; i<len; i++)
80103112:	66 85 ff             	test   %di,%di
80103115:	74 1a                	je     80103131 <mpinit+0xc1>
80103117:	89 f0                	mov    %esi,%eax
80103119:	01 f7                	add    %esi,%edi
  sum = 0;
8010311b:	31 d2                	xor    %edx,%edx
8010311d:	8d 76 00             	lea    0x0(%esi),%esi
    sum += addr[i];
80103120:	0f b6 08             	movzbl (%eax),%ecx
80103123:	83 c0 01             	add    $0x1,%eax
80103126:	01 ca                	add    %ecx,%edx
  for(i=0; i<len; i++)
80103128:	39 c7                	cmp    %eax,%edi
8010312a:	75 f4                	jne    80103120 <mpinit+0xb0>
8010312c:	84 d2                	test   %dl,%dl
8010312e:	0f 95 c2             	setne  %dl
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
80103131:	85 f6                	test   %esi,%esi
80103133:	0f 84 e7 00 00 00    	je     80103220 <mpinit+0x1b0>
80103139:	84 d2                	test   %dl,%dl
8010313b:	0f 85 df 00 00 00    	jne    80103220 <mpinit+0x1b0>
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
80103141:	8b 83 24 00 00 80    	mov    -0x7fffffdc(%ebx),%eax
80103147:	a3 7c 26 11 80       	mov    %eax,0x8011267c
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
8010314c:	0f b7 93 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edx
80103153:	8d 83 2c 00 00 80    	lea    -0x7fffffd4(%ebx),%eax
  ismp = 1;
80103159:	bb 01 00 00 00       	mov    $0x1,%ebx
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
8010315e:	01 d6                	add    %edx,%esi
80103160:	39 c6                	cmp    %eax,%esi
80103162:	76 23                	jbe    80103187 <mpinit+0x117>
    switch(*p){
80103164:	0f b6 10             	movzbl (%eax),%edx
80103167:	80 fa 04             	cmp    $0x4,%dl
8010316a:	0f 87 ca 00 00 00    	ja     8010323a <mpinit+0x1ca>
80103170:	ff 24 95 9c 7a 10 80 	jmp    *-0x7fef8564(,%edx,4)
80103177:	89 f6                	mov    %esi,%esi
80103179:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
80103180:	83 c0 08             	add    $0x8,%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103183:	39 c6                	cmp    %eax,%esi
80103185:	77 dd                	ja     80103164 <mpinit+0xf4>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
80103187:	85 db                	test   %ebx,%ebx
80103189:	0f 84 9e 00 00 00    	je     8010322d <mpinit+0x1bd>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
8010318f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103192:	80 78 0c 00          	cmpb   $0x0,0xc(%eax)
80103196:	74 15                	je     801031ad <mpinit+0x13d>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103198:	b8 70 00 00 00       	mov    $0x70,%eax
8010319d:	ba 22 00 00 00       	mov    $0x22,%edx
801031a2:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801031a3:	ba 23 00 00 00       	mov    $0x23,%edx
801031a8:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
801031a9:	83 c8 01             	or     $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801031ac:	ee                   	out    %al,(%dx)
  }
}
801031ad:	8d 65 f4             	lea    -0xc(%ebp),%esp
801031b0:	5b                   	pop    %ebx
801031b1:	5e                   	pop    %esi
801031b2:	5f                   	pop    %edi
801031b3:	5d                   	pop    %ebp
801031b4:	c3                   	ret    
801031b5:	8d 76 00             	lea    0x0(%esi),%esi
      if(ncpu < NCPU) {
801031b8:	8b 0d 00 2d 11 80    	mov    0x80112d00,%ecx
801031be:	83 f9 07             	cmp    $0x7,%ecx
801031c1:	7f 19                	jg     801031dc <mpinit+0x16c>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
801031c3:	0f b6 50 01          	movzbl 0x1(%eax),%edx
801031c7:	69 f9 b0 00 00 00    	imul   $0xb0,%ecx,%edi
        ncpu++;
801031cd:	83 c1 01             	add    $0x1,%ecx
801031d0:	89 0d 00 2d 11 80    	mov    %ecx,0x80112d00
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
801031d6:	88 97 80 27 11 80    	mov    %dl,-0x7feed880(%edi)
      p += sizeof(struct mpproc);
801031dc:	83 c0 14             	add    $0x14,%eax
      continue;
801031df:	e9 7c ff ff ff       	jmp    80103160 <mpinit+0xf0>
801031e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      ioapicid = ioapic->apicno;
801031e8:	0f b6 50 01          	movzbl 0x1(%eax),%edx
      p += sizeof(struct mpioapic);
801031ec:	83 c0 08             	add    $0x8,%eax
      ioapicid = ioapic->apicno;
801031ef:	88 15 60 27 11 80    	mov    %dl,0x80112760
      continue;
801031f5:	e9 66 ff ff ff       	jmp    80103160 <mpinit+0xf0>
801031fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return mpsearch1(0xF0000, 0x10000);
80103200:	ba 00 00 01 00       	mov    $0x10000,%edx
80103205:	b8 00 00 0f 00       	mov    $0xf0000,%eax
8010320a:	e8 e1 fd ff ff       	call   80102ff0 <mpsearch1>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
8010320f:	85 c0                	test   %eax,%eax
  return mpsearch1(0xF0000, 0x10000);
80103211:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103214:	0f 85 a9 fe ff ff    	jne    801030c3 <mpinit+0x53>
8010321a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    panic("Expect to run on an SMP");
80103220:	83 ec 0c             	sub    $0xc,%esp
80103223:	68 5d 7a 10 80       	push   $0x80107a5d
80103228:	e8 63 d1 ff ff       	call   80100390 <panic>
    panic("Didn't find a suitable machine");
8010322d:	83 ec 0c             	sub    $0xc,%esp
80103230:	68 7c 7a 10 80       	push   $0x80107a7c
80103235:	e8 56 d1 ff ff       	call   80100390 <panic>
      ismp = 0;
8010323a:	31 db                	xor    %ebx,%ebx
8010323c:	e9 26 ff ff ff       	jmp    80103167 <mpinit+0xf7>
80103241:	66 90                	xchg   %ax,%ax
80103243:	66 90                	xchg   %ax,%ax
80103245:	66 90                	xchg   %ax,%ax
80103247:	66 90                	xchg   %ax,%ax
80103249:	66 90                	xchg   %ax,%ax
8010324b:	66 90                	xchg   %ax,%ax
8010324d:	66 90                	xchg   %ax,%ax
8010324f:	90                   	nop

80103250 <picinit>:
#define IO_PIC2         0xA0    // Slave (IRQs 8-15)

// Don't use the 8259A interrupt controllers.  Xv6 assumes SMP hardware.
void
picinit(void)
{
80103250:	55                   	push   %ebp
80103251:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103256:	ba 21 00 00 00       	mov    $0x21,%edx
8010325b:	89 e5                	mov    %esp,%ebp
8010325d:	ee                   	out    %al,(%dx)
8010325e:	ba a1 00 00 00       	mov    $0xa1,%edx
80103263:	ee                   	out    %al,(%dx)
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
80103264:	5d                   	pop    %ebp
80103265:	c3                   	ret    
80103266:	66 90                	xchg   %ax,%ax
80103268:	66 90                	xchg   %ax,%ax
8010326a:	66 90                	xchg   %ax,%ax
8010326c:	66 90                	xchg   %ax,%ax
8010326e:	66 90                	xchg   %ax,%ax

80103270 <pipealloc>:
80103270:	55                   	push   %ebp
80103271:	89 e5                	mov    %esp,%ebp
80103273:	57                   	push   %edi
80103274:	56                   	push   %esi
80103275:	53                   	push   %ebx
80103276:	83 ec 0c             	sub    $0xc,%esp
80103279:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010327c:	8b 75 0c             	mov    0xc(%ebp),%esi
8010327f:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80103285:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
8010328b:	e8 20 db ff ff       	call   80100db0 <filealloc>
80103290:	85 c0                	test   %eax,%eax
80103292:	89 03                	mov    %eax,(%ebx)
80103294:	74 22                	je     801032b8 <pipealloc+0x48>
80103296:	e8 15 db ff ff       	call   80100db0 <filealloc>
8010329b:	85 c0                	test   %eax,%eax
8010329d:	89 06                	mov    %eax,(%esi)
8010329f:	74 3f                	je     801032e0 <pipealloc+0x70>
801032a1:	e8 4a f2 ff ff       	call   801024f0 <kalloc>
801032a6:	85 c0                	test   %eax,%eax
801032a8:	89 c7                	mov    %eax,%edi
801032aa:	75 54                	jne    80103300 <pipealloc+0x90>
801032ac:	8b 03                	mov    (%ebx),%eax
801032ae:	85 c0                	test   %eax,%eax
801032b0:	75 34                	jne    801032e6 <pipealloc+0x76>
801032b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801032b8:	8b 06                	mov    (%esi),%eax
801032ba:	85 c0                	test   %eax,%eax
801032bc:	74 0c                	je     801032ca <pipealloc+0x5a>
801032be:	83 ec 0c             	sub    $0xc,%esp
801032c1:	50                   	push   %eax
801032c2:	e8 a9 db ff ff       	call   80100e70 <fileclose>
801032c7:	83 c4 10             	add    $0x10,%esp
801032ca:	8d 65 f4             	lea    -0xc(%ebp),%esp
801032cd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801032d2:	5b                   	pop    %ebx
801032d3:	5e                   	pop    %esi
801032d4:	5f                   	pop    %edi
801032d5:	5d                   	pop    %ebp
801032d6:	c3                   	ret    
801032d7:	89 f6                	mov    %esi,%esi
801032d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801032e0:	8b 03                	mov    (%ebx),%eax
801032e2:	85 c0                	test   %eax,%eax
801032e4:	74 e4                	je     801032ca <pipealloc+0x5a>
801032e6:	83 ec 0c             	sub    $0xc,%esp
801032e9:	50                   	push   %eax
801032ea:	e8 81 db ff ff       	call   80100e70 <fileclose>
801032ef:	8b 06                	mov    (%esi),%eax
801032f1:	83 c4 10             	add    $0x10,%esp
801032f4:	85 c0                	test   %eax,%eax
801032f6:	75 c6                	jne    801032be <pipealloc+0x4e>
801032f8:	eb d0                	jmp    801032ca <pipealloc+0x5a>
801032fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103300:	83 ec 08             	sub    $0x8,%esp
80103303:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
8010330a:	00 00 00 
8010330d:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
80103314:	00 00 00 
80103317:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
8010331e:	00 00 00 
80103321:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80103328:	00 00 00 
8010332b:	68 b0 7a 10 80       	push   $0x80107ab0
80103330:	50                   	push   %eax
80103331:	e8 2a 14 00 00       	call   80104760 <initlock>
80103336:	8b 03                	mov    (%ebx),%eax
80103338:	83 c4 10             	add    $0x10,%esp
8010333b:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
80103341:	8b 03                	mov    (%ebx),%eax
80103343:	c6 40 08 01          	movb   $0x1,0x8(%eax)
80103347:	8b 03                	mov    (%ebx),%eax
80103349:	c6 40 09 00          	movb   $0x0,0x9(%eax)
8010334d:	8b 03                	mov    (%ebx),%eax
8010334f:	89 78 0c             	mov    %edi,0xc(%eax)
80103352:	8b 06                	mov    (%esi),%eax
80103354:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
8010335a:	8b 06                	mov    (%esi),%eax
8010335c:	c6 40 08 00          	movb   $0x0,0x8(%eax)
80103360:	8b 06                	mov    (%esi),%eax
80103362:	c6 40 09 01          	movb   $0x1,0x9(%eax)
80103366:	8b 06                	mov    (%esi),%eax
80103368:	89 78 0c             	mov    %edi,0xc(%eax)
8010336b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010336e:	31 c0                	xor    %eax,%eax
80103370:	5b                   	pop    %ebx
80103371:	5e                   	pop    %esi
80103372:	5f                   	pop    %edi
80103373:	5d                   	pop    %ebp
80103374:	c3                   	ret    
80103375:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103379:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103380 <pipeclose>:
80103380:	55                   	push   %ebp
80103381:	89 e5                	mov    %esp,%ebp
80103383:	56                   	push   %esi
80103384:	53                   	push   %ebx
80103385:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103388:	8b 75 0c             	mov    0xc(%ebp),%esi
8010338b:	83 ec 0c             	sub    $0xc,%esp
8010338e:	53                   	push   %ebx
8010338f:	e8 0c 15 00 00       	call   801048a0 <acquire>
80103394:	83 c4 10             	add    $0x10,%esp
80103397:	85 f6                	test   %esi,%esi
80103399:	74 45                	je     801033e0 <pipeclose+0x60>
8010339b:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
801033a1:	83 ec 0c             	sub    $0xc,%esp
801033a4:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
801033ab:	00 00 00 
801033ae:	50                   	push   %eax
801033af:	e8 1c 0d 00 00       	call   801040d0 <wakeup>
801033b4:	83 c4 10             	add    $0x10,%esp
801033b7:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
801033bd:	85 d2                	test   %edx,%edx
801033bf:	75 0a                	jne    801033cb <pipeclose+0x4b>
801033c1:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
801033c7:	85 c0                	test   %eax,%eax
801033c9:	74 35                	je     80103400 <pipeclose+0x80>
801033cb:	89 5d 08             	mov    %ebx,0x8(%ebp)
801033ce:	8d 65 f8             	lea    -0x8(%ebp),%esp
801033d1:	5b                   	pop    %ebx
801033d2:	5e                   	pop    %esi
801033d3:	5d                   	pop    %ebp
801033d4:	e9 87 15 00 00       	jmp    80104960 <release>
801033d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801033e0:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
801033e6:	83 ec 0c             	sub    $0xc,%esp
801033e9:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
801033f0:	00 00 00 
801033f3:	50                   	push   %eax
801033f4:	e8 d7 0c 00 00       	call   801040d0 <wakeup>
801033f9:	83 c4 10             	add    $0x10,%esp
801033fc:	eb b9                	jmp    801033b7 <pipeclose+0x37>
801033fe:	66 90                	xchg   %ax,%ax
80103400:	83 ec 0c             	sub    $0xc,%esp
80103403:	53                   	push   %ebx
80103404:	e8 57 15 00 00       	call   80104960 <release>
80103409:	89 5d 08             	mov    %ebx,0x8(%ebp)
8010340c:	83 c4 10             	add    $0x10,%esp
8010340f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103412:	5b                   	pop    %ebx
80103413:	5e                   	pop    %esi
80103414:	5d                   	pop    %ebp
80103415:	e9 26 ef ff ff       	jmp    80102340 <kfree>
8010341a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103420 <pipewrite>:
80103420:	55                   	push   %ebp
80103421:	89 e5                	mov    %esp,%ebp
80103423:	57                   	push   %edi
80103424:	56                   	push   %esi
80103425:	53                   	push   %ebx
80103426:	83 ec 28             	sub    $0x28,%esp
80103429:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010342c:	53                   	push   %ebx
8010342d:	e8 6e 14 00 00       	call   801048a0 <acquire>
80103432:	8b 45 10             	mov    0x10(%ebp),%eax
80103435:	83 c4 10             	add    $0x10,%esp
80103438:	85 c0                	test   %eax,%eax
8010343a:	0f 8e c9 00 00 00    	jle    80103509 <pipewrite+0xe9>
80103440:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80103443:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
80103449:	8d bb 34 02 00 00    	lea    0x234(%ebx),%edi
8010344f:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80103452:	03 4d 10             	add    0x10(%ebp),%ecx
80103455:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80103458:	8b 8b 34 02 00 00    	mov    0x234(%ebx),%ecx
8010345e:	8d 91 00 02 00 00    	lea    0x200(%ecx),%edx
80103464:	39 d0                	cmp    %edx,%eax
80103466:	75 71                	jne    801034d9 <pipewrite+0xb9>
80103468:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
8010346e:	85 c0                	test   %eax,%eax
80103470:	74 4e                	je     801034c0 <pipewrite+0xa0>
80103472:	8d b3 38 02 00 00    	lea    0x238(%ebx),%esi
80103478:	eb 3a                	jmp    801034b4 <pipewrite+0x94>
8010347a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103480:	83 ec 0c             	sub    $0xc,%esp
80103483:	57                   	push   %edi
80103484:	e8 47 0c 00 00       	call   801040d0 <wakeup>
80103489:	5a                   	pop    %edx
8010348a:	59                   	pop    %ecx
8010348b:	53                   	push   %ebx
8010348c:	56                   	push   %esi
8010348d:	e8 8e 0a 00 00       	call   80103f20 <sleep>
80103492:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
80103498:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
8010349e:	83 c4 10             	add    $0x10,%esp
801034a1:	05 00 02 00 00       	add    $0x200,%eax
801034a6:	39 c2                	cmp    %eax,%edx
801034a8:	75 36                	jne    801034e0 <pipewrite+0xc0>
801034aa:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
801034b0:	85 c0                	test   %eax,%eax
801034b2:	74 0c                	je     801034c0 <pipewrite+0xa0>
801034b4:	e8 57 04 00 00       	call   80103910 <myproc>
801034b9:	8b 40 24             	mov    0x24(%eax),%eax
801034bc:	85 c0                	test   %eax,%eax
801034be:	74 c0                	je     80103480 <pipewrite+0x60>
801034c0:	83 ec 0c             	sub    $0xc,%esp
801034c3:	53                   	push   %ebx
801034c4:	e8 97 14 00 00       	call   80104960 <release>
801034c9:	83 c4 10             	add    $0x10,%esp
801034cc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801034d1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801034d4:	5b                   	pop    %ebx
801034d5:	5e                   	pop    %esi
801034d6:	5f                   	pop    %edi
801034d7:	5d                   	pop    %ebp
801034d8:	c3                   	ret    
801034d9:	89 c2                	mov    %eax,%edx
801034db:	90                   	nop
801034dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801034e0:	8b 75 e4             	mov    -0x1c(%ebp),%esi
801034e3:	8d 42 01             	lea    0x1(%edx),%eax
801034e6:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
801034ec:	89 83 38 02 00 00    	mov    %eax,0x238(%ebx)
801034f2:	83 c6 01             	add    $0x1,%esi
801034f5:	0f b6 4e ff          	movzbl -0x1(%esi),%ecx
801034f9:	3b 75 e0             	cmp    -0x20(%ebp),%esi
801034fc:	89 75 e4             	mov    %esi,-0x1c(%ebp)
801034ff:	88 4c 13 34          	mov    %cl,0x34(%ebx,%edx,1)
80103503:	0f 85 4f ff ff ff    	jne    80103458 <pipewrite+0x38>
80103509:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
8010350f:	83 ec 0c             	sub    $0xc,%esp
80103512:	50                   	push   %eax
80103513:	e8 b8 0b 00 00       	call   801040d0 <wakeup>
80103518:	89 1c 24             	mov    %ebx,(%esp)
8010351b:	e8 40 14 00 00       	call   80104960 <release>
80103520:	83 c4 10             	add    $0x10,%esp
80103523:	8b 45 10             	mov    0x10(%ebp),%eax
80103526:	eb a9                	jmp    801034d1 <pipewrite+0xb1>
80103528:	90                   	nop
80103529:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103530 <piperead>:
80103530:	55                   	push   %ebp
80103531:	89 e5                	mov    %esp,%ebp
80103533:	57                   	push   %edi
80103534:	56                   	push   %esi
80103535:	53                   	push   %ebx
80103536:	83 ec 18             	sub    $0x18,%esp
80103539:	8b 75 08             	mov    0x8(%ebp),%esi
8010353c:	8b 7d 0c             	mov    0xc(%ebp),%edi
8010353f:	56                   	push   %esi
80103540:	e8 5b 13 00 00       	call   801048a0 <acquire>
80103545:	83 c4 10             	add    $0x10,%esp
80103548:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
8010354e:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
80103554:	75 6a                	jne    801035c0 <piperead+0x90>
80103556:	8b 9e 40 02 00 00    	mov    0x240(%esi),%ebx
8010355c:	85 db                	test   %ebx,%ebx
8010355e:	0f 84 c4 00 00 00    	je     80103628 <piperead+0xf8>
80103564:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
8010356a:	eb 2d                	jmp    80103599 <piperead+0x69>
8010356c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103570:	83 ec 08             	sub    $0x8,%esp
80103573:	56                   	push   %esi
80103574:	53                   	push   %ebx
80103575:	e8 a6 09 00 00       	call   80103f20 <sleep>
8010357a:	83 c4 10             	add    $0x10,%esp
8010357d:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
80103583:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
80103589:	75 35                	jne    801035c0 <piperead+0x90>
8010358b:	8b 96 40 02 00 00    	mov    0x240(%esi),%edx
80103591:	85 d2                	test   %edx,%edx
80103593:	0f 84 8f 00 00 00    	je     80103628 <piperead+0xf8>
80103599:	e8 72 03 00 00       	call   80103910 <myproc>
8010359e:	8b 48 24             	mov    0x24(%eax),%ecx
801035a1:	85 c9                	test   %ecx,%ecx
801035a3:	74 cb                	je     80103570 <piperead+0x40>
801035a5:	83 ec 0c             	sub    $0xc,%esp
801035a8:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801035ad:	56                   	push   %esi
801035ae:	e8 ad 13 00 00       	call   80104960 <release>
801035b3:	83 c4 10             	add    $0x10,%esp
801035b6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801035b9:	89 d8                	mov    %ebx,%eax
801035bb:	5b                   	pop    %ebx
801035bc:	5e                   	pop    %esi
801035bd:	5f                   	pop    %edi
801035be:	5d                   	pop    %ebp
801035bf:	c3                   	ret    
801035c0:	8b 45 10             	mov    0x10(%ebp),%eax
801035c3:	85 c0                	test   %eax,%eax
801035c5:	7e 61                	jle    80103628 <piperead+0xf8>
801035c7:	31 db                	xor    %ebx,%ebx
801035c9:	eb 13                	jmp    801035de <piperead+0xae>
801035cb:	90                   	nop
801035cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801035d0:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
801035d6:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
801035dc:	74 1f                	je     801035fd <piperead+0xcd>
801035de:	8d 41 01             	lea    0x1(%ecx),%eax
801035e1:	81 e1 ff 01 00 00    	and    $0x1ff,%ecx
801035e7:	89 86 34 02 00 00    	mov    %eax,0x234(%esi)
801035ed:	0f b6 44 0e 34       	movzbl 0x34(%esi,%ecx,1),%eax
801035f2:	88 04 1f             	mov    %al,(%edi,%ebx,1)
801035f5:	83 c3 01             	add    $0x1,%ebx
801035f8:	39 5d 10             	cmp    %ebx,0x10(%ebp)
801035fb:	75 d3                	jne    801035d0 <piperead+0xa0>
801035fd:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
80103603:	83 ec 0c             	sub    $0xc,%esp
80103606:	50                   	push   %eax
80103607:	e8 c4 0a 00 00       	call   801040d0 <wakeup>
8010360c:	89 34 24             	mov    %esi,(%esp)
8010360f:	e8 4c 13 00 00       	call   80104960 <release>
80103614:	83 c4 10             	add    $0x10,%esp
80103617:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010361a:	89 d8                	mov    %ebx,%eax
8010361c:	5b                   	pop    %ebx
8010361d:	5e                   	pop    %esi
8010361e:	5f                   	pop    %edi
8010361f:	5d                   	pop    %ebp
80103620:	c3                   	ret    
80103621:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103628:	31 db                	xor    %ebx,%ebx
8010362a:	eb d1                	jmp    801035fd <piperead+0xcd>
8010362c:	66 90                	xchg   %ax,%ax
8010362e:	66 90                	xchg   %ax,%ax

80103630 <wakeup1>:
//PAGEBREAK!
// Wake up all processes sleeping on chan.
// The ptable lock must be held.
static void
wakeup1(void *chan)
{
80103630:	55                   	push   %ebp
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103631:	ba 54 2d 11 80       	mov    $0x80112d54,%edx
{
80103636:	89 e5                	mov    %esp,%ebp
80103638:	57                   	push   %edi
80103639:	56                   	push   %esi
8010363a:	53                   	push   %ebx

static inline int cas (volatile void * addr, int expected, int newval)
{
  
  int ret;
  asm volatile("movl %2 , %%eax\n\t"
8010363b:	bf 02 00 00 00       	mov    $0x2,%edi
80103640:	be 03 00 00 00       	mov    $0x3,%esi
80103645:	83 ec 04             	sub    $0x4,%esp
80103648:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010364b:	eb 16                	jmp    80103663 <wakeup1+0x33>
8010364d:	8d 76 00             	lea    0x0(%esi),%esi
    if((p->state == SLEEPING || p->state == -SLEEPING) && p->chan == chan){
80103650:	83 f8 fe             	cmp    $0xfffffffe,%eax
80103653:	74 16                	je     8010366b <wakeup1+0x3b>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103655:	81 c2 94 01 00 00    	add    $0x194,%edx
8010365b:	81 fa 54 92 11 80    	cmp    $0x80119254,%edx
80103661:	73 3d                	jae    801036a0 <wakeup1+0x70>
    if((p->state == SLEEPING || p->state == -SLEEPING) && p->chan == chan){
80103663:	8b 42 0c             	mov    0xc(%edx),%eax
80103666:	83 f8 02             	cmp    $0x2,%eax
80103669:	75 e5                	jne    80103650 <wakeup1+0x20>
8010366b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010366e:	39 42 20             	cmp    %eax,0x20(%edx)
80103671:	75 e2                	jne    80103655 <wakeup1+0x25>
80103673:	8d 5a 0c             	lea    0xc(%edx),%ebx
80103676:	8d 76 00             	lea    0x0(%esi),%esi
80103679:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80103680:	89 f8                	mov    %edi,%eax
80103682:	f0 0f b1 33          	lock cmpxchg %esi,(%ebx)
80103686:	9c                   	pushf  
80103687:	59                   	pop    %ecx
80103688:	83 e1 40             	and    $0x40,%ecx
              "and $0x0040, %1\n\t"
              : "+m" (*(int *)addr), "=r" (ret)
              : "r" (expected), "r" (newval)
              : "%eax"
              );
  return ret>>6;
8010368b:	c1 f9 06             	sar    $0x6,%ecx
      while(!cas(&p->state, SLEEPING, RUNNABLE)){
8010368e:	85 c9                	test   %ecx,%ecx
80103690:	74 ee                	je     80103680 <wakeup1+0x50>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103692:	81 c2 94 01 00 00    	add    $0x194,%edx
80103698:	81 fa 54 92 11 80    	cmp    $0x80119254,%edx
8010369e:	72 c3                	jb     80103663 <wakeup1+0x33>
          
      }
    }
  }
}
801036a0:	83 c4 04             	add    $0x4,%esp
801036a3:	5b                   	pop    %ebx
801036a4:	5e                   	pop    %esi
801036a5:	5f                   	pop    %edi
801036a6:	5d                   	pop    %ebp
801036a7:	c3                   	ret    
801036a8:	90                   	nop
801036a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801036b0 <call_sigret>:
  struct proc *p = myproc();
  if (p-> suspended == 1)
    p->suspended = 0; 
}

void call_sigret(void){
801036b0:	55                   	push   %ebp
801036b1:	89 e5                	mov    %esp,%ebp
   asm("movl $24 , %eax;");
801036b3:	b8 18 00 00 00       	mov    $0x18,%eax
   asm("int $64;");
801036b8:	cd 40                	int    $0x40
}
801036ba:	5d                   	pop    %ebp
801036bb:	c3                   	ret    
801036bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801036c0 <allocproc>:
{
801036c0:	55                   	push   %ebp
801036c1:	89 e5                	mov    %esp,%ebp
801036c3:	56                   	push   %esi
801036c4:	53                   	push   %ebx
  asm volatile("movl %2 , %%eax\n\t"
801036c5:	31 f6                	xor    %esi,%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801036c7:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
  pushcli();
801036cc:	e8 ff 10 00 00       	call   801047d0 <pushcli>
801036d1:	b9 01 00 00 00       	mov    $0x1,%ecx
801036d6:	eb 1a                	jmp    801036f2 <allocproc+0x32>
801036d8:	90                   	nop
801036d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801036e0:	81 c3 94 01 00 00    	add    $0x194,%ebx
801036e6:	81 fb 54 92 11 80    	cmp    $0x80119254,%ebx
801036ec:	0f 83 ed 00 00 00    	jae    801037df <allocproc+0x11f>
801036f2:	89 f0                	mov    %esi,%eax
801036f4:	f0 0f b1 4b 0c       	lock cmpxchg %ecx,0xc(%ebx)
801036f9:	9c                   	pushf  
801036fa:	5a                   	pop    %edx
801036fb:	83 e2 40             	and    $0x40,%edx
  return ret>>6;
801036fe:	c1 fa 06             	sar    $0x6,%edx
    if(cas(&p->state, UNUSED, EMBRYO))
80103701:	85 d2                	test   %edx,%edx
80103703:	74 db                	je     801036e0 <allocproc+0x20>
  popcli();
80103705:	e8 06 11 00 00       	call   80104810 <popcli>
8010370a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pid = nextpid;
80103710:	8b 15 04 a0 10 80    	mov    0x8010a004,%edx
  }while (!cas(&nextpid , pid, pid+1));
80103716:	8d 4a 01             	lea    0x1(%edx),%ecx
  asm volatile("movl %2 , %%eax\n\t"
80103719:	89 d0                	mov    %edx,%eax
8010371b:	f0 0f b1 0d 04 a0 10 	lock cmpxchg %ecx,0x8010a004
80103722:	80 
80103723:	9c                   	pushf  
80103724:	5a                   	pop    %edx
80103725:	83 e2 40             	and    $0x40,%edx
  return ret>>6;
80103728:	c1 fa 06             	sar    $0x6,%edx
8010372b:	85 d2                	test   %edx,%edx
8010372d:	74 e1                	je     80103710 <allocproc+0x50>
  p->pid = allocpid();
8010372f:	89 4b 10             	mov    %ecx,0x10(%ebx)
  if((p->kstack = kalloc()) == 0){
80103732:	e8 b9 ed ff ff       	call   801024f0 <kalloc>
80103737:	85 c0                	test   %eax,%eax
80103739:	89 43 08             	mov    %eax,0x8(%ebx)
8010373c:	0f 84 ad 00 00 00    	je     801037ef <allocproc+0x12f>
  sp -= sizeof *p->tf;
80103742:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  memset(p->context, 0, sizeof *p->context);
80103748:	83 ec 04             	sub    $0x4,%esp
  sp -= sizeof *p->context;
8010374b:	05 9c 0f 00 00       	add    $0xf9c,%eax
  sp -= sizeof *p->tf;
80103750:	89 53 18             	mov    %edx,0x18(%ebx)
  *(uint*)sp = (uint)trapret;
80103753:	c7 40 14 77 5c 10 80 	movl   $0x80105c77,0x14(%eax)
  p->context = (struct context*)sp;
8010375a:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
8010375d:	6a 14                	push   $0x14
8010375f:	6a 00                	push   $0x0
80103761:	50                   	push   %eax
80103762:	e8 49 12 00 00       	call   801049b0 <memset>
  p->context->eip = (uint)forkret;
80103767:	8b 43 1c             	mov    0x1c(%ebx),%eax
8010376a:	c7 40 10 00 38 10 80 	movl   $0x80103800,0x10(%eax)
  p->backup = (struct trapframe*)kalloc();
80103771:	e8 7a ed ff ff       	call   801024f0 <kalloc>
80103776:	8d 93 8c 01 00 00    	lea    0x18c(%ebx),%edx
8010377c:	89 43 7c             	mov    %eax,0x7c(%ebx)
8010377f:	8d 83 8c 00 00 00    	lea    0x8c(%ebx),%eax
80103785:	83 c4 10             	add    $0x10,%esp
80103788:	90                   	nop
80103789:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    p->signal_handlers[i].sa_handler = SIG_DFL;
80103790:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    p->signal_handlers[i].sigmask = 0;
80103796:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
8010379d:	83 c0 08             	add    $0x8,%eax
  for(int i=0; i<32; i++){
801037a0:	39 c2                	cmp    %eax,%edx
801037a2:	75 ec                	jne    80103790 <allocproc+0xd0>
  p->pending_signals =0;
801037a4:	c7 83 80 00 00 00 00 	movl   $0x0,0x80(%ebx)
801037ab:	00 00 00 
  p->signal_mask = 0;
801037ae:	c7 83 84 00 00 00 00 	movl   $0x0,0x84(%ebx)
801037b5:	00 00 00 
  p->signal_mask_backup = 0;
801037b8:	c7 83 88 00 00 00 00 	movl   $0x0,0x88(%ebx)
801037bf:	00 00 00 
  p->suspended =0;
801037c2:	c7 83 8c 01 00 00 00 	movl   $0x0,0x18c(%ebx)
801037c9:	00 00 00 
  p->already_in_signal = 0;
801037cc:	c7 83 90 01 00 00 00 	movl   $0x0,0x190(%ebx)
801037d3:	00 00 00 
}
801037d6:	8d 65 f8             	lea    -0x8(%ebp),%esp
801037d9:	89 d8                	mov    %ebx,%eax
801037db:	5b                   	pop    %ebx
801037dc:	5e                   	pop    %esi
801037dd:	5d                   	pop    %ebp
801037de:	c3                   	ret    
  popcli();
801037df:	e8 2c 10 00 00       	call   80104810 <popcli>
}
801037e4:	8d 65 f8             	lea    -0x8(%ebp),%esp
  return 0;
801037e7:	31 db                	xor    %ebx,%ebx
}
801037e9:	89 d8                	mov    %ebx,%eax
801037eb:	5b                   	pop    %ebx
801037ec:	5e                   	pop    %esi
801037ed:	5d                   	pop    %ebp
801037ee:	c3                   	ret    
    p->state = UNUSED;
801037ef:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
801037f6:	31 db                	xor    %ebx,%ebx
801037f8:	eb dc                	jmp    801037d6 <allocproc+0x116>
801037fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103800 <forkret>:
{
80103800:	55                   	push   %ebp
80103801:	89 e5                	mov    %esp,%ebp
80103803:	83 ec 08             	sub    $0x8,%esp
  popcli();
80103806:	e8 05 10 00 00       	call   80104810 <popcli>
  if (first) {
8010380b:	a1 00 a0 10 80       	mov    0x8010a000,%eax
80103810:	85 c0                	test   %eax,%eax
80103812:	75 0c                	jne    80103820 <forkret+0x20>
}
80103814:	c9                   	leave  
80103815:	c3                   	ret    
80103816:	8d 76 00             	lea    0x0(%esi),%esi
80103819:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    iinit(ROOTDEV);
80103820:	83 ec 0c             	sub    $0xc,%esp
    first = 0;
80103823:	c7 05 00 a0 10 80 00 	movl   $0x0,0x8010a000
8010382a:	00 00 00 
    iinit(ROOTDEV);
8010382d:	6a 01                	push   $0x1
8010382f:	e8 7c dc ff ff       	call   801014b0 <iinit>
    initlog(ROOTDEV);
80103834:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010383b:	e8 f0 f2 ff ff       	call   80102b30 <initlog>
80103840:	83 c4 10             	add    $0x10,%esp
}
80103843:	c9                   	leave  
80103844:	c3                   	ret    
80103845:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103849:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103850 <pinit>:
{
80103850:	55                   	push   %ebp
80103851:	89 e5                	mov    %esp,%ebp
80103853:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
80103856:	68 b5 7a 10 80       	push   $0x80107ab5
8010385b:	68 20 2d 11 80       	push   $0x80112d20
80103860:	e8 fb 0e 00 00       	call   80104760 <initlock>
}
80103865:	83 c4 10             	add    $0x10,%esp
80103868:	c9                   	leave  
80103869:	c3                   	ret    
8010386a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103870 <mycpu>:
{
80103870:	55                   	push   %ebp
80103871:	89 e5                	mov    %esp,%ebp
80103873:	56                   	push   %esi
80103874:	53                   	push   %ebx
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103875:	9c                   	pushf  
80103876:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103877:	f6 c4 02             	test   $0x2,%ah
8010387a:	75 5e                	jne    801038da <mycpu+0x6a>
  apicid = lapicid();
8010387c:	e8 df ee ff ff       	call   80102760 <lapicid>
  for (i = 0; i < ncpu; ++i) {
80103881:	8b 35 00 2d 11 80    	mov    0x80112d00,%esi
80103887:	85 f6                	test   %esi,%esi
80103889:	7e 42                	jle    801038cd <mycpu+0x5d>
    if (cpus[i].apicid == apicid)
8010388b:	0f b6 15 80 27 11 80 	movzbl 0x80112780,%edx
80103892:	39 d0                	cmp    %edx,%eax
80103894:	74 30                	je     801038c6 <mycpu+0x56>
80103896:	b9 30 28 11 80       	mov    $0x80112830,%ecx
  for (i = 0; i < ncpu; ++i) {
8010389b:	31 d2                	xor    %edx,%edx
8010389d:	8d 76 00             	lea    0x0(%esi),%esi
801038a0:	83 c2 01             	add    $0x1,%edx
801038a3:	39 f2                	cmp    %esi,%edx
801038a5:	74 26                	je     801038cd <mycpu+0x5d>
    if (cpus[i].apicid == apicid)
801038a7:	0f b6 19             	movzbl (%ecx),%ebx
801038aa:	81 c1 b0 00 00 00    	add    $0xb0,%ecx
801038b0:	39 c3                	cmp    %eax,%ebx
801038b2:	75 ec                	jne    801038a0 <mycpu+0x30>
801038b4:	69 c2 b0 00 00 00    	imul   $0xb0,%edx,%eax
801038ba:	05 80 27 11 80       	add    $0x80112780,%eax
}
801038bf:	8d 65 f8             	lea    -0x8(%ebp),%esp
801038c2:	5b                   	pop    %ebx
801038c3:	5e                   	pop    %esi
801038c4:	5d                   	pop    %ebp
801038c5:	c3                   	ret    
    if (cpus[i].apicid == apicid)
801038c6:	b8 80 27 11 80       	mov    $0x80112780,%eax
      return &cpus[i];
801038cb:	eb f2                	jmp    801038bf <mycpu+0x4f>
  panic("unknown apicid\n");
801038cd:	83 ec 0c             	sub    $0xc,%esp
801038d0:	68 bc 7a 10 80       	push   $0x80107abc
801038d5:	e8 b6 ca ff ff       	call   80100390 <panic>
    panic("mycpu called with interrupts enabled\n");
801038da:	83 ec 0c             	sub    $0xc,%esp
801038dd:	68 88 7b 10 80       	push   $0x80107b88
801038e2:	e8 a9 ca ff ff       	call   80100390 <panic>
801038e7:	89 f6                	mov    %esi,%esi
801038e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801038f0 <cpuid>:
cpuid() {
801038f0:	55                   	push   %ebp
801038f1:	89 e5                	mov    %esp,%ebp
801038f3:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
801038f6:	e8 75 ff ff ff       	call   80103870 <mycpu>
801038fb:	2d 80 27 11 80       	sub    $0x80112780,%eax
}
80103900:	c9                   	leave  
  return mycpu()-cpus;
80103901:	c1 f8 04             	sar    $0x4,%eax
80103904:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
8010390a:	c3                   	ret    
8010390b:	90                   	nop
8010390c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103910 <myproc>:
myproc(void) {
80103910:	55                   	push   %ebp
80103911:	89 e5                	mov    %esp,%ebp
80103913:	53                   	push   %ebx
80103914:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80103917:	e8 b4 0e 00 00       	call   801047d0 <pushcli>
  c = mycpu();
8010391c:	e8 4f ff ff ff       	call   80103870 <mycpu>
  p = c->proc;
80103921:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103927:	e8 e4 0e 00 00       	call   80104810 <popcli>
}
8010392c:	83 c4 04             	add    $0x4,%esp
8010392f:	89 d8                	mov    %ebx,%eax
80103931:	5b                   	pop    %ebx
80103932:	5d                   	pop    %ebp
80103933:	c3                   	ret    
80103934:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010393a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103940 <allocpid>:
{
80103940:	55                   	push   %ebp
80103941:	89 e5                	mov    %esp,%ebp
80103943:	90                   	nop
80103944:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    pid = nextpid;
80103948:	8b 15 04 a0 10 80    	mov    0x8010a004,%edx
  }while (!cas(&nextpid , pid, pid+1));
8010394e:	8d 4a 01             	lea    0x1(%edx),%ecx
  asm volatile("movl %2 , %%eax\n\t"
80103951:	89 d0                	mov    %edx,%eax
80103953:	f0 0f b1 0d 04 a0 10 	lock cmpxchg %ecx,0x8010a004
8010395a:	80 
8010395b:	9c                   	pushf  
8010395c:	5a                   	pop    %edx
8010395d:	83 e2 40             	and    $0x40,%edx
  return ret>>6;
80103960:	c1 fa 06             	sar    $0x6,%edx
80103963:	85 d2                	test   %edx,%edx
80103965:	74 e1                	je     80103948 <allocpid+0x8>
}
80103967:	89 c8                	mov    %ecx,%eax
80103969:	5d                   	pop    %ebp
8010396a:	c3                   	ret    
8010396b:	90                   	nop
8010396c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103970 <userinit>:
{
80103970:	55                   	push   %ebp
80103971:	89 e5                	mov    %esp,%ebp
80103973:	53                   	push   %ebx
80103974:	83 ec 04             	sub    $0x4,%esp
  p = allocproc();
80103977:	e8 44 fd ff ff       	call   801036c0 <allocproc>
8010397c:	89 c3                	mov    %eax,%ebx
  initproc = p;
8010397e:	a3 b8 a5 10 80       	mov    %eax,0x8010a5b8
  if((p->pgdir = setupkvm()) == 0)
80103983:	e8 28 39 00 00       	call   801072b0 <setupkvm>
80103988:	85 c0                	test   %eax,%eax
8010398a:	89 43 04             	mov    %eax,0x4(%ebx)
8010398d:	0f 84 ae 00 00 00    	je     80103a41 <userinit+0xd1>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80103993:	83 ec 04             	sub    $0x4,%esp
80103996:	68 2c 00 00 00       	push   $0x2c
8010399b:	68 60 a4 10 80       	push   $0x8010a460
801039a0:	50                   	push   %eax
801039a1:	e8 ea 35 00 00       	call   80106f90 <inituvm>
  memset(p->tf, 0, sizeof(*p->tf));
801039a6:	83 c4 0c             	add    $0xc,%esp
  p->sz = PGSIZE;
801039a9:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
801039af:	6a 4c                	push   $0x4c
801039b1:	6a 00                	push   $0x0
801039b3:	ff 73 18             	pushl  0x18(%ebx)
801039b6:	e8 f5 0f 00 00       	call   801049b0 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
801039bb:	8b 43 18             	mov    0x18(%ebx),%eax
801039be:	ba 1b 00 00 00       	mov    $0x1b,%edx
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
801039c3:	b9 23 00 00 00       	mov    $0x23,%ecx
  safestrcpy(p->name, "initcode", sizeof(p->name));
801039c8:	83 c4 0c             	add    $0xc,%esp
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
801039cb:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
801039cf:	8b 43 18             	mov    0x18(%ebx),%eax
801039d2:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
801039d6:	8b 43 18             	mov    0x18(%ebx),%eax
801039d9:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
801039dd:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
801039e1:	8b 43 18             	mov    0x18(%ebx),%eax
801039e4:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
801039e8:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
801039ec:	8b 43 18             	mov    0x18(%ebx),%eax
801039ef:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
801039f6:	8b 43 18             	mov    0x18(%ebx),%eax
801039f9:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80103a00:	8b 43 18             	mov    0x18(%ebx),%eax
80103a03:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103a0a:	8d 43 6c             	lea    0x6c(%ebx),%eax
80103a0d:	6a 10                	push   $0x10
80103a0f:	68 e5 7a 10 80       	push   $0x80107ae5
80103a14:	50                   	push   %eax
80103a15:	e8 76 11 00 00       	call   80104b90 <safestrcpy>
  p->cwd = namei("/");
80103a1a:	c7 04 24 ee 7a 10 80 	movl   $0x80107aee,(%esp)
80103a21:	e8 ea e4 ff ff       	call   80101f10 <namei>
80103a26:	89 43 68             	mov    %eax,0x68(%ebx)
  pushcli();
80103a29:	e8 a2 0d 00 00       	call   801047d0 <pushcli>
  p->state = RUNNABLE;
80103a2e:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  popcli();
80103a35:	83 c4 10             	add    $0x10,%esp
}
80103a38:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103a3b:	c9                   	leave  
  popcli();
80103a3c:	e9 cf 0d 00 00       	jmp    80104810 <popcli>
    panic("userinit: out of memory?");
80103a41:	83 ec 0c             	sub    $0xc,%esp
80103a44:	68 cc 7a 10 80       	push   $0x80107acc
80103a49:	e8 42 c9 ff ff       	call   80100390 <panic>
80103a4e:	66 90                	xchg   %ax,%ax

80103a50 <growproc>:
{
80103a50:	55                   	push   %ebp
80103a51:	89 e5                	mov    %esp,%ebp
80103a53:	56                   	push   %esi
80103a54:	53                   	push   %ebx
80103a55:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
80103a58:	e8 73 0d 00 00       	call   801047d0 <pushcli>
  c = mycpu();
80103a5d:	e8 0e fe ff ff       	call   80103870 <mycpu>
  p = c->proc;
80103a62:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103a68:	e8 a3 0d 00 00       	call   80104810 <popcli>
  if(n > 0){
80103a6d:	83 fe 00             	cmp    $0x0,%esi
  sz = curproc->sz;
80103a70:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
80103a72:	7f 1c                	jg     80103a90 <growproc+0x40>
  } else if(n < 0){
80103a74:	75 3a                	jne    80103ab0 <growproc+0x60>
  switchuvm(curproc);
80103a76:	83 ec 0c             	sub    $0xc,%esp
  curproc->sz = sz;
80103a79:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
80103a7b:	53                   	push   %ebx
80103a7c:	e8 ff 33 00 00       	call   80106e80 <switchuvm>
  return 0;
80103a81:	83 c4 10             	add    $0x10,%esp
80103a84:	31 c0                	xor    %eax,%eax
}
80103a86:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103a89:	5b                   	pop    %ebx
80103a8a:	5e                   	pop    %esi
80103a8b:	5d                   	pop    %ebp
80103a8c:	c3                   	ret    
80103a8d:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103a90:	83 ec 04             	sub    $0x4,%esp
80103a93:	01 c6                	add    %eax,%esi
80103a95:	56                   	push   %esi
80103a96:	50                   	push   %eax
80103a97:	ff 73 04             	pushl  0x4(%ebx)
80103a9a:	e8 31 36 00 00       	call   801070d0 <allocuvm>
80103a9f:	83 c4 10             	add    $0x10,%esp
80103aa2:	85 c0                	test   %eax,%eax
80103aa4:	75 d0                	jne    80103a76 <growproc+0x26>
      return -1;
80103aa6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103aab:	eb d9                	jmp    80103a86 <growproc+0x36>
80103aad:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103ab0:	83 ec 04             	sub    $0x4,%esp
80103ab3:	01 c6                	add    %eax,%esi
80103ab5:	56                   	push   %esi
80103ab6:	50                   	push   %eax
80103ab7:	ff 73 04             	pushl  0x4(%ebx)
80103aba:	e8 41 37 00 00       	call   80107200 <deallocuvm>
80103abf:	83 c4 10             	add    $0x10,%esp
80103ac2:	85 c0                	test   %eax,%eax
80103ac4:	75 b0                	jne    80103a76 <growproc+0x26>
80103ac6:	eb de                	jmp    80103aa6 <growproc+0x56>
80103ac8:	90                   	nop
80103ac9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103ad0 <fork>:
{
80103ad0:	55                   	push   %ebp
80103ad1:	89 e5                	mov    %esp,%ebp
80103ad3:	57                   	push   %edi
80103ad4:	56                   	push   %esi
80103ad5:	53                   	push   %ebx
80103ad6:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
80103ad9:	e8 f2 0c 00 00       	call   801047d0 <pushcli>
  c = mycpu();
80103ade:	e8 8d fd ff ff       	call   80103870 <mycpu>
  p = c->proc;
80103ae3:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103ae9:	e8 22 0d 00 00       	call   80104810 <popcli>
  if((np = allocproc()) == 0){
80103aee:	e8 cd fb ff ff       	call   801036c0 <allocproc>
80103af3:	85 c0                	test   %eax,%eax
80103af5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103af8:	0f 84 f8 00 00 00    	je     80103bf6 <fork+0x126>
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
80103afe:	83 ec 08             	sub    $0x8,%esp
80103b01:	ff 33                	pushl  (%ebx)
80103b03:	ff 73 04             	pushl  0x4(%ebx)
80103b06:	e8 75 38 00 00       	call   80107380 <copyuvm>
80103b0b:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103b0e:	83 c4 10             	add    $0x10,%esp
80103b11:	85 c0                	test   %eax,%eax
80103b13:	89 42 04             	mov    %eax,0x4(%edx)
80103b16:	0f 84 e3 00 00 00    	je     80103bff <fork+0x12f>
  np->sz = curproc->sz;
80103b1c:	8b 03                	mov    (%ebx),%eax
  *np->tf = *curproc->tf;
80103b1e:	8b 7a 18             	mov    0x18(%edx),%edi
80103b21:	b9 13 00 00 00       	mov    $0x13,%ecx
  np->parent = curproc;
80103b26:	89 5a 14             	mov    %ebx,0x14(%edx)
  np->sz = curproc->sz;
80103b29:	89 02                	mov    %eax,(%edx)
  *np->tf = *curproc->tf;
80103b2b:	8b 73 18             	mov    0x18(%ebx),%esi
80103b2e:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  for(i = 0; i < NOFILE; i++)
80103b30:	31 f6                	xor    %esi,%esi
  np->tf->eax = 0;
80103b32:	8b 42 18             	mov    0x18(%edx),%eax
80103b35:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
80103b3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[i])
80103b40:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
80103b44:	85 c0                	test   %eax,%eax
80103b46:	74 16                	je     80103b5e <fork+0x8e>
      np->ofile[i] = filedup(curproc->ofile[i]);
80103b48:	83 ec 0c             	sub    $0xc,%esp
80103b4b:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80103b4e:	50                   	push   %eax
80103b4f:	e8 cc d2 ff ff       	call   80100e20 <filedup>
80103b54:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103b57:	83 c4 10             	add    $0x10,%esp
80103b5a:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
  for(i = 0; i < NOFILE; i++)
80103b5e:	83 c6 01             	add    $0x1,%esi
80103b61:	83 fe 10             	cmp    $0x10,%esi
80103b64:	75 da                	jne    80103b40 <fork+0x70>
  np->cwd = idup(curproc->cwd);
80103b66:	83 ec 0c             	sub    $0xc,%esp
80103b69:	ff 73 68             	pushl  0x68(%ebx)
80103b6c:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80103b6f:	e8 0c db ff ff       	call   80101680 <idup>
80103b74:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103b77:	83 c4 0c             	add    $0xc,%esp
  np->cwd = idup(curproc->cwd);
80103b7a:	89 42 68             	mov    %eax,0x68(%edx)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103b7d:	8d 43 6c             	lea    0x6c(%ebx),%eax
80103b80:	6a 10                	push   $0x10
80103b82:	50                   	push   %eax
80103b83:	8d 42 6c             	lea    0x6c(%edx),%eax
80103b86:	50                   	push   %eax
80103b87:	e8 04 10 00 00       	call   80104b90 <safestrcpy>
  pid = np->pid;
80103b8c:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  np->signal_mask = curproc->signal_mask;
80103b8f:	8b 8b 84 00 00 00    	mov    0x84(%ebx),%ecx
80103b95:	83 c4 10             	add    $0x10,%esp
  pid = np->pid;
80103b98:	8b 42 10             	mov    0x10(%edx),%eax
  np->signal_mask = curproc->signal_mask;
80103b9b:	89 8a 84 00 00 00    	mov    %ecx,0x84(%edx)
  for(int i=0; i<32; i++){
80103ba1:	31 c9                	xor    %ecx,%ecx
  pid = np->pid;
80103ba3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103ba6:	8d 76 00             	lea    0x0(%esi),%esi
80103ba9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    np->signal_handlers[i] = curproc->signal_handlers[i];
80103bb0:	8b b4 cb 8c 00 00 00 	mov    0x8c(%ebx,%ecx,8),%esi
80103bb7:	8b bc cb 90 00 00 00 	mov    0x90(%ebx,%ecx,8),%edi
80103bbe:	89 b4 ca 8c 00 00 00 	mov    %esi,0x8c(%edx,%ecx,8)
80103bc5:	89 bc ca 90 00 00 00 	mov    %edi,0x90(%edx,%ecx,8)
  for(int i=0; i<32; i++){
80103bcc:	83 c1 01             	add    $0x1,%ecx
80103bcf:	83 f9 20             	cmp    $0x20,%ecx
80103bd2:	75 dc                	jne    80103bb0 <fork+0xe0>
80103bd4:	89 55 e0             	mov    %edx,-0x20(%ebp)
  pushcli();
80103bd7:	e8 f4 0b 00 00       	call   801047d0 <pushcli>
  np->state = RUNNABLE;
80103bdc:	8b 55 e0             	mov    -0x20(%ebp),%edx
80103bdf:	c7 42 0c 03 00 00 00 	movl   $0x3,0xc(%edx)
  popcli();
80103be6:	e8 25 0c 00 00       	call   80104810 <popcli>
}
80103beb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103bee:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103bf1:	5b                   	pop    %ebx
80103bf2:	5e                   	pop    %esi
80103bf3:	5f                   	pop    %edi
80103bf4:	5d                   	pop    %ebp
80103bf5:	c3                   	ret    
    return -1;
80103bf6:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
80103bfd:	eb ec                	jmp    80103beb <fork+0x11b>
    kfree(np->kstack);
80103bff:	83 ec 0c             	sub    $0xc,%esp
80103c02:	ff 72 08             	pushl  0x8(%edx)
80103c05:	e8 36 e7 ff ff       	call   80102340 <kfree>
    np->kstack = 0;
80103c0a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    return -1;
80103c0d:	83 c4 10             	add    $0x10,%esp
80103c10:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
    np->kstack = 0;
80103c17:	c7 42 08 00 00 00 00 	movl   $0x0,0x8(%edx)
    np->state = UNUSED;
80103c1e:	c7 42 0c 00 00 00 00 	movl   $0x0,0xc(%edx)
    return -1;
80103c25:	eb c4                	jmp    80103beb <fork+0x11b>
80103c27:	89 f6                	mov    %esi,%esi
80103c29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103c30 <scheduler>:
{
80103c30:	55                   	push   %ebp
80103c31:	89 e5                	mov    %esp,%ebp
80103c33:	57                   	push   %edi
80103c34:	56                   	push   %esi
80103c35:	53                   	push   %ebx
  asm volatile("movl %2 , %%eax\n\t"
80103c36:	be 03 00 00 00       	mov    $0x3,%esi
80103c3b:	83 ec 1c             	sub    $0x1c,%esp
  struct cpu *c = mycpu();
80103c3e:	e8 2d fc ff ff       	call   80103870 <mycpu>
  c->proc = 0;
80103c43:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80103c4a:	00 00 00 
  struct cpu *c = mycpu();
80103c4d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103c50:	83 c0 04             	add    $0x4,%eax
80103c53:	89 45 e0             	mov    %eax,-0x20(%ebp)
80103c56:	8d 76 00             	lea    0x0(%esi),%esi
80103c59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  asm volatile("sti");
80103c60:	fb                   	sti    
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103c61:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
  asm volatile("movl %2 , %%eax\n\t"
80103c66:	bf 04 00 00 00       	mov    $0x4,%edi
    pushcli();
80103c6b:	e8 60 0b 00 00       	call   801047d0 <pushcli>
      if(p->suspended){
80103c70:	8b 8b 8c 01 00 00    	mov    0x18c(%ebx),%ecx
80103c76:	85 c9                	test   %ecx,%ecx
80103c78:	74 26                	je     80103ca0 <scheduler+0x70>
          if((p->pending_signals & 1<<SIGCONT) == 1<<SIGCONT){
80103c7a:	8b 83 80 00 00 00    	mov    0x80(%ebx),%eax
80103c80:	a9 00 00 08 00       	test   $0x80000,%eax
80103c85:	0f 84 a0 00 00 00    	je     80103d2b <scheduler+0xfb>
            p->pending_signals = p->pending_signals & (~(1<<SIGCONT));
80103c8b:	25 ff ff f7 ff       	and    $0xfff7ffff,%eax
            p->suspended = 0; 
80103c90:	c7 83 8c 01 00 00 00 	movl   $0x0,0x18c(%ebx)
80103c97:	00 00 00 
            p->pending_signals = p->pending_signals & (~(1<<SIGCONT));
80103c9a:	89 83 80 00 00 00    	mov    %eax,0x80(%ebx)
80103ca0:	89 f0                	mov    %esi,%eax
80103ca2:	f0 0f b1 7b 0c       	lock cmpxchg %edi,0xc(%ebx)
80103ca7:	9c                   	pushf  
80103ca8:	5a                   	pop    %edx
80103ca9:	83 e2 40             	and    $0x40,%edx
  return ret>>6;
80103cac:	c1 fa 06             	sar    $0x6,%edx
      if (!result)
80103caf:	85 d2                	test   %edx,%edx
80103cb1:	74 78                	je     80103d2b <scheduler+0xfb>
      c->proc = p;
80103cb3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
      switchuvm(p);
80103cb6:	83 ec 0c             	sub    $0xc,%esp
      c->proc = p;
80103cb9:	89 98 ac 00 00 00    	mov    %ebx,0xac(%eax)
      switchuvm(p);
80103cbf:	53                   	push   %ebx
80103cc0:	e8 bb 31 00 00       	call   80106e80 <switchuvm>
      swtch(&(c->scheduler), p->context);
80103cc5:	58                   	pop    %eax
80103cc6:	5a                   	pop    %edx
80103cc7:	ff 73 1c             	pushl  0x1c(%ebx)
80103cca:	ff 75 e0             	pushl  -0x20(%ebp)
      p->state = RUNNING;
80103ccd:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
      swtch(&(c->scheduler), p->context);
80103cd4:	e8 12 0f 00 00       	call   80104beb <swtch>
      switchkvm();
80103cd9:	e8 82 31 00 00       	call   80106e60 <switchkvm>
  asm volatile("movl %2 , %%eax\n\t"
80103cde:	ba fd ff ff ff       	mov    $0xfffffffd,%edx
80103ce3:	89 d0                	mov    %edx,%eax
80103ce5:	f0 0f b1 73 0c       	lock cmpxchg %esi,0xc(%ebx)
80103cea:	9c                   	pushf  
80103ceb:	5a                   	pop    %edx
80103cec:	83 e2 40             	and    $0x40,%edx
80103cef:	ba fe ff ff ff       	mov    $0xfffffffe,%edx
80103cf4:	b9 02 00 00 00       	mov    $0x2,%ecx
80103cf9:	89 d0                	mov    %edx,%eax
80103cfb:	f0 0f b1 4b 0c       	lock cmpxchg %ecx,0xc(%ebx)
80103d00:	9c                   	pushf  
80103d01:	5a                   	pop    %edx
80103d02:	83 e2 40             	and    $0x40,%edx
80103d05:	ba fb ff ff ff       	mov    $0xfffffffb,%edx
80103d0a:	b9 05 00 00 00       	mov    $0x5,%ecx
80103d0f:	89 d0                	mov    %edx,%eax
80103d11:	f0 0f b1 4b 0c       	lock cmpxchg %ecx,0xc(%ebx)
80103d16:	9c                   	pushf  
80103d17:	5a                   	pop    %edx
80103d18:	83 e2 40             	and    $0x40,%edx
      c->proc = 0;
80103d1b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103d1e:	83 c4 10             	add    $0x10,%esp
80103d21:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80103d28:	00 00 00 
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103d2b:	81 c3 94 01 00 00    	add    $0x194,%ebx
80103d31:	81 fb 54 92 11 80    	cmp    $0x80119254,%ebx
80103d37:	0f 82 33 ff ff ff    	jb     80103c70 <scheduler+0x40>
    popcli();
80103d3d:	e8 ce 0a 00 00       	call   80104810 <popcli>
    sti();
80103d42:	e9 19 ff ff ff       	jmp    80103c60 <scheduler+0x30>
80103d47:	89 f6                	mov    %esi,%esi
80103d49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103d50 <sched>:
{
80103d50:	55                   	push   %ebp
80103d51:	89 e5                	mov    %esp,%ebp
80103d53:	56                   	push   %esi
80103d54:	53                   	push   %ebx
  pushcli();
80103d55:	e8 76 0a 00 00       	call   801047d0 <pushcli>
  c = mycpu();
80103d5a:	e8 11 fb ff ff       	call   80103870 <mycpu>
  p = c->proc;
80103d5f:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103d65:	e8 a6 0a 00 00       	call   80104810 <popcli>
  if(mycpu()->ncli != 1)
80103d6a:	e8 01 fb ff ff       	call   80103870 <mycpu>
80103d6f:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
80103d76:	75 41                	jne    80103db9 <sched+0x69>
  if(p->state == RUNNING)
80103d78:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80103d7c:	74 55                	je     80103dd3 <sched+0x83>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103d7e:	9c                   	pushf  
80103d7f:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103d80:	f6 c4 02             	test   $0x2,%ah
80103d83:	75 41                	jne    80103dc6 <sched+0x76>
  intena = mycpu()->intena;
80103d85:	e8 e6 fa ff ff       	call   80103870 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
80103d8a:	83 c3 1c             	add    $0x1c,%ebx
  intena = mycpu()->intena;
80103d8d:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80103d93:	e8 d8 fa ff ff       	call   80103870 <mycpu>
80103d98:	83 ec 08             	sub    $0x8,%esp
80103d9b:	ff 70 04             	pushl  0x4(%eax)
80103d9e:	53                   	push   %ebx
80103d9f:	e8 47 0e 00 00       	call   80104beb <swtch>
  mycpu()->intena = intena;
80103da4:	e8 c7 fa ff ff       	call   80103870 <mycpu>
}
80103da9:	83 c4 10             	add    $0x10,%esp
  mycpu()->intena = intena;
80103dac:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80103db2:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103db5:	5b                   	pop    %ebx
80103db6:	5e                   	pop    %esi
80103db7:	5d                   	pop    %ebp
80103db8:	c3                   	ret    
    panic("sched locks");
80103db9:	83 ec 0c             	sub    $0xc,%esp
80103dbc:	68 f0 7a 10 80       	push   $0x80107af0
80103dc1:	e8 ca c5 ff ff       	call   80100390 <panic>
    panic("sched interruptible");
80103dc6:	83 ec 0c             	sub    $0xc,%esp
80103dc9:	68 0a 7b 10 80       	push   $0x80107b0a
80103dce:	e8 bd c5 ff ff       	call   80100390 <panic>
    panic("sched running");
80103dd3:	83 ec 0c             	sub    $0xc,%esp
80103dd6:	68 fc 7a 10 80       	push   $0x80107afc
80103ddb:	e8 b0 c5 ff ff       	call   80100390 <panic>

80103de0 <exit>:
{
80103de0:	55                   	push   %ebp
80103de1:	89 e5                	mov    %esp,%ebp
80103de3:	57                   	push   %edi
80103de4:	56                   	push   %esi
80103de5:	53                   	push   %ebx
80103de6:	83 ec 0c             	sub    $0xc,%esp
  pushcli();
80103de9:	e8 e2 09 00 00       	call   801047d0 <pushcli>
  c = mycpu();
80103dee:	e8 7d fa ff ff       	call   80103870 <mycpu>
  p = c->proc;
80103df3:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80103df9:	e8 12 0a 00 00       	call   80104810 <popcli>
  if(curproc == initproc)
80103dfe:	39 35 b8 a5 10 80    	cmp    %esi,0x8010a5b8
80103e04:	8d 5e 28             	lea    0x28(%esi),%ebx
80103e07:	8d 7e 68             	lea    0x68(%esi),%edi
80103e0a:	0f 84 c1 00 00 00    	je     80103ed1 <exit+0xf1>
    if(curproc->ofile[fd]){
80103e10:	8b 03                	mov    (%ebx),%eax
80103e12:	85 c0                	test   %eax,%eax
80103e14:	74 12                	je     80103e28 <exit+0x48>
      fileclose(curproc->ofile[fd]);
80103e16:	83 ec 0c             	sub    $0xc,%esp
80103e19:	50                   	push   %eax
80103e1a:	e8 51 d0 ff ff       	call   80100e70 <fileclose>
      curproc->ofile[fd] = 0;
80103e1f:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80103e25:	83 c4 10             	add    $0x10,%esp
80103e28:	83 c3 04             	add    $0x4,%ebx
  for(fd = 0; fd < NOFILE; fd++){
80103e2b:	39 df                	cmp    %ebx,%edi
80103e2d:	75 e1                	jne    80103e10 <exit+0x30>
  begin_op();
80103e2f:	e8 9c ed ff ff       	call   80102bd0 <begin_op>
  iput(curproc->cwd);
80103e34:	83 ec 0c             	sub    $0xc,%esp
80103e37:	ff 76 68             	pushl  0x68(%esi)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103e3a:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
  iput(curproc->cwd);
80103e3f:	e8 9c d9 ff ff       	call   801017e0 <iput>
  end_op();
80103e44:	e8 f7 ed ff ff       	call   80102c40 <end_op>
  curproc->cwd = 0;
80103e49:	c7 46 68 00 00 00 00 	movl   $0x0,0x68(%esi)
  pushcli();
80103e50:	e8 7b 09 00 00       	call   801047d0 <pushcli>
  wakeup1(curproc->parent);
80103e55:	8b 46 14             	mov    0x14(%esi),%eax
80103e58:	e8 d3 f7 ff ff       	call   80103630 <wakeup1>
80103e5d:	83 c4 10             	add    $0x10,%esp
80103e60:	eb 14                	jmp    80103e76 <exit+0x96>
80103e62:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103e68:	81 c3 94 01 00 00    	add    $0x194,%ebx
80103e6e:	81 fb 54 92 11 80    	cmp    $0x80119254,%ebx
80103e74:	73 42                	jae    80103eb8 <exit+0xd8>
    if(p->parent == curproc){
80103e76:	39 73 14             	cmp    %esi,0x14(%ebx)
80103e79:	75 ed                	jne    80103e68 <exit+0x88>
      if(p->state == ZOMBIE || p->state == -ZOMBIE){
80103e7b:	8b 53 0c             	mov    0xc(%ebx),%edx
      p->parent = initproc;
80103e7e:	a1 b8 a5 10 80       	mov    0x8010a5b8,%eax
      if(p->state == ZOMBIE || p->state == -ZOMBIE){
80103e83:	83 fa 05             	cmp    $0x5,%edx
      p->parent = initproc;
80103e86:	89 43 14             	mov    %eax,0x14(%ebx)
      if(p->state == ZOMBIE || p->state == -ZOMBIE){
80103e89:	74 05                	je     80103e90 <exit+0xb0>
80103e8b:	83 fa fb             	cmp    $0xfffffffb,%edx
80103e8e:	75 d8                	jne    80103e68 <exit+0x88>
        while(p->state == -ZOMBIE);
80103e90:	83 fa fb             	cmp    $0xfffffffb,%edx
80103e93:	75 0b                	jne    80103ea0 <exit+0xc0>
80103e95:	eb fe                	jmp    80103e95 <exit+0xb5>
80103e97:	89 f6                	mov    %esi,%esi
80103e99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103ea0:	81 c3 94 01 00 00    	add    $0x194,%ebx
        wakeup1(initproc);
80103ea6:	e8 85 f7 ff ff       	call   80103630 <wakeup1>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103eab:	81 fb 54 92 11 80    	cmp    $0x80119254,%ebx
80103eb1:	72 c3                	jb     80103e76 <exit+0x96>
80103eb3:	90                   	nop
80103eb4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  curproc->state = -ZOMBIE;
80103eb8:	c7 46 0c fb ff ff ff 	movl   $0xfffffffb,0xc(%esi)
  sched();
80103ebf:	e8 8c fe ff ff       	call   80103d50 <sched>
  panic("zombie exit");
80103ec4:	83 ec 0c             	sub    $0xc,%esp
80103ec7:	68 2b 7b 10 80       	push   $0x80107b2b
80103ecc:	e8 bf c4 ff ff       	call   80100390 <panic>
    panic("init exiting");
80103ed1:	83 ec 0c             	sub    $0xc,%esp
80103ed4:	68 1e 7b 10 80       	push   $0x80107b1e
80103ed9:	e8 b2 c4 ff ff       	call   80100390 <panic>
80103ede:	66 90                	xchg   %ax,%ax

80103ee0 <yield>:
{
80103ee0:	55                   	push   %ebp
80103ee1:	89 e5                	mov    %esp,%ebp
80103ee3:	53                   	push   %ebx
80103ee4:	83 ec 04             	sub    $0x4,%esp
  pushcli();  //DOC: yieldlock
80103ee7:	e8 e4 08 00 00       	call   801047d0 <pushcli>
  pushcli();
80103eec:	e8 df 08 00 00       	call   801047d0 <pushcli>
  c = mycpu();
80103ef1:	e8 7a f9 ff ff       	call   80103870 <mycpu>
  p = c->proc;
80103ef6:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103efc:	e8 0f 09 00 00       	call   80104810 <popcli>
  myproc()->state = -RUNNABLE;
80103f01:	c7 43 0c fd ff ff ff 	movl   $0xfffffffd,0xc(%ebx)
  sched();
80103f08:	e8 43 fe ff ff       	call   80103d50 <sched>
}
80103f0d:	83 c4 04             	add    $0x4,%esp
80103f10:	5b                   	pop    %ebx
80103f11:	5d                   	pop    %ebp
  popcli();
80103f12:	e9 f9 08 00 00       	jmp    80104810 <popcli>
80103f17:	89 f6                	mov    %esi,%esi
80103f19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103f20 <sleep>:
{
80103f20:	55                   	push   %ebp
80103f21:	89 e5                	mov    %esp,%ebp
80103f23:	57                   	push   %edi
80103f24:	56                   	push   %esi
80103f25:	53                   	push   %ebx
80103f26:	83 ec 0c             	sub    $0xc,%esp
80103f29:	8b 7d 08             	mov    0x8(%ebp),%edi
80103f2c:	8b 75 0c             	mov    0xc(%ebp),%esi
  pushcli();
80103f2f:	e8 9c 08 00 00       	call   801047d0 <pushcli>
  c = mycpu();
80103f34:	e8 37 f9 ff ff       	call   80103870 <mycpu>
  p = c->proc;
80103f39:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103f3f:	e8 cc 08 00 00       	call   80104810 <popcli>
  if(p == 0)
80103f44:	85 db                	test   %ebx,%ebx
80103f46:	74 73                	je     80103fbb <sleep+0x9b>
  if(lk == 0)
80103f48:	85 f6                	test   %esi,%esi
80103f4a:	74 62                	je     80103fae <sleep+0x8e>
  if(lk != &ptable.lock){  //DOC: sleeplock0
80103f4c:	81 fe 20 2d 11 80    	cmp    $0x80112d20,%esi
80103f52:	74 3c                	je     80103f90 <sleep+0x70>
    pushcli();  //DOC: sleeplock1
80103f54:	e8 77 08 00 00       	call   801047d0 <pushcli>
    release(lk);
80103f59:	83 ec 0c             	sub    $0xc,%esp
80103f5c:	56                   	push   %esi
80103f5d:	e8 fe 09 00 00       	call   80104960 <release>
  p->chan = chan;
80103f62:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = -SLEEPING;
80103f65:	c7 43 0c fe ff ff ff 	movl   $0xfffffffe,0xc(%ebx)
  sched();
80103f6c:	e8 df fd ff ff       	call   80103d50 <sched>
  p->chan = 0;
80103f71:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
    popcli();
80103f78:	e8 93 08 00 00       	call   80104810 <popcli>
    acquire(lk);
80103f7d:	89 75 08             	mov    %esi,0x8(%ebp)
80103f80:	83 c4 10             	add    $0x10,%esp
}
80103f83:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103f86:	5b                   	pop    %ebx
80103f87:	5e                   	pop    %esi
80103f88:	5f                   	pop    %edi
80103f89:	5d                   	pop    %ebp
    acquire(lk);
80103f8a:	e9 11 09 00 00       	jmp    801048a0 <acquire>
80103f8f:	90                   	nop
  p->chan = chan;
80103f90:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = -SLEEPING;
80103f93:	c7 43 0c fe ff ff ff 	movl   $0xfffffffe,0xc(%ebx)
  sched();
80103f9a:	e8 b1 fd ff ff       	call   80103d50 <sched>
  p->chan = 0;
80103f9f:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
80103fa6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103fa9:	5b                   	pop    %ebx
80103faa:	5e                   	pop    %esi
80103fab:	5f                   	pop    %edi
80103fac:	5d                   	pop    %ebp
80103fad:	c3                   	ret    
    panic("sleep without lk");
80103fae:	83 ec 0c             	sub    $0xc,%esp
80103fb1:	68 3d 7b 10 80       	push   $0x80107b3d
80103fb6:	e8 d5 c3 ff ff       	call   80100390 <panic>
    panic("sleep");
80103fbb:	83 ec 0c             	sub    $0xc,%esp
80103fbe:	68 37 7b 10 80       	push   $0x80107b37
80103fc3:	e8 c8 c3 ff ff       	call   80100390 <panic>
80103fc8:	90                   	nop
80103fc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103fd0 <wait>:
{
80103fd0:	55                   	push   %ebp
80103fd1:	89 e5                	mov    %esp,%ebp
80103fd3:	56                   	push   %esi
80103fd4:	53                   	push   %ebx
  pushcli();
80103fd5:	e8 f6 07 00 00       	call   801047d0 <pushcli>
  c = mycpu();
80103fda:	e8 91 f8 ff ff       	call   80103870 <mycpu>
  p = c->proc;
80103fdf:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80103fe5:	e8 26 08 00 00       	call   80104810 <popcli>
  pushcli();
80103fea:	e8 e1 07 00 00       	call   801047d0 <pushcli>
    havekids = 0;
80103fef:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103ff1:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
80103ff6:	eb 16                	jmp    8010400e <wait+0x3e>
80103ff8:	90                   	nop
80103ff9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104000:	81 c3 94 01 00 00    	add    $0x194,%ebx
80104006:	81 fb 54 92 11 80    	cmp    $0x80119254,%ebx
8010400c:	73 25                	jae    80104033 <wait+0x63>
      if(p->parent != curproc)
8010400e:	39 73 14             	cmp    %esi,0x14(%ebx)
80104011:	75 ed                	jne    80104000 <wait+0x30>
      if(p->state == ZOMBIE || p->state == -ZOMBIE){
80104013:	8b 43 0c             	mov    0xc(%ebx),%eax
80104016:	83 f8 05             	cmp    $0x5,%eax
80104019:	74 3d                	je     80104058 <wait+0x88>
8010401b:	83 f8 fb             	cmp    $0xfffffffb,%eax
8010401e:	74 38                	je     80104058 <wait+0x88>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104020:	81 c3 94 01 00 00    	add    $0x194,%ebx
      havekids = 1;
80104026:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010402b:	81 fb 54 92 11 80    	cmp    $0x80119254,%ebx
80104031:	72 db                	jb     8010400e <wait+0x3e>
    if(!havekids || curproc->killed){
80104033:	85 c0                	test   %eax,%eax
80104035:	0f 84 7d 00 00 00    	je     801040b8 <wait+0xe8>
8010403b:	8b 46 24             	mov    0x24(%esi),%eax
8010403e:	85 c0                	test   %eax,%eax
80104040:	75 76                	jne    801040b8 <wait+0xe8>
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
80104042:	83 ec 08             	sub    $0x8,%esp
80104045:	68 20 2d 11 80       	push   $0x80112d20
8010404a:	56                   	push   %esi
8010404b:	e8 d0 fe ff ff       	call   80103f20 <sleep>
    havekids = 0;
80104050:	83 c4 10             	add    $0x10,%esp
80104053:	eb 9a                	jmp    80103fef <wait+0x1f>
80104055:	8d 76 00             	lea    0x0(%esi),%esi
        while(p->state == -ZOMBIE); // need to wait antil it zombie so i will not realse before done turning states
80104058:	83 f8 fb             	cmp    $0xfffffffb,%eax
8010405b:	75 03                	jne    80104060 <wait+0x90>
8010405d:	eb fe                	jmp    8010405d <wait+0x8d>
8010405f:	90                   	nop
        kfree(p->kstack);
80104060:	83 ec 0c             	sub    $0xc,%esp
80104063:	ff 73 08             	pushl  0x8(%ebx)
        pid = p->pid;
80104066:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80104069:	e8 d2 e2 ff ff       	call   80102340 <kfree>
        freevm(p->pgdir);
8010406e:	5a                   	pop    %edx
8010406f:	ff 73 04             	pushl  0x4(%ebx)
        p->kstack = 0;
80104072:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80104079:	e8 b2 31 00 00       	call   80107230 <freevm>
        kfree((char *)p->backup);
8010407e:	59                   	pop    %ecx
8010407f:	ff 73 7c             	pushl  0x7c(%ebx)
        p->pid = 0;
80104082:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80104089:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
80104090:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
80104094:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
8010409b:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        kfree((char *)p->backup);
801040a2:	e8 99 e2 ff ff       	call   80102340 <kfree>
        popcli();
801040a7:	e8 64 07 00 00       	call   80104810 <popcli>
        return pid;
801040ac:	83 c4 10             	add    $0x10,%esp
}
801040af:	8d 65 f8             	lea    -0x8(%ebp),%esp
801040b2:	89 f0                	mov    %esi,%eax
801040b4:	5b                   	pop    %ebx
801040b5:	5e                   	pop    %esi
801040b6:	5d                   	pop    %ebp
801040b7:	c3                   	ret    
      popcli();
801040b8:	e8 53 07 00 00       	call   80104810 <popcli>
      return -1;
801040bd:	be ff ff ff ff       	mov    $0xffffffff,%esi
801040c2:	eb eb                	jmp    801040af <wait+0xdf>
801040c4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801040ca:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801040d0 <wakeup>:
{
801040d0:	55                   	push   %ebp
801040d1:	89 e5                	mov    %esp,%ebp
801040d3:	53                   	push   %ebx
801040d4:	83 ec 04             	sub    $0x4,%esp
801040d7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
801040da:	e8 f1 06 00 00       	call   801047d0 <pushcli>
  wakeup1(chan);
801040df:	89 d8                	mov    %ebx,%eax
801040e1:	e8 4a f5 ff ff       	call   80103630 <wakeup1>
}
801040e6:	83 c4 04             	add    $0x4,%esp
801040e9:	5b                   	pop    %ebx
801040ea:	5d                   	pop    %ebp
  popcli();
801040eb:	e9 20 07 00 00       	jmp    80104810 <popcli>

801040f0 <kill>:
{
801040f0:	55                   	push   %ebp
801040f1:	89 e5                	mov    %esp,%ebp
801040f3:	57                   	push   %edi
801040f4:	56                   	push   %esi
801040f5:	53                   	push   %ebx
801040f6:	83 ec 0c             	sub    $0xc,%esp
801040f9:	8b 75 0c             	mov    0xc(%ebp),%esi
801040fc:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (signum > 31 || signum < 0)
801040ff:	83 fe 1f             	cmp    $0x1f,%esi
80104102:	0f 87 9a 00 00 00    	ja     801041a2 <kill+0xb2>
  pushcli();
80104108:	e8 c3 06 00 00       	call   801047d0 <pushcli>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010410d:	ba 54 2d 11 80       	mov    $0x80112d54,%edx
80104112:	eb 12                	jmp    80104126 <kill+0x36>
80104114:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104118:	81 c2 94 01 00 00    	add    $0x194,%edx
8010411e:	81 fa 54 92 11 80    	cmp    $0x80119254,%edx
80104124:	73 6a                	jae    80104190 <kill+0xa0>
    if(p->pid == pid){
80104126:	39 5a 10             	cmp    %ebx,0x10(%edx)
80104129:	75 ed                	jne    80104118 <kill+0x28>
      p->pending_signals = p->pending_signals | 1<<signum;
8010412b:	b8 01 00 00 00       	mov    $0x1,%eax
80104130:	89 f1                	mov    %esi,%ecx
80104132:	d3 e0                	shl    %cl,%eax
80104134:	09 82 80 00 00 00    	or     %eax,0x80(%edx)
      if(signum == SIGKILL){
8010413a:	83 fe 09             	cmp    $0x9,%esi
8010413d:	74 11                	je     80104150 <kill+0x60>
      popcli();
8010413f:	e8 cc 06 00 00       	call   80104810 <popcli>
      return 0;
80104144:	31 c0                	xor    %eax,%eax
}
80104146:	83 c4 0c             	add    $0xc,%esp
80104149:	5b                   	pop    %ebx
8010414a:	5e                   	pop    %esi
8010414b:	5f                   	pop    %edi
8010414c:	5d                   	pop    %ebp
8010414d:	c3                   	ret    
8010414e:	66 90                	xchg   %ax,%ax
        while(p->state == SLEEPING || p->state == -SLEEPING){
80104150:	8b 42 0c             	mov    0xc(%edx),%eax
80104153:	83 f8 02             	cmp    $0x2,%eax
80104156:	74 05                	je     8010415d <kill+0x6d>
80104158:	83 f8 fe             	cmp    $0xfffffffe,%eax
8010415b:	75 e2                	jne    8010413f <kill+0x4f>
8010415d:	8d 4a 0c             	lea    0xc(%edx),%ecx
  asm volatile("movl %2 , %%eax\n\t"
80104160:	be 02 00 00 00       	mov    $0x2,%esi
80104165:	bb 03 00 00 00       	mov    $0x3,%ebx
8010416a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104170:	89 f0                	mov    %esi,%eax
80104172:	f0 0f b1 19          	lock cmpxchg %ebx,(%ecx)
80104176:	9c                   	pushf  
80104177:	5f                   	pop    %edi
80104178:	83 e7 40             	and    $0x40,%edi
8010417b:	8b 42 0c             	mov    0xc(%edx),%eax
8010417e:	83 f8 02             	cmp    $0x2,%eax
80104181:	74 ed                	je     80104170 <kill+0x80>
80104183:	83 f8 fe             	cmp    $0xfffffffe,%eax
80104186:	74 e8                	je     80104170 <kill+0x80>
80104188:	eb b5                	jmp    8010413f <kill+0x4f>
8010418a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  popcli();
80104190:	e8 7b 06 00 00       	call   80104810 <popcli>
}
80104195:	83 c4 0c             	add    $0xc,%esp
  return -1;
80104198:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010419d:	5b                   	pop    %ebx
8010419e:	5e                   	pop    %esi
8010419f:	5f                   	pop    %edi
801041a0:	5d                   	pop    %ebp
801041a1:	c3                   	ret    
  return -1;
801041a2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801041a7:	eb 9d                	jmp    80104146 <kill+0x56>
801041a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801041b0 <kill_handler>:
void kill_handler(void){
801041b0:	55                   	push   %ebp
801041b1:	89 e5                	mov    %esp,%ebp
801041b3:	53                   	push   %ebx
801041b4:	83 ec 04             	sub    $0x4,%esp
  pushcli();
801041b7:	e8 14 06 00 00       	call   801047d0 <pushcli>
  c = mycpu();
801041bc:	e8 af f6 ff ff       	call   80103870 <mycpu>
  p = c->proc;
801041c1:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801041c7:	e8 44 06 00 00       	call   80104810 <popcli>
  p->killed = 1;
801041cc:	c7 43 24 01 00 00 00 	movl   $0x1,0x24(%ebx)
}
801041d3:	83 c4 04             	add    $0x4,%esp
801041d6:	5b                   	pop    %ebx
801041d7:	5d                   	pop    %ebp
801041d8:	c3                   	ret    
801041d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801041e0 <procdump>:
{
801041e0:	55                   	push   %ebp
801041e1:	89 e5                	mov    %esp,%ebp
801041e3:	57                   	push   %edi
801041e4:	56                   	push   %esi
801041e5:	53                   	push   %ebx
801041e6:	8d 75 e8             	lea    -0x18(%ebp),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801041e9:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
{
801041ee:	83 ec 3c             	sub    $0x3c,%esp
801041f1:	eb 27                	jmp    8010421a <procdump+0x3a>
801041f3:	90                   	nop
801041f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("\n");
801041f8:	83 ec 0c             	sub    $0xc,%esp
801041fb:	68 c3 7e 10 80       	push   $0x80107ec3
80104200:	e8 5b c4 ff ff       	call   80100660 <cprintf>
80104205:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104208:	81 c3 94 01 00 00    	add    $0x194,%ebx
8010420e:	81 fb 54 92 11 80    	cmp    $0x80119254,%ebx
80104214:	0f 83 86 00 00 00    	jae    801042a0 <procdump+0xc0>
    if(p->state == UNUSED)
8010421a:	8b 43 0c             	mov    0xc(%ebx),%eax
8010421d:	85 c0                	test   %eax,%eax
8010421f:	74 e7                	je     80104208 <procdump+0x28>
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104221:	83 f8 05             	cmp    $0x5,%eax
      state = "???";
80104224:	ba 4e 7b 10 80       	mov    $0x80107b4e,%edx
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104229:	77 11                	ja     8010423c <procdump+0x5c>
8010422b:	8b 14 85 b0 7b 10 80 	mov    -0x7fef8450(,%eax,4),%edx
      state = "???";
80104232:	b8 4e 7b 10 80       	mov    $0x80107b4e,%eax
80104237:	85 d2                	test   %edx,%edx
80104239:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
8010423c:	8d 43 6c             	lea    0x6c(%ebx),%eax
8010423f:	50                   	push   %eax
80104240:	52                   	push   %edx
80104241:	ff 73 10             	pushl  0x10(%ebx)
80104244:	68 52 7b 10 80       	push   $0x80107b52
80104249:	e8 12 c4 ff ff       	call   80100660 <cprintf>
    if(p->state == SLEEPING){
8010424e:	83 c4 10             	add    $0x10,%esp
80104251:	83 7b 0c 02          	cmpl   $0x2,0xc(%ebx)
80104255:	75 a1                	jne    801041f8 <procdump+0x18>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80104257:	8d 45 c0             	lea    -0x40(%ebp),%eax
8010425a:	83 ec 08             	sub    $0x8,%esp
8010425d:	8d 7d c0             	lea    -0x40(%ebp),%edi
80104260:	50                   	push   %eax
80104261:	8b 43 1c             	mov    0x1c(%ebx),%eax
80104264:	8b 40 0c             	mov    0xc(%eax),%eax
80104267:	83 c0 08             	add    $0x8,%eax
8010426a:	50                   	push   %eax
8010426b:	e8 10 05 00 00       	call   80104780 <getcallerpcs>
80104270:	83 c4 10             	add    $0x10,%esp
80104273:	90                   	nop
80104274:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      for(i=0; i<10 && pc[i] != 0; i++)
80104278:	8b 17                	mov    (%edi),%edx
8010427a:	85 d2                	test   %edx,%edx
8010427c:	0f 84 76 ff ff ff    	je     801041f8 <procdump+0x18>
        cprintf(" %p", pc[i]);
80104282:	83 ec 08             	sub    $0x8,%esp
80104285:	83 c7 04             	add    $0x4,%edi
80104288:	52                   	push   %edx
80104289:	68 a1 75 10 80       	push   $0x801075a1
8010428e:	e8 cd c3 ff ff       	call   80100660 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
80104293:	83 c4 10             	add    $0x10,%esp
80104296:	39 fe                	cmp    %edi,%esi
80104298:	75 de                	jne    80104278 <procdump+0x98>
8010429a:	e9 59 ff ff ff       	jmp    801041f8 <procdump+0x18>
8010429f:	90                   	nop
}
801042a0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801042a3:	5b                   	pop    %ebx
801042a4:	5e                   	pop    %esi
801042a5:	5f                   	pop    %edi
801042a6:	5d                   	pop    %ebp
801042a7:	c3                   	ret    
801042a8:	90                   	nop
801042a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801042b0 <sigprocmask>:
uint sigprocmask (uint sigmask){
801042b0:	55                   	push   %ebp
801042b1:	89 e5                	mov    %esp,%ebp
801042b3:	56                   	push   %esi
801042b4:	53                   	push   %ebx
801042b5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
801042b8:	e8 13 05 00 00       	call   801047d0 <pushcli>
  c = mycpu();
801042bd:	e8 ae f5 ff ff       	call   80103870 <mycpu>
  p = c->proc;
801042c2:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
801042c8:	e8 43 05 00 00       	call   80104810 <popcli>
  if (((sigmask & 1<<SIGKILL) == 1<<SIGKILL))
801042cd:	f7 c3 00 02 02 00    	test   $0x20200,%ebx
801042d3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801042d8:	75 0c                	jne    801042e6 <sigprocmask+0x36>
  uint oldmask = p->signal_mask;
801042da:	8b 86 84 00 00 00    	mov    0x84(%esi),%eax
  p->signal_mask = sigmask;
801042e0:	89 9e 84 00 00 00    	mov    %ebx,0x84(%esi)
}
801042e6:	5b                   	pop    %ebx
801042e7:	5e                   	pop    %esi
801042e8:	5d                   	pop    %ebp
801042e9:	c3                   	ret    
801042ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801042f0 <sigaction>:
int sigaction(int signum , const struct sigaction *act, struct sigaction *oldact){
801042f0:	55                   	push   %ebp
801042f1:	89 e5                	mov    %esp,%ebp
801042f3:	57                   	push   %edi
801042f4:	56                   	push   %esi
801042f5:	53                   	push   %ebx
801042f6:	83 ec 0c             	sub    $0xc,%esp
801042f9:	8b 75 08             	mov    0x8(%ebp),%esi
801042fc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  pushcli();
801042ff:	e8 cc 04 00 00       	call   801047d0 <pushcli>
  c = mycpu();
80104304:	e8 67 f5 ff ff       	call   80103870 <mycpu>
  p = c->proc;
80104309:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
8010430f:	e8 fc 04 00 00       	call   80104810 <popcli>
    if (signum > 31 || signum < 0 || signum == SIGSTOP || signum == SIGKILL)
80104314:	8d 46 f7             	lea    -0x9(%esi),%eax
80104317:	83 e0 f7             	and    $0xfffffff7,%eax
8010431a:	74 44                	je     80104360 <sigaction+0x70>
8010431c:	83 fe 1f             	cmp    $0x1f,%esi
8010431f:	77 3f                	ja     80104360 <sigaction+0x70>
    if (oldact != null){
80104321:	8b 45 10             	mov    0x10(%ebp),%eax
80104324:	85 c0                	test   %eax,%eax
80104326:	74 16                	je     8010433e <sigaction+0x4e>
      *oldact = p->signal_handlers[signum];
80104328:	8b 84 f3 8c 00 00 00 	mov    0x8c(%ebx,%esi,8),%eax
8010432f:	8b 94 f3 90 00 00 00 	mov    0x90(%ebx,%esi,8),%edx
80104336:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104339:	89 01                	mov    %eax,(%ecx)
8010433b:	89 51 04             	mov    %edx,0x4(%ecx)
    p->signal_handlers[signum].sa_handler = act->sa_handler;
8010433e:	8b 17                	mov    (%edi),%edx
80104340:	8d 04 f3             	lea    (%ebx,%esi,8),%eax
80104343:	89 90 8c 00 00 00    	mov    %edx,0x8c(%eax)
    p->signal_handlers[signum].sigmask = act->sigmask;
80104349:	8b 57 04             	mov    0x4(%edi),%edx
8010434c:	89 90 90 00 00 00    	mov    %edx,0x90(%eax)
    return 0;
80104352:	31 c0                	xor    %eax,%eax
}
80104354:	83 c4 0c             	add    $0xc,%esp
80104357:	5b                   	pop    %ebx
80104358:	5e                   	pop    %esi
80104359:	5f                   	pop    %edi
8010435a:	5d                   	pop    %ebp
8010435b:	c3                   	ret    
8010435c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      return -1;
80104360:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104365:	eb ed                	jmp    80104354 <sigaction+0x64>
80104367:	89 f6                	mov    %esi,%esi
80104369:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104370 <sigret>:
void sigret(void){
80104370:	55                   	push   %ebp
80104371:	89 e5                	mov    %esp,%ebp
80104373:	57                   	push   %edi
80104374:	56                   	push   %esi
80104375:	53                   	push   %ebx
80104376:	83 ec 0c             	sub    $0xc,%esp
  pushcli();
80104379:	e8 52 04 00 00       	call   801047d0 <pushcli>
  c = mycpu();
8010437e:	e8 ed f4 ff ff       	call   80103870 <mycpu>
  p = c->proc;
80104383:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104389:	e8 82 04 00 00       	call   80104810 <popcli>
  *p->tf = *p->backup; 
8010438e:	b9 13 00 00 00       	mov    $0x13,%ecx
80104393:	8b 73 7c             	mov    0x7c(%ebx),%esi
80104396:	8b 7b 18             	mov    0x18(%ebx),%edi
80104399:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
   p->already_in_signal = 0;
8010439b:	c7 83 90 01 00 00 00 	movl   $0x0,0x190(%ebx)
801043a2:	00 00 00 
   p->signal_mask = p->signal_mask_backup;
801043a5:	8b 83 88 00 00 00    	mov    0x88(%ebx),%eax
801043ab:	89 83 84 00 00 00    	mov    %eax,0x84(%ebx)
}
801043b1:	83 c4 0c             	add    $0xc,%esp
801043b4:	5b                   	pop    %ebx
801043b5:	5e                   	pop    %esi
801043b6:	5f                   	pop    %edi
801043b7:	5d                   	pop    %ebp
801043b8:	c3                   	ret    
801043b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801043c0 <stop_handler>:
void stop_handler(void){
801043c0:	55                   	push   %ebp
801043c1:	89 e5                	mov    %esp,%ebp
801043c3:	53                   	push   %ebx
801043c4:	83 ec 04             	sub    $0x4,%esp
  pushcli();
801043c7:	e8 04 04 00 00       	call   801047d0 <pushcli>
  c = mycpu();
801043cc:	e8 9f f4 ff ff       	call   80103870 <mycpu>
  p = c->proc;
801043d1:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801043d7:	e8 34 04 00 00       	call   80104810 <popcli>
  p->suspended = 1;
801043dc:	c7 83 8c 01 00 00 01 	movl   $0x1,0x18c(%ebx)
801043e3:	00 00 00 
}
801043e6:	83 c4 04             	add    $0x4,%esp
801043e9:	5b                   	pop    %ebx
801043ea:	5d                   	pop    %ebp
  yield(); 
801043eb:	e9 f0 fa ff ff       	jmp    80103ee0 <yield>

801043f0 <cont_handler>:
void cont_handler(void){
801043f0:	55                   	push   %ebp
801043f1:	89 e5                	mov    %esp,%ebp
801043f3:	53                   	push   %ebx
801043f4:	83 ec 04             	sub    $0x4,%esp
  pushcli();
801043f7:	e8 d4 03 00 00       	call   801047d0 <pushcli>
  c = mycpu();
801043fc:	e8 6f f4 ff ff       	call   80103870 <mycpu>
  p = c->proc;
80104401:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104407:	e8 04 04 00 00       	call   80104810 <popcli>
  if (p-> suspended == 1)
8010440c:	83 bb 8c 01 00 00 01 	cmpl   $0x1,0x18c(%ebx)
80104413:	75 0a                	jne    8010441f <cont_handler+0x2f>
    p->suspended = 0; 
80104415:	c7 83 8c 01 00 00 00 	movl   $0x0,0x18c(%ebx)
8010441c:	00 00 00 
}
8010441f:	83 c4 04             	add    $0x4,%esp
80104422:	5b                   	pop    %ebx
80104423:	5d                   	pop    %ebp
80104424:	c3                   	ret    
80104425:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104429:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104430 <default_handlers>:

void default_handlers(int i){
80104430:	55                   	push   %ebp
80104431:	89 e5                	mov    %esp,%ebp
80104433:	8b 45 08             	mov    0x8(%ebp),%eax
  if(i == SIGCONT)
80104436:	83 f8 13             	cmp    $0x13,%eax
80104439:	74 25                	je     80104460 <default_handlers+0x30>
    cont_handler();
  else if(i==SIGSTOP)
8010443b:	83 f8 11             	cmp    $0x11,%eax
8010443e:	74 10                	je     80104450 <default_handlers+0x20>
    stop_handler();
  else
    kill_handler();

}
80104440:	5d                   	pop    %ebp
    kill_handler();
80104441:	e9 6a fd ff ff       	jmp    801041b0 <kill_handler>
80104446:	8d 76 00             	lea    0x0(%esi),%esi
80104449:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
}
80104450:	5d                   	pop    %ebp
    stop_handler();
80104451:	e9 6a ff ff ff       	jmp    801043c0 <stop_handler>
80104456:	8d 76 00             	lea    0x0(%esi),%esi
80104459:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
}
80104460:	5d                   	pop    %ebp
    cont_handler();
80104461:	eb 8d                	jmp    801043f0 <cont_handler>
80104463:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104469:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104470 <user_handlers>:

void user_handlers(int i, struct proc * p){
80104470:	55                   	push   %ebp
    int functionSize = ((int)default_handlers - (int)call_sigret); 
    //backup trapframe 
    *p->backup = *p->tf;
80104471:	b9 13 00 00 00       	mov    $0x13,%ecx
    int functionSize = ((int)default_handlers - (int)call_sigret); 
80104476:	b8 30 44 10 80       	mov    $0x80104430,%eax
8010447b:	2d b0 36 10 80       	sub    $0x801036b0,%eax
void user_handlers(int i, struct proc * p){
80104480:	89 e5                	mov    %esp,%ebp
80104482:	57                   	push   %edi
80104483:	56                   	push   %esi
80104484:	53                   	push   %ebx
80104485:	83 ec 20             	sub    $0x20,%esp
80104488:	8b 5d 0c             	mov    0xc(%ebp),%ebx
8010448b:	8b 55 08             	mov    0x8(%ebp),%edx
    *p->backup = *p->tf;
8010448e:	8b 73 18             	mov    0x18(%ebx),%esi
80104491:	8b 7b 7c             	mov    0x7c(%ebx),%edi
80104494:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
void user_handlers(int i, struct proc * p){
80104496:	89 55 e4             	mov    %edx,-0x1c(%ebp)

    //put functionn
    p->tf->esp -= functionSize;
80104499:	8b 4b 18             	mov    0x18(%ebx),%ecx
8010449c:	29 41 44             	sub    %eax,0x44(%ecx)
    memmove((int*)p->tf->esp, &call_sigret, functionSize);
8010449f:	50                   	push   %eax
801044a0:	68 b0 36 10 80       	push   $0x801036b0
801044a5:	8b 43 18             	mov    0x18(%ebx),%eax
801044a8:	ff 70 44             	pushl  0x44(%eax)
801044ab:	e8 b0 05 00 00       	call   80104a60 <memmove>
    uint returnAdress = p->tf->esp;
801044b0:	8b 4b 18             	mov    0x18(%ebx),%ecx

    // push argumants
    p->tf->esp -= sizeof i;
    *(int*)p->tf->esp = i;
801044b3:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    //push return address
    p->tf->esp -= sizeof(int);
    *(int*)p->tf->esp = returnAdress; //adrees to the function that calls sigret 
    struct sigaction handler = p->signal_handlers[i]; 
    p->tf->eip = (uint)handler.sa_handler; 
    trapret_handler(p->tf);
801044b6:	83 c4 10             	add    $0x10,%esp
    uint returnAdress = p->tf->esp;
801044b9:	8b 41 44             	mov    0x44(%ecx),%eax
    p->tf->esp -= sizeof i;
801044bc:	8d 70 fc             	lea    -0x4(%eax),%esi
801044bf:	89 71 44             	mov    %esi,0x44(%ecx)
    *(int*)p->tf->esp = i;
801044c2:	8b 4b 18             	mov    0x18(%ebx),%ecx
801044c5:	8b 49 44             	mov    0x44(%ecx),%ecx
801044c8:	89 11                	mov    %edx,(%ecx)
    p->tf->esp -= sizeof(int);
801044ca:	8b 4b 18             	mov    0x18(%ebx),%ecx
801044cd:	83 69 44 04          	subl   $0x4,0x44(%ecx)
    *(int*)p->tf->esp = returnAdress; //adrees to the function that calls sigret 
801044d1:	8b 4b 18             	mov    0x18(%ebx),%ecx
801044d4:	8b 49 44             	mov    0x44(%ecx),%ecx
801044d7:	89 01                	mov    %eax,(%ecx)
    p->tf->eip = (uint)handler.sa_handler; 
801044d9:	8b 43 18             	mov    0x18(%ebx),%eax
801044dc:	8b 94 d3 8c 00 00 00 	mov    0x8c(%ebx,%edx,8),%edx
801044e3:	89 50 38             	mov    %edx,0x38(%eax)
    trapret_handler(p->tf);
801044e6:	8b 43 18             	mov    0x18(%ebx),%eax
801044e9:	89 45 08             	mov    %eax,0x8(%ebp)

}
801044ec:	8d 65 f4             	lea    -0xc(%ebp),%esp
801044ef:	5b                   	pop    %ebx
801044f0:	5e                   	pop    %esi
801044f1:	5f                   	pop    %edi
801044f2:	5d                   	pop    %ebp
    trapret_handler(p->tf);
801044f3:	e9 8f 17 00 00       	jmp    80105c87 <trapret_handler>
801044f8:	90                   	nop
801044f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104500 <check_for_signals>:

void check_for_signals(void){
80104500:	55                   	push   %ebp
80104501:	89 e5                	mov    %esp,%ebp
80104503:	57                   	push   %edi
80104504:	56                   	push   %esi
80104505:	53                   	push   %ebx
80104506:	83 ec 0c             	sub    $0xc,%esp
  pushcli();
80104509:	e8 c2 02 00 00       	call   801047d0 <pushcli>
  c = mycpu();
8010450e:	e8 5d f3 ff ff       	call   80103870 <mycpu>
  p = c->proc;
80104513:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80104519:	e8 f2 02 00 00       	call   80104810 <popcli>
  struct proc *p = myproc();
  if (p == 0)
8010451e:	85 f6                	test   %esi,%esi
80104520:	74 0a                	je     8010452c <check_for_signals+0x2c>
    return; 
  if(p->already_in_signal)
80104522:	8b 9e 90 01 00 00    	mov    0x190(%esi),%ebx
80104528:	85 db                	test   %ebx,%ebx
8010452a:	74 2c                	je     80104558 <check_for_signals+0x58>
          user_handlers(i, p);
        }      
     }
    }
  }
}
8010452c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010452f:	5b                   	pop    %ebx
80104530:	5e                   	pop    %esi
80104531:	5f                   	pop    %edi
80104532:	5d                   	pop    %ebp
80104533:	c3                   	ret    
80104534:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
          user_handlers(i, p);
80104538:	83 ec 08             	sub    $0x8,%esp
          p->already_in_signal = 1; 
8010453b:	c7 86 90 01 00 00 01 	movl   $0x1,0x190(%esi)
80104542:	00 00 00 
          user_handlers(i, p);
80104545:	56                   	push   %esi
80104546:	53                   	push   %ebx
80104547:	e8 24 ff ff ff       	call   80104470 <user_handlers>
8010454c:	83 c4 10             	add    $0x10,%esp
8010454f:	90                   	nop
  for(int i=0; i<32; i=i+1){
80104550:	83 c3 01             	add    $0x1,%ebx
80104553:	83 fb 20             	cmp    $0x20,%ebx
80104556:	74 d4                	je     8010452c <check_for_signals+0x2c>
    signal_index = 1<<i; 
80104558:	89 d9                	mov    %ebx,%ecx
8010455a:	b8 01 00 00 00       	mov    $0x1,%eax
    is_blocked = (p->signal_mask & signal_index) == signal_index; //check if signal is blocked 
8010455f:	8b 96 84 00 00 00    	mov    0x84(%esi),%edx
    signal_index = 1<<i; 
80104565:	d3 e0                	shl    %cl,%eax
    if(((p->pending_signals & signal_index) == signal_index) & !is_blocked){
80104567:	8b 8e 80 00 00 00    	mov    0x80(%esi),%ecx
8010456d:	89 c7                	mov    %eax,%edi
8010456f:	21 cf                	and    %ecx,%edi
80104571:	39 c7                	cmp    %eax,%edi
80104573:	75 db                	jne    80104550 <check_for_signals+0x50>
    is_blocked = (p->signal_mask & signal_index) == signal_index; //check if signal is blocked 
80104575:	89 d7                	mov    %edx,%edi
80104577:	21 c7                	and    %eax,%edi
    if(((p->pending_signals & signal_index) == signal_index) & !is_blocked){
80104579:	39 c7                	cmp    %eax,%edi
8010457b:	74 d3                	je     80104550 <check_for_signals+0x50>
      p->pending_signals = p->pending_signals & (~signal_index); //discard signal
8010457d:	f7 d0                	not    %eax
8010457f:	21 c8                	and    %ecx,%eax
80104581:	89 86 80 00 00 00    	mov    %eax,0x80(%esi)
      if(p->signal_handlers[i].sa_handler != (void*)SIG_IGN){
80104587:	8b 84 de 8c 00 00 00 	mov    0x8c(%esi,%ebx,8),%eax
8010458e:	83 f8 01             	cmp    $0x1,%eax
80104591:	74 bd                	je     80104550 <check_for_signals+0x50>
        p->signal_mask_backup = p->signal_mask;
80104593:	89 96 88 00 00 00    	mov    %edx,0x88(%esi)
        p->signal_mask = p->signal_handlers[i].sigmask;
80104599:	8b 94 de 90 00 00 00 	mov    0x90(%esi,%ebx,8),%edx
        if (p->signal_handlers[i].sa_handler == SIG_DFL){
801045a0:	85 c0                	test   %eax,%eax
        p->signal_mask = p->signal_handlers[i].sigmask;
801045a2:	89 96 84 00 00 00    	mov    %edx,0x84(%esi)
        if (p->signal_handlers[i].sa_handler == SIG_DFL){
801045a8:	74 26                	je     801045d0 <check_for_signals+0xd0>
        else if ((int)p->signal_handlers[i].sa_handler == SIGSTOP){
801045aa:	83 f8 11             	cmp    $0x11,%eax
801045ad:	74 41                	je     801045f0 <check_for_signals+0xf0>
        else if ((int)p->signal_handlers[i].sa_handler == SIGKILL){
801045af:	83 f8 09             	cmp    $0x9,%eax
801045b2:	74 5c                	je     80104610 <check_for_signals+0x110>
        else if ((int)p->signal_handlers[i].sa_handler == SIGCONT){
801045b4:	83 f8 13             	cmp    $0x13,%eax
801045b7:	0f 85 7b ff ff ff    	jne    80104538 <check_for_signals+0x38>
          cont_handler();
801045bd:	e8 2e fe ff ff       	call   801043f0 <cont_handler>
          p->signal_mask = p->signal_mask_backup;
801045c2:	8b 86 88 00 00 00    	mov    0x88(%esi),%eax
801045c8:	89 86 84 00 00 00    	mov    %eax,0x84(%esi)
801045ce:	eb 80                	jmp    80104550 <check_for_signals+0x50>
          default_handlers(i);
801045d0:	83 ec 0c             	sub    $0xc,%esp
801045d3:	53                   	push   %ebx
801045d4:	e8 57 fe ff ff       	call   80104430 <default_handlers>
          p->signal_mask = p->signal_mask_backup;
801045d9:	8b 86 88 00 00 00    	mov    0x88(%esi),%eax
801045df:	83 c4 10             	add    $0x10,%esp
801045e2:	89 86 84 00 00 00    	mov    %eax,0x84(%esi)
801045e8:	e9 63 ff ff ff       	jmp    80104550 <check_for_signals+0x50>
801045ed:	8d 76 00             	lea    0x0(%esi),%esi
          stop_handler();
801045f0:	e8 cb fd ff ff       	call   801043c0 <stop_handler>
          p->signal_mask = p->signal_mask_backup;
801045f5:	8b 86 88 00 00 00    	mov    0x88(%esi),%eax
801045fb:	89 86 84 00 00 00    	mov    %eax,0x84(%esi)
80104601:	e9 4a ff ff ff       	jmp    80104550 <check_for_signals+0x50>
80104606:	8d 76 00             	lea    0x0(%esi),%esi
80104609:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
          kill_handler();
80104610:	e8 9b fb ff ff       	call   801041b0 <kill_handler>
          p->signal_mask = p->signal_mask_backup;
80104615:	8b 86 88 00 00 00    	mov    0x88(%esi),%eax
8010461b:	89 86 84 00 00 00    	mov    %eax,0x84(%esi)
80104621:	e9 2a ff ff ff       	jmp    80104550 <check_for_signals+0x50>
80104626:	66 90                	xchg   %ax,%ax
80104628:	66 90                	xchg   %ax,%ax
8010462a:	66 90                	xchg   %ax,%ax
8010462c:	66 90                	xchg   %ax,%ax
8010462e:	66 90                	xchg   %ax,%ax

80104630 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80104630:	55                   	push   %ebp
80104631:	89 e5                	mov    %esp,%ebp
80104633:	53                   	push   %ebx
80104634:	83 ec 0c             	sub    $0xc,%esp
80104637:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
8010463a:	68 c8 7b 10 80       	push   $0x80107bc8
8010463f:	8d 43 04             	lea    0x4(%ebx),%eax
80104642:	50                   	push   %eax
80104643:	e8 18 01 00 00       	call   80104760 <initlock>
  lk->name = name;
80104648:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
8010464b:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
80104651:	83 c4 10             	add    $0x10,%esp
  lk->pid = 0;
80104654:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
8010465b:	89 43 38             	mov    %eax,0x38(%ebx)
}
8010465e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104661:	c9                   	leave  
80104662:	c3                   	ret    
80104663:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104669:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104670 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80104670:	55                   	push   %ebp
80104671:	89 e5                	mov    %esp,%ebp
80104673:	56                   	push   %esi
80104674:	53                   	push   %ebx
80104675:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104678:	83 ec 0c             	sub    $0xc,%esp
8010467b:	8d 73 04             	lea    0x4(%ebx),%esi
8010467e:	56                   	push   %esi
8010467f:	e8 1c 02 00 00       	call   801048a0 <acquire>
  while (lk->locked) {
80104684:	8b 13                	mov    (%ebx),%edx
80104686:	83 c4 10             	add    $0x10,%esp
80104689:	85 d2                	test   %edx,%edx
8010468b:	74 16                	je     801046a3 <acquiresleep+0x33>
8010468d:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
80104690:	83 ec 08             	sub    $0x8,%esp
80104693:	56                   	push   %esi
80104694:	53                   	push   %ebx
80104695:	e8 86 f8 ff ff       	call   80103f20 <sleep>
  while (lk->locked) {
8010469a:	8b 03                	mov    (%ebx),%eax
8010469c:	83 c4 10             	add    $0x10,%esp
8010469f:	85 c0                	test   %eax,%eax
801046a1:	75 ed                	jne    80104690 <acquiresleep+0x20>
  }
  lk->locked = 1;
801046a3:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
801046a9:	e8 62 f2 ff ff       	call   80103910 <myproc>
801046ae:	8b 40 10             	mov    0x10(%eax),%eax
801046b1:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
801046b4:	89 75 08             	mov    %esi,0x8(%ebp)
}
801046b7:	8d 65 f8             	lea    -0x8(%ebp),%esp
801046ba:	5b                   	pop    %ebx
801046bb:	5e                   	pop    %esi
801046bc:	5d                   	pop    %ebp
  release(&lk->lk);
801046bd:	e9 9e 02 00 00       	jmp    80104960 <release>
801046c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801046c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801046d0 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
801046d0:	55                   	push   %ebp
801046d1:	89 e5                	mov    %esp,%ebp
801046d3:	56                   	push   %esi
801046d4:	53                   	push   %ebx
801046d5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
801046d8:	83 ec 0c             	sub    $0xc,%esp
801046db:	8d 73 04             	lea    0x4(%ebx),%esi
801046de:	56                   	push   %esi
801046df:	e8 bc 01 00 00       	call   801048a0 <acquire>
  lk->locked = 0;
801046e4:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
801046ea:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
801046f1:	89 1c 24             	mov    %ebx,(%esp)
801046f4:	e8 d7 f9 ff ff       	call   801040d0 <wakeup>
  release(&lk->lk);
801046f9:	89 75 08             	mov    %esi,0x8(%ebp)
801046fc:	83 c4 10             	add    $0x10,%esp
}
801046ff:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104702:	5b                   	pop    %ebx
80104703:	5e                   	pop    %esi
80104704:	5d                   	pop    %ebp
  release(&lk->lk);
80104705:	e9 56 02 00 00       	jmp    80104960 <release>
8010470a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104710 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
80104710:	55                   	push   %ebp
80104711:	89 e5                	mov    %esp,%ebp
80104713:	57                   	push   %edi
80104714:	56                   	push   %esi
80104715:	53                   	push   %ebx
80104716:	31 ff                	xor    %edi,%edi
80104718:	83 ec 18             	sub    $0x18,%esp
8010471b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  
  acquire(&lk->lk);
8010471e:	8d 73 04             	lea    0x4(%ebx),%esi
80104721:	56                   	push   %esi
80104722:	e8 79 01 00 00       	call   801048a0 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
80104727:	8b 03                	mov    (%ebx),%eax
80104729:	83 c4 10             	add    $0x10,%esp
8010472c:	85 c0                	test   %eax,%eax
8010472e:	74 13                	je     80104743 <holdingsleep+0x33>
80104730:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
80104733:	e8 d8 f1 ff ff       	call   80103910 <myproc>
80104738:	39 58 10             	cmp    %ebx,0x10(%eax)
8010473b:	0f 94 c0             	sete   %al
8010473e:	0f b6 c0             	movzbl %al,%eax
80104741:	89 c7                	mov    %eax,%edi
  release(&lk->lk);
80104743:	83 ec 0c             	sub    $0xc,%esp
80104746:	56                   	push   %esi
80104747:	e8 14 02 00 00       	call   80104960 <release>
  return r;
}
8010474c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010474f:	89 f8                	mov    %edi,%eax
80104751:	5b                   	pop    %ebx
80104752:	5e                   	pop    %esi
80104753:	5f                   	pop    %edi
80104754:	5d                   	pop    %ebp
80104755:	c3                   	ret    
80104756:	66 90                	xchg   %ax,%ax
80104758:	66 90                	xchg   %ax,%ax
8010475a:	66 90                	xchg   %ax,%ax
8010475c:	66 90                	xchg   %ax,%ax
8010475e:	66 90                	xchg   %ax,%ax

80104760 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80104760:	55                   	push   %ebp
80104761:	89 e5                	mov    %esp,%ebp
80104763:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80104766:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80104769:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
8010476f:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
80104772:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80104779:	5d                   	pop    %ebp
8010477a:	c3                   	ret    
8010477b:	90                   	nop
8010477c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104780 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104780:	55                   	push   %ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104781:	31 d2                	xor    %edx,%edx
{
80104783:	89 e5                	mov    %esp,%ebp
80104785:	53                   	push   %ebx
  ebp = (uint*)v - 2;
80104786:	8b 45 08             	mov    0x8(%ebp),%eax
{
80104789:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  ebp = (uint*)v - 2;
8010478c:	83 e8 08             	sub    $0x8,%eax
8010478f:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104790:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
80104796:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
8010479c:	77 1a                	ja     801047b8 <getcallerpcs+0x38>
      break;
    pcs[i] = ebp[1];     // saved %eip
8010479e:	8b 58 04             	mov    0x4(%eax),%ebx
801047a1:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
801047a4:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
801047a7:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
801047a9:	83 fa 0a             	cmp    $0xa,%edx
801047ac:	75 e2                	jne    80104790 <getcallerpcs+0x10>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
801047ae:	5b                   	pop    %ebx
801047af:	5d                   	pop    %ebp
801047b0:	c3                   	ret    
801047b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801047b8:	8d 04 91             	lea    (%ecx,%edx,4),%eax
801047bb:	83 c1 28             	add    $0x28,%ecx
801047be:	66 90                	xchg   %ax,%ax
    pcs[i] = 0;
801047c0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
801047c6:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
801047c9:	39 c1                	cmp    %eax,%ecx
801047cb:	75 f3                	jne    801047c0 <getcallerpcs+0x40>
}
801047cd:	5b                   	pop    %ebx
801047ce:	5d                   	pop    %ebp
801047cf:	c3                   	ret    

801047d0 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
801047d0:	55                   	push   %ebp
801047d1:	89 e5                	mov    %esp,%ebp
801047d3:	53                   	push   %ebx
801047d4:	83 ec 04             	sub    $0x4,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801047d7:	9c                   	pushf  
801047d8:	5b                   	pop    %ebx
  asm volatile("cli");
801047d9:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
801047da:	e8 91 f0 ff ff       	call   80103870 <mycpu>
801047df:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
801047e5:	85 c0                	test   %eax,%eax
801047e7:	75 11                	jne    801047fa <pushcli+0x2a>
    mycpu()->intena = eflags & FL_IF;
801047e9:	81 e3 00 02 00 00    	and    $0x200,%ebx
801047ef:	e8 7c f0 ff ff       	call   80103870 <mycpu>
801047f4:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
  mycpu()->ncli += 1;
801047fa:	e8 71 f0 ff ff       	call   80103870 <mycpu>
801047ff:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
80104806:	83 c4 04             	add    $0x4,%esp
80104809:	5b                   	pop    %ebx
8010480a:	5d                   	pop    %ebp
8010480b:	c3                   	ret    
8010480c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104810 <popcli>:

void
popcli(void)
{
80104810:	55                   	push   %ebp
80104811:	89 e5                	mov    %esp,%ebp
80104813:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104816:	9c                   	pushf  
80104817:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104818:	f6 c4 02             	test   $0x2,%ah
8010481b:	75 35                	jne    80104852 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
8010481d:	e8 4e f0 ff ff       	call   80103870 <mycpu>
80104822:	83 a8 a4 00 00 00 01 	subl   $0x1,0xa4(%eax)
80104829:	78 34                	js     8010485f <popcli+0x4f>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
8010482b:	e8 40 f0 ff ff       	call   80103870 <mycpu>
80104830:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80104836:	85 d2                	test   %edx,%edx
80104838:	74 06                	je     80104840 <popcli+0x30>
    sti();
}
8010483a:	c9                   	leave  
8010483b:	c3                   	ret    
8010483c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104840:	e8 2b f0 ff ff       	call   80103870 <mycpu>
80104845:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
8010484b:	85 c0                	test   %eax,%eax
8010484d:	74 eb                	je     8010483a <popcli+0x2a>
  asm volatile("sti");
8010484f:	fb                   	sti    
}
80104850:	c9                   	leave  
80104851:	c3                   	ret    
    panic("popcli - interruptible");
80104852:	83 ec 0c             	sub    $0xc,%esp
80104855:	68 d3 7b 10 80       	push   $0x80107bd3
8010485a:	e8 31 bb ff ff       	call   80100390 <panic>
    panic("popcli");
8010485f:	83 ec 0c             	sub    $0xc,%esp
80104862:	68 ea 7b 10 80       	push   $0x80107bea
80104867:	e8 24 bb ff ff       	call   80100390 <panic>
8010486c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104870 <holding>:
{
80104870:	55                   	push   %ebp
80104871:	89 e5                	mov    %esp,%ebp
80104873:	56                   	push   %esi
80104874:	53                   	push   %ebx
80104875:	8b 75 08             	mov    0x8(%ebp),%esi
80104878:	31 db                	xor    %ebx,%ebx
  pushcli();
8010487a:	e8 51 ff ff ff       	call   801047d0 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
8010487f:	8b 06                	mov    (%esi),%eax
80104881:	85 c0                	test   %eax,%eax
80104883:	74 10                	je     80104895 <holding+0x25>
80104885:	8b 5e 08             	mov    0x8(%esi),%ebx
80104888:	e8 e3 ef ff ff       	call   80103870 <mycpu>
8010488d:	39 c3                	cmp    %eax,%ebx
8010488f:	0f 94 c3             	sete   %bl
80104892:	0f b6 db             	movzbl %bl,%ebx
  popcli();
80104895:	e8 76 ff ff ff       	call   80104810 <popcli>
}
8010489a:	89 d8                	mov    %ebx,%eax
8010489c:	5b                   	pop    %ebx
8010489d:	5e                   	pop    %esi
8010489e:	5d                   	pop    %ebp
8010489f:	c3                   	ret    

801048a0 <acquire>:
{
801048a0:	55                   	push   %ebp
801048a1:	89 e5                	mov    %esp,%ebp
801048a3:	56                   	push   %esi
801048a4:	53                   	push   %ebx
  pushcli(); // disable interrupts to avoid deadlock.
801048a5:	e8 26 ff ff ff       	call   801047d0 <pushcli>
  if(holding(lk))
801048aa:	8b 5d 08             	mov    0x8(%ebp),%ebx
801048ad:	83 ec 0c             	sub    $0xc,%esp
801048b0:	53                   	push   %ebx
801048b1:	e8 ba ff ff ff       	call   80104870 <holding>
801048b6:	83 c4 10             	add    $0x10,%esp
801048b9:	85 c0                	test   %eax,%eax
801048bb:	0f 85 83 00 00 00    	jne    80104944 <acquire+0xa4>
801048c1:	89 c6                	mov    %eax,%esi
  asm volatile("lock; xchgl %0, %1" :
801048c3:	ba 01 00 00 00       	mov    $0x1,%edx
801048c8:	eb 09                	jmp    801048d3 <acquire+0x33>
801048ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801048d0:	8b 5d 08             	mov    0x8(%ebp),%ebx
801048d3:	89 d0                	mov    %edx,%eax
801048d5:	f0 87 03             	lock xchg %eax,(%ebx)
  while(xchg(&lk->locked, 1) != 0)
801048d8:	85 c0                	test   %eax,%eax
801048da:	75 f4                	jne    801048d0 <acquire+0x30>
  __sync_synchronize();
801048dc:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
801048e1:	8b 5d 08             	mov    0x8(%ebp),%ebx
801048e4:	e8 87 ef ff ff       	call   80103870 <mycpu>
  getcallerpcs(&lk, lk->pcs);
801048e9:	8d 53 0c             	lea    0xc(%ebx),%edx
  lk->cpu = mycpu();
801048ec:	89 43 08             	mov    %eax,0x8(%ebx)
  ebp = (uint*)v - 2;
801048ef:	89 e8                	mov    %ebp,%eax
801048f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801048f8:	8d 88 00 00 00 80    	lea    -0x80000000(%eax),%ecx
801048fe:	81 f9 fe ff ff 7f    	cmp    $0x7ffffffe,%ecx
80104904:	77 1a                	ja     80104920 <acquire+0x80>
    pcs[i] = ebp[1];     // saved %eip
80104906:	8b 48 04             	mov    0x4(%eax),%ecx
80104909:	89 0c b2             	mov    %ecx,(%edx,%esi,4)
  for(i = 0; i < 10; i++){
8010490c:	83 c6 01             	add    $0x1,%esi
    ebp = (uint*)ebp[0]; // saved %ebp
8010490f:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80104911:	83 fe 0a             	cmp    $0xa,%esi
80104914:	75 e2                	jne    801048f8 <acquire+0x58>
}
80104916:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104919:	5b                   	pop    %ebx
8010491a:	5e                   	pop    %esi
8010491b:	5d                   	pop    %ebp
8010491c:	c3                   	ret    
8010491d:	8d 76 00             	lea    0x0(%esi),%esi
80104920:	8d 04 b2             	lea    (%edx,%esi,4),%eax
80104923:	83 c2 28             	add    $0x28,%edx
80104926:	8d 76 00             	lea    0x0(%esi),%esi
80104929:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    pcs[i] = 0;
80104930:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104936:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
80104939:	39 d0                	cmp    %edx,%eax
8010493b:	75 f3                	jne    80104930 <acquire+0x90>
}
8010493d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104940:	5b                   	pop    %ebx
80104941:	5e                   	pop    %esi
80104942:	5d                   	pop    %ebp
80104943:	c3                   	ret    
    panic("acquire");
80104944:	83 ec 0c             	sub    $0xc,%esp
80104947:	68 f1 7b 10 80       	push   $0x80107bf1
8010494c:	e8 3f ba ff ff       	call   80100390 <panic>
80104951:	eb 0d                	jmp    80104960 <release>
80104953:	90                   	nop
80104954:	90                   	nop
80104955:	90                   	nop
80104956:	90                   	nop
80104957:	90                   	nop
80104958:	90                   	nop
80104959:	90                   	nop
8010495a:	90                   	nop
8010495b:	90                   	nop
8010495c:	90                   	nop
8010495d:	90                   	nop
8010495e:	90                   	nop
8010495f:	90                   	nop

80104960 <release>:
{
80104960:	55                   	push   %ebp
80104961:	89 e5                	mov    %esp,%ebp
80104963:	53                   	push   %ebx
80104964:	83 ec 10             	sub    $0x10,%esp
80104967:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holding(lk))
8010496a:	53                   	push   %ebx
8010496b:	e8 00 ff ff ff       	call   80104870 <holding>
80104970:	83 c4 10             	add    $0x10,%esp
80104973:	85 c0                	test   %eax,%eax
80104975:	74 22                	je     80104999 <release+0x39>
  lk->pcs[0] = 0;
80104977:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
8010497e:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
80104985:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
8010498a:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
80104990:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104993:	c9                   	leave  
  popcli();
80104994:	e9 77 fe ff ff       	jmp    80104810 <popcli>
    panic("release");
80104999:	83 ec 0c             	sub    $0xc,%esp
8010499c:	68 f9 7b 10 80       	push   $0x80107bf9
801049a1:	e8 ea b9 ff ff       	call   80100390 <panic>
801049a6:	66 90                	xchg   %ax,%ax
801049a8:	66 90                	xchg   %ax,%ax
801049aa:	66 90                	xchg   %ax,%ax
801049ac:	66 90                	xchg   %ax,%ax
801049ae:	66 90                	xchg   %ax,%ax

801049b0 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
801049b0:	55                   	push   %ebp
801049b1:	89 e5                	mov    %esp,%ebp
801049b3:	57                   	push   %edi
801049b4:	53                   	push   %ebx
801049b5:	8b 55 08             	mov    0x8(%ebp),%edx
801049b8:	8b 4d 10             	mov    0x10(%ebp),%ecx
  if ((int)dst%4 == 0 && n%4 == 0){
801049bb:	f6 c2 03             	test   $0x3,%dl
801049be:	75 05                	jne    801049c5 <memset+0x15>
801049c0:	f6 c1 03             	test   $0x3,%cl
801049c3:	74 13                	je     801049d8 <memset+0x28>
  asm volatile("cld; rep stosb" :
801049c5:	89 d7                	mov    %edx,%edi
801049c7:	8b 45 0c             	mov    0xc(%ebp),%eax
801049ca:	fc                   	cld    
801049cb:	f3 aa                	rep stos %al,%es:(%edi)
    c &= 0xFF;
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
801049cd:	5b                   	pop    %ebx
801049ce:	89 d0                	mov    %edx,%eax
801049d0:	5f                   	pop    %edi
801049d1:	5d                   	pop    %ebp
801049d2:	c3                   	ret    
801049d3:	90                   	nop
801049d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c &= 0xFF;
801049d8:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
801049dc:	c1 e9 02             	shr    $0x2,%ecx
801049df:	89 f8                	mov    %edi,%eax
801049e1:	89 fb                	mov    %edi,%ebx
801049e3:	c1 e0 18             	shl    $0x18,%eax
801049e6:	c1 e3 10             	shl    $0x10,%ebx
801049e9:	09 d8                	or     %ebx,%eax
801049eb:	09 f8                	or     %edi,%eax
801049ed:	c1 e7 08             	shl    $0x8,%edi
801049f0:	09 f8                	or     %edi,%eax
  asm volatile("cld; rep stosl" :
801049f2:	89 d7                	mov    %edx,%edi
801049f4:	fc                   	cld    
801049f5:	f3 ab                	rep stos %eax,%es:(%edi)
}
801049f7:	5b                   	pop    %ebx
801049f8:	89 d0                	mov    %edx,%eax
801049fa:	5f                   	pop    %edi
801049fb:	5d                   	pop    %ebp
801049fc:	c3                   	ret    
801049fd:	8d 76 00             	lea    0x0(%esi),%esi

80104a00 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80104a00:	55                   	push   %ebp
80104a01:	89 e5                	mov    %esp,%ebp
80104a03:	57                   	push   %edi
80104a04:	56                   	push   %esi
80104a05:	53                   	push   %ebx
80104a06:	8b 5d 10             	mov    0x10(%ebp),%ebx
80104a09:	8b 75 08             	mov    0x8(%ebp),%esi
80104a0c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
80104a0f:	85 db                	test   %ebx,%ebx
80104a11:	74 29                	je     80104a3c <memcmp+0x3c>
    if(*s1 != *s2)
80104a13:	0f b6 16             	movzbl (%esi),%edx
80104a16:	0f b6 0f             	movzbl (%edi),%ecx
80104a19:	38 d1                	cmp    %dl,%cl
80104a1b:	75 2b                	jne    80104a48 <memcmp+0x48>
80104a1d:	b8 01 00 00 00       	mov    $0x1,%eax
80104a22:	eb 14                	jmp    80104a38 <memcmp+0x38>
80104a24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104a28:	0f b6 14 06          	movzbl (%esi,%eax,1),%edx
80104a2c:	83 c0 01             	add    $0x1,%eax
80104a2f:	0f b6 4c 07 ff       	movzbl -0x1(%edi,%eax,1),%ecx
80104a34:	38 ca                	cmp    %cl,%dl
80104a36:	75 10                	jne    80104a48 <memcmp+0x48>
  while(n-- > 0){
80104a38:	39 d8                	cmp    %ebx,%eax
80104a3a:	75 ec                	jne    80104a28 <memcmp+0x28>
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
}
80104a3c:	5b                   	pop    %ebx
  return 0;
80104a3d:	31 c0                	xor    %eax,%eax
}
80104a3f:	5e                   	pop    %esi
80104a40:	5f                   	pop    %edi
80104a41:	5d                   	pop    %ebp
80104a42:	c3                   	ret    
80104a43:	90                   	nop
80104a44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      return *s1 - *s2;
80104a48:	0f b6 c2             	movzbl %dl,%eax
}
80104a4b:	5b                   	pop    %ebx
      return *s1 - *s2;
80104a4c:	29 c8                	sub    %ecx,%eax
}
80104a4e:	5e                   	pop    %esi
80104a4f:	5f                   	pop    %edi
80104a50:	5d                   	pop    %ebp
80104a51:	c3                   	ret    
80104a52:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104a59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104a60 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80104a60:	55                   	push   %ebp
80104a61:	89 e5                	mov    %esp,%ebp
80104a63:	56                   	push   %esi
80104a64:	53                   	push   %ebx
80104a65:	8b 45 08             	mov    0x8(%ebp),%eax
80104a68:	8b 5d 0c             	mov    0xc(%ebp),%ebx
80104a6b:	8b 75 10             	mov    0x10(%ebp),%esi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
80104a6e:	39 c3                	cmp    %eax,%ebx
80104a70:	73 26                	jae    80104a98 <memmove+0x38>
80104a72:	8d 0c 33             	lea    (%ebx,%esi,1),%ecx
80104a75:	39 c8                	cmp    %ecx,%eax
80104a77:	73 1f                	jae    80104a98 <memmove+0x38>
    s += n;
    d += n;
    while(n-- > 0)
80104a79:	85 f6                	test   %esi,%esi
80104a7b:	8d 56 ff             	lea    -0x1(%esi),%edx
80104a7e:	74 0f                	je     80104a8f <memmove+0x2f>
      *--d = *--s;
80104a80:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
80104a84:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    while(n-- > 0)
80104a87:	83 ea 01             	sub    $0x1,%edx
80104a8a:	83 fa ff             	cmp    $0xffffffff,%edx
80104a8d:	75 f1                	jne    80104a80 <memmove+0x20>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
80104a8f:	5b                   	pop    %ebx
80104a90:	5e                   	pop    %esi
80104a91:	5d                   	pop    %ebp
80104a92:	c3                   	ret    
80104a93:	90                   	nop
80104a94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    while(n-- > 0)
80104a98:	31 d2                	xor    %edx,%edx
80104a9a:	85 f6                	test   %esi,%esi
80104a9c:	74 f1                	je     80104a8f <memmove+0x2f>
80104a9e:	66 90                	xchg   %ax,%ax
      *d++ = *s++;
80104aa0:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
80104aa4:	88 0c 10             	mov    %cl,(%eax,%edx,1)
80104aa7:	83 c2 01             	add    $0x1,%edx
    while(n-- > 0)
80104aaa:	39 d6                	cmp    %edx,%esi
80104aac:	75 f2                	jne    80104aa0 <memmove+0x40>
}
80104aae:	5b                   	pop    %ebx
80104aaf:	5e                   	pop    %esi
80104ab0:	5d                   	pop    %ebp
80104ab1:	c3                   	ret    
80104ab2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104ab9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104ac0 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
80104ac0:	55                   	push   %ebp
80104ac1:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
}
80104ac3:	5d                   	pop    %ebp
  return memmove(dst, src, n);
80104ac4:	eb 9a                	jmp    80104a60 <memmove>
80104ac6:	8d 76 00             	lea    0x0(%esi),%esi
80104ac9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104ad0 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
80104ad0:	55                   	push   %ebp
80104ad1:	89 e5                	mov    %esp,%ebp
80104ad3:	57                   	push   %edi
80104ad4:	56                   	push   %esi
80104ad5:	8b 7d 10             	mov    0x10(%ebp),%edi
80104ad8:	53                   	push   %ebx
80104ad9:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104adc:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(n > 0 && *p && *p == *q)
80104adf:	85 ff                	test   %edi,%edi
80104ae1:	74 2f                	je     80104b12 <strncmp+0x42>
80104ae3:	0f b6 01             	movzbl (%ecx),%eax
80104ae6:	0f b6 1e             	movzbl (%esi),%ebx
80104ae9:	84 c0                	test   %al,%al
80104aeb:	74 37                	je     80104b24 <strncmp+0x54>
80104aed:	38 c3                	cmp    %al,%bl
80104aef:	75 33                	jne    80104b24 <strncmp+0x54>
80104af1:	01 f7                	add    %esi,%edi
80104af3:	eb 13                	jmp    80104b08 <strncmp+0x38>
80104af5:	8d 76 00             	lea    0x0(%esi),%esi
80104af8:	0f b6 01             	movzbl (%ecx),%eax
80104afb:	84 c0                	test   %al,%al
80104afd:	74 21                	je     80104b20 <strncmp+0x50>
80104aff:	0f b6 1a             	movzbl (%edx),%ebx
80104b02:	89 d6                	mov    %edx,%esi
80104b04:	38 d8                	cmp    %bl,%al
80104b06:	75 1c                	jne    80104b24 <strncmp+0x54>
    n--, p++, q++;
80104b08:	8d 56 01             	lea    0x1(%esi),%edx
80104b0b:	83 c1 01             	add    $0x1,%ecx
  while(n > 0 && *p && *p == *q)
80104b0e:	39 fa                	cmp    %edi,%edx
80104b10:	75 e6                	jne    80104af8 <strncmp+0x28>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
}
80104b12:	5b                   	pop    %ebx
    return 0;
80104b13:	31 c0                	xor    %eax,%eax
}
80104b15:	5e                   	pop    %esi
80104b16:	5f                   	pop    %edi
80104b17:	5d                   	pop    %ebp
80104b18:	c3                   	ret    
80104b19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104b20:	0f b6 5e 01          	movzbl 0x1(%esi),%ebx
  return (uchar)*p - (uchar)*q;
80104b24:	29 d8                	sub    %ebx,%eax
}
80104b26:	5b                   	pop    %ebx
80104b27:	5e                   	pop    %esi
80104b28:	5f                   	pop    %edi
80104b29:	5d                   	pop    %ebp
80104b2a:	c3                   	ret    
80104b2b:	90                   	nop
80104b2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104b30 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80104b30:	55                   	push   %ebp
80104b31:	89 e5                	mov    %esp,%ebp
80104b33:	56                   	push   %esi
80104b34:	53                   	push   %ebx
80104b35:	8b 45 08             	mov    0x8(%ebp),%eax
80104b38:	8b 5d 0c             	mov    0xc(%ebp),%ebx
80104b3b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
80104b3e:	89 c2                	mov    %eax,%edx
80104b40:	eb 19                	jmp    80104b5b <strncpy+0x2b>
80104b42:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104b48:	83 c3 01             	add    $0x1,%ebx
80104b4b:	0f b6 4b ff          	movzbl -0x1(%ebx),%ecx
80104b4f:	83 c2 01             	add    $0x1,%edx
80104b52:	84 c9                	test   %cl,%cl
80104b54:	88 4a ff             	mov    %cl,-0x1(%edx)
80104b57:	74 09                	je     80104b62 <strncpy+0x32>
80104b59:	89 f1                	mov    %esi,%ecx
80104b5b:	85 c9                	test   %ecx,%ecx
80104b5d:	8d 71 ff             	lea    -0x1(%ecx),%esi
80104b60:	7f e6                	jg     80104b48 <strncpy+0x18>
    ;
  while(n-- > 0)
80104b62:	31 c9                	xor    %ecx,%ecx
80104b64:	85 f6                	test   %esi,%esi
80104b66:	7e 17                	jle    80104b7f <strncpy+0x4f>
80104b68:	90                   	nop
80104b69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    *s++ = 0;
80104b70:	c6 04 0a 00          	movb   $0x0,(%edx,%ecx,1)
80104b74:	89 f3                	mov    %esi,%ebx
80104b76:	83 c1 01             	add    $0x1,%ecx
80104b79:	29 cb                	sub    %ecx,%ebx
  while(n-- > 0)
80104b7b:	85 db                	test   %ebx,%ebx
80104b7d:	7f f1                	jg     80104b70 <strncpy+0x40>
  return os;
}
80104b7f:	5b                   	pop    %ebx
80104b80:	5e                   	pop    %esi
80104b81:	5d                   	pop    %ebp
80104b82:	c3                   	ret    
80104b83:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104b89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104b90 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80104b90:	55                   	push   %ebp
80104b91:	89 e5                	mov    %esp,%ebp
80104b93:	56                   	push   %esi
80104b94:	53                   	push   %ebx
80104b95:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104b98:	8b 45 08             	mov    0x8(%ebp),%eax
80104b9b:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  if(n <= 0)
80104b9e:	85 c9                	test   %ecx,%ecx
80104ba0:	7e 26                	jle    80104bc8 <safestrcpy+0x38>
80104ba2:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
80104ba6:	89 c1                	mov    %eax,%ecx
80104ba8:	eb 17                	jmp    80104bc1 <safestrcpy+0x31>
80104baa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80104bb0:	83 c2 01             	add    $0x1,%edx
80104bb3:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
80104bb7:	83 c1 01             	add    $0x1,%ecx
80104bba:	84 db                	test   %bl,%bl
80104bbc:	88 59 ff             	mov    %bl,-0x1(%ecx)
80104bbf:	74 04                	je     80104bc5 <safestrcpy+0x35>
80104bc1:	39 f2                	cmp    %esi,%edx
80104bc3:	75 eb                	jne    80104bb0 <safestrcpy+0x20>
    ;
  *s = 0;
80104bc5:	c6 01 00             	movb   $0x0,(%ecx)
  return os;
}
80104bc8:	5b                   	pop    %ebx
80104bc9:	5e                   	pop    %esi
80104bca:	5d                   	pop    %ebp
80104bcb:	c3                   	ret    
80104bcc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104bd0 <strlen>:

int
strlen(const char *s)
{
80104bd0:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80104bd1:	31 c0                	xor    %eax,%eax
{
80104bd3:	89 e5                	mov    %esp,%ebp
80104bd5:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
80104bd8:	80 3a 00             	cmpb   $0x0,(%edx)
80104bdb:	74 0c                	je     80104be9 <strlen+0x19>
80104bdd:	8d 76 00             	lea    0x0(%esi),%esi
80104be0:	83 c0 01             	add    $0x1,%eax
80104be3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80104be7:	75 f7                	jne    80104be0 <strlen+0x10>
    ;
  return n;
}
80104be9:	5d                   	pop    %ebp
80104bea:	c3                   	ret    

80104beb <swtch>:
80104beb:	8b 44 24 04          	mov    0x4(%esp),%eax
80104bef:	8b 54 24 08          	mov    0x8(%esp),%edx
80104bf3:	55                   	push   %ebp
80104bf4:	53                   	push   %ebx
80104bf5:	56                   	push   %esi
80104bf6:	57                   	push   %edi
80104bf7:	89 20                	mov    %esp,(%eax)
80104bf9:	89 d4                	mov    %edx,%esp
80104bfb:	5f                   	pop    %edi
80104bfc:	5e                   	pop    %esi
80104bfd:	5b                   	pop    %ebx
80104bfe:	5d                   	pop    %ebp
80104bff:	c3                   	ret    

80104c00 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80104c00:	55                   	push   %ebp
80104c01:	89 e5                	mov    %esp,%ebp
80104c03:	53                   	push   %ebx
80104c04:	83 ec 04             	sub    $0x4,%esp
80104c07:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
80104c0a:	e8 01 ed ff ff       	call   80103910 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104c0f:	8b 00                	mov    (%eax),%eax
80104c11:	39 d8                	cmp    %ebx,%eax
80104c13:	76 1b                	jbe    80104c30 <fetchint+0x30>
80104c15:	8d 53 04             	lea    0x4(%ebx),%edx
80104c18:	39 d0                	cmp    %edx,%eax
80104c1a:	72 14                	jb     80104c30 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
80104c1c:	8b 45 0c             	mov    0xc(%ebp),%eax
80104c1f:	8b 13                	mov    (%ebx),%edx
80104c21:	89 10                	mov    %edx,(%eax)
  return 0;
80104c23:	31 c0                	xor    %eax,%eax
}
80104c25:	83 c4 04             	add    $0x4,%esp
80104c28:	5b                   	pop    %ebx
80104c29:	5d                   	pop    %ebp
80104c2a:	c3                   	ret    
80104c2b:	90                   	nop
80104c2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104c30:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104c35:	eb ee                	jmp    80104c25 <fetchint+0x25>
80104c37:	89 f6                	mov    %esi,%esi
80104c39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104c40 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80104c40:	55                   	push   %ebp
80104c41:	89 e5                	mov    %esp,%ebp
80104c43:	53                   	push   %ebx
80104c44:	83 ec 04             	sub    $0x4,%esp
80104c47:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
80104c4a:	e8 c1 ec ff ff       	call   80103910 <myproc>

  if(addr >= curproc->sz)
80104c4f:	39 18                	cmp    %ebx,(%eax)
80104c51:	76 29                	jbe    80104c7c <fetchstr+0x3c>
    return -1;
  *pp = (char*)addr;
80104c53:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80104c56:	89 da                	mov    %ebx,%edx
80104c58:	89 19                	mov    %ebx,(%ecx)
  ep = (char*)curproc->sz;
80104c5a:	8b 00                	mov    (%eax),%eax
  for(s = *pp; s < ep; s++){
80104c5c:	39 c3                	cmp    %eax,%ebx
80104c5e:	73 1c                	jae    80104c7c <fetchstr+0x3c>
    if(*s == 0)
80104c60:	80 3b 00             	cmpb   $0x0,(%ebx)
80104c63:	75 10                	jne    80104c75 <fetchstr+0x35>
80104c65:	eb 39                	jmp    80104ca0 <fetchstr+0x60>
80104c67:	89 f6                	mov    %esi,%esi
80104c69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104c70:	80 3a 00             	cmpb   $0x0,(%edx)
80104c73:	74 1b                	je     80104c90 <fetchstr+0x50>
  for(s = *pp; s < ep; s++){
80104c75:	83 c2 01             	add    $0x1,%edx
80104c78:	39 d0                	cmp    %edx,%eax
80104c7a:	77 f4                	ja     80104c70 <fetchstr+0x30>
    return -1;
80104c7c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      return s - *pp;
  }
  return -1;
}
80104c81:	83 c4 04             	add    $0x4,%esp
80104c84:	5b                   	pop    %ebx
80104c85:	5d                   	pop    %ebp
80104c86:	c3                   	ret    
80104c87:	89 f6                	mov    %esi,%esi
80104c89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104c90:	83 c4 04             	add    $0x4,%esp
80104c93:	89 d0                	mov    %edx,%eax
80104c95:	29 d8                	sub    %ebx,%eax
80104c97:	5b                   	pop    %ebx
80104c98:	5d                   	pop    %ebp
80104c99:	c3                   	ret    
80104c9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(*s == 0)
80104ca0:	31 c0                	xor    %eax,%eax
      return s - *pp;
80104ca2:	eb dd                	jmp    80104c81 <fetchstr+0x41>
80104ca4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104caa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104cb0 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80104cb0:	55                   	push   %ebp
80104cb1:	89 e5                	mov    %esp,%ebp
80104cb3:	56                   	push   %esi
80104cb4:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104cb5:	e8 56 ec ff ff       	call   80103910 <myproc>
80104cba:	8b 40 18             	mov    0x18(%eax),%eax
80104cbd:	8b 55 08             	mov    0x8(%ebp),%edx
80104cc0:	8b 40 44             	mov    0x44(%eax),%eax
80104cc3:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80104cc6:	e8 45 ec ff ff       	call   80103910 <myproc>
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104ccb:	8b 00                	mov    (%eax),%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104ccd:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104cd0:	39 c6                	cmp    %eax,%esi
80104cd2:	73 1c                	jae    80104cf0 <argint+0x40>
80104cd4:	8d 53 08             	lea    0x8(%ebx),%edx
80104cd7:	39 d0                	cmp    %edx,%eax
80104cd9:	72 15                	jb     80104cf0 <argint+0x40>
  *ip = *(int*)(addr);
80104cdb:	8b 45 0c             	mov    0xc(%ebp),%eax
80104cde:	8b 53 04             	mov    0x4(%ebx),%edx
80104ce1:	89 10                	mov    %edx,(%eax)
  return 0;
80104ce3:	31 c0                	xor    %eax,%eax
}
80104ce5:	5b                   	pop    %ebx
80104ce6:	5e                   	pop    %esi
80104ce7:	5d                   	pop    %ebp
80104ce8:	c3                   	ret    
80104ce9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104cf0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104cf5:	eb ee                	jmp    80104ce5 <argint+0x35>
80104cf7:	89 f6                	mov    %esi,%esi
80104cf9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104d00 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80104d00:	55                   	push   %ebp
80104d01:	89 e5                	mov    %esp,%ebp
80104d03:	56                   	push   %esi
80104d04:	53                   	push   %ebx
80104d05:	83 ec 10             	sub    $0x10,%esp
80104d08:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int i;
  struct proc *curproc = myproc();
80104d0b:	e8 00 ec ff ff       	call   80103910 <myproc>
80104d10:	89 c6                	mov    %eax,%esi
 
  if(argint(n, &i) < 0)
80104d12:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104d15:	83 ec 08             	sub    $0x8,%esp
80104d18:	50                   	push   %eax
80104d19:	ff 75 08             	pushl  0x8(%ebp)
80104d1c:	e8 8f ff ff ff       	call   80104cb0 <argint>
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80104d21:	83 c4 10             	add    $0x10,%esp
80104d24:	85 c0                	test   %eax,%eax
80104d26:	78 28                	js     80104d50 <argptr+0x50>
80104d28:	85 db                	test   %ebx,%ebx
80104d2a:	78 24                	js     80104d50 <argptr+0x50>
80104d2c:	8b 16                	mov    (%esi),%edx
80104d2e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104d31:	39 c2                	cmp    %eax,%edx
80104d33:	76 1b                	jbe    80104d50 <argptr+0x50>
80104d35:	01 c3                	add    %eax,%ebx
80104d37:	39 da                	cmp    %ebx,%edx
80104d39:	72 15                	jb     80104d50 <argptr+0x50>
    return -1;
  *pp = (char*)i;
80104d3b:	8b 55 0c             	mov    0xc(%ebp),%edx
80104d3e:	89 02                	mov    %eax,(%edx)
  return 0;
80104d40:	31 c0                	xor    %eax,%eax
}
80104d42:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104d45:	5b                   	pop    %ebx
80104d46:	5e                   	pop    %esi
80104d47:	5d                   	pop    %ebp
80104d48:	c3                   	ret    
80104d49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104d50:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104d55:	eb eb                	jmp    80104d42 <argptr+0x42>
80104d57:	89 f6                	mov    %esi,%esi
80104d59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104d60 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80104d60:	55                   	push   %ebp
80104d61:	89 e5                	mov    %esp,%ebp
80104d63:	83 ec 20             	sub    $0x20,%esp
  int addr;
  if(argint(n, &addr) < 0)
80104d66:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104d69:	50                   	push   %eax
80104d6a:	ff 75 08             	pushl  0x8(%ebp)
80104d6d:	e8 3e ff ff ff       	call   80104cb0 <argint>
80104d72:	83 c4 10             	add    $0x10,%esp
80104d75:	85 c0                	test   %eax,%eax
80104d77:	78 17                	js     80104d90 <argstr+0x30>
    return -1;
  return fetchstr(addr, pp);
80104d79:	83 ec 08             	sub    $0x8,%esp
80104d7c:	ff 75 0c             	pushl  0xc(%ebp)
80104d7f:	ff 75 f4             	pushl  -0xc(%ebp)
80104d82:	e8 b9 fe ff ff       	call   80104c40 <fetchstr>
80104d87:	83 c4 10             	add    $0x10,%esp
}
80104d8a:	c9                   	leave  
80104d8b:	c3                   	ret    
80104d8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104d90:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104d95:	c9                   	leave  
80104d96:	c3                   	ret    
80104d97:	89 f6                	mov    %esi,%esi
80104d99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104da0 <syscall>:
[SYS_sigret] sys_sigret
};

void
syscall(void)
{
80104da0:	55                   	push   %ebp
80104da1:	89 e5                	mov    %esp,%ebp
80104da3:	53                   	push   %ebx
80104da4:	83 ec 04             	sub    $0x4,%esp
  int num;
  struct proc *curproc = myproc();
80104da7:	e8 64 eb ff ff       	call   80103910 <myproc>
80104dac:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
80104dae:	8b 40 18             	mov    0x18(%eax),%eax
80104db1:	8b 40 1c             	mov    0x1c(%eax),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80104db4:	8d 50 ff             	lea    -0x1(%eax),%edx
80104db7:	83 fa 17             	cmp    $0x17,%edx
80104dba:	77 1c                	ja     80104dd8 <syscall+0x38>
80104dbc:	8b 14 85 20 7c 10 80 	mov    -0x7fef83e0(,%eax,4),%edx
80104dc3:	85 d2                	test   %edx,%edx
80104dc5:	74 11                	je     80104dd8 <syscall+0x38>
    curproc->tf->eax = syscalls[num]();
80104dc7:	ff d2                	call   *%edx
80104dc9:	8b 53 18             	mov    0x18(%ebx),%edx
80104dcc:	89 42 1c             	mov    %eax,0x1c(%edx)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
80104dcf:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104dd2:	c9                   	leave  
80104dd3:	c3                   	ret    
80104dd4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("%d %s: unknown sys call %d\n",
80104dd8:	50                   	push   %eax
            curproc->pid, curproc->name, num);
80104dd9:	8d 43 6c             	lea    0x6c(%ebx),%eax
    cprintf("%d %s: unknown sys call %d\n",
80104ddc:	50                   	push   %eax
80104ddd:	ff 73 10             	pushl  0x10(%ebx)
80104de0:	68 01 7c 10 80       	push   $0x80107c01
80104de5:	e8 76 b8 ff ff       	call   80100660 <cprintf>
    curproc->tf->eax = -1;
80104dea:	8b 43 18             	mov    0x18(%ebx),%eax
80104ded:	83 c4 10             	add    $0x10,%esp
80104df0:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
80104df7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104dfa:	c9                   	leave  
80104dfb:	c3                   	ret    
80104dfc:	66 90                	xchg   %ax,%ax
80104dfe:	66 90                	xchg   %ax,%ax

80104e00 <create>:
80104e00:	55                   	push   %ebp
80104e01:	89 e5                	mov    %esp,%ebp
80104e03:	57                   	push   %edi
80104e04:	56                   	push   %esi
80104e05:	53                   	push   %ebx
80104e06:	8d 75 da             	lea    -0x26(%ebp),%esi
80104e09:	83 ec 34             	sub    $0x34,%esp
80104e0c:	89 4d d0             	mov    %ecx,-0x30(%ebp)
80104e0f:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104e12:	56                   	push   %esi
80104e13:	50                   	push   %eax
80104e14:	89 55 d4             	mov    %edx,-0x2c(%ebp)
80104e17:	89 4d cc             	mov    %ecx,-0x34(%ebp)
80104e1a:	e8 11 d1 ff ff       	call   80101f30 <nameiparent>
80104e1f:	83 c4 10             	add    $0x10,%esp
80104e22:	85 c0                	test   %eax,%eax
80104e24:	0f 84 46 01 00 00    	je     80104f70 <create+0x170>
80104e2a:	83 ec 0c             	sub    $0xc,%esp
80104e2d:	89 c3                	mov    %eax,%ebx
80104e2f:	50                   	push   %eax
80104e30:	e8 7b c8 ff ff       	call   801016b0 <ilock>
80104e35:	83 c4 0c             	add    $0xc,%esp
80104e38:	6a 00                	push   $0x0
80104e3a:	56                   	push   %esi
80104e3b:	53                   	push   %ebx
80104e3c:	e8 9f cd ff ff       	call   80101be0 <dirlookup>
80104e41:	83 c4 10             	add    $0x10,%esp
80104e44:	85 c0                	test   %eax,%eax
80104e46:	89 c7                	mov    %eax,%edi
80104e48:	74 36                	je     80104e80 <create+0x80>
80104e4a:	83 ec 0c             	sub    $0xc,%esp
80104e4d:	53                   	push   %ebx
80104e4e:	e8 ed ca ff ff       	call   80101940 <iunlockput>
80104e53:	89 3c 24             	mov    %edi,(%esp)
80104e56:	e8 55 c8 ff ff       	call   801016b0 <ilock>
80104e5b:	83 c4 10             	add    $0x10,%esp
80104e5e:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
80104e63:	0f 85 97 00 00 00    	jne    80104f00 <create+0x100>
80104e69:	66 83 7f 50 02       	cmpw   $0x2,0x50(%edi)
80104e6e:	0f 85 8c 00 00 00    	jne    80104f00 <create+0x100>
80104e74:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104e77:	89 f8                	mov    %edi,%eax
80104e79:	5b                   	pop    %ebx
80104e7a:	5e                   	pop    %esi
80104e7b:	5f                   	pop    %edi
80104e7c:	5d                   	pop    %ebp
80104e7d:	c3                   	ret    
80104e7e:	66 90                	xchg   %ax,%ax
80104e80:	0f bf 45 d4          	movswl -0x2c(%ebp),%eax
80104e84:	83 ec 08             	sub    $0x8,%esp
80104e87:	50                   	push   %eax
80104e88:	ff 33                	pushl  (%ebx)
80104e8a:	e8 b1 c6 ff ff       	call   80101540 <ialloc>
80104e8f:	83 c4 10             	add    $0x10,%esp
80104e92:	85 c0                	test   %eax,%eax
80104e94:	89 c7                	mov    %eax,%edi
80104e96:	0f 84 e8 00 00 00    	je     80104f84 <create+0x184>
80104e9c:	83 ec 0c             	sub    $0xc,%esp
80104e9f:	50                   	push   %eax
80104ea0:	e8 0b c8 ff ff       	call   801016b0 <ilock>
80104ea5:	0f b7 45 d0          	movzwl -0x30(%ebp),%eax
80104ea9:	66 89 47 52          	mov    %ax,0x52(%edi)
80104ead:	0f b7 45 cc          	movzwl -0x34(%ebp),%eax
80104eb1:	66 89 47 54          	mov    %ax,0x54(%edi)
80104eb5:	b8 01 00 00 00       	mov    $0x1,%eax
80104eba:	66 89 47 56          	mov    %ax,0x56(%edi)
80104ebe:	89 3c 24             	mov    %edi,(%esp)
80104ec1:	e8 3a c7 ff ff       	call   80101600 <iupdate>
80104ec6:	83 c4 10             	add    $0x10,%esp
80104ec9:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
80104ece:	74 50                	je     80104f20 <create+0x120>
80104ed0:	83 ec 04             	sub    $0x4,%esp
80104ed3:	ff 77 04             	pushl  0x4(%edi)
80104ed6:	56                   	push   %esi
80104ed7:	53                   	push   %ebx
80104ed8:	e8 73 cf ff ff       	call   80101e50 <dirlink>
80104edd:	83 c4 10             	add    $0x10,%esp
80104ee0:	85 c0                	test   %eax,%eax
80104ee2:	0f 88 8f 00 00 00    	js     80104f77 <create+0x177>
80104ee8:	83 ec 0c             	sub    $0xc,%esp
80104eeb:	53                   	push   %ebx
80104eec:	e8 4f ca ff ff       	call   80101940 <iunlockput>
80104ef1:	83 c4 10             	add    $0x10,%esp
80104ef4:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104ef7:	89 f8                	mov    %edi,%eax
80104ef9:	5b                   	pop    %ebx
80104efa:	5e                   	pop    %esi
80104efb:	5f                   	pop    %edi
80104efc:	5d                   	pop    %ebp
80104efd:	c3                   	ret    
80104efe:	66 90                	xchg   %ax,%ax
80104f00:	83 ec 0c             	sub    $0xc,%esp
80104f03:	57                   	push   %edi
80104f04:	31 ff                	xor    %edi,%edi
80104f06:	e8 35 ca ff ff       	call   80101940 <iunlockput>
80104f0b:	83 c4 10             	add    $0x10,%esp
80104f0e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104f11:	89 f8                	mov    %edi,%eax
80104f13:	5b                   	pop    %ebx
80104f14:	5e                   	pop    %esi
80104f15:	5f                   	pop    %edi
80104f16:	5d                   	pop    %ebp
80104f17:	c3                   	ret    
80104f18:	90                   	nop
80104f19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104f20:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
80104f25:	83 ec 0c             	sub    $0xc,%esp
80104f28:	53                   	push   %ebx
80104f29:	e8 d2 c6 ff ff       	call   80101600 <iupdate>
80104f2e:	83 c4 0c             	add    $0xc,%esp
80104f31:	ff 77 04             	pushl  0x4(%edi)
80104f34:	68 a0 7c 10 80       	push   $0x80107ca0
80104f39:	57                   	push   %edi
80104f3a:	e8 11 cf ff ff       	call   80101e50 <dirlink>
80104f3f:	83 c4 10             	add    $0x10,%esp
80104f42:	85 c0                	test   %eax,%eax
80104f44:	78 1c                	js     80104f62 <create+0x162>
80104f46:	83 ec 04             	sub    $0x4,%esp
80104f49:	ff 73 04             	pushl  0x4(%ebx)
80104f4c:	68 9f 7c 10 80       	push   $0x80107c9f
80104f51:	57                   	push   %edi
80104f52:	e8 f9 ce ff ff       	call   80101e50 <dirlink>
80104f57:	83 c4 10             	add    $0x10,%esp
80104f5a:	85 c0                	test   %eax,%eax
80104f5c:	0f 89 6e ff ff ff    	jns    80104ed0 <create+0xd0>
80104f62:	83 ec 0c             	sub    $0xc,%esp
80104f65:	68 93 7c 10 80       	push   $0x80107c93
80104f6a:	e8 21 b4 ff ff       	call   80100390 <panic>
80104f6f:	90                   	nop
80104f70:	31 ff                	xor    %edi,%edi
80104f72:	e9 fd fe ff ff       	jmp    80104e74 <create+0x74>
80104f77:	83 ec 0c             	sub    $0xc,%esp
80104f7a:	68 a2 7c 10 80       	push   $0x80107ca2
80104f7f:	e8 0c b4 ff ff       	call   80100390 <panic>
80104f84:	83 ec 0c             	sub    $0xc,%esp
80104f87:	68 84 7c 10 80       	push   $0x80107c84
80104f8c:	e8 ff b3 ff ff       	call   80100390 <panic>
80104f91:	eb 0d                	jmp    80104fa0 <argfd.constprop.0>
80104f93:	90                   	nop
80104f94:	90                   	nop
80104f95:	90                   	nop
80104f96:	90                   	nop
80104f97:	90                   	nop
80104f98:	90                   	nop
80104f99:	90                   	nop
80104f9a:	90                   	nop
80104f9b:	90                   	nop
80104f9c:	90                   	nop
80104f9d:	90                   	nop
80104f9e:	90                   	nop
80104f9f:	90                   	nop

80104fa0 <argfd.constprop.0>:
80104fa0:	55                   	push   %ebp
80104fa1:	89 e5                	mov    %esp,%ebp
80104fa3:	56                   	push   %esi
80104fa4:	53                   	push   %ebx
80104fa5:	89 c3                	mov    %eax,%ebx
80104fa7:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104faa:	89 d6                	mov    %edx,%esi
80104fac:	83 ec 18             	sub    $0x18,%esp
80104faf:	50                   	push   %eax
80104fb0:	6a 00                	push   $0x0
80104fb2:	e8 f9 fc ff ff       	call   80104cb0 <argint>
80104fb7:	83 c4 10             	add    $0x10,%esp
80104fba:	85 c0                	test   %eax,%eax
80104fbc:	78 2a                	js     80104fe8 <argfd.constprop.0+0x48>
80104fbe:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80104fc2:	77 24                	ja     80104fe8 <argfd.constprop.0+0x48>
80104fc4:	e8 47 e9 ff ff       	call   80103910 <myproc>
80104fc9:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104fcc:	8b 44 90 28          	mov    0x28(%eax,%edx,4),%eax
80104fd0:	85 c0                	test   %eax,%eax
80104fd2:	74 14                	je     80104fe8 <argfd.constprop.0+0x48>
80104fd4:	85 db                	test   %ebx,%ebx
80104fd6:	74 02                	je     80104fda <argfd.constprop.0+0x3a>
80104fd8:	89 13                	mov    %edx,(%ebx)
80104fda:	89 06                	mov    %eax,(%esi)
80104fdc:	31 c0                	xor    %eax,%eax
80104fde:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104fe1:	5b                   	pop    %ebx
80104fe2:	5e                   	pop    %esi
80104fe3:	5d                   	pop    %ebp
80104fe4:	c3                   	ret    
80104fe5:	8d 76 00             	lea    0x0(%esi),%esi
80104fe8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104fed:	eb ef                	jmp    80104fde <argfd.constprop.0+0x3e>
80104fef:	90                   	nop

80104ff0 <sys_dup>:
80104ff0:	55                   	push   %ebp
80104ff1:	31 c0                	xor    %eax,%eax
80104ff3:	89 e5                	mov    %esp,%ebp
80104ff5:	56                   	push   %esi
80104ff6:	53                   	push   %ebx
80104ff7:	8d 55 f4             	lea    -0xc(%ebp),%edx
80104ffa:	83 ec 10             	sub    $0x10,%esp
80104ffd:	e8 9e ff ff ff       	call   80104fa0 <argfd.constprop.0>
80105002:	85 c0                	test   %eax,%eax
80105004:	78 42                	js     80105048 <sys_dup+0x58>
80105006:	8b 75 f4             	mov    -0xc(%ebp),%esi
80105009:	31 db                	xor    %ebx,%ebx
8010500b:	e8 00 e9 ff ff       	call   80103910 <myproc>
80105010:	eb 0e                	jmp    80105020 <sys_dup+0x30>
80105012:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105018:	83 c3 01             	add    $0x1,%ebx
8010501b:	83 fb 10             	cmp    $0x10,%ebx
8010501e:	74 28                	je     80105048 <sys_dup+0x58>
80105020:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105024:	85 d2                	test   %edx,%edx
80105026:	75 f0                	jne    80105018 <sys_dup+0x28>
80105028:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
8010502c:	83 ec 0c             	sub    $0xc,%esp
8010502f:	ff 75 f4             	pushl  -0xc(%ebp)
80105032:	e8 e9 bd ff ff       	call   80100e20 <filedup>
80105037:	83 c4 10             	add    $0x10,%esp
8010503a:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010503d:	89 d8                	mov    %ebx,%eax
8010503f:	5b                   	pop    %ebx
80105040:	5e                   	pop    %esi
80105041:	5d                   	pop    %ebp
80105042:	c3                   	ret    
80105043:	90                   	nop
80105044:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105048:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010504b:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105050:	89 d8                	mov    %ebx,%eax
80105052:	5b                   	pop    %ebx
80105053:	5e                   	pop    %esi
80105054:	5d                   	pop    %ebp
80105055:	c3                   	ret    
80105056:	8d 76 00             	lea    0x0(%esi),%esi
80105059:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105060 <sys_read>:
80105060:	55                   	push   %ebp
80105061:	31 c0                	xor    %eax,%eax
80105063:	89 e5                	mov    %esp,%ebp
80105065:	83 ec 18             	sub    $0x18,%esp
80105068:	8d 55 ec             	lea    -0x14(%ebp),%edx
8010506b:	e8 30 ff ff ff       	call   80104fa0 <argfd.constprop.0>
80105070:	85 c0                	test   %eax,%eax
80105072:	78 4c                	js     801050c0 <sys_read+0x60>
80105074:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105077:	83 ec 08             	sub    $0x8,%esp
8010507a:	50                   	push   %eax
8010507b:	6a 02                	push   $0x2
8010507d:	e8 2e fc ff ff       	call   80104cb0 <argint>
80105082:	83 c4 10             	add    $0x10,%esp
80105085:	85 c0                	test   %eax,%eax
80105087:	78 37                	js     801050c0 <sys_read+0x60>
80105089:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010508c:	83 ec 04             	sub    $0x4,%esp
8010508f:	ff 75 f0             	pushl  -0x10(%ebp)
80105092:	50                   	push   %eax
80105093:	6a 01                	push   $0x1
80105095:	e8 66 fc ff ff       	call   80104d00 <argptr>
8010509a:	83 c4 10             	add    $0x10,%esp
8010509d:	85 c0                	test   %eax,%eax
8010509f:	78 1f                	js     801050c0 <sys_read+0x60>
801050a1:	83 ec 04             	sub    $0x4,%esp
801050a4:	ff 75 f0             	pushl  -0x10(%ebp)
801050a7:	ff 75 f4             	pushl  -0xc(%ebp)
801050aa:	ff 75 ec             	pushl  -0x14(%ebp)
801050ad:	e8 de be ff ff       	call   80100f90 <fileread>
801050b2:	83 c4 10             	add    $0x10,%esp
801050b5:	c9                   	leave  
801050b6:	c3                   	ret    
801050b7:	89 f6                	mov    %esi,%esi
801050b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801050c0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801050c5:	c9                   	leave  
801050c6:	c3                   	ret    
801050c7:	89 f6                	mov    %esi,%esi
801050c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801050d0 <sys_write>:
801050d0:	55                   	push   %ebp
801050d1:	31 c0                	xor    %eax,%eax
801050d3:	89 e5                	mov    %esp,%ebp
801050d5:	83 ec 18             	sub    $0x18,%esp
801050d8:	8d 55 ec             	lea    -0x14(%ebp),%edx
801050db:	e8 c0 fe ff ff       	call   80104fa0 <argfd.constprop.0>
801050e0:	85 c0                	test   %eax,%eax
801050e2:	78 4c                	js     80105130 <sys_write+0x60>
801050e4:	8d 45 f0             	lea    -0x10(%ebp),%eax
801050e7:	83 ec 08             	sub    $0x8,%esp
801050ea:	50                   	push   %eax
801050eb:	6a 02                	push   $0x2
801050ed:	e8 be fb ff ff       	call   80104cb0 <argint>
801050f2:	83 c4 10             	add    $0x10,%esp
801050f5:	85 c0                	test   %eax,%eax
801050f7:	78 37                	js     80105130 <sys_write+0x60>
801050f9:	8d 45 f4             	lea    -0xc(%ebp),%eax
801050fc:	83 ec 04             	sub    $0x4,%esp
801050ff:	ff 75 f0             	pushl  -0x10(%ebp)
80105102:	50                   	push   %eax
80105103:	6a 01                	push   $0x1
80105105:	e8 f6 fb ff ff       	call   80104d00 <argptr>
8010510a:	83 c4 10             	add    $0x10,%esp
8010510d:	85 c0                	test   %eax,%eax
8010510f:	78 1f                	js     80105130 <sys_write+0x60>
80105111:	83 ec 04             	sub    $0x4,%esp
80105114:	ff 75 f0             	pushl  -0x10(%ebp)
80105117:	ff 75 f4             	pushl  -0xc(%ebp)
8010511a:	ff 75 ec             	pushl  -0x14(%ebp)
8010511d:	e8 fe be ff ff       	call   80101020 <filewrite>
80105122:	83 c4 10             	add    $0x10,%esp
80105125:	c9                   	leave  
80105126:	c3                   	ret    
80105127:	89 f6                	mov    %esi,%esi
80105129:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105130:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105135:	c9                   	leave  
80105136:	c3                   	ret    
80105137:	89 f6                	mov    %esi,%esi
80105139:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105140 <sys_close>:
80105140:	55                   	push   %ebp
80105141:	89 e5                	mov    %esp,%ebp
80105143:	83 ec 18             	sub    $0x18,%esp
80105146:	8d 55 f4             	lea    -0xc(%ebp),%edx
80105149:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010514c:	e8 4f fe ff ff       	call   80104fa0 <argfd.constprop.0>
80105151:	85 c0                	test   %eax,%eax
80105153:	78 2b                	js     80105180 <sys_close+0x40>
80105155:	e8 b6 e7 ff ff       	call   80103910 <myproc>
8010515a:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010515d:	83 ec 0c             	sub    $0xc,%esp
80105160:	c7 44 90 28 00 00 00 	movl   $0x0,0x28(%eax,%edx,4)
80105167:	00 
80105168:	ff 75 f4             	pushl  -0xc(%ebp)
8010516b:	e8 00 bd ff ff       	call   80100e70 <fileclose>
80105170:	83 c4 10             	add    $0x10,%esp
80105173:	31 c0                	xor    %eax,%eax
80105175:	c9                   	leave  
80105176:	c3                   	ret    
80105177:	89 f6                	mov    %esi,%esi
80105179:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105180:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105185:	c9                   	leave  
80105186:	c3                   	ret    
80105187:	89 f6                	mov    %esi,%esi
80105189:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105190 <sys_fstat>:
80105190:	55                   	push   %ebp
80105191:	31 c0                	xor    %eax,%eax
80105193:	89 e5                	mov    %esp,%ebp
80105195:	83 ec 18             	sub    $0x18,%esp
80105198:	8d 55 f0             	lea    -0x10(%ebp),%edx
8010519b:	e8 00 fe ff ff       	call   80104fa0 <argfd.constprop.0>
801051a0:	85 c0                	test   %eax,%eax
801051a2:	78 2c                	js     801051d0 <sys_fstat+0x40>
801051a4:	8d 45 f4             	lea    -0xc(%ebp),%eax
801051a7:	83 ec 04             	sub    $0x4,%esp
801051aa:	6a 14                	push   $0x14
801051ac:	50                   	push   %eax
801051ad:	6a 01                	push   $0x1
801051af:	e8 4c fb ff ff       	call   80104d00 <argptr>
801051b4:	83 c4 10             	add    $0x10,%esp
801051b7:	85 c0                	test   %eax,%eax
801051b9:	78 15                	js     801051d0 <sys_fstat+0x40>
801051bb:	83 ec 08             	sub    $0x8,%esp
801051be:	ff 75 f4             	pushl  -0xc(%ebp)
801051c1:	ff 75 f0             	pushl  -0x10(%ebp)
801051c4:	e8 77 bd ff ff       	call   80100f40 <filestat>
801051c9:	83 c4 10             	add    $0x10,%esp
801051cc:	c9                   	leave  
801051cd:	c3                   	ret    
801051ce:	66 90                	xchg   %ax,%ax
801051d0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801051d5:	c9                   	leave  
801051d6:	c3                   	ret    
801051d7:	89 f6                	mov    %esi,%esi
801051d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801051e0 <sys_link>:
801051e0:	55                   	push   %ebp
801051e1:	89 e5                	mov    %esp,%ebp
801051e3:	57                   	push   %edi
801051e4:	56                   	push   %esi
801051e5:	53                   	push   %ebx
801051e6:	8d 45 d4             	lea    -0x2c(%ebp),%eax
801051e9:	83 ec 34             	sub    $0x34,%esp
801051ec:	50                   	push   %eax
801051ed:	6a 00                	push   $0x0
801051ef:	e8 6c fb ff ff       	call   80104d60 <argstr>
801051f4:	83 c4 10             	add    $0x10,%esp
801051f7:	85 c0                	test   %eax,%eax
801051f9:	0f 88 fb 00 00 00    	js     801052fa <sys_link+0x11a>
801051ff:	8d 45 d0             	lea    -0x30(%ebp),%eax
80105202:	83 ec 08             	sub    $0x8,%esp
80105205:	50                   	push   %eax
80105206:	6a 01                	push   $0x1
80105208:	e8 53 fb ff ff       	call   80104d60 <argstr>
8010520d:	83 c4 10             	add    $0x10,%esp
80105210:	85 c0                	test   %eax,%eax
80105212:	0f 88 e2 00 00 00    	js     801052fa <sys_link+0x11a>
80105218:	e8 b3 d9 ff ff       	call   80102bd0 <begin_op>
8010521d:	83 ec 0c             	sub    $0xc,%esp
80105220:	ff 75 d4             	pushl  -0x2c(%ebp)
80105223:	e8 e8 cc ff ff       	call   80101f10 <namei>
80105228:	83 c4 10             	add    $0x10,%esp
8010522b:	85 c0                	test   %eax,%eax
8010522d:	89 c3                	mov    %eax,%ebx
8010522f:	0f 84 ea 00 00 00    	je     8010531f <sys_link+0x13f>
80105235:	83 ec 0c             	sub    $0xc,%esp
80105238:	50                   	push   %eax
80105239:	e8 72 c4 ff ff       	call   801016b0 <ilock>
8010523e:	83 c4 10             	add    $0x10,%esp
80105241:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105246:	0f 84 bb 00 00 00    	je     80105307 <sys_link+0x127>
8010524c:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
80105251:	83 ec 0c             	sub    $0xc,%esp
80105254:	8d 7d da             	lea    -0x26(%ebp),%edi
80105257:	53                   	push   %ebx
80105258:	e8 a3 c3 ff ff       	call   80101600 <iupdate>
8010525d:	89 1c 24             	mov    %ebx,(%esp)
80105260:	e8 2b c5 ff ff       	call   80101790 <iunlock>
80105265:	58                   	pop    %eax
80105266:	5a                   	pop    %edx
80105267:	57                   	push   %edi
80105268:	ff 75 d0             	pushl  -0x30(%ebp)
8010526b:	e8 c0 cc ff ff       	call   80101f30 <nameiparent>
80105270:	83 c4 10             	add    $0x10,%esp
80105273:	85 c0                	test   %eax,%eax
80105275:	89 c6                	mov    %eax,%esi
80105277:	74 5b                	je     801052d4 <sys_link+0xf4>
80105279:	83 ec 0c             	sub    $0xc,%esp
8010527c:	50                   	push   %eax
8010527d:	e8 2e c4 ff ff       	call   801016b0 <ilock>
80105282:	83 c4 10             	add    $0x10,%esp
80105285:	8b 03                	mov    (%ebx),%eax
80105287:	39 06                	cmp    %eax,(%esi)
80105289:	75 3d                	jne    801052c8 <sys_link+0xe8>
8010528b:	83 ec 04             	sub    $0x4,%esp
8010528e:	ff 73 04             	pushl  0x4(%ebx)
80105291:	57                   	push   %edi
80105292:	56                   	push   %esi
80105293:	e8 b8 cb ff ff       	call   80101e50 <dirlink>
80105298:	83 c4 10             	add    $0x10,%esp
8010529b:	85 c0                	test   %eax,%eax
8010529d:	78 29                	js     801052c8 <sys_link+0xe8>
8010529f:	83 ec 0c             	sub    $0xc,%esp
801052a2:	56                   	push   %esi
801052a3:	e8 98 c6 ff ff       	call   80101940 <iunlockput>
801052a8:	89 1c 24             	mov    %ebx,(%esp)
801052ab:	e8 30 c5 ff ff       	call   801017e0 <iput>
801052b0:	e8 8b d9 ff ff       	call   80102c40 <end_op>
801052b5:	83 c4 10             	add    $0x10,%esp
801052b8:	31 c0                	xor    %eax,%eax
801052ba:	8d 65 f4             	lea    -0xc(%ebp),%esp
801052bd:	5b                   	pop    %ebx
801052be:	5e                   	pop    %esi
801052bf:	5f                   	pop    %edi
801052c0:	5d                   	pop    %ebp
801052c1:	c3                   	ret    
801052c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801052c8:	83 ec 0c             	sub    $0xc,%esp
801052cb:	56                   	push   %esi
801052cc:	e8 6f c6 ff ff       	call   80101940 <iunlockput>
801052d1:	83 c4 10             	add    $0x10,%esp
801052d4:	83 ec 0c             	sub    $0xc,%esp
801052d7:	53                   	push   %ebx
801052d8:	e8 d3 c3 ff ff       	call   801016b0 <ilock>
801052dd:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
801052e2:	89 1c 24             	mov    %ebx,(%esp)
801052e5:	e8 16 c3 ff ff       	call   80101600 <iupdate>
801052ea:	89 1c 24             	mov    %ebx,(%esp)
801052ed:	e8 4e c6 ff ff       	call   80101940 <iunlockput>
801052f2:	e8 49 d9 ff ff       	call   80102c40 <end_op>
801052f7:	83 c4 10             	add    $0x10,%esp
801052fa:	8d 65 f4             	lea    -0xc(%ebp),%esp
801052fd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105302:	5b                   	pop    %ebx
80105303:	5e                   	pop    %esi
80105304:	5f                   	pop    %edi
80105305:	5d                   	pop    %ebp
80105306:	c3                   	ret    
80105307:	83 ec 0c             	sub    $0xc,%esp
8010530a:	53                   	push   %ebx
8010530b:	e8 30 c6 ff ff       	call   80101940 <iunlockput>
80105310:	e8 2b d9 ff ff       	call   80102c40 <end_op>
80105315:	83 c4 10             	add    $0x10,%esp
80105318:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010531d:	eb 9b                	jmp    801052ba <sys_link+0xda>
8010531f:	e8 1c d9 ff ff       	call   80102c40 <end_op>
80105324:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105329:	eb 8f                	jmp    801052ba <sys_link+0xda>
8010532b:	90                   	nop
8010532c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105330 <sys_unlink>:
80105330:	55                   	push   %ebp
80105331:	89 e5                	mov    %esp,%ebp
80105333:	57                   	push   %edi
80105334:	56                   	push   %esi
80105335:	53                   	push   %ebx
80105336:	8d 45 c0             	lea    -0x40(%ebp),%eax
80105339:	83 ec 44             	sub    $0x44,%esp
8010533c:	50                   	push   %eax
8010533d:	6a 00                	push   $0x0
8010533f:	e8 1c fa ff ff       	call   80104d60 <argstr>
80105344:	83 c4 10             	add    $0x10,%esp
80105347:	85 c0                	test   %eax,%eax
80105349:	0f 88 77 01 00 00    	js     801054c6 <sys_unlink+0x196>
8010534f:	8d 5d ca             	lea    -0x36(%ebp),%ebx
80105352:	e8 79 d8 ff ff       	call   80102bd0 <begin_op>
80105357:	83 ec 08             	sub    $0x8,%esp
8010535a:	53                   	push   %ebx
8010535b:	ff 75 c0             	pushl  -0x40(%ebp)
8010535e:	e8 cd cb ff ff       	call   80101f30 <nameiparent>
80105363:	83 c4 10             	add    $0x10,%esp
80105366:	85 c0                	test   %eax,%eax
80105368:	89 c6                	mov    %eax,%esi
8010536a:	0f 84 60 01 00 00    	je     801054d0 <sys_unlink+0x1a0>
80105370:	83 ec 0c             	sub    $0xc,%esp
80105373:	50                   	push   %eax
80105374:	e8 37 c3 ff ff       	call   801016b0 <ilock>
80105379:	58                   	pop    %eax
8010537a:	5a                   	pop    %edx
8010537b:	68 a0 7c 10 80       	push   $0x80107ca0
80105380:	53                   	push   %ebx
80105381:	e8 3a c8 ff ff       	call   80101bc0 <namecmp>
80105386:	83 c4 10             	add    $0x10,%esp
80105389:	85 c0                	test   %eax,%eax
8010538b:	0f 84 03 01 00 00    	je     80105494 <sys_unlink+0x164>
80105391:	83 ec 08             	sub    $0x8,%esp
80105394:	68 9f 7c 10 80       	push   $0x80107c9f
80105399:	53                   	push   %ebx
8010539a:	e8 21 c8 ff ff       	call   80101bc0 <namecmp>
8010539f:	83 c4 10             	add    $0x10,%esp
801053a2:	85 c0                	test   %eax,%eax
801053a4:	0f 84 ea 00 00 00    	je     80105494 <sys_unlink+0x164>
801053aa:	8d 45 c4             	lea    -0x3c(%ebp),%eax
801053ad:	83 ec 04             	sub    $0x4,%esp
801053b0:	50                   	push   %eax
801053b1:	53                   	push   %ebx
801053b2:	56                   	push   %esi
801053b3:	e8 28 c8 ff ff       	call   80101be0 <dirlookup>
801053b8:	83 c4 10             	add    $0x10,%esp
801053bb:	85 c0                	test   %eax,%eax
801053bd:	89 c3                	mov    %eax,%ebx
801053bf:	0f 84 cf 00 00 00    	je     80105494 <sys_unlink+0x164>
801053c5:	83 ec 0c             	sub    $0xc,%esp
801053c8:	50                   	push   %eax
801053c9:	e8 e2 c2 ff ff       	call   801016b0 <ilock>
801053ce:	83 c4 10             	add    $0x10,%esp
801053d1:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
801053d6:	0f 8e 10 01 00 00    	jle    801054ec <sys_unlink+0x1bc>
801053dc:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801053e1:	74 6d                	je     80105450 <sys_unlink+0x120>
801053e3:	8d 45 d8             	lea    -0x28(%ebp),%eax
801053e6:	83 ec 04             	sub    $0x4,%esp
801053e9:	6a 10                	push   $0x10
801053eb:	6a 00                	push   $0x0
801053ed:	50                   	push   %eax
801053ee:	e8 bd f5 ff ff       	call   801049b0 <memset>
801053f3:	8d 45 d8             	lea    -0x28(%ebp),%eax
801053f6:	6a 10                	push   $0x10
801053f8:	ff 75 c4             	pushl  -0x3c(%ebp)
801053fb:	50                   	push   %eax
801053fc:	56                   	push   %esi
801053fd:	e8 8e c6 ff ff       	call   80101a90 <writei>
80105402:	83 c4 20             	add    $0x20,%esp
80105405:	83 f8 10             	cmp    $0x10,%eax
80105408:	0f 85 eb 00 00 00    	jne    801054f9 <sys_unlink+0x1c9>
8010540e:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105413:	0f 84 97 00 00 00    	je     801054b0 <sys_unlink+0x180>
80105419:	83 ec 0c             	sub    $0xc,%esp
8010541c:	56                   	push   %esi
8010541d:	e8 1e c5 ff ff       	call   80101940 <iunlockput>
80105422:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
80105427:	89 1c 24             	mov    %ebx,(%esp)
8010542a:	e8 d1 c1 ff ff       	call   80101600 <iupdate>
8010542f:	89 1c 24             	mov    %ebx,(%esp)
80105432:	e8 09 c5 ff ff       	call   80101940 <iunlockput>
80105437:	e8 04 d8 ff ff       	call   80102c40 <end_op>
8010543c:	83 c4 10             	add    $0x10,%esp
8010543f:	31 c0                	xor    %eax,%eax
80105441:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105444:	5b                   	pop    %ebx
80105445:	5e                   	pop    %esi
80105446:	5f                   	pop    %edi
80105447:	5d                   	pop    %ebp
80105448:	c3                   	ret    
80105449:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105450:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
80105454:	76 8d                	jbe    801053e3 <sys_unlink+0xb3>
80105456:	bf 20 00 00 00       	mov    $0x20,%edi
8010545b:	eb 0f                	jmp    8010546c <sys_unlink+0x13c>
8010545d:	8d 76 00             	lea    0x0(%esi),%esi
80105460:	83 c7 10             	add    $0x10,%edi
80105463:	3b 7b 58             	cmp    0x58(%ebx),%edi
80105466:	0f 83 77 ff ff ff    	jae    801053e3 <sys_unlink+0xb3>
8010546c:	8d 45 d8             	lea    -0x28(%ebp),%eax
8010546f:	6a 10                	push   $0x10
80105471:	57                   	push   %edi
80105472:	50                   	push   %eax
80105473:	53                   	push   %ebx
80105474:	e8 17 c5 ff ff       	call   80101990 <readi>
80105479:	83 c4 10             	add    $0x10,%esp
8010547c:	83 f8 10             	cmp    $0x10,%eax
8010547f:	75 5e                	jne    801054df <sys_unlink+0x1af>
80105481:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80105486:	74 d8                	je     80105460 <sys_unlink+0x130>
80105488:	83 ec 0c             	sub    $0xc,%esp
8010548b:	53                   	push   %ebx
8010548c:	e8 af c4 ff ff       	call   80101940 <iunlockput>
80105491:	83 c4 10             	add    $0x10,%esp
80105494:	83 ec 0c             	sub    $0xc,%esp
80105497:	56                   	push   %esi
80105498:	e8 a3 c4 ff ff       	call   80101940 <iunlockput>
8010549d:	e8 9e d7 ff ff       	call   80102c40 <end_op>
801054a2:	83 c4 10             	add    $0x10,%esp
801054a5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801054aa:	eb 95                	jmp    80105441 <sys_unlink+0x111>
801054ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801054b0:	66 83 6e 56 01       	subw   $0x1,0x56(%esi)
801054b5:	83 ec 0c             	sub    $0xc,%esp
801054b8:	56                   	push   %esi
801054b9:	e8 42 c1 ff ff       	call   80101600 <iupdate>
801054be:	83 c4 10             	add    $0x10,%esp
801054c1:	e9 53 ff ff ff       	jmp    80105419 <sys_unlink+0xe9>
801054c6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801054cb:	e9 71 ff ff ff       	jmp    80105441 <sys_unlink+0x111>
801054d0:	e8 6b d7 ff ff       	call   80102c40 <end_op>
801054d5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801054da:	e9 62 ff ff ff       	jmp    80105441 <sys_unlink+0x111>
801054df:	83 ec 0c             	sub    $0xc,%esp
801054e2:	68 c4 7c 10 80       	push   $0x80107cc4
801054e7:	e8 a4 ae ff ff       	call   80100390 <panic>
801054ec:	83 ec 0c             	sub    $0xc,%esp
801054ef:	68 b2 7c 10 80       	push   $0x80107cb2
801054f4:	e8 97 ae ff ff       	call   80100390 <panic>
801054f9:	83 ec 0c             	sub    $0xc,%esp
801054fc:	68 d6 7c 10 80       	push   $0x80107cd6
80105501:	e8 8a ae ff ff       	call   80100390 <panic>
80105506:	8d 76 00             	lea    0x0(%esi),%esi
80105509:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105510 <sys_open>:
80105510:	55                   	push   %ebp
80105511:	89 e5                	mov    %esp,%ebp
80105513:	57                   	push   %edi
80105514:	56                   	push   %esi
80105515:	53                   	push   %ebx
80105516:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105519:	83 ec 24             	sub    $0x24,%esp
8010551c:	50                   	push   %eax
8010551d:	6a 00                	push   $0x0
8010551f:	e8 3c f8 ff ff       	call   80104d60 <argstr>
80105524:	83 c4 10             	add    $0x10,%esp
80105527:	85 c0                	test   %eax,%eax
80105529:	0f 88 1d 01 00 00    	js     8010564c <sys_open+0x13c>
8010552f:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105532:	83 ec 08             	sub    $0x8,%esp
80105535:	50                   	push   %eax
80105536:	6a 01                	push   $0x1
80105538:	e8 73 f7 ff ff       	call   80104cb0 <argint>
8010553d:	83 c4 10             	add    $0x10,%esp
80105540:	85 c0                	test   %eax,%eax
80105542:	0f 88 04 01 00 00    	js     8010564c <sys_open+0x13c>
80105548:	e8 83 d6 ff ff       	call   80102bd0 <begin_op>
8010554d:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
80105551:	0f 85 a9 00 00 00    	jne    80105600 <sys_open+0xf0>
80105557:	83 ec 0c             	sub    $0xc,%esp
8010555a:	ff 75 e0             	pushl  -0x20(%ebp)
8010555d:	e8 ae c9 ff ff       	call   80101f10 <namei>
80105562:	83 c4 10             	add    $0x10,%esp
80105565:	85 c0                	test   %eax,%eax
80105567:	89 c6                	mov    %eax,%esi
80105569:	0f 84 b2 00 00 00    	je     80105621 <sys_open+0x111>
8010556f:	83 ec 0c             	sub    $0xc,%esp
80105572:	50                   	push   %eax
80105573:	e8 38 c1 ff ff       	call   801016b0 <ilock>
80105578:	83 c4 10             	add    $0x10,%esp
8010557b:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80105580:	0f 84 aa 00 00 00    	je     80105630 <sys_open+0x120>
80105586:	e8 25 b8 ff ff       	call   80100db0 <filealloc>
8010558b:	85 c0                	test   %eax,%eax
8010558d:	89 c7                	mov    %eax,%edi
8010558f:	0f 84 a6 00 00 00    	je     8010563b <sys_open+0x12b>
80105595:	e8 76 e3 ff ff       	call   80103910 <myproc>
8010559a:	31 db                	xor    %ebx,%ebx
8010559c:	eb 0e                	jmp    801055ac <sys_open+0x9c>
8010559e:	66 90                	xchg   %ax,%ax
801055a0:	83 c3 01             	add    $0x1,%ebx
801055a3:	83 fb 10             	cmp    $0x10,%ebx
801055a6:	0f 84 ac 00 00 00    	je     80105658 <sys_open+0x148>
801055ac:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
801055b0:	85 d2                	test   %edx,%edx
801055b2:	75 ec                	jne    801055a0 <sys_open+0x90>
801055b4:	83 ec 0c             	sub    $0xc,%esp
801055b7:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
801055bb:	56                   	push   %esi
801055bc:	e8 cf c1 ff ff       	call   80101790 <iunlock>
801055c1:	e8 7a d6 ff ff       	call   80102c40 <end_op>
801055c6:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
801055cc:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801055cf:	83 c4 10             	add    $0x10,%esp
801055d2:	89 77 10             	mov    %esi,0x10(%edi)
801055d5:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
801055dc:	89 d0                	mov    %edx,%eax
801055de:	f7 d0                	not    %eax
801055e0:	83 e0 01             	and    $0x1,%eax
801055e3:	83 e2 03             	and    $0x3,%edx
801055e6:	88 47 08             	mov    %al,0x8(%edi)
801055e9:	0f 95 47 09          	setne  0x9(%edi)
801055ed:	8d 65 f4             	lea    -0xc(%ebp),%esp
801055f0:	89 d8                	mov    %ebx,%eax
801055f2:	5b                   	pop    %ebx
801055f3:	5e                   	pop    %esi
801055f4:	5f                   	pop    %edi
801055f5:	5d                   	pop    %ebp
801055f6:	c3                   	ret    
801055f7:	89 f6                	mov    %esi,%esi
801055f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105600:	83 ec 0c             	sub    $0xc,%esp
80105603:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105606:	31 c9                	xor    %ecx,%ecx
80105608:	6a 00                	push   $0x0
8010560a:	ba 02 00 00 00       	mov    $0x2,%edx
8010560f:	e8 ec f7 ff ff       	call   80104e00 <create>
80105614:	83 c4 10             	add    $0x10,%esp
80105617:	85 c0                	test   %eax,%eax
80105619:	89 c6                	mov    %eax,%esi
8010561b:	0f 85 65 ff ff ff    	jne    80105586 <sys_open+0x76>
80105621:	e8 1a d6 ff ff       	call   80102c40 <end_op>
80105626:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
8010562b:	eb c0                	jmp    801055ed <sys_open+0xdd>
8010562d:	8d 76 00             	lea    0x0(%esi),%esi
80105630:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80105633:	85 c9                	test   %ecx,%ecx
80105635:	0f 84 4b ff ff ff    	je     80105586 <sys_open+0x76>
8010563b:	83 ec 0c             	sub    $0xc,%esp
8010563e:	56                   	push   %esi
8010563f:	e8 fc c2 ff ff       	call   80101940 <iunlockput>
80105644:	e8 f7 d5 ff ff       	call   80102c40 <end_op>
80105649:	83 c4 10             	add    $0x10,%esp
8010564c:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105651:	eb 9a                	jmp    801055ed <sys_open+0xdd>
80105653:	90                   	nop
80105654:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105658:	83 ec 0c             	sub    $0xc,%esp
8010565b:	57                   	push   %edi
8010565c:	e8 0f b8 ff ff       	call   80100e70 <fileclose>
80105661:	83 c4 10             	add    $0x10,%esp
80105664:	eb d5                	jmp    8010563b <sys_open+0x12b>
80105666:	8d 76 00             	lea    0x0(%esi),%esi
80105669:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105670 <sys_mkdir>:
80105670:	55                   	push   %ebp
80105671:	89 e5                	mov    %esp,%ebp
80105673:	83 ec 18             	sub    $0x18,%esp
80105676:	e8 55 d5 ff ff       	call   80102bd0 <begin_op>
8010567b:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010567e:	83 ec 08             	sub    $0x8,%esp
80105681:	50                   	push   %eax
80105682:	6a 00                	push   $0x0
80105684:	e8 d7 f6 ff ff       	call   80104d60 <argstr>
80105689:	83 c4 10             	add    $0x10,%esp
8010568c:	85 c0                	test   %eax,%eax
8010568e:	78 30                	js     801056c0 <sys_mkdir+0x50>
80105690:	83 ec 0c             	sub    $0xc,%esp
80105693:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105696:	31 c9                	xor    %ecx,%ecx
80105698:	6a 00                	push   $0x0
8010569a:	ba 01 00 00 00       	mov    $0x1,%edx
8010569f:	e8 5c f7 ff ff       	call   80104e00 <create>
801056a4:	83 c4 10             	add    $0x10,%esp
801056a7:	85 c0                	test   %eax,%eax
801056a9:	74 15                	je     801056c0 <sys_mkdir+0x50>
801056ab:	83 ec 0c             	sub    $0xc,%esp
801056ae:	50                   	push   %eax
801056af:	e8 8c c2 ff ff       	call   80101940 <iunlockput>
801056b4:	e8 87 d5 ff ff       	call   80102c40 <end_op>
801056b9:	83 c4 10             	add    $0x10,%esp
801056bc:	31 c0                	xor    %eax,%eax
801056be:	c9                   	leave  
801056bf:	c3                   	ret    
801056c0:	e8 7b d5 ff ff       	call   80102c40 <end_op>
801056c5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801056ca:	c9                   	leave  
801056cb:	c3                   	ret    
801056cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801056d0 <sys_mknod>:
801056d0:	55                   	push   %ebp
801056d1:	89 e5                	mov    %esp,%ebp
801056d3:	83 ec 18             	sub    $0x18,%esp
801056d6:	e8 f5 d4 ff ff       	call   80102bd0 <begin_op>
801056db:	8d 45 ec             	lea    -0x14(%ebp),%eax
801056de:	83 ec 08             	sub    $0x8,%esp
801056e1:	50                   	push   %eax
801056e2:	6a 00                	push   $0x0
801056e4:	e8 77 f6 ff ff       	call   80104d60 <argstr>
801056e9:	83 c4 10             	add    $0x10,%esp
801056ec:	85 c0                	test   %eax,%eax
801056ee:	78 60                	js     80105750 <sys_mknod+0x80>
801056f0:	8d 45 f0             	lea    -0x10(%ebp),%eax
801056f3:	83 ec 08             	sub    $0x8,%esp
801056f6:	50                   	push   %eax
801056f7:	6a 01                	push   $0x1
801056f9:	e8 b2 f5 ff ff       	call   80104cb0 <argint>
801056fe:	83 c4 10             	add    $0x10,%esp
80105701:	85 c0                	test   %eax,%eax
80105703:	78 4b                	js     80105750 <sys_mknod+0x80>
80105705:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105708:	83 ec 08             	sub    $0x8,%esp
8010570b:	50                   	push   %eax
8010570c:	6a 02                	push   $0x2
8010570e:	e8 9d f5 ff ff       	call   80104cb0 <argint>
80105713:	83 c4 10             	add    $0x10,%esp
80105716:	85 c0                	test   %eax,%eax
80105718:	78 36                	js     80105750 <sys_mknod+0x80>
8010571a:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
8010571e:	83 ec 0c             	sub    $0xc,%esp
80105721:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
80105725:	ba 03 00 00 00       	mov    $0x3,%edx
8010572a:	50                   	push   %eax
8010572b:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010572e:	e8 cd f6 ff ff       	call   80104e00 <create>
80105733:	83 c4 10             	add    $0x10,%esp
80105736:	85 c0                	test   %eax,%eax
80105738:	74 16                	je     80105750 <sys_mknod+0x80>
8010573a:	83 ec 0c             	sub    $0xc,%esp
8010573d:	50                   	push   %eax
8010573e:	e8 fd c1 ff ff       	call   80101940 <iunlockput>
80105743:	e8 f8 d4 ff ff       	call   80102c40 <end_op>
80105748:	83 c4 10             	add    $0x10,%esp
8010574b:	31 c0                	xor    %eax,%eax
8010574d:	c9                   	leave  
8010574e:	c3                   	ret    
8010574f:	90                   	nop
80105750:	e8 eb d4 ff ff       	call   80102c40 <end_op>
80105755:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010575a:	c9                   	leave  
8010575b:	c3                   	ret    
8010575c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105760 <sys_chdir>:
80105760:	55                   	push   %ebp
80105761:	89 e5                	mov    %esp,%ebp
80105763:	56                   	push   %esi
80105764:	53                   	push   %ebx
80105765:	83 ec 10             	sub    $0x10,%esp
80105768:	e8 a3 e1 ff ff       	call   80103910 <myproc>
8010576d:	89 c6                	mov    %eax,%esi
8010576f:	e8 5c d4 ff ff       	call   80102bd0 <begin_op>
80105774:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105777:	83 ec 08             	sub    $0x8,%esp
8010577a:	50                   	push   %eax
8010577b:	6a 00                	push   $0x0
8010577d:	e8 de f5 ff ff       	call   80104d60 <argstr>
80105782:	83 c4 10             	add    $0x10,%esp
80105785:	85 c0                	test   %eax,%eax
80105787:	78 77                	js     80105800 <sys_chdir+0xa0>
80105789:	83 ec 0c             	sub    $0xc,%esp
8010578c:	ff 75 f4             	pushl  -0xc(%ebp)
8010578f:	e8 7c c7 ff ff       	call   80101f10 <namei>
80105794:	83 c4 10             	add    $0x10,%esp
80105797:	85 c0                	test   %eax,%eax
80105799:	89 c3                	mov    %eax,%ebx
8010579b:	74 63                	je     80105800 <sys_chdir+0xa0>
8010579d:	83 ec 0c             	sub    $0xc,%esp
801057a0:	50                   	push   %eax
801057a1:	e8 0a bf ff ff       	call   801016b0 <ilock>
801057a6:	83 c4 10             	add    $0x10,%esp
801057a9:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801057ae:	75 30                	jne    801057e0 <sys_chdir+0x80>
801057b0:	83 ec 0c             	sub    $0xc,%esp
801057b3:	53                   	push   %ebx
801057b4:	e8 d7 bf ff ff       	call   80101790 <iunlock>
801057b9:	58                   	pop    %eax
801057ba:	ff 76 68             	pushl  0x68(%esi)
801057bd:	e8 1e c0 ff ff       	call   801017e0 <iput>
801057c2:	e8 79 d4 ff ff       	call   80102c40 <end_op>
801057c7:	89 5e 68             	mov    %ebx,0x68(%esi)
801057ca:	83 c4 10             	add    $0x10,%esp
801057cd:	31 c0                	xor    %eax,%eax
801057cf:	8d 65 f8             	lea    -0x8(%ebp),%esp
801057d2:	5b                   	pop    %ebx
801057d3:	5e                   	pop    %esi
801057d4:	5d                   	pop    %ebp
801057d5:	c3                   	ret    
801057d6:	8d 76 00             	lea    0x0(%esi),%esi
801057d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801057e0:	83 ec 0c             	sub    $0xc,%esp
801057e3:	53                   	push   %ebx
801057e4:	e8 57 c1 ff ff       	call   80101940 <iunlockput>
801057e9:	e8 52 d4 ff ff       	call   80102c40 <end_op>
801057ee:	83 c4 10             	add    $0x10,%esp
801057f1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801057f6:	eb d7                	jmp    801057cf <sys_chdir+0x6f>
801057f8:	90                   	nop
801057f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105800:	e8 3b d4 ff ff       	call   80102c40 <end_op>
80105805:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010580a:	eb c3                	jmp    801057cf <sys_chdir+0x6f>
8010580c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105810 <sys_exec>:
80105810:	55                   	push   %ebp
80105811:	89 e5                	mov    %esp,%ebp
80105813:	57                   	push   %edi
80105814:	56                   	push   %esi
80105815:	53                   	push   %ebx
80105816:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
8010581c:	81 ec a4 00 00 00    	sub    $0xa4,%esp
80105822:	50                   	push   %eax
80105823:	6a 00                	push   $0x0
80105825:	e8 36 f5 ff ff       	call   80104d60 <argstr>
8010582a:	83 c4 10             	add    $0x10,%esp
8010582d:	85 c0                	test   %eax,%eax
8010582f:	0f 88 87 00 00 00    	js     801058bc <sys_exec+0xac>
80105835:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
8010583b:	83 ec 08             	sub    $0x8,%esp
8010583e:	50                   	push   %eax
8010583f:	6a 01                	push   $0x1
80105841:	e8 6a f4 ff ff       	call   80104cb0 <argint>
80105846:	83 c4 10             	add    $0x10,%esp
80105849:	85 c0                	test   %eax,%eax
8010584b:	78 6f                	js     801058bc <sys_exec+0xac>
8010584d:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80105853:	83 ec 04             	sub    $0x4,%esp
80105856:	31 db                	xor    %ebx,%ebx
80105858:	68 80 00 00 00       	push   $0x80
8010585d:	6a 00                	push   $0x0
8010585f:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
80105865:	50                   	push   %eax
80105866:	e8 45 f1 ff ff       	call   801049b0 <memset>
8010586b:	83 c4 10             	add    $0x10,%esp
8010586e:	eb 2c                	jmp    8010589c <sys_exec+0x8c>
80105870:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80105876:	85 c0                	test   %eax,%eax
80105878:	74 56                	je     801058d0 <sys_exec+0xc0>
8010587a:	8d 8d 68 ff ff ff    	lea    -0x98(%ebp),%ecx
80105880:	83 ec 08             	sub    $0x8,%esp
80105883:	8d 14 31             	lea    (%ecx,%esi,1),%edx
80105886:	52                   	push   %edx
80105887:	50                   	push   %eax
80105888:	e8 b3 f3 ff ff       	call   80104c40 <fetchstr>
8010588d:	83 c4 10             	add    $0x10,%esp
80105890:	85 c0                	test   %eax,%eax
80105892:	78 28                	js     801058bc <sys_exec+0xac>
80105894:	83 c3 01             	add    $0x1,%ebx
80105897:	83 fb 20             	cmp    $0x20,%ebx
8010589a:	74 20                	je     801058bc <sys_exec+0xac>
8010589c:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
801058a2:	8d 34 9d 00 00 00 00 	lea    0x0(,%ebx,4),%esi
801058a9:	83 ec 08             	sub    $0x8,%esp
801058ac:	57                   	push   %edi
801058ad:	01 f0                	add    %esi,%eax
801058af:	50                   	push   %eax
801058b0:	e8 4b f3 ff ff       	call   80104c00 <fetchint>
801058b5:	83 c4 10             	add    $0x10,%esp
801058b8:	85 c0                	test   %eax,%eax
801058ba:	79 b4                	jns    80105870 <sys_exec+0x60>
801058bc:	8d 65 f4             	lea    -0xc(%ebp),%esp
801058bf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801058c4:	5b                   	pop    %ebx
801058c5:	5e                   	pop    %esi
801058c6:	5f                   	pop    %edi
801058c7:	5d                   	pop    %ebp
801058c8:	c3                   	ret    
801058c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801058d0:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
801058d6:	83 ec 08             	sub    $0x8,%esp
801058d9:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
801058e0:	00 00 00 00 
801058e4:	50                   	push   %eax
801058e5:	ff b5 5c ff ff ff    	pushl  -0xa4(%ebp)
801058eb:	e8 20 b1 ff ff       	call   80100a10 <exec>
801058f0:	83 c4 10             	add    $0x10,%esp
801058f3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801058f6:	5b                   	pop    %ebx
801058f7:	5e                   	pop    %esi
801058f8:	5f                   	pop    %edi
801058f9:	5d                   	pop    %ebp
801058fa:	c3                   	ret    
801058fb:	90                   	nop
801058fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105900 <sys_pipe>:
80105900:	55                   	push   %ebp
80105901:	89 e5                	mov    %esp,%ebp
80105903:	57                   	push   %edi
80105904:	56                   	push   %esi
80105905:	53                   	push   %ebx
80105906:	8d 45 dc             	lea    -0x24(%ebp),%eax
80105909:	83 ec 20             	sub    $0x20,%esp
8010590c:	6a 08                	push   $0x8
8010590e:	50                   	push   %eax
8010590f:	6a 00                	push   $0x0
80105911:	e8 ea f3 ff ff       	call   80104d00 <argptr>
80105916:	83 c4 10             	add    $0x10,%esp
80105919:	85 c0                	test   %eax,%eax
8010591b:	0f 88 ae 00 00 00    	js     801059cf <sys_pipe+0xcf>
80105921:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105924:	83 ec 08             	sub    $0x8,%esp
80105927:	50                   	push   %eax
80105928:	8d 45 e0             	lea    -0x20(%ebp),%eax
8010592b:	50                   	push   %eax
8010592c:	e8 3f d9 ff ff       	call   80103270 <pipealloc>
80105931:	83 c4 10             	add    $0x10,%esp
80105934:	85 c0                	test   %eax,%eax
80105936:	0f 88 93 00 00 00    	js     801059cf <sys_pipe+0xcf>
8010593c:	8b 7d e0             	mov    -0x20(%ebp),%edi
8010593f:	31 db                	xor    %ebx,%ebx
80105941:	e8 ca df ff ff       	call   80103910 <myproc>
80105946:	eb 10                	jmp    80105958 <sys_pipe+0x58>
80105948:	90                   	nop
80105949:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105950:	83 c3 01             	add    $0x1,%ebx
80105953:	83 fb 10             	cmp    $0x10,%ebx
80105956:	74 60                	je     801059b8 <sys_pipe+0xb8>
80105958:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
8010595c:	85 f6                	test   %esi,%esi
8010595e:	75 f0                	jne    80105950 <sys_pipe+0x50>
80105960:	8d 73 08             	lea    0x8(%ebx),%esi
80105963:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
80105967:	8b 7d e4             	mov    -0x1c(%ebp),%edi
8010596a:	e8 a1 df ff ff       	call   80103910 <myproc>
8010596f:	31 d2                	xor    %edx,%edx
80105971:	eb 0d                	jmp    80105980 <sys_pipe+0x80>
80105973:	90                   	nop
80105974:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105978:	83 c2 01             	add    $0x1,%edx
8010597b:	83 fa 10             	cmp    $0x10,%edx
8010597e:	74 28                	je     801059a8 <sys_pipe+0xa8>
80105980:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
80105984:	85 c9                	test   %ecx,%ecx
80105986:	75 f0                	jne    80105978 <sys_pipe+0x78>
80105988:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
8010598c:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010598f:	89 18                	mov    %ebx,(%eax)
80105991:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105994:	89 50 04             	mov    %edx,0x4(%eax)
80105997:	31 c0                	xor    %eax,%eax
80105999:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010599c:	5b                   	pop    %ebx
8010599d:	5e                   	pop    %esi
8010599e:	5f                   	pop    %edi
8010599f:	5d                   	pop    %ebp
801059a0:	c3                   	ret    
801059a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801059a8:	e8 63 df ff ff       	call   80103910 <myproc>
801059ad:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
801059b4:	00 
801059b5:	8d 76 00             	lea    0x0(%esi),%esi
801059b8:	83 ec 0c             	sub    $0xc,%esp
801059bb:	ff 75 e0             	pushl  -0x20(%ebp)
801059be:	e8 ad b4 ff ff       	call   80100e70 <fileclose>
801059c3:	58                   	pop    %eax
801059c4:	ff 75 e4             	pushl  -0x1c(%ebp)
801059c7:	e8 a4 b4 ff ff       	call   80100e70 <fileclose>
801059cc:	83 c4 10             	add    $0x10,%esp
801059cf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801059d4:	eb c3                	jmp    80105999 <sys_pipe+0x99>
801059d6:	66 90                	xchg   %ax,%ax
801059d8:	66 90                	xchg   %ax,%ax
801059da:	66 90                	xchg   %ax,%ax
801059dc:	66 90                	xchg   %ax,%ax
801059de:	66 90                	xchg   %ax,%ax

801059e0 <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
801059e0:	55                   	push   %ebp
801059e1:	89 e5                	mov    %esp,%ebp
  return fork();
}
801059e3:	5d                   	pop    %ebp
  return fork();
801059e4:	e9 e7 e0 ff ff       	jmp    80103ad0 <fork>
801059e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801059f0 <sys_exit>:

int
sys_exit(void)
{
801059f0:	55                   	push   %ebp
801059f1:	89 e5                	mov    %esp,%ebp
801059f3:	83 ec 08             	sub    $0x8,%esp
  exit();
801059f6:	e8 e5 e3 ff ff       	call   80103de0 <exit>
  return 0;  // not reached
}
801059fb:	31 c0                	xor    %eax,%eax
801059fd:	c9                   	leave  
801059fe:	c3                   	ret    
801059ff:	90                   	nop

80105a00 <sys_wait>:

int
sys_wait(void)
{
80105a00:	55                   	push   %ebp
80105a01:	89 e5                	mov    %esp,%ebp
  return wait();
}
80105a03:	5d                   	pop    %ebp
  return wait();
80105a04:	e9 c7 e5 ff ff       	jmp    80103fd0 <wait>
80105a09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105a10 <sys_kill>:

int
sys_kill(void)
{
80105a10:	55                   	push   %ebp
80105a11:	89 e5                	mov    %esp,%ebp
80105a13:	83 ec 20             	sub    $0x20,%esp
  int pid;
  int signum;

  if(argint(0, &pid) < 0)
80105a16:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105a19:	50                   	push   %eax
80105a1a:	6a 00                	push   $0x0
80105a1c:	e8 8f f2 ff ff       	call   80104cb0 <argint>
80105a21:	83 c4 10             	add    $0x10,%esp
80105a24:	85 c0                	test   %eax,%eax
80105a26:	78 28                	js     80105a50 <sys_kill+0x40>
    return -1;
  if(argint(1, &signum) < 0)
80105a28:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105a2b:	83 ec 08             	sub    $0x8,%esp
80105a2e:	50                   	push   %eax
80105a2f:	6a 01                	push   $0x1
80105a31:	e8 7a f2 ff ff       	call   80104cb0 <argint>
80105a36:	83 c4 10             	add    $0x10,%esp
80105a39:	85 c0                	test   %eax,%eax
80105a3b:	78 13                	js     80105a50 <sys_kill+0x40>
    return -1;
  return kill(pid, signum);
80105a3d:	83 ec 08             	sub    $0x8,%esp
80105a40:	ff 75 f4             	pushl  -0xc(%ebp)
80105a43:	ff 75 f0             	pushl  -0x10(%ebp)
80105a46:	e8 a5 e6 ff ff       	call   801040f0 <kill>
80105a4b:	83 c4 10             	add    $0x10,%esp
}
80105a4e:	c9                   	leave  
80105a4f:	c3                   	ret    
    return -1;
80105a50:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105a55:	c9                   	leave  
80105a56:	c3                   	ret    
80105a57:	89 f6                	mov    %esi,%esi
80105a59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105a60 <sys_getpid>:

int
sys_getpid(void)
{
80105a60:	55                   	push   %ebp
80105a61:	89 e5                	mov    %esp,%ebp
80105a63:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
80105a66:	e8 a5 de ff ff       	call   80103910 <myproc>
80105a6b:	8b 40 10             	mov    0x10(%eax),%eax
}
80105a6e:	c9                   	leave  
80105a6f:	c3                   	ret    

80105a70 <sys_sbrk>:

int
sys_sbrk(void)
{
80105a70:	55                   	push   %ebp
80105a71:	89 e5                	mov    %esp,%ebp
80105a73:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
80105a74:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105a77:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
80105a7a:	50                   	push   %eax
80105a7b:	6a 00                	push   $0x0
80105a7d:	e8 2e f2 ff ff       	call   80104cb0 <argint>
80105a82:	83 c4 10             	add    $0x10,%esp
80105a85:	85 c0                	test   %eax,%eax
80105a87:	78 27                	js     80105ab0 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
80105a89:	e8 82 de ff ff       	call   80103910 <myproc>
  if(growproc(n) < 0)
80105a8e:	83 ec 0c             	sub    $0xc,%esp
  addr = myproc()->sz;
80105a91:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80105a93:	ff 75 f4             	pushl  -0xc(%ebp)
80105a96:	e8 b5 df ff ff       	call   80103a50 <growproc>
80105a9b:	83 c4 10             	add    $0x10,%esp
80105a9e:	85 c0                	test   %eax,%eax
80105aa0:	78 0e                	js     80105ab0 <sys_sbrk+0x40>
    return -1;
  return addr;
}
80105aa2:	89 d8                	mov    %ebx,%eax
80105aa4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105aa7:	c9                   	leave  
80105aa8:	c3                   	ret    
80105aa9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105ab0:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105ab5:	eb eb                	jmp    80105aa2 <sys_sbrk+0x32>
80105ab7:	89 f6                	mov    %esi,%esi
80105ab9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105ac0 <sys_sleep>:

int
sys_sleep(void)
{
80105ac0:	55                   	push   %ebp
80105ac1:	89 e5                	mov    %esp,%ebp
80105ac3:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80105ac4:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105ac7:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
80105aca:	50                   	push   %eax
80105acb:	6a 00                	push   $0x0
80105acd:	e8 de f1 ff ff       	call   80104cb0 <argint>
80105ad2:	83 c4 10             	add    $0x10,%esp
80105ad5:	85 c0                	test   %eax,%eax
80105ad7:	0f 88 8a 00 00 00    	js     80105b67 <sys_sleep+0xa7>
    return -1;
  acquire(&tickslock);
80105add:	83 ec 0c             	sub    $0xc,%esp
80105ae0:	68 60 92 11 80       	push   $0x80119260
80105ae5:	e8 b6 ed ff ff       	call   801048a0 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
80105aea:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105aed:	83 c4 10             	add    $0x10,%esp
  ticks0 = ticks;
80105af0:	8b 1d a0 9a 11 80    	mov    0x80119aa0,%ebx
  while(ticks - ticks0 < n){
80105af6:	85 d2                	test   %edx,%edx
80105af8:	75 27                	jne    80105b21 <sys_sleep+0x61>
80105afa:	eb 54                	jmp    80105b50 <sys_sleep+0x90>
80105afc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80105b00:	83 ec 08             	sub    $0x8,%esp
80105b03:	68 60 92 11 80       	push   $0x80119260
80105b08:	68 a0 9a 11 80       	push   $0x80119aa0
80105b0d:	e8 0e e4 ff ff       	call   80103f20 <sleep>
  while(ticks - ticks0 < n){
80105b12:	a1 a0 9a 11 80       	mov    0x80119aa0,%eax
80105b17:	83 c4 10             	add    $0x10,%esp
80105b1a:	29 d8                	sub    %ebx,%eax
80105b1c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80105b1f:	73 2f                	jae    80105b50 <sys_sleep+0x90>
    if(myproc()->killed){
80105b21:	e8 ea dd ff ff       	call   80103910 <myproc>
80105b26:	8b 40 24             	mov    0x24(%eax),%eax
80105b29:	85 c0                	test   %eax,%eax
80105b2b:	74 d3                	je     80105b00 <sys_sleep+0x40>
      release(&tickslock);
80105b2d:	83 ec 0c             	sub    $0xc,%esp
80105b30:	68 60 92 11 80       	push   $0x80119260
80105b35:	e8 26 ee ff ff       	call   80104960 <release>
      return -1;
80105b3a:	83 c4 10             	add    $0x10,%esp
80105b3d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  release(&tickslock);
  return 0;
}
80105b42:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105b45:	c9                   	leave  
80105b46:	c3                   	ret    
80105b47:	89 f6                	mov    %esi,%esi
80105b49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  release(&tickslock);
80105b50:	83 ec 0c             	sub    $0xc,%esp
80105b53:	68 60 92 11 80       	push   $0x80119260
80105b58:	e8 03 ee ff ff       	call   80104960 <release>
  return 0;
80105b5d:	83 c4 10             	add    $0x10,%esp
80105b60:	31 c0                	xor    %eax,%eax
}
80105b62:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105b65:	c9                   	leave  
80105b66:	c3                   	ret    
    return -1;
80105b67:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105b6c:	eb f4                	jmp    80105b62 <sys_sleep+0xa2>
80105b6e:	66 90                	xchg   %ax,%ax

80105b70 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80105b70:	55                   	push   %ebp
80105b71:	89 e5                	mov    %esp,%ebp
80105b73:	53                   	push   %ebx
80105b74:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
80105b77:	68 60 92 11 80       	push   $0x80119260
80105b7c:	e8 1f ed ff ff       	call   801048a0 <acquire>
  xticks = ticks;
80105b81:	8b 1d a0 9a 11 80    	mov    0x80119aa0,%ebx
  release(&tickslock);
80105b87:	c7 04 24 60 92 11 80 	movl   $0x80119260,(%esp)
80105b8e:	e8 cd ed ff ff       	call   80104960 <release>
  return xticks;
}
80105b93:	89 d8                	mov    %ebx,%eax
80105b95:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105b98:	c9                   	leave  
80105b99:	c3                   	ret    
80105b9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105ba0 <sys_sigprocmask>:

int 
 sys_sigprocmask(void){
80105ba0:	55                   	push   %ebp
80105ba1:	89 e5                	mov    %esp,%ebp
80105ba3:	83 ec 20             	sub    $0x20,%esp
  uint mask;

  if(argint(0, (int *)&mask) < 0)
80105ba6:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105ba9:	50                   	push   %eax
80105baa:	6a 00                	push   $0x0
80105bac:	e8 ff f0 ff ff       	call   80104cb0 <argint>
80105bb1:	83 c4 10             	add    $0x10,%esp
80105bb4:	85 c0                	test   %eax,%eax
80105bb6:	78 18                	js     80105bd0 <sys_sigprocmask+0x30>
    return -1;
  
  return sigprocmask(mask);
80105bb8:	83 ec 0c             	sub    $0xc,%esp
80105bbb:	ff 75 f4             	pushl  -0xc(%ebp)
80105bbe:	e8 ed e6 ff ff       	call   801042b0 <sigprocmask>
80105bc3:	83 c4 10             	add    $0x10,%esp
 }
80105bc6:	c9                   	leave  
80105bc7:	c3                   	ret    
80105bc8:	90                   	nop
80105bc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105bd0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 }
80105bd5:	c9                   	leave  
80105bd6:	c3                   	ret    
80105bd7:	89 f6                	mov    %esi,%esi
80105bd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105be0 <sys_sigaction>:

 int
 sys_sigaction(void){
80105be0:	55                   	push   %ebp
80105be1:	89 e5                	mov    %esp,%ebp
80105be3:	83 ec 20             	sub    $0x20,%esp
   int signum;
   char *act;
   char *oldact;

  if(argint(0, &signum) < 0)
80105be6:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105be9:	50                   	push   %eax
80105bea:	6a 00                	push   $0x0
80105bec:	e8 bf f0 ff ff       	call   80104cb0 <argint>
80105bf1:	83 c4 10             	add    $0x10,%esp
80105bf4:	85 c0                	test   %eax,%eax
80105bf6:	78 48                	js     80105c40 <sys_sigaction+0x60>
    return -1;
  if(argptr(1, &act, sizeof(struct sigaction)) < 0)
80105bf8:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105bfb:	83 ec 04             	sub    $0x4,%esp
80105bfe:	6a 08                	push   $0x8
80105c00:	50                   	push   %eax
80105c01:	6a 01                	push   $0x1
80105c03:	e8 f8 f0 ff ff       	call   80104d00 <argptr>
80105c08:	83 c4 10             	add    $0x10,%esp
80105c0b:	85 c0                	test   %eax,%eax
80105c0d:	78 31                	js     80105c40 <sys_sigaction+0x60>
    return -1;
  
  if(argptr(2, &oldact, sizeof(struct sigaction)) < 0)
80105c0f:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105c12:	83 ec 04             	sub    $0x4,%esp
80105c15:	6a 08                	push   $0x8
80105c17:	50                   	push   %eax
80105c18:	6a 02                	push   $0x2
80105c1a:	e8 e1 f0 ff ff       	call   80104d00 <argptr>
80105c1f:	83 c4 10             	add    $0x10,%esp
80105c22:	85 c0                	test   %eax,%eax
80105c24:	78 1a                	js     80105c40 <sys_sigaction+0x60>
    return -1;
  
  return sigaction(signum,(struct sigaction *)act, (struct sigaction *)oldact);
80105c26:	83 ec 04             	sub    $0x4,%esp
80105c29:	ff 75 f4             	pushl  -0xc(%ebp)
80105c2c:	ff 75 f0             	pushl  -0x10(%ebp)
80105c2f:	ff 75 ec             	pushl  -0x14(%ebp)
80105c32:	e8 b9 e6 ff ff       	call   801042f0 <sigaction>
80105c37:	83 c4 10             	add    $0x10,%esp
 }
80105c3a:	c9                   	leave  
80105c3b:	c3                   	ret    
80105c3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105c40:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 }
80105c45:	c9                   	leave  
80105c46:	c3                   	ret    
80105c47:	89 f6                	mov    %esi,%esi
80105c49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105c50 <sys_sigret>:

 int
 sys_sigret(void){
80105c50:	55                   	push   %ebp
80105c51:	89 e5                	mov    %esp,%ebp
80105c53:	83 ec 08             	sub    $0x8,%esp
   sigret();
80105c56:	e8 15 e7 ff ff       	call   80104370 <sigret>
   return 0;
 }
80105c5b:	31 c0                	xor    %eax,%eax
80105c5d:	c9                   	leave  
80105c5e:	c3                   	ret    

80105c5f <alltraps>:
80105c5f:	1e                   	push   %ds
80105c60:	06                   	push   %es
80105c61:	0f a0                	push   %fs
80105c63:	0f a8                	push   %gs
80105c65:	60                   	pusha  
80105c66:	66 b8 10 00          	mov    $0x10,%ax
80105c6a:	8e d8                	mov    %eax,%ds
80105c6c:	8e c0                	mov    %eax,%es
80105c6e:	54                   	push   %esp
80105c6f:	e8 dc 00 00 00       	call   80105d50 <trap>
80105c74:	83 c4 04             	add    $0x4,%esp

80105c77 <trapret>:
80105c77:	e8 84 e8 ff ff       	call   80104500 <check_for_signals>
80105c7c:	61                   	popa   
80105c7d:	0f a9                	pop    %gs
80105c7f:	0f a1                	pop    %fs
80105c81:	07                   	pop    %es
80105c82:	1f                   	pop    %ds
80105c83:	83 c4 08             	add    $0x8,%esp
80105c86:	cf                   	iret   

80105c87 <trapret_handler>:
80105c87:	58                   	pop    %eax
80105c88:	5c                   	pop    %esp
80105c89:	61                   	popa   
80105c8a:	0f a9                	pop    %gs
80105c8c:	0f a1                	pop    %fs
80105c8e:	07                   	pop    %es
80105c8f:	1f                   	pop    %ds
80105c90:	83 c4 08             	add    $0x8,%esp
80105c93:	cf                   	iret   
80105c94:	66 90                	xchg   %ax,%ax
80105c96:	66 90                	xchg   %ax,%ax
80105c98:	66 90                	xchg   %ax,%ax
80105c9a:	66 90                	xchg   %ax,%ax
80105c9c:	66 90                	xchg   %ax,%ax
80105c9e:	66 90                	xchg   %ax,%ax

80105ca0 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80105ca0:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
80105ca1:	31 c0                	xor    %eax,%eax
{
80105ca3:	89 e5                	mov    %esp,%ebp
80105ca5:	83 ec 08             	sub    $0x8,%esp
80105ca8:	90                   	nop
80105ca9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80105cb0:	8b 14 85 08 a0 10 80 	mov    -0x7fef5ff8(,%eax,4),%edx
80105cb7:	c7 04 c5 a2 92 11 80 	movl   $0x8e000008,-0x7fee6d5e(,%eax,8)
80105cbe:	08 00 00 8e 
80105cc2:	66 89 14 c5 a0 92 11 	mov    %dx,-0x7fee6d60(,%eax,8)
80105cc9:	80 
80105cca:	c1 ea 10             	shr    $0x10,%edx
80105ccd:	66 89 14 c5 a6 92 11 	mov    %dx,-0x7fee6d5a(,%eax,8)
80105cd4:	80 
  for(i = 0; i < 256; i++)
80105cd5:	83 c0 01             	add    $0x1,%eax
80105cd8:	3d 00 01 00 00       	cmp    $0x100,%eax
80105cdd:	75 d1                	jne    80105cb0 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105cdf:	a1 08 a1 10 80       	mov    0x8010a108,%eax

  initlock(&tickslock, "time");
80105ce4:	83 ec 08             	sub    $0x8,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105ce7:	c7 05 a2 94 11 80 08 	movl   $0xef000008,0x801194a2
80105cee:	00 00 ef 
  initlock(&tickslock, "time");
80105cf1:	68 e5 7c 10 80       	push   $0x80107ce5
80105cf6:	68 60 92 11 80       	push   $0x80119260
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105cfb:	66 a3 a0 94 11 80    	mov    %ax,0x801194a0
80105d01:	c1 e8 10             	shr    $0x10,%eax
80105d04:	66 a3 a6 94 11 80    	mov    %ax,0x801194a6
  initlock(&tickslock, "time");
80105d0a:	e8 51 ea ff ff       	call   80104760 <initlock>
}
80105d0f:	83 c4 10             	add    $0x10,%esp
80105d12:	c9                   	leave  
80105d13:	c3                   	ret    
80105d14:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105d1a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80105d20 <idtinit>:

void
idtinit(void)
{
80105d20:	55                   	push   %ebp
  pd[0] = size-1;
80105d21:	b8 ff 07 00 00       	mov    $0x7ff,%eax
80105d26:	89 e5                	mov    %esp,%ebp
80105d28:	83 ec 10             	sub    $0x10,%esp
80105d2b:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
80105d2f:	b8 a0 92 11 80       	mov    $0x801192a0,%eax
80105d34:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80105d38:	c1 e8 10             	shr    $0x10,%eax
80105d3b:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
80105d3f:	8d 45 fa             	lea    -0x6(%ebp),%eax
80105d42:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80105d45:	c9                   	leave  
80105d46:	c3                   	ret    
80105d47:	89 f6                	mov    %esi,%esi
80105d49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105d50 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80105d50:	55                   	push   %ebp
80105d51:	89 e5                	mov    %esp,%ebp
80105d53:	57                   	push   %edi
80105d54:	56                   	push   %esi
80105d55:	53                   	push   %ebx
80105d56:	83 ec 1c             	sub    $0x1c,%esp
80105d59:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(tf->trapno == T_SYSCALL){
80105d5c:	8b 43 30             	mov    0x30(%ebx),%eax
80105d5f:	83 f8 40             	cmp    $0x40,%eax
80105d62:	0f 84 f8 00 00 00    	je     80105e60 <trap+0x110>
    *tf = *(myproc()->tf); 
    //check_for_signals();
    return;
  }

  switch(tf->trapno){
80105d68:	83 e8 20             	sub    $0x20,%eax
80105d6b:	83 f8 1f             	cmp    $0x1f,%eax
80105d6e:	77 10                	ja     80105d80 <trap+0x30>
80105d70:	ff 24 85 8c 7d 10 80 	jmp    *-0x7fef8274(,%eax,4)
80105d77:	89 f6                	mov    %esi,%esi
80105d79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    lapiceoi();
    break;

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
80105d80:	e8 8b db ff ff       	call   80103910 <myproc>
80105d85:	85 c0                	test   %eax,%eax
80105d87:	8b 7b 38             	mov    0x38(%ebx),%edi
80105d8a:	0f 84 5c 02 00 00    	je     80105fec <trap+0x29c>
80105d90:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
80105d94:	0f 84 52 02 00 00    	je     80105fec <trap+0x29c>
  asm volatile("movl %%cr2,%0" : "=r" (val));
80105d9a:	0f 20 d1             	mov    %cr2,%ecx
80105d9d:	89 4d d8             	mov    %ecx,-0x28(%ebp)
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105da0:	e8 4b db ff ff       	call   801038f0 <cpuid>
80105da5:	89 45 dc             	mov    %eax,-0x24(%ebp)
80105da8:	8b 43 34             	mov    0x34(%ebx),%eax
80105dab:	8b 73 30             	mov    0x30(%ebx),%esi
80105dae:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80105db1:	e8 5a db ff ff       	call   80103910 <myproc>
80105db6:	89 45 e0             	mov    %eax,-0x20(%ebp)
80105db9:	e8 52 db ff ff       	call   80103910 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105dbe:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80105dc1:	8b 55 dc             	mov    -0x24(%ebp),%edx
80105dc4:	51                   	push   %ecx
80105dc5:	57                   	push   %edi
80105dc6:	52                   	push   %edx
            myproc()->pid, myproc()->name, tf->trapno,
80105dc7:	8b 55 e0             	mov    -0x20(%ebp),%edx
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105dca:	ff 75 e4             	pushl  -0x1c(%ebp)
80105dcd:	56                   	push   %esi
            myproc()->pid, myproc()->name, tf->trapno,
80105dce:	83 c2 6c             	add    $0x6c,%edx
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105dd1:	52                   	push   %edx
80105dd2:	ff 70 10             	pushl  0x10(%eax)
80105dd5:	68 48 7d 10 80       	push   $0x80107d48
80105dda:	e8 81 a8 ff ff       	call   80100660 <cprintf>
            tf->err, cpuid(), tf->eip, rcr2());
    myproc()->killed = 1;
80105ddf:	83 c4 20             	add    $0x20,%esp
80105de2:	e8 29 db ff ff       	call   80103910 <myproc>
80105de7:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105dee:	e8 1d db ff ff       	call   80103910 <myproc>
80105df3:	85 c0                	test   %eax,%eax
80105df5:	74 1d                	je     80105e14 <trap+0xc4>
80105df7:	e8 14 db ff ff       	call   80103910 <myproc>
80105dfc:	8b 50 24             	mov    0x24(%eax),%edx
80105dff:	85 d2                	test   %edx,%edx
80105e01:	74 11                	je     80105e14 <trap+0xc4>
80105e03:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80105e07:	83 e0 03             	and    $0x3,%eax
80105e0a:	66 83 f8 03          	cmp    $0x3,%ax
80105e0e:	0f 84 94 01 00 00    	je     80105fa8 <trap+0x258>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80105e14:	e8 f7 da ff ff       	call   80103910 <myproc>
80105e19:	85 c0                	test   %eax,%eax
80105e1b:	74 0f                	je     80105e2c <trap+0xdc>
80105e1d:	e8 ee da ff ff       	call   80103910 <myproc>
80105e22:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80105e26:	0f 84 84 00 00 00    	je     80105eb0 <trap+0x160>
    yield();
    //check_for_signals();
   }

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105e2c:	e8 df da ff ff       	call   80103910 <myproc>
80105e31:	85 c0                	test   %eax,%eax
80105e33:	74 1d                	je     80105e52 <trap+0x102>
80105e35:	e8 d6 da ff ff       	call   80103910 <myproc>
80105e3a:	8b 40 24             	mov    0x24(%eax),%eax
80105e3d:	85 c0                	test   %eax,%eax
80105e3f:	74 11                	je     80105e52 <trap+0x102>
80105e41:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80105e45:	83 e0 03             	and    $0x3,%eax
80105e48:	66 83 f8 03          	cmp    $0x3,%ax
80105e4c:	0f 84 46 01 00 00    	je     80105f98 <trap+0x248>
    exit();
}
80105e52:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105e55:	5b                   	pop    %ebx
80105e56:	5e                   	pop    %esi
80105e57:	5f                   	pop    %edi
80105e58:	5d                   	pop    %ebp
80105e59:	c3                   	ret    
80105e5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(myproc()->killed)
80105e60:	e8 ab da ff ff       	call   80103910 <myproc>
80105e65:	8b 70 24             	mov    0x24(%eax),%esi
80105e68:	85 f6                	test   %esi,%esi
80105e6a:	0f 85 18 01 00 00    	jne    80105f88 <trap+0x238>
    myproc()->tf = tf;
80105e70:	e8 9b da ff ff       	call   80103910 <myproc>
80105e75:	89 58 18             	mov    %ebx,0x18(%eax)
    syscall();
80105e78:	e8 23 ef ff ff       	call   80104da0 <syscall>
    if(myproc()->killed)
80105e7d:	e8 8e da ff ff       	call   80103910 <myproc>
80105e82:	8b 48 24             	mov    0x24(%eax),%ecx
80105e85:	85 c9                	test   %ecx,%ecx
80105e87:	0f 85 eb 00 00 00    	jne    80105f78 <trap+0x228>
    *tf = *(myproc()->tf); 
80105e8d:	e8 7e da ff ff       	call   80103910 <myproc>
80105e92:	89 df                	mov    %ebx,%edi
80105e94:	8b 70 18             	mov    0x18(%eax),%esi
80105e97:	b9 13 00 00 00       	mov    $0x13,%ecx
80105e9c:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
}
80105e9e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105ea1:	5b                   	pop    %ebx
80105ea2:	5e                   	pop    %esi
80105ea3:	5f                   	pop    %edi
80105ea4:	5d                   	pop    %ebp
80105ea5:	c3                   	ret    
80105ea6:	8d 76 00             	lea    0x0(%esi),%esi
80105ea9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  if(myproc() && myproc()->state == RUNNING &&
80105eb0:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
80105eb4:	0f 85 72 ff ff ff    	jne    80105e2c <trap+0xdc>
    yield();
80105eba:	e8 21 e0 ff ff       	call   80103ee0 <yield>
80105ebf:	e9 68 ff ff ff       	jmp    80105e2c <trap+0xdc>
80105ec4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(cpuid() == 0){
80105ec8:	e8 23 da ff ff       	call   801038f0 <cpuid>
80105ecd:	85 c0                	test   %eax,%eax
80105ecf:	0f 84 e3 00 00 00    	je     80105fb8 <trap+0x268>
    lapiceoi();
80105ed5:	e8 a6 c8 ff ff       	call   80102780 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105eda:	e8 31 da ff ff       	call   80103910 <myproc>
80105edf:	85 c0                	test   %eax,%eax
80105ee1:	0f 85 10 ff ff ff    	jne    80105df7 <trap+0xa7>
80105ee7:	e9 28 ff ff ff       	jmp    80105e14 <trap+0xc4>
80105eec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    kbdintr();
80105ef0:	e8 4b c7 ff ff       	call   80102640 <kbdintr>
    lapiceoi();
80105ef5:	e8 86 c8 ff ff       	call   80102780 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105efa:	e8 11 da ff ff       	call   80103910 <myproc>
80105eff:	85 c0                	test   %eax,%eax
80105f01:	0f 85 f0 fe ff ff    	jne    80105df7 <trap+0xa7>
80105f07:	e9 08 ff ff ff       	jmp    80105e14 <trap+0xc4>
80105f0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    uartintr();
80105f10:	e8 7b 02 00 00       	call   80106190 <uartintr>
    lapiceoi();
80105f15:	e8 66 c8 ff ff       	call   80102780 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105f1a:	e8 f1 d9 ff ff       	call   80103910 <myproc>
80105f1f:	85 c0                	test   %eax,%eax
80105f21:	0f 85 d0 fe ff ff    	jne    80105df7 <trap+0xa7>
80105f27:	e9 e8 fe ff ff       	jmp    80105e14 <trap+0xc4>
80105f2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80105f30:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
80105f34:	8b 7b 38             	mov    0x38(%ebx),%edi
80105f37:	e8 b4 d9 ff ff       	call   801038f0 <cpuid>
80105f3c:	57                   	push   %edi
80105f3d:	56                   	push   %esi
80105f3e:	50                   	push   %eax
80105f3f:	68 f0 7c 10 80       	push   $0x80107cf0
80105f44:	e8 17 a7 ff ff       	call   80100660 <cprintf>
    lapiceoi();
80105f49:	e8 32 c8 ff ff       	call   80102780 <lapiceoi>
    break;
80105f4e:	83 c4 10             	add    $0x10,%esp
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105f51:	e8 ba d9 ff ff       	call   80103910 <myproc>
80105f56:	85 c0                	test   %eax,%eax
80105f58:	0f 85 99 fe ff ff    	jne    80105df7 <trap+0xa7>
80105f5e:	e9 b1 fe ff ff       	jmp    80105e14 <trap+0xc4>
80105f63:	90                   	nop
80105f64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ideintr();
80105f68:	e8 43 c1 ff ff       	call   801020b0 <ideintr>
80105f6d:	e9 63 ff ff ff       	jmp    80105ed5 <trap+0x185>
80105f72:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit();
80105f78:	e8 63 de ff ff       	call   80103de0 <exit>
80105f7d:	e9 0b ff ff ff       	jmp    80105e8d <trap+0x13d>
80105f82:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit();
80105f88:	e8 53 de ff ff       	call   80103de0 <exit>
80105f8d:	e9 de fe ff ff       	jmp    80105e70 <trap+0x120>
80105f92:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
}
80105f98:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105f9b:	5b                   	pop    %ebx
80105f9c:	5e                   	pop    %esi
80105f9d:	5f                   	pop    %edi
80105f9e:	5d                   	pop    %ebp
    exit();
80105f9f:	e9 3c de ff ff       	jmp    80103de0 <exit>
80105fa4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    exit();
80105fa8:	e8 33 de ff ff       	call   80103de0 <exit>
80105fad:	e9 62 fe ff ff       	jmp    80105e14 <trap+0xc4>
80105fb2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      acquire(&tickslock);
80105fb8:	83 ec 0c             	sub    $0xc,%esp
80105fbb:	68 60 92 11 80       	push   $0x80119260
80105fc0:	e8 db e8 ff ff       	call   801048a0 <acquire>
      wakeup(&ticks);
80105fc5:	c7 04 24 a0 9a 11 80 	movl   $0x80119aa0,(%esp)
      ticks++;
80105fcc:	83 05 a0 9a 11 80 01 	addl   $0x1,0x80119aa0
      wakeup(&ticks);
80105fd3:	e8 f8 e0 ff ff       	call   801040d0 <wakeup>
      release(&tickslock);
80105fd8:	c7 04 24 60 92 11 80 	movl   $0x80119260,(%esp)
80105fdf:	e8 7c e9 ff ff       	call   80104960 <release>
80105fe4:	83 c4 10             	add    $0x10,%esp
80105fe7:	e9 e9 fe ff ff       	jmp    80105ed5 <trap+0x185>
80105fec:	0f 20 d6             	mov    %cr2,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80105fef:	e8 fc d8 ff ff       	call   801038f0 <cpuid>
80105ff4:	83 ec 0c             	sub    $0xc,%esp
80105ff7:	56                   	push   %esi
80105ff8:	57                   	push   %edi
80105ff9:	50                   	push   %eax
80105ffa:	ff 73 30             	pushl  0x30(%ebx)
80105ffd:	68 14 7d 10 80       	push   $0x80107d14
80106002:	e8 59 a6 ff ff       	call   80100660 <cprintf>
      panic("trap");
80106007:	83 c4 14             	add    $0x14,%esp
8010600a:	68 ea 7c 10 80       	push   $0x80107cea
8010600f:	e8 7c a3 ff ff       	call   80100390 <panic>
80106014:	66 90                	xchg   %ax,%ax
80106016:	66 90                	xchg   %ax,%ax
80106018:	66 90                	xchg   %ax,%ax
8010601a:	66 90                	xchg   %ax,%ax
8010601c:	66 90                	xchg   %ax,%ax
8010601e:	66 90                	xchg   %ax,%ax

80106020 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80106020:	a1 bc a5 10 80       	mov    0x8010a5bc,%eax
{
80106025:	55                   	push   %ebp
80106026:	89 e5                	mov    %esp,%ebp
  if(!uart)
80106028:	85 c0                	test   %eax,%eax
8010602a:	74 1c                	je     80106048 <uartgetc+0x28>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010602c:	ba fd 03 00 00       	mov    $0x3fd,%edx
80106031:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
80106032:	a8 01                	test   $0x1,%al
80106034:	74 12                	je     80106048 <uartgetc+0x28>
80106036:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010603b:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
8010603c:	0f b6 c0             	movzbl %al,%eax
}
8010603f:	5d                   	pop    %ebp
80106040:	c3                   	ret    
80106041:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80106048:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010604d:	5d                   	pop    %ebp
8010604e:	c3                   	ret    
8010604f:	90                   	nop

80106050 <uartputc.part.0>:
uartputc(int c)
80106050:	55                   	push   %ebp
80106051:	89 e5                	mov    %esp,%ebp
80106053:	57                   	push   %edi
80106054:	56                   	push   %esi
80106055:	53                   	push   %ebx
80106056:	89 c7                	mov    %eax,%edi
80106058:	bb 80 00 00 00       	mov    $0x80,%ebx
8010605d:	be fd 03 00 00       	mov    $0x3fd,%esi
80106062:	83 ec 0c             	sub    $0xc,%esp
80106065:	eb 1b                	jmp    80106082 <uartputc.part.0+0x32>
80106067:	89 f6                	mov    %esi,%esi
80106069:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    microdelay(10);
80106070:	83 ec 0c             	sub    $0xc,%esp
80106073:	6a 0a                	push   $0xa
80106075:	e8 26 c7 ff ff       	call   801027a0 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
8010607a:	83 c4 10             	add    $0x10,%esp
8010607d:	83 eb 01             	sub    $0x1,%ebx
80106080:	74 07                	je     80106089 <uartputc.part.0+0x39>
80106082:	89 f2                	mov    %esi,%edx
80106084:	ec                   	in     (%dx),%al
80106085:	a8 20                	test   $0x20,%al
80106087:	74 e7                	je     80106070 <uartputc.part.0+0x20>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106089:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010608e:	89 f8                	mov    %edi,%eax
80106090:	ee                   	out    %al,(%dx)
}
80106091:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106094:	5b                   	pop    %ebx
80106095:	5e                   	pop    %esi
80106096:	5f                   	pop    %edi
80106097:	5d                   	pop    %ebp
80106098:	c3                   	ret    
80106099:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801060a0 <uartinit>:
{
801060a0:	55                   	push   %ebp
801060a1:	31 c9                	xor    %ecx,%ecx
801060a3:	89 c8                	mov    %ecx,%eax
801060a5:	89 e5                	mov    %esp,%ebp
801060a7:	57                   	push   %edi
801060a8:	56                   	push   %esi
801060a9:	53                   	push   %ebx
801060aa:	bb fa 03 00 00       	mov    $0x3fa,%ebx
801060af:	89 da                	mov    %ebx,%edx
801060b1:	83 ec 0c             	sub    $0xc,%esp
801060b4:	ee                   	out    %al,(%dx)
801060b5:	bf fb 03 00 00       	mov    $0x3fb,%edi
801060ba:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
801060bf:	89 fa                	mov    %edi,%edx
801060c1:	ee                   	out    %al,(%dx)
801060c2:	b8 0c 00 00 00       	mov    $0xc,%eax
801060c7:	ba f8 03 00 00       	mov    $0x3f8,%edx
801060cc:	ee                   	out    %al,(%dx)
801060cd:	be f9 03 00 00       	mov    $0x3f9,%esi
801060d2:	89 c8                	mov    %ecx,%eax
801060d4:	89 f2                	mov    %esi,%edx
801060d6:	ee                   	out    %al,(%dx)
801060d7:	b8 03 00 00 00       	mov    $0x3,%eax
801060dc:	89 fa                	mov    %edi,%edx
801060de:	ee                   	out    %al,(%dx)
801060df:	ba fc 03 00 00       	mov    $0x3fc,%edx
801060e4:	89 c8                	mov    %ecx,%eax
801060e6:	ee                   	out    %al,(%dx)
801060e7:	b8 01 00 00 00       	mov    $0x1,%eax
801060ec:	89 f2                	mov    %esi,%edx
801060ee:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801060ef:	ba fd 03 00 00       	mov    $0x3fd,%edx
801060f4:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
801060f5:	3c ff                	cmp    $0xff,%al
801060f7:	74 5a                	je     80106153 <uartinit+0xb3>
  uart = 1;
801060f9:	c7 05 bc a5 10 80 01 	movl   $0x1,0x8010a5bc
80106100:	00 00 00 
80106103:	89 da                	mov    %ebx,%edx
80106105:	ec                   	in     (%dx),%al
80106106:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010610b:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
8010610c:	83 ec 08             	sub    $0x8,%esp
  for(p="xv6...\n"; *p; p++)
8010610f:	bb 0c 7e 10 80       	mov    $0x80107e0c,%ebx
  ioapicenable(IRQ_COM1, 0);
80106114:	6a 00                	push   $0x0
80106116:	6a 04                	push   $0x4
80106118:	e8 e3 c1 ff ff       	call   80102300 <ioapicenable>
8010611d:	83 c4 10             	add    $0x10,%esp
  for(p="xv6...\n"; *p; p++)
80106120:	b8 78 00 00 00       	mov    $0x78,%eax
80106125:	eb 13                	jmp    8010613a <uartinit+0x9a>
80106127:	89 f6                	mov    %esi,%esi
80106129:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80106130:	83 c3 01             	add    $0x1,%ebx
80106133:	0f be 03             	movsbl (%ebx),%eax
80106136:	84 c0                	test   %al,%al
80106138:	74 19                	je     80106153 <uartinit+0xb3>
  if(!uart)
8010613a:	8b 15 bc a5 10 80    	mov    0x8010a5bc,%edx
80106140:	85 d2                	test   %edx,%edx
80106142:	74 ec                	je     80106130 <uartinit+0x90>
  for(p="xv6...\n"; *p; p++)
80106144:	83 c3 01             	add    $0x1,%ebx
80106147:	e8 04 ff ff ff       	call   80106050 <uartputc.part.0>
8010614c:	0f be 03             	movsbl (%ebx),%eax
8010614f:	84 c0                	test   %al,%al
80106151:	75 e7                	jne    8010613a <uartinit+0x9a>
}
80106153:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106156:	5b                   	pop    %ebx
80106157:	5e                   	pop    %esi
80106158:	5f                   	pop    %edi
80106159:	5d                   	pop    %ebp
8010615a:	c3                   	ret    
8010615b:	90                   	nop
8010615c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106160 <uartputc>:
  if(!uart)
80106160:	8b 15 bc a5 10 80    	mov    0x8010a5bc,%edx
{
80106166:	55                   	push   %ebp
80106167:	89 e5                	mov    %esp,%ebp
  if(!uart)
80106169:	85 d2                	test   %edx,%edx
{
8010616b:	8b 45 08             	mov    0x8(%ebp),%eax
  if(!uart)
8010616e:	74 10                	je     80106180 <uartputc+0x20>
}
80106170:	5d                   	pop    %ebp
80106171:	e9 da fe ff ff       	jmp    80106050 <uartputc.part.0>
80106176:	8d 76 00             	lea    0x0(%esi),%esi
80106179:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80106180:	5d                   	pop    %ebp
80106181:	c3                   	ret    
80106182:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106189:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106190 <uartintr>:

void
uartintr(void)
{
80106190:	55                   	push   %ebp
80106191:	89 e5                	mov    %esp,%ebp
80106193:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
80106196:	68 20 60 10 80       	push   $0x80106020
8010619b:	e8 70 a6 ff ff       	call   80100810 <consoleintr>
}
801061a0:	83 c4 10             	add    $0x10,%esp
801061a3:	c9                   	leave  
801061a4:	c3                   	ret    

801061a5 <vector0>:
801061a5:	6a 00                	push   $0x0
801061a7:	6a 00                	push   $0x0
801061a9:	e9 b1 fa ff ff       	jmp    80105c5f <alltraps>

801061ae <vector1>:
801061ae:	6a 00                	push   $0x0
801061b0:	6a 01                	push   $0x1
801061b2:	e9 a8 fa ff ff       	jmp    80105c5f <alltraps>

801061b7 <vector2>:
801061b7:	6a 00                	push   $0x0
801061b9:	6a 02                	push   $0x2
801061bb:	e9 9f fa ff ff       	jmp    80105c5f <alltraps>

801061c0 <vector3>:
801061c0:	6a 00                	push   $0x0
801061c2:	6a 03                	push   $0x3
801061c4:	e9 96 fa ff ff       	jmp    80105c5f <alltraps>

801061c9 <vector4>:
801061c9:	6a 00                	push   $0x0
801061cb:	6a 04                	push   $0x4
801061cd:	e9 8d fa ff ff       	jmp    80105c5f <alltraps>

801061d2 <vector5>:
801061d2:	6a 00                	push   $0x0
801061d4:	6a 05                	push   $0x5
801061d6:	e9 84 fa ff ff       	jmp    80105c5f <alltraps>

801061db <vector6>:
801061db:	6a 00                	push   $0x0
801061dd:	6a 06                	push   $0x6
801061df:	e9 7b fa ff ff       	jmp    80105c5f <alltraps>

801061e4 <vector7>:
801061e4:	6a 00                	push   $0x0
801061e6:	6a 07                	push   $0x7
801061e8:	e9 72 fa ff ff       	jmp    80105c5f <alltraps>

801061ed <vector8>:
801061ed:	6a 08                	push   $0x8
801061ef:	e9 6b fa ff ff       	jmp    80105c5f <alltraps>

801061f4 <vector9>:
801061f4:	6a 00                	push   $0x0
801061f6:	6a 09                	push   $0x9
801061f8:	e9 62 fa ff ff       	jmp    80105c5f <alltraps>

801061fd <vector10>:
801061fd:	6a 0a                	push   $0xa
801061ff:	e9 5b fa ff ff       	jmp    80105c5f <alltraps>

80106204 <vector11>:
80106204:	6a 0b                	push   $0xb
80106206:	e9 54 fa ff ff       	jmp    80105c5f <alltraps>

8010620b <vector12>:
8010620b:	6a 0c                	push   $0xc
8010620d:	e9 4d fa ff ff       	jmp    80105c5f <alltraps>

80106212 <vector13>:
80106212:	6a 0d                	push   $0xd
80106214:	e9 46 fa ff ff       	jmp    80105c5f <alltraps>

80106219 <vector14>:
80106219:	6a 0e                	push   $0xe
8010621b:	e9 3f fa ff ff       	jmp    80105c5f <alltraps>

80106220 <vector15>:
80106220:	6a 00                	push   $0x0
80106222:	6a 0f                	push   $0xf
80106224:	e9 36 fa ff ff       	jmp    80105c5f <alltraps>

80106229 <vector16>:
80106229:	6a 00                	push   $0x0
8010622b:	6a 10                	push   $0x10
8010622d:	e9 2d fa ff ff       	jmp    80105c5f <alltraps>

80106232 <vector17>:
80106232:	6a 11                	push   $0x11
80106234:	e9 26 fa ff ff       	jmp    80105c5f <alltraps>

80106239 <vector18>:
80106239:	6a 00                	push   $0x0
8010623b:	6a 12                	push   $0x12
8010623d:	e9 1d fa ff ff       	jmp    80105c5f <alltraps>

80106242 <vector19>:
80106242:	6a 00                	push   $0x0
80106244:	6a 13                	push   $0x13
80106246:	e9 14 fa ff ff       	jmp    80105c5f <alltraps>

8010624b <vector20>:
8010624b:	6a 00                	push   $0x0
8010624d:	6a 14                	push   $0x14
8010624f:	e9 0b fa ff ff       	jmp    80105c5f <alltraps>

80106254 <vector21>:
80106254:	6a 00                	push   $0x0
80106256:	6a 15                	push   $0x15
80106258:	e9 02 fa ff ff       	jmp    80105c5f <alltraps>

8010625d <vector22>:
8010625d:	6a 00                	push   $0x0
8010625f:	6a 16                	push   $0x16
80106261:	e9 f9 f9 ff ff       	jmp    80105c5f <alltraps>

80106266 <vector23>:
80106266:	6a 00                	push   $0x0
80106268:	6a 17                	push   $0x17
8010626a:	e9 f0 f9 ff ff       	jmp    80105c5f <alltraps>

8010626f <vector24>:
8010626f:	6a 00                	push   $0x0
80106271:	6a 18                	push   $0x18
80106273:	e9 e7 f9 ff ff       	jmp    80105c5f <alltraps>

80106278 <vector25>:
80106278:	6a 00                	push   $0x0
8010627a:	6a 19                	push   $0x19
8010627c:	e9 de f9 ff ff       	jmp    80105c5f <alltraps>

80106281 <vector26>:
80106281:	6a 00                	push   $0x0
80106283:	6a 1a                	push   $0x1a
80106285:	e9 d5 f9 ff ff       	jmp    80105c5f <alltraps>

8010628a <vector27>:
8010628a:	6a 00                	push   $0x0
8010628c:	6a 1b                	push   $0x1b
8010628e:	e9 cc f9 ff ff       	jmp    80105c5f <alltraps>

80106293 <vector28>:
80106293:	6a 00                	push   $0x0
80106295:	6a 1c                	push   $0x1c
80106297:	e9 c3 f9 ff ff       	jmp    80105c5f <alltraps>

8010629c <vector29>:
8010629c:	6a 00                	push   $0x0
8010629e:	6a 1d                	push   $0x1d
801062a0:	e9 ba f9 ff ff       	jmp    80105c5f <alltraps>

801062a5 <vector30>:
801062a5:	6a 00                	push   $0x0
801062a7:	6a 1e                	push   $0x1e
801062a9:	e9 b1 f9 ff ff       	jmp    80105c5f <alltraps>

801062ae <vector31>:
801062ae:	6a 00                	push   $0x0
801062b0:	6a 1f                	push   $0x1f
801062b2:	e9 a8 f9 ff ff       	jmp    80105c5f <alltraps>

801062b7 <vector32>:
801062b7:	6a 00                	push   $0x0
801062b9:	6a 20                	push   $0x20
801062bb:	e9 9f f9 ff ff       	jmp    80105c5f <alltraps>

801062c0 <vector33>:
801062c0:	6a 00                	push   $0x0
801062c2:	6a 21                	push   $0x21
801062c4:	e9 96 f9 ff ff       	jmp    80105c5f <alltraps>

801062c9 <vector34>:
801062c9:	6a 00                	push   $0x0
801062cb:	6a 22                	push   $0x22
801062cd:	e9 8d f9 ff ff       	jmp    80105c5f <alltraps>

801062d2 <vector35>:
801062d2:	6a 00                	push   $0x0
801062d4:	6a 23                	push   $0x23
801062d6:	e9 84 f9 ff ff       	jmp    80105c5f <alltraps>

801062db <vector36>:
801062db:	6a 00                	push   $0x0
801062dd:	6a 24                	push   $0x24
801062df:	e9 7b f9 ff ff       	jmp    80105c5f <alltraps>

801062e4 <vector37>:
801062e4:	6a 00                	push   $0x0
801062e6:	6a 25                	push   $0x25
801062e8:	e9 72 f9 ff ff       	jmp    80105c5f <alltraps>

801062ed <vector38>:
801062ed:	6a 00                	push   $0x0
801062ef:	6a 26                	push   $0x26
801062f1:	e9 69 f9 ff ff       	jmp    80105c5f <alltraps>

801062f6 <vector39>:
801062f6:	6a 00                	push   $0x0
801062f8:	6a 27                	push   $0x27
801062fa:	e9 60 f9 ff ff       	jmp    80105c5f <alltraps>

801062ff <vector40>:
801062ff:	6a 00                	push   $0x0
80106301:	6a 28                	push   $0x28
80106303:	e9 57 f9 ff ff       	jmp    80105c5f <alltraps>

80106308 <vector41>:
80106308:	6a 00                	push   $0x0
8010630a:	6a 29                	push   $0x29
8010630c:	e9 4e f9 ff ff       	jmp    80105c5f <alltraps>

80106311 <vector42>:
80106311:	6a 00                	push   $0x0
80106313:	6a 2a                	push   $0x2a
80106315:	e9 45 f9 ff ff       	jmp    80105c5f <alltraps>

8010631a <vector43>:
8010631a:	6a 00                	push   $0x0
8010631c:	6a 2b                	push   $0x2b
8010631e:	e9 3c f9 ff ff       	jmp    80105c5f <alltraps>

80106323 <vector44>:
80106323:	6a 00                	push   $0x0
80106325:	6a 2c                	push   $0x2c
80106327:	e9 33 f9 ff ff       	jmp    80105c5f <alltraps>

8010632c <vector45>:
8010632c:	6a 00                	push   $0x0
8010632e:	6a 2d                	push   $0x2d
80106330:	e9 2a f9 ff ff       	jmp    80105c5f <alltraps>

80106335 <vector46>:
80106335:	6a 00                	push   $0x0
80106337:	6a 2e                	push   $0x2e
80106339:	e9 21 f9 ff ff       	jmp    80105c5f <alltraps>

8010633e <vector47>:
8010633e:	6a 00                	push   $0x0
80106340:	6a 2f                	push   $0x2f
80106342:	e9 18 f9 ff ff       	jmp    80105c5f <alltraps>

80106347 <vector48>:
80106347:	6a 00                	push   $0x0
80106349:	6a 30                	push   $0x30
8010634b:	e9 0f f9 ff ff       	jmp    80105c5f <alltraps>

80106350 <vector49>:
80106350:	6a 00                	push   $0x0
80106352:	6a 31                	push   $0x31
80106354:	e9 06 f9 ff ff       	jmp    80105c5f <alltraps>

80106359 <vector50>:
80106359:	6a 00                	push   $0x0
8010635b:	6a 32                	push   $0x32
8010635d:	e9 fd f8 ff ff       	jmp    80105c5f <alltraps>

80106362 <vector51>:
80106362:	6a 00                	push   $0x0
80106364:	6a 33                	push   $0x33
80106366:	e9 f4 f8 ff ff       	jmp    80105c5f <alltraps>

8010636b <vector52>:
8010636b:	6a 00                	push   $0x0
8010636d:	6a 34                	push   $0x34
8010636f:	e9 eb f8 ff ff       	jmp    80105c5f <alltraps>

80106374 <vector53>:
80106374:	6a 00                	push   $0x0
80106376:	6a 35                	push   $0x35
80106378:	e9 e2 f8 ff ff       	jmp    80105c5f <alltraps>

8010637d <vector54>:
8010637d:	6a 00                	push   $0x0
8010637f:	6a 36                	push   $0x36
80106381:	e9 d9 f8 ff ff       	jmp    80105c5f <alltraps>

80106386 <vector55>:
80106386:	6a 00                	push   $0x0
80106388:	6a 37                	push   $0x37
8010638a:	e9 d0 f8 ff ff       	jmp    80105c5f <alltraps>

8010638f <vector56>:
8010638f:	6a 00                	push   $0x0
80106391:	6a 38                	push   $0x38
80106393:	e9 c7 f8 ff ff       	jmp    80105c5f <alltraps>

80106398 <vector57>:
80106398:	6a 00                	push   $0x0
8010639a:	6a 39                	push   $0x39
8010639c:	e9 be f8 ff ff       	jmp    80105c5f <alltraps>

801063a1 <vector58>:
801063a1:	6a 00                	push   $0x0
801063a3:	6a 3a                	push   $0x3a
801063a5:	e9 b5 f8 ff ff       	jmp    80105c5f <alltraps>

801063aa <vector59>:
801063aa:	6a 00                	push   $0x0
801063ac:	6a 3b                	push   $0x3b
801063ae:	e9 ac f8 ff ff       	jmp    80105c5f <alltraps>

801063b3 <vector60>:
801063b3:	6a 00                	push   $0x0
801063b5:	6a 3c                	push   $0x3c
801063b7:	e9 a3 f8 ff ff       	jmp    80105c5f <alltraps>

801063bc <vector61>:
801063bc:	6a 00                	push   $0x0
801063be:	6a 3d                	push   $0x3d
801063c0:	e9 9a f8 ff ff       	jmp    80105c5f <alltraps>

801063c5 <vector62>:
801063c5:	6a 00                	push   $0x0
801063c7:	6a 3e                	push   $0x3e
801063c9:	e9 91 f8 ff ff       	jmp    80105c5f <alltraps>

801063ce <vector63>:
801063ce:	6a 00                	push   $0x0
801063d0:	6a 3f                	push   $0x3f
801063d2:	e9 88 f8 ff ff       	jmp    80105c5f <alltraps>

801063d7 <vector64>:
801063d7:	6a 00                	push   $0x0
801063d9:	6a 40                	push   $0x40
801063db:	e9 7f f8 ff ff       	jmp    80105c5f <alltraps>

801063e0 <vector65>:
801063e0:	6a 00                	push   $0x0
801063e2:	6a 41                	push   $0x41
801063e4:	e9 76 f8 ff ff       	jmp    80105c5f <alltraps>

801063e9 <vector66>:
801063e9:	6a 00                	push   $0x0
801063eb:	6a 42                	push   $0x42
801063ed:	e9 6d f8 ff ff       	jmp    80105c5f <alltraps>

801063f2 <vector67>:
801063f2:	6a 00                	push   $0x0
801063f4:	6a 43                	push   $0x43
801063f6:	e9 64 f8 ff ff       	jmp    80105c5f <alltraps>

801063fb <vector68>:
801063fb:	6a 00                	push   $0x0
801063fd:	6a 44                	push   $0x44
801063ff:	e9 5b f8 ff ff       	jmp    80105c5f <alltraps>

80106404 <vector69>:
80106404:	6a 00                	push   $0x0
80106406:	6a 45                	push   $0x45
80106408:	e9 52 f8 ff ff       	jmp    80105c5f <alltraps>

8010640d <vector70>:
8010640d:	6a 00                	push   $0x0
8010640f:	6a 46                	push   $0x46
80106411:	e9 49 f8 ff ff       	jmp    80105c5f <alltraps>

80106416 <vector71>:
80106416:	6a 00                	push   $0x0
80106418:	6a 47                	push   $0x47
8010641a:	e9 40 f8 ff ff       	jmp    80105c5f <alltraps>

8010641f <vector72>:
8010641f:	6a 00                	push   $0x0
80106421:	6a 48                	push   $0x48
80106423:	e9 37 f8 ff ff       	jmp    80105c5f <alltraps>

80106428 <vector73>:
80106428:	6a 00                	push   $0x0
8010642a:	6a 49                	push   $0x49
8010642c:	e9 2e f8 ff ff       	jmp    80105c5f <alltraps>

80106431 <vector74>:
80106431:	6a 00                	push   $0x0
80106433:	6a 4a                	push   $0x4a
80106435:	e9 25 f8 ff ff       	jmp    80105c5f <alltraps>

8010643a <vector75>:
8010643a:	6a 00                	push   $0x0
8010643c:	6a 4b                	push   $0x4b
8010643e:	e9 1c f8 ff ff       	jmp    80105c5f <alltraps>

80106443 <vector76>:
80106443:	6a 00                	push   $0x0
80106445:	6a 4c                	push   $0x4c
80106447:	e9 13 f8 ff ff       	jmp    80105c5f <alltraps>

8010644c <vector77>:
8010644c:	6a 00                	push   $0x0
8010644e:	6a 4d                	push   $0x4d
80106450:	e9 0a f8 ff ff       	jmp    80105c5f <alltraps>

80106455 <vector78>:
80106455:	6a 00                	push   $0x0
80106457:	6a 4e                	push   $0x4e
80106459:	e9 01 f8 ff ff       	jmp    80105c5f <alltraps>

8010645e <vector79>:
8010645e:	6a 00                	push   $0x0
80106460:	6a 4f                	push   $0x4f
80106462:	e9 f8 f7 ff ff       	jmp    80105c5f <alltraps>

80106467 <vector80>:
80106467:	6a 00                	push   $0x0
80106469:	6a 50                	push   $0x50
8010646b:	e9 ef f7 ff ff       	jmp    80105c5f <alltraps>

80106470 <vector81>:
80106470:	6a 00                	push   $0x0
80106472:	6a 51                	push   $0x51
80106474:	e9 e6 f7 ff ff       	jmp    80105c5f <alltraps>

80106479 <vector82>:
80106479:	6a 00                	push   $0x0
8010647b:	6a 52                	push   $0x52
8010647d:	e9 dd f7 ff ff       	jmp    80105c5f <alltraps>

80106482 <vector83>:
80106482:	6a 00                	push   $0x0
80106484:	6a 53                	push   $0x53
80106486:	e9 d4 f7 ff ff       	jmp    80105c5f <alltraps>

8010648b <vector84>:
8010648b:	6a 00                	push   $0x0
8010648d:	6a 54                	push   $0x54
8010648f:	e9 cb f7 ff ff       	jmp    80105c5f <alltraps>

80106494 <vector85>:
80106494:	6a 00                	push   $0x0
80106496:	6a 55                	push   $0x55
80106498:	e9 c2 f7 ff ff       	jmp    80105c5f <alltraps>

8010649d <vector86>:
8010649d:	6a 00                	push   $0x0
8010649f:	6a 56                	push   $0x56
801064a1:	e9 b9 f7 ff ff       	jmp    80105c5f <alltraps>

801064a6 <vector87>:
801064a6:	6a 00                	push   $0x0
801064a8:	6a 57                	push   $0x57
801064aa:	e9 b0 f7 ff ff       	jmp    80105c5f <alltraps>

801064af <vector88>:
801064af:	6a 00                	push   $0x0
801064b1:	6a 58                	push   $0x58
801064b3:	e9 a7 f7 ff ff       	jmp    80105c5f <alltraps>

801064b8 <vector89>:
801064b8:	6a 00                	push   $0x0
801064ba:	6a 59                	push   $0x59
801064bc:	e9 9e f7 ff ff       	jmp    80105c5f <alltraps>

801064c1 <vector90>:
801064c1:	6a 00                	push   $0x0
801064c3:	6a 5a                	push   $0x5a
801064c5:	e9 95 f7 ff ff       	jmp    80105c5f <alltraps>

801064ca <vector91>:
801064ca:	6a 00                	push   $0x0
801064cc:	6a 5b                	push   $0x5b
801064ce:	e9 8c f7 ff ff       	jmp    80105c5f <alltraps>

801064d3 <vector92>:
801064d3:	6a 00                	push   $0x0
801064d5:	6a 5c                	push   $0x5c
801064d7:	e9 83 f7 ff ff       	jmp    80105c5f <alltraps>

801064dc <vector93>:
801064dc:	6a 00                	push   $0x0
801064de:	6a 5d                	push   $0x5d
801064e0:	e9 7a f7 ff ff       	jmp    80105c5f <alltraps>

801064e5 <vector94>:
801064e5:	6a 00                	push   $0x0
801064e7:	6a 5e                	push   $0x5e
801064e9:	e9 71 f7 ff ff       	jmp    80105c5f <alltraps>

801064ee <vector95>:
801064ee:	6a 00                	push   $0x0
801064f0:	6a 5f                	push   $0x5f
801064f2:	e9 68 f7 ff ff       	jmp    80105c5f <alltraps>

801064f7 <vector96>:
801064f7:	6a 00                	push   $0x0
801064f9:	6a 60                	push   $0x60
801064fb:	e9 5f f7 ff ff       	jmp    80105c5f <alltraps>

80106500 <vector97>:
80106500:	6a 00                	push   $0x0
80106502:	6a 61                	push   $0x61
80106504:	e9 56 f7 ff ff       	jmp    80105c5f <alltraps>

80106509 <vector98>:
80106509:	6a 00                	push   $0x0
8010650b:	6a 62                	push   $0x62
8010650d:	e9 4d f7 ff ff       	jmp    80105c5f <alltraps>

80106512 <vector99>:
80106512:	6a 00                	push   $0x0
80106514:	6a 63                	push   $0x63
80106516:	e9 44 f7 ff ff       	jmp    80105c5f <alltraps>

8010651b <vector100>:
8010651b:	6a 00                	push   $0x0
8010651d:	6a 64                	push   $0x64
8010651f:	e9 3b f7 ff ff       	jmp    80105c5f <alltraps>

80106524 <vector101>:
80106524:	6a 00                	push   $0x0
80106526:	6a 65                	push   $0x65
80106528:	e9 32 f7 ff ff       	jmp    80105c5f <alltraps>

8010652d <vector102>:
8010652d:	6a 00                	push   $0x0
8010652f:	6a 66                	push   $0x66
80106531:	e9 29 f7 ff ff       	jmp    80105c5f <alltraps>

80106536 <vector103>:
80106536:	6a 00                	push   $0x0
80106538:	6a 67                	push   $0x67
8010653a:	e9 20 f7 ff ff       	jmp    80105c5f <alltraps>

8010653f <vector104>:
8010653f:	6a 00                	push   $0x0
80106541:	6a 68                	push   $0x68
80106543:	e9 17 f7 ff ff       	jmp    80105c5f <alltraps>

80106548 <vector105>:
80106548:	6a 00                	push   $0x0
8010654a:	6a 69                	push   $0x69
8010654c:	e9 0e f7 ff ff       	jmp    80105c5f <alltraps>

80106551 <vector106>:
80106551:	6a 00                	push   $0x0
80106553:	6a 6a                	push   $0x6a
80106555:	e9 05 f7 ff ff       	jmp    80105c5f <alltraps>

8010655a <vector107>:
8010655a:	6a 00                	push   $0x0
8010655c:	6a 6b                	push   $0x6b
8010655e:	e9 fc f6 ff ff       	jmp    80105c5f <alltraps>

80106563 <vector108>:
80106563:	6a 00                	push   $0x0
80106565:	6a 6c                	push   $0x6c
80106567:	e9 f3 f6 ff ff       	jmp    80105c5f <alltraps>

8010656c <vector109>:
8010656c:	6a 00                	push   $0x0
8010656e:	6a 6d                	push   $0x6d
80106570:	e9 ea f6 ff ff       	jmp    80105c5f <alltraps>

80106575 <vector110>:
80106575:	6a 00                	push   $0x0
80106577:	6a 6e                	push   $0x6e
80106579:	e9 e1 f6 ff ff       	jmp    80105c5f <alltraps>

8010657e <vector111>:
8010657e:	6a 00                	push   $0x0
80106580:	6a 6f                	push   $0x6f
80106582:	e9 d8 f6 ff ff       	jmp    80105c5f <alltraps>

80106587 <vector112>:
80106587:	6a 00                	push   $0x0
80106589:	6a 70                	push   $0x70
8010658b:	e9 cf f6 ff ff       	jmp    80105c5f <alltraps>

80106590 <vector113>:
80106590:	6a 00                	push   $0x0
80106592:	6a 71                	push   $0x71
80106594:	e9 c6 f6 ff ff       	jmp    80105c5f <alltraps>

80106599 <vector114>:
80106599:	6a 00                	push   $0x0
8010659b:	6a 72                	push   $0x72
8010659d:	e9 bd f6 ff ff       	jmp    80105c5f <alltraps>

801065a2 <vector115>:
801065a2:	6a 00                	push   $0x0
801065a4:	6a 73                	push   $0x73
801065a6:	e9 b4 f6 ff ff       	jmp    80105c5f <alltraps>

801065ab <vector116>:
801065ab:	6a 00                	push   $0x0
801065ad:	6a 74                	push   $0x74
801065af:	e9 ab f6 ff ff       	jmp    80105c5f <alltraps>

801065b4 <vector117>:
801065b4:	6a 00                	push   $0x0
801065b6:	6a 75                	push   $0x75
801065b8:	e9 a2 f6 ff ff       	jmp    80105c5f <alltraps>

801065bd <vector118>:
801065bd:	6a 00                	push   $0x0
801065bf:	6a 76                	push   $0x76
801065c1:	e9 99 f6 ff ff       	jmp    80105c5f <alltraps>

801065c6 <vector119>:
801065c6:	6a 00                	push   $0x0
801065c8:	6a 77                	push   $0x77
801065ca:	e9 90 f6 ff ff       	jmp    80105c5f <alltraps>

801065cf <vector120>:
801065cf:	6a 00                	push   $0x0
801065d1:	6a 78                	push   $0x78
801065d3:	e9 87 f6 ff ff       	jmp    80105c5f <alltraps>

801065d8 <vector121>:
801065d8:	6a 00                	push   $0x0
801065da:	6a 79                	push   $0x79
801065dc:	e9 7e f6 ff ff       	jmp    80105c5f <alltraps>

801065e1 <vector122>:
801065e1:	6a 00                	push   $0x0
801065e3:	6a 7a                	push   $0x7a
801065e5:	e9 75 f6 ff ff       	jmp    80105c5f <alltraps>

801065ea <vector123>:
801065ea:	6a 00                	push   $0x0
801065ec:	6a 7b                	push   $0x7b
801065ee:	e9 6c f6 ff ff       	jmp    80105c5f <alltraps>

801065f3 <vector124>:
801065f3:	6a 00                	push   $0x0
801065f5:	6a 7c                	push   $0x7c
801065f7:	e9 63 f6 ff ff       	jmp    80105c5f <alltraps>

801065fc <vector125>:
801065fc:	6a 00                	push   $0x0
801065fe:	6a 7d                	push   $0x7d
80106600:	e9 5a f6 ff ff       	jmp    80105c5f <alltraps>

80106605 <vector126>:
80106605:	6a 00                	push   $0x0
80106607:	6a 7e                	push   $0x7e
80106609:	e9 51 f6 ff ff       	jmp    80105c5f <alltraps>

8010660e <vector127>:
8010660e:	6a 00                	push   $0x0
80106610:	6a 7f                	push   $0x7f
80106612:	e9 48 f6 ff ff       	jmp    80105c5f <alltraps>

80106617 <vector128>:
80106617:	6a 00                	push   $0x0
80106619:	68 80 00 00 00       	push   $0x80
8010661e:	e9 3c f6 ff ff       	jmp    80105c5f <alltraps>

80106623 <vector129>:
80106623:	6a 00                	push   $0x0
80106625:	68 81 00 00 00       	push   $0x81
8010662a:	e9 30 f6 ff ff       	jmp    80105c5f <alltraps>

8010662f <vector130>:
8010662f:	6a 00                	push   $0x0
80106631:	68 82 00 00 00       	push   $0x82
80106636:	e9 24 f6 ff ff       	jmp    80105c5f <alltraps>

8010663b <vector131>:
8010663b:	6a 00                	push   $0x0
8010663d:	68 83 00 00 00       	push   $0x83
80106642:	e9 18 f6 ff ff       	jmp    80105c5f <alltraps>

80106647 <vector132>:
80106647:	6a 00                	push   $0x0
80106649:	68 84 00 00 00       	push   $0x84
8010664e:	e9 0c f6 ff ff       	jmp    80105c5f <alltraps>

80106653 <vector133>:
80106653:	6a 00                	push   $0x0
80106655:	68 85 00 00 00       	push   $0x85
8010665a:	e9 00 f6 ff ff       	jmp    80105c5f <alltraps>

8010665f <vector134>:
8010665f:	6a 00                	push   $0x0
80106661:	68 86 00 00 00       	push   $0x86
80106666:	e9 f4 f5 ff ff       	jmp    80105c5f <alltraps>

8010666b <vector135>:
8010666b:	6a 00                	push   $0x0
8010666d:	68 87 00 00 00       	push   $0x87
80106672:	e9 e8 f5 ff ff       	jmp    80105c5f <alltraps>

80106677 <vector136>:
80106677:	6a 00                	push   $0x0
80106679:	68 88 00 00 00       	push   $0x88
8010667e:	e9 dc f5 ff ff       	jmp    80105c5f <alltraps>

80106683 <vector137>:
80106683:	6a 00                	push   $0x0
80106685:	68 89 00 00 00       	push   $0x89
8010668a:	e9 d0 f5 ff ff       	jmp    80105c5f <alltraps>

8010668f <vector138>:
8010668f:	6a 00                	push   $0x0
80106691:	68 8a 00 00 00       	push   $0x8a
80106696:	e9 c4 f5 ff ff       	jmp    80105c5f <alltraps>

8010669b <vector139>:
8010669b:	6a 00                	push   $0x0
8010669d:	68 8b 00 00 00       	push   $0x8b
801066a2:	e9 b8 f5 ff ff       	jmp    80105c5f <alltraps>

801066a7 <vector140>:
801066a7:	6a 00                	push   $0x0
801066a9:	68 8c 00 00 00       	push   $0x8c
801066ae:	e9 ac f5 ff ff       	jmp    80105c5f <alltraps>

801066b3 <vector141>:
801066b3:	6a 00                	push   $0x0
801066b5:	68 8d 00 00 00       	push   $0x8d
801066ba:	e9 a0 f5 ff ff       	jmp    80105c5f <alltraps>

801066bf <vector142>:
801066bf:	6a 00                	push   $0x0
801066c1:	68 8e 00 00 00       	push   $0x8e
801066c6:	e9 94 f5 ff ff       	jmp    80105c5f <alltraps>

801066cb <vector143>:
801066cb:	6a 00                	push   $0x0
801066cd:	68 8f 00 00 00       	push   $0x8f
801066d2:	e9 88 f5 ff ff       	jmp    80105c5f <alltraps>

801066d7 <vector144>:
801066d7:	6a 00                	push   $0x0
801066d9:	68 90 00 00 00       	push   $0x90
801066de:	e9 7c f5 ff ff       	jmp    80105c5f <alltraps>

801066e3 <vector145>:
801066e3:	6a 00                	push   $0x0
801066e5:	68 91 00 00 00       	push   $0x91
801066ea:	e9 70 f5 ff ff       	jmp    80105c5f <alltraps>

801066ef <vector146>:
801066ef:	6a 00                	push   $0x0
801066f1:	68 92 00 00 00       	push   $0x92
801066f6:	e9 64 f5 ff ff       	jmp    80105c5f <alltraps>

801066fb <vector147>:
801066fb:	6a 00                	push   $0x0
801066fd:	68 93 00 00 00       	push   $0x93
80106702:	e9 58 f5 ff ff       	jmp    80105c5f <alltraps>

80106707 <vector148>:
80106707:	6a 00                	push   $0x0
80106709:	68 94 00 00 00       	push   $0x94
8010670e:	e9 4c f5 ff ff       	jmp    80105c5f <alltraps>

80106713 <vector149>:
80106713:	6a 00                	push   $0x0
80106715:	68 95 00 00 00       	push   $0x95
8010671a:	e9 40 f5 ff ff       	jmp    80105c5f <alltraps>

8010671f <vector150>:
8010671f:	6a 00                	push   $0x0
80106721:	68 96 00 00 00       	push   $0x96
80106726:	e9 34 f5 ff ff       	jmp    80105c5f <alltraps>

8010672b <vector151>:
8010672b:	6a 00                	push   $0x0
8010672d:	68 97 00 00 00       	push   $0x97
80106732:	e9 28 f5 ff ff       	jmp    80105c5f <alltraps>

80106737 <vector152>:
80106737:	6a 00                	push   $0x0
80106739:	68 98 00 00 00       	push   $0x98
8010673e:	e9 1c f5 ff ff       	jmp    80105c5f <alltraps>

80106743 <vector153>:
80106743:	6a 00                	push   $0x0
80106745:	68 99 00 00 00       	push   $0x99
8010674a:	e9 10 f5 ff ff       	jmp    80105c5f <alltraps>

8010674f <vector154>:
8010674f:	6a 00                	push   $0x0
80106751:	68 9a 00 00 00       	push   $0x9a
80106756:	e9 04 f5 ff ff       	jmp    80105c5f <alltraps>

8010675b <vector155>:
8010675b:	6a 00                	push   $0x0
8010675d:	68 9b 00 00 00       	push   $0x9b
80106762:	e9 f8 f4 ff ff       	jmp    80105c5f <alltraps>

80106767 <vector156>:
80106767:	6a 00                	push   $0x0
80106769:	68 9c 00 00 00       	push   $0x9c
8010676e:	e9 ec f4 ff ff       	jmp    80105c5f <alltraps>

80106773 <vector157>:
80106773:	6a 00                	push   $0x0
80106775:	68 9d 00 00 00       	push   $0x9d
8010677a:	e9 e0 f4 ff ff       	jmp    80105c5f <alltraps>

8010677f <vector158>:
8010677f:	6a 00                	push   $0x0
80106781:	68 9e 00 00 00       	push   $0x9e
80106786:	e9 d4 f4 ff ff       	jmp    80105c5f <alltraps>

8010678b <vector159>:
8010678b:	6a 00                	push   $0x0
8010678d:	68 9f 00 00 00       	push   $0x9f
80106792:	e9 c8 f4 ff ff       	jmp    80105c5f <alltraps>

80106797 <vector160>:
80106797:	6a 00                	push   $0x0
80106799:	68 a0 00 00 00       	push   $0xa0
8010679e:	e9 bc f4 ff ff       	jmp    80105c5f <alltraps>

801067a3 <vector161>:
801067a3:	6a 00                	push   $0x0
801067a5:	68 a1 00 00 00       	push   $0xa1
801067aa:	e9 b0 f4 ff ff       	jmp    80105c5f <alltraps>

801067af <vector162>:
801067af:	6a 00                	push   $0x0
801067b1:	68 a2 00 00 00       	push   $0xa2
801067b6:	e9 a4 f4 ff ff       	jmp    80105c5f <alltraps>

801067bb <vector163>:
801067bb:	6a 00                	push   $0x0
801067bd:	68 a3 00 00 00       	push   $0xa3
801067c2:	e9 98 f4 ff ff       	jmp    80105c5f <alltraps>

801067c7 <vector164>:
801067c7:	6a 00                	push   $0x0
801067c9:	68 a4 00 00 00       	push   $0xa4
801067ce:	e9 8c f4 ff ff       	jmp    80105c5f <alltraps>

801067d3 <vector165>:
801067d3:	6a 00                	push   $0x0
801067d5:	68 a5 00 00 00       	push   $0xa5
801067da:	e9 80 f4 ff ff       	jmp    80105c5f <alltraps>

801067df <vector166>:
801067df:	6a 00                	push   $0x0
801067e1:	68 a6 00 00 00       	push   $0xa6
801067e6:	e9 74 f4 ff ff       	jmp    80105c5f <alltraps>

801067eb <vector167>:
801067eb:	6a 00                	push   $0x0
801067ed:	68 a7 00 00 00       	push   $0xa7
801067f2:	e9 68 f4 ff ff       	jmp    80105c5f <alltraps>

801067f7 <vector168>:
801067f7:	6a 00                	push   $0x0
801067f9:	68 a8 00 00 00       	push   $0xa8
801067fe:	e9 5c f4 ff ff       	jmp    80105c5f <alltraps>

80106803 <vector169>:
80106803:	6a 00                	push   $0x0
80106805:	68 a9 00 00 00       	push   $0xa9
8010680a:	e9 50 f4 ff ff       	jmp    80105c5f <alltraps>

8010680f <vector170>:
8010680f:	6a 00                	push   $0x0
80106811:	68 aa 00 00 00       	push   $0xaa
80106816:	e9 44 f4 ff ff       	jmp    80105c5f <alltraps>

8010681b <vector171>:
8010681b:	6a 00                	push   $0x0
8010681d:	68 ab 00 00 00       	push   $0xab
80106822:	e9 38 f4 ff ff       	jmp    80105c5f <alltraps>

80106827 <vector172>:
80106827:	6a 00                	push   $0x0
80106829:	68 ac 00 00 00       	push   $0xac
8010682e:	e9 2c f4 ff ff       	jmp    80105c5f <alltraps>

80106833 <vector173>:
80106833:	6a 00                	push   $0x0
80106835:	68 ad 00 00 00       	push   $0xad
8010683a:	e9 20 f4 ff ff       	jmp    80105c5f <alltraps>

8010683f <vector174>:
8010683f:	6a 00                	push   $0x0
80106841:	68 ae 00 00 00       	push   $0xae
80106846:	e9 14 f4 ff ff       	jmp    80105c5f <alltraps>

8010684b <vector175>:
8010684b:	6a 00                	push   $0x0
8010684d:	68 af 00 00 00       	push   $0xaf
80106852:	e9 08 f4 ff ff       	jmp    80105c5f <alltraps>

80106857 <vector176>:
80106857:	6a 00                	push   $0x0
80106859:	68 b0 00 00 00       	push   $0xb0
8010685e:	e9 fc f3 ff ff       	jmp    80105c5f <alltraps>

80106863 <vector177>:
80106863:	6a 00                	push   $0x0
80106865:	68 b1 00 00 00       	push   $0xb1
8010686a:	e9 f0 f3 ff ff       	jmp    80105c5f <alltraps>

8010686f <vector178>:
8010686f:	6a 00                	push   $0x0
80106871:	68 b2 00 00 00       	push   $0xb2
80106876:	e9 e4 f3 ff ff       	jmp    80105c5f <alltraps>

8010687b <vector179>:
8010687b:	6a 00                	push   $0x0
8010687d:	68 b3 00 00 00       	push   $0xb3
80106882:	e9 d8 f3 ff ff       	jmp    80105c5f <alltraps>

80106887 <vector180>:
80106887:	6a 00                	push   $0x0
80106889:	68 b4 00 00 00       	push   $0xb4
8010688e:	e9 cc f3 ff ff       	jmp    80105c5f <alltraps>

80106893 <vector181>:
80106893:	6a 00                	push   $0x0
80106895:	68 b5 00 00 00       	push   $0xb5
8010689a:	e9 c0 f3 ff ff       	jmp    80105c5f <alltraps>

8010689f <vector182>:
8010689f:	6a 00                	push   $0x0
801068a1:	68 b6 00 00 00       	push   $0xb6
801068a6:	e9 b4 f3 ff ff       	jmp    80105c5f <alltraps>

801068ab <vector183>:
801068ab:	6a 00                	push   $0x0
801068ad:	68 b7 00 00 00       	push   $0xb7
801068b2:	e9 a8 f3 ff ff       	jmp    80105c5f <alltraps>

801068b7 <vector184>:
801068b7:	6a 00                	push   $0x0
801068b9:	68 b8 00 00 00       	push   $0xb8
801068be:	e9 9c f3 ff ff       	jmp    80105c5f <alltraps>

801068c3 <vector185>:
801068c3:	6a 00                	push   $0x0
801068c5:	68 b9 00 00 00       	push   $0xb9
801068ca:	e9 90 f3 ff ff       	jmp    80105c5f <alltraps>

801068cf <vector186>:
801068cf:	6a 00                	push   $0x0
801068d1:	68 ba 00 00 00       	push   $0xba
801068d6:	e9 84 f3 ff ff       	jmp    80105c5f <alltraps>

801068db <vector187>:
801068db:	6a 00                	push   $0x0
801068dd:	68 bb 00 00 00       	push   $0xbb
801068e2:	e9 78 f3 ff ff       	jmp    80105c5f <alltraps>

801068e7 <vector188>:
801068e7:	6a 00                	push   $0x0
801068e9:	68 bc 00 00 00       	push   $0xbc
801068ee:	e9 6c f3 ff ff       	jmp    80105c5f <alltraps>

801068f3 <vector189>:
801068f3:	6a 00                	push   $0x0
801068f5:	68 bd 00 00 00       	push   $0xbd
801068fa:	e9 60 f3 ff ff       	jmp    80105c5f <alltraps>

801068ff <vector190>:
801068ff:	6a 00                	push   $0x0
80106901:	68 be 00 00 00       	push   $0xbe
80106906:	e9 54 f3 ff ff       	jmp    80105c5f <alltraps>

8010690b <vector191>:
8010690b:	6a 00                	push   $0x0
8010690d:	68 bf 00 00 00       	push   $0xbf
80106912:	e9 48 f3 ff ff       	jmp    80105c5f <alltraps>

80106917 <vector192>:
80106917:	6a 00                	push   $0x0
80106919:	68 c0 00 00 00       	push   $0xc0
8010691e:	e9 3c f3 ff ff       	jmp    80105c5f <alltraps>

80106923 <vector193>:
80106923:	6a 00                	push   $0x0
80106925:	68 c1 00 00 00       	push   $0xc1
8010692a:	e9 30 f3 ff ff       	jmp    80105c5f <alltraps>

8010692f <vector194>:
8010692f:	6a 00                	push   $0x0
80106931:	68 c2 00 00 00       	push   $0xc2
80106936:	e9 24 f3 ff ff       	jmp    80105c5f <alltraps>

8010693b <vector195>:
8010693b:	6a 00                	push   $0x0
8010693d:	68 c3 00 00 00       	push   $0xc3
80106942:	e9 18 f3 ff ff       	jmp    80105c5f <alltraps>

80106947 <vector196>:
80106947:	6a 00                	push   $0x0
80106949:	68 c4 00 00 00       	push   $0xc4
8010694e:	e9 0c f3 ff ff       	jmp    80105c5f <alltraps>

80106953 <vector197>:
80106953:	6a 00                	push   $0x0
80106955:	68 c5 00 00 00       	push   $0xc5
8010695a:	e9 00 f3 ff ff       	jmp    80105c5f <alltraps>

8010695f <vector198>:
8010695f:	6a 00                	push   $0x0
80106961:	68 c6 00 00 00       	push   $0xc6
80106966:	e9 f4 f2 ff ff       	jmp    80105c5f <alltraps>

8010696b <vector199>:
8010696b:	6a 00                	push   $0x0
8010696d:	68 c7 00 00 00       	push   $0xc7
80106972:	e9 e8 f2 ff ff       	jmp    80105c5f <alltraps>

80106977 <vector200>:
80106977:	6a 00                	push   $0x0
80106979:	68 c8 00 00 00       	push   $0xc8
8010697e:	e9 dc f2 ff ff       	jmp    80105c5f <alltraps>

80106983 <vector201>:
80106983:	6a 00                	push   $0x0
80106985:	68 c9 00 00 00       	push   $0xc9
8010698a:	e9 d0 f2 ff ff       	jmp    80105c5f <alltraps>

8010698f <vector202>:
8010698f:	6a 00                	push   $0x0
80106991:	68 ca 00 00 00       	push   $0xca
80106996:	e9 c4 f2 ff ff       	jmp    80105c5f <alltraps>

8010699b <vector203>:
8010699b:	6a 00                	push   $0x0
8010699d:	68 cb 00 00 00       	push   $0xcb
801069a2:	e9 b8 f2 ff ff       	jmp    80105c5f <alltraps>

801069a7 <vector204>:
801069a7:	6a 00                	push   $0x0
801069a9:	68 cc 00 00 00       	push   $0xcc
801069ae:	e9 ac f2 ff ff       	jmp    80105c5f <alltraps>

801069b3 <vector205>:
801069b3:	6a 00                	push   $0x0
801069b5:	68 cd 00 00 00       	push   $0xcd
801069ba:	e9 a0 f2 ff ff       	jmp    80105c5f <alltraps>

801069bf <vector206>:
801069bf:	6a 00                	push   $0x0
801069c1:	68 ce 00 00 00       	push   $0xce
801069c6:	e9 94 f2 ff ff       	jmp    80105c5f <alltraps>

801069cb <vector207>:
801069cb:	6a 00                	push   $0x0
801069cd:	68 cf 00 00 00       	push   $0xcf
801069d2:	e9 88 f2 ff ff       	jmp    80105c5f <alltraps>

801069d7 <vector208>:
801069d7:	6a 00                	push   $0x0
801069d9:	68 d0 00 00 00       	push   $0xd0
801069de:	e9 7c f2 ff ff       	jmp    80105c5f <alltraps>

801069e3 <vector209>:
801069e3:	6a 00                	push   $0x0
801069e5:	68 d1 00 00 00       	push   $0xd1
801069ea:	e9 70 f2 ff ff       	jmp    80105c5f <alltraps>

801069ef <vector210>:
801069ef:	6a 00                	push   $0x0
801069f1:	68 d2 00 00 00       	push   $0xd2
801069f6:	e9 64 f2 ff ff       	jmp    80105c5f <alltraps>

801069fb <vector211>:
801069fb:	6a 00                	push   $0x0
801069fd:	68 d3 00 00 00       	push   $0xd3
80106a02:	e9 58 f2 ff ff       	jmp    80105c5f <alltraps>

80106a07 <vector212>:
80106a07:	6a 00                	push   $0x0
80106a09:	68 d4 00 00 00       	push   $0xd4
80106a0e:	e9 4c f2 ff ff       	jmp    80105c5f <alltraps>

80106a13 <vector213>:
80106a13:	6a 00                	push   $0x0
80106a15:	68 d5 00 00 00       	push   $0xd5
80106a1a:	e9 40 f2 ff ff       	jmp    80105c5f <alltraps>

80106a1f <vector214>:
80106a1f:	6a 00                	push   $0x0
80106a21:	68 d6 00 00 00       	push   $0xd6
80106a26:	e9 34 f2 ff ff       	jmp    80105c5f <alltraps>

80106a2b <vector215>:
80106a2b:	6a 00                	push   $0x0
80106a2d:	68 d7 00 00 00       	push   $0xd7
80106a32:	e9 28 f2 ff ff       	jmp    80105c5f <alltraps>

80106a37 <vector216>:
80106a37:	6a 00                	push   $0x0
80106a39:	68 d8 00 00 00       	push   $0xd8
80106a3e:	e9 1c f2 ff ff       	jmp    80105c5f <alltraps>

80106a43 <vector217>:
80106a43:	6a 00                	push   $0x0
80106a45:	68 d9 00 00 00       	push   $0xd9
80106a4a:	e9 10 f2 ff ff       	jmp    80105c5f <alltraps>

80106a4f <vector218>:
80106a4f:	6a 00                	push   $0x0
80106a51:	68 da 00 00 00       	push   $0xda
80106a56:	e9 04 f2 ff ff       	jmp    80105c5f <alltraps>

80106a5b <vector219>:
80106a5b:	6a 00                	push   $0x0
80106a5d:	68 db 00 00 00       	push   $0xdb
80106a62:	e9 f8 f1 ff ff       	jmp    80105c5f <alltraps>

80106a67 <vector220>:
80106a67:	6a 00                	push   $0x0
80106a69:	68 dc 00 00 00       	push   $0xdc
80106a6e:	e9 ec f1 ff ff       	jmp    80105c5f <alltraps>

80106a73 <vector221>:
80106a73:	6a 00                	push   $0x0
80106a75:	68 dd 00 00 00       	push   $0xdd
80106a7a:	e9 e0 f1 ff ff       	jmp    80105c5f <alltraps>

80106a7f <vector222>:
80106a7f:	6a 00                	push   $0x0
80106a81:	68 de 00 00 00       	push   $0xde
80106a86:	e9 d4 f1 ff ff       	jmp    80105c5f <alltraps>

80106a8b <vector223>:
80106a8b:	6a 00                	push   $0x0
80106a8d:	68 df 00 00 00       	push   $0xdf
80106a92:	e9 c8 f1 ff ff       	jmp    80105c5f <alltraps>

80106a97 <vector224>:
80106a97:	6a 00                	push   $0x0
80106a99:	68 e0 00 00 00       	push   $0xe0
80106a9e:	e9 bc f1 ff ff       	jmp    80105c5f <alltraps>

80106aa3 <vector225>:
80106aa3:	6a 00                	push   $0x0
80106aa5:	68 e1 00 00 00       	push   $0xe1
80106aaa:	e9 b0 f1 ff ff       	jmp    80105c5f <alltraps>

80106aaf <vector226>:
80106aaf:	6a 00                	push   $0x0
80106ab1:	68 e2 00 00 00       	push   $0xe2
80106ab6:	e9 a4 f1 ff ff       	jmp    80105c5f <alltraps>

80106abb <vector227>:
80106abb:	6a 00                	push   $0x0
80106abd:	68 e3 00 00 00       	push   $0xe3
80106ac2:	e9 98 f1 ff ff       	jmp    80105c5f <alltraps>

80106ac7 <vector228>:
80106ac7:	6a 00                	push   $0x0
80106ac9:	68 e4 00 00 00       	push   $0xe4
80106ace:	e9 8c f1 ff ff       	jmp    80105c5f <alltraps>

80106ad3 <vector229>:
80106ad3:	6a 00                	push   $0x0
80106ad5:	68 e5 00 00 00       	push   $0xe5
80106ada:	e9 80 f1 ff ff       	jmp    80105c5f <alltraps>

80106adf <vector230>:
80106adf:	6a 00                	push   $0x0
80106ae1:	68 e6 00 00 00       	push   $0xe6
80106ae6:	e9 74 f1 ff ff       	jmp    80105c5f <alltraps>

80106aeb <vector231>:
80106aeb:	6a 00                	push   $0x0
80106aed:	68 e7 00 00 00       	push   $0xe7
80106af2:	e9 68 f1 ff ff       	jmp    80105c5f <alltraps>

80106af7 <vector232>:
80106af7:	6a 00                	push   $0x0
80106af9:	68 e8 00 00 00       	push   $0xe8
80106afe:	e9 5c f1 ff ff       	jmp    80105c5f <alltraps>

80106b03 <vector233>:
80106b03:	6a 00                	push   $0x0
80106b05:	68 e9 00 00 00       	push   $0xe9
80106b0a:	e9 50 f1 ff ff       	jmp    80105c5f <alltraps>

80106b0f <vector234>:
80106b0f:	6a 00                	push   $0x0
80106b11:	68 ea 00 00 00       	push   $0xea
80106b16:	e9 44 f1 ff ff       	jmp    80105c5f <alltraps>

80106b1b <vector235>:
80106b1b:	6a 00                	push   $0x0
80106b1d:	68 eb 00 00 00       	push   $0xeb
80106b22:	e9 38 f1 ff ff       	jmp    80105c5f <alltraps>

80106b27 <vector236>:
80106b27:	6a 00                	push   $0x0
80106b29:	68 ec 00 00 00       	push   $0xec
80106b2e:	e9 2c f1 ff ff       	jmp    80105c5f <alltraps>

80106b33 <vector237>:
80106b33:	6a 00                	push   $0x0
80106b35:	68 ed 00 00 00       	push   $0xed
80106b3a:	e9 20 f1 ff ff       	jmp    80105c5f <alltraps>

80106b3f <vector238>:
80106b3f:	6a 00                	push   $0x0
80106b41:	68 ee 00 00 00       	push   $0xee
80106b46:	e9 14 f1 ff ff       	jmp    80105c5f <alltraps>

80106b4b <vector239>:
80106b4b:	6a 00                	push   $0x0
80106b4d:	68 ef 00 00 00       	push   $0xef
80106b52:	e9 08 f1 ff ff       	jmp    80105c5f <alltraps>

80106b57 <vector240>:
80106b57:	6a 00                	push   $0x0
80106b59:	68 f0 00 00 00       	push   $0xf0
80106b5e:	e9 fc f0 ff ff       	jmp    80105c5f <alltraps>

80106b63 <vector241>:
80106b63:	6a 00                	push   $0x0
80106b65:	68 f1 00 00 00       	push   $0xf1
80106b6a:	e9 f0 f0 ff ff       	jmp    80105c5f <alltraps>

80106b6f <vector242>:
80106b6f:	6a 00                	push   $0x0
80106b71:	68 f2 00 00 00       	push   $0xf2
80106b76:	e9 e4 f0 ff ff       	jmp    80105c5f <alltraps>

80106b7b <vector243>:
80106b7b:	6a 00                	push   $0x0
80106b7d:	68 f3 00 00 00       	push   $0xf3
80106b82:	e9 d8 f0 ff ff       	jmp    80105c5f <alltraps>

80106b87 <vector244>:
80106b87:	6a 00                	push   $0x0
80106b89:	68 f4 00 00 00       	push   $0xf4
80106b8e:	e9 cc f0 ff ff       	jmp    80105c5f <alltraps>

80106b93 <vector245>:
80106b93:	6a 00                	push   $0x0
80106b95:	68 f5 00 00 00       	push   $0xf5
80106b9a:	e9 c0 f0 ff ff       	jmp    80105c5f <alltraps>

80106b9f <vector246>:
80106b9f:	6a 00                	push   $0x0
80106ba1:	68 f6 00 00 00       	push   $0xf6
80106ba6:	e9 b4 f0 ff ff       	jmp    80105c5f <alltraps>

80106bab <vector247>:
80106bab:	6a 00                	push   $0x0
80106bad:	68 f7 00 00 00       	push   $0xf7
80106bb2:	e9 a8 f0 ff ff       	jmp    80105c5f <alltraps>

80106bb7 <vector248>:
80106bb7:	6a 00                	push   $0x0
80106bb9:	68 f8 00 00 00       	push   $0xf8
80106bbe:	e9 9c f0 ff ff       	jmp    80105c5f <alltraps>

80106bc3 <vector249>:
80106bc3:	6a 00                	push   $0x0
80106bc5:	68 f9 00 00 00       	push   $0xf9
80106bca:	e9 90 f0 ff ff       	jmp    80105c5f <alltraps>

80106bcf <vector250>:
80106bcf:	6a 00                	push   $0x0
80106bd1:	68 fa 00 00 00       	push   $0xfa
80106bd6:	e9 84 f0 ff ff       	jmp    80105c5f <alltraps>

80106bdb <vector251>:
80106bdb:	6a 00                	push   $0x0
80106bdd:	68 fb 00 00 00       	push   $0xfb
80106be2:	e9 78 f0 ff ff       	jmp    80105c5f <alltraps>

80106be7 <vector252>:
80106be7:	6a 00                	push   $0x0
80106be9:	68 fc 00 00 00       	push   $0xfc
80106bee:	e9 6c f0 ff ff       	jmp    80105c5f <alltraps>

80106bf3 <vector253>:
80106bf3:	6a 00                	push   $0x0
80106bf5:	68 fd 00 00 00       	push   $0xfd
80106bfa:	e9 60 f0 ff ff       	jmp    80105c5f <alltraps>

80106bff <vector254>:
80106bff:	6a 00                	push   $0x0
80106c01:	68 fe 00 00 00       	push   $0xfe
80106c06:	e9 54 f0 ff ff       	jmp    80105c5f <alltraps>

80106c0b <vector255>:
80106c0b:	6a 00                	push   $0x0
80106c0d:	68 ff 00 00 00       	push   $0xff
80106c12:	e9 48 f0 ff ff       	jmp    80105c5f <alltraps>
80106c17:	66 90                	xchg   %ax,%ax
80106c19:	66 90                	xchg   %ax,%ax
80106c1b:	66 90                	xchg   %ax,%ax
80106c1d:	66 90                	xchg   %ax,%ax
80106c1f:	90                   	nop

80106c20 <walkpgdir>:
80106c20:	55                   	push   %ebp
80106c21:	89 e5                	mov    %esp,%ebp
80106c23:	57                   	push   %edi
80106c24:	56                   	push   %esi
80106c25:	53                   	push   %ebx
80106c26:	89 d3                	mov    %edx,%ebx
80106c28:	89 d7                	mov    %edx,%edi
80106c2a:	c1 eb 16             	shr    $0x16,%ebx
80106c2d:	8d 34 98             	lea    (%eax,%ebx,4),%esi
80106c30:	83 ec 0c             	sub    $0xc,%esp
80106c33:	8b 06                	mov    (%esi),%eax
80106c35:	a8 01                	test   $0x1,%al
80106c37:	74 27                	je     80106c60 <walkpgdir+0x40>
80106c39:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106c3e:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
80106c44:	c1 ef 0a             	shr    $0xa,%edi
80106c47:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106c4a:	89 fa                	mov    %edi,%edx
80106c4c:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80106c52:	8d 04 13             	lea    (%ebx,%edx,1),%eax
80106c55:	5b                   	pop    %ebx
80106c56:	5e                   	pop    %esi
80106c57:	5f                   	pop    %edi
80106c58:	5d                   	pop    %ebp
80106c59:	c3                   	ret    
80106c5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106c60:	85 c9                	test   %ecx,%ecx
80106c62:	74 2c                	je     80106c90 <walkpgdir+0x70>
80106c64:	e8 87 b8 ff ff       	call   801024f0 <kalloc>
80106c69:	85 c0                	test   %eax,%eax
80106c6b:	89 c3                	mov    %eax,%ebx
80106c6d:	74 21                	je     80106c90 <walkpgdir+0x70>
80106c6f:	83 ec 04             	sub    $0x4,%esp
80106c72:	68 00 10 00 00       	push   $0x1000
80106c77:	6a 00                	push   $0x0
80106c79:	50                   	push   %eax
80106c7a:	e8 31 dd ff ff       	call   801049b0 <memset>
80106c7f:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106c85:	83 c4 10             	add    $0x10,%esp
80106c88:	83 c8 07             	or     $0x7,%eax
80106c8b:	89 06                	mov    %eax,(%esi)
80106c8d:	eb b5                	jmp    80106c44 <walkpgdir+0x24>
80106c8f:	90                   	nop
80106c90:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106c93:	31 c0                	xor    %eax,%eax
80106c95:	5b                   	pop    %ebx
80106c96:	5e                   	pop    %esi
80106c97:	5f                   	pop    %edi
80106c98:	5d                   	pop    %ebp
80106c99:	c3                   	ret    
80106c9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106ca0 <mappages>:
80106ca0:	55                   	push   %ebp
80106ca1:	89 e5                	mov    %esp,%ebp
80106ca3:	57                   	push   %edi
80106ca4:	56                   	push   %esi
80106ca5:	53                   	push   %ebx
80106ca6:	89 d3                	mov    %edx,%ebx
80106ca8:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
80106cae:	83 ec 1c             	sub    $0x1c,%esp
80106cb1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106cb4:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
80106cb8:	8b 7d 08             	mov    0x8(%ebp),%edi
80106cbb:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106cc0:	89 45 e0             	mov    %eax,-0x20(%ebp)
80106cc3:	8b 45 0c             	mov    0xc(%ebp),%eax
80106cc6:	29 df                	sub    %ebx,%edi
80106cc8:	83 c8 01             	or     $0x1,%eax
80106ccb:	89 45 dc             	mov    %eax,-0x24(%ebp)
80106cce:	eb 15                	jmp    80106ce5 <mappages+0x45>
80106cd0:	f6 00 01             	testb  $0x1,(%eax)
80106cd3:	75 45                	jne    80106d1a <mappages+0x7a>
80106cd5:	0b 75 dc             	or     -0x24(%ebp),%esi
80106cd8:	3b 5d e0             	cmp    -0x20(%ebp),%ebx
80106cdb:	89 30                	mov    %esi,(%eax)
80106cdd:	74 31                	je     80106d10 <mappages+0x70>
80106cdf:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106ce5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106ce8:	b9 01 00 00 00       	mov    $0x1,%ecx
80106ced:	89 da                	mov    %ebx,%edx
80106cef:	8d 34 3b             	lea    (%ebx,%edi,1),%esi
80106cf2:	e8 29 ff ff ff       	call   80106c20 <walkpgdir>
80106cf7:	85 c0                	test   %eax,%eax
80106cf9:	75 d5                	jne    80106cd0 <mappages+0x30>
80106cfb:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106cfe:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106d03:	5b                   	pop    %ebx
80106d04:	5e                   	pop    %esi
80106d05:	5f                   	pop    %edi
80106d06:	5d                   	pop    %ebp
80106d07:	c3                   	ret    
80106d08:	90                   	nop
80106d09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106d10:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106d13:	31 c0                	xor    %eax,%eax
80106d15:	5b                   	pop    %ebx
80106d16:	5e                   	pop    %esi
80106d17:	5f                   	pop    %edi
80106d18:	5d                   	pop    %ebp
80106d19:	c3                   	ret    
80106d1a:	83 ec 0c             	sub    $0xc,%esp
80106d1d:	68 14 7e 10 80       	push   $0x80107e14
80106d22:	e8 69 96 ff ff       	call   80100390 <panic>
80106d27:	89 f6                	mov    %esi,%esi
80106d29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106d30 <deallocuvm.part.0>:
80106d30:	55                   	push   %ebp
80106d31:	89 e5                	mov    %esp,%ebp
80106d33:	57                   	push   %edi
80106d34:	56                   	push   %esi
80106d35:	53                   	push   %ebx
80106d36:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
80106d3c:	89 c7                	mov    %eax,%edi
80106d3e:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
80106d44:	83 ec 1c             	sub    $0x1c,%esp
80106d47:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80106d4a:	39 d3                	cmp    %edx,%ebx
80106d4c:	73 66                	jae    80106db4 <deallocuvm.part.0+0x84>
80106d4e:	89 d6                	mov    %edx,%esi
80106d50:	eb 3d                	jmp    80106d8f <deallocuvm.part.0+0x5f>
80106d52:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106d58:	8b 10                	mov    (%eax),%edx
80106d5a:	f6 c2 01             	test   $0x1,%dl
80106d5d:	74 26                	je     80106d85 <deallocuvm.part.0+0x55>
80106d5f:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80106d65:	74 58                	je     80106dbf <deallocuvm.part.0+0x8f>
80106d67:	83 ec 0c             	sub    $0xc,%esp
80106d6a:	81 c2 00 00 00 80    	add    $0x80000000,%edx
80106d70:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106d73:	52                   	push   %edx
80106d74:	e8 c7 b5 ff ff       	call   80102340 <kfree>
80106d79:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106d7c:	83 c4 10             	add    $0x10,%esp
80106d7f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80106d85:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106d8b:	39 f3                	cmp    %esi,%ebx
80106d8d:	73 25                	jae    80106db4 <deallocuvm.part.0+0x84>
80106d8f:	31 c9                	xor    %ecx,%ecx
80106d91:	89 da                	mov    %ebx,%edx
80106d93:	89 f8                	mov    %edi,%eax
80106d95:	e8 86 fe ff ff       	call   80106c20 <walkpgdir>
80106d9a:	85 c0                	test   %eax,%eax
80106d9c:	75 ba                	jne    80106d58 <deallocuvm.part.0+0x28>
80106d9e:	81 e3 00 00 c0 ff    	and    $0xffc00000,%ebx
80106da4:	81 c3 00 f0 3f 00    	add    $0x3ff000,%ebx
80106daa:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106db0:	39 f3                	cmp    %esi,%ebx
80106db2:	72 db                	jb     80106d8f <deallocuvm.part.0+0x5f>
80106db4:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106db7:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106dba:	5b                   	pop    %ebx
80106dbb:	5e                   	pop    %esi
80106dbc:	5f                   	pop    %edi
80106dbd:	5d                   	pop    %ebp
80106dbe:	c3                   	ret    
80106dbf:	83 ec 0c             	sub    $0xc,%esp
80106dc2:	68 c6 77 10 80       	push   $0x801077c6
80106dc7:	e8 c4 95 ff ff       	call   80100390 <panic>
80106dcc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106dd0 <seginit>:
80106dd0:	55                   	push   %ebp
80106dd1:	89 e5                	mov    %esp,%ebp
80106dd3:	83 ec 18             	sub    $0x18,%esp
80106dd6:	e8 15 cb ff ff       	call   801038f0 <cpuid>
80106ddb:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
80106de1:	ba 2f 00 00 00       	mov    $0x2f,%edx
80106de6:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
80106dea:	c7 80 f8 27 11 80 ff 	movl   $0xffff,-0x7feed808(%eax)
80106df1:	ff 00 00 
80106df4:	c7 80 fc 27 11 80 00 	movl   $0xcf9a00,-0x7feed804(%eax)
80106dfb:	9a cf 00 
80106dfe:	c7 80 00 28 11 80 ff 	movl   $0xffff,-0x7feed800(%eax)
80106e05:	ff 00 00 
80106e08:	c7 80 04 28 11 80 00 	movl   $0xcf9200,-0x7feed7fc(%eax)
80106e0f:	92 cf 00 
80106e12:	c7 80 08 28 11 80 ff 	movl   $0xffff,-0x7feed7f8(%eax)
80106e19:	ff 00 00 
80106e1c:	c7 80 0c 28 11 80 00 	movl   $0xcffa00,-0x7feed7f4(%eax)
80106e23:	fa cf 00 
80106e26:	c7 80 10 28 11 80 ff 	movl   $0xffff,-0x7feed7f0(%eax)
80106e2d:	ff 00 00 
80106e30:	c7 80 14 28 11 80 00 	movl   $0xcff200,-0x7feed7ec(%eax)
80106e37:	f2 cf 00 
80106e3a:	05 f0 27 11 80       	add    $0x801127f0,%eax
80106e3f:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
80106e43:	c1 e8 10             	shr    $0x10,%eax
80106e46:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
80106e4a:	8d 45 f2             	lea    -0xe(%ebp),%eax
80106e4d:	0f 01 10             	lgdtl  (%eax)
80106e50:	c9                   	leave  
80106e51:	c3                   	ret    
80106e52:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106e59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106e60 <switchkvm>:
80106e60:	a1 a4 9a 11 80       	mov    0x80119aa4,%eax
80106e65:	55                   	push   %ebp
80106e66:	89 e5                	mov    %esp,%ebp
80106e68:	05 00 00 00 80       	add    $0x80000000,%eax
80106e6d:	0f 22 d8             	mov    %eax,%cr3
80106e70:	5d                   	pop    %ebp
80106e71:	c3                   	ret    
80106e72:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106e79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106e80 <switchuvm>:
80106e80:	55                   	push   %ebp
80106e81:	89 e5                	mov    %esp,%ebp
80106e83:	57                   	push   %edi
80106e84:	56                   	push   %esi
80106e85:	53                   	push   %ebx
80106e86:	83 ec 1c             	sub    $0x1c,%esp
80106e89:	8b 5d 08             	mov    0x8(%ebp),%ebx
80106e8c:	85 db                	test   %ebx,%ebx
80106e8e:	0f 84 cb 00 00 00    	je     80106f5f <switchuvm+0xdf>
80106e94:	8b 43 08             	mov    0x8(%ebx),%eax
80106e97:	85 c0                	test   %eax,%eax
80106e99:	0f 84 da 00 00 00    	je     80106f79 <switchuvm+0xf9>
80106e9f:	8b 43 04             	mov    0x4(%ebx),%eax
80106ea2:	85 c0                	test   %eax,%eax
80106ea4:	0f 84 c2 00 00 00    	je     80106f6c <switchuvm+0xec>
80106eaa:	e8 21 d9 ff ff       	call   801047d0 <pushcli>
80106eaf:	e8 bc c9 ff ff       	call   80103870 <mycpu>
80106eb4:	89 c6                	mov    %eax,%esi
80106eb6:	e8 b5 c9 ff ff       	call   80103870 <mycpu>
80106ebb:	89 c7                	mov    %eax,%edi
80106ebd:	e8 ae c9 ff ff       	call   80103870 <mycpu>
80106ec2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106ec5:	83 c7 08             	add    $0x8,%edi
80106ec8:	e8 a3 c9 ff ff       	call   80103870 <mycpu>
80106ecd:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80106ed0:	83 c0 08             	add    $0x8,%eax
80106ed3:	ba 67 00 00 00       	mov    $0x67,%edx
80106ed8:	c1 e8 18             	shr    $0x18,%eax
80106edb:	66 89 96 98 00 00 00 	mov    %dx,0x98(%esi)
80106ee2:	66 89 be 9a 00 00 00 	mov    %di,0x9a(%esi)
80106ee9:	88 86 9f 00 00 00    	mov    %al,0x9f(%esi)
80106eef:	bf ff ff ff ff       	mov    $0xffffffff,%edi
80106ef4:	83 c1 08             	add    $0x8,%ecx
80106ef7:	c1 e9 10             	shr    $0x10,%ecx
80106efa:	88 8e 9c 00 00 00    	mov    %cl,0x9c(%esi)
80106f00:	b9 99 40 00 00       	mov    $0x4099,%ecx
80106f05:	66 89 8e 9d 00 00 00 	mov    %cx,0x9d(%esi)
80106f0c:	be 10 00 00 00       	mov    $0x10,%esi
80106f11:	e8 5a c9 ff ff       	call   80103870 <mycpu>
80106f16:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
80106f1d:	e8 4e c9 ff ff       	call   80103870 <mycpu>
80106f22:	66 89 70 10          	mov    %si,0x10(%eax)
80106f26:	8b 73 08             	mov    0x8(%ebx),%esi
80106f29:	e8 42 c9 ff ff       	call   80103870 <mycpu>
80106f2e:	81 c6 00 10 00 00    	add    $0x1000,%esi
80106f34:	89 70 0c             	mov    %esi,0xc(%eax)
80106f37:	e8 34 c9 ff ff       	call   80103870 <mycpu>
80106f3c:	66 89 78 6e          	mov    %di,0x6e(%eax)
80106f40:	b8 28 00 00 00       	mov    $0x28,%eax
80106f45:	0f 00 d8             	ltr    %ax
80106f48:	8b 43 04             	mov    0x4(%ebx),%eax
80106f4b:	05 00 00 00 80       	add    $0x80000000,%eax
80106f50:	0f 22 d8             	mov    %eax,%cr3
80106f53:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106f56:	5b                   	pop    %ebx
80106f57:	5e                   	pop    %esi
80106f58:	5f                   	pop    %edi
80106f59:	5d                   	pop    %ebp
80106f5a:	e9 b1 d8 ff ff       	jmp    80104810 <popcli>
80106f5f:	83 ec 0c             	sub    $0xc,%esp
80106f62:	68 1a 7e 10 80       	push   $0x80107e1a
80106f67:	e8 24 94 ff ff       	call   80100390 <panic>
80106f6c:	83 ec 0c             	sub    $0xc,%esp
80106f6f:	68 45 7e 10 80       	push   $0x80107e45
80106f74:	e8 17 94 ff ff       	call   80100390 <panic>
80106f79:	83 ec 0c             	sub    $0xc,%esp
80106f7c:	68 30 7e 10 80       	push   $0x80107e30
80106f81:	e8 0a 94 ff ff       	call   80100390 <panic>
80106f86:	8d 76 00             	lea    0x0(%esi),%esi
80106f89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106f90 <inituvm>:
80106f90:	55                   	push   %ebp
80106f91:	89 e5                	mov    %esp,%ebp
80106f93:	57                   	push   %edi
80106f94:	56                   	push   %esi
80106f95:	53                   	push   %ebx
80106f96:	83 ec 1c             	sub    $0x1c,%esp
80106f99:	8b 75 10             	mov    0x10(%ebp),%esi
80106f9c:	8b 45 08             	mov    0x8(%ebp),%eax
80106f9f:	8b 7d 0c             	mov    0xc(%ebp),%edi
80106fa2:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
80106fa8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106fab:	77 49                	ja     80106ff6 <inituvm+0x66>
80106fad:	e8 3e b5 ff ff       	call   801024f0 <kalloc>
80106fb2:	83 ec 04             	sub    $0x4,%esp
80106fb5:	89 c3                	mov    %eax,%ebx
80106fb7:	68 00 10 00 00       	push   $0x1000
80106fbc:	6a 00                	push   $0x0
80106fbe:	50                   	push   %eax
80106fbf:	e8 ec d9 ff ff       	call   801049b0 <memset>
80106fc4:	58                   	pop    %eax
80106fc5:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106fcb:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106fd0:	5a                   	pop    %edx
80106fd1:	6a 06                	push   $0x6
80106fd3:	50                   	push   %eax
80106fd4:	31 d2                	xor    %edx,%edx
80106fd6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106fd9:	e8 c2 fc ff ff       	call   80106ca0 <mappages>
80106fde:	89 75 10             	mov    %esi,0x10(%ebp)
80106fe1:	89 7d 0c             	mov    %edi,0xc(%ebp)
80106fe4:	83 c4 10             	add    $0x10,%esp
80106fe7:	89 5d 08             	mov    %ebx,0x8(%ebp)
80106fea:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106fed:	5b                   	pop    %ebx
80106fee:	5e                   	pop    %esi
80106fef:	5f                   	pop    %edi
80106ff0:	5d                   	pop    %ebp
80106ff1:	e9 6a da ff ff       	jmp    80104a60 <memmove>
80106ff6:	83 ec 0c             	sub    $0xc,%esp
80106ff9:	68 59 7e 10 80       	push   $0x80107e59
80106ffe:	e8 8d 93 ff ff       	call   80100390 <panic>
80107003:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107009:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107010 <loaduvm>:
80107010:	55                   	push   %ebp
80107011:	89 e5                	mov    %esp,%ebp
80107013:	57                   	push   %edi
80107014:	56                   	push   %esi
80107015:	53                   	push   %ebx
80107016:	83 ec 0c             	sub    $0xc,%esp
80107019:	f7 45 0c ff 0f 00 00 	testl  $0xfff,0xc(%ebp)
80107020:	0f 85 91 00 00 00    	jne    801070b7 <loaduvm+0xa7>
80107026:	8b 75 18             	mov    0x18(%ebp),%esi
80107029:	31 db                	xor    %ebx,%ebx
8010702b:	85 f6                	test   %esi,%esi
8010702d:	75 1a                	jne    80107049 <loaduvm+0x39>
8010702f:	eb 6f                	jmp    801070a0 <loaduvm+0x90>
80107031:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107038:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010703e:	81 ee 00 10 00 00    	sub    $0x1000,%esi
80107044:	39 5d 18             	cmp    %ebx,0x18(%ebp)
80107047:	76 57                	jbe    801070a0 <loaduvm+0x90>
80107049:	8b 55 0c             	mov    0xc(%ebp),%edx
8010704c:	8b 45 08             	mov    0x8(%ebp),%eax
8010704f:	31 c9                	xor    %ecx,%ecx
80107051:	01 da                	add    %ebx,%edx
80107053:	e8 c8 fb ff ff       	call   80106c20 <walkpgdir>
80107058:	85 c0                	test   %eax,%eax
8010705a:	74 4e                	je     801070aa <loaduvm+0x9a>
8010705c:	8b 00                	mov    (%eax),%eax
8010705e:	8b 4d 14             	mov    0x14(%ebp),%ecx
80107061:	bf 00 10 00 00       	mov    $0x1000,%edi
80107066:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010706b:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
80107071:	0f 46 fe             	cmovbe %esi,%edi
80107074:	01 d9                	add    %ebx,%ecx
80107076:	05 00 00 00 80       	add    $0x80000000,%eax
8010707b:	57                   	push   %edi
8010707c:	51                   	push   %ecx
8010707d:	50                   	push   %eax
8010707e:	ff 75 10             	pushl  0x10(%ebp)
80107081:	e8 0a a9 ff ff       	call   80101990 <readi>
80107086:	83 c4 10             	add    $0x10,%esp
80107089:	39 f8                	cmp    %edi,%eax
8010708b:	74 ab                	je     80107038 <loaduvm+0x28>
8010708d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107090:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107095:	5b                   	pop    %ebx
80107096:	5e                   	pop    %esi
80107097:	5f                   	pop    %edi
80107098:	5d                   	pop    %ebp
80107099:	c3                   	ret    
8010709a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801070a0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801070a3:	31 c0                	xor    %eax,%eax
801070a5:	5b                   	pop    %ebx
801070a6:	5e                   	pop    %esi
801070a7:	5f                   	pop    %edi
801070a8:	5d                   	pop    %ebp
801070a9:	c3                   	ret    
801070aa:	83 ec 0c             	sub    $0xc,%esp
801070ad:	68 73 7e 10 80       	push   $0x80107e73
801070b2:	e8 d9 92 ff ff       	call   80100390 <panic>
801070b7:	83 ec 0c             	sub    $0xc,%esp
801070ba:	68 14 7f 10 80       	push   $0x80107f14
801070bf:	e8 cc 92 ff ff       	call   80100390 <panic>
801070c4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801070ca:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801070d0 <allocuvm>:
801070d0:	55                   	push   %ebp
801070d1:	89 e5                	mov    %esp,%ebp
801070d3:	57                   	push   %edi
801070d4:	56                   	push   %esi
801070d5:	53                   	push   %ebx
801070d6:	83 ec 1c             	sub    $0x1c,%esp
801070d9:	8b 7d 10             	mov    0x10(%ebp),%edi
801070dc:	85 ff                	test   %edi,%edi
801070de:	0f 88 8e 00 00 00    	js     80107172 <allocuvm+0xa2>
801070e4:	3b 7d 0c             	cmp    0xc(%ebp),%edi
801070e7:	0f 82 93 00 00 00    	jb     80107180 <allocuvm+0xb0>
801070ed:	8b 45 0c             	mov    0xc(%ebp),%eax
801070f0:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801070f6:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
801070fc:	39 5d 10             	cmp    %ebx,0x10(%ebp)
801070ff:	0f 86 7e 00 00 00    	jbe    80107183 <allocuvm+0xb3>
80107105:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80107108:	8b 7d 08             	mov    0x8(%ebp),%edi
8010710b:	eb 42                	jmp    8010714f <allocuvm+0x7f>
8010710d:	8d 76 00             	lea    0x0(%esi),%esi
80107110:	83 ec 04             	sub    $0x4,%esp
80107113:	68 00 10 00 00       	push   $0x1000
80107118:	6a 00                	push   $0x0
8010711a:	50                   	push   %eax
8010711b:	e8 90 d8 ff ff       	call   801049b0 <memset>
80107120:	58                   	pop    %eax
80107121:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80107127:	b9 00 10 00 00       	mov    $0x1000,%ecx
8010712c:	5a                   	pop    %edx
8010712d:	6a 06                	push   $0x6
8010712f:	50                   	push   %eax
80107130:	89 da                	mov    %ebx,%edx
80107132:	89 f8                	mov    %edi,%eax
80107134:	e8 67 fb ff ff       	call   80106ca0 <mappages>
80107139:	83 c4 10             	add    $0x10,%esp
8010713c:	85 c0                	test   %eax,%eax
8010713e:	78 50                	js     80107190 <allocuvm+0xc0>
80107140:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80107146:	39 5d 10             	cmp    %ebx,0x10(%ebp)
80107149:	0f 86 81 00 00 00    	jbe    801071d0 <allocuvm+0x100>
8010714f:	e8 9c b3 ff ff       	call   801024f0 <kalloc>
80107154:	85 c0                	test   %eax,%eax
80107156:	89 c6                	mov    %eax,%esi
80107158:	75 b6                	jne    80107110 <allocuvm+0x40>
8010715a:	83 ec 0c             	sub    $0xc,%esp
8010715d:	68 91 7e 10 80       	push   $0x80107e91
80107162:	e8 f9 94 ff ff       	call   80100660 <cprintf>
80107167:	83 c4 10             	add    $0x10,%esp
8010716a:	8b 45 0c             	mov    0xc(%ebp),%eax
8010716d:	39 45 10             	cmp    %eax,0x10(%ebp)
80107170:	77 6e                	ja     801071e0 <allocuvm+0x110>
80107172:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107175:	31 ff                	xor    %edi,%edi
80107177:	89 f8                	mov    %edi,%eax
80107179:	5b                   	pop    %ebx
8010717a:	5e                   	pop    %esi
8010717b:	5f                   	pop    %edi
8010717c:	5d                   	pop    %ebp
8010717d:	c3                   	ret    
8010717e:	66 90                	xchg   %ax,%ax
80107180:	8b 7d 0c             	mov    0xc(%ebp),%edi
80107183:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107186:	89 f8                	mov    %edi,%eax
80107188:	5b                   	pop    %ebx
80107189:	5e                   	pop    %esi
8010718a:	5f                   	pop    %edi
8010718b:	5d                   	pop    %ebp
8010718c:	c3                   	ret    
8010718d:	8d 76 00             	lea    0x0(%esi),%esi
80107190:	83 ec 0c             	sub    $0xc,%esp
80107193:	68 a9 7e 10 80       	push   $0x80107ea9
80107198:	e8 c3 94 ff ff       	call   80100660 <cprintf>
8010719d:	83 c4 10             	add    $0x10,%esp
801071a0:	8b 45 0c             	mov    0xc(%ebp),%eax
801071a3:	39 45 10             	cmp    %eax,0x10(%ebp)
801071a6:	76 0d                	jbe    801071b5 <allocuvm+0xe5>
801071a8:	89 c1                	mov    %eax,%ecx
801071aa:	8b 55 10             	mov    0x10(%ebp),%edx
801071ad:	8b 45 08             	mov    0x8(%ebp),%eax
801071b0:	e8 7b fb ff ff       	call   80106d30 <deallocuvm.part.0>
801071b5:	83 ec 0c             	sub    $0xc,%esp
801071b8:	31 ff                	xor    %edi,%edi
801071ba:	56                   	push   %esi
801071bb:	e8 80 b1 ff ff       	call   80102340 <kfree>
801071c0:	83 c4 10             	add    $0x10,%esp
801071c3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801071c6:	89 f8                	mov    %edi,%eax
801071c8:	5b                   	pop    %ebx
801071c9:	5e                   	pop    %esi
801071ca:	5f                   	pop    %edi
801071cb:	5d                   	pop    %ebp
801071cc:	c3                   	ret    
801071cd:	8d 76 00             	lea    0x0(%esi),%esi
801071d0:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801071d3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801071d6:	5b                   	pop    %ebx
801071d7:	89 f8                	mov    %edi,%eax
801071d9:	5e                   	pop    %esi
801071da:	5f                   	pop    %edi
801071db:	5d                   	pop    %ebp
801071dc:	c3                   	ret    
801071dd:	8d 76 00             	lea    0x0(%esi),%esi
801071e0:	89 c1                	mov    %eax,%ecx
801071e2:	8b 55 10             	mov    0x10(%ebp),%edx
801071e5:	8b 45 08             	mov    0x8(%ebp),%eax
801071e8:	31 ff                	xor    %edi,%edi
801071ea:	e8 41 fb ff ff       	call   80106d30 <deallocuvm.part.0>
801071ef:	eb 92                	jmp    80107183 <allocuvm+0xb3>
801071f1:	eb 0d                	jmp    80107200 <deallocuvm>
801071f3:	90                   	nop
801071f4:	90                   	nop
801071f5:	90                   	nop
801071f6:	90                   	nop
801071f7:	90                   	nop
801071f8:	90                   	nop
801071f9:	90                   	nop
801071fa:	90                   	nop
801071fb:	90                   	nop
801071fc:	90                   	nop
801071fd:	90                   	nop
801071fe:	90                   	nop
801071ff:	90                   	nop

80107200 <deallocuvm>:
80107200:	55                   	push   %ebp
80107201:	89 e5                	mov    %esp,%ebp
80107203:	8b 55 0c             	mov    0xc(%ebp),%edx
80107206:	8b 4d 10             	mov    0x10(%ebp),%ecx
80107209:	8b 45 08             	mov    0x8(%ebp),%eax
8010720c:	39 d1                	cmp    %edx,%ecx
8010720e:	73 10                	jae    80107220 <deallocuvm+0x20>
80107210:	5d                   	pop    %ebp
80107211:	e9 1a fb ff ff       	jmp    80106d30 <deallocuvm.part.0>
80107216:	8d 76 00             	lea    0x0(%esi),%esi
80107219:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80107220:	89 d0                	mov    %edx,%eax
80107222:	5d                   	pop    %ebp
80107223:	c3                   	ret    
80107224:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010722a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80107230 <freevm>:
80107230:	55                   	push   %ebp
80107231:	89 e5                	mov    %esp,%ebp
80107233:	57                   	push   %edi
80107234:	56                   	push   %esi
80107235:	53                   	push   %ebx
80107236:	83 ec 0c             	sub    $0xc,%esp
80107239:	8b 75 08             	mov    0x8(%ebp),%esi
8010723c:	85 f6                	test   %esi,%esi
8010723e:	74 59                	je     80107299 <freevm+0x69>
80107240:	31 c9                	xor    %ecx,%ecx
80107242:	ba 00 00 00 80       	mov    $0x80000000,%edx
80107247:	89 f0                	mov    %esi,%eax
80107249:	e8 e2 fa ff ff       	call   80106d30 <deallocuvm.part.0>
8010724e:	89 f3                	mov    %esi,%ebx
80107250:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80107256:	eb 0f                	jmp    80107267 <freevm+0x37>
80107258:	90                   	nop
80107259:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107260:	83 c3 04             	add    $0x4,%ebx
80107263:	39 fb                	cmp    %edi,%ebx
80107265:	74 23                	je     8010728a <freevm+0x5a>
80107267:	8b 03                	mov    (%ebx),%eax
80107269:	a8 01                	test   $0x1,%al
8010726b:	74 f3                	je     80107260 <freevm+0x30>
8010726d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107272:	83 ec 0c             	sub    $0xc,%esp
80107275:	83 c3 04             	add    $0x4,%ebx
80107278:	05 00 00 00 80       	add    $0x80000000,%eax
8010727d:	50                   	push   %eax
8010727e:	e8 bd b0 ff ff       	call   80102340 <kfree>
80107283:	83 c4 10             	add    $0x10,%esp
80107286:	39 fb                	cmp    %edi,%ebx
80107288:	75 dd                	jne    80107267 <freevm+0x37>
8010728a:	89 75 08             	mov    %esi,0x8(%ebp)
8010728d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107290:	5b                   	pop    %ebx
80107291:	5e                   	pop    %esi
80107292:	5f                   	pop    %edi
80107293:	5d                   	pop    %ebp
80107294:	e9 a7 b0 ff ff       	jmp    80102340 <kfree>
80107299:	83 ec 0c             	sub    $0xc,%esp
8010729c:	68 c5 7e 10 80       	push   $0x80107ec5
801072a1:	e8 ea 90 ff ff       	call   80100390 <panic>
801072a6:	8d 76 00             	lea    0x0(%esi),%esi
801072a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801072b0 <setupkvm>:
801072b0:	55                   	push   %ebp
801072b1:	89 e5                	mov    %esp,%ebp
801072b3:	56                   	push   %esi
801072b4:	53                   	push   %ebx
801072b5:	e8 36 b2 ff ff       	call   801024f0 <kalloc>
801072ba:	85 c0                	test   %eax,%eax
801072bc:	89 c6                	mov    %eax,%esi
801072be:	74 42                	je     80107302 <setupkvm+0x52>
801072c0:	83 ec 04             	sub    $0x4,%esp
801072c3:	bb 20 a4 10 80       	mov    $0x8010a420,%ebx
801072c8:	68 00 10 00 00       	push   $0x1000
801072cd:	6a 00                	push   $0x0
801072cf:	50                   	push   %eax
801072d0:	e8 db d6 ff ff       	call   801049b0 <memset>
801072d5:	83 c4 10             	add    $0x10,%esp
801072d8:	8b 43 04             	mov    0x4(%ebx),%eax
801072db:	8b 4b 08             	mov    0x8(%ebx),%ecx
801072de:	83 ec 08             	sub    $0x8,%esp
801072e1:	8b 13                	mov    (%ebx),%edx
801072e3:	ff 73 0c             	pushl  0xc(%ebx)
801072e6:	50                   	push   %eax
801072e7:	29 c1                	sub    %eax,%ecx
801072e9:	89 f0                	mov    %esi,%eax
801072eb:	e8 b0 f9 ff ff       	call   80106ca0 <mappages>
801072f0:	83 c4 10             	add    $0x10,%esp
801072f3:	85 c0                	test   %eax,%eax
801072f5:	78 19                	js     80107310 <setupkvm+0x60>
801072f7:	83 c3 10             	add    $0x10,%ebx
801072fa:	81 fb 60 a4 10 80    	cmp    $0x8010a460,%ebx
80107300:	75 d6                	jne    801072d8 <setupkvm+0x28>
80107302:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107305:	89 f0                	mov    %esi,%eax
80107307:	5b                   	pop    %ebx
80107308:	5e                   	pop    %esi
80107309:	5d                   	pop    %ebp
8010730a:	c3                   	ret    
8010730b:	90                   	nop
8010730c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107310:	83 ec 0c             	sub    $0xc,%esp
80107313:	56                   	push   %esi
80107314:	31 f6                	xor    %esi,%esi
80107316:	e8 15 ff ff ff       	call   80107230 <freevm>
8010731b:	83 c4 10             	add    $0x10,%esp
8010731e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107321:	89 f0                	mov    %esi,%eax
80107323:	5b                   	pop    %ebx
80107324:	5e                   	pop    %esi
80107325:	5d                   	pop    %ebp
80107326:	c3                   	ret    
80107327:	89 f6                	mov    %esi,%esi
80107329:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107330 <kvmalloc>:
80107330:	55                   	push   %ebp
80107331:	89 e5                	mov    %esp,%ebp
80107333:	83 ec 08             	sub    $0x8,%esp
80107336:	e8 75 ff ff ff       	call   801072b0 <setupkvm>
8010733b:	a3 a4 9a 11 80       	mov    %eax,0x80119aa4
80107340:	05 00 00 00 80       	add    $0x80000000,%eax
80107345:	0f 22 d8             	mov    %eax,%cr3
80107348:	c9                   	leave  
80107349:	c3                   	ret    
8010734a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107350 <clearpteu>:
80107350:	55                   	push   %ebp
80107351:	31 c9                	xor    %ecx,%ecx
80107353:	89 e5                	mov    %esp,%ebp
80107355:	83 ec 08             	sub    $0x8,%esp
80107358:	8b 55 0c             	mov    0xc(%ebp),%edx
8010735b:	8b 45 08             	mov    0x8(%ebp),%eax
8010735e:	e8 bd f8 ff ff       	call   80106c20 <walkpgdir>
80107363:	85 c0                	test   %eax,%eax
80107365:	74 05                	je     8010736c <clearpteu+0x1c>
80107367:	83 20 fb             	andl   $0xfffffffb,(%eax)
8010736a:	c9                   	leave  
8010736b:	c3                   	ret    
8010736c:	83 ec 0c             	sub    $0xc,%esp
8010736f:	68 d6 7e 10 80       	push   $0x80107ed6
80107374:	e8 17 90 ff ff       	call   80100390 <panic>
80107379:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107380 <copyuvm>:
80107380:	55                   	push   %ebp
80107381:	89 e5                	mov    %esp,%ebp
80107383:	57                   	push   %edi
80107384:	56                   	push   %esi
80107385:	53                   	push   %ebx
80107386:	83 ec 1c             	sub    $0x1c,%esp
80107389:	e8 22 ff ff ff       	call   801072b0 <setupkvm>
8010738e:	85 c0                	test   %eax,%eax
80107390:	89 45 e0             	mov    %eax,-0x20(%ebp)
80107393:	0f 84 9f 00 00 00    	je     80107438 <copyuvm+0xb8>
80107399:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010739c:	85 c9                	test   %ecx,%ecx
8010739e:	0f 84 94 00 00 00    	je     80107438 <copyuvm+0xb8>
801073a4:	31 ff                	xor    %edi,%edi
801073a6:	eb 4a                	jmp    801073f2 <copyuvm+0x72>
801073a8:	90                   	nop
801073a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801073b0:	83 ec 04             	sub    $0x4,%esp
801073b3:	81 c3 00 00 00 80    	add    $0x80000000,%ebx
801073b9:	68 00 10 00 00       	push   $0x1000
801073be:	53                   	push   %ebx
801073bf:	50                   	push   %eax
801073c0:	e8 9b d6 ff ff       	call   80104a60 <memmove>
801073c5:	58                   	pop    %eax
801073c6:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
801073cc:	b9 00 10 00 00       	mov    $0x1000,%ecx
801073d1:	5a                   	pop    %edx
801073d2:	ff 75 e4             	pushl  -0x1c(%ebp)
801073d5:	50                   	push   %eax
801073d6:	89 fa                	mov    %edi,%edx
801073d8:	8b 45 e0             	mov    -0x20(%ebp),%eax
801073db:	e8 c0 f8 ff ff       	call   80106ca0 <mappages>
801073e0:	83 c4 10             	add    $0x10,%esp
801073e3:	85 c0                	test   %eax,%eax
801073e5:	78 61                	js     80107448 <copyuvm+0xc8>
801073e7:	81 c7 00 10 00 00    	add    $0x1000,%edi
801073ed:	39 7d 0c             	cmp    %edi,0xc(%ebp)
801073f0:	76 46                	jbe    80107438 <copyuvm+0xb8>
801073f2:	8b 45 08             	mov    0x8(%ebp),%eax
801073f5:	31 c9                	xor    %ecx,%ecx
801073f7:	89 fa                	mov    %edi,%edx
801073f9:	e8 22 f8 ff ff       	call   80106c20 <walkpgdir>
801073fe:	85 c0                	test   %eax,%eax
80107400:	74 61                	je     80107463 <copyuvm+0xe3>
80107402:	8b 00                	mov    (%eax),%eax
80107404:	a8 01                	test   $0x1,%al
80107406:	74 4e                	je     80107456 <copyuvm+0xd6>
80107408:	89 c3                	mov    %eax,%ebx
8010740a:	25 ff 0f 00 00       	and    $0xfff,%eax
8010740f:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
80107415:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107418:	e8 d3 b0 ff ff       	call   801024f0 <kalloc>
8010741d:	85 c0                	test   %eax,%eax
8010741f:	89 c6                	mov    %eax,%esi
80107421:	75 8d                	jne    801073b0 <copyuvm+0x30>
80107423:	83 ec 0c             	sub    $0xc,%esp
80107426:	ff 75 e0             	pushl  -0x20(%ebp)
80107429:	e8 02 fe ff ff       	call   80107230 <freevm>
8010742e:	83 c4 10             	add    $0x10,%esp
80107431:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
80107438:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010743b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010743e:	5b                   	pop    %ebx
8010743f:	5e                   	pop    %esi
80107440:	5f                   	pop    %edi
80107441:	5d                   	pop    %ebp
80107442:	c3                   	ret    
80107443:	90                   	nop
80107444:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107448:	83 ec 0c             	sub    $0xc,%esp
8010744b:	56                   	push   %esi
8010744c:	e8 ef ae ff ff       	call   80102340 <kfree>
80107451:	83 c4 10             	add    $0x10,%esp
80107454:	eb cd                	jmp    80107423 <copyuvm+0xa3>
80107456:	83 ec 0c             	sub    $0xc,%esp
80107459:	68 fa 7e 10 80       	push   $0x80107efa
8010745e:	e8 2d 8f ff ff       	call   80100390 <panic>
80107463:	83 ec 0c             	sub    $0xc,%esp
80107466:	68 e0 7e 10 80       	push   $0x80107ee0
8010746b:	e8 20 8f ff ff       	call   80100390 <panic>

80107470 <uva2ka>:
80107470:	55                   	push   %ebp
80107471:	31 c9                	xor    %ecx,%ecx
80107473:	89 e5                	mov    %esp,%ebp
80107475:	83 ec 08             	sub    $0x8,%esp
80107478:	8b 55 0c             	mov    0xc(%ebp),%edx
8010747b:	8b 45 08             	mov    0x8(%ebp),%eax
8010747e:	e8 9d f7 ff ff       	call   80106c20 <walkpgdir>
80107483:	8b 00                	mov    (%eax),%eax
80107485:	c9                   	leave  
80107486:	89 c2                	mov    %eax,%edx
80107488:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010748d:	83 e2 05             	and    $0x5,%edx
80107490:	05 00 00 00 80       	add    $0x80000000,%eax
80107495:	83 fa 05             	cmp    $0x5,%edx
80107498:	ba 00 00 00 00       	mov    $0x0,%edx
8010749d:	0f 45 c2             	cmovne %edx,%eax
801074a0:	c3                   	ret    
801074a1:	eb 0d                	jmp    801074b0 <copyout>
801074a3:	90                   	nop
801074a4:	90                   	nop
801074a5:	90                   	nop
801074a6:	90                   	nop
801074a7:	90                   	nop
801074a8:	90                   	nop
801074a9:	90                   	nop
801074aa:	90                   	nop
801074ab:	90                   	nop
801074ac:	90                   	nop
801074ad:	90                   	nop
801074ae:	90                   	nop
801074af:	90                   	nop

801074b0 <copyout>:
801074b0:	55                   	push   %ebp
801074b1:	89 e5                	mov    %esp,%ebp
801074b3:	57                   	push   %edi
801074b4:	56                   	push   %esi
801074b5:	53                   	push   %ebx
801074b6:	83 ec 1c             	sub    $0x1c,%esp
801074b9:	8b 5d 14             	mov    0x14(%ebp),%ebx
801074bc:	8b 55 0c             	mov    0xc(%ebp),%edx
801074bf:	8b 7d 10             	mov    0x10(%ebp),%edi
801074c2:	85 db                	test   %ebx,%ebx
801074c4:	75 40                	jne    80107506 <copyout+0x56>
801074c6:	eb 70                	jmp    80107538 <copyout+0x88>
801074c8:	90                   	nop
801074c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801074d0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801074d3:	89 f1                	mov    %esi,%ecx
801074d5:	29 d1                	sub    %edx,%ecx
801074d7:	81 c1 00 10 00 00    	add    $0x1000,%ecx
801074dd:	39 d9                	cmp    %ebx,%ecx
801074df:	0f 47 cb             	cmova  %ebx,%ecx
801074e2:	29 f2                	sub    %esi,%edx
801074e4:	83 ec 04             	sub    $0x4,%esp
801074e7:	01 d0                	add    %edx,%eax
801074e9:	51                   	push   %ecx
801074ea:	57                   	push   %edi
801074eb:	50                   	push   %eax
801074ec:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
801074ef:	e8 6c d5 ff ff       	call   80104a60 <memmove>
801074f4:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801074f7:	83 c4 10             	add    $0x10,%esp
801074fa:	8d 96 00 10 00 00    	lea    0x1000(%esi),%edx
80107500:	01 cf                	add    %ecx,%edi
80107502:	29 cb                	sub    %ecx,%ebx
80107504:	74 32                	je     80107538 <copyout+0x88>
80107506:	89 d6                	mov    %edx,%esi
80107508:	83 ec 08             	sub    $0x8,%esp
8010750b:	89 55 e4             	mov    %edx,-0x1c(%ebp)
8010750e:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
80107514:	56                   	push   %esi
80107515:	ff 75 08             	pushl  0x8(%ebp)
80107518:	e8 53 ff ff ff       	call   80107470 <uva2ka>
8010751d:	83 c4 10             	add    $0x10,%esp
80107520:	85 c0                	test   %eax,%eax
80107522:	75 ac                	jne    801074d0 <copyout+0x20>
80107524:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107527:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010752c:	5b                   	pop    %ebx
8010752d:	5e                   	pop    %esi
8010752e:	5f                   	pop    %edi
8010752f:	5d                   	pop    %ebp
80107530:	c3                   	ret    
80107531:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107538:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010753b:	31 c0                	xor    %eax,%eax
8010753d:	5b                   	pop    %ebx
8010753e:	5e                   	pop    %esi
8010753f:	5f                   	pop    %edi
80107540:	5d                   	pop    %ebp
80107541:	c3                   	ret    
