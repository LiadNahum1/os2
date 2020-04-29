
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
8010004c:	68 60 73 10 80       	push   $0x80107360
80100051:	68 c0 b5 10 80       	push   $0x8010b5c0
80100056:	e8 75 45 00 00       	call   801045d0 <initlock>
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
80100092:	68 67 73 10 80       	push   $0x80107367
80100097:	50                   	push   %eax
80100098:	e8 03 44 00 00       	call   801044a0 <initsleeplock>
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
801000e4:	e8 27 46 00 00       	call   80104710 <acquire>
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
80100162:	e8 69 46 00 00       	call   801047d0 <release>
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 6e 43 00 00       	call   801044e0 <acquiresleep>
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
80100193:	68 6e 73 10 80       	push   $0x8010736e
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
801001ae:	e8 cd 43 00 00       	call   80104580 <holdingsleep>
801001b3:	83 c4 10             	add    $0x10,%esp
801001b6:	85 c0                	test   %eax,%eax
801001b8:	74 0f                	je     801001c9 <bwrite+0x29>
801001ba:	83 0b 04             	orl    $0x4,(%ebx)
801001bd:	89 5d 08             	mov    %ebx,0x8(%ebp)
801001c0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801001c3:	c9                   	leave  
801001c4:	e9 87 1f 00 00       	jmp    80102150 <iderw>
801001c9:	83 ec 0c             	sub    $0xc,%esp
801001cc:	68 7f 73 10 80       	push   $0x8010737f
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
801001ef:	e8 8c 43 00 00       	call   80104580 <holdingsleep>
801001f4:	83 c4 10             	add    $0x10,%esp
801001f7:	85 c0                	test   %eax,%eax
801001f9:	74 66                	je     80100261 <brelse+0x81>
801001fb:	83 ec 0c             	sub    $0xc,%esp
801001fe:	56                   	push   %esi
801001ff:	e8 3c 43 00 00       	call   80104540 <releasesleep>
80100204:	c7 04 24 c0 b5 10 80 	movl   $0x8010b5c0,(%esp)
8010020b:	e8 00 45 00 00       	call   80104710 <acquire>
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
8010025c:	e9 6f 45 00 00       	jmp    801047d0 <release>
80100261:	83 ec 0c             	sub    $0xc,%esp
80100264:	68 86 73 10 80       	push   $0x80107386
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
8010028c:	e8 7f 44 00 00       	call   80104710 <acquire>
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
801002c5:	e8 d6 3b 00 00       	call   80103ea0 <sleep>
    while(input.r == input.w){
801002ca:	8b 15 a0 ff 10 80    	mov    0x8010ffa0,%edx
801002d0:	83 c4 10             	add    $0x10,%esp
801002d3:	3b 15 a4 ff 10 80    	cmp    0x8010ffa4,%edx
801002d9:	75 35                	jne    80100310 <consoleread+0xa0>
      if(myproc()->killed){
801002db:	e8 a0 35 00 00       	call   80103880 <myproc>
801002e0:	8b 40 24             	mov    0x24(%eax),%eax
801002e3:	85 c0                	test   %eax,%eax
801002e5:	74 d1                	je     801002b8 <consoleread+0x48>
        release(&cons.lock);
801002e7:	83 ec 0c             	sub    $0xc,%esp
801002ea:	68 20 a5 10 80       	push   $0x8010a520
801002ef:	e8 dc 44 00 00       	call   801047d0 <release>
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
8010034d:	e8 7e 44 00 00       	call   801047d0 <release>
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
801003b2:	68 8d 73 10 80       	push   $0x8010738d
801003b7:	e8 a4 02 00 00       	call   80100660 <cprintf>
  cprintf(s);
801003bc:	58                   	pop    %eax
801003bd:	ff 75 08             	pushl  0x8(%ebp)
801003c0:	e8 9b 02 00 00       	call   80100660 <cprintf>
  cprintf("\n");
801003c5:	c7 04 24 e3 7c 10 80 	movl   $0x80107ce3,(%esp)
801003cc:	e8 8f 02 00 00       	call   80100660 <cprintf>
  getcallerpcs(&s, pcs);
801003d1:	5a                   	pop    %edx
801003d2:	8d 45 08             	lea    0x8(%ebp),%eax
801003d5:	59                   	pop    %ecx
801003d6:	53                   	push   %ebx
801003d7:	50                   	push   %eax
801003d8:	e8 13 42 00 00       	call   801045f0 <getcallerpcs>
801003dd:	83 c4 10             	add    $0x10,%esp
    cprintf(" %p", pcs[i]);
801003e0:	83 ec 08             	sub    $0x8,%esp
801003e3:	ff 33                	pushl  (%ebx)
801003e5:	83 c3 04             	add    $0x4,%ebx
801003e8:	68 a1 73 10 80       	push   $0x801073a1
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
8010043a:	e8 21 5b 00 00       	call   80105f60 <uartputc>
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
801004ec:	e8 6f 5a 00 00       	call   80105f60 <uartputc>
801004f1:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801004f8:	e8 63 5a 00 00       	call   80105f60 <uartputc>
801004fd:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80100504:	e8 57 5a 00 00       	call   80105f60 <uartputc>
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
80100524:	e8 a7 43 00 00       	call   801048d0 <memmove>
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
80100541:	e8 da 42 00 00       	call   80104820 <memset>
80100546:	83 c4 10             	add    $0x10,%esp
80100549:	e9 5d ff ff ff       	jmp    801004ab <consputc+0x9b>
    panic("pos under/overflow");
8010054e:	83 ec 0c             	sub    $0xc,%esp
80100551:	68 a5 73 10 80       	push   $0x801073a5
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
801005b1:	0f b6 92 d0 73 10 80 	movzbl -0x7fef8c30(%edx),%edx
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
8010061b:	e8 f0 40 00 00       	call   80104710 <acquire>
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
80100647:	e8 84 41 00 00       	call   801047d0 <release>
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
8010071f:	e8 ac 40 00 00       	call   801047d0 <release>
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
801007d0:	ba b8 73 10 80       	mov    $0x801073b8,%edx
      for(; *s; s++)
801007d5:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
801007d8:	b8 28 00 00 00       	mov    $0x28,%eax
801007dd:	89 d3                	mov    %edx,%ebx
801007df:	eb bf                	jmp    801007a0 <cprintf+0x140>
801007e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    acquire(&cons.lock);
801007e8:	83 ec 0c             	sub    $0xc,%esp
801007eb:	68 20 a5 10 80       	push   $0x8010a520
801007f0:	e8 1b 3f 00 00       	call   80104710 <acquire>
801007f5:	83 c4 10             	add    $0x10,%esp
801007f8:	e9 7c fe ff ff       	jmp    80100679 <cprintf+0x19>
    panic("null fmt");
801007fd:	83 ec 0c             	sub    $0xc,%esp
80100800:	68 bf 73 10 80       	push   $0x801073bf
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
80100823:	e8 e8 3e 00 00       	call   80104710 <acquire>
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
80100888:	e8 43 3f 00 00       	call   801047d0 <release>
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
80100916:	e8 45 37 00 00       	call   80104060 <wakeup>
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
80100997:	e9 a4 37 00 00       	jmp    80104140 <procdump>
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
801009c6:	68 c8 73 10 80       	push   $0x801073c8
801009cb:	68 20 a5 10 80       	push   $0x8010a520
801009d0:	e8 fb 3b 00 00       	call   801045d0 <initlock>

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
80100a1c:	e8 5f 2e 00 00       	call   80103880 <myproc>
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
80100a94:	e8 17 66 00 00       	call   801070b0 <setupkvm>
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
80100af6:	e8 d5 63 00 00       	call   80106ed0 <allocuvm>
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
80100b28:	e8 e3 62 00 00       	call   80106e10 <loaduvm>
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
80100b72:	e8 b9 64 00 00       	call   80107030 <freevm>
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
80100baa:	e8 21 63 00 00       	call   80106ed0 <allocuvm>
80100baf:	83 c4 10             	add    $0x10,%esp
80100bb2:	85 c0                	test   %eax,%eax
80100bb4:	89 c6                	mov    %eax,%esi
80100bb6:	75 3a                	jne    80100bf2 <exec+0x1e2>
    freevm(pgdir);
80100bb8:	83 ec 0c             	sub    $0xc,%esp
80100bbb:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100bc1:	e8 6a 64 00 00       	call   80107030 <freevm>
80100bc6:	83 c4 10             	add    $0x10,%esp
  return -1;
80100bc9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100bce:	e9 a9 fe ff ff       	jmp    80100a7c <exec+0x6c>
    end_op();
80100bd3:	e8 68 20 00 00       	call   80102c40 <end_op>
    cprintf("exec: fail\n");
80100bd8:	83 ec 0c             	sub    $0xc,%esp
80100bdb:	68 e1 73 10 80       	push   $0x801073e1
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
80100c06:	e8 45 65 00 00       	call   80107150 <clearpteu>
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
80100c39:	e8 02 3e 00 00       	call   80104a40 <strlen>
80100c3e:	f7 d0                	not    %eax
80100c40:	01 c3                	add    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c42:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c45:	5a                   	pop    %edx
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100c46:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c49:	ff 34 b8             	pushl  (%eax,%edi,4)
80100c4c:	e8 ef 3d 00 00       	call   80104a40 <strlen>
80100c51:	83 c0 01             	add    $0x1,%eax
80100c54:	50                   	push   %eax
80100c55:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c58:	ff 34 b8             	pushl  (%eax,%edi,4)
80100c5b:	53                   	push   %ebx
80100c5c:	56                   	push   %esi
80100c5d:	e8 4e 66 00 00       	call   801072b0 <copyout>
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
80100cc7:	e8 e4 65 00 00       	call   801072b0 <copyout>
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
80100d08:	e8 f3 3c 00 00       	call   80104a00 <safestrcpy>
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
80100d33:	81 c2 08 01 00 00    	add    $0x108,%edx
80100d39:	89 58 44             	mov    %ebx,0x44(%eax)
80100d3c:	89 c8                	mov    %ecx,%eax
80100d3e:	05 88 00 00 00       	add    $0x88,%eax
80100d43:	90                   	nop
80100d44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if ((int)curproc->signal_handlers[i] != SIG_IGN)
80100d48:	83 38 01             	cmpl   $0x1,(%eax)
80100d4b:	74 06                	je     80100d53 <exec+0x343>
      curproc->signal_handlers[i] = SIG_DFL;
80100d4d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80100d53:	83 c0 04             	add    $0x4,%eax
  for(int i=0; i<32; i++){
80100d56:	39 c2                	cmp    %eax,%edx
80100d58:	75 ee                	jne    80100d48 <exec+0x338>
  switchuvm(curproc);
80100d5a:	83 ec 0c             	sub    $0xc,%esp
80100d5d:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100d63:	e8 18 5f 00 00       	call   80106c80 <switchuvm>
  freevm(oldpgdir);
80100d68:	89 3c 24             	mov    %edi,(%esp)
80100d6b:	e8 c0 62 00 00       	call   80107030 <freevm>
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
80100d96:	68 ed 73 10 80       	push   $0x801073ed
80100d9b:	68 c0 ff 10 80       	push   $0x8010ffc0
80100da0:	e8 2b 38 00 00       	call   801045d0 <initlock>
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
80100dc1:	e8 4a 39 00 00       	call   80104710 <acquire>
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
80100df1:	e8 da 39 00 00       	call   801047d0 <release>
80100df6:	89 d8                	mov    %ebx,%eax
80100df8:	83 c4 10             	add    $0x10,%esp
80100dfb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100dfe:	c9                   	leave  
80100dff:	c3                   	ret    
80100e00:	83 ec 0c             	sub    $0xc,%esp
80100e03:	31 db                	xor    %ebx,%ebx
80100e05:	68 c0 ff 10 80       	push   $0x8010ffc0
80100e0a:	e8 c1 39 00 00       	call   801047d0 <release>
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
80100e2f:	e8 dc 38 00 00       	call   80104710 <acquire>
80100e34:	8b 43 04             	mov    0x4(%ebx),%eax
80100e37:	83 c4 10             	add    $0x10,%esp
80100e3a:	85 c0                	test   %eax,%eax
80100e3c:	7e 1a                	jle    80100e58 <filedup+0x38>
80100e3e:	83 c0 01             	add    $0x1,%eax
80100e41:	83 ec 0c             	sub    $0xc,%esp
80100e44:	89 43 04             	mov    %eax,0x4(%ebx)
80100e47:	68 c0 ff 10 80       	push   $0x8010ffc0
80100e4c:	e8 7f 39 00 00       	call   801047d0 <release>
80100e51:	89 d8                	mov    %ebx,%eax
80100e53:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100e56:	c9                   	leave  
80100e57:	c3                   	ret    
80100e58:	83 ec 0c             	sub    $0xc,%esp
80100e5b:	68 f4 73 10 80       	push   $0x801073f4
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
80100e81:	e8 8a 38 00 00       	call   80104710 <acquire>
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
80100eac:	e9 1f 39 00 00       	jmp    801047d0 <release>
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
80100ed8:	e8 f3 38 00 00       	call   801047d0 <release>
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
80100f32:	68 fc 73 10 80       	push   $0x801073fc
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
80101012:	68 06 74 10 80       	push   $0x80107406
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
80101125:	68 0f 74 10 80       	push   $0x8010740f
8010112a:	e8 61 f2 ff ff       	call   80100390 <panic>
8010112f:	83 ec 0c             	sub    $0xc,%esp
80101132:	68 15 74 10 80       	push   $0x80107415
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
801011a3:	68 1f 74 10 80       	push   $0x8010741f
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
80101254:	68 32 74 10 80       	push   $0x80107432
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
80101295:	e8 86 35 00 00       	call   80104820 <memset>
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
801012da:	e8 31 34 00 00       	call   80104710 <acquire>
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
8010133f:	e8 8c 34 00 00       	call   801047d0 <release>

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
8010136d:	e8 5e 34 00 00       	call   801047d0 <release>
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
80101382:	68 48 74 10 80       	push   $0x80107448
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
80101457:	68 58 74 10 80       	push   $0x80107458
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
80101491:	e8 3a 34 00 00       	call   801048d0 <memmove>
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
801014bc:	68 6b 74 10 80       	push   $0x8010746b
801014c1:	68 e0 09 11 80       	push   $0x801109e0
801014c6:	e8 05 31 00 00       	call   801045d0 <initlock>
801014cb:	83 c4 10             	add    $0x10,%esp
801014ce:	66 90                	xchg   %ax,%ax
    initsleeplock(&icache.inode[i].lock, "inode");
801014d0:	83 ec 08             	sub    $0x8,%esp
801014d3:	68 72 74 10 80       	push   $0x80107472
801014d8:	53                   	push   %ebx
801014d9:	81 c3 90 00 00 00    	add    $0x90,%ebx
801014df:	e8 bc 2f 00 00       	call   801044a0 <initsleeplock>
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
80101529:	68 d8 74 10 80       	push   $0x801074d8
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
801015be:	e8 5d 32 00 00       	call   80104820 <memset>
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
801015f3:	68 78 74 10 80       	push   $0x80107478
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
80101661:	e8 6a 32 00 00       	call   801048d0 <memmove>
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
8010168f:	e8 7c 30 00 00       	call   80104710 <acquire>
  ip->ref++;
80101694:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101698:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
8010169f:	e8 2c 31 00 00       	call   801047d0 <release>
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
801016d2:	e8 09 2e 00 00       	call   801044e0 <acquiresleep>
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
80101748:	e8 83 31 00 00       	call   801048d0 <memmove>
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
8010176d:	68 90 74 10 80       	push   $0x80107490
80101772:	e8 19 ec ff ff       	call   80100390 <panic>
    panic("ilock");
80101777:	83 ec 0c             	sub    $0xc,%esp
8010177a:	68 8a 74 10 80       	push   $0x8010748a
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
801017a3:	e8 d8 2d 00 00       	call   80104580 <holdingsleep>
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
801017bf:	e9 7c 2d 00 00       	jmp    80104540 <releasesleep>
    panic("iunlock");
801017c4:	83 ec 0c             	sub    $0xc,%esp
801017c7:	68 9f 74 10 80       	push   $0x8010749f
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
801017f0:	e8 eb 2c 00 00       	call   801044e0 <acquiresleep>
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
8010180a:	e8 31 2d 00 00       	call   80104540 <releasesleep>
  acquire(&icache.lock);
8010180f:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
80101816:	e8 f5 2e 00 00       	call   80104710 <acquire>
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
80101830:	e9 9b 2f 00 00       	jmp    801047d0 <release>
80101835:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&icache.lock);
80101838:	83 ec 0c             	sub    $0xc,%esp
8010183b:	68 e0 09 11 80       	push   $0x801109e0
80101840:	e8 cb 2e 00 00       	call   80104710 <acquire>
    int r = ip->ref;
80101845:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
80101848:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
8010184f:	e8 7c 2f 00 00       	call   801047d0 <release>
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
80101a37:	e8 94 2e 00 00       	call   801048d0 <memmove>
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
80101b33:	e8 98 2d 00 00       	call   801048d0 <memmove>
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
80101bce:	e8 6d 2d 00 00       	call   80104940 <strncmp>
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
80101c2d:	e8 0e 2d 00 00       	call   80104940 <strncmp>
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
80101c72:	68 b9 74 10 80       	push   $0x801074b9
80101c77:	e8 14 e7 ff ff       	call   80100390 <panic>
    panic("dirlookup not DIR");
80101c7c:	83 ec 0c             	sub    $0xc,%esp
80101c7f:	68 a7 74 10 80       	push   $0x801074a7
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
80101ca9:	e8 d2 1b 00 00       	call   80103880 <myproc>
  acquire(&icache.lock);
80101cae:	83 ec 0c             	sub    $0xc,%esp
    ip = idup(myproc()->cwd);
80101cb1:	8b 70 68             	mov    0x68(%eax),%esi
  acquire(&icache.lock);
80101cb4:	68 e0 09 11 80       	push   $0x801109e0
80101cb9:	e8 52 2a 00 00       	call   80104710 <acquire>
  ip->ref++;
80101cbe:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80101cc2:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
80101cc9:	e8 02 2b 00 00       	call   801047d0 <release>
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
80101d25:	e8 a6 2b 00 00       	call   801048d0 <memmove>
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
80101db8:	e8 13 2b 00 00       	call   801048d0 <memmove>
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
80101ead:	e8 ee 2a 00 00       	call   801049a0 <strncpy>
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
80101eeb:	68 c8 74 10 80       	push   $0x801074c8
80101ef0:	e8 9b e4 ff ff       	call   80100390 <panic>
    panic("dirlink");
80101ef5:	83 ec 0c             	sub    $0xc,%esp
80101ef8:	68 ca 7a 10 80       	push   $0x80107aca
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
8010200b:	68 34 75 10 80       	push   $0x80107534
80102010:	e8 7b e3 ff ff       	call   80100390 <panic>
    panic("idestart");
80102015:	83 ec 0c             	sub    $0xc,%esp
80102018:	68 2b 75 10 80       	push   $0x8010752b
8010201d:	e8 6e e3 ff ff       	call   80100390 <panic>
80102022:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102029:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102030 <ideinit>:
{
80102030:	55                   	push   %ebp
80102031:	89 e5                	mov    %esp,%ebp
80102033:	83 ec 10             	sub    $0x10,%esp
  initlock(&idelock, "ide");
80102036:	68 46 75 10 80       	push   $0x80107546
8010203b:	68 80 a5 10 80       	push   $0x8010a580
80102040:	e8 8b 25 00 00       	call   801045d0 <initlock>
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
801020be:	e8 4d 26 00 00       	call   80104710 <acquire>

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
80102121:	e8 3a 1f 00 00       	call   80104060 <wakeup>

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
8010213f:	e8 8c 26 00 00       	call   801047d0 <release>

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
8010215e:	e8 1d 24 00 00       	call   80104580 <holdingsleep>
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
80102198:	e8 73 25 00 00       	call   80104710 <acquire>

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
801021e9:	e8 b2 1c 00 00       	call   80103ea0 <sleep>
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
80102206:	e9 c5 25 00 00       	jmp    801047d0 <release>
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
8010222a:	68 60 75 10 80       	push   $0x80107560
8010222f:	e8 5c e1 ff ff       	call   80100390 <panic>
    panic("iderw: buf not locked");
80102234:	83 ec 0c             	sub    $0xc,%esp
80102237:	68 4a 75 10 80       	push   $0x8010754a
8010223c:	e8 4f e1 ff ff       	call   80100390 <panic>
    panic("iderw: ide disk 1 not present");
80102241:	83 ec 0c             	sub    $0xc,%esp
80102244:	68 75 75 10 80       	push   $0x80107575
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
80102297:	68 94 75 10 80       	push   $0x80107594
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
80102352:	81 fb a8 78 11 80    	cmp    $0x801178a8,%ebx
80102358:	72 68                	jb     801023c2 <kfree+0x82>
8010235a:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80102360:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80102365:	77 5b                	ja     801023c2 <kfree+0x82>
80102367:	83 ec 04             	sub    $0x4,%esp
8010236a:	68 00 10 00 00       	push   $0x1000
8010236f:	6a 01                	push   $0x1
80102371:	53                   	push   %ebx
80102372:	e8 a9 24 00 00       	call   80104820 <memset>
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
801023ab:	e9 20 24 00 00       	jmp    801047d0 <release>
801023b0:	83 ec 0c             	sub    $0xc,%esp
801023b3:	68 40 26 11 80       	push   $0x80112640
801023b8:	e8 53 23 00 00       	call   80104710 <acquire>
801023bd:	83 c4 10             	add    $0x10,%esp
801023c0:	eb c2                	jmp    80102384 <kfree+0x44>
801023c2:	83 ec 0c             	sub    $0xc,%esp
801023c5:	68 c6 75 10 80       	push   $0x801075c6
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
8010242b:	68 cc 75 10 80       	push   $0x801075cc
80102430:	68 40 26 11 80       	push   $0x80112640
80102435:	e8 96 21 00 00       	call   801045d0 <initlock>
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
80102523:	e8 e8 21 00 00       	call   80104710 <acquire>
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
80102551:	e8 7a 22 00 00       	call   801047d0 <release>
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
801025a3:	0f b6 82 00 77 10 80 	movzbl -0x7fef8900(%edx),%eax
801025aa:	09 c1                	or     %eax,%ecx
  shift ^= togglecode[data];
801025ac:	0f b6 82 00 76 10 80 	movzbl -0x7fef8a00(%edx),%eax
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
801025c3:	8b 04 85 e0 75 10 80 	mov    -0x7fef8a20(,%eax,4),%eax
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
801025e8:	0f b6 82 00 77 10 80 	movzbl -0x7fef8900(%edx),%eax
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
80102967:	e8 04 1f 00 00       	call   80104870 <memcmp>
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
80102a94:	e8 37 1e 00 00       	call   801048d0 <memmove>
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
80102b3a:	68 00 78 10 80       	push   $0x80107800
80102b3f:	68 80 26 11 80       	push   $0x80112680
80102b44:	e8 87 1a 00 00       	call   801045d0 <initlock>
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
80102bdb:	e8 30 1b 00 00       	call   80104710 <acquire>
80102be0:	83 c4 10             	add    $0x10,%esp
80102be3:	eb 18                	jmp    80102bfd <begin_op+0x2d>
80102be5:	8d 76 00             	lea    0x0(%esi),%esi
80102be8:	83 ec 08             	sub    $0x8,%esp
80102beb:	68 80 26 11 80       	push   $0x80112680
80102bf0:	68 80 26 11 80       	push   $0x80112680
80102bf5:	e8 a6 12 00 00       	call   80103ea0 <sleep>
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
80102c2c:	e8 9f 1b 00 00       	call   801047d0 <release>
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
80102c4e:	e8 bd 1a 00 00       	call   80104710 <acquire>
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
80102c8c:	e8 3f 1b 00 00       	call   801047d0 <release>
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
80102ce6:	e8 e5 1b 00 00       	call   801048d0 <memmove>
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
80102d2f:	e8 dc 19 00 00       	call   80104710 <acquire>
80102d34:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
80102d3b:	c7 05 c0 26 11 80 00 	movl   $0x0,0x801126c0
80102d42:	00 00 00 
80102d45:	e8 16 13 00 00       	call   80104060 <wakeup>
80102d4a:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
80102d51:	e8 7a 1a 00 00       	call   801047d0 <release>
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
80102d70:	e8 eb 12 00 00       	call   80104060 <wakeup>
80102d75:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
80102d7c:	e8 4f 1a 00 00       	call   801047d0 <release>
80102d81:	83 c4 10             	add    $0x10,%esp
80102d84:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102d87:	5b                   	pop    %ebx
80102d88:	5e                   	pop    %esi
80102d89:	5f                   	pop    %edi
80102d8a:	5d                   	pop    %ebp
80102d8b:	c3                   	ret    
80102d8c:	83 ec 0c             	sub    $0xc,%esp
80102d8f:	68 04 78 10 80       	push   $0x80107804
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
80102dde:	e8 2d 19 00 00       	call   80104710 <acquire>
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
80102e2d:	e9 9e 19 00 00       	jmp    801047d0 <release>
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
80102e59:	68 13 78 10 80       	push   $0x80107813
80102e5e:	e8 2d d5 ff ff       	call   80100390 <panic>
80102e63:	83 ec 0c             	sub    $0xc,%esp
80102e66:	68 29 78 10 80       	push   $0x80107829
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
80102e77:	e8 e4 09 00 00       	call   80103860 <cpuid>
80102e7c:	89 c3                	mov    %eax,%ebx
80102e7e:	e8 dd 09 00 00       	call   80103860 <cpuid>
80102e83:	83 ec 04             	sub    $0x4,%esp
80102e86:	53                   	push   %ebx
80102e87:	50                   	push   %eax
80102e88:	68 44 78 10 80       	push   $0x80107844
80102e8d:	e8 ce d7 ff ff       	call   80100660 <cprintf>
  idtinit();       // load idt register
80102e92:	e8 d9 2c 00 00       	call   80105b70 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
80102e97:	e8 44 09 00 00       	call   801037e0 <mycpu>
80102e9c:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80102e9e:	b8 01 00 00 00       	mov    $0x1,%eax
80102ea3:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
80102eaa:	e8 11 0d 00 00       	call   80103bc0 <scheduler>
80102eaf:	90                   	nop

80102eb0 <mpenter>:
{
80102eb0:	55                   	push   %ebp
80102eb1:	89 e5                	mov    %esp,%ebp
80102eb3:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80102eb6:	e8 a5 3d 00 00       	call   80106c60 <switchkvm>
  seginit();
80102ebb:	e8 10 3d 00 00       	call   80106bd0 <seginit>
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
80102ee7:	68 a8 78 11 80       	push   $0x801178a8
80102eec:	e8 2f f5 ff ff       	call   80102420 <kinit1>
  kvmalloc();      // kernel page table
80102ef1:	e8 3a 42 00 00       	call   80107130 <kvmalloc>
  mpinit();        // detect other processors
80102ef6:	e8 75 01 00 00       	call   80103070 <mpinit>
  lapicinit();     // interrupt controller
80102efb:	e8 60 f7 ff ff       	call   80102660 <lapicinit>
  seginit();       // segment descriptors
80102f00:	e8 cb 3c 00 00       	call   80106bd0 <seginit>
  picinit();       // disable pic
80102f05:	e8 46 03 00 00       	call   80103250 <picinit>
  ioapicinit();    // another interrupt controller
80102f0a:	e8 41 f3 ff ff       	call   80102250 <ioapicinit>
  consoleinit();   // console hardware
80102f0f:	e8 ac da ff ff       	call   801009c0 <consoleinit>
  uartinit();      // serial port
80102f14:	e8 87 2f 00 00       	call   80105ea0 <uartinit>
  pinit();         // process table
80102f19:	e8 a2 08 00 00       	call   801037c0 <pinit>
  tvinit();        // trap vectors
80102f1e:	e8 cd 2b 00 00       	call   80105af0 <tvinit>
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
80102f44:	e8 87 19 00 00       	call   801048d0 <memmove>

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
80102f70:	e8 6b 08 00 00       	call   801037e0 <mycpu>
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
80102fe5:	e8 f6 08 00 00       	call   801038e0 <userinit>
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
8010301e:	68 58 78 10 80       	push   $0x80107858
80103023:	56                   	push   %esi
80103024:	e8 47 18 00 00       	call   80104870 <memcmp>
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
801030dc:	68 75 78 10 80       	push   $0x80107875
801030e1:	56                   	push   %esi
801030e2:	e8 89 17 00 00       	call   80104870 <memcmp>
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
80103170:	ff 24 95 9c 78 10 80 	jmp    *-0x7fef8764(,%edx,4)
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
80103223:	68 5d 78 10 80       	push   $0x8010785d
80103228:	e8 63 d1 ff ff       	call   80100390 <panic>
    panic("Didn't find a suitable machine");
8010322d:	83 ec 0c             	sub    $0xc,%esp
80103230:	68 7c 78 10 80       	push   $0x8010787c
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
8010332b:	68 b0 78 10 80       	push   $0x801078b0
80103330:	50                   	push   %eax
80103331:	e8 9a 12 00 00       	call   801045d0 <initlock>
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
8010338f:	e8 7c 13 00 00       	call   80104710 <acquire>
80103394:	83 c4 10             	add    $0x10,%esp
80103397:	85 f6                	test   %esi,%esi
80103399:	74 45                	je     801033e0 <pipeclose+0x60>
8010339b:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
801033a1:	83 ec 0c             	sub    $0xc,%esp
801033a4:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
801033ab:	00 00 00 
801033ae:	50                   	push   %eax
801033af:	e8 ac 0c 00 00       	call   80104060 <wakeup>
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
801033d4:	e9 f7 13 00 00       	jmp    801047d0 <release>
801033d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801033e0:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
801033e6:	83 ec 0c             	sub    $0xc,%esp
801033e9:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
801033f0:	00 00 00 
801033f3:	50                   	push   %eax
801033f4:	e8 67 0c 00 00       	call   80104060 <wakeup>
801033f9:	83 c4 10             	add    $0x10,%esp
801033fc:	eb b9                	jmp    801033b7 <pipeclose+0x37>
801033fe:	66 90                	xchg   %ax,%ax
80103400:	83 ec 0c             	sub    $0xc,%esp
80103403:	53                   	push   %ebx
80103404:	e8 c7 13 00 00       	call   801047d0 <release>
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
8010342d:	e8 de 12 00 00       	call   80104710 <acquire>
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
80103484:	e8 d7 0b 00 00       	call   80104060 <wakeup>
80103489:	5a                   	pop    %edx
8010348a:	59                   	pop    %ecx
8010348b:	53                   	push   %ebx
8010348c:	56                   	push   %esi
8010348d:	e8 0e 0a 00 00       	call   80103ea0 <sleep>
80103492:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
80103498:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
8010349e:	83 c4 10             	add    $0x10,%esp
801034a1:	05 00 02 00 00       	add    $0x200,%eax
801034a6:	39 c2                	cmp    %eax,%edx
801034a8:	75 36                	jne    801034e0 <pipewrite+0xc0>
801034aa:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
801034b0:	85 c0                	test   %eax,%eax
801034b2:	74 0c                	je     801034c0 <pipewrite+0xa0>
801034b4:	e8 c7 03 00 00       	call   80103880 <myproc>
801034b9:	8b 40 24             	mov    0x24(%eax),%eax
801034bc:	85 c0                	test   %eax,%eax
801034be:	74 c0                	je     80103480 <pipewrite+0x60>
801034c0:	83 ec 0c             	sub    $0xc,%esp
801034c3:	53                   	push   %ebx
801034c4:	e8 07 13 00 00       	call   801047d0 <release>
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
80103513:	e8 48 0b 00 00       	call   80104060 <wakeup>
80103518:	89 1c 24             	mov    %ebx,(%esp)
8010351b:	e8 b0 12 00 00       	call   801047d0 <release>
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
80103540:	e8 cb 11 00 00       	call   80104710 <acquire>
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
80103575:	e8 26 09 00 00       	call   80103ea0 <sleep>
8010357a:	83 c4 10             	add    $0x10,%esp
8010357d:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
80103583:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
80103589:	75 35                	jne    801035c0 <piperead+0x90>
8010358b:	8b 96 40 02 00 00    	mov    0x240(%esi),%edx
80103591:	85 d2                	test   %edx,%edx
80103593:	0f 84 8f 00 00 00    	je     80103628 <piperead+0xf8>
80103599:	e8 e2 02 00 00       	call   80103880 <myproc>
8010359e:	8b 48 24             	mov    0x24(%eax),%ecx
801035a1:	85 c9                	test   %ecx,%ecx
801035a3:	74 cb                	je     80103570 <piperead+0x40>
801035a5:	83 ec 0c             	sub    $0xc,%esp
801035a8:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801035ad:	56                   	push   %esi
801035ae:	e8 1d 12 00 00       	call   801047d0 <release>
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
80103607:	e8 54 0a 00 00       	call   80104060 <wakeup>
8010360c:	89 34 24             	mov    %esi,(%esp)
8010360f:	e8 bc 11 00 00       	call   801047d0 <release>
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

80103630 <call_sigret>:
  if (p->suspended == 1)
    p->suspended = 0;
}

void call_sigret(void)
{
80103630:	55                   	push   %ebp
80103631:	89 e5                	mov    %esp,%ebp
  asm("movl $24 , %eax;");
80103633:	b8 18 00 00 00       	mov    $0x18,%eax
  asm("int $64;");
80103638:	cd 40                	int    $0x40
}
8010363a:	5d                   	pop    %ebp
8010363b:	c3                   	ret    
8010363c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103640 <allocproc>:
{
80103640:	55                   	push   %ebp
80103641:	89 e5                	mov    %esp,%ebp
80103643:	56                   	push   %esi
80103644:	53                   	push   %ebx
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103645:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
  acquire(&ptable.lock);
8010364a:	83 ec 0c             	sub    $0xc,%esp
8010364d:	68 20 2d 11 80       	push   $0x80112d20
80103652:	e8 b9 10 00 00       	call   80104710 <acquire>
80103657:	83 c4 10             	add    $0x10,%esp
8010365a:	eb 16                	jmp    80103672 <allocproc+0x32>
8010365c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103660:	81 c3 0c 01 00 00    	add    $0x10c,%ebx
80103666:	81 fb 54 70 11 80    	cmp    $0x80117054,%ebx
8010366c:	0f 83 d4 00 00 00    	jae    80103746 <allocproc+0x106>
    if (p->state == UNUSED)
80103672:	8b 43 0c             	mov    0xc(%ebx),%eax
80103675:	85 c0                	test   %eax,%eax
80103677:	75 e7                	jne    80103660 <allocproc+0x20>
  release(&ptable.lock);
80103679:	83 ec 0c             	sub    $0xc,%esp
  p->state = EMBRYO;
8010367c:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  release(&ptable.lock);
80103683:	68 20 2d 11 80       	push   $0x80112d20
80103688:	e8 43 11 00 00       	call   801047d0 <release>
8010368d:	83 c4 10             	add    $0x10,%esp
    pid = nextpid;
80103690:	8b 15 04 a0 10 80    	mov    0x8010a004,%edx
  }while (!cas(&nextpid , pid, pid+1));
80103696:	8d 4a 01             	lea    0x1(%edx),%ecx

static inline int cas (volatile void * addr, int expected, int newval)
{
  
  int ret;
  asm volatile("movl %2 , %%eax\n\t"
80103699:	89 d0                	mov    %edx,%eax
8010369b:	f0 0f b1 0d 04 a0 10 	lock cmpxchg %ecx,0x8010a004
801036a2:	80 
801036a3:	9c                   	pushf  
801036a4:	5a                   	pop    %edx
801036a5:	83 e2 40             	and    $0x40,%edx
801036a8:	85 d2                	test   %edx,%edx
801036aa:	74 e4                	je     80103690 <allocproc+0x50>
  p->pid = allocpid();
801036ac:	89 4b 10             	mov    %ecx,0x10(%ebx)
  if ((p->kstack = kalloc()) == 0)
801036af:	e8 3c ee ff ff       	call   801024f0 <kalloc>
801036b4:	85 c0                	test   %eax,%eax
801036b6:	89 c6                	mov    %eax,%esi
801036b8:	89 43 08             	mov    %eax,0x8(%ebx)
801036bb:	0f 84 a0 00 00 00    	je     80103761 <allocproc+0x121>
  sp -= sizeof *p->tf;
801036c1:	8d 80 b4 0f 00 00    	lea    0xfb4(%eax),%eax
  memset(p->context, 0, sizeof *p->context);
801036c7:	83 ec 04             	sub    $0x4,%esp
  sp -= sizeof *p->tf;
801036ca:	89 43 18             	mov    %eax,0x18(%ebx)
  sp -= sizeof *p->context;
801036cd:	8d 86 9c 0f 00 00    	lea    0xf9c(%esi),%eax
  *(uint *)sp = (uint)trapret;
801036d3:	c7 86 b0 0f 00 00 df 	movl   $0x80105adf,0xfb0(%esi)
801036da:	5a 10 80 
  sp -= sizeof *p->backup;
801036dd:	81 c6 50 0f 00 00    	add    $0xf50,%esi
  p->context = (struct context *)sp;
801036e3:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
801036e6:	6a 14                	push   $0x14
801036e8:	6a 00                	push   $0x0
801036ea:	50                   	push   %eax
801036eb:	e8 30 11 00 00       	call   80104820 <memset>
  p->context->eip = (uint)forkret;
801036f0:	8b 43 1c             	mov    0x1c(%ebx),%eax
801036f3:	8d 93 08 01 00 00    	lea    0x108(%ebx),%edx
801036f9:	83 c4 10             	add    $0x10,%esp
801036fc:	c7 40 10 70 37 10 80 	movl   $0x80103770,0x10(%eax)
80103703:	8d 83 88 00 00 00    	lea    0x88(%ebx),%eax
  sp -= sizeof *p->backup;
80103709:	89 73 7c             	mov    %esi,0x7c(%ebx)
  p->signal_mask = 0;
8010370c:	c7 83 84 00 00 00 00 	movl   $0x0,0x84(%ebx)
80103713:	00 00 00 
  p->pending_signals = 0;
80103716:	c7 83 80 00 00 00 00 	movl   $0x0,0x80(%ebx)
8010371d:	00 00 00 
  p->suspended = 0;
80103720:	c7 83 08 01 00 00 00 	movl   $0x0,0x108(%ebx)
80103727:	00 00 00 
8010372a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    p->signal_handlers[i] = (void *)SIG_DFL;
80103730:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80103736:	83 c0 04             	add    $0x4,%eax
  for (int i = 0; i < 32; i++)
80103739:	39 c2                	cmp    %eax,%edx
8010373b:	75 f3                	jne    80103730 <allocproc+0xf0>
}
8010373d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103740:	89 d8                	mov    %ebx,%eax
80103742:	5b                   	pop    %ebx
80103743:	5e                   	pop    %esi
80103744:	5d                   	pop    %ebp
80103745:	c3                   	ret    
  release(&ptable.lock);
80103746:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80103749:	31 db                	xor    %ebx,%ebx
  release(&ptable.lock);
8010374b:	68 20 2d 11 80       	push   $0x80112d20
80103750:	e8 7b 10 00 00       	call   801047d0 <release>
  return 0;
80103755:	83 c4 10             	add    $0x10,%esp
}
80103758:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010375b:	89 d8                	mov    %ebx,%eax
8010375d:	5b                   	pop    %ebx
8010375e:	5e                   	pop    %esi
8010375f:	5d                   	pop    %ebp
80103760:	c3                   	ret    
    p->state = UNUSED;
80103761:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
80103768:	31 db                	xor    %ebx,%ebx
8010376a:	eb d1                	jmp    8010373d <allocproc+0xfd>
8010376c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103770 <forkret>:
{
80103770:	55                   	push   %ebp
80103771:	89 e5                	mov    %esp,%ebp
80103773:	83 ec 14             	sub    $0x14,%esp
  release(&ptable.lock);
80103776:	68 20 2d 11 80       	push   $0x80112d20
8010377b:	e8 50 10 00 00       	call   801047d0 <release>
  if (first)
80103780:	a1 00 a0 10 80       	mov    0x8010a000,%eax
80103785:	83 c4 10             	add    $0x10,%esp
80103788:	85 c0                	test   %eax,%eax
8010378a:	75 04                	jne    80103790 <forkret+0x20>
}
8010378c:	c9                   	leave  
8010378d:	c3                   	ret    
8010378e:	66 90                	xchg   %ax,%ax
    iinit(ROOTDEV);
80103790:	83 ec 0c             	sub    $0xc,%esp
    first = 0;
80103793:	c7 05 00 a0 10 80 00 	movl   $0x0,0x8010a000
8010379a:	00 00 00 
    iinit(ROOTDEV);
8010379d:	6a 01                	push   $0x1
8010379f:	e8 0c dd ff ff       	call   801014b0 <iinit>
    initlog(ROOTDEV);
801037a4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801037ab:	e8 80 f3 ff ff       	call   80102b30 <initlog>
801037b0:	83 c4 10             	add    $0x10,%esp
}
801037b3:	c9                   	leave  
801037b4:	c3                   	ret    
801037b5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801037b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801037c0 <pinit>:
{
801037c0:	55                   	push   %ebp
801037c1:	89 e5                	mov    %esp,%ebp
801037c3:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
801037c6:	68 b5 78 10 80       	push   $0x801078b5
801037cb:	68 20 2d 11 80       	push   $0x80112d20
801037d0:	e8 fb 0d 00 00       	call   801045d0 <initlock>
}
801037d5:	83 c4 10             	add    $0x10,%esp
801037d8:	c9                   	leave  
801037d9:	c3                   	ret    
801037da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801037e0 <mycpu>:
{
801037e0:	55                   	push   %ebp
801037e1:	89 e5                	mov    %esp,%ebp
801037e3:	56                   	push   %esi
801037e4:	53                   	push   %ebx
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801037e5:	9c                   	pushf  
801037e6:	58                   	pop    %eax
  if (readeflags() & FL_IF)
801037e7:	f6 c4 02             	test   $0x2,%ah
801037ea:	75 5e                	jne    8010384a <mycpu+0x6a>
  apicid = lapicid();
801037ec:	e8 6f ef ff ff       	call   80102760 <lapicid>
  for (i = 0; i < ncpu; ++i)
801037f1:	8b 35 00 2d 11 80    	mov    0x80112d00,%esi
801037f7:	85 f6                	test   %esi,%esi
801037f9:	7e 42                	jle    8010383d <mycpu+0x5d>
    if (cpus[i].apicid == apicid)
801037fb:	0f b6 15 80 27 11 80 	movzbl 0x80112780,%edx
80103802:	39 d0                	cmp    %edx,%eax
80103804:	74 30                	je     80103836 <mycpu+0x56>
80103806:	b9 30 28 11 80       	mov    $0x80112830,%ecx
  for (i = 0; i < ncpu; ++i)
8010380b:	31 d2                	xor    %edx,%edx
8010380d:	8d 76 00             	lea    0x0(%esi),%esi
80103810:	83 c2 01             	add    $0x1,%edx
80103813:	39 f2                	cmp    %esi,%edx
80103815:	74 26                	je     8010383d <mycpu+0x5d>
    if (cpus[i].apicid == apicid)
80103817:	0f b6 19             	movzbl (%ecx),%ebx
8010381a:	81 c1 b0 00 00 00    	add    $0xb0,%ecx
80103820:	39 c3                	cmp    %eax,%ebx
80103822:	75 ec                	jne    80103810 <mycpu+0x30>
80103824:	69 c2 b0 00 00 00    	imul   $0xb0,%edx,%eax
8010382a:	05 80 27 11 80       	add    $0x80112780,%eax
}
8010382f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103832:	5b                   	pop    %ebx
80103833:	5e                   	pop    %esi
80103834:	5d                   	pop    %ebp
80103835:	c3                   	ret    
    if (cpus[i].apicid == apicid)
80103836:	b8 80 27 11 80       	mov    $0x80112780,%eax
      return &cpus[i];
8010383b:	eb f2                	jmp    8010382f <mycpu+0x4f>
  panic("unknown apicid\n");
8010383d:	83 ec 0c             	sub    $0xc,%esp
80103840:	68 bc 78 10 80       	push   $0x801078bc
80103845:	e8 46 cb ff ff       	call   80100390 <panic>
    panic("mycpu called with interrupts enabled\n");
8010384a:	83 ec 0c             	sub    $0xc,%esp
8010384d:	68 98 79 10 80       	push   $0x80107998
80103852:	e8 39 cb ff ff       	call   80100390 <panic>
80103857:	89 f6                	mov    %esi,%esi
80103859:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103860 <cpuid>:
{
80103860:	55                   	push   %ebp
80103861:	89 e5                	mov    %esp,%ebp
80103863:	83 ec 08             	sub    $0x8,%esp
  return mycpu() - cpus;
80103866:	e8 75 ff ff ff       	call   801037e0 <mycpu>
8010386b:	2d 80 27 11 80       	sub    $0x80112780,%eax
}
80103870:	c9                   	leave  
  return mycpu() - cpus;
80103871:	c1 f8 04             	sar    $0x4,%eax
80103874:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
8010387a:	c3                   	ret    
8010387b:	90                   	nop
8010387c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103880 <myproc>:
{
80103880:	55                   	push   %ebp
80103881:	89 e5                	mov    %esp,%ebp
80103883:	53                   	push   %ebx
80103884:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80103887:	e8 b4 0d 00 00       	call   80104640 <pushcli>
  c = mycpu();
8010388c:	e8 4f ff ff ff       	call   801037e0 <mycpu>
  p = c->proc;
80103891:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103897:	e8 e4 0d 00 00       	call   80104680 <popcli>
}
8010389c:	83 c4 04             	add    $0x4,%esp
8010389f:	89 d8                	mov    %ebx,%eax
801038a1:	5b                   	pop    %ebx
801038a2:	5d                   	pop    %ebp
801038a3:	c3                   	ret    
801038a4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801038aa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801038b0 <allocpid>:
{
801038b0:	55                   	push   %ebp
801038b1:	89 e5                	mov    %esp,%ebp
801038b3:	90                   	nop
801038b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    pid = nextpid;
801038b8:	8b 15 04 a0 10 80    	mov    0x8010a004,%edx
  }while (!cas(&nextpid , pid, pid+1));
801038be:	8d 4a 01             	lea    0x1(%edx),%ecx
  asm volatile("movl %2 , %%eax\n\t"
801038c1:	89 d0                	mov    %edx,%eax
801038c3:	f0 0f b1 0d 04 a0 10 	lock cmpxchg %ecx,0x8010a004
801038ca:	80 
801038cb:	9c                   	pushf  
801038cc:	5a                   	pop    %edx
801038cd:	83 e2 40             	and    $0x40,%edx
801038d0:	85 d2                	test   %edx,%edx
801038d2:	74 e4                	je     801038b8 <allocpid+0x8>
}
801038d4:	89 c8                	mov    %ecx,%eax
801038d6:	5d                   	pop    %ebp
801038d7:	c3                   	ret    
801038d8:	90                   	nop
801038d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801038e0 <userinit>:
{
801038e0:	55                   	push   %ebp
801038e1:	89 e5                	mov    %esp,%ebp
801038e3:	53                   	push   %ebx
801038e4:	83 ec 04             	sub    $0x4,%esp
  p = allocproc();
801038e7:	e8 54 fd ff ff       	call   80103640 <allocproc>
801038ec:	89 c3                	mov    %eax,%ebx
  initproc = p;
801038ee:	a3 b8 a5 10 80       	mov    %eax,0x8010a5b8
  if ((p->pgdir = setupkvm()) == 0)
801038f3:	e8 b8 37 00 00       	call   801070b0 <setupkvm>
801038f8:	85 c0                	test   %eax,%eax
801038fa:	89 43 04             	mov    %eax,0x4(%ebx)
801038fd:	0f 84 bd 00 00 00    	je     801039c0 <userinit+0xe0>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80103903:	83 ec 04             	sub    $0x4,%esp
80103906:	68 2c 00 00 00       	push   $0x2c
8010390b:	68 60 a4 10 80       	push   $0x8010a460
80103910:	50                   	push   %eax
80103911:	e8 7a 34 00 00       	call   80106d90 <inituvm>
  memset(p->tf, 0, sizeof(*p->tf));
80103916:	83 c4 0c             	add    $0xc,%esp
  p->sz = PGSIZE;
80103919:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
8010391f:	6a 4c                	push   $0x4c
80103921:	6a 00                	push   $0x0
80103923:	ff 73 18             	pushl  0x18(%ebx)
80103926:	e8 f5 0e 00 00       	call   80104820 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
8010392b:	8b 43 18             	mov    0x18(%ebx),%eax
8010392e:	ba 1b 00 00 00       	mov    $0x1b,%edx
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103933:	b9 23 00 00 00       	mov    $0x23,%ecx
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103938:	83 c4 0c             	add    $0xc,%esp
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
8010393b:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
8010393f:	8b 43 18             	mov    0x18(%ebx),%eax
80103942:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
80103946:	8b 43 18             	mov    0x18(%ebx),%eax
80103949:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
8010394d:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80103951:	8b 43 18             	mov    0x18(%ebx),%eax
80103954:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103958:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
8010395c:	8b 43 18             	mov    0x18(%ebx),%eax
8010395f:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80103966:	8b 43 18             	mov    0x18(%ebx),%eax
80103969:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0; // beginning of initcode.S
80103970:	8b 43 18             	mov    0x18(%ebx),%eax
80103973:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
8010397a:	8d 43 6c             	lea    0x6c(%ebx),%eax
8010397d:	6a 10                	push   $0x10
8010397f:	68 e5 78 10 80       	push   $0x801078e5
80103984:	50                   	push   %eax
80103985:	e8 76 10 00 00       	call   80104a00 <safestrcpy>
  p->cwd = namei("/");
8010398a:	c7 04 24 ee 78 10 80 	movl   $0x801078ee,(%esp)
80103991:	e8 7a e5 ff ff       	call   80101f10 <namei>
80103996:	89 43 68             	mov    %eax,0x68(%ebx)
  acquire(&ptable.lock);
80103999:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
801039a0:	e8 6b 0d 00 00       	call   80104710 <acquire>
  p->state = RUNNABLE;
801039a5:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
801039ac:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
801039b3:	e8 18 0e 00 00       	call   801047d0 <release>
}
801039b8:	83 c4 10             	add    $0x10,%esp
801039bb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801039be:	c9                   	leave  
801039bf:	c3                   	ret    
    panic("userinit: out of memory?");
801039c0:	83 ec 0c             	sub    $0xc,%esp
801039c3:	68 cc 78 10 80       	push   $0x801078cc
801039c8:	e8 c3 c9 ff ff       	call   80100390 <panic>
801039cd:	8d 76 00             	lea    0x0(%esi),%esi

801039d0 <growproc>:
{
801039d0:	55                   	push   %ebp
801039d1:	89 e5                	mov    %esp,%ebp
801039d3:	56                   	push   %esi
801039d4:	53                   	push   %ebx
801039d5:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
801039d8:	e8 63 0c 00 00       	call   80104640 <pushcli>
  c = mycpu();
801039dd:	e8 fe fd ff ff       	call   801037e0 <mycpu>
  p = c->proc;
801039e2:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801039e8:	e8 93 0c 00 00       	call   80104680 <popcli>
  if (n > 0)
801039ed:	83 fe 00             	cmp    $0x0,%esi
  sz = curproc->sz;
801039f0:	8b 03                	mov    (%ebx),%eax
  if (n > 0)
801039f2:	7f 1c                	jg     80103a10 <growproc+0x40>
  else if (n < 0)
801039f4:	75 3a                	jne    80103a30 <growproc+0x60>
  switchuvm(curproc);
801039f6:	83 ec 0c             	sub    $0xc,%esp
  curproc->sz = sz;
801039f9:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
801039fb:	53                   	push   %ebx
801039fc:	e8 7f 32 00 00       	call   80106c80 <switchuvm>
  return 0;
80103a01:	83 c4 10             	add    $0x10,%esp
80103a04:	31 c0                	xor    %eax,%eax
}
80103a06:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103a09:	5b                   	pop    %ebx
80103a0a:	5e                   	pop    %esi
80103a0b:	5d                   	pop    %ebp
80103a0c:	c3                   	ret    
80103a0d:	8d 76 00             	lea    0x0(%esi),%esi
    if ((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103a10:	83 ec 04             	sub    $0x4,%esp
80103a13:	01 c6                	add    %eax,%esi
80103a15:	56                   	push   %esi
80103a16:	50                   	push   %eax
80103a17:	ff 73 04             	pushl  0x4(%ebx)
80103a1a:	e8 b1 34 00 00       	call   80106ed0 <allocuvm>
80103a1f:	83 c4 10             	add    $0x10,%esp
80103a22:	85 c0                	test   %eax,%eax
80103a24:	75 d0                	jne    801039f6 <growproc+0x26>
      return -1;
80103a26:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103a2b:	eb d9                	jmp    80103a06 <growproc+0x36>
80103a2d:	8d 76 00             	lea    0x0(%esi),%esi
    if ((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103a30:	83 ec 04             	sub    $0x4,%esp
80103a33:	01 c6                	add    %eax,%esi
80103a35:	56                   	push   %esi
80103a36:	50                   	push   %eax
80103a37:	ff 73 04             	pushl  0x4(%ebx)
80103a3a:	e8 c1 35 00 00       	call   80107000 <deallocuvm>
80103a3f:	83 c4 10             	add    $0x10,%esp
80103a42:	85 c0                	test   %eax,%eax
80103a44:	75 b0                	jne    801039f6 <growproc+0x26>
80103a46:	eb de                	jmp    80103a26 <growproc+0x56>
80103a48:	90                   	nop
80103a49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103a50 <fork>:
{
80103a50:	55                   	push   %ebp
80103a51:	89 e5                	mov    %esp,%ebp
80103a53:	57                   	push   %edi
80103a54:	56                   	push   %esi
80103a55:	53                   	push   %ebx
80103a56:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
80103a59:	e8 e2 0b 00 00       	call   80104640 <pushcli>
  c = mycpu();
80103a5e:	e8 7d fd ff ff       	call   801037e0 <mycpu>
  p = c->proc;
80103a63:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103a69:	e8 12 0c 00 00       	call   80104680 <popcli>
  if ((np = allocproc()) == 0)
80103a6e:	e8 cd fb ff ff       	call   80103640 <allocproc>
80103a73:	85 c0                	test   %eax,%eax
80103a75:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103a78:	0f 84 0b 01 00 00    	je     80103b89 <fork+0x139>
  if ((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0)
80103a7e:	83 ec 08             	sub    $0x8,%esp
80103a81:	ff 33                	pushl  (%ebx)
80103a83:	ff 73 04             	pushl  0x4(%ebx)
80103a86:	e8 f5 36 00 00       	call   80107180 <copyuvm>
80103a8b:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103a8e:	83 c4 10             	add    $0x10,%esp
80103a91:	85 c0                	test   %eax,%eax
80103a93:	89 42 04             	mov    %eax,0x4(%edx)
80103a96:	0f 84 f4 00 00 00    	je     80103b90 <fork+0x140>
  np->sz = curproc->sz;
80103a9c:	8b 03                	mov    (%ebx),%eax
  *np->tf = *curproc->tf;
80103a9e:	8b 7a 18             	mov    0x18(%edx),%edi
80103aa1:	b9 13 00 00 00       	mov    $0x13,%ecx
  np->parent = curproc;
80103aa6:	89 5a 14             	mov    %ebx,0x14(%edx)
  np->sz = curproc->sz;
80103aa9:	89 02                	mov    %eax,(%edx)
  *np->tf = *curproc->tf;
80103aab:	8b 73 18             	mov    0x18(%ebx),%esi
80103aae:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  for (i = 0; i < NOFILE; i++)
80103ab0:	31 f6                	xor    %esi,%esi
  np->tf->eax = 0;
80103ab2:	8b 42 18             	mov    0x18(%edx),%eax
80103ab5:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
80103abc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if (curproc->ofile[i])
80103ac0:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
80103ac4:	85 c0                	test   %eax,%eax
80103ac6:	74 16                	je     80103ade <fork+0x8e>
      np->ofile[i] = filedup(curproc->ofile[i]);
80103ac8:	83 ec 0c             	sub    $0xc,%esp
80103acb:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80103ace:	50                   	push   %eax
80103acf:	e8 4c d3 ff ff       	call   80100e20 <filedup>
80103ad4:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103ad7:	83 c4 10             	add    $0x10,%esp
80103ada:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
  for (i = 0; i < NOFILE; i++)
80103ade:	83 c6 01             	add    $0x1,%esi
80103ae1:	83 fe 10             	cmp    $0x10,%esi
80103ae4:	75 da                	jne    80103ac0 <fork+0x70>
  np->cwd = idup(curproc->cwd);
80103ae6:	83 ec 0c             	sub    $0xc,%esp
80103ae9:	ff 73 68             	pushl  0x68(%ebx)
80103aec:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80103aef:	e8 8c db ff ff       	call   80101680 <idup>
80103af4:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103af7:	83 c4 0c             	add    $0xc,%esp
  np->cwd = idup(curproc->cwd);
80103afa:	89 42 68             	mov    %eax,0x68(%edx)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103afd:	8d 43 6c             	lea    0x6c(%ebx),%eax
80103b00:	6a 10                	push   $0x10
80103b02:	50                   	push   %eax
80103b03:	8d 42 6c             	lea    0x6c(%edx),%eax
80103b06:	50                   	push   %eax
80103b07:	e8 f4 0e 00 00       	call   80104a00 <safestrcpy>
  pid = np->pid;
80103b0c:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  np->signal_mask = curproc->signal_mask;
80103b0f:	8b 83 84 00 00 00    	mov    0x84(%ebx),%eax
  np->suspended = 0;
80103b15:	83 c4 10             	add    $0x10,%esp
  for (int i = 0; i < 32; i++)
80103b18:	31 c9                	xor    %ecx,%ecx
  pid = np->pid;
80103b1a:	8b 7a 10             	mov    0x10(%edx),%edi
  np->signal_mask = curproc->signal_mask;
80103b1d:	89 82 84 00 00 00    	mov    %eax,0x84(%edx)
  np->pending_signals = 0;
80103b23:	c7 82 80 00 00 00 00 	movl   $0x0,0x80(%edx)
80103b2a:	00 00 00 
  np->suspended = 0;
80103b2d:	c7 82 08 01 00 00 00 	movl   $0x0,0x108(%edx)
80103b34:	00 00 00 
80103b37:	89 f6                	mov    %esi,%esi
80103b39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    np->signal_handlers[i] = curproc->signal_handlers[i];
80103b40:	8b b4 8b 88 00 00 00 	mov    0x88(%ebx,%ecx,4),%esi
80103b47:	89 b4 8a 88 00 00 00 	mov    %esi,0x88(%edx,%ecx,4)
  for (int i = 0; i < 32; i++)
80103b4e:	83 c1 01             	add    $0x1,%ecx
80103b51:	83 f9 20             	cmp    $0x20,%ecx
80103b54:	75 ea                	jne    80103b40 <fork+0xf0>
  acquire(&ptable.lock);
80103b56:	83 ec 0c             	sub    $0xc,%esp
80103b59:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80103b5c:	68 20 2d 11 80       	push   $0x80112d20
80103b61:	e8 aa 0b 00 00       	call   80104710 <acquire>
  np->state = RUNNABLE;
80103b66:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103b69:	c7 42 0c 03 00 00 00 	movl   $0x3,0xc(%edx)
  release(&ptable.lock);
80103b70:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103b77:	e8 54 0c 00 00       	call   801047d0 <release>
  return pid;
80103b7c:	83 c4 10             	add    $0x10,%esp
}
80103b7f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103b82:	89 f8                	mov    %edi,%eax
80103b84:	5b                   	pop    %ebx
80103b85:	5e                   	pop    %esi
80103b86:	5f                   	pop    %edi
80103b87:	5d                   	pop    %ebp
80103b88:	c3                   	ret    
    return -1;
80103b89:	bf ff ff ff ff       	mov    $0xffffffff,%edi
80103b8e:	eb ef                	jmp    80103b7f <fork+0x12f>
    kfree(np->kstack);
80103b90:	83 ec 0c             	sub    $0xc,%esp
80103b93:	ff 72 08             	pushl  0x8(%edx)
    return -1;
80103b96:	bf ff ff ff ff       	mov    $0xffffffff,%edi
    kfree(np->kstack);
80103b9b:	e8 a0 e7 ff ff       	call   80102340 <kfree>
    np->kstack = 0;
80103ba0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    return -1;
80103ba3:	83 c4 10             	add    $0x10,%esp
    np->kstack = 0;
80103ba6:	c7 42 08 00 00 00 00 	movl   $0x0,0x8(%edx)
    np->state = UNUSED;
80103bad:	c7 42 0c 00 00 00 00 	movl   $0x0,0xc(%edx)
    return -1;
80103bb4:	eb c9                	jmp    80103b7f <fork+0x12f>
80103bb6:	8d 76 00             	lea    0x0(%esi),%esi
80103bb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103bc0 <scheduler>:
{
80103bc0:	55                   	push   %ebp
80103bc1:	89 e5                	mov    %esp,%ebp
80103bc3:	57                   	push   %edi
80103bc4:	56                   	push   %esi
80103bc5:	53                   	push   %ebx
80103bc6:	83 ec 0c             	sub    $0xc,%esp
  struct cpu *c = mycpu();
80103bc9:	e8 12 fc ff ff       	call   801037e0 <mycpu>
80103bce:	8d 78 04             	lea    0x4(%eax),%edi
80103bd1:	89 c6                	mov    %eax,%esi
  c->proc = 0;
80103bd3:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80103bda:	00 00 00 
80103bdd:	8d 76 00             	lea    0x0(%esi),%esi
  asm volatile("sti");
80103be0:	fb                   	sti    
    acquire(&ptable.lock);
80103be1:	83 ec 0c             	sub    $0xc,%esp
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103be4:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
    acquire(&ptable.lock);
80103be9:	68 20 2d 11 80       	push   $0x80112d20
80103bee:	e8 1d 0b 00 00       	call   80104710 <acquire>
80103bf3:	83 c4 10             	add    $0x10,%esp
80103bf6:	8d 76 00             	lea    0x0(%esi),%esi
80103bf9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      if (p->state != RUNNABLE)
80103c00:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
80103c04:	75 33                	jne    80103c39 <scheduler+0x79>
      switchuvm(p);
80103c06:	83 ec 0c             	sub    $0xc,%esp
      c->proc = p;
80103c09:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
      switchuvm(p);
80103c0f:	53                   	push   %ebx
80103c10:	e8 6b 30 00 00       	call   80106c80 <switchuvm>
      swtch(&(c->scheduler), p->context);
80103c15:	58                   	pop    %eax
80103c16:	5a                   	pop    %edx
80103c17:	ff 73 1c             	pushl  0x1c(%ebx)
80103c1a:	57                   	push   %edi
      p->state = RUNNING;
80103c1b:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
      swtch(&(c->scheduler), p->context);
80103c22:	e8 34 0e 00 00       	call   80104a5b <swtch>
      switchkvm();
80103c27:	e8 34 30 00 00       	call   80106c60 <switchkvm>
      c->proc = 0;
80103c2c:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
80103c33:	00 00 00 
80103c36:	83 c4 10             	add    $0x10,%esp
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103c39:	81 c3 0c 01 00 00    	add    $0x10c,%ebx
80103c3f:	81 fb 54 70 11 80    	cmp    $0x80117054,%ebx
80103c45:	72 b9                	jb     80103c00 <scheduler+0x40>
    release(&ptable.lock);
80103c47:	83 ec 0c             	sub    $0xc,%esp
80103c4a:	68 20 2d 11 80       	push   $0x80112d20
80103c4f:	e8 7c 0b 00 00       	call   801047d0 <release>
    sti();
80103c54:	83 c4 10             	add    $0x10,%esp
80103c57:	eb 87                	jmp    80103be0 <scheduler+0x20>
80103c59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103c60 <sched>:
{
80103c60:	55                   	push   %ebp
80103c61:	89 e5                	mov    %esp,%ebp
80103c63:	56                   	push   %esi
80103c64:	53                   	push   %ebx
  pushcli();
80103c65:	e8 d6 09 00 00       	call   80104640 <pushcli>
  c = mycpu();
80103c6a:	e8 71 fb ff ff       	call   801037e0 <mycpu>
  p = c->proc;
80103c6f:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103c75:	e8 06 0a 00 00       	call   80104680 <popcli>
  if (!holding(&ptable.lock))
80103c7a:	83 ec 0c             	sub    $0xc,%esp
80103c7d:	68 20 2d 11 80       	push   $0x80112d20
80103c82:	e8 59 0a 00 00       	call   801046e0 <holding>
80103c87:	83 c4 10             	add    $0x10,%esp
80103c8a:	85 c0                	test   %eax,%eax
80103c8c:	74 4f                	je     80103cdd <sched+0x7d>
  if (mycpu()->ncli != 1)
80103c8e:	e8 4d fb ff ff       	call   801037e0 <mycpu>
80103c93:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
80103c9a:	75 68                	jne    80103d04 <sched+0xa4>
  if (p->state == RUNNING)
80103c9c:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80103ca0:	74 55                	je     80103cf7 <sched+0x97>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103ca2:	9c                   	pushf  
80103ca3:	58                   	pop    %eax
  if (readeflags() & FL_IF)
80103ca4:	f6 c4 02             	test   $0x2,%ah
80103ca7:	75 41                	jne    80103cea <sched+0x8a>
  intena = mycpu()->intena;
80103ca9:	e8 32 fb ff ff       	call   801037e0 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
80103cae:	83 c3 1c             	add    $0x1c,%ebx
  intena = mycpu()->intena;
80103cb1:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80103cb7:	e8 24 fb ff ff       	call   801037e0 <mycpu>
80103cbc:	83 ec 08             	sub    $0x8,%esp
80103cbf:	ff 70 04             	pushl  0x4(%eax)
80103cc2:	53                   	push   %ebx
80103cc3:	e8 93 0d 00 00       	call   80104a5b <swtch>
  mycpu()->intena = intena;
80103cc8:	e8 13 fb ff ff       	call   801037e0 <mycpu>
}
80103ccd:	83 c4 10             	add    $0x10,%esp
  mycpu()->intena = intena;
80103cd0:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80103cd6:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103cd9:	5b                   	pop    %ebx
80103cda:	5e                   	pop    %esi
80103cdb:	5d                   	pop    %ebp
80103cdc:	c3                   	ret    
    panic("sched ptable.lock");
80103cdd:	83 ec 0c             	sub    $0xc,%esp
80103ce0:	68 f0 78 10 80       	push   $0x801078f0
80103ce5:	e8 a6 c6 ff ff       	call   80100390 <panic>
    panic("sched interruptible");
80103cea:	83 ec 0c             	sub    $0xc,%esp
80103ced:	68 1c 79 10 80       	push   $0x8010791c
80103cf2:	e8 99 c6 ff ff       	call   80100390 <panic>
    panic("sched running");
80103cf7:	83 ec 0c             	sub    $0xc,%esp
80103cfa:	68 0e 79 10 80       	push   $0x8010790e
80103cff:	e8 8c c6 ff ff       	call   80100390 <panic>
    panic("sched locks");
80103d04:	83 ec 0c             	sub    $0xc,%esp
80103d07:	68 02 79 10 80       	push   $0x80107902
80103d0c:	e8 7f c6 ff ff       	call   80100390 <panic>
80103d11:	eb 0d                	jmp    80103d20 <exit>
80103d13:	90                   	nop
80103d14:	90                   	nop
80103d15:	90                   	nop
80103d16:	90                   	nop
80103d17:	90                   	nop
80103d18:	90                   	nop
80103d19:	90                   	nop
80103d1a:	90                   	nop
80103d1b:	90                   	nop
80103d1c:	90                   	nop
80103d1d:	90                   	nop
80103d1e:	90                   	nop
80103d1f:	90                   	nop

80103d20 <exit>:
{
80103d20:	55                   	push   %ebp
80103d21:	89 e5                	mov    %esp,%ebp
80103d23:	57                   	push   %edi
80103d24:	56                   	push   %esi
80103d25:	53                   	push   %ebx
80103d26:	83 ec 0c             	sub    $0xc,%esp
  pushcli();
80103d29:	e8 12 09 00 00       	call   80104640 <pushcli>
  c = mycpu();
80103d2e:	e8 ad fa ff ff       	call   801037e0 <mycpu>
  p = c->proc;
80103d33:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80103d39:	e8 42 09 00 00       	call   80104680 <popcli>
  if (curproc == initproc)
80103d3e:	39 35 b8 a5 10 80    	cmp    %esi,0x8010a5b8
80103d44:	8d 5e 28             	lea    0x28(%esi),%ebx
80103d47:	8d 7e 68             	lea    0x68(%esi),%edi
80103d4a:	0f 84 f1 00 00 00    	je     80103e41 <exit+0x121>
    if (curproc->ofile[fd])
80103d50:	8b 03                	mov    (%ebx),%eax
80103d52:	85 c0                	test   %eax,%eax
80103d54:	74 12                	je     80103d68 <exit+0x48>
      fileclose(curproc->ofile[fd]);
80103d56:	83 ec 0c             	sub    $0xc,%esp
80103d59:	50                   	push   %eax
80103d5a:	e8 11 d1 ff ff       	call   80100e70 <fileclose>
      curproc->ofile[fd] = 0;
80103d5f:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80103d65:	83 c4 10             	add    $0x10,%esp
80103d68:	83 c3 04             	add    $0x4,%ebx
  for (fd = 0; fd < NOFILE; fd++)
80103d6b:	39 fb                	cmp    %edi,%ebx
80103d6d:	75 e1                	jne    80103d50 <exit+0x30>
  begin_op();
80103d6f:	e8 5c ee ff ff       	call   80102bd0 <begin_op>
  iput(curproc->cwd);
80103d74:	83 ec 0c             	sub    $0xc,%esp
80103d77:	ff 76 68             	pushl  0x68(%esi)
80103d7a:	e8 61 da ff ff       	call   801017e0 <iput>
  end_op();
80103d7f:	e8 bc ee ff ff       	call   80102c40 <end_op>
  curproc->cwd = 0;
80103d84:	c7 46 68 00 00 00 00 	movl   $0x0,0x68(%esi)
  acquire(&ptable.lock);
80103d8b:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103d92:	e8 79 09 00 00       	call   80104710 <acquire>
  wakeup1(curproc->parent);
80103d97:	8b 56 14             	mov    0x14(%esi),%edx
80103d9a:	83 c4 10             	add    $0x10,%esp
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103d9d:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
80103da2:	eb 10                	jmp    80103db4 <exit+0x94>
80103da4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103da8:	05 0c 01 00 00       	add    $0x10c,%eax
80103dad:	3d 54 70 11 80       	cmp    $0x80117054,%eax
80103db2:	73 1e                	jae    80103dd2 <exit+0xb2>
    if (p->state == SLEEPING && p->chan == chan)
80103db4:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103db8:	75 ee                	jne    80103da8 <exit+0x88>
80103dba:	3b 50 20             	cmp    0x20(%eax),%edx
80103dbd:	75 e9                	jne    80103da8 <exit+0x88>
      p->state = RUNNABLE;
80103dbf:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103dc6:	05 0c 01 00 00       	add    $0x10c,%eax
80103dcb:	3d 54 70 11 80       	cmp    $0x80117054,%eax
80103dd0:	72 e2                	jb     80103db4 <exit+0x94>
      p->parent = initproc;
80103dd2:	8b 0d b8 a5 10 80    	mov    0x8010a5b8,%ecx
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103dd8:	ba 54 2d 11 80       	mov    $0x80112d54,%edx
80103ddd:	eb 0f                	jmp    80103dee <exit+0xce>
80103ddf:	90                   	nop
80103de0:	81 c2 0c 01 00 00    	add    $0x10c,%edx
80103de6:	81 fa 54 70 11 80    	cmp    $0x80117054,%edx
80103dec:	73 3a                	jae    80103e28 <exit+0x108>
    if (p->parent == curproc)
80103dee:	39 72 14             	cmp    %esi,0x14(%edx)
80103df1:	75 ed                	jne    80103de0 <exit+0xc0>
      if (p->state == ZOMBIE)
80103df3:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
      p->parent = initproc;
80103df7:	89 4a 14             	mov    %ecx,0x14(%edx)
      if (p->state == ZOMBIE)
80103dfa:	75 e4                	jne    80103de0 <exit+0xc0>
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103dfc:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
80103e01:	eb 11                	jmp    80103e14 <exit+0xf4>
80103e03:	90                   	nop
80103e04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103e08:	05 0c 01 00 00       	add    $0x10c,%eax
80103e0d:	3d 54 70 11 80       	cmp    $0x80117054,%eax
80103e12:	73 cc                	jae    80103de0 <exit+0xc0>
    if (p->state == SLEEPING && p->chan == chan)
80103e14:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103e18:	75 ee                	jne    80103e08 <exit+0xe8>
80103e1a:	3b 48 20             	cmp    0x20(%eax),%ecx
80103e1d:	75 e9                	jne    80103e08 <exit+0xe8>
      p->state = RUNNABLE;
80103e1f:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80103e26:	eb e0                	jmp    80103e08 <exit+0xe8>
  curproc->state = ZOMBIE;
80103e28:	c7 46 0c 05 00 00 00 	movl   $0x5,0xc(%esi)
  sched();
80103e2f:	e8 2c fe ff ff       	call   80103c60 <sched>
  panic("zombie exit");
80103e34:	83 ec 0c             	sub    $0xc,%esp
80103e37:	68 3d 79 10 80       	push   $0x8010793d
80103e3c:	e8 4f c5 ff ff       	call   80100390 <panic>
    panic("init exiting");
80103e41:	83 ec 0c             	sub    $0xc,%esp
80103e44:	68 30 79 10 80       	push   $0x80107930
80103e49:	e8 42 c5 ff ff       	call   80100390 <panic>
80103e4e:	66 90                	xchg   %ax,%ax

80103e50 <yield>:
{
80103e50:	55                   	push   %ebp
80103e51:	89 e5                	mov    %esp,%ebp
80103e53:	53                   	push   %ebx
80103e54:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock); //DOC: yieldlock
80103e57:	68 20 2d 11 80       	push   $0x80112d20
80103e5c:	e8 af 08 00 00       	call   80104710 <acquire>
  pushcli();
80103e61:	e8 da 07 00 00       	call   80104640 <pushcli>
  c = mycpu();
80103e66:	e8 75 f9 ff ff       	call   801037e0 <mycpu>
  p = c->proc;
80103e6b:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103e71:	e8 0a 08 00 00       	call   80104680 <popcli>
  myproc()->state = RUNNABLE;
80103e76:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  sched();
80103e7d:	e8 de fd ff ff       	call   80103c60 <sched>
  release(&ptable.lock);
80103e82:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103e89:	e8 42 09 00 00       	call   801047d0 <release>
}
80103e8e:	83 c4 10             	add    $0x10,%esp
80103e91:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103e94:	c9                   	leave  
80103e95:	c3                   	ret    
80103e96:	8d 76 00             	lea    0x0(%esi),%esi
80103e99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103ea0 <sleep>:
{
80103ea0:	55                   	push   %ebp
80103ea1:	89 e5                	mov    %esp,%ebp
80103ea3:	57                   	push   %edi
80103ea4:	56                   	push   %esi
80103ea5:	53                   	push   %ebx
80103ea6:	83 ec 0c             	sub    $0xc,%esp
80103ea9:	8b 7d 08             	mov    0x8(%ebp),%edi
80103eac:	8b 75 0c             	mov    0xc(%ebp),%esi
  pushcli();
80103eaf:	e8 8c 07 00 00       	call   80104640 <pushcli>
  c = mycpu();
80103eb4:	e8 27 f9 ff ff       	call   801037e0 <mycpu>
  p = c->proc;
80103eb9:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103ebf:	e8 bc 07 00 00       	call   80104680 <popcli>
  if (p == 0)
80103ec4:	85 db                	test   %ebx,%ebx
80103ec6:	0f 84 87 00 00 00    	je     80103f53 <sleep+0xb3>
  if (lk == 0)
80103ecc:	85 f6                	test   %esi,%esi
80103ece:	74 76                	je     80103f46 <sleep+0xa6>
  if (lk != &ptable.lock)
80103ed0:	81 fe 20 2d 11 80    	cmp    $0x80112d20,%esi
80103ed6:	74 50                	je     80103f28 <sleep+0x88>
    acquire(&ptable.lock); //DOC: sleeplock1
80103ed8:	83 ec 0c             	sub    $0xc,%esp
80103edb:	68 20 2d 11 80       	push   $0x80112d20
80103ee0:	e8 2b 08 00 00       	call   80104710 <acquire>
    release(lk);
80103ee5:	89 34 24             	mov    %esi,(%esp)
80103ee8:	e8 e3 08 00 00       	call   801047d0 <release>
  p->chan = chan;
80103eed:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80103ef0:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80103ef7:	e8 64 fd ff ff       	call   80103c60 <sched>
  p->chan = 0;
80103efc:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
    release(&ptable.lock);
80103f03:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103f0a:	e8 c1 08 00 00       	call   801047d0 <release>
    acquire(lk);
80103f0f:	89 75 08             	mov    %esi,0x8(%ebp)
80103f12:	83 c4 10             	add    $0x10,%esp
}
80103f15:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103f18:	5b                   	pop    %ebx
80103f19:	5e                   	pop    %esi
80103f1a:	5f                   	pop    %edi
80103f1b:	5d                   	pop    %ebp
    acquire(lk);
80103f1c:	e9 ef 07 00 00       	jmp    80104710 <acquire>
80103f21:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  p->chan = chan;
80103f28:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80103f2b:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80103f32:	e8 29 fd ff ff       	call   80103c60 <sched>
  p->chan = 0;
80103f37:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
80103f3e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103f41:	5b                   	pop    %ebx
80103f42:	5e                   	pop    %esi
80103f43:	5f                   	pop    %edi
80103f44:	5d                   	pop    %ebp
80103f45:	c3                   	ret    
    panic("sleep without lk");
80103f46:	83 ec 0c             	sub    $0xc,%esp
80103f49:	68 4f 79 10 80       	push   $0x8010794f
80103f4e:	e8 3d c4 ff ff       	call   80100390 <panic>
    panic("sleep");
80103f53:	83 ec 0c             	sub    $0xc,%esp
80103f56:	68 49 79 10 80       	push   $0x80107949
80103f5b:	e8 30 c4 ff ff       	call   80100390 <panic>

80103f60 <wait>:
{
80103f60:	55                   	push   %ebp
80103f61:	89 e5                	mov    %esp,%ebp
80103f63:	56                   	push   %esi
80103f64:	53                   	push   %ebx
  pushcli();
80103f65:	e8 d6 06 00 00       	call   80104640 <pushcli>
  c = mycpu();
80103f6a:	e8 71 f8 ff ff       	call   801037e0 <mycpu>
  p = c->proc;
80103f6f:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80103f75:	e8 06 07 00 00       	call   80104680 <popcli>
  acquire(&ptable.lock);
80103f7a:	83 ec 0c             	sub    $0xc,%esp
80103f7d:	68 20 2d 11 80       	push   $0x80112d20
80103f82:	e8 89 07 00 00       	call   80104710 <acquire>
80103f87:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
80103f8a:	31 c0                	xor    %eax,%eax
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103f8c:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
80103f91:	eb 13                	jmp    80103fa6 <wait+0x46>
80103f93:	90                   	nop
80103f94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103f98:	81 c3 0c 01 00 00    	add    $0x10c,%ebx
80103f9e:	81 fb 54 70 11 80    	cmp    $0x80117054,%ebx
80103fa4:	73 1e                	jae    80103fc4 <wait+0x64>
      if (p->parent != curproc)
80103fa6:	39 73 14             	cmp    %esi,0x14(%ebx)
80103fa9:	75 ed                	jne    80103f98 <wait+0x38>
      if (p->state == ZOMBIE)
80103fab:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
80103faf:	74 37                	je     80103fe8 <wait+0x88>
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103fb1:	81 c3 0c 01 00 00    	add    $0x10c,%ebx
      havekids = 1;
80103fb7:	b8 01 00 00 00       	mov    $0x1,%eax
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103fbc:	81 fb 54 70 11 80    	cmp    $0x80117054,%ebx
80103fc2:	72 e2                	jb     80103fa6 <wait+0x46>
    if (!havekids || curproc->killed)
80103fc4:	85 c0                	test   %eax,%eax
80103fc6:	74 76                	je     8010403e <wait+0xde>
80103fc8:	8b 46 24             	mov    0x24(%esi),%eax
80103fcb:	85 c0                	test   %eax,%eax
80103fcd:	75 6f                	jne    8010403e <wait+0xde>
    sleep(curproc, &ptable.lock); //DOC: wait-sleep
80103fcf:	83 ec 08             	sub    $0x8,%esp
80103fd2:	68 20 2d 11 80       	push   $0x80112d20
80103fd7:	56                   	push   %esi
80103fd8:	e8 c3 fe ff ff       	call   80103ea0 <sleep>
    havekids = 0;
80103fdd:	83 c4 10             	add    $0x10,%esp
80103fe0:	eb a8                	jmp    80103f8a <wait+0x2a>
80103fe2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        kfree(p->kstack);
80103fe8:	83 ec 0c             	sub    $0xc,%esp
80103feb:	ff 73 08             	pushl  0x8(%ebx)
        pid = p->pid;
80103fee:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80103ff1:	e8 4a e3 ff ff       	call   80102340 <kfree>
        freevm(p->pgdir);
80103ff6:	5a                   	pop    %edx
80103ff7:	ff 73 04             	pushl  0x4(%ebx)
        p->kstack = 0;
80103ffa:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80104001:	e8 2a 30 00 00       	call   80107030 <freevm>
        release(&ptable.lock);
80104006:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
        p->pid = 0;
8010400d:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80104014:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
8010401b:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
8010401f:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
80104026:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
8010402d:	e8 9e 07 00 00       	call   801047d0 <release>
        return pid;
80104032:	83 c4 10             	add    $0x10,%esp
}
80104035:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104038:	89 f0                	mov    %esi,%eax
8010403a:	5b                   	pop    %ebx
8010403b:	5e                   	pop    %esi
8010403c:	5d                   	pop    %ebp
8010403d:	c3                   	ret    
      release(&ptable.lock);
8010403e:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80104041:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
80104046:	68 20 2d 11 80       	push   $0x80112d20
8010404b:	e8 80 07 00 00       	call   801047d0 <release>
      return -1;
80104050:	83 c4 10             	add    $0x10,%esp
80104053:	eb e0                	jmp    80104035 <wait+0xd5>
80104055:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104059:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104060 <wakeup>:
{
80104060:	55                   	push   %ebp
80104061:	89 e5                	mov    %esp,%ebp
80104063:	53                   	push   %ebx
80104064:	83 ec 10             	sub    $0x10,%esp
80104067:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
8010406a:	68 20 2d 11 80       	push   $0x80112d20
8010406f:	e8 9c 06 00 00       	call   80104710 <acquire>
80104074:	83 c4 10             	add    $0x10,%esp
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104077:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
8010407c:	eb 0e                	jmp    8010408c <wakeup+0x2c>
8010407e:	66 90                	xchg   %ax,%ax
80104080:	05 0c 01 00 00       	add    $0x10c,%eax
80104085:	3d 54 70 11 80       	cmp    $0x80117054,%eax
8010408a:	73 1e                	jae    801040aa <wakeup+0x4a>
    if (p->state == SLEEPING && p->chan == chan)
8010408c:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104090:	75 ee                	jne    80104080 <wakeup+0x20>
80104092:	3b 58 20             	cmp    0x20(%eax),%ebx
80104095:	75 e9                	jne    80104080 <wakeup+0x20>
      p->state = RUNNABLE;
80104097:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010409e:	05 0c 01 00 00       	add    $0x10c,%eax
801040a3:	3d 54 70 11 80       	cmp    $0x80117054,%eax
801040a8:	72 e2                	jb     8010408c <wakeup+0x2c>
  release(&ptable.lock);
801040aa:	c7 45 08 20 2d 11 80 	movl   $0x80112d20,0x8(%ebp)
}
801040b1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801040b4:	c9                   	leave  
  release(&ptable.lock);
801040b5:	e9 16 07 00 00       	jmp    801047d0 <release>
801040ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801040c0 <kill>:
{
801040c0:	55                   	push   %ebp
801040c1:	89 e5                	mov    %esp,%ebp
801040c3:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801040c6:	8b 55 08             	mov    0x8(%ebp),%edx
  if (signum > 31 || signum < 0)
801040c9:	83 f9 1f             	cmp    $0x1f,%ecx
801040cc:	77 32                	ja     80104100 <kill+0x40>
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801040ce:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
801040d3:	eb 0f                	jmp    801040e4 <kill+0x24>
801040d5:	8d 76 00             	lea    0x0(%esi),%esi
801040d8:	05 0c 01 00 00       	add    $0x10c,%eax
801040dd:	3d 54 70 11 80       	cmp    $0x80117054,%eax
801040e2:	73 1c                	jae    80104100 <kill+0x40>
    if (p->pid == pid)
801040e4:	39 50 10             	cmp    %edx,0x10(%eax)
801040e7:	75 ef                	jne    801040d8 <kill+0x18>
      p->pending_signals = p->pending_signals | 1 << signum;
801040e9:	ba 01 00 00 00       	mov    $0x1,%edx
801040ee:	d3 e2                	shl    %cl,%edx
801040f0:	09 90 80 00 00 00    	or     %edx,0x80(%eax)
      return 0;
801040f6:	31 c0                	xor    %eax,%eax
}
801040f8:	5d                   	pop    %ebp
801040f9:	c3                   	ret    
801040fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80104100:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104105:	5d                   	pop    %ebp
80104106:	c3                   	ret    
80104107:	89 f6                	mov    %esi,%esi
80104109:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104110 <kill_handler>:
{
80104110:	55                   	push   %ebp
80104111:	89 e5                	mov    %esp,%ebp
80104113:	53                   	push   %ebx
80104114:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80104117:	e8 24 05 00 00       	call   80104640 <pushcli>
  c = mycpu();
8010411c:	e8 bf f6 ff ff       	call   801037e0 <mycpu>
  p = c->proc;
80104121:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104127:	e8 54 05 00 00       	call   80104680 <popcli>
  p->killed = 1;
8010412c:	c7 43 24 01 00 00 00 	movl   $0x1,0x24(%ebx)
}
80104133:	83 c4 04             	add    $0x4,%esp
80104136:	5b                   	pop    %ebx
80104137:	5d                   	pop    %ebp
80104138:	c3                   	ret    
80104139:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104140 <procdump>:
{
80104140:	55                   	push   %ebp
80104141:	89 e5                	mov    %esp,%ebp
80104143:	57                   	push   %edi
80104144:	56                   	push   %esi
80104145:	53                   	push   %ebx
80104146:	8d 75 e8             	lea    -0x18(%ebp),%esi
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104149:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
{
8010414e:	83 ec 3c             	sub    $0x3c,%esp
80104151:	eb 27                	jmp    8010417a <procdump+0x3a>
80104153:	90                   	nop
80104154:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("\n");
80104158:	83 ec 0c             	sub    $0xc,%esp
8010415b:	68 e3 7c 10 80       	push   $0x80107ce3
80104160:	e8 fb c4 ff ff       	call   80100660 <cprintf>
80104165:	83 c4 10             	add    $0x10,%esp
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104168:	81 c3 0c 01 00 00    	add    $0x10c,%ebx
8010416e:	81 fb 54 70 11 80    	cmp    $0x80117054,%ebx
80104174:	0f 83 86 00 00 00    	jae    80104200 <procdump+0xc0>
    if (p->state == UNUSED)
8010417a:	8b 43 0c             	mov    0xc(%ebx),%eax
8010417d:	85 c0                	test   %eax,%eax
8010417f:	74 e7                	je     80104168 <procdump+0x28>
    if (p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104181:	83 f8 05             	cmp    $0x5,%eax
      state = "???";
80104184:	ba 60 79 10 80       	mov    $0x80107960,%edx
    if (p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104189:	77 11                	ja     8010419c <procdump+0x5c>
8010418b:	8b 14 85 c0 79 10 80 	mov    -0x7fef8640(,%eax,4),%edx
      state = "???";
80104192:	b8 60 79 10 80       	mov    $0x80107960,%eax
80104197:	85 d2                	test   %edx,%edx
80104199:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
8010419c:	8d 43 6c             	lea    0x6c(%ebx),%eax
8010419f:	50                   	push   %eax
801041a0:	52                   	push   %edx
801041a1:	ff 73 10             	pushl  0x10(%ebx)
801041a4:	68 64 79 10 80       	push   $0x80107964
801041a9:	e8 b2 c4 ff ff       	call   80100660 <cprintf>
    if (p->state == SLEEPING)
801041ae:	83 c4 10             	add    $0x10,%esp
801041b1:	83 7b 0c 02          	cmpl   $0x2,0xc(%ebx)
801041b5:	75 a1                	jne    80104158 <procdump+0x18>
      getcallerpcs((uint *)p->context->ebp + 2, pc);
801041b7:	8d 45 c0             	lea    -0x40(%ebp),%eax
801041ba:	83 ec 08             	sub    $0x8,%esp
801041bd:	8d 7d c0             	lea    -0x40(%ebp),%edi
801041c0:	50                   	push   %eax
801041c1:	8b 43 1c             	mov    0x1c(%ebx),%eax
801041c4:	8b 40 0c             	mov    0xc(%eax),%eax
801041c7:	83 c0 08             	add    $0x8,%eax
801041ca:	50                   	push   %eax
801041cb:	e8 20 04 00 00       	call   801045f0 <getcallerpcs>
801041d0:	83 c4 10             	add    $0x10,%esp
801041d3:	90                   	nop
801041d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      for (i = 0; i < 10 && pc[i] != 0; i++)
801041d8:	8b 17                	mov    (%edi),%edx
801041da:	85 d2                	test   %edx,%edx
801041dc:	0f 84 76 ff ff ff    	je     80104158 <procdump+0x18>
        cprintf(" %p", pc[i]);
801041e2:	83 ec 08             	sub    $0x8,%esp
801041e5:	83 c7 04             	add    $0x4,%edi
801041e8:	52                   	push   %edx
801041e9:	68 a1 73 10 80       	push   $0x801073a1
801041ee:	e8 6d c4 ff ff       	call   80100660 <cprintf>
      for (i = 0; i < 10 && pc[i] != 0; i++)
801041f3:	83 c4 10             	add    $0x10,%esp
801041f6:	39 fe                	cmp    %edi,%esi
801041f8:	75 de                	jne    801041d8 <procdump+0x98>
801041fa:	e9 59 ff ff ff       	jmp    80104158 <procdump+0x18>
801041ff:	90                   	nop
}
80104200:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104203:	5b                   	pop    %ebx
80104204:	5e                   	pop    %esi
80104205:	5f                   	pop    %edi
80104206:	5d                   	pop    %ebp
80104207:	c3                   	ret    
80104208:	90                   	nop
80104209:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104210 <sigprocmask>:
{
80104210:	55                   	push   %ebp
80104211:	89 e5                	mov    %esp,%ebp
80104213:	53                   	push   %ebx
80104214:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80104217:	e8 24 04 00 00       	call   80104640 <pushcli>
  c = mycpu();
8010421c:	e8 bf f5 ff ff       	call   801037e0 <mycpu>
  p = c->proc;
80104221:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104227:	e8 54 04 00 00       	call   80104680 <popcli>
  p->signal_mask = sigmask;
8010422c:	8b 55 08             	mov    0x8(%ebp),%edx
  uint oldmask = p->signal_mask;
8010422f:	8b 83 84 00 00 00    	mov    0x84(%ebx),%eax
  p->signal_mask = sigmask;
80104235:	89 93 84 00 00 00    	mov    %edx,0x84(%ebx)
}
8010423b:	83 c4 04             	add    $0x4,%esp
8010423e:	5b                   	pop    %ebx
8010423f:	5d                   	pop    %ebp
80104240:	c3                   	ret    
80104241:	eb 0d                	jmp    80104250 <sigaction>
80104243:	90                   	nop
80104244:	90                   	nop
80104245:	90                   	nop
80104246:	90                   	nop
80104247:	90                   	nop
80104248:	90                   	nop
80104249:	90                   	nop
8010424a:	90                   	nop
8010424b:	90                   	nop
8010424c:	90                   	nop
8010424d:	90                   	nop
8010424e:	90                   	nop
8010424f:	90                   	nop

80104250 <sigaction>:
{
80104250:	55                   	push   %ebp
80104251:	89 e5                	mov    %esp,%ebp
80104253:	57                   	push   %edi
80104254:	56                   	push   %esi
80104255:	53                   	push   %ebx
80104256:	83 ec 0c             	sub    $0xc,%esp
80104259:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010425c:	8b 75 10             	mov    0x10(%ebp),%esi
  pushcli();
8010425f:	e8 dc 03 00 00       	call   80104640 <pushcli>
  c = mycpu();
80104264:	e8 77 f5 ff ff       	call   801037e0 <mycpu>
  p = c->proc;
80104269:	8b b8 ac 00 00 00    	mov    0xac(%eax),%edi
  popcli();
8010426f:	e8 0c 04 00 00       	call   80104680 <popcli>
  if (signum > 31 || signum < 0 || signum == SIGSTOP || signum == SIGKILL)
80104274:	8d 43 f7             	lea    -0x9(%ebx),%eax
80104277:	83 e0 f7             	and    $0xfffffff7,%eax
8010427a:	74 34                	je     801042b0 <sigaction+0x60>
8010427c:	83 fb 1f             	cmp    $0x1f,%ebx
8010427f:	77 2f                	ja     801042b0 <sigaction+0x60>
  if (oldact != null)
80104281:	85 f6                	test   %esi,%esi
80104283:	8d 4b 20             	lea    0x20(%ebx),%ecx
80104286:	74 0e                	je     80104296 <sigaction+0x46>
    *oldact = *(struct sigaction *)(p->signal_handlers[signum]);
80104288:	8b 44 8f 08          	mov    0x8(%edi,%ecx,4),%eax
8010428c:	8b 50 04             	mov    0x4(%eax),%edx
8010428f:	8b 00                	mov    (%eax),%eax
80104291:	89 56 04             	mov    %edx,0x4(%esi)
80104294:	89 06                	mov    %eax,(%esi)
  p->signal_handlers[signum] = (struct sigaction *)act;
80104296:	8b 45 0c             	mov    0xc(%ebp),%eax
80104299:	89 44 8f 08          	mov    %eax,0x8(%edi,%ecx,4)
  return 0;
8010429d:	31 c0                	xor    %eax,%eax
}
8010429f:	83 c4 0c             	add    $0xc,%esp
801042a2:	5b                   	pop    %ebx
801042a3:	5e                   	pop    %esi
801042a4:	5f                   	pop    %edi
801042a5:	5d                   	pop    %ebp
801042a6:	c3                   	ret    
801042a7:	89 f6                	mov    %esi,%esi
801042a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
801042b0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801042b5:	eb e8                	jmp    8010429f <sigaction+0x4f>
801042b7:	89 f6                	mov    %esi,%esi
801042b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801042c0 <sigret>:
{
801042c0:	55                   	push   %ebp
801042c1:	89 e5                	mov    %esp,%ebp
801042c3:	57                   	push   %edi
801042c4:	56                   	push   %esi
801042c5:	53                   	push   %ebx
801042c6:	83 ec 0c             	sub    $0xc,%esp
  pushcli();
801042c9:	e8 72 03 00 00       	call   80104640 <pushcli>
  c = mycpu();
801042ce:	e8 0d f5 ff ff       	call   801037e0 <mycpu>
  p = c->proc;
801042d3:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801042d9:	e8 a2 03 00 00       	call   80104680 <popcli>
  *p->tf = *p->backup;
801042de:	b9 13 00 00 00       	mov    $0x13,%ecx
801042e3:	8b 43 18             	mov    0x18(%ebx),%eax
801042e6:	8b 73 7c             	mov    0x7c(%ebx),%esi
801042e9:	89 c7                	mov    %eax,%edi
801042eb:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
}
801042ed:	83 c4 0c             	add    $0xc,%esp
801042f0:	5b                   	pop    %ebx
801042f1:	5e                   	pop    %esi
801042f2:	5f                   	pop    %edi
801042f3:	5d                   	pop    %ebp
801042f4:	c3                   	ret    
801042f5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801042f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104300 <stop_handler>:
{
80104300:	55                   	push   %ebp
80104301:	89 e5                	mov    %esp,%ebp
80104303:	53                   	push   %ebx
80104304:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80104307:	e8 34 03 00 00       	call   80104640 <pushcli>
  c = mycpu();
8010430c:	e8 cf f4 ff ff       	call   801037e0 <mycpu>
  p = c->proc;
80104311:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104317:	e8 64 03 00 00       	call   80104680 <popcli>
  p->suspended = 1;
8010431c:	c7 83 08 01 00 00 01 	movl   $0x1,0x108(%ebx)
80104323:	00 00 00 
}
80104326:	83 c4 04             	add    $0x4,%esp
80104329:	5b                   	pop    %ebx
8010432a:	5d                   	pop    %ebp
8010432b:	c3                   	ret    
8010432c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104330 <cont_handler>:
{
80104330:	55                   	push   %ebp
80104331:	89 e5                	mov    %esp,%ebp
80104333:	53                   	push   %ebx
80104334:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80104337:	e8 04 03 00 00       	call   80104640 <pushcli>
  c = mycpu();
8010433c:	e8 9f f4 ff ff       	call   801037e0 <mycpu>
  p = c->proc;
80104341:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104347:	e8 34 03 00 00       	call   80104680 <popcli>
  if (p->suspended == 1)
8010434c:	83 bb 08 01 00 00 01 	cmpl   $0x1,0x108(%ebx)
80104353:	75 0a                	jne    8010435f <cont_handler+0x2f>
    p->suspended = 0;
80104355:	c7 83 08 01 00 00 00 	movl   $0x0,0x108(%ebx)
8010435c:	00 00 00 
}
8010435f:	83 c4 04             	add    $0x4,%esp
80104362:	5b                   	pop    %ebx
80104363:	5d                   	pop    %ebp
80104364:	c3                   	ret    
80104365:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104369:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104370 <check_for_signals>:

int check_for_signals(void)
{
80104370:	55                   	push   %ebp
80104371:	89 e5                	mov    %esp,%ebp
80104373:	57                   	push   %edi
80104374:	56                   	push   %esi
80104375:	53                   	push   %ebx
80104376:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
80104379:	e8 c2 02 00 00       	call   80104640 <pushcli>
  c = mycpu();
8010437e:	e8 5d f4 ff ff       	call   801037e0 <mycpu>
  p = c->proc;
80104383:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104389:	e8 f2 02 00 00       	call   80104680 <popcli>
            stop_handler();
          else
            kill_handler();
        }
         else{
          int functionSize = ((int)check_for_signals - (int)call_sigret); 
8010438e:	b8 70 43 10 80       	mov    $0x80104370,%eax
  for (int i = 0; i < 32; i = i + 1)
80104393:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  int signal_index = 1;
8010439a:	ba 01 00 00 00       	mov    $0x1,%edx
          int functionSize = ((int)check_for_signals - (int)call_sigret); 
8010439f:	2d 30 36 10 80       	sub    $0x80103630,%eax
801043a4:	89 45 dc             	mov    %eax,-0x24(%ebp)
801043a7:	89 f6                	mov    %esi,%esi
801043a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if (((p->pending_signals & signal_index) == signal_index) & (is_blocked == 0))
801043b0:	8b 83 80 00 00 00    	mov    0x80(%ebx),%eax
801043b6:	21 d0                	and    %edx,%eax
801043b8:	39 d0                	cmp    %edx,%eax
801043ba:	0f 85 91 00 00 00    	jne    80104451 <check_for_signals+0xe1>
    is_blocked = (p->signal_mask & signal_index) == signal_index; //check if signal is blocked
801043c0:	8b 83 84 00 00 00    	mov    0x84(%ebx),%eax
801043c6:	21 d0                	and    %edx,%eax
    if (((p->pending_signals & signal_index) == signal_index) & (is_blocked == 0))
801043c8:	39 d0                	cmp    %edx,%eax
801043ca:	0f 84 81 00 00 00    	je     80104451 <check_for_signals+0xe1>
      if ((int)p->signal_handlers[i] != SIG_IGN)
801043d0:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801043d3:	8b 84 bb 88 00 00 00 	mov    0x88(%ebx,%edi,4),%eax
801043da:	83 f8 01             	cmp    $0x1,%eax
801043dd:	74 70                	je     8010444f <check_for_signals+0xdf>
        if ((int)p->signal_handlers[i] == SIG_DFL)
801043df:	85 c0                	test   %eax,%eax
801043e1:	0f 84 89 00 00 00    	je     80104470 <check_for_signals+0x100>
          //backup trapframe 
          *p->backup = *p->tf;
801043e7:	8b 73 18             	mov    0x18(%ebx),%esi
801043ea:	8b 7b 7c             	mov    0x7c(%ebx),%edi
801043ed:	b9 13 00 00 00       	mov    $0x13,%ecx
801043f2:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

          //put functionn
          p->tf->esp -= functionSize;
801043f4:	8b 75 dc             	mov    -0x24(%ebp),%esi
          memmove((int*)p->tf->esp, &call_sigret, functionSize);
801043f7:	83 ec 04             	sub    $0x4,%esp
801043fa:	89 55 e0             	mov    %edx,-0x20(%ebp)
          p->tf->esp -= functionSize;
801043fd:	8b 43 18             	mov    0x18(%ebx),%eax
80104400:	29 70 44             	sub    %esi,0x44(%eax)
          memmove((int*)p->tf->esp, &call_sigret, functionSize);
80104403:	56                   	push   %esi
80104404:	68 30 36 10 80       	push   $0x80103630
80104409:	8b 43 18             	mov    0x18(%ebx),%eax
8010440c:	ff 70 44             	pushl  0x44(%eax)
8010440f:	e8 bc 04 00 00       	call   801048d0 <memmove>
          uint returnAdress = p->tf->esp;
80104414:	8b 4b 18             	mov    0x18(%ebx),%ecx
          *(int*)p->tf->esp = i;
          //push return address
          p->tf->esp -= sizeof(int);
          *(int*)p->tf->esp = returnAdress; //adrees to the function that calls sigret 
          struct sigaction * handler = (struct sigaction *)p->signal_handlers[i]; 
          p->tf->eip = (uint)handler-> sa_handler; 
80104417:	8b 55 e0             	mov    -0x20(%ebp),%edx
8010441a:	83 c4 10             	add    $0x10,%esp
          uint returnAdress = p->tf->esp;
8010441d:	8b 41 44             	mov    0x44(%ecx),%eax
          p->tf->esp -= sizeof i;
80104420:	8d 70 fc             	lea    -0x4(%eax),%esi
80104423:	89 71 44             	mov    %esi,0x44(%ecx)
          *(int*)p->tf->esp = i;
80104426:	8b 4b 18             	mov    0x18(%ebx),%ecx
80104429:	8b 75 e4             	mov    -0x1c(%ebp),%esi
8010442c:	8b 49 44             	mov    0x44(%ecx),%ecx
8010442f:	89 31                	mov    %esi,(%ecx)
          p->tf->esp -= sizeof(int);
80104431:	8b 4b 18             	mov    0x18(%ebx),%ecx
80104434:	83 69 44 04          	subl   $0x4,0x44(%ecx)
          *(int*)p->tf->esp = returnAdress; //adrees to the function that calls sigret 
80104438:	8b 4b 18             	mov    0x18(%ebx),%ecx
8010443b:	8b 49 44             	mov    0x44(%ecx),%ecx
8010443e:	89 01                	mov    %eax,(%ecx)
          p->tf->eip = (uint)handler-> sa_handler; 
80104440:	8b 8c b3 88 00 00 00 	mov    0x88(%ebx,%esi,4),%ecx
80104447:	8b 43 18             	mov    0x18(%ebx),%eax
8010444a:	8b 09                	mov    (%ecx),%ecx
8010444c:	89 48 38             	mov    %ecx,0x38(%eax)

        }
      }
      signal_index = signal_index << 1;
8010444f:	01 d2                	add    %edx,%edx
  for (int i = 0; i < 32; i = i + 1)
80104451:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
80104455:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80104458:	83 f8 20             	cmp    $0x20,%eax
8010445b:	0f 85 4f ff ff ff    	jne    801043b0 <check_for_signals+0x40>
      }
  }
  return 1;
}
80104461:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104464:	b8 01 00 00 00       	mov    $0x1,%eax
80104469:	5b                   	pop    %ebx
8010446a:	5e                   	pop    %esi
8010446b:	5f                   	pop    %edi
8010446c:	5d                   	pop    %ebp
8010446d:	c3                   	ret    
8010446e:	66 90                	xchg   %ax,%ax
          if (i == SIGCONT)
80104470:	83 ff 13             	cmp    $0x13,%edi
80104473:	74 1d                	je     80104492 <check_for_signals+0x122>
          else if (i == SIGSTOP)
80104475:	83 7d e4 11          	cmpl   $0x11,-0x1c(%ebp)
80104479:	89 55 e0             	mov    %edx,-0x20(%ebp)
8010447c:	74 0a                	je     80104488 <check_for_signals+0x118>
            kill_handler();
8010447e:	e8 8d fc ff ff       	call   80104110 <kill_handler>
80104483:	8b 55 e0             	mov    -0x20(%ebp),%edx
80104486:	eb c7                	jmp    8010444f <check_for_signals+0xdf>
            stop_handler();
80104488:	e8 73 fe ff ff       	call   80104300 <stop_handler>
8010448d:	8b 55 e0             	mov    -0x20(%ebp),%edx
80104490:	eb bd                	jmp    8010444f <check_for_signals+0xdf>
80104492:	89 55 e0             	mov    %edx,-0x20(%ebp)
            cont_handler();
80104495:	e8 96 fe ff ff       	call   80104330 <cont_handler>
8010449a:	8b 55 e0             	mov    -0x20(%ebp),%edx
8010449d:	eb b0                	jmp    8010444f <check_for_signals+0xdf>
8010449f:	90                   	nop

801044a0 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
801044a0:	55                   	push   %ebp
801044a1:	89 e5                	mov    %esp,%ebp
801044a3:	53                   	push   %ebx
801044a4:	83 ec 0c             	sub    $0xc,%esp
801044a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
801044aa:	68 d8 79 10 80       	push   $0x801079d8
801044af:	8d 43 04             	lea    0x4(%ebx),%eax
801044b2:	50                   	push   %eax
801044b3:	e8 18 01 00 00       	call   801045d0 <initlock>
  lk->name = name;
801044b8:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
801044bb:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
801044c1:	83 c4 10             	add    $0x10,%esp
  lk->pid = 0;
801044c4:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
801044cb:	89 43 38             	mov    %eax,0x38(%ebx)
}
801044ce:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801044d1:	c9                   	leave  
801044d2:	c3                   	ret    
801044d3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801044d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801044e0 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
801044e0:	55                   	push   %ebp
801044e1:	89 e5                	mov    %esp,%ebp
801044e3:	56                   	push   %esi
801044e4:	53                   	push   %ebx
801044e5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
801044e8:	83 ec 0c             	sub    $0xc,%esp
801044eb:	8d 73 04             	lea    0x4(%ebx),%esi
801044ee:	56                   	push   %esi
801044ef:	e8 1c 02 00 00       	call   80104710 <acquire>
  while (lk->locked) {
801044f4:	8b 13                	mov    (%ebx),%edx
801044f6:	83 c4 10             	add    $0x10,%esp
801044f9:	85 d2                	test   %edx,%edx
801044fb:	74 16                	je     80104513 <acquiresleep+0x33>
801044fd:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
80104500:	83 ec 08             	sub    $0x8,%esp
80104503:	56                   	push   %esi
80104504:	53                   	push   %ebx
80104505:	e8 96 f9 ff ff       	call   80103ea0 <sleep>
  while (lk->locked) {
8010450a:	8b 03                	mov    (%ebx),%eax
8010450c:	83 c4 10             	add    $0x10,%esp
8010450f:	85 c0                	test   %eax,%eax
80104511:	75 ed                	jne    80104500 <acquiresleep+0x20>
  }
  lk->locked = 1;
80104513:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80104519:	e8 62 f3 ff ff       	call   80103880 <myproc>
8010451e:	8b 40 10             	mov    0x10(%eax),%eax
80104521:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80104524:	89 75 08             	mov    %esi,0x8(%ebp)
}
80104527:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010452a:	5b                   	pop    %ebx
8010452b:	5e                   	pop    %esi
8010452c:	5d                   	pop    %ebp
  release(&lk->lk);
8010452d:	e9 9e 02 00 00       	jmp    801047d0 <release>
80104532:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104539:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104540 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
80104540:	55                   	push   %ebp
80104541:	89 e5                	mov    %esp,%ebp
80104543:	56                   	push   %esi
80104544:	53                   	push   %ebx
80104545:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104548:	83 ec 0c             	sub    $0xc,%esp
8010454b:	8d 73 04             	lea    0x4(%ebx),%esi
8010454e:	56                   	push   %esi
8010454f:	e8 bc 01 00 00       	call   80104710 <acquire>
  lk->locked = 0;
80104554:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
8010455a:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80104561:	89 1c 24             	mov    %ebx,(%esp)
80104564:	e8 f7 fa ff ff       	call   80104060 <wakeup>
  release(&lk->lk);
80104569:	89 75 08             	mov    %esi,0x8(%ebp)
8010456c:	83 c4 10             	add    $0x10,%esp
}
8010456f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104572:	5b                   	pop    %ebx
80104573:	5e                   	pop    %esi
80104574:	5d                   	pop    %ebp
  release(&lk->lk);
80104575:	e9 56 02 00 00       	jmp    801047d0 <release>
8010457a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104580 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
80104580:	55                   	push   %ebp
80104581:	89 e5                	mov    %esp,%ebp
80104583:	57                   	push   %edi
80104584:	56                   	push   %esi
80104585:	53                   	push   %ebx
80104586:	31 ff                	xor    %edi,%edi
80104588:	83 ec 18             	sub    $0x18,%esp
8010458b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  
  acquire(&lk->lk);
8010458e:	8d 73 04             	lea    0x4(%ebx),%esi
80104591:	56                   	push   %esi
80104592:	e8 79 01 00 00       	call   80104710 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
80104597:	8b 03                	mov    (%ebx),%eax
80104599:	83 c4 10             	add    $0x10,%esp
8010459c:	85 c0                	test   %eax,%eax
8010459e:	74 13                	je     801045b3 <holdingsleep+0x33>
801045a0:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
801045a3:	e8 d8 f2 ff ff       	call   80103880 <myproc>
801045a8:	39 58 10             	cmp    %ebx,0x10(%eax)
801045ab:	0f 94 c0             	sete   %al
801045ae:	0f b6 c0             	movzbl %al,%eax
801045b1:	89 c7                	mov    %eax,%edi
  release(&lk->lk);
801045b3:	83 ec 0c             	sub    $0xc,%esp
801045b6:	56                   	push   %esi
801045b7:	e8 14 02 00 00       	call   801047d0 <release>
  return r;
}
801045bc:	8d 65 f4             	lea    -0xc(%ebp),%esp
801045bf:	89 f8                	mov    %edi,%eax
801045c1:	5b                   	pop    %ebx
801045c2:	5e                   	pop    %esi
801045c3:	5f                   	pop    %edi
801045c4:	5d                   	pop    %ebp
801045c5:	c3                   	ret    
801045c6:	66 90                	xchg   %ax,%ax
801045c8:	66 90                	xchg   %ax,%ax
801045ca:	66 90                	xchg   %ax,%ax
801045cc:	66 90                	xchg   %ax,%ax
801045ce:	66 90                	xchg   %ax,%ax

801045d0 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
801045d0:	55                   	push   %ebp
801045d1:	89 e5                	mov    %esp,%ebp
801045d3:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
801045d6:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
801045d9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
801045df:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
801045e2:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
801045e9:	5d                   	pop    %ebp
801045ea:	c3                   	ret    
801045eb:	90                   	nop
801045ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801045f0 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
801045f0:	55                   	push   %ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
801045f1:	31 d2                	xor    %edx,%edx
{
801045f3:	89 e5                	mov    %esp,%ebp
801045f5:	53                   	push   %ebx
  ebp = (uint*)v - 2;
801045f6:	8b 45 08             	mov    0x8(%ebp),%eax
{
801045f9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  ebp = (uint*)v - 2;
801045fc:	83 e8 08             	sub    $0x8,%eax
801045ff:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104600:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
80104606:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
8010460c:	77 1a                	ja     80104628 <getcallerpcs+0x38>
      break;
    pcs[i] = ebp[1];     // saved %eip
8010460e:	8b 58 04             	mov    0x4(%eax),%ebx
80104611:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
80104614:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
80104617:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80104619:	83 fa 0a             	cmp    $0xa,%edx
8010461c:	75 e2                	jne    80104600 <getcallerpcs+0x10>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
8010461e:	5b                   	pop    %ebx
8010461f:	5d                   	pop    %ebp
80104620:	c3                   	ret    
80104621:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104628:	8d 04 91             	lea    (%ecx,%edx,4),%eax
8010462b:	83 c1 28             	add    $0x28,%ecx
8010462e:	66 90                	xchg   %ax,%ax
    pcs[i] = 0;
80104630:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104636:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
80104639:	39 c1                	cmp    %eax,%ecx
8010463b:	75 f3                	jne    80104630 <getcallerpcs+0x40>
}
8010463d:	5b                   	pop    %ebx
8010463e:	5d                   	pop    %ebp
8010463f:	c3                   	ret    

80104640 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80104640:	55                   	push   %ebp
80104641:	89 e5                	mov    %esp,%ebp
80104643:	53                   	push   %ebx
80104644:	83 ec 04             	sub    $0x4,%esp
80104647:	9c                   	pushf  
80104648:	5b                   	pop    %ebx
  asm volatile("cli");
80104649:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
8010464a:	e8 91 f1 ff ff       	call   801037e0 <mycpu>
8010464f:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80104655:	85 c0                	test   %eax,%eax
80104657:	75 11                	jne    8010466a <pushcli+0x2a>
    mycpu()->intena = eflags & FL_IF;
80104659:	81 e3 00 02 00 00    	and    $0x200,%ebx
8010465f:	e8 7c f1 ff ff       	call   801037e0 <mycpu>
80104664:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
  mycpu()->ncli += 1;
8010466a:	e8 71 f1 ff ff       	call   801037e0 <mycpu>
8010466f:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
80104676:	83 c4 04             	add    $0x4,%esp
80104679:	5b                   	pop    %ebx
8010467a:	5d                   	pop    %ebp
8010467b:	c3                   	ret    
8010467c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104680 <popcli>:

void
popcli(void)
{
80104680:	55                   	push   %ebp
80104681:	89 e5                	mov    %esp,%ebp
80104683:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104686:	9c                   	pushf  
80104687:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104688:	f6 c4 02             	test   $0x2,%ah
8010468b:	75 35                	jne    801046c2 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
8010468d:	e8 4e f1 ff ff       	call   801037e0 <mycpu>
80104692:	83 a8 a4 00 00 00 01 	subl   $0x1,0xa4(%eax)
80104699:	78 34                	js     801046cf <popcli+0x4f>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
8010469b:	e8 40 f1 ff ff       	call   801037e0 <mycpu>
801046a0:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
801046a6:	85 d2                	test   %edx,%edx
801046a8:	74 06                	je     801046b0 <popcli+0x30>
    sti();
}
801046aa:	c9                   	leave  
801046ab:	c3                   	ret    
801046ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(mycpu()->ncli == 0 && mycpu()->intena)
801046b0:	e8 2b f1 ff ff       	call   801037e0 <mycpu>
801046b5:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
801046bb:	85 c0                	test   %eax,%eax
801046bd:	74 eb                	je     801046aa <popcli+0x2a>
  asm volatile("sti");
801046bf:	fb                   	sti    
}
801046c0:	c9                   	leave  
801046c1:	c3                   	ret    
    panic("popcli - interruptible");
801046c2:	83 ec 0c             	sub    $0xc,%esp
801046c5:	68 e3 79 10 80       	push   $0x801079e3
801046ca:	e8 c1 bc ff ff       	call   80100390 <panic>
    panic("popcli");
801046cf:	83 ec 0c             	sub    $0xc,%esp
801046d2:	68 fa 79 10 80       	push   $0x801079fa
801046d7:	e8 b4 bc ff ff       	call   80100390 <panic>
801046dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801046e0 <holding>:
{
801046e0:	55                   	push   %ebp
801046e1:	89 e5                	mov    %esp,%ebp
801046e3:	56                   	push   %esi
801046e4:	53                   	push   %ebx
801046e5:	8b 75 08             	mov    0x8(%ebp),%esi
801046e8:	31 db                	xor    %ebx,%ebx
  pushcli();
801046ea:	e8 51 ff ff ff       	call   80104640 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
801046ef:	8b 06                	mov    (%esi),%eax
801046f1:	85 c0                	test   %eax,%eax
801046f3:	74 10                	je     80104705 <holding+0x25>
801046f5:	8b 5e 08             	mov    0x8(%esi),%ebx
801046f8:	e8 e3 f0 ff ff       	call   801037e0 <mycpu>
801046fd:	39 c3                	cmp    %eax,%ebx
801046ff:	0f 94 c3             	sete   %bl
80104702:	0f b6 db             	movzbl %bl,%ebx
  popcli();
80104705:	e8 76 ff ff ff       	call   80104680 <popcli>
}
8010470a:	89 d8                	mov    %ebx,%eax
8010470c:	5b                   	pop    %ebx
8010470d:	5e                   	pop    %esi
8010470e:	5d                   	pop    %ebp
8010470f:	c3                   	ret    

80104710 <acquire>:
{
80104710:	55                   	push   %ebp
80104711:	89 e5                	mov    %esp,%ebp
80104713:	56                   	push   %esi
80104714:	53                   	push   %ebx
  pushcli(); // disable interrupts to avoid deadlock.
80104715:	e8 26 ff ff ff       	call   80104640 <pushcli>
  if(holding(lk))
8010471a:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010471d:	83 ec 0c             	sub    $0xc,%esp
80104720:	53                   	push   %ebx
80104721:	e8 ba ff ff ff       	call   801046e0 <holding>
80104726:	83 c4 10             	add    $0x10,%esp
80104729:	85 c0                	test   %eax,%eax
8010472b:	0f 85 83 00 00 00    	jne    801047b4 <acquire+0xa4>
80104731:	89 c6                	mov    %eax,%esi
  asm volatile("lock; xchgl %0, %1" :
80104733:	ba 01 00 00 00       	mov    $0x1,%edx
80104738:	eb 09                	jmp    80104743 <acquire+0x33>
8010473a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104740:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104743:	89 d0                	mov    %edx,%eax
80104745:	f0 87 03             	lock xchg %eax,(%ebx)
  while(xchg(&lk->locked, 1) != 0)
80104748:	85 c0                	test   %eax,%eax
8010474a:	75 f4                	jne    80104740 <acquire+0x30>
  __sync_synchronize();
8010474c:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
80104751:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104754:	e8 87 f0 ff ff       	call   801037e0 <mycpu>
  getcallerpcs(&lk, lk->pcs);
80104759:	8d 53 0c             	lea    0xc(%ebx),%edx
  lk->cpu = mycpu();
8010475c:	89 43 08             	mov    %eax,0x8(%ebx)
  ebp = (uint*)v - 2;
8010475f:	89 e8                	mov    %ebp,%eax
80104761:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104768:	8d 88 00 00 00 80    	lea    -0x80000000(%eax),%ecx
8010476e:	81 f9 fe ff ff 7f    	cmp    $0x7ffffffe,%ecx
80104774:	77 1a                	ja     80104790 <acquire+0x80>
    pcs[i] = ebp[1];     // saved %eip
80104776:	8b 48 04             	mov    0x4(%eax),%ecx
80104779:	89 0c b2             	mov    %ecx,(%edx,%esi,4)
  for(i = 0; i < 10; i++){
8010477c:	83 c6 01             	add    $0x1,%esi
    ebp = (uint*)ebp[0]; // saved %ebp
8010477f:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80104781:	83 fe 0a             	cmp    $0xa,%esi
80104784:	75 e2                	jne    80104768 <acquire+0x58>
}
80104786:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104789:	5b                   	pop    %ebx
8010478a:	5e                   	pop    %esi
8010478b:	5d                   	pop    %ebp
8010478c:	c3                   	ret    
8010478d:	8d 76 00             	lea    0x0(%esi),%esi
80104790:	8d 04 b2             	lea    (%edx,%esi,4),%eax
80104793:	83 c2 28             	add    $0x28,%edx
80104796:	8d 76 00             	lea    0x0(%esi),%esi
80104799:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    pcs[i] = 0;
801047a0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
801047a6:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
801047a9:	39 d0                	cmp    %edx,%eax
801047ab:	75 f3                	jne    801047a0 <acquire+0x90>
}
801047ad:	8d 65 f8             	lea    -0x8(%ebp),%esp
801047b0:	5b                   	pop    %ebx
801047b1:	5e                   	pop    %esi
801047b2:	5d                   	pop    %ebp
801047b3:	c3                   	ret    
    panic("acquire");
801047b4:	83 ec 0c             	sub    $0xc,%esp
801047b7:	68 01 7a 10 80       	push   $0x80107a01
801047bc:	e8 cf bb ff ff       	call   80100390 <panic>
801047c1:	eb 0d                	jmp    801047d0 <release>
801047c3:	90                   	nop
801047c4:	90                   	nop
801047c5:	90                   	nop
801047c6:	90                   	nop
801047c7:	90                   	nop
801047c8:	90                   	nop
801047c9:	90                   	nop
801047ca:	90                   	nop
801047cb:	90                   	nop
801047cc:	90                   	nop
801047cd:	90                   	nop
801047ce:	90                   	nop
801047cf:	90                   	nop

801047d0 <release>:
{
801047d0:	55                   	push   %ebp
801047d1:	89 e5                	mov    %esp,%ebp
801047d3:	53                   	push   %ebx
801047d4:	83 ec 10             	sub    $0x10,%esp
801047d7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holding(lk))
801047da:	53                   	push   %ebx
801047db:	e8 00 ff ff ff       	call   801046e0 <holding>
801047e0:	83 c4 10             	add    $0x10,%esp
801047e3:	85 c0                	test   %eax,%eax
801047e5:	74 22                	je     80104809 <release+0x39>
  lk->pcs[0] = 0;
801047e7:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
801047ee:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
801047f5:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
801047fa:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
80104800:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104803:	c9                   	leave  
  popcli();
80104804:	e9 77 fe ff ff       	jmp    80104680 <popcli>
    panic("release");
80104809:	83 ec 0c             	sub    $0xc,%esp
8010480c:	68 09 7a 10 80       	push   $0x80107a09
80104811:	e8 7a bb ff ff       	call   80100390 <panic>
80104816:	66 90                	xchg   %ax,%ax
80104818:	66 90                	xchg   %ax,%ax
8010481a:	66 90                	xchg   %ax,%ax
8010481c:	66 90                	xchg   %ax,%ax
8010481e:	66 90                	xchg   %ax,%ax

80104820 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80104820:	55                   	push   %ebp
80104821:	89 e5                	mov    %esp,%ebp
80104823:	57                   	push   %edi
80104824:	53                   	push   %ebx
80104825:	8b 55 08             	mov    0x8(%ebp),%edx
80104828:	8b 4d 10             	mov    0x10(%ebp),%ecx
  if ((int)dst%4 == 0 && n%4 == 0){
8010482b:	f6 c2 03             	test   $0x3,%dl
8010482e:	75 05                	jne    80104835 <memset+0x15>
80104830:	f6 c1 03             	test   $0x3,%cl
80104833:	74 13                	je     80104848 <memset+0x28>
  asm volatile("cld; rep stosb" :
80104835:	89 d7                	mov    %edx,%edi
80104837:	8b 45 0c             	mov    0xc(%ebp),%eax
8010483a:	fc                   	cld    
8010483b:	f3 aa                	rep stos %al,%es:(%edi)
    c &= 0xFF;
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
8010483d:	5b                   	pop    %ebx
8010483e:	89 d0                	mov    %edx,%eax
80104840:	5f                   	pop    %edi
80104841:	5d                   	pop    %ebp
80104842:	c3                   	ret    
80104843:	90                   	nop
80104844:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c &= 0xFF;
80104848:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
8010484c:	c1 e9 02             	shr    $0x2,%ecx
8010484f:	89 f8                	mov    %edi,%eax
80104851:	89 fb                	mov    %edi,%ebx
80104853:	c1 e0 18             	shl    $0x18,%eax
80104856:	c1 e3 10             	shl    $0x10,%ebx
80104859:	09 d8                	or     %ebx,%eax
8010485b:	09 f8                	or     %edi,%eax
8010485d:	c1 e7 08             	shl    $0x8,%edi
80104860:	09 f8                	or     %edi,%eax
  asm volatile("cld; rep stosl" :
80104862:	89 d7                	mov    %edx,%edi
80104864:	fc                   	cld    
80104865:	f3 ab                	rep stos %eax,%es:(%edi)
}
80104867:	5b                   	pop    %ebx
80104868:	89 d0                	mov    %edx,%eax
8010486a:	5f                   	pop    %edi
8010486b:	5d                   	pop    %ebp
8010486c:	c3                   	ret    
8010486d:	8d 76 00             	lea    0x0(%esi),%esi

80104870 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80104870:	55                   	push   %ebp
80104871:	89 e5                	mov    %esp,%ebp
80104873:	57                   	push   %edi
80104874:	56                   	push   %esi
80104875:	53                   	push   %ebx
80104876:	8b 5d 10             	mov    0x10(%ebp),%ebx
80104879:	8b 75 08             	mov    0x8(%ebp),%esi
8010487c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
8010487f:	85 db                	test   %ebx,%ebx
80104881:	74 29                	je     801048ac <memcmp+0x3c>
    if(*s1 != *s2)
80104883:	0f b6 16             	movzbl (%esi),%edx
80104886:	0f b6 0f             	movzbl (%edi),%ecx
80104889:	38 d1                	cmp    %dl,%cl
8010488b:	75 2b                	jne    801048b8 <memcmp+0x48>
8010488d:	b8 01 00 00 00       	mov    $0x1,%eax
80104892:	eb 14                	jmp    801048a8 <memcmp+0x38>
80104894:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104898:	0f b6 14 06          	movzbl (%esi,%eax,1),%edx
8010489c:	83 c0 01             	add    $0x1,%eax
8010489f:	0f b6 4c 07 ff       	movzbl -0x1(%edi,%eax,1),%ecx
801048a4:	38 ca                	cmp    %cl,%dl
801048a6:	75 10                	jne    801048b8 <memcmp+0x48>
  while(n-- > 0){
801048a8:	39 d8                	cmp    %ebx,%eax
801048aa:	75 ec                	jne    80104898 <memcmp+0x28>
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
}
801048ac:	5b                   	pop    %ebx
  return 0;
801048ad:	31 c0                	xor    %eax,%eax
}
801048af:	5e                   	pop    %esi
801048b0:	5f                   	pop    %edi
801048b1:	5d                   	pop    %ebp
801048b2:	c3                   	ret    
801048b3:	90                   	nop
801048b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      return *s1 - *s2;
801048b8:	0f b6 c2             	movzbl %dl,%eax
}
801048bb:	5b                   	pop    %ebx
      return *s1 - *s2;
801048bc:	29 c8                	sub    %ecx,%eax
}
801048be:	5e                   	pop    %esi
801048bf:	5f                   	pop    %edi
801048c0:	5d                   	pop    %ebp
801048c1:	c3                   	ret    
801048c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801048c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801048d0 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
801048d0:	55                   	push   %ebp
801048d1:	89 e5                	mov    %esp,%ebp
801048d3:	56                   	push   %esi
801048d4:	53                   	push   %ebx
801048d5:	8b 45 08             	mov    0x8(%ebp),%eax
801048d8:	8b 5d 0c             	mov    0xc(%ebp),%ebx
801048db:	8b 75 10             	mov    0x10(%ebp),%esi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
801048de:	39 c3                	cmp    %eax,%ebx
801048e0:	73 26                	jae    80104908 <memmove+0x38>
801048e2:	8d 0c 33             	lea    (%ebx,%esi,1),%ecx
801048e5:	39 c8                	cmp    %ecx,%eax
801048e7:	73 1f                	jae    80104908 <memmove+0x38>
    s += n;
    d += n;
    while(n-- > 0)
801048e9:	85 f6                	test   %esi,%esi
801048eb:	8d 56 ff             	lea    -0x1(%esi),%edx
801048ee:	74 0f                	je     801048ff <memmove+0x2f>
      *--d = *--s;
801048f0:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
801048f4:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    while(n-- > 0)
801048f7:	83 ea 01             	sub    $0x1,%edx
801048fa:	83 fa ff             	cmp    $0xffffffff,%edx
801048fd:	75 f1                	jne    801048f0 <memmove+0x20>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
801048ff:	5b                   	pop    %ebx
80104900:	5e                   	pop    %esi
80104901:	5d                   	pop    %ebp
80104902:	c3                   	ret    
80104903:	90                   	nop
80104904:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    while(n-- > 0)
80104908:	31 d2                	xor    %edx,%edx
8010490a:	85 f6                	test   %esi,%esi
8010490c:	74 f1                	je     801048ff <memmove+0x2f>
8010490e:	66 90                	xchg   %ax,%ax
      *d++ = *s++;
80104910:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
80104914:	88 0c 10             	mov    %cl,(%eax,%edx,1)
80104917:	83 c2 01             	add    $0x1,%edx
    while(n-- > 0)
8010491a:	39 d6                	cmp    %edx,%esi
8010491c:	75 f2                	jne    80104910 <memmove+0x40>
}
8010491e:	5b                   	pop    %ebx
8010491f:	5e                   	pop    %esi
80104920:	5d                   	pop    %ebp
80104921:	c3                   	ret    
80104922:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104929:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104930 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
80104930:	55                   	push   %ebp
80104931:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
}
80104933:	5d                   	pop    %ebp
  return memmove(dst, src, n);
80104934:	eb 9a                	jmp    801048d0 <memmove>
80104936:	8d 76 00             	lea    0x0(%esi),%esi
80104939:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104940 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
80104940:	55                   	push   %ebp
80104941:	89 e5                	mov    %esp,%ebp
80104943:	57                   	push   %edi
80104944:	56                   	push   %esi
80104945:	8b 7d 10             	mov    0x10(%ebp),%edi
80104948:	53                   	push   %ebx
80104949:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010494c:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(n > 0 && *p && *p == *q)
8010494f:	85 ff                	test   %edi,%edi
80104951:	74 2f                	je     80104982 <strncmp+0x42>
80104953:	0f b6 01             	movzbl (%ecx),%eax
80104956:	0f b6 1e             	movzbl (%esi),%ebx
80104959:	84 c0                	test   %al,%al
8010495b:	74 37                	je     80104994 <strncmp+0x54>
8010495d:	38 c3                	cmp    %al,%bl
8010495f:	75 33                	jne    80104994 <strncmp+0x54>
80104961:	01 f7                	add    %esi,%edi
80104963:	eb 13                	jmp    80104978 <strncmp+0x38>
80104965:	8d 76 00             	lea    0x0(%esi),%esi
80104968:	0f b6 01             	movzbl (%ecx),%eax
8010496b:	84 c0                	test   %al,%al
8010496d:	74 21                	je     80104990 <strncmp+0x50>
8010496f:	0f b6 1a             	movzbl (%edx),%ebx
80104972:	89 d6                	mov    %edx,%esi
80104974:	38 d8                	cmp    %bl,%al
80104976:	75 1c                	jne    80104994 <strncmp+0x54>
    n--, p++, q++;
80104978:	8d 56 01             	lea    0x1(%esi),%edx
8010497b:	83 c1 01             	add    $0x1,%ecx
  while(n > 0 && *p && *p == *q)
8010497e:	39 fa                	cmp    %edi,%edx
80104980:	75 e6                	jne    80104968 <strncmp+0x28>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
}
80104982:	5b                   	pop    %ebx
    return 0;
80104983:	31 c0                	xor    %eax,%eax
}
80104985:	5e                   	pop    %esi
80104986:	5f                   	pop    %edi
80104987:	5d                   	pop    %ebp
80104988:	c3                   	ret    
80104989:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104990:	0f b6 5e 01          	movzbl 0x1(%esi),%ebx
  return (uchar)*p - (uchar)*q;
80104994:	29 d8                	sub    %ebx,%eax
}
80104996:	5b                   	pop    %ebx
80104997:	5e                   	pop    %esi
80104998:	5f                   	pop    %edi
80104999:	5d                   	pop    %ebp
8010499a:	c3                   	ret    
8010499b:	90                   	nop
8010499c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801049a0 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
801049a0:	55                   	push   %ebp
801049a1:	89 e5                	mov    %esp,%ebp
801049a3:	56                   	push   %esi
801049a4:	53                   	push   %ebx
801049a5:	8b 45 08             	mov    0x8(%ebp),%eax
801049a8:	8b 5d 0c             	mov    0xc(%ebp),%ebx
801049ab:	8b 4d 10             	mov    0x10(%ebp),%ecx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
801049ae:	89 c2                	mov    %eax,%edx
801049b0:	eb 19                	jmp    801049cb <strncpy+0x2b>
801049b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801049b8:	83 c3 01             	add    $0x1,%ebx
801049bb:	0f b6 4b ff          	movzbl -0x1(%ebx),%ecx
801049bf:	83 c2 01             	add    $0x1,%edx
801049c2:	84 c9                	test   %cl,%cl
801049c4:	88 4a ff             	mov    %cl,-0x1(%edx)
801049c7:	74 09                	je     801049d2 <strncpy+0x32>
801049c9:	89 f1                	mov    %esi,%ecx
801049cb:	85 c9                	test   %ecx,%ecx
801049cd:	8d 71 ff             	lea    -0x1(%ecx),%esi
801049d0:	7f e6                	jg     801049b8 <strncpy+0x18>
    ;
  while(n-- > 0)
801049d2:	31 c9                	xor    %ecx,%ecx
801049d4:	85 f6                	test   %esi,%esi
801049d6:	7e 17                	jle    801049ef <strncpy+0x4f>
801049d8:	90                   	nop
801049d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    *s++ = 0;
801049e0:	c6 04 0a 00          	movb   $0x0,(%edx,%ecx,1)
801049e4:	89 f3                	mov    %esi,%ebx
801049e6:	83 c1 01             	add    $0x1,%ecx
801049e9:	29 cb                	sub    %ecx,%ebx
  while(n-- > 0)
801049eb:	85 db                	test   %ebx,%ebx
801049ed:	7f f1                	jg     801049e0 <strncpy+0x40>
  return os;
}
801049ef:	5b                   	pop    %ebx
801049f0:	5e                   	pop    %esi
801049f1:	5d                   	pop    %ebp
801049f2:	c3                   	ret    
801049f3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801049f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104a00 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80104a00:	55                   	push   %ebp
80104a01:	89 e5                	mov    %esp,%ebp
80104a03:	56                   	push   %esi
80104a04:	53                   	push   %ebx
80104a05:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104a08:	8b 45 08             	mov    0x8(%ebp),%eax
80104a0b:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  if(n <= 0)
80104a0e:	85 c9                	test   %ecx,%ecx
80104a10:	7e 26                	jle    80104a38 <safestrcpy+0x38>
80104a12:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
80104a16:	89 c1                	mov    %eax,%ecx
80104a18:	eb 17                	jmp    80104a31 <safestrcpy+0x31>
80104a1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80104a20:	83 c2 01             	add    $0x1,%edx
80104a23:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
80104a27:	83 c1 01             	add    $0x1,%ecx
80104a2a:	84 db                	test   %bl,%bl
80104a2c:	88 59 ff             	mov    %bl,-0x1(%ecx)
80104a2f:	74 04                	je     80104a35 <safestrcpy+0x35>
80104a31:	39 f2                	cmp    %esi,%edx
80104a33:	75 eb                	jne    80104a20 <safestrcpy+0x20>
    ;
  *s = 0;
80104a35:	c6 01 00             	movb   $0x0,(%ecx)
  return os;
}
80104a38:	5b                   	pop    %ebx
80104a39:	5e                   	pop    %esi
80104a3a:	5d                   	pop    %ebp
80104a3b:	c3                   	ret    
80104a3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104a40 <strlen>:

int
strlen(const char *s)
{
80104a40:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80104a41:	31 c0                	xor    %eax,%eax
{
80104a43:	89 e5                	mov    %esp,%ebp
80104a45:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
80104a48:	80 3a 00             	cmpb   $0x0,(%edx)
80104a4b:	74 0c                	je     80104a59 <strlen+0x19>
80104a4d:	8d 76 00             	lea    0x0(%esi),%esi
80104a50:	83 c0 01             	add    $0x1,%eax
80104a53:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80104a57:	75 f7                	jne    80104a50 <strlen+0x10>
    ;
  return n;
}
80104a59:	5d                   	pop    %ebp
80104a5a:	c3                   	ret    

80104a5b <swtch>:
80104a5b:	8b 44 24 04          	mov    0x4(%esp),%eax
80104a5f:	8b 54 24 08          	mov    0x8(%esp),%edx
80104a63:	55                   	push   %ebp
80104a64:	53                   	push   %ebx
80104a65:	56                   	push   %esi
80104a66:	57                   	push   %edi
80104a67:	89 20                	mov    %esp,(%eax)
80104a69:	89 d4                	mov    %edx,%esp
80104a6b:	5f                   	pop    %edi
80104a6c:	5e                   	pop    %esi
80104a6d:	5b                   	pop    %ebx
80104a6e:	5d                   	pop    %ebp
80104a6f:	c3                   	ret    

80104a70 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80104a70:	55                   	push   %ebp
80104a71:	89 e5                	mov    %esp,%ebp
80104a73:	53                   	push   %ebx
80104a74:	83 ec 04             	sub    $0x4,%esp
80104a77:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
80104a7a:	e8 01 ee ff ff       	call   80103880 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104a7f:	8b 00                	mov    (%eax),%eax
80104a81:	39 d8                	cmp    %ebx,%eax
80104a83:	76 1b                	jbe    80104aa0 <fetchint+0x30>
80104a85:	8d 53 04             	lea    0x4(%ebx),%edx
80104a88:	39 d0                	cmp    %edx,%eax
80104a8a:	72 14                	jb     80104aa0 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
80104a8c:	8b 45 0c             	mov    0xc(%ebp),%eax
80104a8f:	8b 13                	mov    (%ebx),%edx
80104a91:	89 10                	mov    %edx,(%eax)
  return 0;
80104a93:	31 c0                	xor    %eax,%eax
}
80104a95:	83 c4 04             	add    $0x4,%esp
80104a98:	5b                   	pop    %ebx
80104a99:	5d                   	pop    %ebp
80104a9a:	c3                   	ret    
80104a9b:	90                   	nop
80104a9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104aa0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104aa5:	eb ee                	jmp    80104a95 <fetchint+0x25>
80104aa7:	89 f6                	mov    %esi,%esi
80104aa9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104ab0 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80104ab0:	55                   	push   %ebp
80104ab1:	89 e5                	mov    %esp,%ebp
80104ab3:	53                   	push   %ebx
80104ab4:	83 ec 04             	sub    $0x4,%esp
80104ab7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
80104aba:	e8 c1 ed ff ff       	call   80103880 <myproc>

  if(addr >= curproc->sz)
80104abf:	39 18                	cmp    %ebx,(%eax)
80104ac1:	76 29                	jbe    80104aec <fetchstr+0x3c>
    return -1;
  *pp = (char*)addr;
80104ac3:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80104ac6:	89 da                	mov    %ebx,%edx
80104ac8:	89 19                	mov    %ebx,(%ecx)
  ep = (char*)curproc->sz;
80104aca:	8b 00                	mov    (%eax),%eax
  for(s = *pp; s < ep; s++){
80104acc:	39 c3                	cmp    %eax,%ebx
80104ace:	73 1c                	jae    80104aec <fetchstr+0x3c>
    if(*s == 0)
80104ad0:	80 3b 00             	cmpb   $0x0,(%ebx)
80104ad3:	75 10                	jne    80104ae5 <fetchstr+0x35>
80104ad5:	eb 39                	jmp    80104b10 <fetchstr+0x60>
80104ad7:	89 f6                	mov    %esi,%esi
80104ad9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104ae0:	80 3a 00             	cmpb   $0x0,(%edx)
80104ae3:	74 1b                	je     80104b00 <fetchstr+0x50>
  for(s = *pp; s < ep; s++){
80104ae5:	83 c2 01             	add    $0x1,%edx
80104ae8:	39 d0                	cmp    %edx,%eax
80104aea:	77 f4                	ja     80104ae0 <fetchstr+0x30>
    return -1;
80104aec:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      return s - *pp;
  }
  return -1;
}
80104af1:	83 c4 04             	add    $0x4,%esp
80104af4:	5b                   	pop    %ebx
80104af5:	5d                   	pop    %ebp
80104af6:	c3                   	ret    
80104af7:	89 f6                	mov    %esi,%esi
80104af9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104b00:	83 c4 04             	add    $0x4,%esp
80104b03:	89 d0                	mov    %edx,%eax
80104b05:	29 d8                	sub    %ebx,%eax
80104b07:	5b                   	pop    %ebx
80104b08:	5d                   	pop    %ebp
80104b09:	c3                   	ret    
80104b0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(*s == 0)
80104b10:	31 c0                	xor    %eax,%eax
      return s - *pp;
80104b12:	eb dd                	jmp    80104af1 <fetchstr+0x41>
80104b14:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104b1a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104b20 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80104b20:	55                   	push   %ebp
80104b21:	89 e5                	mov    %esp,%ebp
80104b23:	56                   	push   %esi
80104b24:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104b25:	e8 56 ed ff ff       	call   80103880 <myproc>
80104b2a:	8b 40 18             	mov    0x18(%eax),%eax
80104b2d:	8b 55 08             	mov    0x8(%ebp),%edx
80104b30:	8b 40 44             	mov    0x44(%eax),%eax
80104b33:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80104b36:	e8 45 ed ff ff       	call   80103880 <myproc>
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104b3b:	8b 00                	mov    (%eax),%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104b3d:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104b40:	39 c6                	cmp    %eax,%esi
80104b42:	73 1c                	jae    80104b60 <argint+0x40>
80104b44:	8d 53 08             	lea    0x8(%ebx),%edx
80104b47:	39 d0                	cmp    %edx,%eax
80104b49:	72 15                	jb     80104b60 <argint+0x40>
  *ip = *(int*)(addr);
80104b4b:	8b 45 0c             	mov    0xc(%ebp),%eax
80104b4e:	8b 53 04             	mov    0x4(%ebx),%edx
80104b51:	89 10                	mov    %edx,(%eax)
  return 0;
80104b53:	31 c0                	xor    %eax,%eax
}
80104b55:	5b                   	pop    %ebx
80104b56:	5e                   	pop    %esi
80104b57:	5d                   	pop    %ebp
80104b58:	c3                   	ret    
80104b59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104b60:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104b65:	eb ee                	jmp    80104b55 <argint+0x35>
80104b67:	89 f6                	mov    %esi,%esi
80104b69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104b70 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80104b70:	55                   	push   %ebp
80104b71:	89 e5                	mov    %esp,%ebp
80104b73:	56                   	push   %esi
80104b74:	53                   	push   %ebx
80104b75:	83 ec 10             	sub    $0x10,%esp
80104b78:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int i;
  struct proc *curproc = myproc();
80104b7b:	e8 00 ed ff ff       	call   80103880 <myproc>
80104b80:	89 c6                	mov    %eax,%esi
 
  if(argint(n, &i) < 0)
80104b82:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104b85:	83 ec 08             	sub    $0x8,%esp
80104b88:	50                   	push   %eax
80104b89:	ff 75 08             	pushl  0x8(%ebp)
80104b8c:	e8 8f ff ff ff       	call   80104b20 <argint>
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80104b91:	83 c4 10             	add    $0x10,%esp
80104b94:	85 c0                	test   %eax,%eax
80104b96:	78 28                	js     80104bc0 <argptr+0x50>
80104b98:	85 db                	test   %ebx,%ebx
80104b9a:	78 24                	js     80104bc0 <argptr+0x50>
80104b9c:	8b 16                	mov    (%esi),%edx
80104b9e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104ba1:	39 c2                	cmp    %eax,%edx
80104ba3:	76 1b                	jbe    80104bc0 <argptr+0x50>
80104ba5:	01 c3                	add    %eax,%ebx
80104ba7:	39 da                	cmp    %ebx,%edx
80104ba9:	72 15                	jb     80104bc0 <argptr+0x50>
    return -1;
  *pp = (char*)i;
80104bab:	8b 55 0c             	mov    0xc(%ebp),%edx
80104bae:	89 02                	mov    %eax,(%edx)
  return 0;
80104bb0:	31 c0                	xor    %eax,%eax
}
80104bb2:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104bb5:	5b                   	pop    %ebx
80104bb6:	5e                   	pop    %esi
80104bb7:	5d                   	pop    %ebp
80104bb8:	c3                   	ret    
80104bb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104bc0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104bc5:	eb eb                	jmp    80104bb2 <argptr+0x42>
80104bc7:	89 f6                	mov    %esi,%esi
80104bc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104bd0 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80104bd0:	55                   	push   %ebp
80104bd1:	89 e5                	mov    %esp,%ebp
80104bd3:	83 ec 20             	sub    $0x20,%esp
  int addr;
  if(argint(n, &addr) < 0)
80104bd6:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104bd9:	50                   	push   %eax
80104bda:	ff 75 08             	pushl  0x8(%ebp)
80104bdd:	e8 3e ff ff ff       	call   80104b20 <argint>
80104be2:	83 c4 10             	add    $0x10,%esp
80104be5:	85 c0                	test   %eax,%eax
80104be7:	78 17                	js     80104c00 <argstr+0x30>
    return -1;
  return fetchstr(addr, pp);
80104be9:	83 ec 08             	sub    $0x8,%esp
80104bec:	ff 75 0c             	pushl  0xc(%ebp)
80104bef:	ff 75 f4             	pushl  -0xc(%ebp)
80104bf2:	e8 b9 fe ff ff       	call   80104ab0 <fetchstr>
80104bf7:	83 c4 10             	add    $0x10,%esp
}
80104bfa:	c9                   	leave  
80104bfb:	c3                   	ret    
80104bfc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104c00:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104c05:	c9                   	leave  
80104c06:	c3                   	ret    
80104c07:	89 f6                	mov    %esi,%esi
80104c09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104c10 <syscall>:
[SYS_sigret] sys_sigret
};

void
syscall(void)
{
80104c10:	55                   	push   %ebp
80104c11:	89 e5                	mov    %esp,%ebp
80104c13:	53                   	push   %ebx
80104c14:	83 ec 04             	sub    $0x4,%esp
  int num;
  struct proc *curproc = myproc();
80104c17:	e8 64 ec ff ff       	call   80103880 <myproc>
80104c1c:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
80104c1e:	8b 40 18             	mov    0x18(%eax),%eax
80104c21:	8b 40 1c             	mov    0x1c(%eax),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80104c24:	8d 50 ff             	lea    -0x1(%eax),%edx
80104c27:	83 fa 17             	cmp    $0x17,%edx
80104c2a:	77 1c                	ja     80104c48 <syscall+0x38>
80104c2c:	8b 14 85 40 7a 10 80 	mov    -0x7fef85c0(,%eax,4),%edx
80104c33:	85 d2                	test   %edx,%edx
80104c35:	74 11                	je     80104c48 <syscall+0x38>
    curproc->tf->eax = syscalls[num]();
80104c37:	ff d2                	call   *%edx
80104c39:	8b 53 18             	mov    0x18(%ebx),%edx
80104c3c:	89 42 1c             	mov    %eax,0x1c(%edx)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
80104c3f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104c42:	c9                   	leave  
80104c43:	c3                   	ret    
80104c44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("%d %s: unknown sys call %d\n",
80104c48:	50                   	push   %eax
            curproc->pid, curproc->name, num);
80104c49:	8d 43 6c             	lea    0x6c(%ebx),%eax
    cprintf("%d %s: unknown sys call %d\n",
80104c4c:	50                   	push   %eax
80104c4d:	ff 73 10             	pushl  0x10(%ebx)
80104c50:	68 11 7a 10 80       	push   $0x80107a11
80104c55:	e8 06 ba ff ff       	call   80100660 <cprintf>
    curproc->tf->eax = -1;
80104c5a:	8b 43 18             	mov    0x18(%ebx),%eax
80104c5d:	83 c4 10             	add    $0x10,%esp
80104c60:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
80104c67:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104c6a:	c9                   	leave  
80104c6b:	c3                   	ret    
80104c6c:	66 90                	xchg   %ax,%ax
80104c6e:	66 90                	xchg   %ax,%ax

80104c70 <create>:
80104c70:	55                   	push   %ebp
80104c71:	89 e5                	mov    %esp,%ebp
80104c73:	57                   	push   %edi
80104c74:	56                   	push   %esi
80104c75:	53                   	push   %ebx
80104c76:	8d 75 da             	lea    -0x26(%ebp),%esi
80104c79:	83 ec 34             	sub    $0x34,%esp
80104c7c:	89 4d d0             	mov    %ecx,-0x30(%ebp)
80104c7f:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104c82:	56                   	push   %esi
80104c83:	50                   	push   %eax
80104c84:	89 55 d4             	mov    %edx,-0x2c(%ebp)
80104c87:	89 4d cc             	mov    %ecx,-0x34(%ebp)
80104c8a:	e8 a1 d2 ff ff       	call   80101f30 <nameiparent>
80104c8f:	83 c4 10             	add    $0x10,%esp
80104c92:	85 c0                	test   %eax,%eax
80104c94:	0f 84 46 01 00 00    	je     80104de0 <create+0x170>
80104c9a:	83 ec 0c             	sub    $0xc,%esp
80104c9d:	89 c3                	mov    %eax,%ebx
80104c9f:	50                   	push   %eax
80104ca0:	e8 0b ca ff ff       	call   801016b0 <ilock>
80104ca5:	83 c4 0c             	add    $0xc,%esp
80104ca8:	6a 00                	push   $0x0
80104caa:	56                   	push   %esi
80104cab:	53                   	push   %ebx
80104cac:	e8 2f cf ff ff       	call   80101be0 <dirlookup>
80104cb1:	83 c4 10             	add    $0x10,%esp
80104cb4:	85 c0                	test   %eax,%eax
80104cb6:	89 c7                	mov    %eax,%edi
80104cb8:	74 36                	je     80104cf0 <create+0x80>
80104cba:	83 ec 0c             	sub    $0xc,%esp
80104cbd:	53                   	push   %ebx
80104cbe:	e8 7d cc ff ff       	call   80101940 <iunlockput>
80104cc3:	89 3c 24             	mov    %edi,(%esp)
80104cc6:	e8 e5 c9 ff ff       	call   801016b0 <ilock>
80104ccb:	83 c4 10             	add    $0x10,%esp
80104cce:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
80104cd3:	0f 85 97 00 00 00    	jne    80104d70 <create+0x100>
80104cd9:	66 83 7f 50 02       	cmpw   $0x2,0x50(%edi)
80104cde:	0f 85 8c 00 00 00    	jne    80104d70 <create+0x100>
80104ce4:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104ce7:	89 f8                	mov    %edi,%eax
80104ce9:	5b                   	pop    %ebx
80104cea:	5e                   	pop    %esi
80104ceb:	5f                   	pop    %edi
80104cec:	5d                   	pop    %ebp
80104ced:	c3                   	ret    
80104cee:	66 90                	xchg   %ax,%ax
80104cf0:	0f bf 45 d4          	movswl -0x2c(%ebp),%eax
80104cf4:	83 ec 08             	sub    $0x8,%esp
80104cf7:	50                   	push   %eax
80104cf8:	ff 33                	pushl  (%ebx)
80104cfa:	e8 41 c8 ff ff       	call   80101540 <ialloc>
80104cff:	83 c4 10             	add    $0x10,%esp
80104d02:	85 c0                	test   %eax,%eax
80104d04:	89 c7                	mov    %eax,%edi
80104d06:	0f 84 e8 00 00 00    	je     80104df4 <create+0x184>
80104d0c:	83 ec 0c             	sub    $0xc,%esp
80104d0f:	50                   	push   %eax
80104d10:	e8 9b c9 ff ff       	call   801016b0 <ilock>
80104d15:	0f b7 45 d0          	movzwl -0x30(%ebp),%eax
80104d19:	66 89 47 52          	mov    %ax,0x52(%edi)
80104d1d:	0f b7 45 cc          	movzwl -0x34(%ebp),%eax
80104d21:	66 89 47 54          	mov    %ax,0x54(%edi)
80104d25:	b8 01 00 00 00       	mov    $0x1,%eax
80104d2a:	66 89 47 56          	mov    %ax,0x56(%edi)
80104d2e:	89 3c 24             	mov    %edi,(%esp)
80104d31:	e8 ca c8 ff ff       	call   80101600 <iupdate>
80104d36:	83 c4 10             	add    $0x10,%esp
80104d39:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
80104d3e:	74 50                	je     80104d90 <create+0x120>
80104d40:	83 ec 04             	sub    $0x4,%esp
80104d43:	ff 77 04             	pushl  0x4(%edi)
80104d46:	56                   	push   %esi
80104d47:	53                   	push   %ebx
80104d48:	e8 03 d1 ff ff       	call   80101e50 <dirlink>
80104d4d:	83 c4 10             	add    $0x10,%esp
80104d50:	85 c0                	test   %eax,%eax
80104d52:	0f 88 8f 00 00 00    	js     80104de7 <create+0x177>
80104d58:	83 ec 0c             	sub    $0xc,%esp
80104d5b:	53                   	push   %ebx
80104d5c:	e8 df cb ff ff       	call   80101940 <iunlockput>
80104d61:	83 c4 10             	add    $0x10,%esp
80104d64:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104d67:	89 f8                	mov    %edi,%eax
80104d69:	5b                   	pop    %ebx
80104d6a:	5e                   	pop    %esi
80104d6b:	5f                   	pop    %edi
80104d6c:	5d                   	pop    %ebp
80104d6d:	c3                   	ret    
80104d6e:	66 90                	xchg   %ax,%ax
80104d70:	83 ec 0c             	sub    $0xc,%esp
80104d73:	57                   	push   %edi
80104d74:	31 ff                	xor    %edi,%edi
80104d76:	e8 c5 cb ff ff       	call   80101940 <iunlockput>
80104d7b:	83 c4 10             	add    $0x10,%esp
80104d7e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104d81:	89 f8                	mov    %edi,%eax
80104d83:	5b                   	pop    %ebx
80104d84:	5e                   	pop    %esi
80104d85:	5f                   	pop    %edi
80104d86:	5d                   	pop    %ebp
80104d87:	c3                   	ret    
80104d88:	90                   	nop
80104d89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104d90:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
80104d95:	83 ec 0c             	sub    $0xc,%esp
80104d98:	53                   	push   %ebx
80104d99:	e8 62 c8 ff ff       	call   80101600 <iupdate>
80104d9e:	83 c4 0c             	add    $0xc,%esp
80104da1:	ff 77 04             	pushl  0x4(%edi)
80104da4:	68 c0 7a 10 80       	push   $0x80107ac0
80104da9:	57                   	push   %edi
80104daa:	e8 a1 d0 ff ff       	call   80101e50 <dirlink>
80104daf:	83 c4 10             	add    $0x10,%esp
80104db2:	85 c0                	test   %eax,%eax
80104db4:	78 1c                	js     80104dd2 <create+0x162>
80104db6:	83 ec 04             	sub    $0x4,%esp
80104db9:	ff 73 04             	pushl  0x4(%ebx)
80104dbc:	68 bf 7a 10 80       	push   $0x80107abf
80104dc1:	57                   	push   %edi
80104dc2:	e8 89 d0 ff ff       	call   80101e50 <dirlink>
80104dc7:	83 c4 10             	add    $0x10,%esp
80104dca:	85 c0                	test   %eax,%eax
80104dcc:	0f 89 6e ff ff ff    	jns    80104d40 <create+0xd0>
80104dd2:	83 ec 0c             	sub    $0xc,%esp
80104dd5:	68 b3 7a 10 80       	push   $0x80107ab3
80104dda:	e8 b1 b5 ff ff       	call   80100390 <panic>
80104ddf:	90                   	nop
80104de0:	31 ff                	xor    %edi,%edi
80104de2:	e9 fd fe ff ff       	jmp    80104ce4 <create+0x74>
80104de7:	83 ec 0c             	sub    $0xc,%esp
80104dea:	68 c2 7a 10 80       	push   $0x80107ac2
80104def:	e8 9c b5 ff ff       	call   80100390 <panic>
80104df4:	83 ec 0c             	sub    $0xc,%esp
80104df7:	68 a4 7a 10 80       	push   $0x80107aa4
80104dfc:	e8 8f b5 ff ff       	call   80100390 <panic>
80104e01:	eb 0d                	jmp    80104e10 <argfd.constprop.0>
80104e03:	90                   	nop
80104e04:	90                   	nop
80104e05:	90                   	nop
80104e06:	90                   	nop
80104e07:	90                   	nop
80104e08:	90                   	nop
80104e09:	90                   	nop
80104e0a:	90                   	nop
80104e0b:	90                   	nop
80104e0c:	90                   	nop
80104e0d:	90                   	nop
80104e0e:	90                   	nop
80104e0f:	90                   	nop

80104e10 <argfd.constprop.0>:
80104e10:	55                   	push   %ebp
80104e11:	89 e5                	mov    %esp,%ebp
80104e13:	56                   	push   %esi
80104e14:	53                   	push   %ebx
80104e15:	89 c3                	mov    %eax,%ebx
80104e17:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104e1a:	89 d6                	mov    %edx,%esi
80104e1c:	83 ec 18             	sub    $0x18,%esp
80104e1f:	50                   	push   %eax
80104e20:	6a 00                	push   $0x0
80104e22:	e8 f9 fc ff ff       	call   80104b20 <argint>
80104e27:	83 c4 10             	add    $0x10,%esp
80104e2a:	85 c0                	test   %eax,%eax
80104e2c:	78 2a                	js     80104e58 <argfd.constprop.0+0x48>
80104e2e:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80104e32:	77 24                	ja     80104e58 <argfd.constprop.0+0x48>
80104e34:	e8 47 ea ff ff       	call   80103880 <myproc>
80104e39:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104e3c:	8b 44 90 28          	mov    0x28(%eax,%edx,4),%eax
80104e40:	85 c0                	test   %eax,%eax
80104e42:	74 14                	je     80104e58 <argfd.constprop.0+0x48>
80104e44:	85 db                	test   %ebx,%ebx
80104e46:	74 02                	je     80104e4a <argfd.constprop.0+0x3a>
80104e48:	89 13                	mov    %edx,(%ebx)
80104e4a:	89 06                	mov    %eax,(%esi)
80104e4c:	31 c0                	xor    %eax,%eax
80104e4e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104e51:	5b                   	pop    %ebx
80104e52:	5e                   	pop    %esi
80104e53:	5d                   	pop    %ebp
80104e54:	c3                   	ret    
80104e55:	8d 76 00             	lea    0x0(%esi),%esi
80104e58:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104e5d:	eb ef                	jmp    80104e4e <argfd.constprop.0+0x3e>
80104e5f:	90                   	nop

80104e60 <sys_dup>:
80104e60:	55                   	push   %ebp
80104e61:	31 c0                	xor    %eax,%eax
80104e63:	89 e5                	mov    %esp,%ebp
80104e65:	56                   	push   %esi
80104e66:	53                   	push   %ebx
80104e67:	8d 55 f4             	lea    -0xc(%ebp),%edx
80104e6a:	83 ec 10             	sub    $0x10,%esp
80104e6d:	e8 9e ff ff ff       	call   80104e10 <argfd.constprop.0>
80104e72:	85 c0                	test   %eax,%eax
80104e74:	78 42                	js     80104eb8 <sys_dup+0x58>
80104e76:	8b 75 f4             	mov    -0xc(%ebp),%esi
80104e79:	31 db                	xor    %ebx,%ebx
80104e7b:	e8 00 ea ff ff       	call   80103880 <myproc>
80104e80:	eb 0e                	jmp    80104e90 <sys_dup+0x30>
80104e82:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104e88:	83 c3 01             	add    $0x1,%ebx
80104e8b:	83 fb 10             	cmp    $0x10,%ebx
80104e8e:	74 28                	je     80104eb8 <sys_dup+0x58>
80104e90:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80104e94:	85 d2                	test   %edx,%edx
80104e96:	75 f0                	jne    80104e88 <sys_dup+0x28>
80104e98:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
80104e9c:	83 ec 0c             	sub    $0xc,%esp
80104e9f:	ff 75 f4             	pushl  -0xc(%ebp)
80104ea2:	e8 79 bf ff ff       	call   80100e20 <filedup>
80104ea7:	83 c4 10             	add    $0x10,%esp
80104eaa:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104ead:	89 d8                	mov    %ebx,%eax
80104eaf:	5b                   	pop    %ebx
80104eb0:	5e                   	pop    %esi
80104eb1:	5d                   	pop    %ebp
80104eb2:	c3                   	ret    
80104eb3:	90                   	nop
80104eb4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104eb8:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104ebb:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80104ec0:	89 d8                	mov    %ebx,%eax
80104ec2:	5b                   	pop    %ebx
80104ec3:	5e                   	pop    %esi
80104ec4:	5d                   	pop    %ebp
80104ec5:	c3                   	ret    
80104ec6:	8d 76 00             	lea    0x0(%esi),%esi
80104ec9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104ed0 <sys_read>:
80104ed0:	55                   	push   %ebp
80104ed1:	31 c0                	xor    %eax,%eax
80104ed3:	89 e5                	mov    %esp,%ebp
80104ed5:	83 ec 18             	sub    $0x18,%esp
80104ed8:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104edb:	e8 30 ff ff ff       	call   80104e10 <argfd.constprop.0>
80104ee0:	85 c0                	test   %eax,%eax
80104ee2:	78 4c                	js     80104f30 <sys_read+0x60>
80104ee4:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104ee7:	83 ec 08             	sub    $0x8,%esp
80104eea:	50                   	push   %eax
80104eeb:	6a 02                	push   $0x2
80104eed:	e8 2e fc ff ff       	call   80104b20 <argint>
80104ef2:	83 c4 10             	add    $0x10,%esp
80104ef5:	85 c0                	test   %eax,%eax
80104ef7:	78 37                	js     80104f30 <sys_read+0x60>
80104ef9:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104efc:	83 ec 04             	sub    $0x4,%esp
80104eff:	ff 75 f0             	pushl  -0x10(%ebp)
80104f02:	50                   	push   %eax
80104f03:	6a 01                	push   $0x1
80104f05:	e8 66 fc ff ff       	call   80104b70 <argptr>
80104f0a:	83 c4 10             	add    $0x10,%esp
80104f0d:	85 c0                	test   %eax,%eax
80104f0f:	78 1f                	js     80104f30 <sys_read+0x60>
80104f11:	83 ec 04             	sub    $0x4,%esp
80104f14:	ff 75 f0             	pushl  -0x10(%ebp)
80104f17:	ff 75 f4             	pushl  -0xc(%ebp)
80104f1a:	ff 75 ec             	pushl  -0x14(%ebp)
80104f1d:	e8 6e c0 ff ff       	call   80100f90 <fileread>
80104f22:	83 c4 10             	add    $0x10,%esp
80104f25:	c9                   	leave  
80104f26:	c3                   	ret    
80104f27:	89 f6                	mov    %esi,%esi
80104f29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104f30:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104f35:	c9                   	leave  
80104f36:	c3                   	ret    
80104f37:	89 f6                	mov    %esi,%esi
80104f39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104f40 <sys_write>:
80104f40:	55                   	push   %ebp
80104f41:	31 c0                	xor    %eax,%eax
80104f43:	89 e5                	mov    %esp,%ebp
80104f45:	83 ec 18             	sub    $0x18,%esp
80104f48:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104f4b:	e8 c0 fe ff ff       	call   80104e10 <argfd.constprop.0>
80104f50:	85 c0                	test   %eax,%eax
80104f52:	78 4c                	js     80104fa0 <sys_write+0x60>
80104f54:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104f57:	83 ec 08             	sub    $0x8,%esp
80104f5a:	50                   	push   %eax
80104f5b:	6a 02                	push   $0x2
80104f5d:	e8 be fb ff ff       	call   80104b20 <argint>
80104f62:	83 c4 10             	add    $0x10,%esp
80104f65:	85 c0                	test   %eax,%eax
80104f67:	78 37                	js     80104fa0 <sys_write+0x60>
80104f69:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104f6c:	83 ec 04             	sub    $0x4,%esp
80104f6f:	ff 75 f0             	pushl  -0x10(%ebp)
80104f72:	50                   	push   %eax
80104f73:	6a 01                	push   $0x1
80104f75:	e8 f6 fb ff ff       	call   80104b70 <argptr>
80104f7a:	83 c4 10             	add    $0x10,%esp
80104f7d:	85 c0                	test   %eax,%eax
80104f7f:	78 1f                	js     80104fa0 <sys_write+0x60>
80104f81:	83 ec 04             	sub    $0x4,%esp
80104f84:	ff 75 f0             	pushl  -0x10(%ebp)
80104f87:	ff 75 f4             	pushl  -0xc(%ebp)
80104f8a:	ff 75 ec             	pushl  -0x14(%ebp)
80104f8d:	e8 8e c0 ff ff       	call   80101020 <filewrite>
80104f92:	83 c4 10             	add    $0x10,%esp
80104f95:	c9                   	leave  
80104f96:	c3                   	ret    
80104f97:	89 f6                	mov    %esi,%esi
80104f99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104fa0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104fa5:	c9                   	leave  
80104fa6:	c3                   	ret    
80104fa7:	89 f6                	mov    %esi,%esi
80104fa9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104fb0 <sys_close>:
80104fb0:	55                   	push   %ebp
80104fb1:	89 e5                	mov    %esp,%ebp
80104fb3:	83 ec 18             	sub    $0x18,%esp
80104fb6:	8d 55 f4             	lea    -0xc(%ebp),%edx
80104fb9:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104fbc:	e8 4f fe ff ff       	call   80104e10 <argfd.constprop.0>
80104fc1:	85 c0                	test   %eax,%eax
80104fc3:	78 2b                	js     80104ff0 <sys_close+0x40>
80104fc5:	e8 b6 e8 ff ff       	call   80103880 <myproc>
80104fca:	8b 55 f0             	mov    -0x10(%ebp),%edx
80104fcd:	83 ec 0c             	sub    $0xc,%esp
80104fd0:	c7 44 90 28 00 00 00 	movl   $0x0,0x28(%eax,%edx,4)
80104fd7:	00 
80104fd8:	ff 75 f4             	pushl  -0xc(%ebp)
80104fdb:	e8 90 be ff ff       	call   80100e70 <fileclose>
80104fe0:	83 c4 10             	add    $0x10,%esp
80104fe3:	31 c0                	xor    %eax,%eax
80104fe5:	c9                   	leave  
80104fe6:	c3                   	ret    
80104fe7:	89 f6                	mov    %esi,%esi
80104fe9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104ff0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104ff5:	c9                   	leave  
80104ff6:	c3                   	ret    
80104ff7:	89 f6                	mov    %esi,%esi
80104ff9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105000 <sys_fstat>:
80105000:	55                   	push   %ebp
80105001:	31 c0                	xor    %eax,%eax
80105003:	89 e5                	mov    %esp,%ebp
80105005:	83 ec 18             	sub    $0x18,%esp
80105008:	8d 55 f0             	lea    -0x10(%ebp),%edx
8010500b:	e8 00 fe ff ff       	call   80104e10 <argfd.constprop.0>
80105010:	85 c0                	test   %eax,%eax
80105012:	78 2c                	js     80105040 <sys_fstat+0x40>
80105014:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105017:	83 ec 04             	sub    $0x4,%esp
8010501a:	6a 14                	push   $0x14
8010501c:	50                   	push   %eax
8010501d:	6a 01                	push   $0x1
8010501f:	e8 4c fb ff ff       	call   80104b70 <argptr>
80105024:	83 c4 10             	add    $0x10,%esp
80105027:	85 c0                	test   %eax,%eax
80105029:	78 15                	js     80105040 <sys_fstat+0x40>
8010502b:	83 ec 08             	sub    $0x8,%esp
8010502e:	ff 75 f4             	pushl  -0xc(%ebp)
80105031:	ff 75 f0             	pushl  -0x10(%ebp)
80105034:	e8 07 bf ff ff       	call   80100f40 <filestat>
80105039:	83 c4 10             	add    $0x10,%esp
8010503c:	c9                   	leave  
8010503d:	c3                   	ret    
8010503e:	66 90                	xchg   %ax,%ax
80105040:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105045:	c9                   	leave  
80105046:	c3                   	ret    
80105047:	89 f6                	mov    %esi,%esi
80105049:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105050 <sys_link>:
80105050:	55                   	push   %ebp
80105051:	89 e5                	mov    %esp,%ebp
80105053:	57                   	push   %edi
80105054:	56                   	push   %esi
80105055:	53                   	push   %ebx
80105056:	8d 45 d4             	lea    -0x2c(%ebp),%eax
80105059:	83 ec 34             	sub    $0x34,%esp
8010505c:	50                   	push   %eax
8010505d:	6a 00                	push   $0x0
8010505f:	e8 6c fb ff ff       	call   80104bd0 <argstr>
80105064:	83 c4 10             	add    $0x10,%esp
80105067:	85 c0                	test   %eax,%eax
80105069:	0f 88 fb 00 00 00    	js     8010516a <sys_link+0x11a>
8010506f:	8d 45 d0             	lea    -0x30(%ebp),%eax
80105072:	83 ec 08             	sub    $0x8,%esp
80105075:	50                   	push   %eax
80105076:	6a 01                	push   $0x1
80105078:	e8 53 fb ff ff       	call   80104bd0 <argstr>
8010507d:	83 c4 10             	add    $0x10,%esp
80105080:	85 c0                	test   %eax,%eax
80105082:	0f 88 e2 00 00 00    	js     8010516a <sys_link+0x11a>
80105088:	e8 43 db ff ff       	call   80102bd0 <begin_op>
8010508d:	83 ec 0c             	sub    $0xc,%esp
80105090:	ff 75 d4             	pushl  -0x2c(%ebp)
80105093:	e8 78 ce ff ff       	call   80101f10 <namei>
80105098:	83 c4 10             	add    $0x10,%esp
8010509b:	85 c0                	test   %eax,%eax
8010509d:	89 c3                	mov    %eax,%ebx
8010509f:	0f 84 ea 00 00 00    	je     8010518f <sys_link+0x13f>
801050a5:	83 ec 0c             	sub    $0xc,%esp
801050a8:	50                   	push   %eax
801050a9:	e8 02 c6 ff ff       	call   801016b0 <ilock>
801050ae:	83 c4 10             	add    $0x10,%esp
801050b1:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801050b6:	0f 84 bb 00 00 00    	je     80105177 <sys_link+0x127>
801050bc:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
801050c1:	83 ec 0c             	sub    $0xc,%esp
801050c4:	8d 7d da             	lea    -0x26(%ebp),%edi
801050c7:	53                   	push   %ebx
801050c8:	e8 33 c5 ff ff       	call   80101600 <iupdate>
801050cd:	89 1c 24             	mov    %ebx,(%esp)
801050d0:	e8 bb c6 ff ff       	call   80101790 <iunlock>
801050d5:	58                   	pop    %eax
801050d6:	5a                   	pop    %edx
801050d7:	57                   	push   %edi
801050d8:	ff 75 d0             	pushl  -0x30(%ebp)
801050db:	e8 50 ce ff ff       	call   80101f30 <nameiparent>
801050e0:	83 c4 10             	add    $0x10,%esp
801050e3:	85 c0                	test   %eax,%eax
801050e5:	89 c6                	mov    %eax,%esi
801050e7:	74 5b                	je     80105144 <sys_link+0xf4>
801050e9:	83 ec 0c             	sub    $0xc,%esp
801050ec:	50                   	push   %eax
801050ed:	e8 be c5 ff ff       	call   801016b0 <ilock>
801050f2:	83 c4 10             	add    $0x10,%esp
801050f5:	8b 03                	mov    (%ebx),%eax
801050f7:	39 06                	cmp    %eax,(%esi)
801050f9:	75 3d                	jne    80105138 <sys_link+0xe8>
801050fb:	83 ec 04             	sub    $0x4,%esp
801050fe:	ff 73 04             	pushl  0x4(%ebx)
80105101:	57                   	push   %edi
80105102:	56                   	push   %esi
80105103:	e8 48 cd ff ff       	call   80101e50 <dirlink>
80105108:	83 c4 10             	add    $0x10,%esp
8010510b:	85 c0                	test   %eax,%eax
8010510d:	78 29                	js     80105138 <sys_link+0xe8>
8010510f:	83 ec 0c             	sub    $0xc,%esp
80105112:	56                   	push   %esi
80105113:	e8 28 c8 ff ff       	call   80101940 <iunlockput>
80105118:	89 1c 24             	mov    %ebx,(%esp)
8010511b:	e8 c0 c6 ff ff       	call   801017e0 <iput>
80105120:	e8 1b db ff ff       	call   80102c40 <end_op>
80105125:	83 c4 10             	add    $0x10,%esp
80105128:	31 c0                	xor    %eax,%eax
8010512a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010512d:	5b                   	pop    %ebx
8010512e:	5e                   	pop    %esi
8010512f:	5f                   	pop    %edi
80105130:	5d                   	pop    %ebp
80105131:	c3                   	ret    
80105132:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105138:	83 ec 0c             	sub    $0xc,%esp
8010513b:	56                   	push   %esi
8010513c:	e8 ff c7 ff ff       	call   80101940 <iunlockput>
80105141:	83 c4 10             	add    $0x10,%esp
80105144:	83 ec 0c             	sub    $0xc,%esp
80105147:	53                   	push   %ebx
80105148:	e8 63 c5 ff ff       	call   801016b0 <ilock>
8010514d:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
80105152:	89 1c 24             	mov    %ebx,(%esp)
80105155:	e8 a6 c4 ff ff       	call   80101600 <iupdate>
8010515a:	89 1c 24             	mov    %ebx,(%esp)
8010515d:	e8 de c7 ff ff       	call   80101940 <iunlockput>
80105162:	e8 d9 da ff ff       	call   80102c40 <end_op>
80105167:	83 c4 10             	add    $0x10,%esp
8010516a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010516d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105172:	5b                   	pop    %ebx
80105173:	5e                   	pop    %esi
80105174:	5f                   	pop    %edi
80105175:	5d                   	pop    %ebp
80105176:	c3                   	ret    
80105177:	83 ec 0c             	sub    $0xc,%esp
8010517a:	53                   	push   %ebx
8010517b:	e8 c0 c7 ff ff       	call   80101940 <iunlockput>
80105180:	e8 bb da ff ff       	call   80102c40 <end_op>
80105185:	83 c4 10             	add    $0x10,%esp
80105188:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010518d:	eb 9b                	jmp    8010512a <sys_link+0xda>
8010518f:	e8 ac da ff ff       	call   80102c40 <end_op>
80105194:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105199:	eb 8f                	jmp    8010512a <sys_link+0xda>
8010519b:	90                   	nop
8010519c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801051a0 <sys_unlink>:
801051a0:	55                   	push   %ebp
801051a1:	89 e5                	mov    %esp,%ebp
801051a3:	57                   	push   %edi
801051a4:	56                   	push   %esi
801051a5:	53                   	push   %ebx
801051a6:	8d 45 c0             	lea    -0x40(%ebp),%eax
801051a9:	83 ec 44             	sub    $0x44,%esp
801051ac:	50                   	push   %eax
801051ad:	6a 00                	push   $0x0
801051af:	e8 1c fa ff ff       	call   80104bd0 <argstr>
801051b4:	83 c4 10             	add    $0x10,%esp
801051b7:	85 c0                	test   %eax,%eax
801051b9:	0f 88 77 01 00 00    	js     80105336 <sys_unlink+0x196>
801051bf:	8d 5d ca             	lea    -0x36(%ebp),%ebx
801051c2:	e8 09 da ff ff       	call   80102bd0 <begin_op>
801051c7:	83 ec 08             	sub    $0x8,%esp
801051ca:	53                   	push   %ebx
801051cb:	ff 75 c0             	pushl  -0x40(%ebp)
801051ce:	e8 5d cd ff ff       	call   80101f30 <nameiparent>
801051d3:	83 c4 10             	add    $0x10,%esp
801051d6:	85 c0                	test   %eax,%eax
801051d8:	89 c6                	mov    %eax,%esi
801051da:	0f 84 60 01 00 00    	je     80105340 <sys_unlink+0x1a0>
801051e0:	83 ec 0c             	sub    $0xc,%esp
801051e3:	50                   	push   %eax
801051e4:	e8 c7 c4 ff ff       	call   801016b0 <ilock>
801051e9:	58                   	pop    %eax
801051ea:	5a                   	pop    %edx
801051eb:	68 c0 7a 10 80       	push   $0x80107ac0
801051f0:	53                   	push   %ebx
801051f1:	e8 ca c9 ff ff       	call   80101bc0 <namecmp>
801051f6:	83 c4 10             	add    $0x10,%esp
801051f9:	85 c0                	test   %eax,%eax
801051fb:	0f 84 03 01 00 00    	je     80105304 <sys_unlink+0x164>
80105201:	83 ec 08             	sub    $0x8,%esp
80105204:	68 bf 7a 10 80       	push   $0x80107abf
80105209:	53                   	push   %ebx
8010520a:	e8 b1 c9 ff ff       	call   80101bc0 <namecmp>
8010520f:	83 c4 10             	add    $0x10,%esp
80105212:	85 c0                	test   %eax,%eax
80105214:	0f 84 ea 00 00 00    	je     80105304 <sys_unlink+0x164>
8010521a:	8d 45 c4             	lea    -0x3c(%ebp),%eax
8010521d:	83 ec 04             	sub    $0x4,%esp
80105220:	50                   	push   %eax
80105221:	53                   	push   %ebx
80105222:	56                   	push   %esi
80105223:	e8 b8 c9 ff ff       	call   80101be0 <dirlookup>
80105228:	83 c4 10             	add    $0x10,%esp
8010522b:	85 c0                	test   %eax,%eax
8010522d:	89 c3                	mov    %eax,%ebx
8010522f:	0f 84 cf 00 00 00    	je     80105304 <sys_unlink+0x164>
80105235:	83 ec 0c             	sub    $0xc,%esp
80105238:	50                   	push   %eax
80105239:	e8 72 c4 ff ff       	call   801016b0 <ilock>
8010523e:	83 c4 10             	add    $0x10,%esp
80105241:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80105246:	0f 8e 10 01 00 00    	jle    8010535c <sys_unlink+0x1bc>
8010524c:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105251:	74 6d                	je     801052c0 <sys_unlink+0x120>
80105253:	8d 45 d8             	lea    -0x28(%ebp),%eax
80105256:	83 ec 04             	sub    $0x4,%esp
80105259:	6a 10                	push   $0x10
8010525b:	6a 00                	push   $0x0
8010525d:	50                   	push   %eax
8010525e:	e8 bd f5 ff ff       	call   80104820 <memset>
80105263:	8d 45 d8             	lea    -0x28(%ebp),%eax
80105266:	6a 10                	push   $0x10
80105268:	ff 75 c4             	pushl  -0x3c(%ebp)
8010526b:	50                   	push   %eax
8010526c:	56                   	push   %esi
8010526d:	e8 1e c8 ff ff       	call   80101a90 <writei>
80105272:	83 c4 20             	add    $0x20,%esp
80105275:	83 f8 10             	cmp    $0x10,%eax
80105278:	0f 85 eb 00 00 00    	jne    80105369 <sys_unlink+0x1c9>
8010527e:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105283:	0f 84 97 00 00 00    	je     80105320 <sys_unlink+0x180>
80105289:	83 ec 0c             	sub    $0xc,%esp
8010528c:	56                   	push   %esi
8010528d:	e8 ae c6 ff ff       	call   80101940 <iunlockput>
80105292:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
80105297:	89 1c 24             	mov    %ebx,(%esp)
8010529a:	e8 61 c3 ff ff       	call   80101600 <iupdate>
8010529f:	89 1c 24             	mov    %ebx,(%esp)
801052a2:	e8 99 c6 ff ff       	call   80101940 <iunlockput>
801052a7:	e8 94 d9 ff ff       	call   80102c40 <end_op>
801052ac:	83 c4 10             	add    $0x10,%esp
801052af:	31 c0                	xor    %eax,%eax
801052b1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801052b4:	5b                   	pop    %ebx
801052b5:	5e                   	pop    %esi
801052b6:	5f                   	pop    %edi
801052b7:	5d                   	pop    %ebp
801052b8:	c3                   	ret    
801052b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801052c0:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
801052c4:	76 8d                	jbe    80105253 <sys_unlink+0xb3>
801052c6:	bf 20 00 00 00       	mov    $0x20,%edi
801052cb:	eb 0f                	jmp    801052dc <sys_unlink+0x13c>
801052cd:	8d 76 00             	lea    0x0(%esi),%esi
801052d0:	83 c7 10             	add    $0x10,%edi
801052d3:	3b 7b 58             	cmp    0x58(%ebx),%edi
801052d6:	0f 83 77 ff ff ff    	jae    80105253 <sys_unlink+0xb3>
801052dc:	8d 45 d8             	lea    -0x28(%ebp),%eax
801052df:	6a 10                	push   $0x10
801052e1:	57                   	push   %edi
801052e2:	50                   	push   %eax
801052e3:	53                   	push   %ebx
801052e4:	e8 a7 c6 ff ff       	call   80101990 <readi>
801052e9:	83 c4 10             	add    $0x10,%esp
801052ec:	83 f8 10             	cmp    $0x10,%eax
801052ef:	75 5e                	jne    8010534f <sys_unlink+0x1af>
801052f1:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
801052f6:	74 d8                	je     801052d0 <sys_unlink+0x130>
801052f8:	83 ec 0c             	sub    $0xc,%esp
801052fb:	53                   	push   %ebx
801052fc:	e8 3f c6 ff ff       	call   80101940 <iunlockput>
80105301:	83 c4 10             	add    $0x10,%esp
80105304:	83 ec 0c             	sub    $0xc,%esp
80105307:	56                   	push   %esi
80105308:	e8 33 c6 ff ff       	call   80101940 <iunlockput>
8010530d:	e8 2e d9 ff ff       	call   80102c40 <end_op>
80105312:	83 c4 10             	add    $0x10,%esp
80105315:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010531a:	eb 95                	jmp    801052b1 <sys_unlink+0x111>
8010531c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105320:	66 83 6e 56 01       	subw   $0x1,0x56(%esi)
80105325:	83 ec 0c             	sub    $0xc,%esp
80105328:	56                   	push   %esi
80105329:	e8 d2 c2 ff ff       	call   80101600 <iupdate>
8010532e:	83 c4 10             	add    $0x10,%esp
80105331:	e9 53 ff ff ff       	jmp    80105289 <sys_unlink+0xe9>
80105336:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010533b:	e9 71 ff ff ff       	jmp    801052b1 <sys_unlink+0x111>
80105340:	e8 fb d8 ff ff       	call   80102c40 <end_op>
80105345:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010534a:	e9 62 ff ff ff       	jmp    801052b1 <sys_unlink+0x111>
8010534f:	83 ec 0c             	sub    $0xc,%esp
80105352:	68 e4 7a 10 80       	push   $0x80107ae4
80105357:	e8 34 b0 ff ff       	call   80100390 <panic>
8010535c:	83 ec 0c             	sub    $0xc,%esp
8010535f:	68 d2 7a 10 80       	push   $0x80107ad2
80105364:	e8 27 b0 ff ff       	call   80100390 <panic>
80105369:	83 ec 0c             	sub    $0xc,%esp
8010536c:	68 f6 7a 10 80       	push   $0x80107af6
80105371:	e8 1a b0 ff ff       	call   80100390 <panic>
80105376:	8d 76 00             	lea    0x0(%esi),%esi
80105379:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105380 <sys_open>:
80105380:	55                   	push   %ebp
80105381:	89 e5                	mov    %esp,%ebp
80105383:	57                   	push   %edi
80105384:	56                   	push   %esi
80105385:	53                   	push   %ebx
80105386:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105389:	83 ec 24             	sub    $0x24,%esp
8010538c:	50                   	push   %eax
8010538d:	6a 00                	push   $0x0
8010538f:	e8 3c f8 ff ff       	call   80104bd0 <argstr>
80105394:	83 c4 10             	add    $0x10,%esp
80105397:	85 c0                	test   %eax,%eax
80105399:	0f 88 1d 01 00 00    	js     801054bc <sys_open+0x13c>
8010539f:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801053a2:	83 ec 08             	sub    $0x8,%esp
801053a5:	50                   	push   %eax
801053a6:	6a 01                	push   $0x1
801053a8:	e8 73 f7 ff ff       	call   80104b20 <argint>
801053ad:	83 c4 10             	add    $0x10,%esp
801053b0:	85 c0                	test   %eax,%eax
801053b2:	0f 88 04 01 00 00    	js     801054bc <sys_open+0x13c>
801053b8:	e8 13 d8 ff ff       	call   80102bd0 <begin_op>
801053bd:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
801053c1:	0f 85 a9 00 00 00    	jne    80105470 <sys_open+0xf0>
801053c7:	83 ec 0c             	sub    $0xc,%esp
801053ca:	ff 75 e0             	pushl  -0x20(%ebp)
801053cd:	e8 3e cb ff ff       	call   80101f10 <namei>
801053d2:	83 c4 10             	add    $0x10,%esp
801053d5:	85 c0                	test   %eax,%eax
801053d7:	89 c6                	mov    %eax,%esi
801053d9:	0f 84 b2 00 00 00    	je     80105491 <sys_open+0x111>
801053df:	83 ec 0c             	sub    $0xc,%esp
801053e2:	50                   	push   %eax
801053e3:	e8 c8 c2 ff ff       	call   801016b0 <ilock>
801053e8:	83 c4 10             	add    $0x10,%esp
801053eb:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
801053f0:	0f 84 aa 00 00 00    	je     801054a0 <sys_open+0x120>
801053f6:	e8 b5 b9 ff ff       	call   80100db0 <filealloc>
801053fb:	85 c0                	test   %eax,%eax
801053fd:	89 c7                	mov    %eax,%edi
801053ff:	0f 84 a6 00 00 00    	je     801054ab <sys_open+0x12b>
80105405:	e8 76 e4 ff ff       	call   80103880 <myproc>
8010540a:	31 db                	xor    %ebx,%ebx
8010540c:	eb 0e                	jmp    8010541c <sys_open+0x9c>
8010540e:	66 90                	xchg   %ax,%ax
80105410:	83 c3 01             	add    $0x1,%ebx
80105413:	83 fb 10             	cmp    $0x10,%ebx
80105416:	0f 84 ac 00 00 00    	je     801054c8 <sys_open+0x148>
8010541c:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105420:	85 d2                	test   %edx,%edx
80105422:	75 ec                	jne    80105410 <sys_open+0x90>
80105424:	83 ec 0c             	sub    $0xc,%esp
80105427:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
8010542b:	56                   	push   %esi
8010542c:	e8 5f c3 ff ff       	call   80101790 <iunlock>
80105431:	e8 0a d8 ff ff       	call   80102c40 <end_op>
80105436:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
8010543c:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010543f:	83 c4 10             	add    $0x10,%esp
80105442:	89 77 10             	mov    %esi,0x10(%edi)
80105445:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
8010544c:	89 d0                	mov    %edx,%eax
8010544e:	f7 d0                	not    %eax
80105450:	83 e0 01             	and    $0x1,%eax
80105453:	83 e2 03             	and    $0x3,%edx
80105456:	88 47 08             	mov    %al,0x8(%edi)
80105459:	0f 95 47 09          	setne  0x9(%edi)
8010545d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105460:	89 d8                	mov    %ebx,%eax
80105462:	5b                   	pop    %ebx
80105463:	5e                   	pop    %esi
80105464:	5f                   	pop    %edi
80105465:	5d                   	pop    %ebp
80105466:	c3                   	ret    
80105467:	89 f6                	mov    %esi,%esi
80105469:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105470:	83 ec 0c             	sub    $0xc,%esp
80105473:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105476:	31 c9                	xor    %ecx,%ecx
80105478:	6a 00                	push   $0x0
8010547a:	ba 02 00 00 00       	mov    $0x2,%edx
8010547f:	e8 ec f7 ff ff       	call   80104c70 <create>
80105484:	83 c4 10             	add    $0x10,%esp
80105487:	85 c0                	test   %eax,%eax
80105489:	89 c6                	mov    %eax,%esi
8010548b:	0f 85 65 ff ff ff    	jne    801053f6 <sys_open+0x76>
80105491:	e8 aa d7 ff ff       	call   80102c40 <end_op>
80105496:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
8010549b:	eb c0                	jmp    8010545d <sys_open+0xdd>
8010549d:	8d 76 00             	lea    0x0(%esi),%esi
801054a0:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801054a3:	85 c9                	test   %ecx,%ecx
801054a5:	0f 84 4b ff ff ff    	je     801053f6 <sys_open+0x76>
801054ab:	83 ec 0c             	sub    $0xc,%esp
801054ae:	56                   	push   %esi
801054af:	e8 8c c4 ff ff       	call   80101940 <iunlockput>
801054b4:	e8 87 d7 ff ff       	call   80102c40 <end_op>
801054b9:	83 c4 10             	add    $0x10,%esp
801054bc:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801054c1:	eb 9a                	jmp    8010545d <sys_open+0xdd>
801054c3:	90                   	nop
801054c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801054c8:	83 ec 0c             	sub    $0xc,%esp
801054cb:	57                   	push   %edi
801054cc:	e8 9f b9 ff ff       	call   80100e70 <fileclose>
801054d1:	83 c4 10             	add    $0x10,%esp
801054d4:	eb d5                	jmp    801054ab <sys_open+0x12b>
801054d6:	8d 76 00             	lea    0x0(%esi),%esi
801054d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801054e0 <sys_mkdir>:
801054e0:	55                   	push   %ebp
801054e1:	89 e5                	mov    %esp,%ebp
801054e3:	83 ec 18             	sub    $0x18,%esp
801054e6:	e8 e5 d6 ff ff       	call   80102bd0 <begin_op>
801054eb:	8d 45 f4             	lea    -0xc(%ebp),%eax
801054ee:	83 ec 08             	sub    $0x8,%esp
801054f1:	50                   	push   %eax
801054f2:	6a 00                	push   $0x0
801054f4:	e8 d7 f6 ff ff       	call   80104bd0 <argstr>
801054f9:	83 c4 10             	add    $0x10,%esp
801054fc:	85 c0                	test   %eax,%eax
801054fe:	78 30                	js     80105530 <sys_mkdir+0x50>
80105500:	83 ec 0c             	sub    $0xc,%esp
80105503:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105506:	31 c9                	xor    %ecx,%ecx
80105508:	6a 00                	push   $0x0
8010550a:	ba 01 00 00 00       	mov    $0x1,%edx
8010550f:	e8 5c f7 ff ff       	call   80104c70 <create>
80105514:	83 c4 10             	add    $0x10,%esp
80105517:	85 c0                	test   %eax,%eax
80105519:	74 15                	je     80105530 <sys_mkdir+0x50>
8010551b:	83 ec 0c             	sub    $0xc,%esp
8010551e:	50                   	push   %eax
8010551f:	e8 1c c4 ff ff       	call   80101940 <iunlockput>
80105524:	e8 17 d7 ff ff       	call   80102c40 <end_op>
80105529:	83 c4 10             	add    $0x10,%esp
8010552c:	31 c0                	xor    %eax,%eax
8010552e:	c9                   	leave  
8010552f:	c3                   	ret    
80105530:	e8 0b d7 ff ff       	call   80102c40 <end_op>
80105535:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010553a:	c9                   	leave  
8010553b:	c3                   	ret    
8010553c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105540 <sys_mknod>:
80105540:	55                   	push   %ebp
80105541:	89 e5                	mov    %esp,%ebp
80105543:	83 ec 18             	sub    $0x18,%esp
80105546:	e8 85 d6 ff ff       	call   80102bd0 <begin_op>
8010554b:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010554e:	83 ec 08             	sub    $0x8,%esp
80105551:	50                   	push   %eax
80105552:	6a 00                	push   $0x0
80105554:	e8 77 f6 ff ff       	call   80104bd0 <argstr>
80105559:	83 c4 10             	add    $0x10,%esp
8010555c:	85 c0                	test   %eax,%eax
8010555e:	78 60                	js     801055c0 <sys_mknod+0x80>
80105560:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105563:	83 ec 08             	sub    $0x8,%esp
80105566:	50                   	push   %eax
80105567:	6a 01                	push   $0x1
80105569:	e8 b2 f5 ff ff       	call   80104b20 <argint>
8010556e:	83 c4 10             	add    $0x10,%esp
80105571:	85 c0                	test   %eax,%eax
80105573:	78 4b                	js     801055c0 <sys_mknod+0x80>
80105575:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105578:	83 ec 08             	sub    $0x8,%esp
8010557b:	50                   	push   %eax
8010557c:	6a 02                	push   $0x2
8010557e:	e8 9d f5 ff ff       	call   80104b20 <argint>
80105583:	83 c4 10             	add    $0x10,%esp
80105586:	85 c0                	test   %eax,%eax
80105588:	78 36                	js     801055c0 <sys_mknod+0x80>
8010558a:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
8010558e:	83 ec 0c             	sub    $0xc,%esp
80105591:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
80105595:	ba 03 00 00 00       	mov    $0x3,%edx
8010559a:	50                   	push   %eax
8010559b:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010559e:	e8 cd f6 ff ff       	call   80104c70 <create>
801055a3:	83 c4 10             	add    $0x10,%esp
801055a6:	85 c0                	test   %eax,%eax
801055a8:	74 16                	je     801055c0 <sys_mknod+0x80>
801055aa:	83 ec 0c             	sub    $0xc,%esp
801055ad:	50                   	push   %eax
801055ae:	e8 8d c3 ff ff       	call   80101940 <iunlockput>
801055b3:	e8 88 d6 ff ff       	call   80102c40 <end_op>
801055b8:	83 c4 10             	add    $0x10,%esp
801055bb:	31 c0                	xor    %eax,%eax
801055bd:	c9                   	leave  
801055be:	c3                   	ret    
801055bf:	90                   	nop
801055c0:	e8 7b d6 ff ff       	call   80102c40 <end_op>
801055c5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801055ca:	c9                   	leave  
801055cb:	c3                   	ret    
801055cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801055d0 <sys_chdir>:
801055d0:	55                   	push   %ebp
801055d1:	89 e5                	mov    %esp,%ebp
801055d3:	56                   	push   %esi
801055d4:	53                   	push   %ebx
801055d5:	83 ec 10             	sub    $0x10,%esp
801055d8:	e8 a3 e2 ff ff       	call   80103880 <myproc>
801055dd:	89 c6                	mov    %eax,%esi
801055df:	e8 ec d5 ff ff       	call   80102bd0 <begin_op>
801055e4:	8d 45 f4             	lea    -0xc(%ebp),%eax
801055e7:	83 ec 08             	sub    $0x8,%esp
801055ea:	50                   	push   %eax
801055eb:	6a 00                	push   $0x0
801055ed:	e8 de f5 ff ff       	call   80104bd0 <argstr>
801055f2:	83 c4 10             	add    $0x10,%esp
801055f5:	85 c0                	test   %eax,%eax
801055f7:	78 77                	js     80105670 <sys_chdir+0xa0>
801055f9:	83 ec 0c             	sub    $0xc,%esp
801055fc:	ff 75 f4             	pushl  -0xc(%ebp)
801055ff:	e8 0c c9 ff ff       	call   80101f10 <namei>
80105604:	83 c4 10             	add    $0x10,%esp
80105607:	85 c0                	test   %eax,%eax
80105609:	89 c3                	mov    %eax,%ebx
8010560b:	74 63                	je     80105670 <sys_chdir+0xa0>
8010560d:	83 ec 0c             	sub    $0xc,%esp
80105610:	50                   	push   %eax
80105611:	e8 9a c0 ff ff       	call   801016b0 <ilock>
80105616:	83 c4 10             	add    $0x10,%esp
80105619:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
8010561e:	75 30                	jne    80105650 <sys_chdir+0x80>
80105620:	83 ec 0c             	sub    $0xc,%esp
80105623:	53                   	push   %ebx
80105624:	e8 67 c1 ff ff       	call   80101790 <iunlock>
80105629:	58                   	pop    %eax
8010562a:	ff 76 68             	pushl  0x68(%esi)
8010562d:	e8 ae c1 ff ff       	call   801017e0 <iput>
80105632:	e8 09 d6 ff ff       	call   80102c40 <end_op>
80105637:	89 5e 68             	mov    %ebx,0x68(%esi)
8010563a:	83 c4 10             	add    $0x10,%esp
8010563d:	31 c0                	xor    %eax,%eax
8010563f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105642:	5b                   	pop    %ebx
80105643:	5e                   	pop    %esi
80105644:	5d                   	pop    %ebp
80105645:	c3                   	ret    
80105646:	8d 76 00             	lea    0x0(%esi),%esi
80105649:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105650:	83 ec 0c             	sub    $0xc,%esp
80105653:	53                   	push   %ebx
80105654:	e8 e7 c2 ff ff       	call   80101940 <iunlockput>
80105659:	e8 e2 d5 ff ff       	call   80102c40 <end_op>
8010565e:	83 c4 10             	add    $0x10,%esp
80105661:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105666:	eb d7                	jmp    8010563f <sys_chdir+0x6f>
80105668:	90                   	nop
80105669:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105670:	e8 cb d5 ff ff       	call   80102c40 <end_op>
80105675:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010567a:	eb c3                	jmp    8010563f <sys_chdir+0x6f>
8010567c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105680 <sys_exec>:
80105680:	55                   	push   %ebp
80105681:	89 e5                	mov    %esp,%ebp
80105683:	57                   	push   %edi
80105684:	56                   	push   %esi
80105685:	53                   	push   %ebx
80105686:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
8010568c:	81 ec a4 00 00 00    	sub    $0xa4,%esp
80105692:	50                   	push   %eax
80105693:	6a 00                	push   $0x0
80105695:	e8 36 f5 ff ff       	call   80104bd0 <argstr>
8010569a:	83 c4 10             	add    $0x10,%esp
8010569d:	85 c0                	test   %eax,%eax
8010569f:	0f 88 87 00 00 00    	js     8010572c <sys_exec+0xac>
801056a5:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
801056ab:	83 ec 08             	sub    $0x8,%esp
801056ae:	50                   	push   %eax
801056af:	6a 01                	push   $0x1
801056b1:	e8 6a f4 ff ff       	call   80104b20 <argint>
801056b6:	83 c4 10             	add    $0x10,%esp
801056b9:	85 c0                	test   %eax,%eax
801056bb:	78 6f                	js     8010572c <sys_exec+0xac>
801056bd:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
801056c3:	83 ec 04             	sub    $0x4,%esp
801056c6:	31 db                	xor    %ebx,%ebx
801056c8:	68 80 00 00 00       	push   $0x80
801056cd:	6a 00                	push   $0x0
801056cf:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
801056d5:	50                   	push   %eax
801056d6:	e8 45 f1 ff ff       	call   80104820 <memset>
801056db:	83 c4 10             	add    $0x10,%esp
801056de:	eb 2c                	jmp    8010570c <sys_exec+0x8c>
801056e0:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
801056e6:	85 c0                	test   %eax,%eax
801056e8:	74 56                	je     80105740 <sys_exec+0xc0>
801056ea:	8d 8d 68 ff ff ff    	lea    -0x98(%ebp),%ecx
801056f0:	83 ec 08             	sub    $0x8,%esp
801056f3:	8d 14 31             	lea    (%ecx,%esi,1),%edx
801056f6:	52                   	push   %edx
801056f7:	50                   	push   %eax
801056f8:	e8 b3 f3 ff ff       	call   80104ab0 <fetchstr>
801056fd:	83 c4 10             	add    $0x10,%esp
80105700:	85 c0                	test   %eax,%eax
80105702:	78 28                	js     8010572c <sys_exec+0xac>
80105704:	83 c3 01             	add    $0x1,%ebx
80105707:	83 fb 20             	cmp    $0x20,%ebx
8010570a:	74 20                	je     8010572c <sys_exec+0xac>
8010570c:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80105712:	8d 34 9d 00 00 00 00 	lea    0x0(,%ebx,4),%esi
80105719:	83 ec 08             	sub    $0x8,%esp
8010571c:	57                   	push   %edi
8010571d:	01 f0                	add    %esi,%eax
8010571f:	50                   	push   %eax
80105720:	e8 4b f3 ff ff       	call   80104a70 <fetchint>
80105725:	83 c4 10             	add    $0x10,%esp
80105728:	85 c0                	test   %eax,%eax
8010572a:	79 b4                	jns    801056e0 <sys_exec+0x60>
8010572c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010572f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105734:	5b                   	pop    %ebx
80105735:	5e                   	pop    %esi
80105736:	5f                   	pop    %edi
80105737:	5d                   	pop    %ebp
80105738:	c3                   	ret    
80105739:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105740:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80105746:	83 ec 08             	sub    $0x8,%esp
80105749:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
80105750:	00 00 00 00 
80105754:	50                   	push   %eax
80105755:	ff b5 5c ff ff ff    	pushl  -0xa4(%ebp)
8010575b:	e8 b0 b2 ff ff       	call   80100a10 <exec>
80105760:	83 c4 10             	add    $0x10,%esp
80105763:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105766:	5b                   	pop    %ebx
80105767:	5e                   	pop    %esi
80105768:	5f                   	pop    %edi
80105769:	5d                   	pop    %ebp
8010576a:	c3                   	ret    
8010576b:	90                   	nop
8010576c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105770 <sys_pipe>:
80105770:	55                   	push   %ebp
80105771:	89 e5                	mov    %esp,%ebp
80105773:	57                   	push   %edi
80105774:	56                   	push   %esi
80105775:	53                   	push   %ebx
80105776:	8d 45 dc             	lea    -0x24(%ebp),%eax
80105779:	83 ec 20             	sub    $0x20,%esp
8010577c:	6a 08                	push   $0x8
8010577e:	50                   	push   %eax
8010577f:	6a 00                	push   $0x0
80105781:	e8 ea f3 ff ff       	call   80104b70 <argptr>
80105786:	83 c4 10             	add    $0x10,%esp
80105789:	85 c0                	test   %eax,%eax
8010578b:	0f 88 ae 00 00 00    	js     8010583f <sys_pipe+0xcf>
80105791:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105794:	83 ec 08             	sub    $0x8,%esp
80105797:	50                   	push   %eax
80105798:	8d 45 e0             	lea    -0x20(%ebp),%eax
8010579b:	50                   	push   %eax
8010579c:	e8 cf da ff ff       	call   80103270 <pipealloc>
801057a1:	83 c4 10             	add    $0x10,%esp
801057a4:	85 c0                	test   %eax,%eax
801057a6:	0f 88 93 00 00 00    	js     8010583f <sys_pipe+0xcf>
801057ac:	8b 7d e0             	mov    -0x20(%ebp),%edi
801057af:	31 db                	xor    %ebx,%ebx
801057b1:	e8 ca e0 ff ff       	call   80103880 <myproc>
801057b6:	eb 10                	jmp    801057c8 <sys_pipe+0x58>
801057b8:	90                   	nop
801057b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801057c0:	83 c3 01             	add    $0x1,%ebx
801057c3:	83 fb 10             	cmp    $0x10,%ebx
801057c6:	74 60                	je     80105828 <sys_pipe+0xb8>
801057c8:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
801057cc:	85 f6                	test   %esi,%esi
801057ce:	75 f0                	jne    801057c0 <sys_pipe+0x50>
801057d0:	8d 73 08             	lea    0x8(%ebx),%esi
801057d3:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
801057d7:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801057da:	e8 a1 e0 ff ff       	call   80103880 <myproc>
801057df:	31 d2                	xor    %edx,%edx
801057e1:	eb 0d                	jmp    801057f0 <sys_pipe+0x80>
801057e3:	90                   	nop
801057e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801057e8:	83 c2 01             	add    $0x1,%edx
801057eb:	83 fa 10             	cmp    $0x10,%edx
801057ee:	74 28                	je     80105818 <sys_pipe+0xa8>
801057f0:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
801057f4:	85 c9                	test   %ecx,%ecx
801057f6:	75 f0                	jne    801057e8 <sys_pipe+0x78>
801057f8:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
801057fc:	8b 45 dc             	mov    -0x24(%ebp),%eax
801057ff:	89 18                	mov    %ebx,(%eax)
80105801:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105804:	89 50 04             	mov    %edx,0x4(%eax)
80105807:	31 c0                	xor    %eax,%eax
80105809:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010580c:	5b                   	pop    %ebx
8010580d:	5e                   	pop    %esi
8010580e:	5f                   	pop    %edi
8010580f:	5d                   	pop    %ebp
80105810:	c3                   	ret    
80105811:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105818:	e8 63 e0 ff ff       	call   80103880 <myproc>
8010581d:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
80105824:	00 
80105825:	8d 76 00             	lea    0x0(%esi),%esi
80105828:	83 ec 0c             	sub    $0xc,%esp
8010582b:	ff 75 e0             	pushl  -0x20(%ebp)
8010582e:	e8 3d b6 ff ff       	call   80100e70 <fileclose>
80105833:	58                   	pop    %eax
80105834:	ff 75 e4             	pushl  -0x1c(%ebp)
80105837:	e8 34 b6 ff ff       	call   80100e70 <fileclose>
8010583c:	83 c4 10             	add    $0x10,%esp
8010583f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105844:	eb c3                	jmp    80105809 <sys_pipe+0x99>
80105846:	66 90                	xchg   %ax,%ax
80105848:	66 90                	xchg   %ax,%ax
8010584a:	66 90                	xchg   %ax,%ax
8010584c:	66 90                	xchg   %ax,%ax
8010584e:	66 90                	xchg   %ax,%ax

80105850 <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
80105850:	55                   	push   %ebp
80105851:	89 e5                	mov    %esp,%ebp
  return fork();
}
80105853:	5d                   	pop    %ebp
  return fork();
80105854:	e9 f7 e1 ff ff       	jmp    80103a50 <fork>
80105859:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105860 <sys_exit>:

int
sys_exit(void)
{
80105860:	55                   	push   %ebp
80105861:	89 e5                	mov    %esp,%ebp
80105863:	83 ec 08             	sub    $0x8,%esp
  exit();
80105866:	e8 b5 e4 ff ff       	call   80103d20 <exit>
  return 0;  // not reached
}
8010586b:	31 c0                	xor    %eax,%eax
8010586d:	c9                   	leave  
8010586e:	c3                   	ret    
8010586f:	90                   	nop

80105870 <sys_wait>:

int
sys_wait(void)
{
80105870:	55                   	push   %ebp
80105871:	89 e5                	mov    %esp,%ebp
  return wait();
}
80105873:	5d                   	pop    %ebp
  return wait();
80105874:	e9 e7 e6 ff ff       	jmp    80103f60 <wait>
80105879:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105880 <sys_kill>:

int
sys_kill(void)
{
80105880:	55                   	push   %ebp
80105881:	89 e5                	mov    %esp,%ebp
80105883:	83 ec 20             	sub    $0x20,%esp
  int pid;
  int signum;

  if(argint(0, &pid) < 0)
80105886:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105889:	50                   	push   %eax
8010588a:	6a 00                	push   $0x0
8010588c:	e8 8f f2 ff ff       	call   80104b20 <argint>
80105891:	83 c4 10             	add    $0x10,%esp
80105894:	85 c0                	test   %eax,%eax
80105896:	78 28                	js     801058c0 <sys_kill+0x40>
    return -1;
  if(argint(1, &signum) < 0)
80105898:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010589b:	83 ec 08             	sub    $0x8,%esp
8010589e:	50                   	push   %eax
8010589f:	6a 01                	push   $0x1
801058a1:	e8 7a f2 ff ff       	call   80104b20 <argint>
801058a6:	83 c4 10             	add    $0x10,%esp
801058a9:	85 c0                	test   %eax,%eax
801058ab:	78 13                	js     801058c0 <sys_kill+0x40>
    return -1;
  return kill(pid, signum);
801058ad:	83 ec 08             	sub    $0x8,%esp
801058b0:	ff 75 f4             	pushl  -0xc(%ebp)
801058b3:	ff 75 f0             	pushl  -0x10(%ebp)
801058b6:	e8 05 e8 ff ff       	call   801040c0 <kill>
801058bb:	83 c4 10             	add    $0x10,%esp
}
801058be:	c9                   	leave  
801058bf:	c3                   	ret    
    return -1;
801058c0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801058c5:	c9                   	leave  
801058c6:	c3                   	ret    
801058c7:	89 f6                	mov    %esi,%esi
801058c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801058d0 <sys_getpid>:

int
sys_getpid(void)
{
801058d0:	55                   	push   %ebp
801058d1:	89 e5                	mov    %esp,%ebp
801058d3:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
801058d6:	e8 a5 df ff ff       	call   80103880 <myproc>
801058db:	8b 40 10             	mov    0x10(%eax),%eax
}
801058de:	c9                   	leave  
801058df:	c3                   	ret    

801058e0 <sys_sbrk>:

int
sys_sbrk(void)
{
801058e0:	55                   	push   %ebp
801058e1:	89 e5                	mov    %esp,%ebp
801058e3:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
801058e4:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
801058e7:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
801058ea:	50                   	push   %eax
801058eb:	6a 00                	push   $0x0
801058ed:	e8 2e f2 ff ff       	call   80104b20 <argint>
801058f2:	83 c4 10             	add    $0x10,%esp
801058f5:	85 c0                	test   %eax,%eax
801058f7:	78 27                	js     80105920 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
801058f9:	e8 82 df ff ff       	call   80103880 <myproc>
  if(growproc(n) < 0)
801058fe:	83 ec 0c             	sub    $0xc,%esp
  addr = myproc()->sz;
80105901:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80105903:	ff 75 f4             	pushl  -0xc(%ebp)
80105906:	e8 c5 e0 ff ff       	call   801039d0 <growproc>
8010590b:	83 c4 10             	add    $0x10,%esp
8010590e:	85 c0                	test   %eax,%eax
80105910:	78 0e                	js     80105920 <sys_sbrk+0x40>
    return -1;
  return addr;
}
80105912:	89 d8                	mov    %ebx,%eax
80105914:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105917:	c9                   	leave  
80105918:	c3                   	ret    
80105919:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105920:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105925:	eb eb                	jmp    80105912 <sys_sbrk+0x32>
80105927:	89 f6                	mov    %esi,%esi
80105929:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105930 <sys_sleep>:

int
sys_sleep(void)
{
80105930:	55                   	push   %ebp
80105931:	89 e5                	mov    %esp,%ebp
80105933:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80105934:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105937:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
8010593a:	50                   	push   %eax
8010593b:	6a 00                	push   $0x0
8010593d:	e8 de f1 ff ff       	call   80104b20 <argint>
80105942:	83 c4 10             	add    $0x10,%esp
80105945:	85 c0                	test   %eax,%eax
80105947:	0f 88 8a 00 00 00    	js     801059d7 <sys_sleep+0xa7>
    return -1;
  acquire(&tickslock);
8010594d:	83 ec 0c             	sub    $0xc,%esp
80105950:	68 60 70 11 80       	push   $0x80117060
80105955:	e8 b6 ed ff ff       	call   80104710 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
8010595a:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010595d:	83 c4 10             	add    $0x10,%esp
  ticks0 = ticks;
80105960:	8b 1d a0 78 11 80    	mov    0x801178a0,%ebx
  while(ticks - ticks0 < n){
80105966:	85 d2                	test   %edx,%edx
80105968:	75 27                	jne    80105991 <sys_sleep+0x61>
8010596a:	eb 54                	jmp    801059c0 <sys_sleep+0x90>
8010596c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80105970:	83 ec 08             	sub    $0x8,%esp
80105973:	68 60 70 11 80       	push   $0x80117060
80105978:	68 a0 78 11 80       	push   $0x801178a0
8010597d:	e8 1e e5 ff ff       	call   80103ea0 <sleep>
  while(ticks - ticks0 < n){
80105982:	a1 a0 78 11 80       	mov    0x801178a0,%eax
80105987:	83 c4 10             	add    $0x10,%esp
8010598a:	29 d8                	sub    %ebx,%eax
8010598c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010598f:	73 2f                	jae    801059c0 <sys_sleep+0x90>
    if(myproc()->killed){
80105991:	e8 ea de ff ff       	call   80103880 <myproc>
80105996:	8b 40 24             	mov    0x24(%eax),%eax
80105999:	85 c0                	test   %eax,%eax
8010599b:	74 d3                	je     80105970 <sys_sleep+0x40>
      release(&tickslock);
8010599d:	83 ec 0c             	sub    $0xc,%esp
801059a0:	68 60 70 11 80       	push   $0x80117060
801059a5:	e8 26 ee ff ff       	call   801047d0 <release>
      return -1;
801059aa:	83 c4 10             	add    $0x10,%esp
801059ad:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  release(&tickslock);
  return 0;
}
801059b2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801059b5:	c9                   	leave  
801059b6:	c3                   	ret    
801059b7:	89 f6                	mov    %esi,%esi
801059b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  release(&tickslock);
801059c0:	83 ec 0c             	sub    $0xc,%esp
801059c3:	68 60 70 11 80       	push   $0x80117060
801059c8:	e8 03 ee ff ff       	call   801047d0 <release>
  return 0;
801059cd:	83 c4 10             	add    $0x10,%esp
801059d0:	31 c0                	xor    %eax,%eax
}
801059d2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801059d5:	c9                   	leave  
801059d6:	c3                   	ret    
    return -1;
801059d7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801059dc:	eb f4                	jmp    801059d2 <sys_sleep+0xa2>
801059de:	66 90                	xchg   %ax,%ax

801059e0 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
801059e0:	55                   	push   %ebp
801059e1:	89 e5                	mov    %esp,%ebp
801059e3:	53                   	push   %ebx
801059e4:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
801059e7:	68 60 70 11 80       	push   $0x80117060
801059ec:	e8 1f ed ff ff       	call   80104710 <acquire>
  xticks = ticks;
801059f1:	8b 1d a0 78 11 80    	mov    0x801178a0,%ebx
  release(&tickslock);
801059f7:	c7 04 24 60 70 11 80 	movl   $0x80117060,(%esp)
801059fe:	e8 cd ed ff ff       	call   801047d0 <release>
  return xticks;
}
80105a03:	89 d8                	mov    %ebx,%eax
80105a05:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105a08:	c9                   	leave  
80105a09:	c3                   	ret    
80105a0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105a10 <sys_sigprocmask>:

int 
 sys_sigprocmask(void){
80105a10:	55                   	push   %ebp
80105a11:	89 e5                	mov    %esp,%ebp
80105a13:	83 ec 20             	sub    $0x20,%esp
  uint mask;

  if(argint(0, (int *)&mask) < 0)
80105a16:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105a19:	50                   	push   %eax
80105a1a:	6a 00                	push   $0x0
80105a1c:	e8 ff f0 ff ff       	call   80104b20 <argint>
80105a21:	83 c4 10             	add    $0x10,%esp
80105a24:	85 c0                	test   %eax,%eax
80105a26:	78 18                	js     80105a40 <sys_sigprocmask+0x30>
    return -1;
  
  return sigprocmask(mask);
80105a28:	83 ec 0c             	sub    $0xc,%esp
80105a2b:	ff 75 f4             	pushl  -0xc(%ebp)
80105a2e:	e8 dd e7 ff ff       	call   80104210 <sigprocmask>
80105a33:	83 c4 10             	add    $0x10,%esp
 }
80105a36:	c9                   	leave  
80105a37:	c3                   	ret    
80105a38:	90                   	nop
80105a39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105a40:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 }
80105a45:	c9                   	leave  
80105a46:	c3                   	ret    
80105a47:	89 f6                	mov    %esi,%esi
80105a49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105a50 <sys_sigaction>:

 int
 sys_sigaction(void){
80105a50:	55                   	push   %ebp
80105a51:	89 e5                	mov    %esp,%ebp
80105a53:	83 ec 20             	sub    $0x20,%esp
   int signum;
   struct sigaction *act;
   struct sigaction *oldact;

  if(argint(0, &signum) < 0)
80105a56:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105a59:	50                   	push   %eax
80105a5a:	6a 00                	push   $0x0
80105a5c:	e8 bf f0 ff ff       	call   80104b20 <argint>
80105a61:	83 c4 10             	add    $0x10,%esp
80105a64:	85 c0                	test   %eax,%eax
80105a66:	78 48                	js     80105ab0 <sys_sigaction+0x60>
    return -1;
  if(argptr(1, (char**) &act, sizeof(struct sigaction)) < 0)
80105a68:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105a6b:	83 ec 04             	sub    $0x4,%esp
80105a6e:	6a 08                	push   $0x8
80105a70:	50                   	push   %eax
80105a71:	6a 01                	push   $0x1
80105a73:	e8 f8 f0 ff ff       	call   80104b70 <argptr>
80105a78:	83 c4 10             	add    $0x10,%esp
80105a7b:	85 c0                	test   %eax,%eax
80105a7d:	78 31                	js     80105ab0 <sys_sigaction+0x60>
    return -1;
  
  if(argptr(1, (char**)  &oldact, sizeof(struct sigaction)) < 0)
80105a7f:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105a82:	83 ec 04             	sub    $0x4,%esp
80105a85:	6a 08                	push   $0x8
80105a87:	50                   	push   %eax
80105a88:	6a 01                	push   $0x1
80105a8a:	e8 e1 f0 ff ff       	call   80104b70 <argptr>
80105a8f:	83 c4 10             	add    $0x10,%esp
80105a92:	85 c0                	test   %eax,%eax
80105a94:	78 1a                	js     80105ab0 <sys_sigaction+0x60>
    return -1;
  
  return sigaction(signum,act, oldact);
80105a96:	83 ec 04             	sub    $0x4,%esp
80105a99:	ff 75 f4             	pushl  -0xc(%ebp)
80105a9c:	ff 75 f0             	pushl  -0x10(%ebp)
80105a9f:	ff 75 ec             	pushl  -0x14(%ebp)
80105aa2:	e8 a9 e7 ff ff       	call   80104250 <sigaction>
80105aa7:	83 c4 10             	add    $0x10,%esp
 }
80105aaa:	c9                   	leave  
80105aab:	c3                   	ret    
80105aac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105ab0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 }
80105ab5:	c9                   	leave  
80105ab6:	c3                   	ret    
80105ab7:	89 f6                	mov    %esi,%esi
80105ab9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105ac0 <sys_sigret>:

 int
 sys_sigret(void){
80105ac0:	55                   	push   %ebp
   return 0;
 }
80105ac1:	31 c0                	xor    %eax,%eax
 sys_sigret(void){
80105ac3:	89 e5                	mov    %esp,%ebp
 }
80105ac5:	5d                   	pop    %ebp
80105ac6:	c3                   	ret    

80105ac7 <alltraps>:
80105ac7:	1e                   	push   %ds
80105ac8:	06                   	push   %es
80105ac9:	0f a0                	push   %fs
80105acb:	0f a8                	push   %gs
80105acd:	60                   	pusha  
80105ace:	66 b8 10 00          	mov    $0x10,%ax
80105ad2:	8e d8                	mov    %eax,%ds
80105ad4:	8e c0                	mov    %eax,%es
80105ad6:	54                   	push   %esp
80105ad7:	e8 c4 00 00 00       	call   80105ba0 <trap>
80105adc:	83 c4 04             	add    $0x4,%esp

80105adf <trapret>:
80105adf:	61                   	popa   
80105ae0:	0f a9                	pop    %gs
80105ae2:	0f a1                	pop    %fs
80105ae4:	07                   	pop    %es
80105ae5:	1f                   	pop    %ds
80105ae6:	83 c4 08             	add    $0x8,%esp
80105ae9:	cf                   	iret   
80105aea:	66 90                	xchg   %ax,%ax
80105aec:	66 90                	xchg   %ax,%ax
80105aee:	66 90                	xchg   %ax,%ax

80105af0 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80105af0:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
80105af1:	31 c0                	xor    %eax,%eax
{
80105af3:	89 e5                	mov    %esp,%ebp
80105af5:	83 ec 08             	sub    $0x8,%esp
80105af8:	90                   	nop
80105af9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80105b00:	8b 14 85 08 a0 10 80 	mov    -0x7fef5ff8(,%eax,4),%edx
80105b07:	c7 04 c5 a2 70 11 80 	movl   $0x8e000008,-0x7fee8f5e(,%eax,8)
80105b0e:	08 00 00 8e 
80105b12:	66 89 14 c5 a0 70 11 	mov    %dx,-0x7fee8f60(,%eax,8)
80105b19:	80 
80105b1a:	c1 ea 10             	shr    $0x10,%edx
80105b1d:	66 89 14 c5 a6 70 11 	mov    %dx,-0x7fee8f5a(,%eax,8)
80105b24:	80 
  for(i = 0; i < 256; i++)
80105b25:	83 c0 01             	add    $0x1,%eax
80105b28:	3d 00 01 00 00       	cmp    $0x100,%eax
80105b2d:	75 d1                	jne    80105b00 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105b2f:	a1 08 a1 10 80       	mov    0x8010a108,%eax

  initlock(&tickslock, "time");
80105b34:	83 ec 08             	sub    $0x8,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105b37:	c7 05 a2 72 11 80 08 	movl   $0xef000008,0x801172a2
80105b3e:	00 00 ef 
  initlock(&tickslock, "time");
80105b41:	68 05 7b 10 80       	push   $0x80107b05
80105b46:	68 60 70 11 80       	push   $0x80117060
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105b4b:	66 a3 a0 72 11 80    	mov    %ax,0x801172a0
80105b51:	c1 e8 10             	shr    $0x10,%eax
80105b54:	66 a3 a6 72 11 80    	mov    %ax,0x801172a6
  initlock(&tickslock, "time");
80105b5a:	e8 71 ea ff ff       	call   801045d0 <initlock>
}
80105b5f:	83 c4 10             	add    $0x10,%esp
80105b62:	c9                   	leave  
80105b63:	c3                   	ret    
80105b64:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105b6a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80105b70 <idtinit>:

void
idtinit(void)
{
80105b70:	55                   	push   %ebp
  pd[0] = size-1;
80105b71:	b8 ff 07 00 00       	mov    $0x7ff,%eax
80105b76:	89 e5                	mov    %esp,%ebp
80105b78:	83 ec 10             	sub    $0x10,%esp
80105b7b:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
80105b7f:	b8 a0 70 11 80       	mov    $0x801170a0,%eax
80105b84:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80105b88:	c1 e8 10             	shr    $0x10,%eax
80105b8b:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
80105b8f:	8d 45 fa             	lea    -0x6(%ebp),%eax
80105b92:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80105b95:	c9                   	leave  
80105b96:	c3                   	ret    
80105b97:	89 f6                	mov    %esi,%esi
80105b99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105ba0 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80105ba0:	55                   	push   %ebp
80105ba1:	89 e5                	mov    %esp,%ebp
80105ba3:	57                   	push   %edi
80105ba4:	56                   	push   %esi
80105ba5:	53                   	push   %ebx
80105ba6:	83 ec 1c             	sub    $0x1c,%esp
80105ba9:	8b 7d 08             	mov    0x8(%ebp),%edi
  if(tf->trapno == T_SYSCALL){
80105bac:	8b 47 30             	mov    0x30(%edi),%eax
80105baf:	83 f8 40             	cmp    $0x40,%eax
80105bb2:	0f 84 f0 00 00 00    	je     80105ca8 <trap+0x108>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
80105bb8:	83 e8 20             	sub    $0x20,%eax
80105bbb:	83 f8 1f             	cmp    $0x1f,%eax
80105bbe:	77 10                	ja     80105bd0 <trap+0x30>
80105bc0:	ff 24 85 ac 7b 10 80 	jmp    *-0x7fef8454(,%eax,4)
80105bc7:	89 f6                	mov    %esi,%esi
80105bc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    lapiceoi();
    break;

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
80105bd0:	e8 ab dc ff ff       	call   80103880 <myproc>
80105bd5:	85 c0                	test   %eax,%eax
80105bd7:	8b 5f 38             	mov    0x38(%edi),%ebx
80105bda:	0f 84 14 02 00 00    	je     80105df4 <trap+0x254>
80105be0:	f6 47 3c 03          	testb  $0x3,0x3c(%edi)
80105be4:	0f 84 0a 02 00 00    	je     80105df4 <trap+0x254>
  asm volatile("movl %%cr2,%0" : "=r" (val));
80105bea:	0f 20 d1             	mov    %cr2,%ecx
80105bed:	89 4d d8             	mov    %ecx,-0x28(%ebp)
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105bf0:	e8 6b dc ff ff       	call   80103860 <cpuid>
80105bf5:	89 45 dc             	mov    %eax,-0x24(%ebp)
80105bf8:	8b 47 34             	mov    0x34(%edi),%eax
80105bfb:	8b 77 30             	mov    0x30(%edi),%esi
80105bfe:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80105c01:	e8 7a dc ff ff       	call   80103880 <myproc>
80105c06:	89 45 e0             	mov    %eax,-0x20(%ebp)
80105c09:	e8 72 dc ff ff       	call   80103880 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105c0e:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80105c11:	8b 55 dc             	mov    -0x24(%ebp),%edx
80105c14:	51                   	push   %ecx
80105c15:	53                   	push   %ebx
80105c16:	52                   	push   %edx
            myproc()->pid, myproc()->name, tf->trapno,
80105c17:	8b 55 e0             	mov    -0x20(%ebp),%edx
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105c1a:	ff 75 e4             	pushl  -0x1c(%ebp)
80105c1d:	56                   	push   %esi
            myproc()->pid, myproc()->name, tf->trapno,
80105c1e:	83 c2 6c             	add    $0x6c,%edx
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105c21:	52                   	push   %edx
80105c22:	ff 70 10             	pushl  0x10(%eax)
80105c25:	68 68 7b 10 80       	push   $0x80107b68
80105c2a:	e8 31 aa ff ff       	call   80100660 <cprintf>
            tf->err, cpuid(), tf->eip, rcr2());
    myproc()->killed = 1;
80105c2f:	83 c4 20             	add    $0x20,%esp
80105c32:	e8 49 dc ff ff       	call   80103880 <myproc>
80105c37:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105c3e:	e8 3d dc ff ff       	call   80103880 <myproc>
80105c43:	85 c0                	test   %eax,%eax
80105c45:	74 1d                	je     80105c64 <trap+0xc4>
80105c47:	e8 34 dc ff ff       	call   80103880 <myproc>
80105c4c:	8b 50 24             	mov    0x24(%eax),%edx
80105c4f:	85 d2                	test   %edx,%edx
80105c51:	74 11                	je     80105c64 <trap+0xc4>
80105c53:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
80105c57:	83 e0 03             	and    $0x3,%eax
80105c5a:	66 83 f8 03          	cmp    $0x3,%ax
80105c5e:	0f 84 4c 01 00 00    	je     80105db0 <trap+0x210>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80105c64:	e8 17 dc ff ff       	call   80103880 <myproc>
80105c69:	85 c0                	test   %eax,%eax
80105c6b:	74 0b                	je     80105c78 <trap+0xd8>
80105c6d:	e8 0e dc ff ff       	call   80103880 <myproc>
80105c72:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80105c76:	74 68                	je     80105ce0 <trap+0x140>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105c78:	e8 03 dc ff ff       	call   80103880 <myproc>
80105c7d:	85 c0                	test   %eax,%eax
80105c7f:	74 19                	je     80105c9a <trap+0xfa>
80105c81:	e8 fa db ff ff       	call   80103880 <myproc>
80105c86:	8b 40 24             	mov    0x24(%eax),%eax
80105c89:	85 c0                	test   %eax,%eax
80105c8b:	74 0d                	je     80105c9a <trap+0xfa>
80105c8d:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
80105c91:	83 e0 03             	and    $0x3,%eax
80105c94:	66 83 f8 03          	cmp    $0x3,%ax
80105c98:	74 37                	je     80105cd1 <trap+0x131>
    exit();
}
80105c9a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105c9d:	5b                   	pop    %ebx
80105c9e:	5e                   	pop    %esi
80105c9f:	5f                   	pop    %edi
80105ca0:	5d                   	pop    %ebp
80105ca1:	c3                   	ret    
80105ca2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(myproc()->killed)
80105ca8:	e8 d3 db ff ff       	call   80103880 <myproc>
80105cad:	8b 58 24             	mov    0x24(%eax),%ebx
80105cb0:	85 db                	test   %ebx,%ebx
80105cb2:	0f 85 e8 00 00 00    	jne    80105da0 <trap+0x200>
    myproc()->tf = tf;
80105cb8:	e8 c3 db ff ff       	call   80103880 <myproc>
80105cbd:	89 78 18             	mov    %edi,0x18(%eax)
    syscall();
80105cc0:	e8 4b ef ff ff       	call   80104c10 <syscall>
    if(myproc()->killed)
80105cc5:	e8 b6 db ff ff       	call   80103880 <myproc>
80105cca:	8b 48 24             	mov    0x24(%eax),%ecx
80105ccd:	85 c9                	test   %ecx,%ecx
80105ccf:	74 c9                	je     80105c9a <trap+0xfa>
}
80105cd1:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105cd4:	5b                   	pop    %ebx
80105cd5:	5e                   	pop    %esi
80105cd6:	5f                   	pop    %edi
80105cd7:	5d                   	pop    %ebp
      exit();
80105cd8:	e9 43 e0 ff ff       	jmp    80103d20 <exit>
80105cdd:	8d 76 00             	lea    0x0(%esi),%esi
  if(myproc() && myproc()->state == RUNNING &&
80105ce0:	83 7f 30 20          	cmpl   $0x20,0x30(%edi)
80105ce4:	75 92                	jne    80105c78 <trap+0xd8>
    yield();
80105ce6:	e8 65 e1 ff ff       	call   80103e50 <yield>
80105ceb:	eb 8b                	jmp    80105c78 <trap+0xd8>
80105ced:	8d 76 00             	lea    0x0(%esi),%esi
    if(cpuid() == 0){
80105cf0:	e8 6b db ff ff       	call   80103860 <cpuid>
80105cf5:	85 c0                	test   %eax,%eax
80105cf7:	0f 84 c3 00 00 00    	je     80105dc0 <trap+0x220>
    lapiceoi();
80105cfd:	e8 7e ca ff ff       	call   80102780 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105d02:	e8 79 db ff ff       	call   80103880 <myproc>
80105d07:	85 c0                	test   %eax,%eax
80105d09:	0f 85 38 ff ff ff    	jne    80105c47 <trap+0xa7>
80105d0f:	e9 50 ff ff ff       	jmp    80105c64 <trap+0xc4>
80105d14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    kbdintr();
80105d18:	e8 23 c9 ff ff       	call   80102640 <kbdintr>
    lapiceoi();
80105d1d:	e8 5e ca ff ff       	call   80102780 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105d22:	e8 59 db ff ff       	call   80103880 <myproc>
80105d27:	85 c0                	test   %eax,%eax
80105d29:	0f 85 18 ff ff ff    	jne    80105c47 <trap+0xa7>
80105d2f:	e9 30 ff ff ff       	jmp    80105c64 <trap+0xc4>
80105d34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    uartintr();
80105d38:	e8 53 02 00 00       	call   80105f90 <uartintr>
    lapiceoi();
80105d3d:	e8 3e ca ff ff       	call   80102780 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105d42:	e8 39 db ff ff       	call   80103880 <myproc>
80105d47:	85 c0                	test   %eax,%eax
80105d49:	0f 85 f8 fe ff ff    	jne    80105c47 <trap+0xa7>
80105d4f:	e9 10 ff ff ff       	jmp    80105c64 <trap+0xc4>
80105d54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80105d58:	0f b7 5f 3c          	movzwl 0x3c(%edi),%ebx
80105d5c:	8b 77 38             	mov    0x38(%edi),%esi
80105d5f:	e8 fc da ff ff       	call   80103860 <cpuid>
80105d64:	56                   	push   %esi
80105d65:	53                   	push   %ebx
80105d66:	50                   	push   %eax
80105d67:	68 10 7b 10 80       	push   $0x80107b10
80105d6c:	e8 ef a8 ff ff       	call   80100660 <cprintf>
    lapiceoi();
80105d71:	e8 0a ca ff ff       	call   80102780 <lapiceoi>
    break;
80105d76:	83 c4 10             	add    $0x10,%esp
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105d79:	e8 02 db ff ff       	call   80103880 <myproc>
80105d7e:	85 c0                	test   %eax,%eax
80105d80:	0f 85 c1 fe ff ff    	jne    80105c47 <trap+0xa7>
80105d86:	e9 d9 fe ff ff       	jmp    80105c64 <trap+0xc4>
80105d8b:	90                   	nop
80105d8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ideintr();
80105d90:	e8 1b c3 ff ff       	call   801020b0 <ideintr>
80105d95:	e9 63 ff ff ff       	jmp    80105cfd <trap+0x15d>
80105d9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit();
80105da0:	e8 7b df ff ff       	call   80103d20 <exit>
80105da5:	e9 0e ff ff ff       	jmp    80105cb8 <trap+0x118>
80105daa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    exit();
80105db0:	e8 6b df ff ff       	call   80103d20 <exit>
80105db5:	e9 aa fe ff ff       	jmp    80105c64 <trap+0xc4>
80105dba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      acquire(&tickslock);
80105dc0:	83 ec 0c             	sub    $0xc,%esp
80105dc3:	68 60 70 11 80       	push   $0x80117060
80105dc8:	e8 43 e9 ff ff       	call   80104710 <acquire>
      wakeup(&ticks);
80105dcd:	c7 04 24 a0 78 11 80 	movl   $0x801178a0,(%esp)
      ticks++;
80105dd4:	83 05 a0 78 11 80 01 	addl   $0x1,0x801178a0
      wakeup(&ticks);
80105ddb:	e8 80 e2 ff ff       	call   80104060 <wakeup>
      release(&tickslock);
80105de0:	c7 04 24 60 70 11 80 	movl   $0x80117060,(%esp)
80105de7:	e8 e4 e9 ff ff       	call   801047d0 <release>
80105dec:	83 c4 10             	add    $0x10,%esp
80105def:	e9 09 ff ff ff       	jmp    80105cfd <trap+0x15d>
80105df4:	0f 20 d6             	mov    %cr2,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80105df7:	e8 64 da ff ff       	call   80103860 <cpuid>
80105dfc:	83 ec 0c             	sub    $0xc,%esp
80105dff:	56                   	push   %esi
80105e00:	53                   	push   %ebx
80105e01:	50                   	push   %eax
80105e02:	ff 77 30             	pushl  0x30(%edi)
80105e05:	68 34 7b 10 80       	push   $0x80107b34
80105e0a:	e8 51 a8 ff ff       	call   80100660 <cprintf>
      panic("trap");
80105e0f:	83 c4 14             	add    $0x14,%esp
80105e12:	68 0a 7b 10 80       	push   $0x80107b0a
80105e17:	e8 74 a5 ff ff       	call   80100390 <panic>
80105e1c:	66 90                	xchg   %ax,%ax
80105e1e:	66 90                	xchg   %ax,%ax

80105e20 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80105e20:	a1 bc a5 10 80       	mov    0x8010a5bc,%eax
{
80105e25:	55                   	push   %ebp
80105e26:	89 e5                	mov    %esp,%ebp
  if(!uart)
80105e28:	85 c0                	test   %eax,%eax
80105e2a:	74 1c                	je     80105e48 <uartgetc+0x28>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105e2c:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105e31:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
80105e32:	a8 01                	test   $0x1,%al
80105e34:	74 12                	je     80105e48 <uartgetc+0x28>
80105e36:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105e3b:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
80105e3c:	0f b6 c0             	movzbl %al,%eax
}
80105e3f:	5d                   	pop    %ebp
80105e40:	c3                   	ret    
80105e41:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105e48:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105e4d:	5d                   	pop    %ebp
80105e4e:	c3                   	ret    
80105e4f:	90                   	nop

80105e50 <uartputc.part.0>:
uartputc(int c)
80105e50:	55                   	push   %ebp
80105e51:	89 e5                	mov    %esp,%ebp
80105e53:	57                   	push   %edi
80105e54:	56                   	push   %esi
80105e55:	53                   	push   %ebx
80105e56:	89 c7                	mov    %eax,%edi
80105e58:	bb 80 00 00 00       	mov    $0x80,%ebx
80105e5d:	be fd 03 00 00       	mov    $0x3fd,%esi
80105e62:	83 ec 0c             	sub    $0xc,%esp
80105e65:	eb 1b                	jmp    80105e82 <uartputc.part.0+0x32>
80105e67:	89 f6                	mov    %esi,%esi
80105e69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    microdelay(10);
80105e70:	83 ec 0c             	sub    $0xc,%esp
80105e73:	6a 0a                	push   $0xa
80105e75:	e8 26 c9 ff ff       	call   801027a0 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80105e7a:	83 c4 10             	add    $0x10,%esp
80105e7d:	83 eb 01             	sub    $0x1,%ebx
80105e80:	74 07                	je     80105e89 <uartputc.part.0+0x39>
80105e82:	89 f2                	mov    %esi,%edx
80105e84:	ec                   	in     (%dx),%al
80105e85:	a8 20                	test   $0x20,%al
80105e87:	74 e7                	je     80105e70 <uartputc.part.0+0x20>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80105e89:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105e8e:	89 f8                	mov    %edi,%eax
80105e90:	ee                   	out    %al,(%dx)
}
80105e91:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105e94:	5b                   	pop    %ebx
80105e95:	5e                   	pop    %esi
80105e96:	5f                   	pop    %edi
80105e97:	5d                   	pop    %ebp
80105e98:	c3                   	ret    
80105e99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105ea0 <uartinit>:
{
80105ea0:	55                   	push   %ebp
80105ea1:	31 c9                	xor    %ecx,%ecx
80105ea3:	89 c8                	mov    %ecx,%eax
80105ea5:	89 e5                	mov    %esp,%ebp
80105ea7:	57                   	push   %edi
80105ea8:	56                   	push   %esi
80105ea9:	53                   	push   %ebx
80105eaa:	bb fa 03 00 00       	mov    $0x3fa,%ebx
80105eaf:	89 da                	mov    %ebx,%edx
80105eb1:	83 ec 0c             	sub    $0xc,%esp
80105eb4:	ee                   	out    %al,(%dx)
80105eb5:	bf fb 03 00 00       	mov    $0x3fb,%edi
80105eba:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
80105ebf:	89 fa                	mov    %edi,%edx
80105ec1:	ee                   	out    %al,(%dx)
80105ec2:	b8 0c 00 00 00       	mov    $0xc,%eax
80105ec7:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105ecc:	ee                   	out    %al,(%dx)
80105ecd:	be f9 03 00 00       	mov    $0x3f9,%esi
80105ed2:	89 c8                	mov    %ecx,%eax
80105ed4:	89 f2                	mov    %esi,%edx
80105ed6:	ee                   	out    %al,(%dx)
80105ed7:	b8 03 00 00 00       	mov    $0x3,%eax
80105edc:	89 fa                	mov    %edi,%edx
80105ede:	ee                   	out    %al,(%dx)
80105edf:	ba fc 03 00 00       	mov    $0x3fc,%edx
80105ee4:	89 c8                	mov    %ecx,%eax
80105ee6:	ee                   	out    %al,(%dx)
80105ee7:	b8 01 00 00 00       	mov    $0x1,%eax
80105eec:	89 f2                	mov    %esi,%edx
80105eee:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105eef:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105ef4:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
80105ef5:	3c ff                	cmp    $0xff,%al
80105ef7:	74 5a                	je     80105f53 <uartinit+0xb3>
  uart = 1;
80105ef9:	c7 05 bc a5 10 80 01 	movl   $0x1,0x8010a5bc
80105f00:	00 00 00 
80105f03:	89 da                	mov    %ebx,%edx
80105f05:	ec                   	in     (%dx),%al
80105f06:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105f0b:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
80105f0c:	83 ec 08             	sub    $0x8,%esp
  for(p="xv6...\n"; *p; p++)
80105f0f:	bb 2c 7c 10 80       	mov    $0x80107c2c,%ebx
  ioapicenable(IRQ_COM1, 0);
80105f14:	6a 00                	push   $0x0
80105f16:	6a 04                	push   $0x4
80105f18:	e8 e3 c3 ff ff       	call   80102300 <ioapicenable>
80105f1d:	83 c4 10             	add    $0x10,%esp
  for(p="xv6...\n"; *p; p++)
80105f20:	b8 78 00 00 00       	mov    $0x78,%eax
80105f25:	eb 13                	jmp    80105f3a <uartinit+0x9a>
80105f27:	89 f6                	mov    %esi,%esi
80105f29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105f30:	83 c3 01             	add    $0x1,%ebx
80105f33:	0f be 03             	movsbl (%ebx),%eax
80105f36:	84 c0                	test   %al,%al
80105f38:	74 19                	je     80105f53 <uartinit+0xb3>
  if(!uart)
80105f3a:	8b 15 bc a5 10 80    	mov    0x8010a5bc,%edx
80105f40:	85 d2                	test   %edx,%edx
80105f42:	74 ec                	je     80105f30 <uartinit+0x90>
  for(p="xv6...\n"; *p; p++)
80105f44:	83 c3 01             	add    $0x1,%ebx
80105f47:	e8 04 ff ff ff       	call   80105e50 <uartputc.part.0>
80105f4c:	0f be 03             	movsbl (%ebx),%eax
80105f4f:	84 c0                	test   %al,%al
80105f51:	75 e7                	jne    80105f3a <uartinit+0x9a>
}
80105f53:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105f56:	5b                   	pop    %ebx
80105f57:	5e                   	pop    %esi
80105f58:	5f                   	pop    %edi
80105f59:	5d                   	pop    %ebp
80105f5a:	c3                   	ret    
80105f5b:	90                   	nop
80105f5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105f60 <uartputc>:
  if(!uart)
80105f60:	8b 15 bc a5 10 80    	mov    0x8010a5bc,%edx
{
80105f66:	55                   	push   %ebp
80105f67:	89 e5                	mov    %esp,%ebp
  if(!uart)
80105f69:	85 d2                	test   %edx,%edx
{
80105f6b:	8b 45 08             	mov    0x8(%ebp),%eax
  if(!uart)
80105f6e:	74 10                	je     80105f80 <uartputc+0x20>
}
80105f70:	5d                   	pop    %ebp
80105f71:	e9 da fe ff ff       	jmp    80105e50 <uartputc.part.0>
80105f76:	8d 76 00             	lea    0x0(%esi),%esi
80105f79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105f80:	5d                   	pop    %ebp
80105f81:	c3                   	ret    
80105f82:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105f89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105f90 <uartintr>:

void
uartintr(void)
{
80105f90:	55                   	push   %ebp
80105f91:	89 e5                	mov    %esp,%ebp
80105f93:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
80105f96:	68 20 5e 10 80       	push   $0x80105e20
80105f9b:	e8 70 a8 ff ff       	call   80100810 <consoleintr>
}
80105fa0:	83 c4 10             	add    $0x10,%esp
80105fa3:	c9                   	leave  
80105fa4:	c3                   	ret    

80105fa5 <vector0>:
80105fa5:	6a 00                	push   $0x0
80105fa7:	6a 00                	push   $0x0
80105fa9:	e9 19 fb ff ff       	jmp    80105ac7 <alltraps>

80105fae <vector1>:
80105fae:	6a 00                	push   $0x0
80105fb0:	6a 01                	push   $0x1
80105fb2:	e9 10 fb ff ff       	jmp    80105ac7 <alltraps>

80105fb7 <vector2>:
80105fb7:	6a 00                	push   $0x0
80105fb9:	6a 02                	push   $0x2
80105fbb:	e9 07 fb ff ff       	jmp    80105ac7 <alltraps>

80105fc0 <vector3>:
80105fc0:	6a 00                	push   $0x0
80105fc2:	6a 03                	push   $0x3
80105fc4:	e9 fe fa ff ff       	jmp    80105ac7 <alltraps>

80105fc9 <vector4>:
80105fc9:	6a 00                	push   $0x0
80105fcb:	6a 04                	push   $0x4
80105fcd:	e9 f5 fa ff ff       	jmp    80105ac7 <alltraps>

80105fd2 <vector5>:
80105fd2:	6a 00                	push   $0x0
80105fd4:	6a 05                	push   $0x5
80105fd6:	e9 ec fa ff ff       	jmp    80105ac7 <alltraps>

80105fdb <vector6>:
80105fdb:	6a 00                	push   $0x0
80105fdd:	6a 06                	push   $0x6
80105fdf:	e9 e3 fa ff ff       	jmp    80105ac7 <alltraps>

80105fe4 <vector7>:
80105fe4:	6a 00                	push   $0x0
80105fe6:	6a 07                	push   $0x7
80105fe8:	e9 da fa ff ff       	jmp    80105ac7 <alltraps>

80105fed <vector8>:
80105fed:	6a 08                	push   $0x8
80105fef:	e9 d3 fa ff ff       	jmp    80105ac7 <alltraps>

80105ff4 <vector9>:
80105ff4:	6a 00                	push   $0x0
80105ff6:	6a 09                	push   $0x9
80105ff8:	e9 ca fa ff ff       	jmp    80105ac7 <alltraps>

80105ffd <vector10>:
80105ffd:	6a 0a                	push   $0xa
80105fff:	e9 c3 fa ff ff       	jmp    80105ac7 <alltraps>

80106004 <vector11>:
80106004:	6a 0b                	push   $0xb
80106006:	e9 bc fa ff ff       	jmp    80105ac7 <alltraps>

8010600b <vector12>:
8010600b:	6a 0c                	push   $0xc
8010600d:	e9 b5 fa ff ff       	jmp    80105ac7 <alltraps>

80106012 <vector13>:
80106012:	6a 0d                	push   $0xd
80106014:	e9 ae fa ff ff       	jmp    80105ac7 <alltraps>

80106019 <vector14>:
80106019:	6a 0e                	push   $0xe
8010601b:	e9 a7 fa ff ff       	jmp    80105ac7 <alltraps>

80106020 <vector15>:
80106020:	6a 00                	push   $0x0
80106022:	6a 0f                	push   $0xf
80106024:	e9 9e fa ff ff       	jmp    80105ac7 <alltraps>

80106029 <vector16>:
80106029:	6a 00                	push   $0x0
8010602b:	6a 10                	push   $0x10
8010602d:	e9 95 fa ff ff       	jmp    80105ac7 <alltraps>

80106032 <vector17>:
80106032:	6a 11                	push   $0x11
80106034:	e9 8e fa ff ff       	jmp    80105ac7 <alltraps>

80106039 <vector18>:
80106039:	6a 00                	push   $0x0
8010603b:	6a 12                	push   $0x12
8010603d:	e9 85 fa ff ff       	jmp    80105ac7 <alltraps>

80106042 <vector19>:
80106042:	6a 00                	push   $0x0
80106044:	6a 13                	push   $0x13
80106046:	e9 7c fa ff ff       	jmp    80105ac7 <alltraps>

8010604b <vector20>:
8010604b:	6a 00                	push   $0x0
8010604d:	6a 14                	push   $0x14
8010604f:	e9 73 fa ff ff       	jmp    80105ac7 <alltraps>

80106054 <vector21>:
80106054:	6a 00                	push   $0x0
80106056:	6a 15                	push   $0x15
80106058:	e9 6a fa ff ff       	jmp    80105ac7 <alltraps>

8010605d <vector22>:
8010605d:	6a 00                	push   $0x0
8010605f:	6a 16                	push   $0x16
80106061:	e9 61 fa ff ff       	jmp    80105ac7 <alltraps>

80106066 <vector23>:
80106066:	6a 00                	push   $0x0
80106068:	6a 17                	push   $0x17
8010606a:	e9 58 fa ff ff       	jmp    80105ac7 <alltraps>

8010606f <vector24>:
8010606f:	6a 00                	push   $0x0
80106071:	6a 18                	push   $0x18
80106073:	e9 4f fa ff ff       	jmp    80105ac7 <alltraps>

80106078 <vector25>:
80106078:	6a 00                	push   $0x0
8010607a:	6a 19                	push   $0x19
8010607c:	e9 46 fa ff ff       	jmp    80105ac7 <alltraps>

80106081 <vector26>:
80106081:	6a 00                	push   $0x0
80106083:	6a 1a                	push   $0x1a
80106085:	e9 3d fa ff ff       	jmp    80105ac7 <alltraps>

8010608a <vector27>:
8010608a:	6a 00                	push   $0x0
8010608c:	6a 1b                	push   $0x1b
8010608e:	e9 34 fa ff ff       	jmp    80105ac7 <alltraps>

80106093 <vector28>:
80106093:	6a 00                	push   $0x0
80106095:	6a 1c                	push   $0x1c
80106097:	e9 2b fa ff ff       	jmp    80105ac7 <alltraps>

8010609c <vector29>:
8010609c:	6a 00                	push   $0x0
8010609e:	6a 1d                	push   $0x1d
801060a0:	e9 22 fa ff ff       	jmp    80105ac7 <alltraps>

801060a5 <vector30>:
801060a5:	6a 00                	push   $0x0
801060a7:	6a 1e                	push   $0x1e
801060a9:	e9 19 fa ff ff       	jmp    80105ac7 <alltraps>

801060ae <vector31>:
801060ae:	6a 00                	push   $0x0
801060b0:	6a 1f                	push   $0x1f
801060b2:	e9 10 fa ff ff       	jmp    80105ac7 <alltraps>

801060b7 <vector32>:
801060b7:	6a 00                	push   $0x0
801060b9:	6a 20                	push   $0x20
801060bb:	e9 07 fa ff ff       	jmp    80105ac7 <alltraps>

801060c0 <vector33>:
801060c0:	6a 00                	push   $0x0
801060c2:	6a 21                	push   $0x21
801060c4:	e9 fe f9 ff ff       	jmp    80105ac7 <alltraps>

801060c9 <vector34>:
801060c9:	6a 00                	push   $0x0
801060cb:	6a 22                	push   $0x22
801060cd:	e9 f5 f9 ff ff       	jmp    80105ac7 <alltraps>

801060d2 <vector35>:
801060d2:	6a 00                	push   $0x0
801060d4:	6a 23                	push   $0x23
801060d6:	e9 ec f9 ff ff       	jmp    80105ac7 <alltraps>

801060db <vector36>:
801060db:	6a 00                	push   $0x0
801060dd:	6a 24                	push   $0x24
801060df:	e9 e3 f9 ff ff       	jmp    80105ac7 <alltraps>

801060e4 <vector37>:
801060e4:	6a 00                	push   $0x0
801060e6:	6a 25                	push   $0x25
801060e8:	e9 da f9 ff ff       	jmp    80105ac7 <alltraps>

801060ed <vector38>:
801060ed:	6a 00                	push   $0x0
801060ef:	6a 26                	push   $0x26
801060f1:	e9 d1 f9 ff ff       	jmp    80105ac7 <alltraps>

801060f6 <vector39>:
801060f6:	6a 00                	push   $0x0
801060f8:	6a 27                	push   $0x27
801060fa:	e9 c8 f9 ff ff       	jmp    80105ac7 <alltraps>

801060ff <vector40>:
801060ff:	6a 00                	push   $0x0
80106101:	6a 28                	push   $0x28
80106103:	e9 bf f9 ff ff       	jmp    80105ac7 <alltraps>

80106108 <vector41>:
80106108:	6a 00                	push   $0x0
8010610a:	6a 29                	push   $0x29
8010610c:	e9 b6 f9 ff ff       	jmp    80105ac7 <alltraps>

80106111 <vector42>:
80106111:	6a 00                	push   $0x0
80106113:	6a 2a                	push   $0x2a
80106115:	e9 ad f9 ff ff       	jmp    80105ac7 <alltraps>

8010611a <vector43>:
8010611a:	6a 00                	push   $0x0
8010611c:	6a 2b                	push   $0x2b
8010611e:	e9 a4 f9 ff ff       	jmp    80105ac7 <alltraps>

80106123 <vector44>:
80106123:	6a 00                	push   $0x0
80106125:	6a 2c                	push   $0x2c
80106127:	e9 9b f9 ff ff       	jmp    80105ac7 <alltraps>

8010612c <vector45>:
8010612c:	6a 00                	push   $0x0
8010612e:	6a 2d                	push   $0x2d
80106130:	e9 92 f9 ff ff       	jmp    80105ac7 <alltraps>

80106135 <vector46>:
80106135:	6a 00                	push   $0x0
80106137:	6a 2e                	push   $0x2e
80106139:	e9 89 f9 ff ff       	jmp    80105ac7 <alltraps>

8010613e <vector47>:
8010613e:	6a 00                	push   $0x0
80106140:	6a 2f                	push   $0x2f
80106142:	e9 80 f9 ff ff       	jmp    80105ac7 <alltraps>

80106147 <vector48>:
80106147:	6a 00                	push   $0x0
80106149:	6a 30                	push   $0x30
8010614b:	e9 77 f9 ff ff       	jmp    80105ac7 <alltraps>

80106150 <vector49>:
80106150:	6a 00                	push   $0x0
80106152:	6a 31                	push   $0x31
80106154:	e9 6e f9 ff ff       	jmp    80105ac7 <alltraps>

80106159 <vector50>:
80106159:	6a 00                	push   $0x0
8010615b:	6a 32                	push   $0x32
8010615d:	e9 65 f9 ff ff       	jmp    80105ac7 <alltraps>

80106162 <vector51>:
80106162:	6a 00                	push   $0x0
80106164:	6a 33                	push   $0x33
80106166:	e9 5c f9 ff ff       	jmp    80105ac7 <alltraps>

8010616b <vector52>:
8010616b:	6a 00                	push   $0x0
8010616d:	6a 34                	push   $0x34
8010616f:	e9 53 f9 ff ff       	jmp    80105ac7 <alltraps>

80106174 <vector53>:
80106174:	6a 00                	push   $0x0
80106176:	6a 35                	push   $0x35
80106178:	e9 4a f9 ff ff       	jmp    80105ac7 <alltraps>

8010617d <vector54>:
8010617d:	6a 00                	push   $0x0
8010617f:	6a 36                	push   $0x36
80106181:	e9 41 f9 ff ff       	jmp    80105ac7 <alltraps>

80106186 <vector55>:
80106186:	6a 00                	push   $0x0
80106188:	6a 37                	push   $0x37
8010618a:	e9 38 f9 ff ff       	jmp    80105ac7 <alltraps>

8010618f <vector56>:
8010618f:	6a 00                	push   $0x0
80106191:	6a 38                	push   $0x38
80106193:	e9 2f f9 ff ff       	jmp    80105ac7 <alltraps>

80106198 <vector57>:
80106198:	6a 00                	push   $0x0
8010619a:	6a 39                	push   $0x39
8010619c:	e9 26 f9 ff ff       	jmp    80105ac7 <alltraps>

801061a1 <vector58>:
801061a1:	6a 00                	push   $0x0
801061a3:	6a 3a                	push   $0x3a
801061a5:	e9 1d f9 ff ff       	jmp    80105ac7 <alltraps>

801061aa <vector59>:
801061aa:	6a 00                	push   $0x0
801061ac:	6a 3b                	push   $0x3b
801061ae:	e9 14 f9 ff ff       	jmp    80105ac7 <alltraps>

801061b3 <vector60>:
801061b3:	6a 00                	push   $0x0
801061b5:	6a 3c                	push   $0x3c
801061b7:	e9 0b f9 ff ff       	jmp    80105ac7 <alltraps>

801061bc <vector61>:
801061bc:	6a 00                	push   $0x0
801061be:	6a 3d                	push   $0x3d
801061c0:	e9 02 f9 ff ff       	jmp    80105ac7 <alltraps>

801061c5 <vector62>:
801061c5:	6a 00                	push   $0x0
801061c7:	6a 3e                	push   $0x3e
801061c9:	e9 f9 f8 ff ff       	jmp    80105ac7 <alltraps>

801061ce <vector63>:
801061ce:	6a 00                	push   $0x0
801061d0:	6a 3f                	push   $0x3f
801061d2:	e9 f0 f8 ff ff       	jmp    80105ac7 <alltraps>

801061d7 <vector64>:
801061d7:	6a 00                	push   $0x0
801061d9:	6a 40                	push   $0x40
801061db:	e9 e7 f8 ff ff       	jmp    80105ac7 <alltraps>

801061e0 <vector65>:
801061e0:	6a 00                	push   $0x0
801061e2:	6a 41                	push   $0x41
801061e4:	e9 de f8 ff ff       	jmp    80105ac7 <alltraps>

801061e9 <vector66>:
801061e9:	6a 00                	push   $0x0
801061eb:	6a 42                	push   $0x42
801061ed:	e9 d5 f8 ff ff       	jmp    80105ac7 <alltraps>

801061f2 <vector67>:
801061f2:	6a 00                	push   $0x0
801061f4:	6a 43                	push   $0x43
801061f6:	e9 cc f8 ff ff       	jmp    80105ac7 <alltraps>

801061fb <vector68>:
801061fb:	6a 00                	push   $0x0
801061fd:	6a 44                	push   $0x44
801061ff:	e9 c3 f8 ff ff       	jmp    80105ac7 <alltraps>

80106204 <vector69>:
80106204:	6a 00                	push   $0x0
80106206:	6a 45                	push   $0x45
80106208:	e9 ba f8 ff ff       	jmp    80105ac7 <alltraps>

8010620d <vector70>:
8010620d:	6a 00                	push   $0x0
8010620f:	6a 46                	push   $0x46
80106211:	e9 b1 f8 ff ff       	jmp    80105ac7 <alltraps>

80106216 <vector71>:
80106216:	6a 00                	push   $0x0
80106218:	6a 47                	push   $0x47
8010621a:	e9 a8 f8 ff ff       	jmp    80105ac7 <alltraps>

8010621f <vector72>:
8010621f:	6a 00                	push   $0x0
80106221:	6a 48                	push   $0x48
80106223:	e9 9f f8 ff ff       	jmp    80105ac7 <alltraps>

80106228 <vector73>:
80106228:	6a 00                	push   $0x0
8010622a:	6a 49                	push   $0x49
8010622c:	e9 96 f8 ff ff       	jmp    80105ac7 <alltraps>

80106231 <vector74>:
80106231:	6a 00                	push   $0x0
80106233:	6a 4a                	push   $0x4a
80106235:	e9 8d f8 ff ff       	jmp    80105ac7 <alltraps>

8010623a <vector75>:
8010623a:	6a 00                	push   $0x0
8010623c:	6a 4b                	push   $0x4b
8010623e:	e9 84 f8 ff ff       	jmp    80105ac7 <alltraps>

80106243 <vector76>:
80106243:	6a 00                	push   $0x0
80106245:	6a 4c                	push   $0x4c
80106247:	e9 7b f8 ff ff       	jmp    80105ac7 <alltraps>

8010624c <vector77>:
8010624c:	6a 00                	push   $0x0
8010624e:	6a 4d                	push   $0x4d
80106250:	e9 72 f8 ff ff       	jmp    80105ac7 <alltraps>

80106255 <vector78>:
80106255:	6a 00                	push   $0x0
80106257:	6a 4e                	push   $0x4e
80106259:	e9 69 f8 ff ff       	jmp    80105ac7 <alltraps>

8010625e <vector79>:
8010625e:	6a 00                	push   $0x0
80106260:	6a 4f                	push   $0x4f
80106262:	e9 60 f8 ff ff       	jmp    80105ac7 <alltraps>

80106267 <vector80>:
80106267:	6a 00                	push   $0x0
80106269:	6a 50                	push   $0x50
8010626b:	e9 57 f8 ff ff       	jmp    80105ac7 <alltraps>

80106270 <vector81>:
80106270:	6a 00                	push   $0x0
80106272:	6a 51                	push   $0x51
80106274:	e9 4e f8 ff ff       	jmp    80105ac7 <alltraps>

80106279 <vector82>:
80106279:	6a 00                	push   $0x0
8010627b:	6a 52                	push   $0x52
8010627d:	e9 45 f8 ff ff       	jmp    80105ac7 <alltraps>

80106282 <vector83>:
80106282:	6a 00                	push   $0x0
80106284:	6a 53                	push   $0x53
80106286:	e9 3c f8 ff ff       	jmp    80105ac7 <alltraps>

8010628b <vector84>:
8010628b:	6a 00                	push   $0x0
8010628d:	6a 54                	push   $0x54
8010628f:	e9 33 f8 ff ff       	jmp    80105ac7 <alltraps>

80106294 <vector85>:
80106294:	6a 00                	push   $0x0
80106296:	6a 55                	push   $0x55
80106298:	e9 2a f8 ff ff       	jmp    80105ac7 <alltraps>

8010629d <vector86>:
8010629d:	6a 00                	push   $0x0
8010629f:	6a 56                	push   $0x56
801062a1:	e9 21 f8 ff ff       	jmp    80105ac7 <alltraps>

801062a6 <vector87>:
801062a6:	6a 00                	push   $0x0
801062a8:	6a 57                	push   $0x57
801062aa:	e9 18 f8 ff ff       	jmp    80105ac7 <alltraps>

801062af <vector88>:
801062af:	6a 00                	push   $0x0
801062b1:	6a 58                	push   $0x58
801062b3:	e9 0f f8 ff ff       	jmp    80105ac7 <alltraps>

801062b8 <vector89>:
801062b8:	6a 00                	push   $0x0
801062ba:	6a 59                	push   $0x59
801062bc:	e9 06 f8 ff ff       	jmp    80105ac7 <alltraps>

801062c1 <vector90>:
801062c1:	6a 00                	push   $0x0
801062c3:	6a 5a                	push   $0x5a
801062c5:	e9 fd f7 ff ff       	jmp    80105ac7 <alltraps>

801062ca <vector91>:
801062ca:	6a 00                	push   $0x0
801062cc:	6a 5b                	push   $0x5b
801062ce:	e9 f4 f7 ff ff       	jmp    80105ac7 <alltraps>

801062d3 <vector92>:
801062d3:	6a 00                	push   $0x0
801062d5:	6a 5c                	push   $0x5c
801062d7:	e9 eb f7 ff ff       	jmp    80105ac7 <alltraps>

801062dc <vector93>:
801062dc:	6a 00                	push   $0x0
801062de:	6a 5d                	push   $0x5d
801062e0:	e9 e2 f7 ff ff       	jmp    80105ac7 <alltraps>

801062e5 <vector94>:
801062e5:	6a 00                	push   $0x0
801062e7:	6a 5e                	push   $0x5e
801062e9:	e9 d9 f7 ff ff       	jmp    80105ac7 <alltraps>

801062ee <vector95>:
801062ee:	6a 00                	push   $0x0
801062f0:	6a 5f                	push   $0x5f
801062f2:	e9 d0 f7 ff ff       	jmp    80105ac7 <alltraps>

801062f7 <vector96>:
801062f7:	6a 00                	push   $0x0
801062f9:	6a 60                	push   $0x60
801062fb:	e9 c7 f7 ff ff       	jmp    80105ac7 <alltraps>

80106300 <vector97>:
80106300:	6a 00                	push   $0x0
80106302:	6a 61                	push   $0x61
80106304:	e9 be f7 ff ff       	jmp    80105ac7 <alltraps>

80106309 <vector98>:
80106309:	6a 00                	push   $0x0
8010630b:	6a 62                	push   $0x62
8010630d:	e9 b5 f7 ff ff       	jmp    80105ac7 <alltraps>

80106312 <vector99>:
80106312:	6a 00                	push   $0x0
80106314:	6a 63                	push   $0x63
80106316:	e9 ac f7 ff ff       	jmp    80105ac7 <alltraps>

8010631b <vector100>:
8010631b:	6a 00                	push   $0x0
8010631d:	6a 64                	push   $0x64
8010631f:	e9 a3 f7 ff ff       	jmp    80105ac7 <alltraps>

80106324 <vector101>:
80106324:	6a 00                	push   $0x0
80106326:	6a 65                	push   $0x65
80106328:	e9 9a f7 ff ff       	jmp    80105ac7 <alltraps>

8010632d <vector102>:
8010632d:	6a 00                	push   $0x0
8010632f:	6a 66                	push   $0x66
80106331:	e9 91 f7 ff ff       	jmp    80105ac7 <alltraps>

80106336 <vector103>:
80106336:	6a 00                	push   $0x0
80106338:	6a 67                	push   $0x67
8010633a:	e9 88 f7 ff ff       	jmp    80105ac7 <alltraps>

8010633f <vector104>:
8010633f:	6a 00                	push   $0x0
80106341:	6a 68                	push   $0x68
80106343:	e9 7f f7 ff ff       	jmp    80105ac7 <alltraps>

80106348 <vector105>:
80106348:	6a 00                	push   $0x0
8010634a:	6a 69                	push   $0x69
8010634c:	e9 76 f7 ff ff       	jmp    80105ac7 <alltraps>

80106351 <vector106>:
80106351:	6a 00                	push   $0x0
80106353:	6a 6a                	push   $0x6a
80106355:	e9 6d f7 ff ff       	jmp    80105ac7 <alltraps>

8010635a <vector107>:
8010635a:	6a 00                	push   $0x0
8010635c:	6a 6b                	push   $0x6b
8010635e:	e9 64 f7 ff ff       	jmp    80105ac7 <alltraps>

80106363 <vector108>:
80106363:	6a 00                	push   $0x0
80106365:	6a 6c                	push   $0x6c
80106367:	e9 5b f7 ff ff       	jmp    80105ac7 <alltraps>

8010636c <vector109>:
8010636c:	6a 00                	push   $0x0
8010636e:	6a 6d                	push   $0x6d
80106370:	e9 52 f7 ff ff       	jmp    80105ac7 <alltraps>

80106375 <vector110>:
80106375:	6a 00                	push   $0x0
80106377:	6a 6e                	push   $0x6e
80106379:	e9 49 f7 ff ff       	jmp    80105ac7 <alltraps>

8010637e <vector111>:
8010637e:	6a 00                	push   $0x0
80106380:	6a 6f                	push   $0x6f
80106382:	e9 40 f7 ff ff       	jmp    80105ac7 <alltraps>

80106387 <vector112>:
80106387:	6a 00                	push   $0x0
80106389:	6a 70                	push   $0x70
8010638b:	e9 37 f7 ff ff       	jmp    80105ac7 <alltraps>

80106390 <vector113>:
80106390:	6a 00                	push   $0x0
80106392:	6a 71                	push   $0x71
80106394:	e9 2e f7 ff ff       	jmp    80105ac7 <alltraps>

80106399 <vector114>:
80106399:	6a 00                	push   $0x0
8010639b:	6a 72                	push   $0x72
8010639d:	e9 25 f7 ff ff       	jmp    80105ac7 <alltraps>

801063a2 <vector115>:
801063a2:	6a 00                	push   $0x0
801063a4:	6a 73                	push   $0x73
801063a6:	e9 1c f7 ff ff       	jmp    80105ac7 <alltraps>

801063ab <vector116>:
801063ab:	6a 00                	push   $0x0
801063ad:	6a 74                	push   $0x74
801063af:	e9 13 f7 ff ff       	jmp    80105ac7 <alltraps>

801063b4 <vector117>:
801063b4:	6a 00                	push   $0x0
801063b6:	6a 75                	push   $0x75
801063b8:	e9 0a f7 ff ff       	jmp    80105ac7 <alltraps>

801063bd <vector118>:
801063bd:	6a 00                	push   $0x0
801063bf:	6a 76                	push   $0x76
801063c1:	e9 01 f7 ff ff       	jmp    80105ac7 <alltraps>

801063c6 <vector119>:
801063c6:	6a 00                	push   $0x0
801063c8:	6a 77                	push   $0x77
801063ca:	e9 f8 f6 ff ff       	jmp    80105ac7 <alltraps>

801063cf <vector120>:
801063cf:	6a 00                	push   $0x0
801063d1:	6a 78                	push   $0x78
801063d3:	e9 ef f6 ff ff       	jmp    80105ac7 <alltraps>

801063d8 <vector121>:
801063d8:	6a 00                	push   $0x0
801063da:	6a 79                	push   $0x79
801063dc:	e9 e6 f6 ff ff       	jmp    80105ac7 <alltraps>

801063e1 <vector122>:
801063e1:	6a 00                	push   $0x0
801063e3:	6a 7a                	push   $0x7a
801063e5:	e9 dd f6 ff ff       	jmp    80105ac7 <alltraps>

801063ea <vector123>:
801063ea:	6a 00                	push   $0x0
801063ec:	6a 7b                	push   $0x7b
801063ee:	e9 d4 f6 ff ff       	jmp    80105ac7 <alltraps>

801063f3 <vector124>:
801063f3:	6a 00                	push   $0x0
801063f5:	6a 7c                	push   $0x7c
801063f7:	e9 cb f6 ff ff       	jmp    80105ac7 <alltraps>

801063fc <vector125>:
801063fc:	6a 00                	push   $0x0
801063fe:	6a 7d                	push   $0x7d
80106400:	e9 c2 f6 ff ff       	jmp    80105ac7 <alltraps>

80106405 <vector126>:
80106405:	6a 00                	push   $0x0
80106407:	6a 7e                	push   $0x7e
80106409:	e9 b9 f6 ff ff       	jmp    80105ac7 <alltraps>

8010640e <vector127>:
8010640e:	6a 00                	push   $0x0
80106410:	6a 7f                	push   $0x7f
80106412:	e9 b0 f6 ff ff       	jmp    80105ac7 <alltraps>

80106417 <vector128>:
80106417:	6a 00                	push   $0x0
80106419:	68 80 00 00 00       	push   $0x80
8010641e:	e9 a4 f6 ff ff       	jmp    80105ac7 <alltraps>

80106423 <vector129>:
80106423:	6a 00                	push   $0x0
80106425:	68 81 00 00 00       	push   $0x81
8010642a:	e9 98 f6 ff ff       	jmp    80105ac7 <alltraps>

8010642f <vector130>:
8010642f:	6a 00                	push   $0x0
80106431:	68 82 00 00 00       	push   $0x82
80106436:	e9 8c f6 ff ff       	jmp    80105ac7 <alltraps>

8010643b <vector131>:
8010643b:	6a 00                	push   $0x0
8010643d:	68 83 00 00 00       	push   $0x83
80106442:	e9 80 f6 ff ff       	jmp    80105ac7 <alltraps>

80106447 <vector132>:
80106447:	6a 00                	push   $0x0
80106449:	68 84 00 00 00       	push   $0x84
8010644e:	e9 74 f6 ff ff       	jmp    80105ac7 <alltraps>

80106453 <vector133>:
80106453:	6a 00                	push   $0x0
80106455:	68 85 00 00 00       	push   $0x85
8010645a:	e9 68 f6 ff ff       	jmp    80105ac7 <alltraps>

8010645f <vector134>:
8010645f:	6a 00                	push   $0x0
80106461:	68 86 00 00 00       	push   $0x86
80106466:	e9 5c f6 ff ff       	jmp    80105ac7 <alltraps>

8010646b <vector135>:
8010646b:	6a 00                	push   $0x0
8010646d:	68 87 00 00 00       	push   $0x87
80106472:	e9 50 f6 ff ff       	jmp    80105ac7 <alltraps>

80106477 <vector136>:
80106477:	6a 00                	push   $0x0
80106479:	68 88 00 00 00       	push   $0x88
8010647e:	e9 44 f6 ff ff       	jmp    80105ac7 <alltraps>

80106483 <vector137>:
80106483:	6a 00                	push   $0x0
80106485:	68 89 00 00 00       	push   $0x89
8010648a:	e9 38 f6 ff ff       	jmp    80105ac7 <alltraps>

8010648f <vector138>:
8010648f:	6a 00                	push   $0x0
80106491:	68 8a 00 00 00       	push   $0x8a
80106496:	e9 2c f6 ff ff       	jmp    80105ac7 <alltraps>

8010649b <vector139>:
8010649b:	6a 00                	push   $0x0
8010649d:	68 8b 00 00 00       	push   $0x8b
801064a2:	e9 20 f6 ff ff       	jmp    80105ac7 <alltraps>

801064a7 <vector140>:
801064a7:	6a 00                	push   $0x0
801064a9:	68 8c 00 00 00       	push   $0x8c
801064ae:	e9 14 f6 ff ff       	jmp    80105ac7 <alltraps>

801064b3 <vector141>:
801064b3:	6a 00                	push   $0x0
801064b5:	68 8d 00 00 00       	push   $0x8d
801064ba:	e9 08 f6 ff ff       	jmp    80105ac7 <alltraps>

801064bf <vector142>:
801064bf:	6a 00                	push   $0x0
801064c1:	68 8e 00 00 00       	push   $0x8e
801064c6:	e9 fc f5 ff ff       	jmp    80105ac7 <alltraps>

801064cb <vector143>:
801064cb:	6a 00                	push   $0x0
801064cd:	68 8f 00 00 00       	push   $0x8f
801064d2:	e9 f0 f5 ff ff       	jmp    80105ac7 <alltraps>

801064d7 <vector144>:
801064d7:	6a 00                	push   $0x0
801064d9:	68 90 00 00 00       	push   $0x90
801064de:	e9 e4 f5 ff ff       	jmp    80105ac7 <alltraps>

801064e3 <vector145>:
801064e3:	6a 00                	push   $0x0
801064e5:	68 91 00 00 00       	push   $0x91
801064ea:	e9 d8 f5 ff ff       	jmp    80105ac7 <alltraps>

801064ef <vector146>:
801064ef:	6a 00                	push   $0x0
801064f1:	68 92 00 00 00       	push   $0x92
801064f6:	e9 cc f5 ff ff       	jmp    80105ac7 <alltraps>

801064fb <vector147>:
801064fb:	6a 00                	push   $0x0
801064fd:	68 93 00 00 00       	push   $0x93
80106502:	e9 c0 f5 ff ff       	jmp    80105ac7 <alltraps>

80106507 <vector148>:
80106507:	6a 00                	push   $0x0
80106509:	68 94 00 00 00       	push   $0x94
8010650e:	e9 b4 f5 ff ff       	jmp    80105ac7 <alltraps>

80106513 <vector149>:
80106513:	6a 00                	push   $0x0
80106515:	68 95 00 00 00       	push   $0x95
8010651a:	e9 a8 f5 ff ff       	jmp    80105ac7 <alltraps>

8010651f <vector150>:
8010651f:	6a 00                	push   $0x0
80106521:	68 96 00 00 00       	push   $0x96
80106526:	e9 9c f5 ff ff       	jmp    80105ac7 <alltraps>

8010652b <vector151>:
8010652b:	6a 00                	push   $0x0
8010652d:	68 97 00 00 00       	push   $0x97
80106532:	e9 90 f5 ff ff       	jmp    80105ac7 <alltraps>

80106537 <vector152>:
80106537:	6a 00                	push   $0x0
80106539:	68 98 00 00 00       	push   $0x98
8010653e:	e9 84 f5 ff ff       	jmp    80105ac7 <alltraps>

80106543 <vector153>:
80106543:	6a 00                	push   $0x0
80106545:	68 99 00 00 00       	push   $0x99
8010654a:	e9 78 f5 ff ff       	jmp    80105ac7 <alltraps>

8010654f <vector154>:
8010654f:	6a 00                	push   $0x0
80106551:	68 9a 00 00 00       	push   $0x9a
80106556:	e9 6c f5 ff ff       	jmp    80105ac7 <alltraps>

8010655b <vector155>:
8010655b:	6a 00                	push   $0x0
8010655d:	68 9b 00 00 00       	push   $0x9b
80106562:	e9 60 f5 ff ff       	jmp    80105ac7 <alltraps>

80106567 <vector156>:
80106567:	6a 00                	push   $0x0
80106569:	68 9c 00 00 00       	push   $0x9c
8010656e:	e9 54 f5 ff ff       	jmp    80105ac7 <alltraps>

80106573 <vector157>:
80106573:	6a 00                	push   $0x0
80106575:	68 9d 00 00 00       	push   $0x9d
8010657a:	e9 48 f5 ff ff       	jmp    80105ac7 <alltraps>

8010657f <vector158>:
8010657f:	6a 00                	push   $0x0
80106581:	68 9e 00 00 00       	push   $0x9e
80106586:	e9 3c f5 ff ff       	jmp    80105ac7 <alltraps>

8010658b <vector159>:
8010658b:	6a 00                	push   $0x0
8010658d:	68 9f 00 00 00       	push   $0x9f
80106592:	e9 30 f5 ff ff       	jmp    80105ac7 <alltraps>

80106597 <vector160>:
80106597:	6a 00                	push   $0x0
80106599:	68 a0 00 00 00       	push   $0xa0
8010659e:	e9 24 f5 ff ff       	jmp    80105ac7 <alltraps>

801065a3 <vector161>:
801065a3:	6a 00                	push   $0x0
801065a5:	68 a1 00 00 00       	push   $0xa1
801065aa:	e9 18 f5 ff ff       	jmp    80105ac7 <alltraps>

801065af <vector162>:
801065af:	6a 00                	push   $0x0
801065b1:	68 a2 00 00 00       	push   $0xa2
801065b6:	e9 0c f5 ff ff       	jmp    80105ac7 <alltraps>

801065bb <vector163>:
801065bb:	6a 00                	push   $0x0
801065bd:	68 a3 00 00 00       	push   $0xa3
801065c2:	e9 00 f5 ff ff       	jmp    80105ac7 <alltraps>

801065c7 <vector164>:
801065c7:	6a 00                	push   $0x0
801065c9:	68 a4 00 00 00       	push   $0xa4
801065ce:	e9 f4 f4 ff ff       	jmp    80105ac7 <alltraps>

801065d3 <vector165>:
801065d3:	6a 00                	push   $0x0
801065d5:	68 a5 00 00 00       	push   $0xa5
801065da:	e9 e8 f4 ff ff       	jmp    80105ac7 <alltraps>

801065df <vector166>:
801065df:	6a 00                	push   $0x0
801065e1:	68 a6 00 00 00       	push   $0xa6
801065e6:	e9 dc f4 ff ff       	jmp    80105ac7 <alltraps>

801065eb <vector167>:
801065eb:	6a 00                	push   $0x0
801065ed:	68 a7 00 00 00       	push   $0xa7
801065f2:	e9 d0 f4 ff ff       	jmp    80105ac7 <alltraps>

801065f7 <vector168>:
801065f7:	6a 00                	push   $0x0
801065f9:	68 a8 00 00 00       	push   $0xa8
801065fe:	e9 c4 f4 ff ff       	jmp    80105ac7 <alltraps>

80106603 <vector169>:
80106603:	6a 00                	push   $0x0
80106605:	68 a9 00 00 00       	push   $0xa9
8010660a:	e9 b8 f4 ff ff       	jmp    80105ac7 <alltraps>

8010660f <vector170>:
8010660f:	6a 00                	push   $0x0
80106611:	68 aa 00 00 00       	push   $0xaa
80106616:	e9 ac f4 ff ff       	jmp    80105ac7 <alltraps>

8010661b <vector171>:
8010661b:	6a 00                	push   $0x0
8010661d:	68 ab 00 00 00       	push   $0xab
80106622:	e9 a0 f4 ff ff       	jmp    80105ac7 <alltraps>

80106627 <vector172>:
80106627:	6a 00                	push   $0x0
80106629:	68 ac 00 00 00       	push   $0xac
8010662e:	e9 94 f4 ff ff       	jmp    80105ac7 <alltraps>

80106633 <vector173>:
80106633:	6a 00                	push   $0x0
80106635:	68 ad 00 00 00       	push   $0xad
8010663a:	e9 88 f4 ff ff       	jmp    80105ac7 <alltraps>

8010663f <vector174>:
8010663f:	6a 00                	push   $0x0
80106641:	68 ae 00 00 00       	push   $0xae
80106646:	e9 7c f4 ff ff       	jmp    80105ac7 <alltraps>

8010664b <vector175>:
8010664b:	6a 00                	push   $0x0
8010664d:	68 af 00 00 00       	push   $0xaf
80106652:	e9 70 f4 ff ff       	jmp    80105ac7 <alltraps>

80106657 <vector176>:
80106657:	6a 00                	push   $0x0
80106659:	68 b0 00 00 00       	push   $0xb0
8010665e:	e9 64 f4 ff ff       	jmp    80105ac7 <alltraps>

80106663 <vector177>:
80106663:	6a 00                	push   $0x0
80106665:	68 b1 00 00 00       	push   $0xb1
8010666a:	e9 58 f4 ff ff       	jmp    80105ac7 <alltraps>

8010666f <vector178>:
8010666f:	6a 00                	push   $0x0
80106671:	68 b2 00 00 00       	push   $0xb2
80106676:	e9 4c f4 ff ff       	jmp    80105ac7 <alltraps>

8010667b <vector179>:
8010667b:	6a 00                	push   $0x0
8010667d:	68 b3 00 00 00       	push   $0xb3
80106682:	e9 40 f4 ff ff       	jmp    80105ac7 <alltraps>

80106687 <vector180>:
80106687:	6a 00                	push   $0x0
80106689:	68 b4 00 00 00       	push   $0xb4
8010668e:	e9 34 f4 ff ff       	jmp    80105ac7 <alltraps>

80106693 <vector181>:
80106693:	6a 00                	push   $0x0
80106695:	68 b5 00 00 00       	push   $0xb5
8010669a:	e9 28 f4 ff ff       	jmp    80105ac7 <alltraps>

8010669f <vector182>:
8010669f:	6a 00                	push   $0x0
801066a1:	68 b6 00 00 00       	push   $0xb6
801066a6:	e9 1c f4 ff ff       	jmp    80105ac7 <alltraps>

801066ab <vector183>:
801066ab:	6a 00                	push   $0x0
801066ad:	68 b7 00 00 00       	push   $0xb7
801066b2:	e9 10 f4 ff ff       	jmp    80105ac7 <alltraps>

801066b7 <vector184>:
801066b7:	6a 00                	push   $0x0
801066b9:	68 b8 00 00 00       	push   $0xb8
801066be:	e9 04 f4 ff ff       	jmp    80105ac7 <alltraps>

801066c3 <vector185>:
801066c3:	6a 00                	push   $0x0
801066c5:	68 b9 00 00 00       	push   $0xb9
801066ca:	e9 f8 f3 ff ff       	jmp    80105ac7 <alltraps>

801066cf <vector186>:
801066cf:	6a 00                	push   $0x0
801066d1:	68 ba 00 00 00       	push   $0xba
801066d6:	e9 ec f3 ff ff       	jmp    80105ac7 <alltraps>

801066db <vector187>:
801066db:	6a 00                	push   $0x0
801066dd:	68 bb 00 00 00       	push   $0xbb
801066e2:	e9 e0 f3 ff ff       	jmp    80105ac7 <alltraps>

801066e7 <vector188>:
801066e7:	6a 00                	push   $0x0
801066e9:	68 bc 00 00 00       	push   $0xbc
801066ee:	e9 d4 f3 ff ff       	jmp    80105ac7 <alltraps>

801066f3 <vector189>:
801066f3:	6a 00                	push   $0x0
801066f5:	68 bd 00 00 00       	push   $0xbd
801066fa:	e9 c8 f3 ff ff       	jmp    80105ac7 <alltraps>

801066ff <vector190>:
801066ff:	6a 00                	push   $0x0
80106701:	68 be 00 00 00       	push   $0xbe
80106706:	e9 bc f3 ff ff       	jmp    80105ac7 <alltraps>

8010670b <vector191>:
8010670b:	6a 00                	push   $0x0
8010670d:	68 bf 00 00 00       	push   $0xbf
80106712:	e9 b0 f3 ff ff       	jmp    80105ac7 <alltraps>

80106717 <vector192>:
80106717:	6a 00                	push   $0x0
80106719:	68 c0 00 00 00       	push   $0xc0
8010671e:	e9 a4 f3 ff ff       	jmp    80105ac7 <alltraps>

80106723 <vector193>:
80106723:	6a 00                	push   $0x0
80106725:	68 c1 00 00 00       	push   $0xc1
8010672a:	e9 98 f3 ff ff       	jmp    80105ac7 <alltraps>

8010672f <vector194>:
8010672f:	6a 00                	push   $0x0
80106731:	68 c2 00 00 00       	push   $0xc2
80106736:	e9 8c f3 ff ff       	jmp    80105ac7 <alltraps>

8010673b <vector195>:
8010673b:	6a 00                	push   $0x0
8010673d:	68 c3 00 00 00       	push   $0xc3
80106742:	e9 80 f3 ff ff       	jmp    80105ac7 <alltraps>

80106747 <vector196>:
80106747:	6a 00                	push   $0x0
80106749:	68 c4 00 00 00       	push   $0xc4
8010674e:	e9 74 f3 ff ff       	jmp    80105ac7 <alltraps>

80106753 <vector197>:
80106753:	6a 00                	push   $0x0
80106755:	68 c5 00 00 00       	push   $0xc5
8010675a:	e9 68 f3 ff ff       	jmp    80105ac7 <alltraps>

8010675f <vector198>:
8010675f:	6a 00                	push   $0x0
80106761:	68 c6 00 00 00       	push   $0xc6
80106766:	e9 5c f3 ff ff       	jmp    80105ac7 <alltraps>

8010676b <vector199>:
8010676b:	6a 00                	push   $0x0
8010676d:	68 c7 00 00 00       	push   $0xc7
80106772:	e9 50 f3 ff ff       	jmp    80105ac7 <alltraps>

80106777 <vector200>:
80106777:	6a 00                	push   $0x0
80106779:	68 c8 00 00 00       	push   $0xc8
8010677e:	e9 44 f3 ff ff       	jmp    80105ac7 <alltraps>

80106783 <vector201>:
80106783:	6a 00                	push   $0x0
80106785:	68 c9 00 00 00       	push   $0xc9
8010678a:	e9 38 f3 ff ff       	jmp    80105ac7 <alltraps>

8010678f <vector202>:
8010678f:	6a 00                	push   $0x0
80106791:	68 ca 00 00 00       	push   $0xca
80106796:	e9 2c f3 ff ff       	jmp    80105ac7 <alltraps>

8010679b <vector203>:
8010679b:	6a 00                	push   $0x0
8010679d:	68 cb 00 00 00       	push   $0xcb
801067a2:	e9 20 f3 ff ff       	jmp    80105ac7 <alltraps>

801067a7 <vector204>:
801067a7:	6a 00                	push   $0x0
801067a9:	68 cc 00 00 00       	push   $0xcc
801067ae:	e9 14 f3 ff ff       	jmp    80105ac7 <alltraps>

801067b3 <vector205>:
801067b3:	6a 00                	push   $0x0
801067b5:	68 cd 00 00 00       	push   $0xcd
801067ba:	e9 08 f3 ff ff       	jmp    80105ac7 <alltraps>

801067bf <vector206>:
801067bf:	6a 00                	push   $0x0
801067c1:	68 ce 00 00 00       	push   $0xce
801067c6:	e9 fc f2 ff ff       	jmp    80105ac7 <alltraps>

801067cb <vector207>:
801067cb:	6a 00                	push   $0x0
801067cd:	68 cf 00 00 00       	push   $0xcf
801067d2:	e9 f0 f2 ff ff       	jmp    80105ac7 <alltraps>

801067d7 <vector208>:
801067d7:	6a 00                	push   $0x0
801067d9:	68 d0 00 00 00       	push   $0xd0
801067de:	e9 e4 f2 ff ff       	jmp    80105ac7 <alltraps>

801067e3 <vector209>:
801067e3:	6a 00                	push   $0x0
801067e5:	68 d1 00 00 00       	push   $0xd1
801067ea:	e9 d8 f2 ff ff       	jmp    80105ac7 <alltraps>

801067ef <vector210>:
801067ef:	6a 00                	push   $0x0
801067f1:	68 d2 00 00 00       	push   $0xd2
801067f6:	e9 cc f2 ff ff       	jmp    80105ac7 <alltraps>

801067fb <vector211>:
801067fb:	6a 00                	push   $0x0
801067fd:	68 d3 00 00 00       	push   $0xd3
80106802:	e9 c0 f2 ff ff       	jmp    80105ac7 <alltraps>

80106807 <vector212>:
80106807:	6a 00                	push   $0x0
80106809:	68 d4 00 00 00       	push   $0xd4
8010680e:	e9 b4 f2 ff ff       	jmp    80105ac7 <alltraps>

80106813 <vector213>:
80106813:	6a 00                	push   $0x0
80106815:	68 d5 00 00 00       	push   $0xd5
8010681a:	e9 a8 f2 ff ff       	jmp    80105ac7 <alltraps>

8010681f <vector214>:
8010681f:	6a 00                	push   $0x0
80106821:	68 d6 00 00 00       	push   $0xd6
80106826:	e9 9c f2 ff ff       	jmp    80105ac7 <alltraps>

8010682b <vector215>:
8010682b:	6a 00                	push   $0x0
8010682d:	68 d7 00 00 00       	push   $0xd7
80106832:	e9 90 f2 ff ff       	jmp    80105ac7 <alltraps>

80106837 <vector216>:
80106837:	6a 00                	push   $0x0
80106839:	68 d8 00 00 00       	push   $0xd8
8010683e:	e9 84 f2 ff ff       	jmp    80105ac7 <alltraps>

80106843 <vector217>:
80106843:	6a 00                	push   $0x0
80106845:	68 d9 00 00 00       	push   $0xd9
8010684a:	e9 78 f2 ff ff       	jmp    80105ac7 <alltraps>

8010684f <vector218>:
8010684f:	6a 00                	push   $0x0
80106851:	68 da 00 00 00       	push   $0xda
80106856:	e9 6c f2 ff ff       	jmp    80105ac7 <alltraps>

8010685b <vector219>:
8010685b:	6a 00                	push   $0x0
8010685d:	68 db 00 00 00       	push   $0xdb
80106862:	e9 60 f2 ff ff       	jmp    80105ac7 <alltraps>

80106867 <vector220>:
80106867:	6a 00                	push   $0x0
80106869:	68 dc 00 00 00       	push   $0xdc
8010686e:	e9 54 f2 ff ff       	jmp    80105ac7 <alltraps>

80106873 <vector221>:
80106873:	6a 00                	push   $0x0
80106875:	68 dd 00 00 00       	push   $0xdd
8010687a:	e9 48 f2 ff ff       	jmp    80105ac7 <alltraps>

8010687f <vector222>:
8010687f:	6a 00                	push   $0x0
80106881:	68 de 00 00 00       	push   $0xde
80106886:	e9 3c f2 ff ff       	jmp    80105ac7 <alltraps>

8010688b <vector223>:
8010688b:	6a 00                	push   $0x0
8010688d:	68 df 00 00 00       	push   $0xdf
80106892:	e9 30 f2 ff ff       	jmp    80105ac7 <alltraps>

80106897 <vector224>:
80106897:	6a 00                	push   $0x0
80106899:	68 e0 00 00 00       	push   $0xe0
8010689e:	e9 24 f2 ff ff       	jmp    80105ac7 <alltraps>

801068a3 <vector225>:
801068a3:	6a 00                	push   $0x0
801068a5:	68 e1 00 00 00       	push   $0xe1
801068aa:	e9 18 f2 ff ff       	jmp    80105ac7 <alltraps>

801068af <vector226>:
801068af:	6a 00                	push   $0x0
801068b1:	68 e2 00 00 00       	push   $0xe2
801068b6:	e9 0c f2 ff ff       	jmp    80105ac7 <alltraps>

801068bb <vector227>:
801068bb:	6a 00                	push   $0x0
801068bd:	68 e3 00 00 00       	push   $0xe3
801068c2:	e9 00 f2 ff ff       	jmp    80105ac7 <alltraps>

801068c7 <vector228>:
801068c7:	6a 00                	push   $0x0
801068c9:	68 e4 00 00 00       	push   $0xe4
801068ce:	e9 f4 f1 ff ff       	jmp    80105ac7 <alltraps>

801068d3 <vector229>:
801068d3:	6a 00                	push   $0x0
801068d5:	68 e5 00 00 00       	push   $0xe5
801068da:	e9 e8 f1 ff ff       	jmp    80105ac7 <alltraps>

801068df <vector230>:
801068df:	6a 00                	push   $0x0
801068e1:	68 e6 00 00 00       	push   $0xe6
801068e6:	e9 dc f1 ff ff       	jmp    80105ac7 <alltraps>

801068eb <vector231>:
801068eb:	6a 00                	push   $0x0
801068ed:	68 e7 00 00 00       	push   $0xe7
801068f2:	e9 d0 f1 ff ff       	jmp    80105ac7 <alltraps>

801068f7 <vector232>:
801068f7:	6a 00                	push   $0x0
801068f9:	68 e8 00 00 00       	push   $0xe8
801068fe:	e9 c4 f1 ff ff       	jmp    80105ac7 <alltraps>

80106903 <vector233>:
80106903:	6a 00                	push   $0x0
80106905:	68 e9 00 00 00       	push   $0xe9
8010690a:	e9 b8 f1 ff ff       	jmp    80105ac7 <alltraps>

8010690f <vector234>:
8010690f:	6a 00                	push   $0x0
80106911:	68 ea 00 00 00       	push   $0xea
80106916:	e9 ac f1 ff ff       	jmp    80105ac7 <alltraps>

8010691b <vector235>:
8010691b:	6a 00                	push   $0x0
8010691d:	68 eb 00 00 00       	push   $0xeb
80106922:	e9 a0 f1 ff ff       	jmp    80105ac7 <alltraps>

80106927 <vector236>:
80106927:	6a 00                	push   $0x0
80106929:	68 ec 00 00 00       	push   $0xec
8010692e:	e9 94 f1 ff ff       	jmp    80105ac7 <alltraps>

80106933 <vector237>:
80106933:	6a 00                	push   $0x0
80106935:	68 ed 00 00 00       	push   $0xed
8010693a:	e9 88 f1 ff ff       	jmp    80105ac7 <alltraps>

8010693f <vector238>:
8010693f:	6a 00                	push   $0x0
80106941:	68 ee 00 00 00       	push   $0xee
80106946:	e9 7c f1 ff ff       	jmp    80105ac7 <alltraps>

8010694b <vector239>:
8010694b:	6a 00                	push   $0x0
8010694d:	68 ef 00 00 00       	push   $0xef
80106952:	e9 70 f1 ff ff       	jmp    80105ac7 <alltraps>

80106957 <vector240>:
80106957:	6a 00                	push   $0x0
80106959:	68 f0 00 00 00       	push   $0xf0
8010695e:	e9 64 f1 ff ff       	jmp    80105ac7 <alltraps>

80106963 <vector241>:
80106963:	6a 00                	push   $0x0
80106965:	68 f1 00 00 00       	push   $0xf1
8010696a:	e9 58 f1 ff ff       	jmp    80105ac7 <alltraps>

8010696f <vector242>:
8010696f:	6a 00                	push   $0x0
80106971:	68 f2 00 00 00       	push   $0xf2
80106976:	e9 4c f1 ff ff       	jmp    80105ac7 <alltraps>

8010697b <vector243>:
8010697b:	6a 00                	push   $0x0
8010697d:	68 f3 00 00 00       	push   $0xf3
80106982:	e9 40 f1 ff ff       	jmp    80105ac7 <alltraps>

80106987 <vector244>:
80106987:	6a 00                	push   $0x0
80106989:	68 f4 00 00 00       	push   $0xf4
8010698e:	e9 34 f1 ff ff       	jmp    80105ac7 <alltraps>

80106993 <vector245>:
80106993:	6a 00                	push   $0x0
80106995:	68 f5 00 00 00       	push   $0xf5
8010699a:	e9 28 f1 ff ff       	jmp    80105ac7 <alltraps>

8010699f <vector246>:
8010699f:	6a 00                	push   $0x0
801069a1:	68 f6 00 00 00       	push   $0xf6
801069a6:	e9 1c f1 ff ff       	jmp    80105ac7 <alltraps>

801069ab <vector247>:
801069ab:	6a 00                	push   $0x0
801069ad:	68 f7 00 00 00       	push   $0xf7
801069b2:	e9 10 f1 ff ff       	jmp    80105ac7 <alltraps>

801069b7 <vector248>:
801069b7:	6a 00                	push   $0x0
801069b9:	68 f8 00 00 00       	push   $0xf8
801069be:	e9 04 f1 ff ff       	jmp    80105ac7 <alltraps>

801069c3 <vector249>:
801069c3:	6a 00                	push   $0x0
801069c5:	68 f9 00 00 00       	push   $0xf9
801069ca:	e9 f8 f0 ff ff       	jmp    80105ac7 <alltraps>

801069cf <vector250>:
801069cf:	6a 00                	push   $0x0
801069d1:	68 fa 00 00 00       	push   $0xfa
801069d6:	e9 ec f0 ff ff       	jmp    80105ac7 <alltraps>

801069db <vector251>:
801069db:	6a 00                	push   $0x0
801069dd:	68 fb 00 00 00       	push   $0xfb
801069e2:	e9 e0 f0 ff ff       	jmp    80105ac7 <alltraps>

801069e7 <vector252>:
801069e7:	6a 00                	push   $0x0
801069e9:	68 fc 00 00 00       	push   $0xfc
801069ee:	e9 d4 f0 ff ff       	jmp    80105ac7 <alltraps>

801069f3 <vector253>:
801069f3:	6a 00                	push   $0x0
801069f5:	68 fd 00 00 00       	push   $0xfd
801069fa:	e9 c8 f0 ff ff       	jmp    80105ac7 <alltraps>

801069ff <vector254>:
801069ff:	6a 00                	push   $0x0
80106a01:	68 fe 00 00 00       	push   $0xfe
80106a06:	e9 bc f0 ff ff       	jmp    80105ac7 <alltraps>

80106a0b <vector255>:
80106a0b:	6a 00                	push   $0x0
80106a0d:	68 ff 00 00 00       	push   $0xff
80106a12:	e9 b0 f0 ff ff       	jmp    80105ac7 <alltraps>
80106a17:	66 90                	xchg   %ax,%ax
80106a19:	66 90                	xchg   %ax,%ax
80106a1b:	66 90                	xchg   %ax,%ax
80106a1d:	66 90                	xchg   %ax,%ax
80106a1f:	90                   	nop

80106a20 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80106a20:	55                   	push   %ebp
80106a21:	89 e5                	mov    %esp,%ebp
80106a23:	57                   	push   %edi
80106a24:	56                   	push   %esi
80106a25:	53                   	push   %ebx
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80106a26:	89 d3                	mov    %edx,%ebx
{
80106a28:	89 d7                	mov    %edx,%edi
  pde = &pgdir[PDX(va)];
80106a2a:	c1 eb 16             	shr    $0x16,%ebx
80106a2d:	8d 34 98             	lea    (%eax,%ebx,4),%esi
{
80106a30:	83 ec 0c             	sub    $0xc,%esp
  if(*pde & PTE_P){
80106a33:	8b 06                	mov    (%esi),%eax
80106a35:	a8 01                	test   $0x1,%al
80106a37:	74 27                	je     80106a60 <walkpgdir+0x40>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106a39:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106a3e:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
80106a44:	c1 ef 0a             	shr    $0xa,%edi
}
80106a47:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return &pgtab[PTX(va)];
80106a4a:	89 fa                	mov    %edi,%edx
80106a4c:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80106a52:	8d 04 13             	lea    (%ebx,%edx,1),%eax
}
80106a55:	5b                   	pop    %ebx
80106a56:	5e                   	pop    %esi
80106a57:	5f                   	pop    %edi
80106a58:	5d                   	pop    %ebp
80106a59:	c3                   	ret    
80106a5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80106a60:	85 c9                	test   %ecx,%ecx
80106a62:	74 2c                	je     80106a90 <walkpgdir+0x70>
80106a64:	e8 87 ba ff ff       	call   801024f0 <kalloc>
80106a69:	85 c0                	test   %eax,%eax
80106a6b:	89 c3                	mov    %eax,%ebx
80106a6d:	74 21                	je     80106a90 <walkpgdir+0x70>
    memset(pgtab, 0, PGSIZE);
80106a6f:	83 ec 04             	sub    $0x4,%esp
80106a72:	68 00 10 00 00       	push   $0x1000
80106a77:	6a 00                	push   $0x0
80106a79:	50                   	push   %eax
80106a7a:	e8 a1 dd ff ff       	call   80104820 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80106a7f:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106a85:	83 c4 10             	add    $0x10,%esp
80106a88:	83 c8 07             	or     $0x7,%eax
80106a8b:	89 06                	mov    %eax,(%esi)
80106a8d:	eb b5                	jmp    80106a44 <walkpgdir+0x24>
80106a8f:	90                   	nop
}
80106a90:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 0;
80106a93:	31 c0                	xor    %eax,%eax
}
80106a95:	5b                   	pop    %ebx
80106a96:	5e                   	pop    %esi
80106a97:	5f                   	pop    %edi
80106a98:	5d                   	pop    %ebp
80106a99:	c3                   	ret    
80106a9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106aa0 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80106aa0:	55                   	push   %ebp
80106aa1:	89 e5                	mov    %esp,%ebp
80106aa3:	57                   	push   %edi
80106aa4:	56                   	push   %esi
80106aa5:	53                   	push   %ebx
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
80106aa6:	89 d3                	mov    %edx,%ebx
80106aa8:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
{
80106aae:	83 ec 1c             	sub    $0x1c,%esp
80106ab1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80106ab4:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
80106ab8:	8b 7d 08             	mov    0x8(%ebp),%edi
80106abb:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106ac0:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
80106ac3:	8b 45 0c             	mov    0xc(%ebp),%eax
80106ac6:	29 df                	sub    %ebx,%edi
80106ac8:	83 c8 01             	or     $0x1,%eax
80106acb:	89 45 dc             	mov    %eax,-0x24(%ebp)
80106ace:	eb 15                	jmp    80106ae5 <mappages+0x45>
    if(*pte & PTE_P)
80106ad0:	f6 00 01             	testb  $0x1,(%eax)
80106ad3:	75 45                	jne    80106b1a <mappages+0x7a>
    *pte = pa | perm | PTE_P;
80106ad5:	0b 75 dc             	or     -0x24(%ebp),%esi
    if(a == last)
80106ad8:	3b 5d e0             	cmp    -0x20(%ebp),%ebx
    *pte = pa | perm | PTE_P;
80106adb:	89 30                	mov    %esi,(%eax)
    if(a == last)
80106add:	74 31                	je     80106b10 <mappages+0x70>
      break;
    a += PGSIZE;
80106adf:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80106ae5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106ae8:	b9 01 00 00 00       	mov    $0x1,%ecx
80106aed:	89 da                	mov    %ebx,%edx
80106aef:	8d 34 3b             	lea    (%ebx,%edi,1),%esi
80106af2:	e8 29 ff ff ff       	call   80106a20 <walkpgdir>
80106af7:	85 c0                	test   %eax,%eax
80106af9:	75 d5                	jne    80106ad0 <mappages+0x30>
    pa += PGSIZE;
  }
  return 0;
}
80106afb:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80106afe:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106b03:	5b                   	pop    %ebx
80106b04:	5e                   	pop    %esi
80106b05:	5f                   	pop    %edi
80106b06:	5d                   	pop    %ebp
80106b07:	c3                   	ret    
80106b08:	90                   	nop
80106b09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106b10:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80106b13:	31 c0                	xor    %eax,%eax
}
80106b15:	5b                   	pop    %ebx
80106b16:	5e                   	pop    %esi
80106b17:	5f                   	pop    %edi
80106b18:	5d                   	pop    %ebp
80106b19:	c3                   	ret    
      panic("remap");
80106b1a:	83 ec 0c             	sub    $0xc,%esp
80106b1d:	68 34 7c 10 80       	push   $0x80107c34
80106b22:	e8 69 98 ff ff       	call   80100390 <panic>
80106b27:	89 f6                	mov    %esi,%esi
80106b29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106b30 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106b30:	55                   	push   %ebp
80106b31:	89 e5                	mov    %esp,%ebp
80106b33:	57                   	push   %edi
80106b34:	56                   	push   %esi
80106b35:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80106b36:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106b3c:	89 c7                	mov    %eax,%edi
  a = PGROUNDUP(newsz);
80106b3e:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106b44:	83 ec 1c             	sub    $0x1c,%esp
80106b47:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  for(; a  < oldsz; a += PGSIZE){
80106b4a:	39 d3                	cmp    %edx,%ebx
80106b4c:	73 66                	jae    80106bb4 <deallocuvm.part.0+0x84>
80106b4e:	89 d6                	mov    %edx,%esi
80106b50:	eb 3d                	jmp    80106b8f <deallocuvm.part.0+0x5f>
80106b52:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
80106b58:	8b 10                	mov    (%eax),%edx
80106b5a:	f6 c2 01             	test   $0x1,%dl
80106b5d:	74 26                	je     80106b85 <deallocuvm.part.0+0x55>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
80106b5f:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80106b65:	74 58                	je     80106bbf <deallocuvm.part.0+0x8f>
        panic("kfree");
      char *v = P2V(pa);
      kfree(v);
80106b67:	83 ec 0c             	sub    $0xc,%esp
      char *v = P2V(pa);
80106b6a:	81 c2 00 00 00 80    	add    $0x80000000,%edx
80106b70:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      kfree(v);
80106b73:	52                   	push   %edx
80106b74:	e8 c7 b7 ff ff       	call   80102340 <kfree>
      *pte = 0;
80106b79:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106b7c:	83 c4 10             	add    $0x10,%esp
80106b7f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; a  < oldsz; a += PGSIZE){
80106b85:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106b8b:	39 f3                	cmp    %esi,%ebx
80106b8d:	73 25                	jae    80106bb4 <deallocuvm.part.0+0x84>
    pte = walkpgdir(pgdir, (char*)a, 0);
80106b8f:	31 c9                	xor    %ecx,%ecx
80106b91:	89 da                	mov    %ebx,%edx
80106b93:	89 f8                	mov    %edi,%eax
80106b95:	e8 86 fe ff ff       	call   80106a20 <walkpgdir>
    if(!pte)
80106b9a:	85 c0                	test   %eax,%eax
80106b9c:	75 ba                	jne    80106b58 <deallocuvm.part.0+0x28>
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
80106b9e:	81 e3 00 00 c0 ff    	and    $0xffc00000,%ebx
80106ba4:	81 c3 00 f0 3f 00    	add    $0x3ff000,%ebx
  for(; a  < oldsz; a += PGSIZE){
80106baa:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106bb0:	39 f3                	cmp    %esi,%ebx
80106bb2:	72 db                	jb     80106b8f <deallocuvm.part.0+0x5f>
    }
  }
  return newsz;
}
80106bb4:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106bb7:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106bba:	5b                   	pop    %ebx
80106bbb:	5e                   	pop    %esi
80106bbc:	5f                   	pop    %edi
80106bbd:	5d                   	pop    %ebp
80106bbe:	c3                   	ret    
        panic("kfree");
80106bbf:	83 ec 0c             	sub    $0xc,%esp
80106bc2:	68 c6 75 10 80       	push   $0x801075c6
80106bc7:	e8 c4 97 ff ff       	call   80100390 <panic>
80106bcc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106bd0 <seginit>:
{
80106bd0:	55                   	push   %ebp
80106bd1:	89 e5                	mov    %esp,%ebp
80106bd3:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
80106bd6:	e8 85 cc ff ff       	call   80103860 <cpuid>
80106bdb:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
  pd[0] = size-1;
80106be1:	ba 2f 00 00 00       	mov    $0x2f,%edx
80106be6:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80106bea:	c7 80 f8 27 11 80 ff 	movl   $0xffff,-0x7feed808(%eax)
80106bf1:	ff 00 00 
80106bf4:	c7 80 fc 27 11 80 00 	movl   $0xcf9a00,-0x7feed804(%eax)
80106bfb:	9a cf 00 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106bfe:	c7 80 00 28 11 80 ff 	movl   $0xffff,-0x7feed800(%eax)
80106c05:	ff 00 00 
80106c08:	c7 80 04 28 11 80 00 	movl   $0xcf9200,-0x7feed7fc(%eax)
80106c0f:	92 cf 00 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106c12:	c7 80 08 28 11 80 ff 	movl   $0xffff,-0x7feed7f8(%eax)
80106c19:	ff 00 00 
80106c1c:	c7 80 0c 28 11 80 00 	movl   $0xcffa00,-0x7feed7f4(%eax)
80106c23:	fa cf 00 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106c26:	c7 80 10 28 11 80 ff 	movl   $0xffff,-0x7feed7f0(%eax)
80106c2d:	ff 00 00 
80106c30:	c7 80 14 28 11 80 00 	movl   $0xcff200,-0x7feed7ec(%eax)
80106c37:	f2 cf 00 
  lgdt(c->gdt, sizeof(c->gdt));
80106c3a:	05 f0 27 11 80       	add    $0x801127f0,%eax
  pd[1] = (uint)p;
80106c3f:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80106c43:	c1 e8 10             	shr    $0x10,%eax
80106c46:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
80106c4a:	8d 45 f2             	lea    -0xe(%ebp),%eax
80106c4d:	0f 01 10             	lgdtl  (%eax)
}
80106c50:	c9                   	leave  
80106c51:	c3                   	ret    
80106c52:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106c59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106c60 <switchkvm>:
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106c60:	a1 a4 78 11 80       	mov    0x801178a4,%eax
{
80106c65:	55                   	push   %ebp
80106c66:	89 e5                	mov    %esp,%ebp
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106c68:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106c6d:	0f 22 d8             	mov    %eax,%cr3
}
80106c70:	5d                   	pop    %ebp
80106c71:	c3                   	ret    
80106c72:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106c79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106c80 <switchuvm>:
{
80106c80:	55                   	push   %ebp
80106c81:	89 e5                	mov    %esp,%ebp
80106c83:	57                   	push   %edi
80106c84:	56                   	push   %esi
80106c85:	53                   	push   %ebx
80106c86:	83 ec 1c             	sub    $0x1c,%esp
80106c89:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(p == 0)
80106c8c:	85 db                	test   %ebx,%ebx
80106c8e:	0f 84 cb 00 00 00    	je     80106d5f <switchuvm+0xdf>
  if(p->kstack == 0)
80106c94:	8b 43 08             	mov    0x8(%ebx),%eax
80106c97:	85 c0                	test   %eax,%eax
80106c99:	0f 84 da 00 00 00    	je     80106d79 <switchuvm+0xf9>
  if(p->pgdir == 0)
80106c9f:	8b 43 04             	mov    0x4(%ebx),%eax
80106ca2:	85 c0                	test   %eax,%eax
80106ca4:	0f 84 c2 00 00 00    	je     80106d6c <switchuvm+0xec>
  pushcli();
80106caa:	e8 91 d9 ff ff       	call   80104640 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80106caf:	e8 2c cb ff ff       	call   801037e0 <mycpu>
80106cb4:	89 c6                	mov    %eax,%esi
80106cb6:	e8 25 cb ff ff       	call   801037e0 <mycpu>
80106cbb:	89 c7                	mov    %eax,%edi
80106cbd:	e8 1e cb ff ff       	call   801037e0 <mycpu>
80106cc2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106cc5:	83 c7 08             	add    $0x8,%edi
80106cc8:	e8 13 cb ff ff       	call   801037e0 <mycpu>
80106ccd:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80106cd0:	83 c0 08             	add    $0x8,%eax
80106cd3:	ba 67 00 00 00       	mov    $0x67,%edx
80106cd8:	c1 e8 18             	shr    $0x18,%eax
80106cdb:	66 89 96 98 00 00 00 	mov    %dx,0x98(%esi)
80106ce2:	66 89 be 9a 00 00 00 	mov    %di,0x9a(%esi)
80106ce9:	88 86 9f 00 00 00    	mov    %al,0x9f(%esi)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106cef:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80106cf4:	83 c1 08             	add    $0x8,%ecx
80106cf7:	c1 e9 10             	shr    $0x10,%ecx
80106cfa:	88 8e 9c 00 00 00    	mov    %cl,0x9c(%esi)
80106d00:	b9 99 40 00 00       	mov    $0x4099,%ecx
80106d05:	66 89 8e 9d 00 00 00 	mov    %cx,0x9d(%esi)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80106d0c:	be 10 00 00 00       	mov    $0x10,%esi
  mycpu()->gdt[SEG_TSS].s = 0;
80106d11:	e8 ca ca ff ff       	call   801037e0 <mycpu>
80106d16:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80106d1d:	e8 be ca ff ff       	call   801037e0 <mycpu>
80106d22:	66 89 70 10          	mov    %si,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80106d26:	8b 73 08             	mov    0x8(%ebx),%esi
80106d29:	e8 b2 ca ff ff       	call   801037e0 <mycpu>
80106d2e:	81 c6 00 10 00 00    	add    $0x1000,%esi
80106d34:	89 70 0c             	mov    %esi,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106d37:	e8 a4 ca ff ff       	call   801037e0 <mycpu>
80106d3c:	66 89 78 6e          	mov    %di,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
80106d40:	b8 28 00 00 00       	mov    $0x28,%eax
80106d45:	0f 00 d8             	ltr    %ax
  lcr3(V2P(p->pgdir));  // switch to process's address space
80106d48:	8b 43 04             	mov    0x4(%ebx),%eax
80106d4b:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106d50:	0f 22 d8             	mov    %eax,%cr3
}
80106d53:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106d56:	5b                   	pop    %ebx
80106d57:	5e                   	pop    %esi
80106d58:	5f                   	pop    %edi
80106d59:	5d                   	pop    %ebp
  popcli();
80106d5a:	e9 21 d9 ff ff       	jmp    80104680 <popcli>
    panic("switchuvm: no process");
80106d5f:	83 ec 0c             	sub    $0xc,%esp
80106d62:	68 3a 7c 10 80       	push   $0x80107c3a
80106d67:	e8 24 96 ff ff       	call   80100390 <panic>
    panic("switchuvm: no pgdir");
80106d6c:	83 ec 0c             	sub    $0xc,%esp
80106d6f:	68 65 7c 10 80       	push   $0x80107c65
80106d74:	e8 17 96 ff ff       	call   80100390 <panic>
    panic("switchuvm: no kstack");
80106d79:	83 ec 0c             	sub    $0xc,%esp
80106d7c:	68 50 7c 10 80       	push   $0x80107c50
80106d81:	e8 0a 96 ff ff       	call   80100390 <panic>
80106d86:	8d 76 00             	lea    0x0(%esi),%esi
80106d89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106d90 <inituvm>:
{
80106d90:	55                   	push   %ebp
80106d91:	89 e5                	mov    %esp,%ebp
80106d93:	57                   	push   %edi
80106d94:	56                   	push   %esi
80106d95:	53                   	push   %ebx
80106d96:	83 ec 1c             	sub    $0x1c,%esp
80106d99:	8b 75 10             	mov    0x10(%ebp),%esi
80106d9c:	8b 45 08             	mov    0x8(%ebp),%eax
80106d9f:	8b 7d 0c             	mov    0xc(%ebp),%edi
  if(sz >= PGSIZE)
80106da2:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
{
80106da8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
80106dab:	77 49                	ja     80106df6 <inituvm+0x66>
  mem = kalloc();
80106dad:	e8 3e b7 ff ff       	call   801024f0 <kalloc>
  memset(mem, 0, PGSIZE);
80106db2:	83 ec 04             	sub    $0x4,%esp
  mem = kalloc();
80106db5:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80106db7:	68 00 10 00 00       	push   $0x1000
80106dbc:	6a 00                	push   $0x0
80106dbe:	50                   	push   %eax
80106dbf:	e8 5c da ff ff       	call   80104820 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80106dc4:	58                   	pop    %eax
80106dc5:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106dcb:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106dd0:	5a                   	pop    %edx
80106dd1:	6a 06                	push   $0x6
80106dd3:	50                   	push   %eax
80106dd4:	31 d2                	xor    %edx,%edx
80106dd6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106dd9:	e8 c2 fc ff ff       	call   80106aa0 <mappages>
  memmove(mem, init, sz);
80106dde:	89 75 10             	mov    %esi,0x10(%ebp)
80106de1:	89 7d 0c             	mov    %edi,0xc(%ebp)
80106de4:	83 c4 10             	add    $0x10,%esp
80106de7:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80106dea:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106ded:	5b                   	pop    %ebx
80106dee:	5e                   	pop    %esi
80106def:	5f                   	pop    %edi
80106df0:	5d                   	pop    %ebp
  memmove(mem, init, sz);
80106df1:	e9 da da ff ff       	jmp    801048d0 <memmove>
    panic("inituvm: more than a page");
80106df6:	83 ec 0c             	sub    $0xc,%esp
80106df9:	68 79 7c 10 80       	push   $0x80107c79
80106dfe:	e8 8d 95 ff ff       	call   80100390 <panic>
80106e03:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106e09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106e10 <loaduvm>:
{
80106e10:	55                   	push   %ebp
80106e11:	89 e5                	mov    %esp,%ebp
80106e13:	57                   	push   %edi
80106e14:	56                   	push   %esi
80106e15:	53                   	push   %ebx
80106e16:	83 ec 0c             	sub    $0xc,%esp
  if((uint) addr % PGSIZE != 0)
80106e19:	f7 45 0c ff 0f 00 00 	testl  $0xfff,0xc(%ebp)
80106e20:	0f 85 91 00 00 00    	jne    80106eb7 <loaduvm+0xa7>
  for(i = 0; i < sz; i += PGSIZE){
80106e26:	8b 75 18             	mov    0x18(%ebp),%esi
80106e29:	31 db                	xor    %ebx,%ebx
80106e2b:	85 f6                	test   %esi,%esi
80106e2d:	75 1a                	jne    80106e49 <loaduvm+0x39>
80106e2f:	eb 6f                	jmp    80106ea0 <loaduvm+0x90>
80106e31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106e38:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106e3e:	81 ee 00 10 00 00    	sub    $0x1000,%esi
80106e44:	39 5d 18             	cmp    %ebx,0x18(%ebp)
80106e47:	76 57                	jbe    80106ea0 <loaduvm+0x90>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80106e49:	8b 55 0c             	mov    0xc(%ebp),%edx
80106e4c:	8b 45 08             	mov    0x8(%ebp),%eax
80106e4f:	31 c9                	xor    %ecx,%ecx
80106e51:	01 da                	add    %ebx,%edx
80106e53:	e8 c8 fb ff ff       	call   80106a20 <walkpgdir>
80106e58:	85 c0                	test   %eax,%eax
80106e5a:	74 4e                	je     80106eaa <loaduvm+0x9a>
    pa = PTE_ADDR(*pte);
80106e5c:	8b 00                	mov    (%eax),%eax
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106e5e:	8b 4d 14             	mov    0x14(%ebp),%ecx
    if(sz - i < PGSIZE)
80106e61:	bf 00 10 00 00       	mov    $0x1000,%edi
    pa = PTE_ADDR(*pte);
80106e66:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
80106e6b:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
80106e71:	0f 46 fe             	cmovbe %esi,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106e74:	01 d9                	add    %ebx,%ecx
80106e76:	05 00 00 00 80       	add    $0x80000000,%eax
80106e7b:	57                   	push   %edi
80106e7c:	51                   	push   %ecx
80106e7d:	50                   	push   %eax
80106e7e:	ff 75 10             	pushl  0x10(%ebp)
80106e81:	e8 0a ab ff ff       	call   80101990 <readi>
80106e86:	83 c4 10             	add    $0x10,%esp
80106e89:	39 f8                	cmp    %edi,%eax
80106e8b:	74 ab                	je     80106e38 <loaduvm+0x28>
}
80106e8d:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80106e90:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106e95:	5b                   	pop    %ebx
80106e96:	5e                   	pop    %esi
80106e97:	5f                   	pop    %edi
80106e98:	5d                   	pop    %ebp
80106e99:	c3                   	ret    
80106e9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106ea0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80106ea3:	31 c0                	xor    %eax,%eax
}
80106ea5:	5b                   	pop    %ebx
80106ea6:	5e                   	pop    %esi
80106ea7:	5f                   	pop    %edi
80106ea8:	5d                   	pop    %ebp
80106ea9:	c3                   	ret    
      panic("loaduvm: address should exist");
80106eaa:	83 ec 0c             	sub    $0xc,%esp
80106ead:	68 93 7c 10 80       	push   $0x80107c93
80106eb2:	e8 d9 94 ff ff       	call   80100390 <panic>
    panic("loaduvm: addr must be page aligned");
80106eb7:	83 ec 0c             	sub    $0xc,%esp
80106eba:	68 34 7d 10 80       	push   $0x80107d34
80106ebf:	e8 cc 94 ff ff       	call   80100390 <panic>
80106ec4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106eca:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106ed0 <allocuvm>:
{
80106ed0:	55                   	push   %ebp
80106ed1:	89 e5                	mov    %esp,%ebp
80106ed3:	57                   	push   %edi
80106ed4:	56                   	push   %esi
80106ed5:	53                   	push   %ebx
80106ed6:	83 ec 1c             	sub    $0x1c,%esp
  if(newsz >= KERNBASE)
80106ed9:	8b 7d 10             	mov    0x10(%ebp),%edi
80106edc:	85 ff                	test   %edi,%edi
80106ede:	0f 88 8e 00 00 00    	js     80106f72 <allocuvm+0xa2>
  if(newsz < oldsz)
80106ee4:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80106ee7:	0f 82 93 00 00 00    	jb     80106f80 <allocuvm+0xb0>
  a = PGROUNDUP(oldsz);
80106eed:	8b 45 0c             	mov    0xc(%ebp),%eax
80106ef0:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80106ef6:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a < newsz; a += PGSIZE){
80106efc:	39 5d 10             	cmp    %ebx,0x10(%ebp)
80106eff:	0f 86 7e 00 00 00    	jbe    80106f83 <allocuvm+0xb3>
80106f05:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80106f08:	8b 7d 08             	mov    0x8(%ebp),%edi
80106f0b:	eb 42                	jmp    80106f4f <allocuvm+0x7f>
80106f0d:	8d 76 00             	lea    0x0(%esi),%esi
    memset(mem, 0, PGSIZE);
80106f10:	83 ec 04             	sub    $0x4,%esp
80106f13:	68 00 10 00 00       	push   $0x1000
80106f18:	6a 00                	push   $0x0
80106f1a:	50                   	push   %eax
80106f1b:	e8 00 d9 ff ff       	call   80104820 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80106f20:	58                   	pop    %eax
80106f21:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80106f27:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106f2c:	5a                   	pop    %edx
80106f2d:	6a 06                	push   $0x6
80106f2f:	50                   	push   %eax
80106f30:	89 da                	mov    %ebx,%edx
80106f32:	89 f8                	mov    %edi,%eax
80106f34:	e8 67 fb ff ff       	call   80106aa0 <mappages>
80106f39:	83 c4 10             	add    $0x10,%esp
80106f3c:	85 c0                	test   %eax,%eax
80106f3e:	78 50                	js     80106f90 <allocuvm+0xc0>
  for(; a < newsz; a += PGSIZE){
80106f40:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106f46:	39 5d 10             	cmp    %ebx,0x10(%ebp)
80106f49:	0f 86 81 00 00 00    	jbe    80106fd0 <allocuvm+0x100>
    mem = kalloc();
80106f4f:	e8 9c b5 ff ff       	call   801024f0 <kalloc>
    if(mem == 0){
80106f54:	85 c0                	test   %eax,%eax
    mem = kalloc();
80106f56:	89 c6                	mov    %eax,%esi
    if(mem == 0){
80106f58:	75 b6                	jne    80106f10 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
80106f5a:	83 ec 0c             	sub    $0xc,%esp
80106f5d:	68 b1 7c 10 80       	push   $0x80107cb1
80106f62:	e8 f9 96 ff ff       	call   80100660 <cprintf>
  if(newsz >= oldsz)
80106f67:	83 c4 10             	add    $0x10,%esp
80106f6a:	8b 45 0c             	mov    0xc(%ebp),%eax
80106f6d:	39 45 10             	cmp    %eax,0x10(%ebp)
80106f70:	77 6e                	ja     80106fe0 <allocuvm+0x110>
}
80106f72:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
80106f75:	31 ff                	xor    %edi,%edi
}
80106f77:	89 f8                	mov    %edi,%eax
80106f79:	5b                   	pop    %ebx
80106f7a:	5e                   	pop    %esi
80106f7b:	5f                   	pop    %edi
80106f7c:	5d                   	pop    %ebp
80106f7d:	c3                   	ret    
80106f7e:	66 90                	xchg   %ax,%ax
    return oldsz;
80106f80:	8b 7d 0c             	mov    0xc(%ebp),%edi
}
80106f83:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106f86:	89 f8                	mov    %edi,%eax
80106f88:	5b                   	pop    %ebx
80106f89:	5e                   	pop    %esi
80106f8a:	5f                   	pop    %edi
80106f8b:	5d                   	pop    %ebp
80106f8c:	c3                   	ret    
80106f8d:	8d 76 00             	lea    0x0(%esi),%esi
      cprintf("allocuvm out of memory (2)\n");
80106f90:	83 ec 0c             	sub    $0xc,%esp
80106f93:	68 c9 7c 10 80       	push   $0x80107cc9
80106f98:	e8 c3 96 ff ff       	call   80100660 <cprintf>
  if(newsz >= oldsz)
80106f9d:	83 c4 10             	add    $0x10,%esp
80106fa0:	8b 45 0c             	mov    0xc(%ebp),%eax
80106fa3:	39 45 10             	cmp    %eax,0x10(%ebp)
80106fa6:	76 0d                	jbe    80106fb5 <allocuvm+0xe5>
80106fa8:	89 c1                	mov    %eax,%ecx
80106faa:	8b 55 10             	mov    0x10(%ebp),%edx
80106fad:	8b 45 08             	mov    0x8(%ebp),%eax
80106fb0:	e8 7b fb ff ff       	call   80106b30 <deallocuvm.part.0>
      kfree(mem);
80106fb5:	83 ec 0c             	sub    $0xc,%esp
      return 0;
80106fb8:	31 ff                	xor    %edi,%edi
      kfree(mem);
80106fba:	56                   	push   %esi
80106fbb:	e8 80 b3 ff ff       	call   80102340 <kfree>
      return 0;
80106fc0:	83 c4 10             	add    $0x10,%esp
}
80106fc3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106fc6:	89 f8                	mov    %edi,%eax
80106fc8:	5b                   	pop    %ebx
80106fc9:	5e                   	pop    %esi
80106fca:	5f                   	pop    %edi
80106fcb:	5d                   	pop    %ebp
80106fcc:	c3                   	ret    
80106fcd:	8d 76 00             	lea    0x0(%esi),%esi
80106fd0:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80106fd3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106fd6:	5b                   	pop    %ebx
80106fd7:	89 f8                	mov    %edi,%eax
80106fd9:	5e                   	pop    %esi
80106fda:	5f                   	pop    %edi
80106fdb:	5d                   	pop    %ebp
80106fdc:	c3                   	ret    
80106fdd:	8d 76 00             	lea    0x0(%esi),%esi
80106fe0:	89 c1                	mov    %eax,%ecx
80106fe2:	8b 55 10             	mov    0x10(%ebp),%edx
80106fe5:	8b 45 08             	mov    0x8(%ebp),%eax
      return 0;
80106fe8:	31 ff                	xor    %edi,%edi
80106fea:	e8 41 fb ff ff       	call   80106b30 <deallocuvm.part.0>
80106fef:	eb 92                	jmp    80106f83 <allocuvm+0xb3>
80106ff1:	eb 0d                	jmp    80107000 <deallocuvm>
80106ff3:	90                   	nop
80106ff4:	90                   	nop
80106ff5:	90                   	nop
80106ff6:	90                   	nop
80106ff7:	90                   	nop
80106ff8:	90                   	nop
80106ff9:	90                   	nop
80106ffa:	90                   	nop
80106ffb:	90                   	nop
80106ffc:	90                   	nop
80106ffd:	90                   	nop
80106ffe:	90                   	nop
80106fff:	90                   	nop

80107000 <deallocuvm>:
{
80107000:	55                   	push   %ebp
80107001:	89 e5                	mov    %esp,%ebp
80107003:	8b 55 0c             	mov    0xc(%ebp),%edx
80107006:	8b 4d 10             	mov    0x10(%ebp),%ecx
80107009:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
8010700c:	39 d1                	cmp    %edx,%ecx
8010700e:	73 10                	jae    80107020 <deallocuvm+0x20>
}
80107010:	5d                   	pop    %ebp
80107011:	e9 1a fb ff ff       	jmp    80106b30 <deallocuvm.part.0>
80107016:	8d 76 00             	lea    0x0(%esi),%esi
80107019:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80107020:	89 d0                	mov    %edx,%eax
80107022:	5d                   	pop    %ebp
80107023:	c3                   	ret    
80107024:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010702a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80107030 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80107030:	55                   	push   %ebp
80107031:	89 e5                	mov    %esp,%ebp
80107033:	57                   	push   %edi
80107034:	56                   	push   %esi
80107035:	53                   	push   %ebx
80107036:	83 ec 0c             	sub    $0xc,%esp
80107039:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
8010703c:	85 f6                	test   %esi,%esi
8010703e:	74 59                	je     80107099 <freevm+0x69>
80107040:	31 c9                	xor    %ecx,%ecx
80107042:	ba 00 00 00 80       	mov    $0x80000000,%edx
80107047:	89 f0                	mov    %esi,%eax
80107049:	e8 e2 fa ff ff       	call   80106b30 <deallocuvm.part.0>
8010704e:	89 f3                	mov    %esi,%ebx
80107050:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80107056:	eb 0f                	jmp    80107067 <freevm+0x37>
80107058:	90                   	nop
80107059:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107060:	83 c3 04             	add    $0x4,%ebx
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80107063:	39 fb                	cmp    %edi,%ebx
80107065:	74 23                	je     8010708a <freevm+0x5a>
    if(pgdir[i] & PTE_P){
80107067:	8b 03                	mov    (%ebx),%eax
80107069:	a8 01                	test   $0x1,%al
8010706b:	74 f3                	je     80107060 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
8010706d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      kfree(v);
80107072:	83 ec 0c             	sub    $0xc,%esp
80107075:	83 c3 04             	add    $0x4,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
80107078:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
8010707d:	50                   	push   %eax
8010707e:	e8 bd b2 ff ff       	call   80102340 <kfree>
80107083:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
80107086:	39 fb                	cmp    %edi,%ebx
80107088:	75 dd                	jne    80107067 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
8010708a:	89 75 08             	mov    %esi,0x8(%ebp)
}
8010708d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107090:	5b                   	pop    %ebx
80107091:	5e                   	pop    %esi
80107092:	5f                   	pop    %edi
80107093:	5d                   	pop    %ebp
  kfree((char*)pgdir);
80107094:	e9 a7 b2 ff ff       	jmp    80102340 <kfree>
    panic("freevm: no pgdir");
80107099:	83 ec 0c             	sub    $0xc,%esp
8010709c:	68 e5 7c 10 80       	push   $0x80107ce5
801070a1:	e8 ea 92 ff ff       	call   80100390 <panic>
801070a6:	8d 76 00             	lea    0x0(%esi),%esi
801070a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801070b0 <setupkvm>:
{
801070b0:	55                   	push   %ebp
801070b1:	89 e5                	mov    %esp,%ebp
801070b3:	56                   	push   %esi
801070b4:	53                   	push   %ebx
  if((pgdir = (pde_t*)kalloc()) == 0)
801070b5:	e8 36 b4 ff ff       	call   801024f0 <kalloc>
801070ba:	85 c0                	test   %eax,%eax
801070bc:	89 c6                	mov    %eax,%esi
801070be:	74 42                	je     80107102 <setupkvm+0x52>
  memset(pgdir, 0, PGSIZE);
801070c0:	83 ec 04             	sub    $0x4,%esp
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
801070c3:	bb 20 a4 10 80       	mov    $0x8010a420,%ebx
  memset(pgdir, 0, PGSIZE);
801070c8:	68 00 10 00 00       	push   $0x1000
801070cd:	6a 00                	push   $0x0
801070cf:	50                   	push   %eax
801070d0:	e8 4b d7 ff ff       	call   80104820 <memset>
801070d5:	83 c4 10             	add    $0x10,%esp
                (uint)k->phys_start, k->perm) < 0) {
801070d8:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
801070db:	8b 4b 08             	mov    0x8(%ebx),%ecx
801070de:	83 ec 08             	sub    $0x8,%esp
801070e1:	8b 13                	mov    (%ebx),%edx
801070e3:	ff 73 0c             	pushl  0xc(%ebx)
801070e6:	50                   	push   %eax
801070e7:	29 c1                	sub    %eax,%ecx
801070e9:	89 f0                	mov    %esi,%eax
801070eb:	e8 b0 f9 ff ff       	call   80106aa0 <mappages>
801070f0:	83 c4 10             	add    $0x10,%esp
801070f3:	85 c0                	test   %eax,%eax
801070f5:	78 19                	js     80107110 <setupkvm+0x60>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
801070f7:	83 c3 10             	add    $0x10,%ebx
801070fa:	81 fb 60 a4 10 80    	cmp    $0x8010a460,%ebx
80107100:	75 d6                	jne    801070d8 <setupkvm+0x28>
}
80107102:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107105:	89 f0                	mov    %esi,%eax
80107107:	5b                   	pop    %ebx
80107108:	5e                   	pop    %esi
80107109:	5d                   	pop    %ebp
8010710a:	c3                   	ret    
8010710b:	90                   	nop
8010710c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      freevm(pgdir);
80107110:	83 ec 0c             	sub    $0xc,%esp
80107113:	56                   	push   %esi
      return 0;
80107114:	31 f6                	xor    %esi,%esi
      freevm(pgdir);
80107116:	e8 15 ff ff ff       	call   80107030 <freevm>
      return 0;
8010711b:	83 c4 10             	add    $0x10,%esp
}
8010711e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107121:	89 f0                	mov    %esi,%eax
80107123:	5b                   	pop    %ebx
80107124:	5e                   	pop    %esi
80107125:	5d                   	pop    %ebp
80107126:	c3                   	ret    
80107127:	89 f6                	mov    %esi,%esi
80107129:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107130 <kvmalloc>:
{
80107130:	55                   	push   %ebp
80107131:	89 e5                	mov    %esp,%ebp
80107133:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80107136:	e8 75 ff ff ff       	call   801070b0 <setupkvm>
8010713b:	a3 a4 78 11 80       	mov    %eax,0x801178a4
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80107140:	05 00 00 00 80       	add    $0x80000000,%eax
80107145:	0f 22 d8             	mov    %eax,%cr3
}
80107148:	c9                   	leave  
80107149:	c3                   	ret    
8010714a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107150 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80107150:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107151:	31 c9                	xor    %ecx,%ecx
{
80107153:	89 e5                	mov    %esp,%ebp
80107155:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
80107158:	8b 55 0c             	mov    0xc(%ebp),%edx
8010715b:	8b 45 08             	mov    0x8(%ebp),%eax
8010715e:	e8 bd f8 ff ff       	call   80106a20 <walkpgdir>
  if(pte == 0)
80107163:	85 c0                	test   %eax,%eax
80107165:	74 05                	je     8010716c <clearpteu+0x1c>
    panic("clearpteu");
  *pte &= ~PTE_U;
80107167:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
8010716a:	c9                   	leave  
8010716b:	c3                   	ret    
    panic("clearpteu");
8010716c:	83 ec 0c             	sub    $0xc,%esp
8010716f:	68 f6 7c 10 80       	push   $0x80107cf6
80107174:	e8 17 92 ff ff       	call   80100390 <panic>
80107179:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107180 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80107180:	55                   	push   %ebp
80107181:	89 e5                	mov    %esp,%ebp
80107183:	57                   	push   %edi
80107184:	56                   	push   %esi
80107185:	53                   	push   %ebx
80107186:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80107189:	e8 22 ff ff ff       	call   801070b0 <setupkvm>
8010718e:	85 c0                	test   %eax,%eax
80107190:	89 45 e0             	mov    %eax,-0x20(%ebp)
80107193:	0f 84 9f 00 00 00    	je     80107238 <copyuvm+0xb8>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80107199:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010719c:	85 c9                	test   %ecx,%ecx
8010719e:	0f 84 94 00 00 00    	je     80107238 <copyuvm+0xb8>
801071a4:	31 ff                	xor    %edi,%edi
801071a6:	eb 4a                	jmp    801071f2 <copyuvm+0x72>
801071a8:	90                   	nop
801071a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
801071b0:	83 ec 04             	sub    $0x4,%esp
801071b3:	81 c3 00 00 00 80    	add    $0x80000000,%ebx
801071b9:	68 00 10 00 00       	push   $0x1000
801071be:	53                   	push   %ebx
801071bf:	50                   	push   %eax
801071c0:	e8 0b d7 ff ff       	call   801048d0 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
801071c5:	58                   	pop    %eax
801071c6:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
801071cc:	b9 00 10 00 00       	mov    $0x1000,%ecx
801071d1:	5a                   	pop    %edx
801071d2:	ff 75 e4             	pushl  -0x1c(%ebp)
801071d5:	50                   	push   %eax
801071d6:	89 fa                	mov    %edi,%edx
801071d8:	8b 45 e0             	mov    -0x20(%ebp),%eax
801071db:	e8 c0 f8 ff ff       	call   80106aa0 <mappages>
801071e0:	83 c4 10             	add    $0x10,%esp
801071e3:	85 c0                	test   %eax,%eax
801071e5:	78 61                	js     80107248 <copyuvm+0xc8>
  for(i = 0; i < sz; i += PGSIZE){
801071e7:	81 c7 00 10 00 00    	add    $0x1000,%edi
801071ed:	39 7d 0c             	cmp    %edi,0xc(%ebp)
801071f0:	76 46                	jbe    80107238 <copyuvm+0xb8>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
801071f2:	8b 45 08             	mov    0x8(%ebp),%eax
801071f5:	31 c9                	xor    %ecx,%ecx
801071f7:	89 fa                	mov    %edi,%edx
801071f9:	e8 22 f8 ff ff       	call   80106a20 <walkpgdir>
801071fe:	85 c0                	test   %eax,%eax
80107200:	74 61                	je     80107263 <copyuvm+0xe3>
    if(!(*pte & PTE_P))
80107202:	8b 00                	mov    (%eax),%eax
80107204:	a8 01                	test   $0x1,%al
80107206:	74 4e                	je     80107256 <copyuvm+0xd6>
    pa = PTE_ADDR(*pte);
80107208:	89 c3                	mov    %eax,%ebx
    flags = PTE_FLAGS(*pte);
8010720a:	25 ff 0f 00 00       	and    $0xfff,%eax
    pa = PTE_ADDR(*pte);
8010720f:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
    flags = PTE_FLAGS(*pte);
80107215:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if((mem = kalloc()) == 0)
80107218:	e8 d3 b2 ff ff       	call   801024f0 <kalloc>
8010721d:	85 c0                	test   %eax,%eax
8010721f:	89 c6                	mov    %eax,%esi
80107221:	75 8d                	jne    801071b0 <copyuvm+0x30>
    }
  }
  return d;

bad:
  freevm(d);
80107223:	83 ec 0c             	sub    $0xc,%esp
80107226:	ff 75 e0             	pushl  -0x20(%ebp)
80107229:	e8 02 fe ff ff       	call   80107030 <freevm>
  return 0;
8010722e:	83 c4 10             	add    $0x10,%esp
80107231:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
}
80107238:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010723b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010723e:	5b                   	pop    %ebx
8010723f:	5e                   	pop    %esi
80107240:	5f                   	pop    %edi
80107241:	5d                   	pop    %ebp
80107242:	c3                   	ret    
80107243:	90                   	nop
80107244:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      kfree(mem);
80107248:	83 ec 0c             	sub    $0xc,%esp
8010724b:	56                   	push   %esi
8010724c:	e8 ef b0 ff ff       	call   80102340 <kfree>
      goto bad;
80107251:	83 c4 10             	add    $0x10,%esp
80107254:	eb cd                	jmp    80107223 <copyuvm+0xa3>
      panic("copyuvm: page not present");
80107256:	83 ec 0c             	sub    $0xc,%esp
80107259:	68 1a 7d 10 80       	push   $0x80107d1a
8010725e:	e8 2d 91 ff ff       	call   80100390 <panic>
      panic("copyuvm: pte should exist");
80107263:	83 ec 0c             	sub    $0xc,%esp
80107266:	68 00 7d 10 80       	push   $0x80107d00
8010726b:	e8 20 91 ff ff       	call   80100390 <panic>

80107270 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80107270:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107271:	31 c9                	xor    %ecx,%ecx
{
80107273:	89 e5                	mov    %esp,%ebp
80107275:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
80107278:	8b 55 0c             	mov    0xc(%ebp),%edx
8010727b:	8b 45 08             	mov    0x8(%ebp),%eax
8010727e:	e8 9d f7 ff ff       	call   80106a20 <walkpgdir>
  if((*pte & PTE_P) == 0)
80107283:	8b 00                	mov    (%eax),%eax
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
80107285:	c9                   	leave  
  if((*pte & PTE_U) == 0)
80107286:	89 c2                	mov    %eax,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80107288:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((*pte & PTE_U) == 0)
8010728d:	83 e2 05             	and    $0x5,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80107290:	05 00 00 00 80       	add    $0x80000000,%eax
80107295:	83 fa 05             	cmp    $0x5,%edx
80107298:	ba 00 00 00 00       	mov    $0x0,%edx
8010729d:	0f 45 c2             	cmovne %edx,%eax
}
801072a0:	c3                   	ret    
801072a1:	eb 0d                	jmp    801072b0 <copyout>
801072a3:	90                   	nop
801072a4:	90                   	nop
801072a5:	90                   	nop
801072a6:	90                   	nop
801072a7:	90                   	nop
801072a8:	90                   	nop
801072a9:	90                   	nop
801072aa:	90                   	nop
801072ab:	90                   	nop
801072ac:	90                   	nop
801072ad:	90                   	nop
801072ae:	90                   	nop
801072af:	90                   	nop

801072b0 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
801072b0:	55                   	push   %ebp
801072b1:	89 e5                	mov    %esp,%ebp
801072b3:	57                   	push   %edi
801072b4:	56                   	push   %esi
801072b5:	53                   	push   %ebx
801072b6:	83 ec 1c             	sub    $0x1c,%esp
801072b9:	8b 5d 14             	mov    0x14(%ebp),%ebx
801072bc:	8b 55 0c             	mov    0xc(%ebp),%edx
801072bf:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
801072c2:	85 db                	test   %ebx,%ebx
801072c4:	75 40                	jne    80107306 <copyout+0x56>
801072c6:	eb 70                	jmp    80107338 <copyout+0x88>
801072c8:	90                   	nop
801072c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
801072d0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801072d3:	89 f1                	mov    %esi,%ecx
801072d5:	29 d1                	sub    %edx,%ecx
801072d7:	81 c1 00 10 00 00    	add    $0x1000,%ecx
801072dd:	39 d9                	cmp    %ebx,%ecx
801072df:	0f 47 cb             	cmova  %ebx,%ecx
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
801072e2:	29 f2                	sub    %esi,%edx
801072e4:	83 ec 04             	sub    $0x4,%esp
801072e7:	01 d0                	add    %edx,%eax
801072e9:	51                   	push   %ecx
801072ea:	57                   	push   %edi
801072eb:	50                   	push   %eax
801072ec:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
801072ef:	e8 dc d5 ff ff       	call   801048d0 <memmove>
    len -= n;
    buf += n;
801072f4:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
  while(len > 0){
801072f7:	83 c4 10             	add    $0x10,%esp
    va = va0 + PGSIZE;
801072fa:	8d 96 00 10 00 00    	lea    0x1000(%esi),%edx
    buf += n;
80107300:	01 cf                	add    %ecx,%edi
  while(len > 0){
80107302:	29 cb                	sub    %ecx,%ebx
80107304:	74 32                	je     80107338 <copyout+0x88>
    va0 = (uint)PGROUNDDOWN(va);
80107306:	89 d6                	mov    %edx,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80107308:	83 ec 08             	sub    $0x8,%esp
    va0 = (uint)PGROUNDDOWN(va);
8010730b:	89 55 e4             	mov    %edx,-0x1c(%ebp)
8010730e:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80107314:	56                   	push   %esi
80107315:	ff 75 08             	pushl  0x8(%ebp)
80107318:	e8 53 ff ff ff       	call   80107270 <uva2ka>
    if(pa0 == 0)
8010731d:	83 c4 10             	add    $0x10,%esp
80107320:	85 c0                	test   %eax,%eax
80107322:	75 ac                	jne    801072d0 <copyout+0x20>
  }
  return 0;
}
80107324:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80107327:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010732c:	5b                   	pop    %ebx
8010732d:	5e                   	pop    %esi
8010732e:	5f                   	pop    %edi
8010732f:	5d                   	pop    %ebp
80107330:	c3                   	ret    
80107331:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107338:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010733b:	31 c0                	xor    %eax,%eax
}
8010733d:	5b                   	pop    %ebx
8010733e:	5e                   	pop    %esi
8010733f:	5f                   	pop    %edi
80107340:	5d                   	pop    %ebp
80107341:	c3                   	ret    
