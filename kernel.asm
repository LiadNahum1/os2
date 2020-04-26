
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
  struct buf head;
} bcache;

void
binit(void)
{
80100040:	55                   	push   %ebp
80100041:	89 e5                	mov    %esp,%ebp
80100043:	53                   	push   %ebx

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100044:	bb f4 b5 10 80       	mov    $0x8010b5f4,%ebx
{
80100049:	83 ec 0c             	sub    $0xc,%esp
  initlock(&bcache.lock, "bcache");
8010004c:	68 a0 71 10 80       	push   $0x801071a0
80100051:	68 c0 b5 10 80       	push   $0x8010b5c0
80100056:	e8 c5 43 00 00       	call   80104420 <initlock>
  bcache.head.prev = &bcache.head;
8010005b:	c7 05 0c fd 10 80 bc 	movl   $0x8010fcbc,0x8010fd0c
80100062:	fc 10 80 
  bcache.head.next = &bcache.head;
80100065:	c7 05 10 fd 10 80 bc 	movl   $0x8010fcbc,0x8010fd10
8010006c:	fc 10 80 
8010006f:	83 c4 10             	add    $0x10,%esp
80100072:	ba bc fc 10 80       	mov    $0x8010fcbc,%edx
80100077:	eb 09                	jmp    80100082 <binit+0x42>
80100079:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100080:	89 c3                	mov    %eax,%ebx
    b->next = bcache.head.next;
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
80100082:	8d 43 0c             	lea    0xc(%ebx),%eax
80100085:	83 ec 08             	sub    $0x8,%esp
    b->next = bcache.head.next;
80100088:	89 53 54             	mov    %edx,0x54(%ebx)
    b->prev = &bcache.head;
8010008b:	c7 43 50 bc fc 10 80 	movl   $0x8010fcbc,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100092:	68 a7 71 10 80       	push   $0x801071a7
80100097:	50                   	push   %eax
80100098:	e8 53 42 00 00       	call   801042f0 <initsleeplock>
    bcache.head.next->prev = b;
8010009d:	a1 10 fd 10 80       	mov    0x8010fd10,%eax
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000a2:	83 c4 10             	add    $0x10,%esp
801000a5:	89 da                	mov    %ebx,%edx
    bcache.head.next->prev = b;
801000a7:	89 58 50             	mov    %ebx,0x50(%eax)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000aa:	8d 83 5c 02 00 00    	lea    0x25c(%ebx),%eax
    bcache.head.next = b;
801000b0:	89 1d 10 fd 10 80    	mov    %ebx,0x8010fd10
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000b6:	3d bc fc 10 80       	cmp    $0x8010fcbc,%eax
801000bb:	72 c3                	jb     80100080 <binit+0x40>
  }
}
801000bd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801000c0:	c9                   	leave  
801000c1:	c3                   	ret    
801000c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801000c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801000d0 <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
801000d0:	55                   	push   %ebp
801000d1:	89 e5                	mov    %esp,%ebp
801000d3:	57                   	push   %edi
801000d4:	56                   	push   %esi
801000d5:	53                   	push   %ebx
801000d6:	83 ec 18             	sub    $0x18,%esp
801000d9:	8b 75 08             	mov    0x8(%ebp),%esi
801000dc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  acquire(&bcache.lock);
801000df:	68 c0 b5 10 80       	push   $0x8010b5c0
801000e4:	e8 77 44 00 00       	call   80104560 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000e9:	8b 1d 10 fd 10 80    	mov    0x8010fd10,%ebx
801000ef:	83 c4 10             	add    $0x10,%esp
801000f2:	81 fb bc fc 10 80    	cmp    $0x8010fcbc,%ebx
801000f8:	75 11                	jne    8010010b <bread+0x3b>
801000fa:	eb 24                	jmp    80100120 <bread+0x50>
801000fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb bc fc 10 80    	cmp    $0x8010fcbc,%ebx
80100109:	74 15                	je     80100120 <bread+0x50>
    if(b->dev == dev && b->blockno == blockno){
8010010b:	3b 73 04             	cmp    0x4(%ebx),%esi
8010010e:	75 f0                	jne    80100100 <bread+0x30>
80100110:	3b 7b 08             	cmp    0x8(%ebx),%edi
80100113:	75 eb                	jne    80100100 <bread+0x30>
      b->refcnt++;
80100115:	83 43 4c 01          	addl   $0x1,0x4c(%ebx)
80100119:	eb 3f                	jmp    8010015a <bread+0x8a>
8010011b:	90                   	nop
8010011c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100120:	8b 1d 0c fd 10 80    	mov    0x8010fd0c,%ebx
80100126:	81 fb bc fc 10 80    	cmp    $0x8010fcbc,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 60                	jmp    80100190 <bread+0xc0>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb bc fc 10 80    	cmp    $0x8010fcbc,%ebx
80100139:	74 55                	je     80100190 <bread+0xc0>
    if(b->refcnt == 0 && (b->flags & B_DIRTY) == 0) {
8010013b:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010013e:	85 c0                	test   %eax,%eax
80100140:	75 ee                	jne    80100130 <bread+0x60>
80100142:	f6 03 04             	testb  $0x4,(%ebx)
80100145:	75 e9                	jne    80100130 <bread+0x60>
      b->dev = dev;
80100147:	89 73 04             	mov    %esi,0x4(%ebx)
      b->blockno = blockno;
8010014a:	89 7b 08             	mov    %edi,0x8(%ebx)
      b->flags = 0;
8010014d:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
      b->refcnt = 1;
80100153:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
8010015a:	83 ec 0c             	sub    $0xc,%esp
8010015d:	68 c0 b5 10 80       	push   $0x8010b5c0
80100162:	e8 b9 44 00 00       	call   80104620 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 be 41 00 00       	call   80104330 <acquiresleep>
80100172:	83 c4 10             	add    $0x10,%esp
  struct buf *b;

  b = bget(dev, blockno);
  if((b->flags & B_VALID) == 0) {
80100175:	f6 03 02             	testb  $0x2,(%ebx)
80100178:	75 0c                	jne    80100186 <bread+0xb6>
    iderw(b);
8010017a:	83 ec 0c             	sub    $0xc,%esp
8010017d:	53                   	push   %ebx
8010017e:	e8 cd 1f 00 00       	call   80102150 <iderw>
80100183:	83 c4 10             	add    $0x10,%esp
  }
  return b;
}
80100186:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100189:	89 d8                	mov    %ebx,%eax
8010018b:	5b                   	pop    %ebx
8010018c:	5e                   	pop    %esi
8010018d:	5f                   	pop    %edi
8010018e:	5d                   	pop    %ebp
8010018f:	c3                   	ret    
  panic("bget: no buffers");
80100190:	83 ec 0c             	sub    $0xc,%esp
80100193:	68 ae 71 10 80       	push   $0x801071ae
80100198:	e8 f3 01 00 00       	call   80100390 <panic>
8010019d:	8d 76 00             	lea    0x0(%esi),%esi

801001a0 <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
801001a0:	55                   	push   %ebp
801001a1:	89 e5                	mov    %esp,%ebp
801001a3:	53                   	push   %ebx
801001a4:	83 ec 10             	sub    $0x10,%esp
801001a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001aa:	8d 43 0c             	lea    0xc(%ebx),%eax
801001ad:	50                   	push   %eax
801001ae:	e8 1d 42 00 00       	call   801043d0 <holdingsleep>
801001b3:	83 c4 10             	add    $0x10,%esp
801001b6:	85 c0                	test   %eax,%eax
801001b8:	74 0f                	je     801001c9 <bwrite+0x29>
    panic("bwrite");
  b->flags |= B_DIRTY;
801001ba:	83 0b 04             	orl    $0x4,(%ebx)
  iderw(b);
801001bd:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801001c0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801001c3:	c9                   	leave  
  iderw(b);
801001c4:	e9 87 1f 00 00       	jmp    80102150 <iderw>
    panic("bwrite");
801001c9:	83 ec 0c             	sub    $0xc,%esp
801001cc:	68 bf 71 10 80       	push   $0x801071bf
801001d1:	e8 ba 01 00 00       	call   80100390 <panic>
801001d6:	8d 76 00             	lea    0x0(%esi),%esi
801001d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801001e0 <brelse>:

// Release a locked buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
801001e0:	55                   	push   %ebp
801001e1:	89 e5                	mov    %esp,%ebp
801001e3:	56                   	push   %esi
801001e4:	53                   	push   %ebx
801001e5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001e8:	83 ec 0c             	sub    $0xc,%esp
801001eb:	8d 73 0c             	lea    0xc(%ebx),%esi
801001ee:	56                   	push   %esi
801001ef:	e8 dc 41 00 00       	call   801043d0 <holdingsleep>
801001f4:	83 c4 10             	add    $0x10,%esp
801001f7:	85 c0                	test   %eax,%eax
801001f9:	74 66                	je     80100261 <brelse+0x81>
    panic("brelse");

  releasesleep(&b->lock);
801001fb:	83 ec 0c             	sub    $0xc,%esp
801001fe:	56                   	push   %esi
801001ff:	e8 8c 41 00 00       	call   80104390 <releasesleep>

  acquire(&bcache.lock);
80100204:	c7 04 24 c0 b5 10 80 	movl   $0x8010b5c0,(%esp)
8010020b:	e8 50 43 00 00       	call   80104560 <acquire>
  b->refcnt--;
80100210:	8b 43 4c             	mov    0x4c(%ebx),%eax
  if (b->refcnt == 0) {
80100213:	83 c4 10             	add    $0x10,%esp
  b->refcnt--;
80100216:	83 e8 01             	sub    $0x1,%eax
  if (b->refcnt == 0) {
80100219:	85 c0                	test   %eax,%eax
  b->refcnt--;
8010021b:	89 43 4c             	mov    %eax,0x4c(%ebx)
  if (b->refcnt == 0) {
8010021e:	75 2f                	jne    8010024f <brelse+0x6f>
    // no one is waiting for it.
    b->next->prev = b->prev;
80100220:	8b 43 54             	mov    0x54(%ebx),%eax
80100223:	8b 53 50             	mov    0x50(%ebx),%edx
80100226:	89 50 50             	mov    %edx,0x50(%eax)
    b->prev->next = b->next;
80100229:	8b 43 50             	mov    0x50(%ebx),%eax
8010022c:	8b 53 54             	mov    0x54(%ebx),%edx
8010022f:	89 50 54             	mov    %edx,0x54(%eax)
    b->next = bcache.head.next;
80100232:	a1 10 fd 10 80       	mov    0x8010fd10,%eax
    b->prev = &bcache.head;
80100237:	c7 43 50 bc fc 10 80 	movl   $0x8010fcbc,0x50(%ebx)
    b->next = bcache.head.next;
8010023e:	89 43 54             	mov    %eax,0x54(%ebx)
    bcache.head.next->prev = b;
80100241:	a1 10 fd 10 80       	mov    0x8010fd10,%eax
80100246:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
80100249:	89 1d 10 fd 10 80    	mov    %ebx,0x8010fd10
  }
  
  release(&bcache.lock);
8010024f:	c7 45 08 c0 b5 10 80 	movl   $0x8010b5c0,0x8(%ebp)
}
80100256:	8d 65 f8             	lea    -0x8(%ebp),%esp
80100259:	5b                   	pop    %ebx
8010025a:	5e                   	pop    %esi
8010025b:	5d                   	pop    %ebp
  release(&bcache.lock);
8010025c:	e9 bf 43 00 00       	jmp    80104620 <release>
    panic("brelse");
80100261:	83 ec 0c             	sub    $0xc,%esp
80100264:	68 c6 71 10 80       	push   $0x801071c6
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
8010028c:	e8 cf 42 00 00       	call   80104560 <acquire>
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
801002c5:	e8 a6 3b 00 00       	call   80103e70 <sleep>
    while(input.r == input.w){
801002ca:	8b 15 a0 ff 10 80    	mov    0x8010ffa0,%edx
801002d0:	83 c4 10             	add    $0x10,%esp
801002d3:	3b 15 a4 ff 10 80    	cmp    0x8010ffa4,%edx
801002d9:	75 35                	jne    80100310 <consoleread+0xa0>
      if(myproc()->killed){
801002db:	e8 60 34 00 00       	call   80103740 <myproc>
801002e0:	8b 40 24             	mov    0x24(%eax),%eax
801002e3:	85 c0                	test   %eax,%eax
801002e5:	74 d1                	je     801002b8 <consoleread+0x48>
        release(&cons.lock);
801002e7:	83 ec 0c             	sub    $0xc,%esp
801002ea:	68 20 a5 10 80       	push   $0x8010a520
801002ef:	e8 2c 43 00 00       	call   80104620 <release>
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
8010034d:	e8 ce 42 00 00       	call   80104620 <release>
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
801003b2:	68 cd 71 10 80       	push   $0x801071cd
801003b7:	e8 a4 02 00 00       	call   80100660 <cprintf>
  cprintf(s);
801003bc:	58                   	pop    %eax
801003bd:	ff 75 08             	pushl  0x8(%ebp)
801003c0:	e8 9b 02 00 00       	call   80100660 <cprintf>
  cprintf("\n");
801003c5:	c7 04 24 23 7b 10 80 	movl   $0x80107b23,(%esp)
801003cc:	e8 8f 02 00 00       	call   80100660 <cprintf>
  getcallerpcs(&s, pcs);
801003d1:	5a                   	pop    %edx
801003d2:	8d 45 08             	lea    0x8(%ebp),%eax
801003d5:	59                   	pop    %ecx
801003d6:	53                   	push   %ebx
801003d7:	50                   	push   %eax
801003d8:	e8 63 40 00 00       	call   80104440 <getcallerpcs>
801003dd:	83 c4 10             	add    $0x10,%esp
    cprintf(" %p", pcs[i]);
801003e0:	83 ec 08             	sub    $0x8,%esp
801003e3:	ff 33                	pushl  (%ebx)
801003e5:	83 c3 04             	add    $0x4,%ebx
801003e8:	68 e1 71 10 80       	push   $0x801071e1
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
8010043a:	e8 71 59 00 00       	call   80105db0 <uartputc>
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
801004ec:	e8 bf 58 00 00       	call   80105db0 <uartputc>
801004f1:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801004f8:	e8 b3 58 00 00       	call   80105db0 <uartputc>
801004fd:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80100504:	e8 a7 58 00 00       	call   80105db0 <uartputc>
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
80100524:	e8 f7 41 00 00       	call   80104720 <memmove>
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
80100541:	e8 2a 41 00 00       	call   80104670 <memset>
80100546:	83 c4 10             	add    $0x10,%esp
80100549:	e9 5d ff ff ff       	jmp    801004ab <consputc+0x9b>
    panic("pos under/overflow");
8010054e:	83 ec 0c             	sub    $0xc,%esp
80100551:	68 e5 71 10 80       	push   $0x801071e5
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
801005b1:	0f b6 92 10 72 10 80 	movzbl -0x7fef8df0(%edx),%edx
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
8010061b:	e8 40 3f 00 00       	call   80104560 <acquire>
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
80100647:	e8 d4 3f 00 00       	call   80104620 <release>
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
8010071f:	e8 fc 3e 00 00       	call   80104620 <release>
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
801007d0:	ba f8 71 10 80       	mov    $0x801071f8,%edx
      for(; *s; s++)
801007d5:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
801007d8:	b8 28 00 00 00       	mov    $0x28,%eax
801007dd:	89 d3                	mov    %edx,%ebx
801007df:	eb bf                	jmp    801007a0 <cprintf+0x140>
801007e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    acquire(&cons.lock);
801007e8:	83 ec 0c             	sub    $0xc,%esp
801007eb:	68 20 a5 10 80       	push   $0x8010a520
801007f0:	e8 6b 3d 00 00       	call   80104560 <acquire>
801007f5:	83 c4 10             	add    $0x10,%esp
801007f8:	e9 7c fe ff ff       	jmp    80100679 <cprintf+0x19>
    panic("null fmt");
801007fd:	83 ec 0c             	sub    $0xc,%esp
80100800:	68 ff 71 10 80       	push   $0x801071ff
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
80100823:	e8 38 3d 00 00       	call   80104560 <acquire>
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
80100888:	e8 93 3d 00 00       	call   80104620 <release>
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
80100916:	e8 15 37 00 00       	call   80104030 <wakeup>
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
80100997:	e9 c4 37 00 00       	jmp    80104160 <procdump>
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
801009c6:	68 08 72 10 80       	push   $0x80107208
801009cb:	68 20 a5 10 80       	push   $0x8010a520
801009d0:	e8 4b 3a 00 00       	call   80104420 <initlock>

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
80100a1c:	e8 1f 2d 00 00       	call   80103740 <myproc>
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
80100a94:	e8 67 64 00 00       	call   80106f00 <setupkvm>
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
80100af6:	e8 25 62 00 00       	call   80106d20 <allocuvm>
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
80100b28:	e8 33 61 00 00       	call   80106c60 <loaduvm>
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
80100b72:	e8 09 63 00 00       	call   80106e80 <freevm>
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
80100baa:	e8 71 61 00 00       	call   80106d20 <allocuvm>
80100baf:	83 c4 10             	add    $0x10,%esp
80100bb2:	85 c0                	test   %eax,%eax
80100bb4:	89 c6                	mov    %eax,%esi
80100bb6:	75 3a                	jne    80100bf2 <exec+0x1e2>
    freevm(pgdir);
80100bb8:	83 ec 0c             	sub    $0xc,%esp
80100bbb:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100bc1:	e8 ba 62 00 00       	call   80106e80 <freevm>
80100bc6:	83 c4 10             	add    $0x10,%esp
  return -1;
80100bc9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100bce:	e9 a9 fe ff ff       	jmp    80100a7c <exec+0x6c>
    end_op();
80100bd3:	e8 68 20 00 00       	call   80102c40 <end_op>
    cprintf("exec: fail\n");
80100bd8:	83 ec 0c             	sub    $0xc,%esp
80100bdb:	68 21 72 10 80       	push   $0x80107221
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
80100c06:	e8 95 63 00 00       	call   80106fa0 <clearpteu>
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
80100c39:	e8 52 3c 00 00       	call   80104890 <strlen>
80100c3e:	f7 d0                	not    %eax
80100c40:	01 c3                	add    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c42:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c45:	5a                   	pop    %edx
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100c46:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c49:	ff 34 b8             	pushl  (%eax,%edi,4)
80100c4c:	e8 3f 3c 00 00       	call   80104890 <strlen>
80100c51:	83 c0 01             	add    $0x1,%eax
80100c54:	50                   	push   %eax
80100c55:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c58:	ff 34 b8             	pushl  (%eax,%edi,4)
80100c5b:	53                   	push   %ebx
80100c5c:	56                   	push   %esi
80100c5d:	e8 9e 64 00 00       	call   80107100 <copyout>
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
80100cc7:	e8 34 64 00 00       	call   80107100 <copyout>
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
80100d08:	e8 43 3b 00 00       	call   80104850 <safestrcpy>
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
80100d33:	81 c2 04 01 00 00    	add    $0x104,%edx
80100d39:	89 58 44             	mov    %ebx,0x44(%eax)
80100d3c:	89 c8                	mov    %ecx,%eax
80100d3e:	05 84 00 00 00       	add    $0x84,%eax
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
80100d63:	e8 68 5d 00 00       	call   80106ad0 <switchuvm>
  freevm(oldpgdir);
80100d68:	89 3c 24             	mov    %edi,(%esp)
80100d6b:	e8 10 61 00 00       	call   80106e80 <freevm>
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
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100d90:	55                   	push   %ebp
80100d91:	89 e5                	mov    %esp,%ebp
80100d93:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
80100d96:	68 2d 72 10 80       	push   $0x8010722d
80100d9b:	68 c0 ff 10 80       	push   $0x8010ffc0
80100da0:	e8 7b 36 00 00       	call   80104420 <initlock>
}
80100da5:	83 c4 10             	add    $0x10,%esp
80100da8:	c9                   	leave  
80100da9:	c3                   	ret    
80100daa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100db0 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80100db0:	55                   	push   %ebp
80100db1:	89 e5                	mov    %esp,%ebp
80100db3:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100db4:	bb f4 ff 10 80       	mov    $0x8010fff4,%ebx
{
80100db9:	83 ec 10             	sub    $0x10,%esp
  acquire(&ftable.lock);
80100dbc:	68 c0 ff 10 80       	push   $0x8010ffc0
80100dc1:	e8 9a 37 00 00       	call   80104560 <acquire>
80100dc6:	83 c4 10             	add    $0x10,%esp
80100dc9:	eb 10                	jmp    80100ddb <filealloc+0x2b>
80100dcb:	90                   	nop
80100dcc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100dd0:	83 c3 18             	add    $0x18,%ebx
80100dd3:	81 fb 54 09 11 80    	cmp    $0x80110954,%ebx
80100dd9:	73 25                	jae    80100e00 <filealloc+0x50>
    if(f->ref == 0){
80100ddb:	8b 43 04             	mov    0x4(%ebx),%eax
80100dde:	85 c0                	test   %eax,%eax
80100de0:	75 ee                	jne    80100dd0 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
80100de2:	83 ec 0c             	sub    $0xc,%esp
      f->ref = 1;
80100de5:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
80100dec:	68 c0 ff 10 80       	push   $0x8010ffc0
80100df1:	e8 2a 38 00 00       	call   80104620 <release>
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}
80100df6:	89 d8                	mov    %ebx,%eax
      return f;
80100df8:	83 c4 10             	add    $0x10,%esp
}
80100dfb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100dfe:	c9                   	leave  
80100dff:	c3                   	ret    
  release(&ftable.lock);
80100e00:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80100e03:	31 db                	xor    %ebx,%ebx
  release(&ftable.lock);
80100e05:	68 c0 ff 10 80       	push   $0x8010ffc0
80100e0a:	e8 11 38 00 00       	call   80104620 <release>
}
80100e0f:	89 d8                	mov    %ebx,%eax
  return 0;
80100e11:	83 c4 10             	add    $0x10,%esp
}
80100e14:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100e17:	c9                   	leave  
80100e18:	c3                   	ret    
80100e19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100e20 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80100e20:	55                   	push   %ebp
80100e21:	89 e5                	mov    %esp,%ebp
80100e23:	53                   	push   %ebx
80100e24:	83 ec 10             	sub    $0x10,%esp
80100e27:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
80100e2a:	68 c0 ff 10 80       	push   $0x8010ffc0
80100e2f:	e8 2c 37 00 00       	call   80104560 <acquire>
  if(f->ref < 1)
80100e34:	8b 43 04             	mov    0x4(%ebx),%eax
80100e37:	83 c4 10             	add    $0x10,%esp
80100e3a:	85 c0                	test   %eax,%eax
80100e3c:	7e 1a                	jle    80100e58 <filedup+0x38>
    panic("filedup");
  f->ref++;
80100e3e:	83 c0 01             	add    $0x1,%eax
  release(&ftable.lock);
80100e41:	83 ec 0c             	sub    $0xc,%esp
  f->ref++;
80100e44:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80100e47:	68 c0 ff 10 80       	push   $0x8010ffc0
80100e4c:	e8 cf 37 00 00       	call   80104620 <release>
  return f;
}
80100e51:	89 d8                	mov    %ebx,%eax
80100e53:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100e56:	c9                   	leave  
80100e57:	c3                   	ret    
    panic("filedup");
80100e58:	83 ec 0c             	sub    $0xc,%esp
80100e5b:	68 34 72 10 80       	push   $0x80107234
80100e60:	e8 2b f5 ff ff       	call   80100390 <panic>
80100e65:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100e69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100e70 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80100e70:	55                   	push   %ebp
80100e71:	89 e5                	mov    %esp,%ebp
80100e73:	57                   	push   %edi
80100e74:	56                   	push   %esi
80100e75:	53                   	push   %ebx
80100e76:	83 ec 28             	sub    $0x28,%esp
80100e79:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct file ff;

  acquire(&ftable.lock);
80100e7c:	68 c0 ff 10 80       	push   $0x8010ffc0
80100e81:	e8 da 36 00 00       	call   80104560 <acquire>
  if(f->ref < 1)
80100e86:	8b 43 04             	mov    0x4(%ebx),%eax
80100e89:	83 c4 10             	add    $0x10,%esp
80100e8c:	85 c0                	test   %eax,%eax
80100e8e:	0f 8e 9b 00 00 00    	jle    80100f2f <fileclose+0xbf>
    panic("fileclose");
  if(--f->ref > 0){
80100e94:	83 e8 01             	sub    $0x1,%eax
80100e97:	85 c0                	test   %eax,%eax
80100e99:	89 43 04             	mov    %eax,0x4(%ebx)
80100e9c:	74 1a                	je     80100eb8 <fileclose+0x48>
    release(&ftable.lock);
80100e9e:	c7 45 08 c0 ff 10 80 	movl   $0x8010ffc0,0x8(%ebp)
  else if(ff.type == FD_INODE){
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80100ea5:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100ea8:	5b                   	pop    %ebx
80100ea9:	5e                   	pop    %esi
80100eaa:	5f                   	pop    %edi
80100eab:	5d                   	pop    %ebp
    release(&ftable.lock);
80100eac:	e9 6f 37 00 00       	jmp    80104620 <release>
80100eb1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  ff = *f;
80100eb8:	0f b6 43 09          	movzbl 0x9(%ebx),%eax
80100ebc:	8b 3b                	mov    (%ebx),%edi
  release(&ftable.lock);
80100ebe:	83 ec 0c             	sub    $0xc,%esp
  ff = *f;
80100ec1:	8b 73 0c             	mov    0xc(%ebx),%esi
  f->type = FD_NONE;
80100ec4:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  ff = *f;
80100eca:	88 45 e7             	mov    %al,-0x19(%ebp)
80100ecd:	8b 43 10             	mov    0x10(%ebx),%eax
  release(&ftable.lock);
80100ed0:	68 c0 ff 10 80       	push   $0x8010ffc0
  ff = *f;
80100ed5:	89 45 e0             	mov    %eax,-0x20(%ebp)
  release(&ftable.lock);
80100ed8:	e8 43 37 00 00       	call   80104620 <release>
  if(ff.type == FD_PIPE)
80100edd:	83 c4 10             	add    $0x10,%esp
80100ee0:	83 ff 01             	cmp    $0x1,%edi
80100ee3:	74 13                	je     80100ef8 <fileclose+0x88>
  else if(ff.type == FD_INODE){
80100ee5:	83 ff 02             	cmp    $0x2,%edi
80100ee8:	74 26                	je     80100f10 <fileclose+0xa0>
}
80100eea:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100eed:	5b                   	pop    %ebx
80100eee:	5e                   	pop    %esi
80100eef:	5f                   	pop    %edi
80100ef0:	5d                   	pop    %ebp
80100ef1:	c3                   	ret    
80100ef2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pipeclose(ff.pipe, ff.writable);
80100ef8:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
80100efc:	83 ec 08             	sub    $0x8,%esp
80100eff:	53                   	push   %ebx
80100f00:	56                   	push   %esi
80100f01:	e8 7a 24 00 00       	call   80103380 <pipeclose>
80100f06:	83 c4 10             	add    $0x10,%esp
80100f09:	eb df                	jmp    80100eea <fileclose+0x7a>
80100f0b:	90                   	nop
80100f0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    begin_op();
80100f10:	e8 bb 1c 00 00       	call   80102bd0 <begin_op>
    iput(ff.ip);
80100f15:	83 ec 0c             	sub    $0xc,%esp
80100f18:	ff 75 e0             	pushl  -0x20(%ebp)
80100f1b:	e8 c0 08 00 00       	call   801017e0 <iput>
    end_op();
80100f20:	83 c4 10             	add    $0x10,%esp
}
80100f23:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100f26:	5b                   	pop    %ebx
80100f27:	5e                   	pop    %esi
80100f28:	5f                   	pop    %edi
80100f29:	5d                   	pop    %ebp
    end_op();
80100f2a:	e9 11 1d 00 00       	jmp    80102c40 <end_op>
    panic("fileclose");
80100f2f:	83 ec 0c             	sub    $0xc,%esp
80100f32:	68 3c 72 10 80       	push   $0x8010723c
80100f37:	e8 54 f4 ff ff       	call   80100390 <panic>
80100f3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100f40 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80100f40:	55                   	push   %ebp
80100f41:	89 e5                	mov    %esp,%ebp
80100f43:	53                   	push   %ebx
80100f44:	83 ec 04             	sub    $0x4,%esp
80100f47:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
80100f4a:	83 3b 02             	cmpl   $0x2,(%ebx)
80100f4d:	75 31                	jne    80100f80 <filestat+0x40>
    ilock(f->ip);
80100f4f:	83 ec 0c             	sub    $0xc,%esp
80100f52:	ff 73 10             	pushl  0x10(%ebx)
80100f55:	e8 56 07 00 00       	call   801016b0 <ilock>
    stati(f->ip, st);
80100f5a:	58                   	pop    %eax
80100f5b:	5a                   	pop    %edx
80100f5c:	ff 75 0c             	pushl  0xc(%ebp)
80100f5f:	ff 73 10             	pushl  0x10(%ebx)
80100f62:	e8 f9 09 00 00       	call   80101960 <stati>
    iunlock(f->ip);
80100f67:	59                   	pop    %ecx
80100f68:	ff 73 10             	pushl  0x10(%ebx)
80100f6b:	e8 20 08 00 00       	call   80101790 <iunlock>
    return 0;
80100f70:	83 c4 10             	add    $0x10,%esp
80100f73:	31 c0                	xor    %eax,%eax
  }
  return -1;
}
80100f75:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100f78:	c9                   	leave  
80100f79:	c3                   	ret    
80100f7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return -1;
80100f80:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100f85:	eb ee                	jmp    80100f75 <filestat+0x35>
80100f87:	89 f6                	mov    %esi,%esi
80100f89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100f90 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80100f90:	55                   	push   %ebp
80100f91:	89 e5                	mov    %esp,%ebp
80100f93:	57                   	push   %edi
80100f94:	56                   	push   %esi
80100f95:	53                   	push   %ebx
80100f96:	83 ec 0c             	sub    $0xc,%esp
80100f99:	8b 5d 08             	mov    0x8(%ebp),%ebx
80100f9c:	8b 75 0c             	mov    0xc(%ebp),%esi
80100f9f:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
80100fa2:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80100fa6:	74 60                	je     80101008 <fileread+0x78>
    return -1;
  if(f->type == FD_PIPE)
80100fa8:	8b 03                	mov    (%ebx),%eax
80100faa:	83 f8 01             	cmp    $0x1,%eax
80100fad:	74 41                	je     80100ff0 <fileread+0x60>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
80100faf:	83 f8 02             	cmp    $0x2,%eax
80100fb2:	75 5b                	jne    8010100f <fileread+0x7f>
    ilock(f->ip);
80100fb4:	83 ec 0c             	sub    $0xc,%esp
80100fb7:	ff 73 10             	pushl  0x10(%ebx)
80100fba:	e8 f1 06 00 00       	call   801016b0 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
80100fbf:	57                   	push   %edi
80100fc0:	ff 73 14             	pushl  0x14(%ebx)
80100fc3:	56                   	push   %esi
80100fc4:	ff 73 10             	pushl  0x10(%ebx)
80100fc7:	e8 c4 09 00 00       	call   80101990 <readi>
80100fcc:	83 c4 20             	add    $0x20,%esp
80100fcf:	85 c0                	test   %eax,%eax
80100fd1:	89 c6                	mov    %eax,%esi
80100fd3:	7e 03                	jle    80100fd8 <fileread+0x48>
      f->off += r;
80100fd5:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
80100fd8:	83 ec 0c             	sub    $0xc,%esp
80100fdb:	ff 73 10             	pushl  0x10(%ebx)
80100fde:	e8 ad 07 00 00       	call   80101790 <iunlock>
    return r;
80100fe3:	83 c4 10             	add    $0x10,%esp
  }
  panic("fileread");
}
80100fe6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100fe9:	89 f0                	mov    %esi,%eax
80100feb:	5b                   	pop    %ebx
80100fec:	5e                   	pop    %esi
80100fed:	5f                   	pop    %edi
80100fee:	5d                   	pop    %ebp
80100fef:	c3                   	ret    
    return piperead(f->pipe, addr, n);
80100ff0:	8b 43 0c             	mov    0xc(%ebx),%eax
80100ff3:	89 45 08             	mov    %eax,0x8(%ebp)
}
80100ff6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100ff9:	5b                   	pop    %ebx
80100ffa:	5e                   	pop    %esi
80100ffb:	5f                   	pop    %edi
80100ffc:	5d                   	pop    %ebp
    return piperead(f->pipe, addr, n);
80100ffd:	e9 2e 25 00 00       	jmp    80103530 <piperead>
80101002:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80101008:	be ff ff ff ff       	mov    $0xffffffff,%esi
8010100d:	eb d7                	jmp    80100fe6 <fileread+0x56>
  panic("fileread");
8010100f:	83 ec 0c             	sub    $0xc,%esp
80101012:	68 46 72 10 80       	push   $0x80107246
80101017:	e8 74 f3 ff ff       	call   80100390 <panic>
8010101c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101020 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80101020:	55                   	push   %ebp
80101021:	89 e5                	mov    %esp,%ebp
80101023:	57                   	push   %edi
80101024:	56                   	push   %esi
80101025:	53                   	push   %ebx
80101026:	83 ec 1c             	sub    $0x1c,%esp
80101029:	8b 75 08             	mov    0x8(%ebp),%esi
8010102c:	8b 45 0c             	mov    0xc(%ebp),%eax
  int r;

  if(f->writable == 0)
8010102f:	80 7e 09 00          	cmpb   $0x0,0x9(%esi)
{
80101033:	89 45 dc             	mov    %eax,-0x24(%ebp)
80101036:	8b 45 10             	mov    0x10(%ebp),%eax
80101039:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(f->writable == 0)
8010103c:	0f 84 aa 00 00 00    	je     801010ec <filewrite+0xcc>
    return -1;
  if(f->type == FD_PIPE)
80101042:	8b 06                	mov    (%esi),%eax
80101044:	83 f8 01             	cmp    $0x1,%eax
80101047:	0f 84 c3 00 00 00    	je     80101110 <filewrite+0xf0>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
8010104d:	83 f8 02             	cmp    $0x2,%eax
80101050:	0f 85 d9 00 00 00    	jne    8010112f <filewrite+0x10f>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
80101056:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    int i = 0;
80101059:	31 ff                	xor    %edi,%edi
    while(i < n){
8010105b:	85 c0                	test   %eax,%eax
8010105d:	7f 34                	jg     80101093 <filewrite+0x73>
8010105f:	e9 9c 00 00 00       	jmp    80101100 <filewrite+0xe0>
80101064:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80101068:	01 46 14             	add    %eax,0x14(%esi)
      iunlock(f->ip);
8010106b:	83 ec 0c             	sub    $0xc,%esp
8010106e:	ff 76 10             	pushl  0x10(%esi)
        f->off += r;
80101071:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
80101074:	e8 17 07 00 00       	call   80101790 <iunlock>
      end_op();
80101079:	e8 c2 1b 00 00       	call   80102c40 <end_op>
8010107e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101081:	83 c4 10             	add    $0x10,%esp

      if(r < 0)
        break;
      if(r != n1)
80101084:	39 c3                	cmp    %eax,%ebx
80101086:	0f 85 96 00 00 00    	jne    80101122 <filewrite+0x102>
        panic("short filewrite");
      i += r;
8010108c:	01 df                	add    %ebx,%edi
    while(i < n){
8010108e:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101091:	7e 6d                	jle    80101100 <filewrite+0xe0>
      int n1 = n - i;
80101093:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101096:	b8 00 06 00 00       	mov    $0x600,%eax
8010109b:	29 fb                	sub    %edi,%ebx
8010109d:	81 fb 00 06 00 00    	cmp    $0x600,%ebx
801010a3:	0f 4f d8             	cmovg  %eax,%ebx
      begin_op();
801010a6:	e8 25 1b 00 00       	call   80102bd0 <begin_op>
      ilock(f->ip);
801010ab:	83 ec 0c             	sub    $0xc,%esp
801010ae:	ff 76 10             	pushl  0x10(%esi)
801010b1:	e8 fa 05 00 00       	call   801016b0 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
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
      iunlock(f->ip);
801010cf:	83 ec 0c             	sub    $0xc,%esp
801010d2:	ff 76 10             	pushl  0x10(%esi)
801010d5:	89 45 e0             	mov    %eax,-0x20(%ebp)
801010d8:	e8 b3 06 00 00       	call   80101790 <iunlock>
      end_op();
801010dd:	e8 5e 1b 00 00       	call   80102c40 <end_op>
      if(r < 0)
801010e2:	8b 45 e0             	mov    -0x20(%ebp),%eax
801010e5:	83 c4 10             	add    $0x10,%esp
801010e8:	85 c0                	test   %eax,%eax
801010ea:	74 98                	je     80101084 <filewrite+0x64>
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
}
801010ec:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
801010ef:	bf ff ff ff ff       	mov    $0xffffffff,%edi
}
801010f4:	89 f8                	mov    %edi,%eax
801010f6:	5b                   	pop    %ebx
801010f7:	5e                   	pop    %esi
801010f8:	5f                   	pop    %edi
801010f9:	5d                   	pop    %ebp
801010fa:	c3                   	ret    
801010fb:	90                   	nop
801010fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return i == n ? n : -1;
80101100:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101103:	75 e7                	jne    801010ec <filewrite+0xcc>
}
80101105:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101108:	89 f8                	mov    %edi,%eax
8010110a:	5b                   	pop    %ebx
8010110b:	5e                   	pop    %esi
8010110c:	5f                   	pop    %edi
8010110d:	5d                   	pop    %ebp
8010110e:	c3                   	ret    
8010110f:	90                   	nop
    return pipewrite(f->pipe, addr, n);
80101110:	8b 46 0c             	mov    0xc(%esi),%eax
80101113:	89 45 08             	mov    %eax,0x8(%ebp)
}
80101116:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101119:	5b                   	pop    %ebx
8010111a:	5e                   	pop    %esi
8010111b:	5f                   	pop    %edi
8010111c:	5d                   	pop    %ebp
    return pipewrite(f->pipe, addr, n);
8010111d:	e9 fe 22 00 00       	jmp    80103420 <pipewrite>
        panic("short filewrite");
80101122:	83 ec 0c             	sub    $0xc,%esp
80101125:	68 4f 72 10 80       	push   $0x8010724f
8010112a:	e8 61 f2 ff ff       	call   80100390 <panic>
  panic("filewrite");
8010112f:	83 ec 0c             	sub    $0xc,%esp
80101132:	68 55 72 10 80       	push   $0x80107255
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
801011a3:	68 5f 72 10 80       	push   $0x8010725f
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
80101254:	68 72 72 10 80       	push   $0x80107272
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
80101295:	e8 d6 33 00 00       	call   80104670 <memset>
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
801012da:	e8 81 32 00 00       	call   80104560 <acquire>
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
8010133f:	e8 dc 32 00 00       	call   80104620 <release>

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
8010136d:	e8 ae 32 00 00       	call   80104620 <release>
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
80101382:	68 88 72 10 80       	push   $0x80107288
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
80101457:	68 98 72 10 80       	push   $0x80107298
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
80101491:	e8 8a 32 00 00       	call   80104720 <memmove>
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
801014bc:	68 ab 72 10 80       	push   $0x801072ab
801014c1:	68 e0 09 11 80       	push   $0x801109e0
801014c6:	e8 55 2f 00 00       	call   80104420 <initlock>
801014cb:	83 c4 10             	add    $0x10,%esp
801014ce:	66 90                	xchg   %ax,%ax
    initsleeplock(&icache.inode[i].lock, "inode");
801014d0:	83 ec 08             	sub    $0x8,%esp
801014d3:	68 b2 72 10 80       	push   $0x801072b2
801014d8:	53                   	push   %ebx
801014d9:	81 c3 90 00 00 00    	add    $0x90,%ebx
801014df:	e8 0c 2e 00 00       	call   801042f0 <initsleeplock>
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
80101529:	68 18 73 10 80       	push   $0x80107318
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
801015be:	e8 ad 30 00 00       	call   80104670 <memset>
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
801015f3:	68 b8 72 10 80       	push   $0x801072b8
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
80101661:	e8 ba 30 00 00       	call   80104720 <memmove>
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
8010168f:	e8 cc 2e 00 00       	call   80104560 <acquire>
  ip->ref++;
80101694:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101698:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
8010169f:	e8 7c 2f 00 00       	call   80104620 <release>
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
801016d2:	e8 59 2c 00 00       	call   80104330 <acquiresleep>
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
80101748:	e8 d3 2f 00 00       	call   80104720 <memmove>
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
8010176d:	68 d0 72 10 80       	push   $0x801072d0
80101772:	e8 19 ec ff ff       	call   80100390 <panic>
    panic("ilock");
80101777:	83 ec 0c             	sub    $0xc,%esp
8010177a:	68 ca 72 10 80       	push   $0x801072ca
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
801017a3:	e8 28 2c 00 00       	call   801043d0 <holdingsleep>
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
801017bf:	e9 cc 2b 00 00       	jmp    80104390 <releasesleep>
    panic("iunlock");
801017c4:	83 ec 0c             	sub    $0xc,%esp
801017c7:	68 df 72 10 80       	push   $0x801072df
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
801017f0:	e8 3b 2b 00 00       	call   80104330 <acquiresleep>
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
8010180a:	e8 81 2b 00 00       	call   80104390 <releasesleep>
  acquire(&icache.lock);
8010180f:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
80101816:	e8 45 2d 00 00       	call   80104560 <acquire>
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
80101830:	e9 eb 2d 00 00       	jmp    80104620 <release>
80101835:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&icache.lock);
80101838:	83 ec 0c             	sub    $0xc,%esp
8010183b:	68 e0 09 11 80       	push   $0x801109e0
80101840:	e8 1b 2d 00 00       	call   80104560 <acquire>
    int r = ip->ref;
80101845:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
80101848:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
8010184f:	e8 cc 2d 00 00       	call   80104620 <release>
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
80101a37:	e8 e4 2c 00 00       	call   80104720 <memmove>
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
80101b33:	e8 e8 2b 00 00       	call   80104720 <memmove>
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
80101bce:	e8 bd 2b 00 00       	call   80104790 <strncmp>
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
80101c2d:	e8 5e 2b 00 00       	call   80104790 <strncmp>
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
80101c72:	68 f9 72 10 80       	push   $0x801072f9
80101c77:	e8 14 e7 ff ff       	call   80100390 <panic>
    panic("dirlookup not DIR");
80101c7c:	83 ec 0c             	sub    $0xc,%esp
80101c7f:	68 e7 72 10 80       	push   $0x801072e7
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
80101ca9:	e8 92 1a 00 00       	call   80103740 <myproc>
  acquire(&icache.lock);
80101cae:	83 ec 0c             	sub    $0xc,%esp
    ip = idup(myproc()->cwd);
80101cb1:	8b 70 68             	mov    0x68(%eax),%esi
  acquire(&icache.lock);
80101cb4:	68 e0 09 11 80       	push   $0x801109e0
80101cb9:	e8 a2 28 00 00       	call   80104560 <acquire>
  ip->ref++;
80101cbe:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80101cc2:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
80101cc9:	e8 52 29 00 00       	call   80104620 <release>
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
80101d25:	e8 f6 29 00 00       	call   80104720 <memmove>
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
80101db8:	e8 63 29 00 00       	call   80104720 <memmove>
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
80101ead:	e8 3e 29 00 00       	call   801047f0 <strncpy>
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
80101eeb:	68 08 73 10 80       	push   $0x80107308
80101ef0:	e8 9b e4 ff ff       	call   80100390 <panic>
    panic("dirlink");
80101ef5:	83 ec 0c             	sub    $0xc,%esp
80101ef8:	68 0a 79 10 80       	push   $0x8010790a
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
8010200b:	68 74 73 10 80       	push   $0x80107374
80102010:	e8 7b e3 ff ff       	call   80100390 <panic>
    panic("idestart");
80102015:	83 ec 0c             	sub    $0xc,%esp
80102018:	68 6b 73 10 80       	push   $0x8010736b
8010201d:	e8 6e e3 ff ff       	call   80100390 <panic>
80102022:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102029:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102030 <ideinit>:
{
80102030:	55                   	push   %ebp
80102031:	89 e5                	mov    %esp,%ebp
80102033:	83 ec 10             	sub    $0x10,%esp
  initlock(&idelock, "ide");
80102036:	68 86 73 10 80       	push   $0x80107386
8010203b:	68 80 a5 10 80       	push   $0x8010a580
80102040:	e8 db 23 00 00       	call   80104420 <initlock>
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
801020be:	e8 9d 24 00 00       	call   80104560 <acquire>

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
80102121:	e8 0a 1f 00 00       	call   80104030 <wakeup>

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
8010213f:	e8 dc 24 00 00       	call   80104620 <release>

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
8010215e:	e8 6d 22 00 00       	call   801043d0 <holdingsleep>
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
80102198:	e8 c3 23 00 00       	call   80104560 <acquire>

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
801021e9:	e8 82 1c 00 00       	call   80103e70 <sleep>
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
80102206:	e9 15 24 00 00       	jmp    80104620 <release>
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
8010222a:	68 a0 73 10 80       	push   $0x801073a0
8010222f:	e8 5c e1 ff ff       	call   80100390 <panic>
    panic("iderw: buf not locked");
80102234:	83 ec 0c             	sub    $0xc,%esp
80102237:	68 8a 73 10 80       	push   $0x8010738a
8010223c:	e8 4f e1 ff ff       	call   80100390 <panic>
    panic("iderw: ide disk 1 not present");
80102241:	83 ec 0c             	sub    $0xc,%esp
80102244:	68 b5 73 10 80       	push   $0x801073b5
80102249:	e8 42 e1 ff ff       	call   80100390 <panic>
8010224e:	66 90                	xchg   %ax,%ax

80102250 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
80102250:	55                   	push   %ebp
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
80102251:	c7 05 34 26 11 80 00 	movl   $0xfec00000,0x80112634
80102258:	00 c0 fe 
{
8010225b:	89 e5                	mov    %esp,%ebp
8010225d:	56                   	push   %esi
8010225e:	53                   	push   %ebx
  ioapic->reg = reg;
8010225f:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
80102266:	00 00 00 
  return ioapic->data;
80102269:	a1 34 26 11 80       	mov    0x80112634,%eax
8010226e:	8b 58 10             	mov    0x10(%eax),%ebx
  ioapic->reg = reg;
80102271:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  return ioapic->data;
80102277:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
8010227d:	0f b6 15 60 27 11 80 	movzbl 0x80112760,%edx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80102284:	c1 eb 10             	shr    $0x10,%ebx
  return ioapic->data;
80102287:	8b 41 10             	mov    0x10(%ecx),%eax
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
8010228a:	0f b6 db             	movzbl %bl,%ebx
  id = ioapicread(REG_ID) >> 24;
8010228d:	c1 e8 18             	shr    $0x18,%eax
  if(id != ioapicid)
80102290:	39 c2                	cmp    %eax,%edx
80102292:	74 16                	je     801022aa <ioapicinit+0x5a>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80102294:	83 ec 0c             	sub    $0xc,%esp
80102297:	68 d4 73 10 80       	push   $0x801073d4
8010229c:	e8 bf e3 ff ff       	call   80100660 <cprintf>
801022a1:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
801022a7:	83 c4 10             	add    $0x10,%esp
801022aa:	83 c3 21             	add    $0x21,%ebx
{
801022ad:	ba 10 00 00 00       	mov    $0x10,%edx
801022b2:	b8 20 00 00 00       	mov    $0x20,%eax
801022b7:	89 f6                	mov    %esi,%esi
801022b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  ioapic->reg = reg;
801022c0:	89 11                	mov    %edx,(%ecx)
  ioapic->data = data;
801022c2:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
801022c8:	89 c6                	mov    %eax,%esi
801022ca:	81 ce 00 00 01 00    	or     $0x10000,%esi
801022d0:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
801022d3:	89 71 10             	mov    %esi,0x10(%ecx)
801022d6:	8d 72 01             	lea    0x1(%edx),%esi
801022d9:	83 c2 02             	add    $0x2,%edx
  for(i = 0; i <= maxintr; i++){
801022dc:	39 d8                	cmp    %ebx,%eax
  ioapic->reg = reg;
801022de:	89 31                	mov    %esi,(%ecx)
  ioapic->data = data;
801022e0:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
801022e6:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
  for(i = 0; i <= maxintr; i++){
801022ed:	75 d1                	jne    801022c0 <ioapicinit+0x70>
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
801022ef:	8d 65 f8             	lea    -0x8(%ebp),%esp
801022f2:	5b                   	pop    %ebx
801022f3:	5e                   	pop    %esi
801022f4:	5d                   	pop    %ebp
801022f5:	c3                   	ret    
801022f6:	8d 76 00             	lea    0x0(%esi),%esi
801022f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102300 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
80102300:	55                   	push   %ebp
  ioapic->reg = reg;
80102301:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
{
80102307:	89 e5                	mov    %esp,%ebp
80102309:	8b 45 08             	mov    0x8(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
8010230c:	8d 50 20             	lea    0x20(%eax),%edx
8010230f:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
  ioapic->reg = reg;
80102313:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80102315:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010231b:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
8010231e:	89 51 10             	mov    %edx,0x10(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80102321:	8b 55 0c             	mov    0xc(%ebp),%edx
  ioapic->reg = reg;
80102324:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80102326:	a1 34 26 11 80       	mov    0x80112634,%eax
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010232b:	c1 e2 18             	shl    $0x18,%edx
  ioapic->data = data;
8010232e:	89 50 10             	mov    %edx,0x10(%eax)
}
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
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
80102340:	55                   	push   %ebp
80102341:	89 e5                	mov    %esp,%ebp
80102343:	53                   	push   %ebx
80102344:	83 ec 04             	sub    $0x4,%esp
80102347:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
8010234a:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
80102350:	75 70                	jne    801023c2 <kfree+0x82>
80102352:	81 fb a8 77 11 80    	cmp    $0x801177a8,%ebx
80102358:	72 68                	jb     801023c2 <kfree+0x82>
8010235a:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80102360:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80102365:	77 5b                	ja     801023c2 <kfree+0x82>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
80102367:	83 ec 04             	sub    $0x4,%esp
8010236a:	68 00 10 00 00       	push   $0x1000
8010236f:	6a 01                	push   $0x1
80102371:	53                   	push   %ebx
80102372:	e8 f9 22 00 00       	call   80104670 <memset>

  if(kmem.use_lock)
80102377:	8b 15 74 26 11 80    	mov    0x80112674,%edx
8010237d:	83 c4 10             	add    $0x10,%esp
80102380:	85 d2                	test   %edx,%edx
80102382:	75 2c                	jne    801023b0 <kfree+0x70>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
80102384:	a1 78 26 11 80       	mov    0x80112678,%eax
80102389:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
8010238b:	a1 74 26 11 80       	mov    0x80112674,%eax
  kmem.freelist = r;
80102390:	89 1d 78 26 11 80    	mov    %ebx,0x80112678
  if(kmem.use_lock)
80102396:	85 c0                	test   %eax,%eax
80102398:	75 06                	jne    801023a0 <kfree+0x60>
    release(&kmem.lock);
}
8010239a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010239d:	c9                   	leave  
8010239e:	c3                   	ret    
8010239f:	90                   	nop
    release(&kmem.lock);
801023a0:	c7 45 08 40 26 11 80 	movl   $0x80112640,0x8(%ebp)
}
801023a7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801023aa:	c9                   	leave  
    release(&kmem.lock);
801023ab:	e9 70 22 00 00       	jmp    80104620 <release>
    acquire(&kmem.lock);
801023b0:	83 ec 0c             	sub    $0xc,%esp
801023b3:	68 40 26 11 80       	push   $0x80112640
801023b8:	e8 a3 21 00 00       	call   80104560 <acquire>
801023bd:	83 c4 10             	add    $0x10,%esp
801023c0:	eb c2                	jmp    80102384 <kfree+0x44>
    panic("kfree");
801023c2:	83 ec 0c             	sub    $0xc,%esp
801023c5:	68 06 74 10 80       	push   $0x80107406
801023ca:	e8 c1 df ff ff       	call   80100390 <panic>
801023cf:	90                   	nop

801023d0 <freerange>:
{
801023d0:	55                   	push   %ebp
801023d1:	89 e5                	mov    %esp,%ebp
801023d3:	56                   	push   %esi
801023d4:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
801023d5:	8b 45 08             	mov    0x8(%ebp),%eax
{
801023d8:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
801023db:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801023e1:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801023e7:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801023ed:	39 de                	cmp    %ebx,%esi
801023ef:	72 23                	jb     80102414 <freerange+0x44>
801023f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
801023f8:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
801023fe:	83 ec 0c             	sub    $0xc,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102401:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102407:	50                   	push   %eax
80102408:	e8 33 ff ff ff       	call   80102340 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010240d:	83 c4 10             	add    $0x10,%esp
80102410:	39 f3                	cmp    %esi,%ebx
80102412:	76 e4                	jbe    801023f8 <freerange+0x28>
}
80102414:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102417:	5b                   	pop    %ebx
80102418:	5e                   	pop    %esi
80102419:	5d                   	pop    %ebp
8010241a:	c3                   	ret    
8010241b:	90                   	nop
8010241c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102420 <kinit1>:
{
80102420:	55                   	push   %ebp
80102421:	89 e5                	mov    %esp,%ebp
80102423:	56                   	push   %esi
80102424:	53                   	push   %ebx
80102425:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
80102428:	83 ec 08             	sub    $0x8,%esp
8010242b:	68 0c 74 10 80       	push   $0x8010740c
80102430:	68 40 26 11 80       	push   $0x80112640
80102435:	e8 e6 1f 00 00       	call   80104420 <initlock>
  p = (char*)PGROUNDUP((uint)vstart);
8010243a:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010243d:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
80102440:	c7 05 74 26 11 80 00 	movl   $0x0,0x80112674
80102447:	00 00 00 
  p = (char*)PGROUNDUP((uint)vstart);
8010244a:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102450:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102456:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010245c:	39 de                	cmp    %ebx,%esi
8010245e:	72 1c                	jb     8010247c <kinit1+0x5c>
    kfree(p);
80102460:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
80102466:	83 ec 0c             	sub    $0xc,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102469:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
8010246f:	50                   	push   %eax
80102470:	e8 cb fe ff ff       	call   80102340 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102475:	83 c4 10             	add    $0x10,%esp
80102478:	39 de                	cmp    %ebx,%esi
8010247a:	73 e4                	jae    80102460 <kinit1+0x40>
}
8010247c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010247f:	5b                   	pop    %ebx
80102480:	5e                   	pop    %esi
80102481:	5d                   	pop    %ebp
80102482:	c3                   	ret    
80102483:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102489:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102490 <kinit2>:
{
80102490:	55                   	push   %ebp
80102491:	89 e5                	mov    %esp,%ebp
80102493:	56                   	push   %esi
80102494:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
80102495:	8b 45 08             	mov    0x8(%ebp),%eax
{
80102498:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
8010249b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801024a1:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801024a7:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801024ad:	39 de                	cmp    %ebx,%esi
801024af:	72 23                	jb     801024d4 <kinit2+0x44>
801024b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
801024b8:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
801024be:	83 ec 0c             	sub    $0xc,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801024c1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801024c7:	50                   	push   %eax
801024c8:	e8 73 fe ff ff       	call   80102340 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801024cd:	83 c4 10             	add    $0x10,%esp
801024d0:	39 de                	cmp    %ebx,%esi
801024d2:	73 e4                	jae    801024b8 <kinit2+0x28>
  kmem.use_lock = 1;
801024d4:	c7 05 74 26 11 80 01 	movl   $0x1,0x80112674
801024db:	00 00 00 
}
801024de:	8d 65 f8             	lea    -0x8(%ebp),%esp
801024e1:	5b                   	pop    %ebx
801024e2:	5e                   	pop    %esi
801024e3:	5d                   	pop    %ebp
801024e4:	c3                   	ret    
801024e5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801024e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801024f0 <kalloc>:
char*
kalloc(void)
{
  struct run *r;

  if(kmem.use_lock)
801024f0:	a1 74 26 11 80       	mov    0x80112674,%eax
801024f5:	85 c0                	test   %eax,%eax
801024f7:	75 1f                	jne    80102518 <kalloc+0x28>
    acquire(&kmem.lock);
  r = kmem.freelist;
801024f9:	a1 78 26 11 80       	mov    0x80112678,%eax
  if(r)
801024fe:	85 c0                	test   %eax,%eax
80102500:	74 0e                	je     80102510 <kalloc+0x20>
    kmem.freelist = r->next;
80102502:	8b 10                	mov    (%eax),%edx
80102504:	89 15 78 26 11 80    	mov    %edx,0x80112678
8010250a:	c3                   	ret    
8010250b:	90                   	nop
8010250c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(kmem.use_lock)
    release(&kmem.lock);
  return (char*)r;
}
80102510:	f3 c3                	repz ret 
80102512:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
{
80102518:	55                   	push   %ebp
80102519:	89 e5                	mov    %esp,%ebp
8010251b:	83 ec 24             	sub    $0x24,%esp
    acquire(&kmem.lock);
8010251e:	68 40 26 11 80       	push   $0x80112640
80102523:	e8 38 20 00 00       	call   80104560 <acquire>
  r = kmem.freelist;
80102528:	a1 78 26 11 80       	mov    0x80112678,%eax
  if(r)
8010252d:	83 c4 10             	add    $0x10,%esp
80102530:	8b 15 74 26 11 80    	mov    0x80112674,%edx
80102536:	85 c0                	test   %eax,%eax
80102538:	74 08                	je     80102542 <kalloc+0x52>
    kmem.freelist = r->next;
8010253a:	8b 08                	mov    (%eax),%ecx
8010253c:	89 0d 78 26 11 80    	mov    %ecx,0x80112678
  if(kmem.use_lock)
80102542:	85 d2                	test   %edx,%edx
80102544:	74 16                	je     8010255c <kalloc+0x6c>
    release(&kmem.lock);
80102546:	83 ec 0c             	sub    $0xc,%esp
80102549:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010254c:	68 40 26 11 80       	push   $0x80112640
80102551:	e8 ca 20 00 00       	call   80104620 <release>
  return (char*)r;
80102556:	8b 45 f4             	mov    -0xc(%ebp),%eax
    release(&kmem.lock);
80102559:	83 c4 10             	add    $0x10,%esp
}
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
801025a3:	0f b6 82 40 75 10 80 	movzbl -0x7fef8ac0(%edx),%eax
801025aa:	09 c1                	or     %eax,%ecx
  shift ^= togglecode[data];
801025ac:	0f b6 82 40 74 10 80 	movzbl -0x7fef8bc0(%edx),%eax
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
801025c3:	8b 04 85 20 74 10 80 	mov    -0x7fef8be0(,%eax,4),%eax
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
801025e8:	0f b6 82 40 75 10 80 	movzbl -0x7fef8ac0(%edx),%eax
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
80102967:	e8 54 1d 00 00       	call   801046c0 <memcmp>
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
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102a30:	8b 0d c8 26 11 80    	mov    0x801126c8,%ecx
80102a36:	85 c9                	test   %ecx,%ecx
80102a38:	0f 8e 8a 00 00 00    	jle    80102ac8 <install_trans+0x98>
{
80102a3e:	55                   	push   %ebp
80102a3f:	89 e5                	mov    %esp,%ebp
80102a41:	57                   	push   %edi
80102a42:	56                   	push   %esi
80102a43:	53                   	push   %ebx
  for (tail = 0; tail < log.lh.n; tail++) {
80102a44:	31 db                	xor    %ebx,%ebx
{
80102a46:	83 ec 0c             	sub    $0xc,%esp
80102a49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80102a50:	a1 b4 26 11 80       	mov    0x801126b4,%eax
80102a55:	83 ec 08             	sub    $0x8,%esp
80102a58:	01 d8                	add    %ebx,%eax
80102a5a:	83 c0 01             	add    $0x1,%eax
80102a5d:	50                   	push   %eax
80102a5e:	ff 35 c4 26 11 80    	pushl  0x801126c4
80102a64:	e8 67 d6 ff ff       	call   801000d0 <bread>
80102a69:	89 c7                	mov    %eax,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102a6b:	58                   	pop    %eax
80102a6c:	5a                   	pop    %edx
80102a6d:	ff 34 9d cc 26 11 80 	pushl  -0x7feed934(,%ebx,4)
80102a74:	ff 35 c4 26 11 80    	pushl  0x801126c4
  for (tail = 0; tail < log.lh.n; tail++) {
80102a7a:	83 c3 01             	add    $0x1,%ebx
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102a7d:	e8 4e d6 ff ff       	call   801000d0 <bread>
80102a82:	89 c6                	mov    %eax,%esi
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102a84:	8d 47 5c             	lea    0x5c(%edi),%eax
80102a87:	83 c4 0c             	add    $0xc,%esp
80102a8a:	68 00 02 00 00       	push   $0x200
80102a8f:	50                   	push   %eax
80102a90:	8d 46 5c             	lea    0x5c(%esi),%eax
80102a93:	50                   	push   %eax
80102a94:	e8 87 1c 00 00       	call   80104720 <memmove>
    bwrite(dbuf);  // write dst to disk
80102a99:	89 34 24             	mov    %esi,(%esp)
80102a9c:	e8 ff d6 ff ff       	call   801001a0 <bwrite>
    brelse(lbuf);
80102aa1:	89 3c 24             	mov    %edi,(%esp)
80102aa4:	e8 37 d7 ff ff       	call   801001e0 <brelse>
    brelse(dbuf);
80102aa9:	89 34 24             	mov    %esi,(%esp)
80102aac:	e8 2f d7 ff ff       	call   801001e0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102ab1:	83 c4 10             	add    $0x10,%esp
80102ab4:	39 1d c8 26 11 80    	cmp    %ebx,0x801126c8
80102aba:	7f 94                	jg     80102a50 <install_trans+0x20>
  }
}
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
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80102ad0:	55                   	push   %ebp
80102ad1:	89 e5                	mov    %esp,%ebp
80102ad3:	56                   	push   %esi
80102ad4:	53                   	push   %ebx
  struct buf *buf = bread(log.dev, log.start);
80102ad5:	83 ec 08             	sub    $0x8,%esp
80102ad8:	ff 35 b4 26 11 80    	pushl  0x801126b4
80102ade:	ff 35 c4 26 11 80    	pushl  0x801126c4
80102ae4:	e8 e7 d5 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80102ae9:	8b 1d c8 26 11 80    	mov    0x801126c8,%ebx
  for (i = 0; i < log.lh.n; i++) {
80102aef:	83 c4 10             	add    $0x10,%esp
  struct buf *buf = bread(log.dev, log.start);
80102af2:	89 c6                	mov    %eax,%esi
  for (i = 0; i < log.lh.n; i++) {
80102af4:	85 db                	test   %ebx,%ebx
  hb->n = log.lh.n;
80102af6:	89 58 5c             	mov    %ebx,0x5c(%eax)
  for (i = 0; i < log.lh.n; i++) {
80102af9:	7e 16                	jle    80102b11 <write_head+0x41>
80102afb:	c1 e3 02             	shl    $0x2,%ebx
80102afe:	31 d2                	xor    %edx,%edx
    hb->block[i] = log.lh.block[i];
80102b00:	8b 8a cc 26 11 80    	mov    -0x7feed934(%edx),%ecx
80102b06:	89 4c 16 60          	mov    %ecx,0x60(%esi,%edx,1)
80102b0a:	83 c2 04             	add    $0x4,%edx
  for (i = 0; i < log.lh.n; i++) {
80102b0d:	39 da                	cmp    %ebx,%edx
80102b0f:	75 ef                	jne    80102b00 <write_head+0x30>
  }
  bwrite(buf);
80102b11:	83 ec 0c             	sub    $0xc,%esp
80102b14:	56                   	push   %esi
80102b15:	e8 86 d6 ff ff       	call   801001a0 <bwrite>
  brelse(buf);
80102b1a:	89 34 24             	mov    %esi,(%esp)
80102b1d:	e8 be d6 ff ff       	call   801001e0 <brelse>
}
80102b22:	83 c4 10             	add    $0x10,%esp
80102b25:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102b28:	5b                   	pop    %ebx
80102b29:	5e                   	pop    %esi
80102b2a:	5d                   	pop    %ebp
80102b2b:	c3                   	ret    
80102b2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102b30 <initlog>:
{
80102b30:	55                   	push   %ebp
80102b31:	89 e5                	mov    %esp,%ebp
80102b33:	53                   	push   %ebx
80102b34:	83 ec 2c             	sub    $0x2c,%esp
80102b37:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
80102b3a:	68 40 76 10 80       	push   $0x80107640
80102b3f:	68 80 26 11 80       	push   $0x80112680
80102b44:	e8 d7 18 00 00       	call   80104420 <initlock>
  readsb(dev, &sb);
80102b49:	58                   	pop    %eax
80102b4a:	8d 45 dc             	lea    -0x24(%ebp),%eax
80102b4d:	5a                   	pop    %edx
80102b4e:	50                   	push   %eax
80102b4f:	53                   	push   %ebx
80102b50:	e8 1b e9 ff ff       	call   80101470 <readsb>
  log.size = sb.nlog;
80102b55:	8b 55 e8             	mov    -0x18(%ebp),%edx
  log.start = sb.logstart;
80102b58:	8b 45 ec             	mov    -0x14(%ebp),%eax
  struct buf *buf = bread(log.dev, log.start);
80102b5b:	59                   	pop    %ecx
  log.dev = dev;
80102b5c:	89 1d c4 26 11 80    	mov    %ebx,0x801126c4
  log.size = sb.nlog;
80102b62:	89 15 b8 26 11 80    	mov    %edx,0x801126b8
  log.start = sb.logstart;
80102b68:	a3 b4 26 11 80       	mov    %eax,0x801126b4
  struct buf *buf = bread(log.dev, log.start);
80102b6d:	5a                   	pop    %edx
80102b6e:	50                   	push   %eax
80102b6f:	53                   	push   %ebx
80102b70:	e8 5b d5 ff ff       	call   801000d0 <bread>
  log.lh.n = lh->n;
80102b75:	8b 58 5c             	mov    0x5c(%eax),%ebx
  for (i = 0; i < log.lh.n; i++) {
80102b78:	83 c4 10             	add    $0x10,%esp
80102b7b:	85 db                	test   %ebx,%ebx
  log.lh.n = lh->n;
80102b7d:	89 1d c8 26 11 80    	mov    %ebx,0x801126c8
  for (i = 0; i < log.lh.n; i++) {
80102b83:	7e 1c                	jle    80102ba1 <initlog+0x71>
80102b85:	c1 e3 02             	shl    $0x2,%ebx
80102b88:	31 d2                	xor    %edx,%edx
80102b8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    log.lh.block[i] = lh->block[i];
80102b90:	8b 4c 10 60          	mov    0x60(%eax,%edx,1),%ecx
80102b94:	83 c2 04             	add    $0x4,%edx
80102b97:	89 8a c8 26 11 80    	mov    %ecx,-0x7feed938(%edx)
  for (i = 0; i < log.lh.n; i++) {
80102b9d:	39 d3                	cmp    %edx,%ebx
80102b9f:	75 ef                	jne    80102b90 <initlog+0x60>
  brelse(buf);
80102ba1:	83 ec 0c             	sub    $0xc,%esp
80102ba4:	50                   	push   %eax
80102ba5:	e8 36 d6 ff ff       	call   801001e0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
80102baa:	e8 81 fe ff ff       	call   80102a30 <install_trans>
  log.lh.n = 0;
80102baf:	c7 05 c8 26 11 80 00 	movl   $0x0,0x801126c8
80102bb6:	00 00 00 
  write_head(); // clear the log
80102bb9:	e8 12 ff ff ff       	call   80102ad0 <write_head>
}
80102bbe:	83 c4 10             	add    $0x10,%esp
80102bc1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102bc4:	c9                   	leave  
80102bc5:	c3                   	ret    
80102bc6:	8d 76 00             	lea    0x0(%esi),%esi
80102bc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102bd0 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80102bd0:	55                   	push   %ebp
80102bd1:	89 e5                	mov    %esp,%ebp
80102bd3:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
80102bd6:	68 80 26 11 80       	push   $0x80112680
80102bdb:	e8 80 19 00 00       	call   80104560 <acquire>
80102be0:	83 c4 10             	add    $0x10,%esp
80102be3:	eb 18                	jmp    80102bfd <begin_op+0x2d>
80102be5:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102be8:	83 ec 08             	sub    $0x8,%esp
80102beb:	68 80 26 11 80       	push   $0x80112680
80102bf0:	68 80 26 11 80       	push   $0x80112680
80102bf5:	e8 76 12 00 00       	call   80103e70 <sleep>
80102bfa:	83 c4 10             	add    $0x10,%esp
    if(log.committing){
80102bfd:	a1 c0 26 11 80       	mov    0x801126c0,%eax
80102c02:	85 c0                	test   %eax,%eax
80102c04:	75 e2                	jne    80102be8 <begin_op+0x18>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80102c06:	a1 bc 26 11 80       	mov    0x801126bc,%eax
80102c0b:	8b 15 c8 26 11 80    	mov    0x801126c8,%edx
80102c11:	83 c0 01             	add    $0x1,%eax
80102c14:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80102c17:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80102c1a:	83 fa 1e             	cmp    $0x1e,%edx
80102c1d:	7f c9                	jg     80102be8 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
80102c1f:	83 ec 0c             	sub    $0xc,%esp
      log.outstanding += 1;
80102c22:	a3 bc 26 11 80       	mov    %eax,0x801126bc
      release(&log.lock);
80102c27:	68 80 26 11 80       	push   $0x80112680
80102c2c:	e8 ef 19 00 00       	call   80104620 <release>
      break;
    }
  }
}
80102c31:	83 c4 10             	add    $0x10,%esp
80102c34:	c9                   	leave  
80102c35:	c3                   	ret    
80102c36:	8d 76 00             	lea    0x0(%esi),%esi
80102c39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102c40 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80102c40:	55                   	push   %ebp
80102c41:	89 e5                	mov    %esp,%ebp
80102c43:	57                   	push   %edi
80102c44:	56                   	push   %esi
80102c45:	53                   	push   %ebx
80102c46:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
80102c49:	68 80 26 11 80       	push   $0x80112680
80102c4e:	e8 0d 19 00 00       	call   80104560 <acquire>
  log.outstanding -= 1;
80102c53:	a1 bc 26 11 80       	mov    0x801126bc,%eax
  if(log.committing)
80102c58:	8b 35 c0 26 11 80    	mov    0x801126c0,%esi
80102c5e:	83 c4 10             	add    $0x10,%esp
  log.outstanding -= 1;
80102c61:	8d 58 ff             	lea    -0x1(%eax),%ebx
  if(log.committing)
80102c64:	85 f6                	test   %esi,%esi
  log.outstanding -= 1;
80102c66:	89 1d bc 26 11 80    	mov    %ebx,0x801126bc
  if(log.committing)
80102c6c:	0f 85 1a 01 00 00    	jne    80102d8c <end_op+0x14c>
    panic("log.committing");
  if(log.outstanding == 0){
80102c72:	85 db                	test   %ebx,%ebx
80102c74:	0f 85 ee 00 00 00    	jne    80102d68 <end_op+0x128>
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80102c7a:	83 ec 0c             	sub    $0xc,%esp
    log.committing = 1;
80102c7d:	c7 05 c0 26 11 80 01 	movl   $0x1,0x801126c0
80102c84:	00 00 00 
  release(&log.lock);
80102c87:	68 80 26 11 80       	push   $0x80112680
80102c8c:	e8 8f 19 00 00       	call   80104620 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80102c91:	8b 0d c8 26 11 80    	mov    0x801126c8,%ecx
80102c97:	83 c4 10             	add    $0x10,%esp
80102c9a:	85 c9                	test   %ecx,%ecx
80102c9c:	0f 8e 85 00 00 00    	jle    80102d27 <end_op+0xe7>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80102ca2:	a1 b4 26 11 80       	mov    0x801126b4,%eax
80102ca7:	83 ec 08             	sub    $0x8,%esp
80102caa:	01 d8                	add    %ebx,%eax
80102cac:	83 c0 01             	add    $0x1,%eax
80102caf:	50                   	push   %eax
80102cb0:	ff 35 c4 26 11 80    	pushl  0x801126c4
80102cb6:	e8 15 d4 ff ff       	call   801000d0 <bread>
80102cbb:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102cbd:	58                   	pop    %eax
80102cbe:	5a                   	pop    %edx
80102cbf:	ff 34 9d cc 26 11 80 	pushl  -0x7feed934(,%ebx,4)
80102cc6:	ff 35 c4 26 11 80    	pushl  0x801126c4
  for (tail = 0; tail < log.lh.n; tail++) {
80102ccc:	83 c3 01             	add    $0x1,%ebx
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102ccf:	e8 fc d3 ff ff       	call   801000d0 <bread>
80102cd4:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80102cd6:	8d 40 5c             	lea    0x5c(%eax),%eax
80102cd9:	83 c4 0c             	add    $0xc,%esp
80102cdc:	68 00 02 00 00       	push   $0x200
80102ce1:	50                   	push   %eax
80102ce2:	8d 46 5c             	lea    0x5c(%esi),%eax
80102ce5:	50                   	push   %eax
80102ce6:	e8 35 1a 00 00       	call   80104720 <memmove>
    bwrite(to);  // write the log
80102ceb:	89 34 24             	mov    %esi,(%esp)
80102cee:	e8 ad d4 ff ff       	call   801001a0 <bwrite>
    brelse(from);
80102cf3:	89 3c 24             	mov    %edi,(%esp)
80102cf6:	e8 e5 d4 ff ff       	call   801001e0 <brelse>
    brelse(to);
80102cfb:	89 34 24             	mov    %esi,(%esp)
80102cfe:	e8 dd d4 ff ff       	call   801001e0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102d03:	83 c4 10             	add    $0x10,%esp
80102d06:	3b 1d c8 26 11 80    	cmp    0x801126c8,%ebx
80102d0c:	7c 94                	jl     80102ca2 <end_op+0x62>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
80102d0e:	e8 bd fd ff ff       	call   80102ad0 <write_head>
    install_trans(); // Now install writes to home locations
80102d13:	e8 18 fd ff ff       	call   80102a30 <install_trans>
    log.lh.n = 0;
80102d18:	c7 05 c8 26 11 80 00 	movl   $0x0,0x801126c8
80102d1f:	00 00 00 
    write_head();    // Erase the transaction from the log
80102d22:	e8 a9 fd ff ff       	call   80102ad0 <write_head>
    acquire(&log.lock);
80102d27:	83 ec 0c             	sub    $0xc,%esp
80102d2a:	68 80 26 11 80       	push   $0x80112680
80102d2f:	e8 2c 18 00 00       	call   80104560 <acquire>
    wakeup(&log);
80102d34:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
    log.committing = 0;
80102d3b:	c7 05 c0 26 11 80 00 	movl   $0x0,0x801126c0
80102d42:	00 00 00 
    wakeup(&log);
80102d45:	e8 e6 12 00 00       	call   80104030 <wakeup>
    release(&log.lock);
80102d4a:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
80102d51:	e8 ca 18 00 00       	call   80104620 <release>
80102d56:	83 c4 10             	add    $0x10,%esp
}
80102d59:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102d5c:	5b                   	pop    %ebx
80102d5d:	5e                   	pop    %esi
80102d5e:	5f                   	pop    %edi
80102d5f:	5d                   	pop    %ebp
80102d60:	c3                   	ret    
80102d61:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    wakeup(&log);
80102d68:	83 ec 0c             	sub    $0xc,%esp
80102d6b:	68 80 26 11 80       	push   $0x80112680
80102d70:	e8 bb 12 00 00       	call   80104030 <wakeup>
  release(&log.lock);
80102d75:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
80102d7c:	e8 9f 18 00 00       	call   80104620 <release>
80102d81:	83 c4 10             	add    $0x10,%esp
}
80102d84:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102d87:	5b                   	pop    %ebx
80102d88:	5e                   	pop    %esi
80102d89:	5f                   	pop    %edi
80102d8a:	5d                   	pop    %ebp
80102d8b:	c3                   	ret    
    panic("log.committing");
80102d8c:	83 ec 0c             	sub    $0xc,%esp
80102d8f:	68 44 76 10 80       	push   $0x80107644
80102d94:	e8 f7 d5 ff ff       	call   80100390 <panic>
80102d99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102da0 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102da0:	55                   	push   %ebp
80102da1:	89 e5                	mov    %esp,%ebp
80102da3:	53                   	push   %ebx
80102da4:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102da7:	8b 15 c8 26 11 80    	mov    0x801126c8,%edx
{
80102dad:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102db0:	83 fa 1d             	cmp    $0x1d,%edx
80102db3:	0f 8f 9d 00 00 00    	jg     80102e56 <log_write+0xb6>
80102db9:	a1 b8 26 11 80       	mov    0x801126b8,%eax
80102dbe:	83 e8 01             	sub    $0x1,%eax
80102dc1:	39 c2                	cmp    %eax,%edx
80102dc3:	0f 8d 8d 00 00 00    	jge    80102e56 <log_write+0xb6>
    panic("too big a transaction");
  if (log.outstanding < 1)
80102dc9:	a1 bc 26 11 80       	mov    0x801126bc,%eax
80102dce:	85 c0                	test   %eax,%eax
80102dd0:	0f 8e 8d 00 00 00    	jle    80102e63 <log_write+0xc3>
    panic("log_write outside of trans");

  acquire(&log.lock);
80102dd6:	83 ec 0c             	sub    $0xc,%esp
80102dd9:	68 80 26 11 80       	push   $0x80112680
80102dde:	e8 7d 17 00 00       	call   80104560 <acquire>
  for (i = 0; i < log.lh.n; i++) {
80102de3:	8b 0d c8 26 11 80    	mov    0x801126c8,%ecx
80102de9:	83 c4 10             	add    $0x10,%esp
80102dec:	83 f9 00             	cmp    $0x0,%ecx
80102def:	7e 57                	jle    80102e48 <log_write+0xa8>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102df1:	8b 53 08             	mov    0x8(%ebx),%edx
  for (i = 0; i < log.lh.n; i++) {
80102df4:	31 c0                	xor    %eax,%eax
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102df6:	3b 15 cc 26 11 80    	cmp    0x801126cc,%edx
80102dfc:	75 0b                	jne    80102e09 <log_write+0x69>
80102dfe:	eb 38                	jmp    80102e38 <log_write+0x98>
80102e00:	39 14 85 cc 26 11 80 	cmp    %edx,-0x7feed934(,%eax,4)
80102e07:	74 2f                	je     80102e38 <log_write+0x98>
  for (i = 0; i < log.lh.n; i++) {
80102e09:	83 c0 01             	add    $0x1,%eax
80102e0c:	39 c1                	cmp    %eax,%ecx
80102e0e:	75 f0                	jne    80102e00 <log_write+0x60>
      break;
  }
  log.lh.block[i] = b->blockno;
80102e10:	89 14 85 cc 26 11 80 	mov    %edx,-0x7feed934(,%eax,4)
  if (i == log.lh.n)
    log.lh.n++;
80102e17:	83 c0 01             	add    $0x1,%eax
80102e1a:	a3 c8 26 11 80       	mov    %eax,0x801126c8
  b->flags |= B_DIRTY; // prevent eviction
80102e1f:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
80102e22:	c7 45 08 80 26 11 80 	movl   $0x80112680,0x8(%ebp)
}
80102e29:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102e2c:	c9                   	leave  
  release(&log.lock);
80102e2d:	e9 ee 17 00 00       	jmp    80104620 <release>
80102e32:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  log.lh.block[i] = b->blockno;
80102e38:	89 14 85 cc 26 11 80 	mov    %edx,-0x7feed934(,%eax,4)
80102e3f:	eb de                	jmp    80102e1f <log_write+0x7f>
80102e41:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102e48:	8b 43 08             	mov    0x8(%ebx),%eax
80102e4b:	a3 cc 26 11 80       	mov    %eax,0x801126cc
  if (i == log.lh.n)
80102e50:	75 cd                	jne    80102e1f <log_write+0x7f>
80102e52:	31 c0                	xor    %eax,%eax
80102e54:	eb c1                	jmp    80102e17 <log_write+0x77>
    panic("too big a transaction");
80102e56:	83 ec 0c             	sub    $0xc,%esp
80102e59:	68 53 76 10 80       	push   $0x80107653
80102e5e:	e8 2d d5 ff ff       	call   80100390 <panic>
    panic("log_write outside of trans");
80102e63:	83 ec 0c             	sub    $0xc,%esp
80102e66:	68 69 76 10 80       	push   $0x80107669
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
80102e77:	e8 a4 08 00 00       	call   80103720 <cpuid>
80102e7c:	89 c3                	mov    %eax,%ebx
80102e7e:	e8 9d 08 00 00       	call   80103720 <cpuid>
80102e83:	83 ec 04             	sub    $0x4,%esp
80102e86:	53                   	push   %ebx
80102e87:	50                   	push   %eax
80102e88:	68 84 76 10 80       	push   $0x80107684
80102e8d:	e8 ce d7 ff ff       	call   80100660 <cprintf>
  idtinit();       // load idt register
80102e92:	e8 29 2b 00 00       	call   801059c0 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
80102e97:	e8 04 08 00 00       	call   801036a0 <mycpu>
80102e9c:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80102e9e:	b8 01 00 00 00       	mov    $0x1,%eax
80102ea3:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
80102eaa:	e8 e1 0c 00 00       	call   80103b90 <scheduler>
80102eaf:	90                   	nop

80102eb0 <mpenter>:
{
80102eb0:	55                   	push   %ebp
80102eb1:	89 e5                	mov    %esp,%ebp
80102eb3:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80102eb6:	e8 f5 3b 00 00       	call   80106ab0 <switchkvm>
  seginit();
80102ebb:	e8 60 3b 00 00       	call   80106a20 <seginit>
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
80102ee7:	68 a8 77 11 80       	push   $0x801177a8
80102eec:	e8 2f f5 ff ff       	call   80102420 <kinit1>
  kvmalloc();      // kernel page table
80102ef1:	e8 8a 40 00 00       	call   80106f80 <kvmalloc>
  mpinit();        // detect other processors
80102ef6:	e8 75 01 00 00       	call   80103070 <mpinit>
  lapicinit();     // interrupt controller
80102efb:	e8 60 f7 ff ff       	call   80102660 <lapicinit>
  seginit();       // segment descriptors
80102f00:	e8 1b 3b 00 00       	call   80106a20 <seginit>
  picinit();       // disable pic
80102f05:	e8 46 03 00 00       	call   80103250 <picinit>
  ioapicinit();    // another interrupt controller
80102f0a:	e8 41 f3 ff ff       	call   80102250 <ioapicinit>
  consoleinit();   // console hardware
80102f0f:	e8 ac da ff ff       	call   801009c0 <consoleinit>
  uartinit();      // serial port
80102f14:	e8 d7 2d 00 00       	call   80105cf0 <uartinit>
  pinit();         // process table
80102f19:	e8 62 07 00 00       	call   80103680 <pinit>
  tvinit();        // trap vectors
80102f1e:	e8 1d 2a 00 00       	call   80105940 <tvinit>
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
80102f44:	e8 d7 17 00 00       	call   80104720 <memmove>

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
80102f70:	e8 2b 07 00 00       	call   801036a0 <mycpu>
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
80102fe5:	e8 96 08 00 00       	call   80103880 <userinit>
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
8010301e:	68 98 76 10 80       	push   $0x80107698
80103023:	56                   	push   %esi
80103024:	e8 97 16 00 00       	call   801046c0 <memcmp>
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
801030dc:	68 b5 76 10 80       	push   $0x801076b5
801030e1:	56                   	push   %esi
801030e2:	e8 d9 15 00 00       	call   801046c0 <memcmp>
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
80103170:	ff 24 95 dc 76 10 80 	jmp    *-0x7fef8924(,%edx,4)
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
80103223:	68 9d 76 10 80       	push   $0x8010769d
80103228:	e8 63 d1 ff ff       	call   80100390 <panic>
    panic("Didn't find a suitable machine");
8010322d:	83 ec 0c             	sub    $0xc,%esp
80103230:	68 bc 76 10 80       	push   $0x801076bc
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
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80103270:	55                   	push   %ebp
80103271:	89 e5                	mov    %esp,%ebp
80103273:	57                   	push   %edi
80103274:	56                   	push   %esi
80103275:	53                   	push   %ebx
80103276:	83 ec 0c             	sub    $0xc,%esp
80103279:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010327c:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
8010327f:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80103285:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
8010328b:	e8 20 db ff ff       	call   80100db0 <filealloc>
80103290:	85 c0                	test   %eax,%eax
80103292:	89 03                	mov    %eax,(%ebx)
80103294:	74 22                	je     801032b8 <pipealloc+0x48>
80103296:	e8 15 db ff ff       	call   80100db0 <filealloc>
8010329b:	85 c0                	test   %eax,%eax
8010329d:	89 06                	mov    %eax,(%esi)
8010329f:	74 3f                	je     801032e0 <pipealloc+0x70>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
801032a1:	e8 4a f2 ff ff       	call   801024f0 <kalloc>
801032a6:	85 c0                	test   %eax,%eax
801032a8:	89 c7                	mov    %eax,%edi
801032aa:	75 54                	jne    80103300 <pipealloc+0x90>

//PAGEBREAK: 20
 bad:
  if(p)
    kfree((char*)p);
  if(*f0)
801032ac:	8b 03                	mov    (%ebx),%eax
801032ae:	85 c0                	test   %eax,%eax
801032b0:	75 34                	jne    801032e6 <pipealloc+0x76>
801032b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    fileclose(*f0);
  if(*f1)
801032b8:	8b 06                	mov    (%esi),%eax
801032ba:	85 c0                	test   %eax,%eax
801032bc:	74 0c                	je     801032ca <pipealloc+0x5a>
    fileclose(*f1);
801032be:	83 ec 0c             	sub    $0xc,%esp
801032c1:	50                   	push   %eax
801032c2:	e8 a9 db ff ff       	call   80100e70 <fileclose>
801032c7:	83 c4 10             	add    $0x10,%esp
  return -1;
}
801032ca:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
801032cd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801032d2:	5b                   	pop    %ebx
801032d3:	5e                   	pop    %esi
801032d4:	5f                   	pop    %edi
801032d5:	5d                   	pop    %ebp
801032d6:	c3                   	ret    
801032d7:	89 f6                	mov    %esi,%esi
801032d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  if(*f0)
801032e0:	8b 03                	mov    (%ebx),%eax
801032e2:	85 c0                	test   %eax,%eax
801032e4:	74 e4                	je     801032ca <pipealloc+0x5a>
    fileclose(*f0);
801032e6:	83 ec 0c             	sub    $0xc,%esp
801032e9:	50                   	push   %eax
801032ea:	e8 81 db ff ff       	call   80100e70 <fileclose>
  if(*f1)
801032ef:	8b 06                	mov    (%esi),%eax
    fileclose(*f0);
801032f1:	83 c4 10             	add    $0x10,%esp
  if(*f1)
801032f4:	85 c0                	test   %eax,%eax
801032f6:	75 c6                	jne    801032be <pipealloc+0x4e>
801032f8:	eb d0                	jmp    801032ca <pipealloc+0x5a>
801032fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  initlock(&p->lock, "pipe");
80103300:	83 ec 08             	sub    $0x8,%esp
  p->readopen = 1;
80103303:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
8010330a:	00 00 00 
  p->writeopen = 1;
8010330d:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
80103314:	00 00 00 
  p->nwrite = 0;
80103317:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
8010331e:	00 00 00 
  p->nread = 0;
80103321:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80103328:	00 00 00 
  initlock(&p->lock, "pipe");
8010332b:	68 f0 76 10 80       	push   $0x801076f0
80103330:	50                   	push   %eax
80103331:	e8 ea 10 00 00       	call   80104420 <initlock>
  (*f0)->type = FD_PIPE;
80103336:	8b 03                	mov    (%ebx),%eax
  return 0;
80103338:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
8010333b:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
80103341:	8b 03                	mov    (%ebx),%eax
80103343:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
80103347:	8b 03                	mov    (%ebx),%eax
80103349:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
8010334d:	8b 03                	mov    (%ebx),%eax
8010334f:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
80103352:	8b 06                	mov    (%esi),%eax
80103354:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
8010335a:	8b 06                	mov    (%esi),%eax
8010335c:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
80103360:	8b 06                	mov    (%esi),%eax
80103362:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
80103366:	8b 06                	mov    (%esi),%eax
80103368:	89 78 0c             	mov    %edi,0xc(%eax)
}
8010336b:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010336e:	31 c0                	xor    %eax,%eax
}
80103370:	5b                   	pop    %ebx
80103371:	5e                   	pop    %esi
80103372:	5f                   	pop    %edi
80103373:	5d                   	pop    %ebp
80103374:	c3                   	ret    
80103375:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103379:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103380 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
80103380:	55                   	push   %ebp
80103381:	89 e5                	mov    %esp,%ebp
80103383:	56                   	push   %esi
80103384:	53                   	push   %ebx
80103385:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103388:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
8010338b:	83 ec 0c             	sub    $0xc,%esp
8010338e:	53                   	push   %ebx
8010338f:	e8 cc 11 00 00       	call   80104560 <acquire>
  if(writable){
80103394:	83 c4 10             	add    $0x10,%esp
80103397:	85 f6                	test   %esi,%esi
80103399:	74 45                	je     801033e0 <pipeclose+0x60>
    p->writeopen = 0;
    wakeup(&p->nread);
8010339b:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
801033a1:	83 ec 0c             	sub    $0xc,%esp
    p->writeopen = 0;
801033a4:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
801033ab:	00 00 00 
    wakeup(&p->nread);
801033ae:	50                   	push   %eax
801033af:	e8 7c 0c 00 00       	call   80104030 <wakeup>
801033b4:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
801033b7:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
801033bd:	85 d2                	test   %edx,%edx
801033bf:	75 0a                	jne    801033cb <pipeclose+0x4b>
801033c1:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
801033c7:	85 c0                	test   %eax,%eax
801033c9:	74 35                	je     80103400 <pipeclose+0x80>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
801033cb:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801033ce:	8d 65 f8             	lea    -0x8(%ebp),%esp
801033d1:	5b                   	pop    %ebx
801033d2:	5e                   	pop    %esi
801033d3:	5d                   	pop    %ebp
    release(&p->lock);
801033d4:	e9 47 12 00 00       	jmp    80104620 <release>
801033d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    wakeup(&p->nwrite);
801033e0:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
801033e6:	83 ec 0c             	sub    $0xc,%esp
    p->readopen = 0;
801033e9:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
801033f0:	00 00 00 
    wakeup(&p->nwrite);
801033f3:	50                   	push   %eax
801033f4:	e8 37 0c 00 00       	call   80104030 <wakeup>
801033f9:	83 c4 10             	add    $0x10,%esp
801033fc:	eb b9                	jmp    801033b7 <pipeclose+0x37>
801033fe:	66 90                	xchg   %ax,%ax
    release(&p->lock);
80103400:	83 ec 0c             	sub    $0xc,%esp
80103403:	53                   	push   %ebx
80103404:	e8 17 12 00 00       	call   80104620 <release>
    kfree((char*)p);
80103409:	89 5d 08             	mov    %ebx,0x8(%ebp)
8010340c:	83 c4 10             	add    $0x10,%esp
}
8010340f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103412:	5b                   	pop    %ebx
80103413:	5e                   	pop    %esi
80103414:	5d                   	pop    %ebp
    kfree((char*)p);
80103415:	e9 26 ef ff ff       	jmp    80102340 <kfree>
8010341a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103420 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
80103420:	55                   	push   %ebp
80103421:	89 e5                	mov    %esp,%ebp
80103423:	57                   	push   %edi
80103424:	56                   	push   %esi
80103425:	53                   	push   %ebx
80103426:	83 ec 28             	sub    $0x28,%esp
80103429:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  acquire(&p->lock);
8010342c:	53                   	push   %ebx
8010342d:	e8 2e 11 00 00       	call   80104560 <acquire>
  for(i = 0; i < n; i++){
80103432:	8b 45 10             	mov    0x10(%ebp),%eax
80103435:	83 c4 10             	add    $0x10,%esp
80103438:	85 c0                	test   %eax,%eax
8010343a:	0f 8e c9 00 00 00    	jle    80103509 <pipewrite+0xe9>
80103440:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80103443:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
80103449:	8d bb 34 02 00 00    	lea    0x234(%ebx),%edi
8010344f:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80103452:	03 4d 10             	add    0x10(%ebp),%ecx
80103455:	89 4d e0             	mov    %ecx,-0x20(%ebp)
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103458:	8b 8b 34 02 00 00    	mov    0x234(%ebx),%ecx
8010345e:	8d 91 00 02 00 00    	lea    0x200(%ecx),%edx
80103464:	39 d0                	cmp    %edx,%eax
80103466:	75 71                	jne    801034d9 <pipewrite+0xb9>
      if(p->readopen == 0 || myproc()->killed){
80103468:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
8010346e:	85 c0                	test   %eax,%eax
80103470:	74 4e                	je     801034c0 <pipewrite+0xa0>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103472:	8d b3 38 02 00 00    	lea    0x238(%ebx),%esi
80103478:	eb 3a                	jmp    801034b4 <pipewrite+0x94>
8010347a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      wakeup(&p->nread);
80103480:	83 ec 0c             	sub    $0xc,%esp
80103483:	57                   	push   %edi
80103484:	e8 a7 0b 00 00       	call   80104030 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103489:	5a                   	pop    %edx
8010348a:	59                   	pop    %ecx
8010348b:	53                   	push   %ebx
8010348c:	56                   	push   %esi
8010348d:	e8 de 09 00 00       	call   80103e70 <sleep>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103492:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
80103498:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
8010349e:	83 c4 10             	add    $0x10,%esp
801034a1:	05 00 02 00 00       	add    $0x200,%eax
801034a6:	39 c2                	cmp    %eax,%edx
801034a8:	75 36                	jne    801034e0 <pipewrite+0xc0>
      if(p->readopen == 0 || myproc()->killed){
801034aa:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
801034b0:	85 c0                	test   %eax,%eax
801034b2:	74 0c                	je     801034c0 <pipewrite+0xa0>
801034b4:	e8 87 02 00 00       	call   80103740 <myproc>
801034b9:	8b 40 24             	mov    0x24(%eax),%eax
801034bc:	85 c0                	test   %eax,%eax
801034be:	74 c0                	je     80103480 <pipewrite+0x60>
        release(&p->lock);
801034c0:	83 ec 0c             	sub    $0xc,%esp
801034c3:	53                   	push   %ebx
801034c4:	e8 57 11 00 00       	call   80104620 <release>
        return -1;
801034c9:	83 c4 10             	add    $0x10,%esp
801034cc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
801034d1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801034d4:	5b                   	pop    %ebx
801034d5:	5e                   	pop    %esi
801034d6:	5f                   	pop    %edi
801034d7:	5d                   	pop    %ebp
801034d8:	c3                   	ret    
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801034d9:	89 c2                	mov    %eax,%edx
801034db:	90                   	nop
801034dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
801034e0:	8b 75 e4             	mov    -0x1c(%ebp),%esi
801034e3:	8d 42 01             	lea    0x1(%edx),%eax
801034e6:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
801034ec:	89 83 38 02 00 00    	mov    %eax,0x238(%ebx)
801034f2:	83 c6 01             	add    $0x1,%esi
801034f5:	0f b6 4e ff          	movzbl -0x1(%esi),%ecx
  for(i = 0; i < n; i++){
801034f9:	3b 75 e0             	cmp    -0x20(%ebp),%esi
801034fc:	89 75 e4             	mov    %esi,-0x1c(%ebp)
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
801034ff:	88 4c 13 34          	mov    %cl,0x34(%ebx,%edx,1)
  for(i = 0; i < n; i++){
80103503:	0f 85 4f ff ff ff    	jne    80103458 <pipewrite+0x38>
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
80103509:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
8010350f:	83 ec 0c             	sub    $0xc,%esp
80103512:	50                   	push   %eax
80103513:	e8 18 0b 00 00       	call   80104030 <wakeup>
  release(&p->lock);
80103518:	89 1c 24             	mov    %ebx,(%esp)
8010351b:	e8 00 11 00 00       	call   80104620 <release>
  return n;
80103520:	83 c4 10             	add    $0x10,%esp
80103523:	8b 45 10             	mov    0x10(%ebp),%eax
80103526:	eb a9                	jmp    801034d1 <pipewrite+0xb1>
80103528:	90                   	nop
80103529:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103530 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
80103530:	55                   	push   %ebp
80103531:	89 e5                	mov    %esp,%ebp
80103533:	57                   	push   %edi
80103534:	56                   	push   %esi
80103535:	53                   	push   %ebx
80103536:	83 ec 18             	sub    $0x18,%esp
80103539:	8b 75 08             	mov    0x8(%ebp),%esi
8010353c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
8010353f:	56                   	push   %esi
80103540:	e8 1b 10 00 00       	call   80104560 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103545:	83 c4 10             	add    $0x10,%esp
80103548:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
8010354e:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
80103554:	75 6a                	jne    801035c0 <piperead+0x90>
80103556:	8b 9e 40 02 00 00    	mov    0x240(%esi),%ebx
8010355c:	85 db                	test   %ebx,%ebx
8010355e:	0f 84 c4 00 00 00    	je     80103628 <piperead+0xf8>
    if(myproc()->killed){
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
80103564:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
8010356a:	eb 2d                	jmp    80103599 <piperead+0x69>
8010356c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103570:	83 ec 08             	sub    $0x8,%esp
80103573:	56                   	push   %esi
80103574:	53                   	push   %ebx
80103575:	e8 f6 08 00 00       	call   80103e70 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
8010357a:	83 c4 10             	add    $0x10,%esp
8010357d:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
80103583:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
80103589:	75 35                	jne    801035c0 <piperead+0x90>
8010358b:	8b 96 40 02 00 00    	mov    0x240(%esi),%edx
80103591:	85 d2                	test   %edx,%edx
80103593:	0f 84 8f 00 00 00    	je     80103628 <piperead+0xf8>
    if(myproc()->killed){
80103599:	e8 a2 01 00 00       	call   80103740 <myproc>
8010359e:	8b 48 24             	mov    0x24(%eax),%ecx
801035a1:	85 c9                	test   %ecx,%ecx
801035a3:	74 cb                	je     80103570 <piperead+0x40>
      release(&p->lock);
801035a5:	83 ec 0c             	sub    $0xc,%esp
      return -1;
801035a8:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      release(&p->lock);
801035ad:	56                   	push   %esi
801035ae:	e8 6d 10 00 00       	call   80104620 <release>
      return -1;
801035b3:	83 c4 10             	add    $0x10,%esp
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
}
801035b6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801035b9:	89 d8                	mov    %ebx,%eax
801035bb:	5b                   	pop    %ebx
801035bc:	5e                   	pop    %esi
801035bd:	5f                   	pop    %edi
801035be:	5d                   	pop    %ebp
801035bf:	c3                   	ret    
  for(i = 0; i < n; i++){  //DOC: piperead-copy
801035c0:	8b 45 10             	mov    0x10(%ebp),%eax
801035c3:	85 c0                	test   %eax,%eax
801035c5:	7e 61                	jle    80103628 <piperead+0xf8>
    if(p->nread == p->nwrite)
801035c7:	31 db                	xor    %ebx,%ebx
801035c9:	eb 13                	jmp    801035de <piperead+0xae>
801035cb:	90                   	nop
801035cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801035d0:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
801035d6:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
801035dc:	74 1f                	je     801035fd <piperead+0xcd>
    addr[i] = p->data[p->nread++ % PIPESIZE];
801035de:	8d 41 01             	lea    0x1(%ecx),%eax
801035e1:	81 e1 ff 01 00 00    	and    $0x1ff,%ecx
801035e7:	89 86 34 02 00 00    	mov    %eax,0x234(%esi)
801035ed:	0f b6 44 0e 34       	movzbl 0x34(%esi,%ecx,1),%eax
801035f2:	88 04 1f             	mov    %al,(%edi,%ebx,1)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
801035f5:	83 c3 01             	add    $0x1,%ebx
801035f8:	39 5d 10             	cmp    %ebx,0x10(%ebp)
801035fb:	75 d3                	jne    801035d0 <piperead+0xa0>
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
801035fd:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
80103603:	83 ec 0c             	sub    $0xc,%esp
80103606:	50                   	push   %eax
80103607:	e8 24 0a 00 00       	call   80104030 <wakeup>
  release(&p->lock);
8010360c:	89 34 24             	mov    %esi,(%esp)
8010360f:	e8 0c 10 00 00       	call   80104620 <release>
  return i;
80103614:	83 c4 10             	add    $0x10,%esp
}
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

80103630 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80103630:	55                   	push   %ebp
80103631:	89 e5                	mov    %esp,%ebp
80103633:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80103636:	68 20 2d 11 80       	push   $0x80112d20
8010363b:	e8 e0 0f 00 00       	call   80104620 <release>

  if (first) {
80103640:	a1 00 a0 10 80       	mov    0x8010a000,%eax
80103645:	83 c4 10             	add    $0x10,%esp
80103648:	85 c0                	test   %eax,%eax
8010364a:	75 04                	jne    80103650 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
8010364c:	c9                   	leave  
8010364d:	c3                   	ret    
8010364e:	66 90                	xchg   %ax,%ax
    iinit(ROOTDEV);
80103650:	83 ec 0c             	sub    $0xc,%esp
    first = 0;
80103653:	c7 05 00 a0 10 80 00 	movl   $0x0,0x8010a000
8010365a:	00 00 00 
    iinit(ROOTDEV);
8010365d:	6a 01                	push   $0x1
8010365f:	e8 4c de ff ff       	call   801014b0 <iinit>
    initlog(ROOTDEV);
80103664:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010366b:	e8 c0 f4 ff ff       	call   80102b30 <initlog>
80103670:	83 c4 10             	add    $0x10,%esp
}
80103673:	c9                   	leave  
80103674:	c3                   	ret    
80103675:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103679:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103680 <pinit>:
{
80103680:	55                   	push   %ebp
80103681:	89 e5                	mov    %esp,%ebp
80103683:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
80103686:	68 f5 76 10 80       	push   $0x801076f5
8010368b:	68 20 2d 11 80       	push   $0x80112d20
80103690:	e8 8b 0d 00 00       	call   80104420 <initlock>
}
80103695:	83 c4 10             	add    $0x10,%esp
80103698:	c9                   	leave  
80103699:	c3                   	ret    
8010369a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801036a0 <mycpu>:
{
801036a0:	55                   	push   %ebp
801036a1:	89 e5                	mov    %esp,%ebp
801036a3:	56                   	push   %esi
801036a4:	53                   	push   %ebx
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801036a5:	9c                   	pushf  
801036a6:	58                   	pop    %eax
  if(readeflags()&FL_IF)
801036a7:	f6 c4 02             	test   $0x2,%ah
801036aa:	75 5e                	jne    8010370a <mycpu+0x6a>
  apicid = lapicid();
801036ac:	e8 af f0 ff ff       	call   80102760 <lapicid>
  for (i = 0; i < ncpu; ++i) {
801036b1:	8b 35 00 2d 11 80    	mov    0x80112d00,%esi
801036b7:	85 f6                	test   %esi,%esi
801036b9:	7e 42                	jle    801036fd <mycpu+0x5d>
    if (cpus[i].apicid == apicid)
801036bb:	0f b6 15 80 27 11 80 	movzbl 0x80112780,%edx
801036c2:	39 d0                	cmp    %edx,%eax
801036c4:	74 30                	je     801036f6 <mycpu+0x56>
801036c6:	b9 30 28 11 80       	mov    $0x80112830,%ecx
  for (i = 0; i < ncpu; ++i) {
801036cb:	31 d2                	xor    %edx,%edx
801036cd:	8d 76 00             	lea    0x0(%esi),%esi
801036d0:	83 c2 01             	add    $0x1,%edx
801036d3:	39 f2                	cmp    %esi,%edx
801036d5:	74 26                	je     801036fd <mycpu+0x5d>
    if (cpus[i].apicid == apicid)
801036d7:	0f b6 19             	movzbl (%ecx),%ebx
801036da:	81 c1 b0 00 00 00    	add    $0xb0,%ecx
801036e0:	39 c3                	cmp    %eax,%ebx
801036e2:	75 ec                	jne    801036d0 <mycpu+0x30>
801036e4:	69 c2 b0 00 00 00    	imul   $0xb0,%edx,%eax
801036ea:	05 80 27 11 80       	add    $0x80112780,%eax
}
801036ef:	8d 65 f8             	lea    -0x8(%ebp),%esp
801036f2:	5b                   	pop    %ebx
801036f3:	5e                   	pop    %esi
801036f4:	5d                   	pop    %ebp
801036f5:	c3                   	ret    
    if (cpus[i].apicid == apicid)
801036f6:	b8 80 27 11 80       	mov    $0x80112780,%eax
      return &cpus[i];
801036fb:	eb f2                	jmp    801036ef <mycpu+0x4f>
  panic("unknown apicid\n");
801036fd:	83 ec 0c             	sub    $0xc,%esp
80103700:	68 fc 76 10 80       	push   $0x801076fc
80103705:	e8 86 cc ff ff       	call   80100390 <panic>
    panic("mycpu called with interrupts enabled\n");
8010370a:	83 ec 0c             	sub    $0xc,%esp
8010370d:	68 d8 77 10 80       	push   $0x801077d8
80103712:	e8 79 cc ff ff       	call   80100390 <panic>
80103717:	89 f6                	mov    %esi,%esi
80103719:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103720 <cpuid>:
cpuid() {
80103720:	55                   	push   %ebp
80103721:	89 e5                	mov    %esp,%ebp
80103723:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
80103726:	e8 75 ff ff ff       	call   801036a0 <mycpu>
8010372b:	2d 80 27 11 80       	sub    $0x80112780,%eax
}
80103730:	c9                   	leave  
  return mycpu()-cpus;
80103731:	c1 f8 04             	sar    $0x4,%eax
80103734:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
8010373a:	c3                   	ret    
8010373b:	90                   	nop
8010373c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103740 <myproc>:
myproc(void) {
80103740:	55                   	push   %ebp
80103741:	89 e5                	mov    %esp,%ebp
80103743:	53                   	push   %ebx
80103744:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80103747:	e8 44 0d 00 00       	call   80104490 <pushcli>
  c = mycpu();
8010374c:	e8 4f ff ff ff       	call   801036a0 <mycpu>
  p = c->proc;
80103751:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103757:	e8 74 0d 00 00       	call   801044d0 <popcli>
}
8010375c:	83 c4 04             	add    $0x4,%esp
8010375f:	89 d8                	mov    %ebx,%eax
80103761:	5b                   	pop    %ebx
80103762:	5d                   	pop    %ebp
80103763:	c3                   	ret    
80103764:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010376a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103770 <allocpid>:
{
80103770:	55                   	push   %ebp
80103771:	89 e5                	mov    %esp,%ebp
80103773:	53                   	push   %ebx
80103774:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);
80103777:	68 20 2d 11 80       	push   $0x80112d20
8010377c:	e8 df 0d 00 00       	call   80104560 <acquire>
  pid = nextpid++;
80103781:	8b 1d 04 a0 10 80    	mov    0x8010a004,%ebx
  release(&ptable.lock);
80103787:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
  pid = nextpid++;
8010378e:	8d 43 01             	lea    0x1(%ebx),%eax
80103791:	a3 04 a0 10 80       	mov    %eax,0x8010a004
  release(&ptable.lock);
80103796:	e8 85 0e 00 00       	call   80104620 <release>
}
8010379b:	89 d8                	mov    %ebx,%eax
8010379d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801037a0:	c9                   	leave  
801037a1:	c3                   	ret    
801037a2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801037a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801037b0 <allocproc>:
{
801037b0:	55                   	push   %ebp
801037b1:	89 e5                	mov    %esp,%ebp
801037b3:	53                   	push   %ebx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801037b4:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
{
801037b9:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);
801037bc:	68 20 2d 11 80       	push   $0x80112d20
801037c1:	e8 9a 0d 00 00       	call   80104560 <acquire>
801037c6:	83 c4 10             	add    $0x10,%esp
801037c9:	eb 13                	jmp    801037de <allocproc+0x2e>
801037cb:	90                   	nop
801037cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801037d0:	81 c3 08 01 00 00    	add    $0x108,%ebx
801037d6:	81 fb 54 6f 11 80    	cmp    $0x80116f54,%ebx
801037dc:	73 72                	jae    80103850 <allocproc+0xa0>
    if(p->state == UNUSED)
801037de:	8b 43 0c             	mov    0xc(%ebx),%eax
801037e1:	85 c0                	test   %eax,%eax
801037e3:	75 eb                	jne    801037d0 <allocproc+0x20>
  release(&ptable.lock);
801037e5:	83 ec 0c             	sub    $0xc,%esp
  p->state = EMBRYO;
801037e8:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  release(&ptable.lock);
801037ef:	68 20 2d 11 80       	push   $0x80112d20
801037f4:	e8 27 0e 00 00       	call   80104620 <release>
  p->pid = allocpid();
801037f9:	e8 72 ff ff ff       	call   80103770 <allocpid>
801037fe:	89 43 10             	mov    %eax,0x10(%ebx)
  if((p->kstack = kalloc()) == 0){
80103801:	e8 ea ec ff ff       	call   801024f0 <kalloc>
80103806:	83 c4 10             	add    $0x10,%esp
80103809:	85 c0                	test   %eax,%eax
8010380b:	89 43 08             	mov    %eax,0x8(%ebx)
8010380e:	74 59                	je     80103869 <allocproc+0xb9>
  sp -= sizeof *p->tf;
80103810:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  memset(p->context, 0, sizeof *p->context);
80103816:	83 ec 04             	sub    $0x4,%esp
  sp -= sizeof *p->context;
80103819:	05 9c 0f 00 00       	add    $0xf9c,%eax
  sp -= sizeof *p->tf;
8010381e:	89 53 18             	mov    %edx,0x18(%ebx)
  *(uint*)sp = (uint)trapret;
80103821:	c7 40 14 2f 59 10 80 	movl   $0x8010592f,0x14(%eax)
  p->context = (struct context*)sp;
80103828:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
8010382b:	6a 14                	push   $0x14
8010382d:	6a 00                	push   $0x0
8010382f:	50                   	push   %eax
80103830:	e8 3b 0e 00 00       	call   80104670 <memset>
  p->context->eip = (uint)forkret;
80103835:	8b 43 1c             	mov    0x1c(%ebx),%eax
  return p;
80103838:	83 c4 10             	add    $0x10,%esp
  p->context->eip = (uint)forkret;
8010383b:	c7 40 10 30 36 10 80 	movl   $0x80103630,0x10(%eax)
}
80103842:	89 d8                	mov    %ebx,%eax
80103844:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103847:	c9                   	leave  
80103848:	c3                   	ret    
80103849:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  release(&ptable.lock);
80103850:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80103853:	31 db                	xor    %ebx,%ebx
  release(&ptable.lock);
80103855:	68 20 2d 11 80       	push   $0x80112d20
8010385a:	e8 c1 0d 00 00       	call   80104620 <release>
}
8010385f:	89 d8                	mov    %ebx,%eax
  return 0;
80103861:	83 c4 10             	add    $0x10,%esp
}
80103864:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103867:	c9                   	leave  
80103868:	c3                   	ret    
    p->state = UNUSED;
80103869:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
80103870:	31 db                	xor    %ebx,%ebx
80103872:	eb ce                	jmp    80103842 <allocproc+0x92>
80103874:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010387a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103880 <userinit>:
{
80103880:	55                   	push   %ebp
80103881:	89 e5                	mov    %esp,%ebp
80103883:	53                   	push   %ebx
80103884:	83 ec 04             	sub    $0x4,%esp
  p = allocproc();
80103887:	e8 24 ff ff ff       	call   801037b0 <allocproc>
8010388c:	89 c3                	mov    %eax,%ebx
  initproc = p;
8010388e:	a3 b8 a5 10 80       	mov    %eax,0x8010a5b8
  if((p->pgdir = setupkvm()) == 0)
80103893:	e8 68 36 00 00       	call   80106f00 <setupkvm>
80103898:	85 c0                	test   %eax,%eax
8010389a:	89 43 04             	mov    %eax,0x4(%ebx)
8010389d:	0f 84 f2 00 00 00    	je     80103995 <userinit+0x115>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
801038a3:	83 ec 04             	sub    $0x4,%esp
801038a6:	68 2c 00 00 00       	push   $0x2c
801038ab:	68 60 a4 10 80       	push   $0x8010a460
801038b0:	50                   	push   %eax
801038b1:	e8 2a 33 00 00       	call   80106be0 <inituvm>
  memset(p->tf, 0, sizeof(*p->tf));
801038b6:	83 c4 0c             	add    $0xc,%esp
  p->sz = PGSIZE;
801038b9:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
801038bf:	6a 4c                	push   $0x4c
801038c1:	6a 00                	push   $0x0
801038c3:	ff 73 18             	pushl  0x18(%ebx)
801038c6:	e8 a5 0d 00 00       	call   80104670 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
801038cb:	8b 43 18             	mov    0x18(%ebx),%eax
801038ce:	ba 1b 00 00 00       	mov    $0x1b,%edx
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
801038d3:	b9 23 00 00 00       	mov    $0x23,%ecx
  safestrcpy(p->name, "initcode", sizeof(p->name));
801038d8:	83 c4 0c             	add    $0xc,%esp
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
801038db:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
801038df:	8b 43 18             	mov    0x18(%ebx),%eax
801038e2:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
801038e6:	8b 43 18             	mov    0x18(%ebx),%eax
801038e9:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
801038ed:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
801038f1:	8b 43 18             	mov    0x18(%ebx),%eax
801038f4:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
801038f8:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
801038fc:	8b 43 18             	mov    0x18(%ebx),%eax
801038ff:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80103906:	8b 43 18             	mov    0x18(%ebx),%eax
80103909:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80103910:	8b 43 18             	mov    0x18(%ebx),%eax
80103913:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
8010391a:	8d 43 6c             	lea    0x6c(%ebx),%eax
8010391d:	6a 10                	push   $0x10
8010391f:	68 25 77 10 80       	push   $0x80107725
80103924:	50                   	push   %eax
80103925:	e8 26 0f 00 00       	call   80104850 <safestrcpy>
  p->cwd = namei("/");
8010392a:	c7 04 24 2e 77 10 80 	movl   $0x8010772e,(%esp)
80103931:	e8 da e5 ff ff       	call   80101f10 <namei>
80103936:	8d 93 04 01 00 00    	lea    0x104(%ebx),%edx
8010393c:	89 43 68             	mov    %eax,0x68(%ebx)
8010393f:	8d 83 84 00 00 00    	lea    0x84(%ebx),%eax
  p->signal_mask = 0;
80103945:	c7 83 80 00 00 00 00 	movl   $0x0,0x80(%ebx)
8010394c:	00 00 00 
  p->pending_signals =0;
8010394f:	c7 43 7c 00 00 00 00 	movl   $0x0,0x7c(%ebx)
80103956:	83 c4 10             	add    $0x10,%esp
80103959:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    p->signal_handlers[i] = (void*)SIG_DFL;
80103960:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80103966:	83 c0 04             	add    $0x4,%eax
  for(int i=0; i<32; i++){
80103969:	39 d0                	cmp    %edx,%eax
8010396b:	75 f3                	jne    80103960 <userinit+0xe0>
  acquire(&ptable.lock);
8010396d:	83 ec 0c             	sub    $0xc,%esp
80103970:	68 20 2d 11 80       	push   $0x80112d20
80103975:	e8 e6 0b 00 00       	call   80104560 <acquire>
  p->state = RUNNABLE;
8010397a:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
80103981:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103988:	e8 93 0c 00 00       	call   80104620 <release>
}
8010398d:	83 c4 10             	add    $0x10,%esp
80103990:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103993:	c9                   	leave  
80103994:	c3                   	ret    
    panic("userinit: out of memory?");
80103995:	83 ec 0c             	sub    $0xc,%esp
80103998:	68 0c 77 10 80       	push   $0x8010770c
8010399d:	e8 ee c9 ff ff       	call   80100390 <panic>
801039a2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801039a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801039b0 <growproc>:
{
801039b0:	55                   	push   %ebp
801039b1:	89 e5                	mov    %esp,%ebp
801039b3:	56                   	push   %esi
801039b4:	53                   	push   %ebx
801039b5:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
801039b8:	e8 d3 0a 00 00       	call   80104490 <pushcli>
  c = mycpu();
801039bd:	e8 de fc ff ff       	call   801036a0 <mycpu>
  p = c->proc;
801039c2:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801039c8:	e8 03 0b 00 00       	call   801044d0 <popcli>
  if(n > 0){
801039cd:	83 fe 00             	cmp    $0x0,%esi
  sz = curproc->sz;
801039d0:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
801039d2:	7f 1c                	jg     801039f0 <growproc+0x40>
  } else if(n < 0){
801039d4:	75 3a                	jne    80103a10 <growproc+0x60>
  switchuvm(curproc);
801039d6:	83 ec 0c             	sub    $0xc,%esp
  curproc->sz = sz;
801039d9:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
801039db:	53                   	push   %ebx
801039dc:	e8 ef 30 00 00       	call   80106ad0 <switchuvm>
  return 0;
801039e1:	83 c4 10             	add    $0x10,%esp
801039e4:	31 c0                	xor    %eax,%eax
}
801039e6:	8d 65 f8             	lea    -0x8(%ebp),%esp
801039e9:	5b                   	pop    %ebx
801039ea:	5e                   	pop    %esi
801039eb:	5d                   	pop    %ebp
801039ec:	c3                   	ret    
801039ed:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
801039f0:	83 ec 04             	sub    $0x4,%esp
801039f3:	01 c6                	add    %eax,%esi
801039f5:	56                   	push   %esi
801039f6:	50                   	push   %eax
801039f7:	ff 73 04             	pushl  0x4(%ebx)
801039fa:	e8 21 33 00 00       	call   80106d20 <allocuvm>
801039ff:	83 c4 10             	add    $0x10,%esp
80103a02:	85 c0                	test   %eax,%eax
80103a04:	75 d0                	jne    801039d6 <growproc+0x26>
      return -1;
80103a06:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103a0b:	eb d9                	jmp    801039e6 <growproc+0x36>
80103a0d:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103a10:	83 ec 04             	sub    $0x4,%esp
80103a13:	01 c6                	add    %eax,%esi
80103a15:	56                   	push   %esi
80103a16:	50                   	push   %eax
80103a17:	ff 73 04             	pushl  0x4(%ebx)
80103a1a:	e8 31 34 00 00       	call   80106e50 <deallocuvm>
80103a1f:	83 c4 10             	add    $0x10,%esp
80103a22:	85 c0                	test   %eax,%eax
80103a24:	75 b0                	jne    801039d6 <growproc+0x26>
80103a26:	eb de                	jmp    80103a06 <growproc+0x56>
80103a28:	90                   	nop
80103a29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103a30 <fork>:
{
80103a30:	55                   	push   %ebp
80103a31:	89 e5                	mov    %esp,%ebp
80103a33:	57                   	push   %edi
80103a34:	56                   	push   %esi
80103a35:	53                   	push   %ebx
80103a36:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
80103a39:	e8 52 0a 00 00       	call   80104490 <pushcli>
  c = mycpu();
80103a3e:	e8 5d fc ff ff       	call   801036a0 <mycpu>
  p = c->proc;
80103a43:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103a49:	e8 82 0a 00 00       	call   801044d0 <popcli>
  if((np = allocproc()) == 0){
80103a4e:	e8 5d fd ff ff       	call   801037b0 <allocproc>
80103a53:	85 c0                	test   %eax,%eax
80103a55:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103a58:	0f 84 fb 00 00 00    	je     80103b59 <fork+0x129>
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
80103a5e:	83 ec 08             	sub    $0x8,%esp
80103a61:	ff 33                	pushl  (%ebx)
80103a63:	ff 73 04             	pushl  0x4(%ebx)
80103a66:	e8 65 35 00 00       	call   80106fd0 <copyuvm>
80103a6b:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103a6e:	83 c4 10             	add    $0x10,%esp
80103a71:	85 c0                	test   %eax,%eax
80103a73:	89 42 04             	mov    %eax,0x4(%edx)
80103a76:	0f 84 e4 00 00 00    	je     80103b60 <fork+0x130>
  np->sz = curproc->sz;
80103a7c:	8b 03                	mov    (%ebx),%eax
  *np->tf = *curproc->tf;
80103a7e:	8b 7a 18             	mov    0x18(%edx),%edi
80103a81:	b9 13 00 00 00       	mov    $0x13,%ecx
  np->parent = curproc;
80103a86:	89 5a 14             	mov    %ebx,0x14(%edx)
  np->sz = curproc->sz;
80103a89:	89 02                	mov    %eax,(%edx)
  *np->tf = *curproc->tf;
80103a8b:	8b 73 18             	mov    0x18(%ebx),%esi
80103a8e:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  for(i = 0; i < NOFILE; i++)
80103a90:	31 f6                	xor    %esi,%esi
  np->tf->eax = 0;
80103a92:	8b 42 18             	mov    0x18(%edx),%eax
80103a95:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
80103a9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[i])
80103aa0:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
80103aa4:	85 c0                	test   %eax,%eax
80103aa6:	74 16                	je     80103abe <fork+0x8e>
      np->ofile[i] = filedup(curproc->ofile[i]);
80103aa8:	83 ec 0c             	sub    $0xc,%esp
80103aab:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80103aae:	50                   	push   %eax
80103aaf:	e8 6c d3 ff ff       	call   80100e20 <filedup>
80103ab4:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103ab7:	83 c4 10             	add    $0x10,%esp
80103aba:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
  for(i = 0; i < NOFILE; i++)
80103abe:	83 c6 01             	add    $0x1,%esi
80103ac1:	83 fe 10             	cmp    $0x10,%esi
80103ac4:	75 da                	jne    80103aa0 <fork+0x70>
  np->cwd = idup(curproc->cwd);
80103ac6:	83 ec 0c             	sub    $0xc,%esp
80103ac9:	ff 73 68             	pushl  0x68(%ebx)
80103acc:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80103acf:	e8 ac db ff ff       	call   80101680 <idup>
80103ad4:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103ad7:	83 c4 0c             	add    $0xc,%esp
  np->cwd = idup(curproc->cwd);
80103ada:	89 42 68             	mov    %eax,0x68(%edx)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103add:	8d 43 6c             	lea    0x6c(%ebx),%eax
80103ae0:	6a 10                	push   $0x10
80103ae2:	50                   	push   %eax
80103ae3:	8d 42 6c             	lea    0x6c(%edx),%eax
80103ae6:	50                   	push   %eax
80103ae7:	e8 64 0d 00 00       	call   80104850 <safestrcpy>
  pid = np->pid;
80103aec:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  np->signal_mask = curproc->signal_mask;
80103aef:	8b 83 80 00 00 00    	mov    0x80(%ebx),%eax
  np->pending_signals = 0; 
80103af5:	83 c4 10             	add    $0x10,%esp
  for(int i=0; i<32; i++){
80103af8:	31 c9                	xor    %ecx,%ecx
  pid = np->pid;
80103afa:	8b 7a 10             	mov    0x10(%edx),%edi
  np->signal_mask = curproc->signal_mask;
80103afd:	89 82 80 00 00 00    	mov    %eax,0x80(%edx)
  np->pending_signals = 0; 
80103b03:	c7 42 7c 00 00 00 00 	movl   $0x0,0x7c(%edx)
80103b0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    np->signal_handlers[i] = curproc->signal_handlers[i];
80103b10:	8b b4 8b 84 00 00 00 	mov    0x84(%ebx,%ecx,4),%esi
80103b17:	89 b4 8a 84 00 00 00 	mov    %esi,0x84(%edx,%ecx,4)
  for(int i=0; i<32; i++){
80103b1e:	83 c1 01             	add    $0x1,%ecx
80103b21:	83 f9 20             	cmp    $0x20,%ecx
80103b24:	75 ea                	jne    80103b10 <fork+0xe0>
  acquire(&ptable.lock);
80103b26:	83 ec 0c             	sub    $0xc,%esp
80103b29:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80103b2c:	68 20 2d 11 80       	push   $0x80112d20
80103b31:	e8 2a 0a 00 00       	call   80104560 <acquire>
  np->state = RUNNABLE;
80103b36:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103b39:	c7 42 0c 03 00 00 00 	movl   $0x3,0xc(%edx)
  release(&ptable.lock);
80103b40:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103b47:	e8 d4 0a 00 00       	call   80104620 <release>
  return pid;
80103b4c:	83 c4 10             	add    $0x10,%esp
}
80103b4f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103b52:	89 f8                	mov    %edi,%eax
80103b54:	5b                   	pop    %ebx
80103b55:	5e                   	pop    %esi
80103b56:	5f                   	pop    %edi
80103b57:	5d                   	pop    %ebp
80103b58:	c3                   	ret    
    return -1;
80103b59:	bf ff ff ff ff       	mov    $0xffffffff,%edi
80103b5e:	eb ef                	jmp    80103b4f <fork+0x11f>
    kfree(np->kstack);
80103b60:	83 ec 0c             	sub    $0xc,%esp
80103b63:	ff 72 08             	pushl  0x8(%edx)
    return -1;
80103b66:	bf ff ff ff ff       	mov    $0xffffffff,%edi
    kfree(np->kstack);
80103b6b:	e8 d0 e7 ff ff       	call   80102340 <kfree>
    np->kstack = 0;
80103b70:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    return -1;
80103b73:	83 c4 10             	add    $0x10,%esp
    np->kstack = 0;
80103b76:	c7 42 08 00 00 00 00 	movl   $0x0,0x8(%edx)
    np->state = UNUSED;
80103b7d:	c7 42 0c 00 00 00 00 	movl   $0x0,0xc(%edx)
    return -1;
80103b84:	eb c9                	jmp    80103b4f <fork+0x11f>
80103b86:	8d 76 00             	lea    0x0(%esi),%esi
80103b89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103b90 <scheduler>:
{
80103b90:	55                   	push   %ebp
80103b91:	89 e5                	mov    %esp,%ebp
80103b93:	57                   	push   %edi
80103b94:	56                   	push   %esi
80103b95:	53                   	push   %ebx
80103b96:	83 ec 0c             	sub    $0xc,%esp
  struct cpu *c = mycpu();
80103b99:	e8 02 fb ff ff       	call   801036a0 <mycpu>
80103b9e:	8d 78 04             	lea    0x4(%eax),%edi
80103ba1:	89 c6                	mov    %eax,%esi
  c->proc = 0;
80103ba3:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80103baa:	00 00 00 
80103bad:	8d 76 00             	lea    0x0(%esi),%esi
  asm volatile("sti");
80103bb0:	fb                   	sti    
    acquire(&ptable.lock);
80103bb1:	83 ec 0c             	sub    $0xc,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103bb4:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
    acquire(&ptable.lock);
80103bb9:	68 20 2d 11 80       	push   $0x80112d20
80103bbe:	e8 9d 09 00 00       	call   80104560 <acquire>
80103bc3:	83 c4 10             	add    $0x10,%esp
80103bc6:	8d 76 00             	lea    0x0(%esi),%esi
80103bc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      if(p->state != RUNNABLE)
80103bd0:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
80103bd4:	75 33                	jne    80103c09 <scheduler+0x79>
      switchuvm(p);
80103bd6:	83 ec 0c             	sub    $0xc,%esp
      c->proc = p;
80103bd9:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
      switchuvm(p);
80103bdf:	53                   	push   %ebx
80103be0:	e8 eb 2e 00 00       	call   80106ad0 <switchuvm>
      swtch(&(c->scheduler), p->context);
80103be5:	58                   	pop    %eax
80103be6:	5a                   	pop    %edx
80103be7:	ff 73 1c             	pushl  0x1c(%ebx)
80103bea:	57                   	push   %edi
      p->state = RUNNING;
80103beb:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
      swtch(&(c->scheduler), p->context);
80103bf2:	e8 b4 0c 00 00       	call   801048ab <swtch>
      switchkvm();
80103bf7:	e8 b4 2e 00 00       	call   80106ab0 <switchkvm>
      c->proc = 0;
80103bfc:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
80103c03:	00 00 00 
80103c06:	83 c4 10             	add    $0x10,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103c09:	81 c3 08 01 00 00    	add    $0x108,%ebx
80103c0f:	81 fb 54 6f 11 80    	cmp    $0x80116f54,%ebx
80103c15:	72 b9                	jb     80103bd0 <scheduler+0x40>
    release(&ptable.lock);
80103c17:	83 ec 0c             	sub    $0xc,%esp
80103c1a:	68 20 2d 11 80       	push   $0x80112d20
80103c1f:	e8 fc 09 00 00       	call   80104620 <release>
    sti();
80103c24:	83 c4 10             	add    $0x10,%esp
80103c27:	eb 87                	jmp    80103bb0 <scheduler+0x20>
80103c29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103c30 <sched>:
{
80103c30:	55                   	push   %ebp
80103c31:	89 e5                	mov    %esp,%ebp
80103c33:	56                   	push   %esi
80103c34:	53                   	push   %ebx
  pushcli();
80103c35:	e8 56 08 00 00       	call   80104490 <pushcli>
  c = mycpu();
80103c3a:	e8 61 fa ff ff       	call   801036a0 <mycpu>
  p = c->proc;
80103c3f:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103c45:	e8 86 08 00 00       	call   801044d0 <popcli>
  if(!holding(&ptable.lock))
80103c4a:	83 ec 0c             	sub    $0xc,%esp
80103c4d:	68 20 2d 11 80       	push   $0x80112d20
80103c52:	e8 d9 08 00 00       	call   80104530 <holding>
80103c57:	83 c4 10             	add    $0x10,%esp
80103c5a:	85 c0                	test   %eax,%eax
80103c5c:	74 4f                	je     80103cad <sched+0x7d>
  if(mycpu()->ncli != 1)
80103c5e:	e8 3d fa ff ff       	call   801036a0 <mycpu>
80103c63:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
80103c6a:	75 68                	jne    80103cd4 <sched+0xa4>
  if(p->state == RUNNING)
80103c6c:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80103c70:	74 55                	je     80103cc7 <sched+0x97>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103c72:	9c                   	pushf  
80103c73:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103c74:	f6 c4 02             	test   $0x2,%ah
80103c77:	75 41                	jne    80103cba <sched+0x8a>
  intena = mycpu()->intena;
80103c79:	e8 22 fa ff ff       	call   801036a0 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
80103c7e:	83 c3 1c             	add    $0x1c,%ebx
  intena = mycpu()->intena;
80103c81:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80103c87:	e8 14 fa ff ff       	call   801036a0 <mycpu>
80103c8c:	83 ec 08             	sub    $0x8,%esp
80103c8f:	ff 70 04             	pushl  0x4(%eax)
80103c92:	53                   	push   %ebx
80103c93:	e8 13 0c 00 00       	call   801048ab <swtch>
  mycpu()->intena = intena;
80103c98:	e8 03 fa ff ff       	call   801036a0 <mycpu>
}
80103c9d:	83 c4 10             	add    $0x10,%esp
  mycpu()->intena = intena;
80103ca0:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80103ca6:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103ca9:	5b                   	pop    %ebx
80103caa:	5e                   	pop    %esi
80103cab:	5d                   	pop    %ebp
80103cac:	c3                   	ret    
    panic("sched ptable.lock");
80103cad:	83 ec 0c             	sub    $0xc,%esp
80103cb0:	68 30 77 10 80       	push   $0x80107730
80103cb5:	e8 d6 c6 ff ff       	call   80100390 <panic>
    panic("sched interruptible");
80103cba:	83 ec 0c             	sub    $0xc,%esp
80103cbd:	68 5c 77 10 80       	push   $0x8010775c
80103cc2:	e8 c9 c6 ff ff       	call   80100390 <panic>
    panic("sched running");
80103cc7:	83 ec 0c             	sub    $0xc,%esp
80103cca:	68 4e 77 10 80       	push   $0x8010774e
80103ccf:	e8 bc c6 ff ff       	call   80100390 <panic>
    panic("sched locks");
80103cd4:	83 ec 0c             	sub    $0xc,%esp
80103cd7:	68 42 77 10 80       	push   $0x80107742
80103cdc:	e8 af c6 ff ff       	call   80100390 <panic>
80103ce1:	eb 0d                	jmp    80103cf0 <exit>
80103ce3:	90                   	nop
80103ce4:	90                   	nop
80103ce5:	90                   	nop
80103ce6:	90                   	nop
80103ce7:	90                   	nop
80103ce8:	90                   	nop
80103ce9:	90                   	nop
80103cea:	90                   	nop
80103ceb:	90                   	nop
80103cec:	90                   	nop
80103ced:	90                   	nop
80103cee:	90                   	nop
80103cef:	90                   	nop

80103cf0 <exit>:
{
80103cf0:	55                   	push   %ebp
80103cf1:	89 e5                	mov    %esp,%ebp
80103cf3:	57                   	push   %edi
80103cf4:	56                   	push   %esi
80103cf5:	53                   	push   %ebx
80103cf6:	83 ec 0c             	sub    $0xc,%esp
  pushcli();
80103cf9:	e8 92 07 00 00       	call   80104490 <pushcli>
  c = mycpu();
80103cfe:	e8 9d f9 ff ff       	call   801036a0 <mycpu>
  p = c->proc;
80103d03:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80103d09:	e8 c2 07 00 00       	call   801044d0 <popcli>
  if(curproc == initproc)
80103d0e:	39 35 b8 a5 10 80    	cmp    %esi,0x8010a5b8
80103d14:	8d 5e 28             	lea    0x28(%esi),%ebx
80103d17:	8d 7e 68             	lea    0x68(%esi),%edi
80103d1a:	0f 84 f1 00 00 00    	je     80103e11 <exit+0x121>
    if(curproc->ofile[fd]){
80103d20:	8b 03                	mov    (%ebx),%eax
80103d22:	85 c0                	test   %eax,%eax
80103d24:	74 12                	je     80103d38 <exit+0x48>
      fileclose(curproc->ofile[fd]);
80103d26:	83 ec 0c             	sub    $0xc,%esp
80103d29:	50                   	push   %eax
80103d2a:	e8 41 d1 ff ff       	call   80100e70 <fileclose>
      curproc->ofile[fd] = 0;
80103d2f:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80103d35:	83 c4 10             	add    $0x10,%esp
80103d38:	83 c3 04             	add    $0x4,%ebx
  for(fd = 0; fd < NOFILE; fd++){
80103d3b:	39 fb                	cmp    %edi,%ebx
80103d3d:	75 e1                	jne    80103d20 <exit+0x30>
  begin_op();
80103d3f:	e8 8c ee ff ff       	call   80102bd0 <begin_op>
  iput(curproc->cwd);
80103d44:	83 ec 0c             	sub    $0xc,%esp
80103d47:	ff 76 68             	pushl  0x68(%esi)
80103d4a:	e8 91 da ff ff       	call   801017e0 <iput>
  end_op();
80103d4f:	e8 ec ee ff ff       	call   80102c40 <end_op>
  curproc->cwd = 0;
80103d54:	c7 46 68 00 00 00 00 	movl   $0x0,0x68(%esi)
  acquire(&ptable.lock);
80103d5b:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103d62:	e8 f9 07 00 00       	call   80104560 <acquire>
  wakeup1(curproc->parent);
80103d67:	8b 56 14             	mov    0x14(%esi),%edx
80103d6a:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103d6d:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
80103d72:	eb 10                	jmp    80103d84 <exit+0x94>
80103d74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103d78:	05 08 01 00 00       	add    $0x108,%eax
80103d7d:	3d 54 6f 11 80       	cmp    $0x80116f54,%eax
80103d82:	73 1e                	jae    80103da2 <exit+0xb2>
    if(p->state == SLEEPING && p->chan == chan)
80103d84:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103d88:	75 ee                	jne    80103d78 <exit+0x88>
80103d8a:	3b 50 20             	cmp    0x20(%eax),%edx
80103d8d:	75 e9                	jne    80103d78 <exit+0x88>
      p->state = RUNNABLE;
80103d8f:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103d96:	05 08 01 00 00       	add    $0x108,%eax
80103d9b:	3d 54 6f 11 80       	cmp    $0x80116f54,%eax
80103da0:	72 e2                	jb     80103d84 <exit+0x94>
      p->parent = initproc;
80103da2:	8b 0d b8 a5 10 80    	mov    0x8010a5b8,%ecx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103da8:	ba 54 2d 11 80       	mov    $0x80112d54,%edx
80103dad:	eb 0f                	jmp    80103dbe <exit+0xce>
80103daf:	90                   	nop
80103db0:	81 c2 08 01 00 00    	add    $0x108,%edx
80103db6:	81 fa 54 6f 11 80    	cmp    $0x80116f54,%edx
80103dbc:	73 3a                	jae    80103df8 <exit+0x108>
    if(p->parent == curproc){
80103dbe:	39 72 14             	cmp    %esi,0x14(%edx)
80103dc1:	75 ed                	jne    80103db0 <exit+0xc0>
      if(p->state == ZOMBIE)
80103dc3:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
      p->parent = initproc;
80103dc7:	89 4a 14             	mov    %ecx,0x14(%edx)
      if(p->state == ZOMBIE)
80103dca:	75 e4                	jne    80103db0 <exit+0xc0>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103dcc:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
80103dd1:	eb 11                	jmp    80103de4 <exit+0xf4>
80103dd3:	90                   	nop
80103dd4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103dd8:	05 08 01 00 00       	add    $0x108,%eax
80103ddd:	3d 54 6f 11 80       	cmp    $0x80116f54,%eax
80103de2:	73 cc                	jae    80103db0 <exit+0xc0>
    if(p->state == SLEEPING && p->chan == chan)
80103de4:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103de8:	75 ee                	jne    80103dd8 <exit+0xe8>
80103dea:	3b 48 20             	cmp    0x20(%eax),%ecx
80103ded:	75 e9                	jne    80103dd8 <exit+0xe8>
      p->state = RUNNABLE;
80103def:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80103df6:	eb e0                	jmp    80103dd8 <exit+0xe8>
  curproc->state = ZOMBIE;
80103df8:	c7 46 0c 05 00 00 00 	movl   $0x5,0xc(%esi)
  sched();
80103dff:	e8 2c fe ff ff       	call   80103c30 <sched>
  panic("zombie exit");
80103e04:	83 ec 0c             	sub    $0xc,%esp
80103e07:	68 7d 77 10 80       	push   $0x8010777d
80103e0c:	e8 7f c5 ff ff       	call   80100390 <panic>
    panic("init exiting");
80103e11:	83 ec 0c             	sub    $0xc,%esp
80103e14:	68 70 77 10 80       	push   $0x80107770
80103e19:	e8 72 c5 ff ff       	call   80100390 <panic>
80103e1e:	66 90                	xchg   %ax,%ax

80103e20 <yield>:
{
80103e20:	55                   	push   %ebp
80103e21:	89 e5                	mov    %esp,%ebp
80103e23:	53                   	push   %ebx
80103e24:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80103e27:	68 20 2d 11 80       	push   $0x80112d20
80103e2c:	e8 2f 07 00 00       	call   80104560 <acquire>
  pushcli();
80103e31:	e8 5a 06 00 00       	call   80104490 <pushcli>
  c = mycpu();
80103e36:	e8 65 f8 ff ff       	call   801036a0 <mycpu>
  p = c->proc;
80103e3b:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103e41:	e8 8a 06 00 00       	call   801044d0 <popcli>
  myproc()->state = RUNNABLE;
80103e46:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  sched();
80103e4d:	e8 de fd ff ff       	call   80103c30 <sched>
  release(&ptable.lock);
80103e52:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103e59:	e8 c2 07 00 00       	call   80104620 <release>
}
80103e5e:	83 c4 10             	add    $0x10,%esp
80103e61:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103e64:	c9                   	leave  
80103e65:	c3                   	ret    
80103e66:	8d 76 00             	lea    0x0(%esi),%esi
80103e69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103e70 <sleep>:
{
80103e70:	55                   	push   %ebp
80103e71:	89 e5                	mov    %esp,%ebp
80103e73:	57                   	push   %edi
80103e74:	56                   	push   %esi
80103e75:	53                   	push   %ebx
80103e76:	83 ec 0c             	sub    $0xc,%esp
80103e79:	8b 7d 08             	mov    0x8(%ebp),%edi
80103e7c:	8b 75 0c             	mov    0xc(%ebp),%esi
  pushcli();
80103e7f:	e8 0c 06 00 00       	call   80104490 <pushcli>
  c = mycpu();
80103e84:	e8 17 f8 ff ff       	call   801036a0 <mycpu>
  p = c->proc;
80103e89:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103e8f:	e8 3c 06 00 00       	call   801044d0 <popcli>
  if(p == 0)
80103e94:	85 db                	test   %ebx,%ebx
80103e96:	0f 84 87 00 00 00    	je     80103f23 <sleep+0xb3>
  if(lk == 0)
80103e9c:	85 f6                	test   %esi,%esi
80103e9e:	74 76                	je     80103f16 <sleep+0xa6>
  if(lk != &ptable.lock){  //DOC: sleeplock0
80103ea0:	81 fe 20 2d 11 80    	cmp    $0x80112d20,%esi
80103ea6:	74 50                	je     80103ef8 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
80103ea8:	83 ec 0c             	sub    $0xc,%esp
80103eab:	68 20 2d 11 80       	push   $0x80112d20
80103eb0:	e8 ab 06 00 00       	call   80104560 <acquire>
    release(lk);
80103eb5:	89 34 24             	mov    %esi,(%esp)
80103eb8:	e8 63 07 00 00       	call   80104620 <release>
  p->chan = chan;
80103ebd:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80103ec0:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80103ec7:	e8 64 fd ff ff       	call   80103c30 <sched>
  p->chan = 0;
80103ecc:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
    release(&ptable.lock);
80103ed3:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103eda:	e8 41 07 00 00       	call   80104620 <release>
    acquire(lk);
80103edf:	89 75 08             	mov    %esi,0x8(%ebp)
80103ee2:	83 c4 10             	add    $0x10,%esp
}
80103ee5:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103ee8:	5b                   	pop    %ebx
80103ee9:	5e                   	pop    %esi
80103eea:	5f                   	pop    %edi
80103eeb:	5d                   	pop    %ebp
    acquire(lk);
80103eec:	e9 6f 06 00 00       	jmp    80104560 <acquire>
80103ef1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  p->chan = chan;
80103ef8:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80103efb:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80103f02:	e8 29 fd ff ff       	call   80103c30 <sched>
  p->chan = 0;
80103f07:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
80103f0e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103f11:	5b                   	pop    %ebx
80103f12:	5e                   	pop    %esi
80103f13:	5f                   	pop    %edi
80103f14:	5d                   	pop    %ebp
80103f15:	c3                   	ret    
    panic("sleep without lk");
80103f16:	83 ec 0c             	sub    $0xc,%esp
80103f19:	68 8f 77 10 80       	push   $0x8010778f
80103f1e:	e8 6d c4 ff ff       	call   80100390 <panic>
    panic("sleep");
80103f23:	83 ec 0c             	sub    $0xc,%esp
80103f26:	68 89 77 10 80       	push   $0x80107789
80103f2b:	e8 60 c4 ff ff       	call   80100390 <panic>

80103f30 <wait>:
{
80103f30:	55                   	push   %ebp
80103f31:	89 e5                	mov    %esp,%ebp
80103f33:	56                   	push   %esi
80103f34:	53                   	push   %ebx
  pushcli();
80103f35:	e8 56 05 00 00       	call   80104490 <pushcli>
  c = mycpu();
80103f3a:	e8 61 f7 ff ff       	call   801036a0 <mycpu>
  p = c->proc;
80103f3f:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80103f45:	e8 86 05 00 00       	call   801044d0 <popcli>
  acquire(&ptable.lock);
80103f4a:	83 ec 0c             	sub    $0xc,%esp
80103f4d:	68 20 2d 11 80       	push   $0x80112d20
80103f52:	e8 09 06 00 00       	call   80104560 <acquire>
80103f57:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
80103f5a:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103f5c:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
80103f61:	eb 13                	jmp    80103f76 <wait+0x46>
80103f63:	90                   	nop
80103f64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103f68:	81 c3 08 01 00 00    	add    $0x108,%ebx
80103f6e:	81 fb 54 6f 11 80    	cmp    $0x80116f54,%ebx
80103f74:	73 1e                	jae    80103f94 <wait+0x64>
      if(p->parent != curproc)
80103f76:	39 73 14             	cmp    %esi,0x14(%ebx)
80103f79:	75 ed                	jne    80103f68 <wait+0x38>
      if(p->state == ZOMBIE){
80103f7b:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
80103f7f:	74 37                	je     80103fb8 <wait+0x88>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103f81:	81 c3 08 01 00 00    	add    $0x108,%ebx
      havekids = 1;
80103f87:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103f8c:	81 fb 54 6f 11 80    	cmp    $0x80116f54,%ebx
80103f92:	72 e2                	jb     80103f76 <wait+0x46>
    if(!havekids || curproc->killed){
80103f94:	85 c0                	test   %eax,%eax
80103f96:	74 76                	je     8010400e <wait+0xde>
80103f98:	8b 46 24             	mov    0x24(%esi),%eax
80103f9b:	85 c0                	test   %eax,%eax
80103f9d:	75 6f                	jne    8010400e <wait+0xde>
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
80103f9f:	83 ec 08             	sub    $0x8,%esp
80103fa2:	68 20 2d 11 80       	push   $0x80112d20
80103fa7:	56                   	push   %esi
80103fa8:	e8 c3 fe ff ff       	call   80103e70 <sleep>
    havekids = 0;
80103fad:	83 c4 10             	add    $0x10,%esp
80103fb0:	eb a8                	jmp    80103f5a <wait+0x2a>
80103fb2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        kfree(p->kstack);
80103fb8:	83 ec 0c             	sub    $0xc,%esp
80103fbb:	ff 73 08             	pushl  0x8(%ebx)
        pid = p->pid;
80103fbe:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80103fc1:	e8 7a e3 ff ff       	call   80102340 <kfree>
        freevm(p->pgdir);
80103fc6:	5a                   	pop    %edx
80103fc7:	ff 73 04             	pushl  0x4(%ebx)
        p->kstack = 0;
80103fca:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80103fd1:	e8 aa 2e 00 00       	call   80106e80 <freevm>
        release(&ptable.lock);
80103fd6:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
        p->pid = 0;
80103fdd:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80103fe4:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
80103feb:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
80103fef:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
80103ff6:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
80103ffd:	e8 1e 06 00 00       	call   80104620 <release>
        return pid;
80104002:	83 c4 10             	add    $0x10,%esp
}
80104005:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104008:	89 f0                	mov    %esi,%eax
8010400a:	5b                   	pop    %ebx
8010400b:	5e                   	pop    %esi
8010400c:	5d                   	pop    %ebp
8010400d:	c3                   	ret    
      release(&ptable.lock);
8010400e:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80104011:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
80104016:	68 20 2d 11 80       	push   $0x80112d20
8010401b:	e8 00 06 00 00       	call   80104620 <release>
      return -1;
80104020:	83 c4 10             	add    $0x10,%esp
80104023:	eb e0                	jmp    80104005 <wait+0xd5>
80104025:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104029:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104030 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80104030:	55                   	push   %ebp
80104031:	89 e5                	mov    %esp,%ebp
80104033:	53                   	push   %ebx
80104034:	83 ec 10             	sub    $0x10,%esp
80104037:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
8010403a:	68 20 2d 11 80       	push   $0x80112d20
8010403f:	e8 1c 05 00 00       	call   80104560 <acquire>
80104044:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104047:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
8010404c:	eb 0e                	jmp    8010405c <wakeup+0x2c>
8010404e:	66 90                	xchg   %ax,%ax
80104050:	05 08 01 00 00       	add    $0x108,%eax
80104055:	3d 54 6f 11 80       	cmp    $0x80116f54,%eax
8010405a:	73 1e                	jae    8010407a <wakeup+0x4a>
    if(p->state == SLEEPING && p->chan == chan)
8010405c:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104060:	75 ee                	jne    80104050 <wakeup+0x20>
80104062:	3b 58 20             	cmp    0x20(%eax),%ebx
80104065:	75 e9                	jne    80104050 <wakeup+0x20>
      p->state = RUNNABLE;
80104067:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010406e:	05 08 01 00 00       	add    $0x108,%eax
80104073:	3d 54 6f 11 80       	cmp    $0x80116f54,%eax
80104078:	72 e2                	jb     8010405c <wakeup+0x2c>
  wakeup1(chan);
  release(&ptable.lock);
8010407a:	c7 45 08 20 2d 11 80 	movl   $0x80112d20,0x8(%ebp)
}
80104081:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104084:	c9                   	leave  
  release(&ptable.lock);
80104085:	e9 96 05 00 00       	jmp    80104620 <release>
8010408a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104090 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid , int signum)
{
80104090:	55                   	push   %ebp
80104091:	89 e5                	mov    %esp,%ebp
80104093:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80104096:	8b 55 08             	mov    0x8(%ebp),%edx
 struct proc *p;
  if (signum > 31 || signum < 0)
80104099:	83 f9 1f             	cmp    $0x1f,%ecx
8010409c:	77 32                	ja     801040d0 <kill+0x40>
  return -1;
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010409e:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
801040a3:	eb 0f                	jmp    801040b4 <kill+0x24>
801040a5:	8d 76 00             	lea    0x0(%esi),%esi
801040a8:	05 08 01 00 00       	add    $0x108,%eax
801040ad:	3d 54 6f 11 80       	cmp    $0x80116f54,%eax
801040b2:	73 1c                	jae    801040d0 <kill+0x40>
    if(p->pid == pid){
801040b4:	39 50 10             	cmp    %edx,0x10(%eax)
801040b7:	75 ef                	jne    801040a8 <kill+0x18>
      p->pending_signals = p->pending_signals | 1<<signum;
801040b9:	ba 01 00 00 00       	mov    $0x1,%edx
801040be:	d3 e2                	shl    %cl,%edx
801040c0:	09 50 7c             	or     %edx,0x7c(%eax)
      return 0;
801040c3:	31 c0                	xor    %eax,%eax
    }
  }
  return -1;

 
}
801040c5:	5d                   	pop    %ebp
801040c6:	c3                   	ret    
801040c7:	89 f6                	mov    %esi,%esi
801040c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  return -1;
801040d0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801040d5:	5d                   	pop    %ebp
801040d6:	c3                   	ret    
801040d7:	89 f6                	mov    %esi,%esi
801040d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801040e0 <kill_handler>:

int kill_handler(int pid){
801040e0:	55                   	push   %ebp
801040e1:	89 e5                	mov    %esp,%ebp
801040e3:	53                   	push   %ebx
801040e4:	83 ec 10             	sub    $0x10,%esp
801040e7:	8b 5d 08             	mov    0x8(%ebp),%ebx
struct proc *p;
 acquire(&ptable.lock);
801040ea:	68 20 2d 11 80       	push   $0x80112d20
801040ef:	e8 6c 04 00 00       	call   80104560 <acquire>
801040f4:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801040f7:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
801040fc:	eb 0e                	jmp    8010410c <kill_handler+0x2c>
801040fe:	66 90                	xchg   %ax,%ax
80104100:	05 08 01 00 00       	add    $0x108,%eax
80104105:	3d 54 6f 11 80       	cmp    $0x80116f54,%eax
8010410a:	73 34                	jae    80104140 <kill_handler+0x60>
    if(p->pid == pid){
8010410c:	39 58 10             	cmp    %ebx,0x10(%eax)
8010410f:	75 ef                	jne    80104100 <kill_handler+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
80104111:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
      p->killed = 1;
80104115:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      if(p->state == SLEEPING)
8010411c:	75 07                	jne    80104125 <kill_handler+0x45>
        p->state = RUNNABLE;
8010411e:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
80104125:	83 ec 0c             	sub    $0xc,%esp
80104128:	68 20 2d 11 80       	push   $0x80112d20
8010412d:	e8 ee 04 00 00       	call   80104620 <release>
      return 0;
80104132:	83 c4 10             	add    $0x10,%esp
80104135:	31 c0                	xor    %eax,%eax
    }
  }
  release(&ptable.lock);
  return -1;
}
80104137:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010413a:	c9                   	leave  
8010413b:	c3                   	ret    
8010413c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  release(&ptable.lock);
80104140:	83 ec 0c             	sub    $0xc,%esp
80104143:	68 20 2d 11 80       	push   $0x80112d20
80104148:	e8 d3 04 00 00       	call   80104620 <release>
  return -1;
8010414d:	83 c4 10             	add    $0x10,%esp
80104150:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104155:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104158:	c9                   	leave  
80104159:	c3                   	ret    
8010415a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104160 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80104160:	55                   	push   %ebp
80104161:	89 e5                	mov    %esp,%ebp
80104163:	57                   	push   %edi
80104164:	56                   	push   %esi
80104165:	53                   	push   %ebx
80104166:	8d 75 e8             	lea    -0x18(%ebp),%esi
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104169:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
{
8010416e:	83 ec 3c             	sub    $0x3c,%esp
80104171:	eb 27                	jmp    8010419a <procdump+0x3a>
80104173:	90                   	nop
80104174:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80104178:	83 ec 0c             	sub    $0xc,%esp
8010417b:	68 23 7b 10 80       	push   $0x80107b23
80104180:	e8 db c4 ff ff       	call   80100660 <cprintf>
80104185:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104188:	81 c3 08 01 00 00    	add    $0x108,%ebx
8010418e:	81 fb 54 6f 11 80    	cmp    $0x80116f54,%ebx
80104194:	0f 83 86 00 00 00    	jae    80104220 <procdump+0xc0>
    if(p->state == UNUSED)
8010419a:	8b 43 0c             	mov    0xc(%ebx),%eax
8010419d:	85 c0                	test   %eax,%eax
8010419f:	74 e7                	je     80104188 <procdump+0x28>
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
801041a1:	83 f8 05             	cmp    $0x5,%eax
      state = "???";
801041a4:	ba a0 77 10 80       	mov    $0x801077a0,%edx
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
801041a9:	77 11                	ja     801041bc <procdump+0x5c>
801041ab:	8b 14 85 00 78 10 80 	mov    -0x7fef8800(,%eax,4),%edx
      state = "???";
801041b2:	b8 a0 77 10 80       	mov    $0x801077a0,%eax
801041b7:	85 d2                	test   %edx,%edx
801041b9:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
801041bc:	8d 43 6c             	lea    0x6c(%ebx),%eax
801041bf:	50                   	push   %eax
801041c0:	52                   	push   %edx
801041c1:	ff 73 10             	pushl  0x10(%ebx)
801041c4:	68 a4 77 10 80       	push   $0x801077a4
801041c9:	e8 92 c4 ff ff       	call   80100660 <cprintf>
    if(p->state == SLEEPING){
801041ce:	83 c4 10             	add    $0x10,%esp
801041d1:	83 7b 0c 02          	cmpl   $0x2,0xc(%ebx)
801041d5:	75 a1                	jne    80104178 <procdump+0x18>
      getcallerpcs((uint*)p->context->ebp+2, pc);
801041d7:	8d 45 c0             	lea    -0x40(%ebp),%eax
801041da:	83 ec 08             	sub    $0x8,%esp
801041dd:	8d 7d c0             	lea    -0x40(%ebp),%edi
801041e0:	50                   	push   %eax
801041e1:	8b 43 1c             	mov    0x1c(%ebx),%eax
801041e4:	8b 40 0c             	mov    0xc(%eax),%eax
801041e7:	83 c0 08             	add    $0x8,%eax
801041ea:	50                   	push   %eax
801041eb:	e8 50 02 00 00       	call   80104440 <getcallerpcs>
801041f0:	83 c4 10             	add    $0x10,%esp
801041f3:	90                   	nop
801041f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      for(i=0; i<10 && pc[i] != 0; i++)
801041f8:	8b 17                	mov    (%edi),%edx
801041fa:	85 d2                	test   %edx,%edx
801041fc:	0f 84 76 ff ff ff    	je     80104178 <procdump+0x18>
        cprintf(" %p", pc[i]);
80104202:	83 ec 08             	sub    $0x8,%esp
80104205:	83 c7 04             	add    $0x4,%edi
80104208:	52                   	push   %edx
80104209:	68 e1 71 10 80       	push   $0x801071e1
8010420e:	e8 4d c4 ff ff       	call   80100660 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
80104213:	83 c4 10             	add    $0x10,%esp
80104216:	39 fe                	cmp    %edi,%esi
80104218:	75 de                	jne    801041f8 <procdump+0x98>
8010421a:	e9 59 ff ff ff       	jmp    80104178 <procdump+0x18>
8010421f:	90                   	nop
  }
}
80104220:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104223:	5b                   	pop    %ebx
80104224:	5e                   	pop    %esi
80104225:	5f                   	pop    %edi
80104226:	5d                   	pop    %ebp
80104227:	c3                   	ret    
80104228:	90                   	nop
80104229:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104230 <sigprocmask>:

uint sigprocmask (uint sigmask){
80104230:	55                   	push   %ebp
80104231:	89 e5                	mov    %esp,%ebp
80104233:	53                   	push   %ebx
80104234:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80104237:	e8 54 02 00 00       	call   80104490 <pushcli>
  c = mycpu();
8010423c:	e8 5f f4 ff ff       	call   801036a0 <mycpu>
  p = c->proc;
80104241:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104247:	e8 84 02 00 00       	call   801044d0 <popcli>
  struct proc *p = myproc();
  uint oldmask = p->signal_mask;
  p->signal_mask = sigmask;
8010424c:	8b 55 08             	mov    0x8(%ebp),%edx
  uint oldmask = p->signal_mask;
8010424f:	8b 83 80 00 00 00    	mov    0x80(%ebx),%eax
  p->signal_mask = sigmask;
80104255:	89 93 80 00 00 00    	mov    %edx,0x80(%ebx)
  return oldmask;
}
8010425b:	83 c4 04             	add    $0x4,%esp
8010425e:	5b                   	pop    %ebx
8010425f:	5d                   	pop    %ebp
80104260:	c3                   	ret    
80104261:	eb 0d                	jmp    80104270 <sigaction>
80104263:	90                   	nop
80104264:	90                   	nop
80104265:	90                   	nop
80104266:	90                   	nop
80104267:	90                   	nop
80104268:	90                   	nop
80104269:	90                   	nop
8010426a:	90                   	nop
8010426b:	90                   	nop
8010426c:	90                   	nop
8010426d:	90                   	nop
8010426e:	90                   	nop
8010426f:	90                   	nop

80104270 <sigaction>:

int sigaction(int signum , const struct sigaction *act, struct sigaction *oldact){
80104270:	55                   	push   %ebp
80104271:	89 e5                	mov    %esp,%ebp
80104273:	57                   	push   %edi
80104274:	56                   	push   %esi
80104275:	53                   	push   %ebx
80104276:	83 ec 0c             	sub    $0xc,%esp
80104279:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010427c:	8b 75 10             	mov    0x10(%ebp),%esi
  pushcli();
8010427f:	e8 0c 02 00 00       	call   80104490 <pushcli>
  c = mycpu();
80104284:	e8 17 f4 ff ff       	call   801036a0 <mycpu>
  p = c->proc;
80104289:	8b b8 ac 00 00 00    	mov    0xac(%eax),%edi
  popcli();
8010428f:	e8 3c 02 00 00       	call   801044d0 <popcli>
    struct proc *p = myproc();
    if (signum > 31 || signum < 0 || signum == SIGSTOP || signum == SIGKILL)
80104294:	8d 43 f7             	lea    -0x9(%ebx),%eax
80104297:	83 e0 f7             	and    $0xfffffff7,%eax
8010429a:	74 34                	je     801042d0 <sigaction+0x60>
8010429c:	83 fb 1f             	cmp    $0x1f,%ebx
8010429f:	77 2f                	ja     801042d0 <sigaction+0x60>
      return -1;
      //TODO filx oldact
    if (oldact != null){
801042a1:	85 f6                	test   %esi,%esi
801042a3:	8d 4b 20             	lea    0x20(%ebx),%ecx
801042a6:	74 0e                	je     801042b6 <sigaction+0x46>
      *oldact = *(struct sigaction *)(p->signal_handlers[signum]);
801042a8:	8b 44 8f 04          	mov    0x4(%edi,%ecx,4),%eax
801042ac:	8b 50 04             	mov    0x4(%eax),%edx
801042af:	8b 00                	mov    (%eax),%eax
801042b1:	89 56 04             	mov    %edx,0x4(%esi)
801042b4:	89 06                	mov    %eax,(%esi)
    }
    p->signal_handlers[signum] = (struct sigaction *)act;
801042b6:	8b 45 0c             	mov    0xc(%ebp),%eax
801042b9:	89 44 8f 04          	mov    %eax,0x4(%edi,%ecx,4)
    return 0;
801042bd:	31 c0                	xor    %eax,%eax
}
801042bf:	83 c4 0c             	add    $0xc,%esp
801042c2:	5b                   	pop    %ebx
801042c3:	5e                   	pop    %esi
801042c4:	5f                   	pop    %edi
801042c5:	5d                   	pop    %ebp
801042c6:	c3                   	ret    
801042c7:	89 f6                	mov    %esi,%esi
801042c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      return -1;
801042d0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801042d5:	eb e8                	jmp    801042bf <sigaction+0x4f>
801042d7:	89 f6                	mov    %esi,%esi
801042d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801042e0 <sigret>:

void sigret(){
801042e0:	55                   	push   %ebp
801042e1:	89 e5                	mov    %esp,%ebp
 return;
801042e3:	5d                   	pop    %ebp
801042e4:	c3                   	ret    
801042e5:	66 90                	xchg   %ax,%ax
801042e7:	66 90                	xchg   %ax,%ax
801042e9:	66 90                	xchg   %ax,%ax
801042eb:	66 90                	xchg   %ax,%ax
801042ed:	66 90                	xchg   %ax,%ax
801042ef:	90                   	nop

801042f0 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
801042f0:	55                   	push   %ebp
801042f1:	89 e5                	mov    %esp,%ebp
801042f3:	53                   	push   %ebx
801042f4:	83 ec 0c             	sub    $0xc,%esp
801042f7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
801042fa:	68 18 78 10 80       	push   $0x80107818
801042ff:	8d 43 04             	lea    0x4(%ebx),%eax
80104302:	50                   	push   %eax
80104303:	e8 18 01 00 00       	call   80104420 <initlock>
  lk->name = name;
80104308:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
8010430b:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
80104311:	83 c4 10             	add    $0x10,%esp
  lk->pid = 0;
80104314:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
8010431b:	89 43 38             	mov    %eax,0x38(%ebx)
}
8010431e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104321:	c9                   	leave  
80104322:	c3                   	ret    
80104323:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104329:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104330 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80104330:	55                   	push   %ebp
80104331:	89 e5                	mov    %esp,%ebp
80104333:	56                   	push   %esi
80104334:	53                   	push   %ebx
80104335:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104338:	83 ec 0c             	sub    $0xc,%esp
8010433b:	8d 73 04             	lea    0x4(%ebx),%esi
8010433e:	56                   	push   %esi
8010433f:	e8 1c 02 00 00       	call   80104560 <acquire>
  while (lk->locked) {
80104344:	8b 13                	mov    (%ebx),%edx
80104346:	83 c4 10             	add    $0x10,%esp
80104349:	85 d2                	test   %edx,%edx
8010434b:	74 16                	je     80104363 <acquiresleep+0x33>
8010434d:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
80104350:	83 ec 08             	sub    $0x8,%esp
80104353:	56                   	push   %esi
80104354:	53                   	push   %ebx
80104355:	e8 16 fb ff ff       	call   80103e70 <sleep>
  while (lk->locked) {
8010435a:	8b 03                	mov    (%ebx),%eax
8010435c:	83 c4 10             	add    $0x10,%esp
8010435f:	85 c0                	test   %eax,%eax
80104361:	75 ed                	jne    80104350 <acquiresleep+0x20>
  }
  lk->locked = 1;
80104363:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80104369:	e8 d2 f3 ff ff       	call   80103740 <myproc>
8010436e:	8b 40 10             	mov    0x10(%eax),%eax
80104371:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80104374:	89 75 08             	mov    %esi,0x8(%ebp)
}
80104377:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010437a:	5b                   	pop    %ebx
8010437b:	5e                   	pop    %esi
8010437c:	5d                   	pop    %ebp
  release(&lk->lk);
8010437d:	e9 9e 02 00 00       	jmp    80104620 <release>
80104382:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104389:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104390 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
80104390:	55                   	push   %ebp
80104391:	89 e5                	mov    %esp,%ebp
80104393:	56                   	push   %esi
80104394:	53                   	push   %ebx
80104395:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104398:	83 ec 0c             	sub    $0xc,%esp
8010439b:	8d 73 04             	lea    0x4(%ebx),%esi
8010439e:	56                   	push   %esi
8010439f:	e8 bc 01 00 00       	call   80104560 <acquire>
  lk->locked = 0;
801043a4:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
801043aa:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
801043b1:	89 1c 24             	mov    %ebx,(%esp)
801043b4:	e8 77 fc ff ff       	call   80104030 <wakeup>
  release(&lk->lk);
801043b9:	89 75 08             	mov    %esi,0x8(%ebp)
801043bc:	83 c4 10             	add    $0x10,%esp
}
801043bf:	8d 65 f8             	lea    -0x8(%ebp),%esp
801043c2:	5b                   	pop    %ebx
801043c3:	5e                   	pop    %esi
801043c4:	5d                   	pop    %ebp
  release(&lk->lk);
801043c5:	e9 56 02 00 00       	jmp    80104620 <release>
801043ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801043d0 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
801043d0:	55                   	push   %ebp
801043d1:	89 e5                	mov    %esp,%ebp
801043d3:	57                   	push   %edi
801043d4:	56                   	push   %esi
801043d5:	53                   	push   %ebx
801043d6:	31 ff                	xor    %edi,%edi
801043d8:	83 ec 18             	sub    $0x18,%esp
801043db:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  
  acquire(&lk->lk);
801043de:	8d 73 04             	lea    0x4(%ebx),%esi
801043e1:	56                   	push   %esi
801043e2:	e8 79 01 00 00       	call   80104560 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
801043e7:	8b 03                	mov    (%ebx),%eax
801043e9:	83 c4 10             	add    $0x10,%esp
801043ec:	85 c0                	test   %eax,%eax
801043ee:	74 13                	je     80104403 <holdingsleep+0x33>
801043f0:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
801043f3:	e8 48 f3 ff ff       	call   80103740 <myproc>
801043f8:	39 58 10             	cmp    %ebx,0x10(%eax)
801043fb:	0f 94 c0             	sete   %al
801043fe:	0f b6 c0             	movzbl %al,%eax
80104401:	89 c7                	mov    %eax,%edi
  release(&lk->lk);
80104403:	83 ec 0c             	sub    $0xc,%esp
80104406:	56                   	push   %esi
80104407:	e8 14 02 00 00       	call   80104620 <release>
  return r;
}
8010440c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010440f:	89 f8                	mov    %edi,%eax
80104411:	5b                   	pop    %ebx
80104412:	5e                   	pop    %esi
80104413:	5f                   	pop    %edi
80104414:	5d                   	pop    %ebp
80104415:	c3                   	ret    
80104416:	66 90                	xchg   %ax,%ax
80104418:	66 90                	xchg   %ax,%ax
8010441a:	66 90                	xchg   %ax,%ax
8010441c:	66 90                	xchg   %ax,%ax
8010441e:	66 90                	xchg   %ax,%ax

80104420 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80104420:	55                   	push   %ebp
80104421:	89 e5                	mov    %esp,%ebp
80104423:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80104426:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80104429:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
8010442f:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
80104432:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80104439:	5d                   	pop    %ebp
8010443a:	c3                   	ret    
8010443b:	90                   	nop
8010443c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104440 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104440:	55                   	push   %ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104441:	31 d2                	xor    %edx,%edx
{
80104443:	89 e5                	mov    %esp,%ebp
80104445:	53                   	push   %ebx
  ebp = (uint*)v - 2;
80104446:	8b 45 08             	mov    0x8(%ebp),%eax
{
80104449:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  ebp = (uint*)v - 2;
8010444c:	83 e8 08             	sub    $0x8,%eax
8010444f:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104450:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
80104456:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
8010445c:	77 1a                	ja     80104478 <getcallerpcs+0x38>
      break;
    pcs[i] = ebp[1];     // saved %eip
8010445e:	8b 58 04             	mov    0x4(%eax),%ebx
80104461:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
80104464:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
80104467:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80104469:	83 fa 0a             	cmp    $0xa,%edx
8010446c:	75 e2                	jne    80104450 <getcallerpcs+0x10>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
8010446e:	5b                   	pop    %ebx
8010446f:	5d                   	pop    %ebp
80104470:	c3                   	ret    
80104471:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104478:	8d 04 91             	lea    (%ecx,%edx,4),%eax
8010447b:	83 c1 28             	add    $0x28,%ecx
8010447e:	66 90                	xchg   %ax,%ax
    pcs[i] = 0;
80104480:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104486:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
80104489:	39 c1                	cmp    %eax,%ecx
8010448b:	75 f3                	jne    80104480 <getcallerpcs+0x40>
}
8010448d:	5b                   	pop    %ebx
8010448e:	5d                   	pop    %ebp
8010448f:	c3                   	ret    

80104490 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80104490:	55                   	push   %ebp
80104491:	89 e5                	mov    %esp,%ebp
80104493:	53                   	push   %ebx
80104494:	83 ec 04             	sub    $0x4,%esp
80104497:	9c                   	pushf  
80104498:	5b                   	pop    %ebx
  asm volatile("cli");
80104499:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
8010449a:	e8 01 f2 ff ff       	call   801036a0 <mycpu>
8010449f:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
801044a5:	85 c0                	test   %eax,%eax
801044a7:	75 11                	jne    801044ba <pushcli+0x2a>
    mycpu()->intena = eflags & FL_IF;
801044a9:	81 e3 00 02 00 00    	and    $0x200,%ebx
801044af:	e8 ec f1 ff ff       	call   801036a0 <mycpu>
801044b4:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
  mycpu()->ncli += 1;
801044ba:	e8 e1 f1 ff ff       	call   801036a0 <mycpu>
801044bf:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
801044c6:	83 c4 04             	add    $0x4,%esp
801044c9:	5b                   	pop    %ebx
801044ca:	5d                   	pop    %ebp
801044cb:	c3                   	ret    
801044cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801044d0 <popcli>:

void
popcli(void)
{
801044d0:	55                   	push   %ebp
801044d1:	89 e5                	mov    %esp,%ebp
801044d3:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801044d6:	9c                   	pushf  
801044d7:	58                   	pop    %eax
  if(readeflags()&FL_IF)
801044d8:	f6 c4 02             	test   $0x2,%ah
801044db:	75 35                	jne    80104512 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
801044dd:	e8 be f1 ff ff       	call   801036a0 <mycpu>
801044e2:	83 a8 a4 00 00 00 01 	subl   $0x1,0xa4(%eax)
801044e9:	78 34                	js     8010451f <popcli+0x4f>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
801044eb:	e8 b0 f1 ff ff       	call   801036a0 <mycpu>
801044f0:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
801044f6:	85 d2                	test   %edx,%edx
801044f8:	74 06                	je     80104500 <popcli+0x30>
    sti();
}
801044fa:	c9                   	leave  
801044fb:	c3                   	ret    
801044fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104500:	e8 9b f1 ff ff       	call   801036a0 <mycpu>
80104505:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
8010450b:	85 c0                	test   %eax,%eax
8010450d:	74 eb                	je     801044fa <popcli+0x2a>
  asm volatile("sti");
8010450f:	fb                   	sti    
}
80104510:	c9                   	leave  
80104511:	c3                   	ret    
    panic("popcli - interruptible");
80104512:	83 ec 0c             	sub    $0xc,%esp
80104515:	68 23 78 10 80       	push   $0x80107823
8010451a:	e8 71 be ff ff       	call   80100390 <panic>
    panic("popcli");
8010451f:	83 ec 0c             	sub    $0xc,%esp
80104522:	68 3a 78 10 80       	push   $0x8010783a
80104527:	e8 64 be ff ff       	call   80100390 <panic>
8010452c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104530 <holding>:
{
80104530:	55                   	push   %ebp
80104531:	89 e5                	mov    %esp,%ebp
80104533:	56                   	push   %esi
80104534:	53                   	push   %ebx
80104535:	8b 75 08             	mov    0x8(%ebp),%esi
80104538:	31 db                	xor    %ebx,%ebx
  pushcli();
8010453a:	e8 51 ff ff ff       	call   80104490 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
8010453f:	8b 06                	mov    (%esi),%eax
80104541:	85 c0                	test   %eax,%eax
80104543:	74 10                	je     80104555 <holding+0x25>
80104545:	8b 5e 08             	mov    0x8(%esi),%ebx
80104548:	e8 53 f1 ff ff       	call   801036a0 <mycpu>
8010454d:	39 c3                	cmp    %eax,%ebx
8010454f:	0f 94 c3             	sete   %bl
80104552:	0f b6 db             	movzbl %bl,%ebx
  popcli();
80104555:	e8 76 ff ff ff       	call   801044d0 <popcli>
}
8010455a:	89 d8                	mov    %ebx,%eax
8010455c:	5b                   	pop    %ebx
8010455d:	5e                   	pop    %esi
8010455e:	5d                   	pop    %ebp
8010455f:	c3                   	ret    

80104560 <acquire>:
{
80104560:	55                   	push   %ebp
80104561:	89 e5                	mov    %esp,%ebp
80104563:	56                   	push   %esi
80104564:	53                   	push   %ebx
  pushcli(); // disable interrupts to avoid deadlock.
80104565:	e8 26 ff ff ff       	call   80104490 <pushcli>
  if(holding(lk))
8010456a:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010456d:	83 ec 0c             	sub    $0xc,%esp
80104570:	53                   	push   %ebx
80104571:	e8 ba ff ff ff       	call   80104530 <holding>
80104576:	83 c4 10             	add    $0x10,%esp
80104579:	85 c0                	test   %eax,%eax
8010457b:	0f 85 83 00 00 00    	jne    80104604 <acquire+0xa4>
80104581:	89 c6                	mov    %eax,%esi
  asm volatile("lock; xchgl %0, %1" :
80104583:	ba 01 00 00 00       	mov    $0x1,%edx
80104588:	eb 09                	jmp    80104593 <acquire+0x33>
8010458a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104590:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104593:	89 d0                	mov    %edx,%eax
80104595:	f0 87 03             	lock xchg %eax,(%ebx)
  while(xchg(&lk->locked, 1) != 0)
80104598:	85 c0                	test   %eax,%eax
8010459a:	75 f4                	jne    80104590 <acquire+0x30>
  __sync_synchronize();
8010459c:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
801045a1:	8b 5d 08             	mov    0x8(%ebp),%ebx
801045a4:	e8 f7 f0 ff ff       	call   801036a0 <mycpu>
  getcallerpcs(&lk, lk->pcs);
801045a9:	8d 53 0c             	lea    0xc(%ebx),%edx
  lk->cpu = mycpu();
801045ac:	89 43 08             	mov    %eax,0x8(%ebx)
  ebp = (uint*)v - 2;
801045af:	89 e8                	mov    %ebp,%eax
801045b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801045b8:	8d 88 00 00 00 80    	lea    -0x80000000(%eax),%ecx
801045be:	81 f9 fe ff ff 7f    	cmp    $0x7ffffffe,%ecx
801045c4:	77 1a                	ja     801045e0 <acquire+0x80>
    pcs[i] = ebp[1];     // saved %eip
801045c6:	8b 48 04             	mov    0x4(%eax),%ecx
801045c9:	89 0c b2             	mov    %ecx,(%edx,%esi,4)
  for(i = 0; i < 10; i++){
801045cc:	83 c6 01             	add    $0x1,%esi
    ebp = (uint*)ebp[0]; // saved %ebp
801045cf:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
801045d1:	83 fe 0a             	cmp    $0xa,%esi
801045d4:	75 e2                	jne    801045b8 <acquire+0x58>
}
801045d6:	8d 65 f8             	lea    -0x8(%ebp),%esp
801045d9:	5b                   	pop    %ebx
801045da:	5e                   	pop    %esi
801045db:	5d                   	pop    %ebp
801045dc:	c3                   	ret    
801045dd:	8d 76 00             	lea    0x0(%esi),%esi
801045e0:	8d 04 b2             	lea    (%edx,%esi,4),%eax
801045e3:	83 c2 28             	add    $0x28,%edx
801045e6:	8d 76 00             	lea    0x0(%esi),%esi
801045e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    pcs[i] = 0;
801045f0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
801045f6:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
801045f9:	39 d0                	cmp    %edx,%eax
801045fb:	75 f3                	jne    801045f0 <acquire+0x90>
}
801045fd:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104600:	5b                   	pop    %ebx
80104601:	5e                   	pop    %esi
80104602:	5d                   	pop    %ebp
80104603:	c3                   	ret    
    panic("acquire");
80104604:	83 ec 0c             	sub    $0xc,%esp
80104607:	68 41 78 10 80       	push   $0x80107841
8010460c:	e8 7f bd ff ff       	call   80100390 <panic>
80104611:	eb 0d                	jmp    80104620 <release>
80104613:	90                   	nop
80104614:	90                   	nop
80104615:	90                   	nop
80104616:	90                   	nop
80104617:	90                   	nop
80104618:	90                   	nop
80104619:	90                   	nop
8010461a:	90                   	nop
8010461b:	90                   	nop
8010461c:	90                   	nop
8010461d:	90                   	nop
8010461e:	90                   	nop
8010461f:	90                   	nop

80104620 <release>:
{
80104620:	55                   	push   %ebp
80104621:	89 e5                	mov    %esp,%ebp
80104623:	53                   	push   %ebx
80104624:	83 ec 10             	sub    $0x10,%esp
80104627:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holding(lk))
8010462a:	53                   	push   %ebx
8010462b:	e8 00 ff ff ff       	call   80104530 <holding>
80104630:	83 c4 10             	add    $0x10,%esp
80104633:	85 c0                	test   %eax,%eax
80104635:	74 22                	je     80104659 <release+0x39>
  lk->pcs[0] = 0;
80104637:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
8010463e:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
80104645:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
8010464a:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
80104650:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104653:	c9                   	leave  
  popcli();
80104654:	e9 77 fe ff ff       	jmp    801044d0 <popcli>
    panic("release");
80104659:	83 ec 0c             	sub    $0xc,%esp
8010465c:	68 49 78 10 80       	push   $0x80107849
80104661:	e8 2a bd ff ff       	call   80100390 <panic>
80104666:	66 90                	xchg   %ax,%ax
80104668:	66 90                	xchg   %ax,%ax
8010466a:	66 90                	xchg   %ax,%ax
8010466c:	66 90                	xchg   %ax,%ax
8010466e:	66 90                	xchg   %ax,%ax

80104670 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80104670:	55                   	push   %ebp
80104671:	89 e5                	mov    %esp,%ebp
80104673:	57                   	push   %edi
80104674:	53                   	push   %ebx
80104675:	8b 55 08             	mov    0x8(%ebp),%edx
80104678:	8b 4d 10             	mov    0x10(%ebp),%ecx
  if ((int)dst%4 == 0 && n%4 == 0){
8010467b:	f6 c2 03             	test   $0x3,%dl
8010467e:	75 05                	jne    80104685 <memset+0x15>
80104680:	f6 c1 03             	test   $0x3,%cl
80104683:	74 13                	je     80104698 <memset+0x28>
  asm volatile("cld; rep stosb" :
80104685:	89 d7                	mov    %edx,%edi
80104687:	8b 45 0c             	mov    0xc(%ebp),%eax
8010468a:	fc                   	cld    
8010468b:	f3 aa                	rep stos %al,%es:(%edi)
    c &= 0xFF;
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
8010468d:	5b                   	pop    %ebx
8010468e:	89 d0                	mov    %edx,%eax
80104690:	5f                   	pop    %edi
80104691:	5d                   	pop    %ebp
80104692:	c3                   	ret    
80104693:	90                   	nop
80104694:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c &= 0xFF;
80104698:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
8010469c:	c1 e9 02             	shr    $0x2,%ecx
8010469f:	89 f8                	mov    %edi,%eax
801046a1:	89 fb                	mov    %edi,%ebx
801046a3:	c1 e0 18             	shl    $0x18,%eax
801046a6:	c1 e3 10             	shl    $0x10,%ebx
801046a9:	09 d8                	or     %ebx,%eax
801046ab:	09 f8                	or     %edi,%eax
801046ad:	c1 e7 08             	shl    $0x8,%edi
801046b0:	09 f8                	or     %edi,%eax
  asm volatile("cld; rep stosl" :
801046b2:	89 d7                	mov    %edx,%edi
801046b4:	fc                   	cld    
801046b5:	f3 ab                	rep stos %eax,%es:(%edi)
}
801046b7:	5b                   	pop    %ebx
801046b8:	89 d0                	mov    %edx,%eax
801046ba:	5f                   	pop    %edi
801046bb:	5d                   	pop    %ebp
801046bc:	c3                   	ret    
801046bd:	8d 76 00             	lea    0x0(%esi),%esi

801046c0 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
801046c0:	55                   	push   %ebp
801046c1:	89 e5                	mov    %esp,%ebp
801046c3:	57                   	push   %edi
801046c4:	56                   	push   %esi
801046c5:	53                   	push   %ebx
801046c6:	8b 5d 10             	mov    0x10(%ebp),%ebx
801046c9:	8b 75 08             	mov    0x8(%ebp),%esi
801046cc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
801046cf:	85 db                	test   %ebx,%ebx
801046d1:	74 29                	je     801046fc <memcmp+0x3c>
    if(*s1 != *s2)
801046d3:	0f b6 16             	movzbl (%esi),%edx
801046d6:	0f b6 0f             	movzbl (%edi),%ecx
801046d9:	38 d1                	cmp    %dl,%cl
801046db:	75 2b                	jne    80104708 <memcmp+0x48>
801046dd:	b8 01 00 00 00       	mov    $0x1,%eax
801046e2:	eb 14                	jmp    801046f8 <memcmp+0x38>
801046e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801046e8:	0f b6 14 06          	movzbl (%esi,%eax,1),%edx
801046ec:	83 c0 01             	add    $0x1,%eax
801046ef:	0f b6 4c 07 ff       	movzbl -0x1(%edi,%eax,1),%ecx
801046f4:	38 ca                	cmp    %cl,%dl
801046f6:	75 10                	jne    80104708 <memcmp+0x48>
  while(n-- > 0){
801046f8:	39 d8                	cmp    %ebx,%eax
801046fa:	75 ec                	jne    801046e8 <memcmp+0x28>
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
}
801046fc:	5b                   	pop    %ebx
  return 0;
801046fd:	31 c0                	xor    %eax,%eax
}
801046ff:	5e                   	pop    %esi
80104700:	5f                   	pop    %edi
80104701:	5d                   	pop    %ebp
80104702:	c3                   	ret    
80104703:	90                   	nop
80104704:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      return *s1 - *s2;
80104708:	0f b6 c2             	movzbl %dl,%eax
}
8010470b:	5b                   	pop    %ebx
      return *s1 - *s2;
8010470c:	29 c8                	sub    %ecx,%eax
}
8010470e:	5e                   	pop    %esi
8010470f:	5f                   	pop    %edi
80104710:	5d                   	pop    %ebp
80104711:	c3                   	ret    
80104712:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104719:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104720 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80104720:	55                   	push   %ebp
80104721:	89 e5                	mov    %esp,%ebp
80104723:	56                   	push   %esi
80104724:	53                   	push   %ebx
80104725:	8b 45 08             	mov    0x8(%ebp),%eax
80104728:	8b 5d 0c             	mov    0xc(%ebp),%ebx
8010472b:	8b 75 10             	mov    0x10(%ebp),%esi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
8010472e:	39 c3                	cmp    %eax,%ebx
80104730:	73 26                	jae    80104758 <memmove+0x38>
80104732:	8d 0c 33             	lea    (%ebx,%esi,1),%ecx
80104735:	39 c8                	cmp    %ecx,%eax
80104737:	73 1f                	jae    80104758 <memmove+0x38>
    s += n;
    d += n;
    while(n-- > 0)
80104739:	85 f6                	test   %esi,%esi
8010473b:	8d 56 ff             	lea    -0x1(%esi),%edx
8010473e:	74 0f                	je     8010474f <memmove+0x2f>
      *--d = *--s;
80104740:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
80104744:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    while(n-- > 0)
80104747:	83 ea 01             	sub    $0x1,%edx
8010474a:	83 fa ff             	cmp    $0xffffffff,%edx
8010474d:	75 f1                	jne    80104740 <memmove+0x20>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
8010474f:	5b                   	pop    %ebx
80104750:	5e                   	pop    %esi
80104751:	5d                   	pop    %ebp
80104752:	c3                   	ret    
80104753:	90                   	nop
80104754:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    while(n-- > 0)
80104758:	31 d2                	xor    %edx,%edx
8010475a:	85 f6                	test   %esi,%esi
8010475c:	74 f1                	je     8010474f <memmove+0x2f>
8010475e:	66 90                	xchg   %ax,%ax
      *d++ = *s++;
80104760:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
80104764:	88 0c 10             	mov    %cl,(%eax,%edx,1)
80104767:	83 c2 01             	add    $0x1,%edx
    while(n-- > 0)
8010476a:	39 d6                	cmp    %edx,%esi
8010476c:	75 f2                	jne    80104760 <memmove+0x40>
}
8010476e:	5b                   	pop    %ebx
8010476f:	5e                   	pop    %esi
80104770:	5d                   	pop    %ebp
80104771:	c3                   	ret    
80104772:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104779:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104780 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
80104780:	55                   	push   %ebp
80104781:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
}
80104783:	5d                   	pop    %ebp
  return memmove(dst, src, n);
80104784:	eb 9a                	jmp    80104720 <memmove>
80104786:	8d 76 00             	lea    0x0(%esi),%esi
80104789:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104790 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
80104790:	55                   	push   %ebp
80104791:	89 e5                	mov    %esp,%ebp
80104793:	57                   	push   %edi
80104794:	56                   	push   %esi
80104795:	8b 7d 10             	mov    0x10(%ebp),%edi
80104798:	53                   	push   %ebx
80104799:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010479c:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(n > 0 && *p && *p == *q)
8010479f:	85 ff                	test   %edi,%edi
801047a1:	74 2f                	je     801047d2 <strncmp+0x42>
801047a3:	0f b6 01             	movzbl (%ecx),%eax
801047a6:	0f b6 1e             	movzbl (%esi),%ebx
801047a9:	84 c0                	test   %al,%al
801047ab:	74 37                	je     801047e4 <strncmp+0x54>
801047ad:	38 c3                	cmp    %al,%bl
801047af:	75 33                	jne    801047e4 <strncmp+0x54>
801047b1:	01 f7                	add    %esi,%edi
801047b3:	eb 13                	jmp    801047c8 <strncmp+0x38>
801047b5:	8d 76 00             	lea    0x0(%esi),%esi
801047b8:	0f b6 01             	movzbl (%ecx),%eax
801047bb:	84 c0                	test   %al,%al
801047bd:	74 21                	je     801047e0 <strncmp+0x50>
801047bf:	0f b6 1a             	movzbl (%edx),%ebx
801047c2:	89 d6                	mov    %edx,%esi
801047c4:	38 d8                	cmp    %bl,%al
801047c6:	75 1c                	jne    801047e4 <strncmp+0x54>
    n--, p++, q++;
801047c8:	8d 56 01             	lea    0x1(%esi),%edx
801047cb:	83 c1 01             	add    $0x1,%ecx
  while(n > 0 && *p && *p == *q)
801047ce:	39 fa                	cmp    %edi,%edx
801047d0:	75 e6                	jne    801047b8 <strncmp+0x28>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
}
801047d2:	5b                   	pop    %ebx
    return 0;
801047d3:	31 c0                	xor    %eax,%eax
}
801047d5:	5e                   	pop    %esi
801047d6:	5f                   	pop    %edi
801047d7:	5d                   	pop    %ebp
801047d8:	c3                   	ret    
801047d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801047e0:	0f b6 5e 01          	movzbl 0x1(%esi),%ebx
  return (uchar)*p - (uchar)*q;
801047e4:	29 d8                	sub    %ebx,%eax
}
801047e6:	5b                   	pop    %ebx
801047e7:	5e                   	pop    %esi
801047e8:	5f                   	pop    %edi
801047e9:	5d                   	pop    %ebp
801047ea:	c3                   	ret    
801047eb:	90                   	nop
801047ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801047f0 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
801047f0:	55                   	push   %ebp
801047f1:	89 e5                	mov    %esp,%ebp
801047f3:	56                   	push   %esi
801047f4:	53                   	push   %ebx
801047f5:	8b 45 08             	mov    0x8(%ebp),%eax
801047f8:	8b 5d 0c             	mov    0xc(%ebp),%ebx
801047fb:	8b 4d 10             	mov    0x10(%ebp),%ecx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
801047fe:	89 c2                	mov    %eax,%edx
80104800:	eb 19                	jmp    8010481b <strncpy+0x2b>
80104802:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104808:	83 c3 01             	add    $0x1,%ebx
8010480b:	0f b6 4b ff          	movzbl -0x1(%ebx),%ecx
8010480f:	83 c2 01             	add    $0x1,%edx
80104812:	84 c9                	test   %cl,%cl
80104814:	88 4a ff             	mov    %cl,-0x1(%edx)
80104817:	74 09                	je     80104822 <strncpy+0x32>
80104819:	89 f1                	mov    %esi,%ecx
8010481b:	85 c9                	test   %ecx,%ecx
8010481d:	8d 71 ff             	lea    -0x1(%ecx),%esi
80104820:	7f e6                	jg     80104808 <strncpy+0x18>
    ;
  while(n-- > 0)
80104822:	31 c9                	xor    %ecx,%ecx
80104824:	85 f6                	test   %esi,%esi
80104826:	7e 17                	jle    8010483f <strncpy+0x4f>
80104828:	90                   	nop
80104829:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    *s++ = 0;
80104830:	c6 04 0a 00          	movb   $0x0,(%edx,%ecx,1)
80104834:	89 f3                	mov    %esi,%ebx
80104836:	83 c1 01             	add    $0x1,%ecx
80104839:	29 cb                	sub    %ecx,%ebx
  while(n-- > 0)
8010483b:	85 db                	test   %ebx,%ebx
8010483d:	7f f1                	jg     80104830 <strncpy+0x40>
  return os;
}
8010483f:	5b                   	pop    %ebx
80104840:	5e                   	pop    %esi
80104841:	5d                   	pop    %ebp
80104842:	c3                   	ret    
80104843:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104849:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104850 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80104850:	55                   	push   %ebp
80104851:	89 e5                	mov    %esp,%ebp
80104853:	56                   	push   %esi
80104854:	53                   	push   %ebx
80104855:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104858:	8b 45 08             	mov    0x8(%ebp),%eax
8010485b:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  if(n <= 0)
8010485e:	85 c9                	test   %ecx,%ecx
80104860:	7e 26                	jle    80104888 <safestrcpy+0x38>
80104862:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
80104866:	89 c1                	mov    %eax,%ecx
80104868:	eb 17                	jmp    80104881 <safestrcpy+0x31>
8010486a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80104870:	83 c2 01             	add    $0x1,%edx
80104873:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
80104877:	83 c1 01             	add    $0x1,%ecx
8010487a:	84 db                	test   %bl,%bl
8010487c:	88 59 ff             	mov    %bl,-0x1(%ecx)
8010487f:	74 04                	je     80104885 <safestrcpy+0x35>
80104881:	39 f2                	cmp    %esi,%edx
80104883:	75 eb                	jne    80104870 <safestrcpy+0x20>
    ;
  *s = 0;
80104885:	c6 01 00             	movb   $0x0,(%ecx)
  return os;
}
80104888:	5b                   	pop    %ebx
80104889:	5e                   	pop    %esi
8010488a:	5d                   	pop    %ebp
8010488b:	c3                   	ret    
8010488c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104890 <strlen>:

int
strlen(const char *s)
{
80104890:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80104891:	31 c0                	xor    %eax,%eax
{
80104893:	89 e5                	mov    %esp,%ebp
80104895:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
80104898:	80 3a 00             	cmpb   $0x0,(%edx)
8010489b:	74 0c                	je     801048a9 <strlen+0x19>
8010489d:	8d 76 00             	lea    0x0(%esi),%esi
801048a0:	83 c0 01             	add    $0x1,%eax
801048a3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
801048a7:	75 f7                	jne    801048a0 <strlen+0x10>
    ;
  return n;
}
801048a9:	5d                   	pop    %ebp
801048aa:	c3                   	ret    

801048ab <swtch>:
801048ab:	8b 44 24 04          	mov    0x4(%esp),%eax
801048af:	8b 54 24 08          	mov    0x8(%esp),%edx
801048b3:	55                   	push   %ebp
801048b4:	53                   	push   %ebx
801048b5:	56                   	push   %esi
801048b6:	57                   	push   %edi
801048b7:	89 20                	mov    %esp,(%eax)
801048b9:	89 d4                	mov    %edx,%esp
801048bb:	5f                   	pop    %edi
801048bc:	5e                   	pop    %esi
801048bd:	5b                   	pop    %ebx
801048be:	5d                   	pop    %ebp
801048bf:	c3                   	ret    

801048c0 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
801048c0:	55                   	push   %ebp
801048c1:	89 e5                	mov    %esp,%ebp
801048c3:	53                   	push   %ebx
801048c4:	83 ec 04             	sub    $0x4,%esp
801048c7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
801048ca:	e8 71 ee ff ff       	call   80103740 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
801048cf:	8b 00                	mov    (%eax),%eax
801048d1:	39 d8                	cmp    %ebx,%eax
801048d3:	76 1b                	jbe    801048f0 <fetchint+0x30>
801048d5:	8d 53 04             	lea    0x4(%ebx),%edx
801048d8:	39 d0                	cmp    %edx,%eax
801048da:	72 14                	jb     801048f0 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
801048dc:	8b 45 0c             	mov    0xc(%ebp),%eax
801048df:	8b 13                	mov    (%ebx),%edx
801048e1:	89 10                	mov    %edx,(%eax)
  return 0;
801048e3:	31 c0                	xor    %eax,%eax
}
801048e5:	83 c4 04             	add    $0x4,%esp
801048e8:	5b                   	pop    %ebx
801048e9:	5d                   	pop    %ebp
801048ea:	c3                   	ret    
801048eb:	90                   	nop
801048ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801048f0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801048f5:	eb ee                	jmp    801048e5 <fetchint+0x25>
801048f7:	89 f6                	mov    %esi,%esi
801048f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104900 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80104900:	55                   	push   %ebp
80104901:	89 e5                	mov    %esp,%ebp
80104903:	53                   	push   %ebx
80104904:	83 ec 04             	sub    $0x4,%esp
80104907:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
8010490a:	e8 31 ee ff ff       	call   80103740 <myproc>

  if(addr >= curproc->sz)
8010490f:	39 18                	cmp    %ebx,(%eax)
80104911:	76 29                	jbe    8010493c <fetchstr+0x3c>
    return -1;
  *pp = (char*)addr;
80104913:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80104916:	89 da                	mov    %ebx,%edx
80104918:	89 19                	mov    %ebx,(%ecx)
  ep = (char*)curproc->sz;
8010491a:	8b 00                	mov    (%eax),%eax
  for(s = *pp; s < ep; s++){
8010491c:	39 c3                	cmp    %eax,%ebx
8010491e:	73 1c                	jae    8010493c <fetchstr+0x3c>
    if(*s == 0)
80104920:	80 3b 00             	cmpb   $0x0,(%ebx)
80104923:	75 10                	jne    80104935 <fetchstr+0x35>
80104925:	eb 39                	jmp    80104960 <fetchstr+0x60>
80104927:	89 f6                	mov    %esi,%esi
80104929:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104930:	80 3a 00             	cmpb   $0x0,(%edx)
80104933:	74 1b                	je     80104950 <fetchstr+0x50>
  for(s = *pp; s < ep; s++){
80104935:	83 c2 01             	add    $0x1,%edx
80104938:	39 d0                	cmp    %edx,%eax
8010493a:	77 f4                	ja     80104930 <fetchstr+0x30>
    return -1;
8010493c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      return s - *pp;
  }
  return -1;
}
80104941:	83 c4 04             	add    $0x4,%esp
80104944:	5b                   	pop    %ebx
80104945:	5d                   	pop    %ebp
80104946:	c3                   	ret    
80104947:	89 f6                	mov    %esi,%esi
80104949:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104950:	83 c4 04             	add    $0x4,%esp
80104953:	89 d0                	mov    %edx,%eax
80104955:	29 d8                	sub    %ebx,%eax
80104957:	5b                   	pop    %ebx
80104958:	5d                   	pop    %ebp
80104959:	c3                   	ret    
8010495a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(*s == 0)
80104960:	31 c0                	xor    %eax,%eax
      return s - *pp;
80104962:	eb dd                	jmp    80104941 <fetchstr+0x41>
80104964:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010496a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104970 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80104970:	55                   	push   %ebp
80104971:	89 e5                	mov    %esp,%ebp
80104973:	56                   	push   %esi
80104974:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104975:	e8 c6 ed ff ff       	call   80103740 <myproc>
8010497a:	8b 40 18             	mov    0x18(%eax),%eax
8010497d:	8b 55 08             	mov    0x8(%ebp),%edx
80104980:	8b 40 44             	mov    0x44(%eax),%eax
80104983:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80104986:	e8 b5 ed ff ff       	call   80103740 <myproc>
  if(addr >= curproc->sz || addr+4 > curproc->sz)
8010498b:	8b 00                	mov    (%eax),%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
8010498d:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104990:	39 c6                	cmp    %eax,%esi
80104992:	73 1c                	jae    801049b0 <argint+0x40>
80104994:	8d 53 08             	lea    0x8(%ebx),%edx
80104997:	39 d0                	cmp    %edx,%eax
80104999:	72 15                	jb     801049b0 <argint+0x40>
  *ip = *(int*)(addr);
8010499b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010499e:	8b 53 04             	mov    0x4(%ebx),%edx
801049a1:	89 10                	mov    %edx,(%eax)
  return 0;
801049a3:	31 c0                	xor    %eax,%eax
}
801049a5:	5b                   	pop    %ebx
801049a6:	5e                   	pop    %esi
801049a7:	5d                   	pop    %ebp
801049a8:	c3                   	ret    
801049a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801049b0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801049b5:	eb ee                	jmp    801049a5 <argint+0x35>
801049b7:	89 f6                	mov    %esi,%esi
801049b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801049c0 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
801049c0:	55                   	push   %ebp
801049c1:	89 e5                	mov    %esp,%ebp
801049c3:	56                   	push   %esi
801049c4:	53                   	push   %ebx
801049c5:	83 ec 10             	sub    $0x10,%esp
801049c8:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int i;
  struct proc *curproc = myproc();
801049cb:	e8 70 ed ff ff       	call   80103740 <myproc>
801049d0:	89 c6                	mov    %eax,%esi
 
  if(argint(n, &i) < 0)
801049d2:	8d 45 f4             	lea    -0xc(%ebp),%eax
801049d5:	83 ec 08             	sub    $0x8,%esp
801049d8:	50                   	push   %eax
801049d9:	ff 75 08             	pushl  0x8(%ebp)
801049dc:	e8 8f ff ff ff       	call   80104970 <argint>
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
801049e1:	83 c4 10             	add    $0x10,%esp
801049e4:	85 c0                	test   %eax,%eax
801049e6:	78 28                	js     80104a10 <argptr+0x50>
801049e8:	85 db                	test   %ebx,%ebx
801049ea:	78 24                	js     80104a10 <argptr+0x50>
801049ec:	8b 16                	mov    (%esi),%edx
801049ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
801049f1:	39 c2                	cmp    %eax,%edx
801049f3:	76 1b                	jbe    80104a10 <argptr+0x50>
801049f5:	01 c3                	add    %eax,%ebx
801049f7:	39 da                	cmp    %ebx,%edx
801049f9:	72 15                	jb     80104a10 <argptr+0x50>
    return -1;
  *pp = (char*)i;
801049fb:	8b 55 0c             	mov    0xc(%ebp),%edx
801049fe:	89 02                	mov    %eax,(%edx)
  return 0;
80104a00:	31 c0                	xor    %eax,%eax
}
80104a02:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104a05:	5b                   	pop    %ebx
80104a06:	5e                   	pop    %esi
80104a07:	5d                   	pop    %ebp
80104a08:	c3                   	ret    
80104a09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104a10:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104a15:	eb eb                	jmp    80104a02 <argptr+0x42>
80104a17:	89 f6                	mov    %esi,%esi
80104a19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104a20 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80104a20:	55                   	push   %ebp
80104a21:	89 e5                	mov    %esp,%ebp
80104a23:	83 ec 20             	sub    $0x20,%esp
  int addr;
  if(argint(n, &addr) < 0)
80104a26:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104a29:	50                   	push   %eax
80104a2a:	ff 75 08             	pushl  0x8(%ebp)
80104a2d:	e8 3e ff ff ff       	call   80104970 <argint>
80104a32:	83 c4 10             	add    $0x10,%esp
80104a35:	85 c0                	test   %eax,%eax
80104a37:	78 17                	js     80104a50 <argstr+0x30>
    return -1;
  return fetchstr(addr, pp);
80104a39:	83 ec 08             	sub    $0x8,%esp
80104a3c:	ff 75 0c             	pushl  0xc(%ebp)
80104a3f:	ff 75 f4             	pushl  -0xc(%ebp)
80104a42:	e8 b9 fe ff ff       	call   80104900 <fetchstr>
80104a47:	83 c4 10             	add    $0x10,%esp
}
80104a4a:	c9                   	leave  
80104a4b:	c3                   	ret    
80104a4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104a50:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104a55:	c9                   	leave  
80104a56:	c3                   	ret    
80104a57:	89 f6                	mov    %esi,%esi
80104a59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104a60 <syscall>:
[SYS_sigret] sys_sigret
};

void
syscall(void)
{
80104a60:	55                   	push   %ebp
80104a61:	89 e5                	mov    %esp,%ebp
80104a63:	53                   	push   %ebx
80104a64:	83 ec 04             	sub    $0x4,%esp
  int num;
  struct proc *curproc = myproc();
80104a67:	e8 d4 ec ff ff       	call   80103740 <myproc>
80104a6c:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
80104a6e:	8b 40 18             	mov    0x18(%eax),%eax
80104a71:	8b 40 1c             	mov    0x1c(%eax),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80104a74:	8d 50 ff             	lea    -0x1(%eax),%edx
80104a77:	83 fa 17             	cmp    $0x17,%edx
80104a7a:	77 1c                	ja     80104a98 <syscall+0x38>
80104a7c:	8b 14 85 80 78 10 80 	mov    -0x7fef8780(,%eax,4),%edx
80104a83:	85 d2                	test   %edx,%edx
80104a85:	74 11                	je     80104a98 <syscall+0x38>
    curproc->tf->eax = syscalls[num]();
80104a87:	ff d2                	call   *%edx
80104a89:	8b 53 18             	mov    0x18(%ebx),%edx
80104a8c:	89 42 1c             	mov    %eax,0x1c(%edx)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
80104a8f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104a92:	c9                   	leave  
80104a93:	c3                   	ret    
80104a94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("%d %s: unknown sys call %d\n",
80104a98:	50                   	push   %eax
            curproc->pid, curproc->name, num);
80104a99:	8d 43 6c             	lea    0x6c(%ebx),%eax
    cprintf("%d %s: unknown sys call %d\n",
80104a9c:	50                   	push   %eax
80104a9d:	ff 73 10             	pushl  0x10(%ebx)
80104aa0:	68 51 78 10 80       	push   $0x80107851
80104aa5:	e8 b6 bb ff ff       	call   80100660 <cprintf>
    curproc->tf->eax = -1;
80104aaa:	8b 43 18             	mov    0x18(%ebx),%eax
80104aad:	83 c4 10             	add    $0x10,%esp
80104ab0:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
80104ab7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104aba:	c9                   	leave  
80104abb:	c3                   	ret    
80104abc:	66 90                	xchg   %ax,%ax
80104abe:	66 90                	xchg   %ax,%ax

80104ac0 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104ac0:	55                   	push   %ebp
80104ac1:	89 e5                	mov    %esp,%ebp
80104ac3:	57                   	push   %edi
80104ac4:	56                   	push   %esi
80104ac5:	53                   	push   %ebx
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104ac6:	8d 75 da             	lea    -0x26(%ebp),%esi
{
80104ac9:	83 ec 34             	sub    $0x34,%esp
80104acc:	89 4d d0             	mov    %ecx,-0x30(%ebp)
80104acf:	8b 4d 08             	mov    0x8(%ebp),%ecx
  if((dp = nameiparent(path, name)) == 0)
80104ad2:	56                   	push   %esi
80104ad3:	50                   	push   %eax
{
80104ad4:	89 55 d4             	mov    %edx,-0x2c(%ebp)
80104ad7:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  if((dp = nameiparent(path, name)) == 0)
80104ada:	e8 51 d4 ff ff       	call   80101f30 <nameiparent>
80104adf:	83 c4 10             	add    $0x10,%esp
80104ae2:	85 c0                	test   %eax,%eax
80104ae4:	0f 84 46 01 00 00    	je     80104c30 <create+0x170>
    return 0;
  ilock(dp);
80104aea:	83 ec 0c             	sub    $0xc,%esp
80104aed:	89 c3                	mov    %eax,%ebx
80104aef:	50                   	push   %eax
80104af0:	e8 bb cb ff ff       	call   801016b0 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
80104af5:	83 c4 0c             	add    $0xc,%esp
80104af8:	6a 00                	push   $0x0
80104afa:	56                   	push   %esi
80104afb:	53                   	push   %ebx
80104afc:	e8 df d0 ff ff       	call   80101be0 <dirlookup>
80104b01:	83 c4 10             	add    $0x10,%esp
80104b04:	85 c0                	test   %eax,%eax
80104b06:	89 c7                	mov    %eax,%edi
80104b08:	74 36                	je     80104b40 <create+0x80>
    iunlockput(dp);
80104b0a:	83 ec 0c             	sub    $0xc,%esp
80104b0d:	53                   	push   %ebx
80104b0e:	e8 2d ce ff ff       	call   80101940 <iunlockput>
    ilock(ip);
80104b13:	89 3c 24             	mov    %edi,(%esp)
80104b16:	e8 95 cb ff ff       	call   801016b0 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
80104b1b:	83 c4 10             	add    $0x10,%esp
80104b1e:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
80104b23:	0f 85 97 00 00 00    	jne    80104bc0 <create+0x100>
80104b29:	66 83 7f 50 02       	cmpw   $0x2,0x50(%edi)
80104b2e:	0f 85 8c 00 00 00    	jne    80104bc0 <create+0x100>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104b34:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104b37:	89 f8                	mov    %edi,%eax
80104b39:	5b                   	pop    %ebx
80104b3a:	5e                   	pop    %esi
80104b3b:	5f                   	pop    %edi
80104b3c:	5d                   	pop    %ebp
80104b3d:	c3                   	ret    
80104b3e:	66 90                	xchg   %ax,%ax
  if((ip = ialloc(dp->dev, type)) == 0)
80104b40:	0f bf 45 d4          	movswl -0x2c(%ebp),%eax
80104b44:	83 ec 08             	sub    $0x8,%esp
80104b47:	50                   	push   %eax
80104b48:	ff 33                	pushl  (%ebx)
80104b4a:	e8 f1 c9 ff ff       	call   80101540 <ialloc>
80104b4f:	83 c4 10             	add    $0x10,%esp
80104b52:	85 c0                	test   %eax,%eax
80104b54:	89 c7                	mov    %eax,%edi
80104b56:	0f 84 e8 00 00 00    	je     80104c44 <create+0x184>
  ilock(ip);
80104b5c:	83 ec 0c             	sub    $0xc,%esp
80104b5f:	50                   	push   %eax
80104b60:	e8 4b cb ff ff       	call   801016b0 <ilock>
  ip->major = major;
80104b65:	0f b7 45 d0          	movzwl -0x30(%ebp),%eax
80104b69:	66 89 47 52          	mov    %ax,0x52(%edi)
  ip->minor = minor;
80104b6d:	0f b7 45 cc          	movzwl -0x34(%ebp),%eax
80104b71:	66 89 47 54          	mov    %ax,0x54(%edi)
  ip->nlink = 1;
80104b75:	b8 01 00 00 00       	mov    $0x1,%eax
80104b7a:	66 89 47 56          	mov    %ax,0x56(%edi)
  iupdate(ip);
80104b7e:	89 3c 24             	mov    %edi,(%esp)
80104b81:	e8 7a ca ff ff       	call   80101600 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
80104b86:	83 c4 10             	add    $0x10,%esp
80104b89:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
80104b8e:	74 50                	je     80104be0 <create+0x120>
  if(dirlink(dp, name, ip->inum) < 0)
80104b90:	83 ec 04             	sub    $0x4,%esp
80104b93:	ff 77 04             	pushl  0x4(%edi)
80104b96:	56                   	push   %esi
80104b97:	53                   	push   %ebx
80104b98:	e8 b3 d2 ff ff       	call   80101e50 <dirlink>
80104b9d:	83 c4 10             	add    $0x10,%esp
80104ba0:	85 c0                	test   %eax,%eax
80104ba2:	0f 88 8f 00 00 00    	js     80104c37 <create+0x177>
  iunlockput(dp);
80104ba8:	83 ec 0c             	sub    $0xc,%esp
80104bab:	53                   	push   %ebx
80104bac:	e8 8f cd ff ff       	call   80101940 <iunlockput>
  return ip;
80104bb1:	83 c4 10             	add    $0x10,%esp
}
80104bb4:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104bb7:	89 f8                	mov    %edi,%eax
80104bb9:	5b                   	pop    %ebx
80104bba:	5e                   	pop    %esi
80104bbb:	5f                   	pop    %edi
80104bbc:	5d                   	pop    %ebp
80104bbd:	c3                   	ret    
80104bbe:	66 90                	xchg   %ax,%ax
    iunlockput(ip);
80104bc0:	83 ec 0c             	sub    $0xc,%esp
80104bc3:	57                   	push   %edi
    return 0;
80104bc4:	31 ff                	xor    %edi,%edi
    iunlockput(ip);
80104bc6:	e8 75 cd ff ff       	call   80101940 <iunlockput>
    return 0;
80104bcb:	83 c4 10             	add    $0x10,%esp
}
80104bce:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104bd1:	89 f8                	mov    %edi,%eax
80104bd3:	5b                   	pop    %ebx
80104bd4:	5e                   	pop    %esi
80104bd5:	5f                   	pop    %edi
80104bd6:	5d                   	pop    %ebp
80104bd7:	c3                   	ret    
80104bd8:	90                   	nop
80104bd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    dp->nlink++;  // for ".."
80104be0:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
    iupdate(dp);
80104be5:	83 ec 0c             	sub    $0xc,%esp
80104be8:	53                   	push   %ebx
80104be9:	e8 12 ca ff ff       	call   80101600 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80104bee:	83 c4 0c             	add    $0xc,%esp
80104bf1:	ff 77 04             	pushl  0x4(%edi)
80104bf4:	68 00 79 10 80       	push   $0x80107900
80104bf9:	57                   	push   %edi
80104bfa:	e8 51 d2 ff ff       	call   80101e50 <dirlink>
80104bff:	83 c4 10             	add    $0x10,%esp
80104c02:	85 c0                	test   %eax,%eax
80104c04:	78 1c                	js     80104c22 <create+0x162>
80104c06:	83 ec 04             	sub    $0x4,%esp
80104c09:	ff 73 04             	pushl  0x4(%ebx)
80104c0c:	68 ff 78 10 80       	push   $0x801078ff
80104c11:	57                   	push   %edi
80104c12:	e8 39 d2 ff ff       	call   80101e50 <dirlink>
80104c17:	83 c4 10             	add    $0x10,%esp
80104c1a:	85 c0                	test   %eax,%eax
80104c1c:	0f 89 6e ff ff ff    	jns    80104b90 <create+0xd0>
      panic("create dots");
80104c22:	83 ec 0c             	sub    $0xc,%esp
80104c25:	68 f3 78 10 80       	push   $0x801078f3
80104c2a:	e8 61 b7 ff ff       	call   80100390 <panic>
80104c2f:	90                   	nop
    return 0;
80104c30:	31 ff                	xor    %edi,%edi
80104c32:	e9 fd fe ff ff       	jmp    80104b34 <create+0x74>
    panic("create: dirlink");
80104c37:	83 ec 0c             	sub    $0xc,%esp
80104c3a:	68 02 79 10 80       	push   $0x80107902
80104c3f:	e8 4c b7 ff ff       	call   80100390 <panic>
    panic("create: ialloc");
80104c44:	83 ec 0c             	sub    $0xc,%esp
80104c47:	68 e4 78 10 80       	push   $0x801078e4
80104c4c:	e8 3f b7 ff ff       	call   80100390 <panic>
80104c51:	eb 0d                	jmp    80104c60 <argfd.constprop.0>
80104c53:	90                   	nop
80104c54:	90                   	nop
80104c55:	90                   	nop
80104c56:	90                   	nop
80104c57:	90                   	nop
80104c58:	90                   	nop
80104c59:	90                   	nop
80104c5a:	90                   	nop
80104c5b:	90                   	nop
80104c5c:	90                   	nop
80104c5d:	90                   	nop
80104c5e:	90                   	nop
80104c5f:	90                   	nop

80104c60 <argfd.constprop.0>:
argfd(int n, int *pfd, struct file **pf)
80104c60:	55                   	push   %ebp
80104c61:	89 e5                	mov    %esp,%ebp
80104c63:	56                   	push   %esi
80104c64:	53                   	push   %ebx
80104c65:	89 c3                	mov    %eax,%ebx
  if(argint(n, &fd) < 0)
80104c67:	8d 45 f4             	lea    -0xc(%ebp),%eax
argfd(int n, int *pfd, struct file **pf)
80104c6a:	89 d6                	mov    %edx,%esi
80104c6c:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80104c6f:	50                   	push   %eax
80104c70:	6a 00                	push   $0x0
80104c72:	e8 f9 fc ff ff       	call   80104970 <argint>
80104c77:	83 c4 10             	add    $0x10,%esp
80104c7a:	85 c0                	test   %eax,%eax
80104c7c:	78 2a                	js     80104ca8 <argfd.constprop.0+0x48>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80104c7e:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80104c82:	77 24                	ja     80104ca8 <argfd.constprop.0+0x48>
80104c84:	e8 b7 ea ff ff       	call   80103740 <myproc>
80104c89:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104c8c:	8b 44 90 28          	mov    0x28(%eax,%edx,4),%eax
80104c90:	85 c0                	test   %eax,%eax
80104c92:	74 14                	je     80104ca8 <argfd.constprop.0+0x48>
  if(pfd)
80104c94:	85 db                	test   %ebx,%ebx
80104c96:	74 02                	je     80104c9a <argfd.constprop.0+0x3a>
    *pfd = fd;
80104c98:	89 13                	mov    %edx,(%ebx)
    *pf = f;
80104c9a:	89 06                	mov    %eax,(%esi)
  return 0;
80104c9c:	31 c0                	xor    %eax,%eax
}
80104c9e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104ca1:	5b                   	pop    %ebx
80104ca2:	5e                   	pop    %esi
80104ca3:	5d                   	pop    %ebp
80104ca4:	c3                   	ret    
80104ca5:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80104ca8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104cad:	eb ef                	jmp    80104c9e <argfd.constprop.0+0x3e>
80104caf:	90                   	nop

80104cb0 <sys_dup>:
{
80104cb0:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0)
80104cb1:	31 c0                	xor    %eax,%eax
{
80104cb3:	89 e5                	mov    %esp,%ebp
80104cb5:	56                   	push   %esi
80104cb6:	53                   	push   %ebx
  if(argfd(0, 0, &f) < 0)
80104cb7:	8d 55 f4             	lea    -0xc(%ebp),%edx
{
80104cba:	83 ec 10             	sub    $0x10,%esp
  if(argfd(0, 0, &f) < 0)
80104cbd:	e8 9e ff ff ff       	call   80104c60 <argfd.constprop.0>
80104cc2:	85 c0                	test   %eax,%eax
80104cc4:	78 42                	js     80104d08 <sys_dup+0x58>
  if((fd=fdalloc(f)) < 0)
80104cc6:	8b 75 f4             	mov    -0xc(%ebp),%esi
  for(fd = 0; fd < NOFILE; fd++){
80104cc9:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
80104ccb:	e8 70 ea ff ff       	call   80103740 <myproc>
80104cd0:	eb 0e                	jmp    80104ce0 <sys_dup+0x30>
80104cd2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(fd = 0; fd < NOFILE; fd++){
80104cd8:	83 c3 01             	add    $0x1,%ebx
80104cdb:	83 fb 10             	cmp    $0x10,%ebx
80104cde:	74 28                	je     80104d08 <sys_dup+0x58>
    if(curproc->ofile[fd] == 0){
80104ce0:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80104ce4:	85 d2                	test   %edx,%edx
80104ce6:	75 f0                	jne    80104cd8 <sys_dup+0x28>
      curproc->ofile[fd] = f;
80104ce8:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
  filedup(f);
80104cec:	83 ec 0c             	sub    $0xc,%esp
80104cef:	ff 75 f4             	pushl  -0xc(%ebp)
80104cf2:	e8 29 c1 ff ff       	call   80100e20 <filedup>
  return fd;
80104cf7:	83 c4 10             	add    $0x10,%esp
}
80104cfa:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104cfd:	89 d8                	mov    %ebx,%eax
80104cff:	5b                   	pop    %ebx
80104d00:	5e                   	pop    %esi
80104d01:	5d                   	pop    %ebp
80104d02:	c3                   	ret    
80104d03:	90                   	nop
80104d04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104d08:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return -1;
80104d0b:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
80104d10:	89 d8                	mov    %ebx,%eax
80104d12:	5b                   	pop    %ebx
80104d13:	5e                   	pop    %esi
80104d14:	5d                   	pop    %ebp
80104d15:	c3                   	ret    
80104d16:	8d 76 00             	lea    0x0(%esi),%esi
80104d19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104d20 <sys_read>:
{
80104d20:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104d21:	31 c0                	xor    %eax,%eax
{
80104d23:	89 e5                	mov    %esp,%ebp
80104d25:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104d28:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104d2b:	e8 30 ff ff ff       	call   80104c60 <argfd.constprop.0>
80104d30:	85 c0                	test   %eax,%eax
80104d32:	78 4c                	js     80104d80 <sys_read+0x60>
80104d34:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104d37:	83 ec 08             	sub    $0x8,%esp
80104d3a:	50                   	push   %eax
80104d3b:	6a 02                	push   $0x2
80104d3d:	e8 2e fc ff ff       	call   80104970 <argint>
80104d42:	83 c4 10             	add    $0x10,%esp
80104d45:	85 c0                	test   %eax,%eax
80104d47:	78 37                	js     80104d80 <sys_read+0x60>
80104d49:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104d4c:	83 ec 04             	sub    $0x4,%esp
80104d4f:	ff 75 f0             	pushl  -0x10(%ebp)
80104d52:	50                   	push   %eax
80104d53:	6a 01                	push   $0x1
80104d55:	e8 66 fc ff ff       	call   801049c0 <argptr>
80104d5a:	83 c4 10             	add    $0x10,%esp
80104d5d:	85 c0                	test   %eax,%eax
80104d5f:	78 1f                	js     80104d80 <sys_read+0x60>
  return fileread(f, p, n);
80104d61:	83 ec 04             	sub    $0x4,%esp
80104d64:	ff 75 f0             	pushl  -0x10(%ebp)
80104d67:	ff 75 f4             	pushl  -0xc(%ebp)
80104d6a:	ff 75 ec             	pushl  -0x14(%ebp)
80104d6d:	e8 1e c2 ff ff       	call   80100f90 <fileread>
80104d72:	83 c4 10             	add    $0x10,%esp
}
80104d75:	c9                   	leave  
80104d76:	c3                   	ret    
80104d77:	89 f6                	mov    %esi,%esi
80104d79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80104d80:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104d85:	c9                   	leave  
80104d86:	c3                   	ret    
80104d87:	89 f6                	mov    %esi,%esi
80104d89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104d90 <sys_write>:
{
80104d90:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104d91:	31 c0                	xor    %eax,%eax
{
80104d93:	89 e5                	mov    %esp,%ebp
80104d95:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104d98:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104d9b:	e8 c0 fe ff ff       	call   80104c60 <argfd.constprop.0>
80104da0:	85 c0                	test   %eax,%eax
80104da2:	78 4c                	js     80104df0 <sys_write+0x60>
80104da4:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104da7:	83 ec 08             	sub    $0x8,%esp
80104daa:	50                   	push   %eax
80104dab:	6a 02                	push   $0x2
80104dad:	e8 be fb ff ff       	call   80104970 <argint>
80104db2:	83 c4 10             	add    $0x10,%esp
80104db5:	85 c0                	test   %eax,%eax
80104db7:	78 37                	js     80104df0 <sys_write+0x60>
80104db9:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104dbc:	83 ec 04             	sub    $0x4,%esp
80104dbf:	ff 75 f0             	pushl  -0x10(%ebp)
80104dc2:	50                   	push   %eax
80104dc3:	6a 01                	push   $0x1
80104dc5:	e8 f6 fb ff ff       	call   801049c0 <argptr>
80104dca:	83 c4 10             	add    $0x10,%esp
80104dcd:	85 c0                	test   %eax,%eax
80104dcf:	78 1f                	js     80104df0 <sys_write+0x60>
  return filewrite(f, p, n);
80104dd1:	83 ec 04             	sub    $0x4,%esp
80104dd4:	ff 75 f0             	pushl  -0x10(%ebp)
80104dd7:	ff 75 f4             	pushl  -0xc(%ebp)
80104dda:	ff 75 ec             	pushl  -0x14(%ebp)
80104ddd:	e8 3e c2 ff ff       	call   80101020 <filewrite>
80104de2:	83 c4 10             	add    $0x10,%esp
}
80104de5:	c9                   	leave  
80104de6:	c3                   	ret    
80104de7:	89 f6                	mov    %esi,%esi
80104de9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80104df0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104df5:	c9                   	leave  
80104df6:	c3                   	ret    
80104df7:	89 f6                	mov    %esi,%esi
80104df9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104e00 <sys_close>:
{
80104e00:	55                   	push   %ebp
80104e01:	89 e5                	mov    %esp,%ebp
80104e03:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, &fd, &f) < 0)
80104e06:	8d 55 f4             	lea    -0xc(%ebp),%edx
80104e09:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104e0c:	e8 4f fe ff ff       	call   80104c60 <argfd.constprop.0>
80104e11:	85 c0                	test   %eax,%eax
80104e13:	78 2b                	js     80104e40 <sys_close+0x40>
  myproc()->ofile[fd] = 0;
80104e15:	e8 26 e9 ff ff       	call   80103740 <myproc>
80104e1a:	8b 55 f0             	mov    -0x10(%ebp),%edx
  fileclose(f);
80104e1d:	83 ec 0c             	sub    $0xc,%esp
  myproc()->ofile[fd] = 0;
80104e20:	c7 44 90 28 00 00 00 	movl   $0x0,0x28(%eax,%edx,4)
80104e27:	00 
  fileclose(f);
80104e28:	ff 75 f4             	pushl  -0xc(%ebp)
80104e2b:	e8 40 c0 ff ff       	call   80100e70 <fileclose>
  return 0;
80104e30:	83 c4 10             	add    $0x10,%esp
80104e33:	31 c0                	xor    %eax,%eax
}
80104e35:	c9                   	leave  
80104e36:	c3                   	ret    
80104e37:	89 f6                	mov    %esi,%esi
80104e39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80104e40:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104e45:	c9                   	leave  
80104e46:	c3                   	ret    
80104e47:	89 f6                	mov    %esi,%esi
80104e49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104e50 <sys_fstat>:
{
80104e50:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80104e51:	31 c0                	xor    %eax,%eax
{
80104e53:	89 e5                	mov    %esp,%ebp
80104e55:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80104e58:	8d 55 f0             	lea    -0x10(%ebp),%edx
80104e5b:	e8 00 fe ff ff       	call   80104c60 <argfd.constprop.0>
80104e60:	85 c0                	test   %eax,%eax
80104e62:	78 2c                	js     80104e90 <sys_fstat+0x40>
80104e64:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104e67:	83 ec 04             	sub    $0x4,%esp
80104e6a:	6a 14                	push   $0x14
80104e6c:	50                   	push   %eax
80104e6d:	6a 01                	push   $0x1
80104e6f:	e8 4c fb ff ff       	call   801049c0 <argptr>
80104e74:	83 c4 10             	add    $0x10,%esp
80104e77:	85 c0                	test   %eax,%eax
80104e79:	78 15                	js     80104e90 <sys_fstat+0x40>
  return filestat(f, st);
80104e7b:	83 ec 08             	sub    $0x8,%esp
80104e7e:	ff 75 f4             	pushl  -0xc(%ebp)
80104e81:	ff 75 f0             	pushl  -0x10(%ebp)
80104e84:	e8 b7 c0 ff ff       	call   80100f40 <filestat>
80104e89:	83 c4 10             	add    $0x10,%esp
}
80104e8c:	c9                   	leave  
80104e8d:	c3                   	ret    
80104e8e:	66 90                	xchg   %ax,%ax
    return -1;
80104e90:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104e95:	c9                   	leave  
80104e96:	c3                   	ret    
80104e97:	89 f6                	mov    %esi,%esi
80104e99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104ea0 <sys_link>:
{
80104ea0:	55                   	push   %ebp
80104ea1:	89 e5                	mov    %esp,%ebp
80104ea3:	57                   	push   %edi
80104ea4:	56                   	push   %esi
80104ea5:	53                   	push   %ebx
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80104ea6:	8d 45 d4             	lea    -0x2c(%ebp),%eax
{
80104ea9:	83 ec 34             	sub    $0x34,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80104eac:	50                   	push   %eax
80104ead:	6a 00                	push   $0x0
80104eaf:	e8 6c fb ff ff       	call   80104a20 <argstr>
80104eb4:	83 c4 10             	add    $0x10,%esp
80104eb7:	85 c0                	test   %eax,%eax
80104eb9:	0f 88 fb 00 00 00    	js     80104fba <sys_link+0x11a>
80104ebf:	8d 45 d0             	lea    -0x30(%ebp),%eax
80104ec2:	83 ec 08             	sub    $0x8,%esp
80104ec5:	50                   	push   %eax
80104ec6:	6a 01                	push   $0x1
80104ec8:	e8 53 fb ff ff       	call   80104a20 <argstr>
80104ecd:	83 c4 10             	add    $0x10,%esp
80104ed0:	85 c0                	test   %eax,%eax
80104ed2:	0f 88 e2 00 00 00    	js     80104fba <sys_link+0x11a>
  begin_op();
80104ed8:	e8 f3 dc ff ff       	call   80102bd0 <begin_op>
  if((ip = namei(old)) == 0){
80104edd:	83 ec 0c             	sub    $0xc,%esp
80104ee0:	ff 75 d4             	pushl  -0x2c(%ebp)
80104ee3:	e8 28 d0 ff ff       	call   80101f10 <namei>
80104ee8:	83 c4 10             	add    $0x10,%esp
80104eeb:	85 c0                	test   %eax,%eax
80104eed:	89 c3                	mov    %eax,%ebx
80104eef:	0f 84 ea 00 00 00    	je     80104fdf <sys_link+0x13f>
  ilock(ip);
80104ef5:	83 ec 0c             	sub    $0xc,%esp
80104ef8:	50                   	push   %eax
80104ef9:	e8 b2 c7 ff ff       	call   801016b0 <ilock>
  if(ip->type == T_DIR){
80104efe:	83 c4 10             	add    $0x10,%esp
80104f01:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80104f06:	0f 84 bb 00 00 00    	je     80104fc7 <sys_link+0x127>
  ip->nlink++;
80104f0c:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  iupdate(ip);
80104f11:	83 ec 0c             	sub    $0xc,%esp
  if((dp = nameiparent(new, name)) == 0)
80104f14:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
80104f17:	53                   	push   %ebx
80104f18:	e8 e3 c6 ff ff       	call   80101600 <iupdate>
  iunlock(ip);
80104f1d:	89 1c 24             	mov    %ebx,(%esp)
80104f20:	e8 6b c8 ff ff       	call   80101790 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
80104f25:	58                   	pop    %eax
80104f26:	5a                   	pop    %edx
80104f27:	57                   	push   %edi
80104f28:	ff 75 d0             	pushl  -0x30(%ebp)
80104f2b:	e8 00 d0 ff ff       	call   80101f30 <nameiparent>
80104f30:	83 c4 10             	add    $0x10,%esp
80104f33:	85 c0                	test   %eax,%eax
80104f35:	89 c6                	mov    %eax,%esi
80104f37:	74 5b                	je     80104f94 <sys_link+0xf4>
  ilock(dp);
80104f39:	83 ec 0c             	sub    $0xc,%esp
80104f3c:	50                   	push   %eax
80104f3d:	e8 6e c7 ff ff       	call   801016b0 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80104f42:	83 c4 10             	add    $0x10,%esp
80104f45:	8b 03                	mov    (%ebx),%eax
80104f47:	39 06                	cmp    %eax,(%esi)
80104f49:	75 3d                	jne    80104f88 <sys_link+0xe8>
80104f4b:	83 ec 04             	sub    $0x4,%esp
80104f4e:	ff 73 04             	pushl  0x4(%ebx)
80104f51:	57                   	push   %edi
80104f52:	56                   	push   %esi
80104f53:	e8 f8 ce ff ff       	call   80101e50 <dirlink>
80104f58:	83 c4 10             	add    $0x10,%esp
80104f5b:	85 c0                	test   %eax,%eax
80104f5d:	78 29                	js     80104f88 <sys_link+0xe8>
  iunlockput(dp);
80104f5f:	83 ec 0c             	sub    $0xc,%esp
80104f62:	56                   	push   %esi
80104f63:	e8 d8 c9 ff ff       	call   80101940 <iunlockput>
  iput(ip);
80104f68:	89 1c 24             	mov    %ebx,(%esp)
80104f6b:	e8 70 c8 ff ff       	call   801017e0 <iput>
  end_op();
80104f70:	e8 cb dc ff ff       	call   80102c40 <end_op>
  return 0;
80104f75:	83 c4 10             	add    $0x10,%esp
80104f78:	31 c0                	xor    %eax,%eax
}
80104f7a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104f7d:	5b                   	pop    %ebx
80104f7e:	5e                   	pop    %esi
80104f7f:	5f                   	pop    %edi
80104f80:	5d                   	pop    %ebp
80104f81:	c3                   	ret    
80104f82:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(dp);
80104f88:	83 ec 0c             	sub    $0xc,%esp
80104f8b:	56                   	push   %esi
80104f8c:	e8 af c9 ff ff       	call   80101940 <iunlockput>
    goto bad;
80104f91:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80104f94:	83 ec 0c             	sub    $0xc,%esp
80104f97:	53                   	push   %ebx
80104f98:	e8 13 c7 ff ff       	call   801016b0 <ilock>
  ip->nlink--;
80104f9d:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80104fa2:	89 1c 24             	mov    %ebx,(%esp)
80104fa5:	e8 56 c6 ff ff       	call   80101600 <iupdate>
  iunlockput(ip);
80104faa:	89 1c 24             	mov    %ebx,(%esp)
80104fad:	e8 8e c9 ff ff       	call   80101940 <iunlockput>
  end_op();
80104fb2:	e8 89 dc ff ff       	call   80102c40 <end_op>
  return -1;
80104fb7:	83 c4 10             	add    $0x10,%esp
}
80104fba:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
80104fbd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104fc2:	5b                   	pop    %ebx
80104fc3:	5e                   	pop    %esi
80104fc4:	5f                   	pop    %edi
80104fc5:	5d                   	pop    %ebp
80104fc6:	c3                   	ret    
    iunlockput(ip);
80104fc7:	83 ec 0c             	sub    $0xc,%esp
80104fca:	53                   	push   %ebx
80104fcb:	e8 70 c9 ff ff       	call   80101940 <iunlockput>
    end_op();
80104fd0:	e8 6b dc ff ff       	call   80102c40 <end_op>
    return -1;
80104fd5:	83 c4 10             	add    $0x10,%esp
80104fd8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104fdd:	eb 9b                	jmp    80104f7a <sys_link+0xda>
    end_op();
80104fdf:	e8 5c dc ff ff       	call   80102c40 <end_op>
    return -1;
80104fe4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104fe9:	eb 8f                	jmp    80104f7a <sys_link+0xda>
80104feb:	90                   	nop
80104fec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104ff0 <sys_unlink>:
{
80104ff0:	55                   	push   %ebp
80104ff1:	89 e5                	mov    %esp,%ebp
80104ff3:	57                   	push   %edi
80104ff4:	56                   	push   %esi
80104ff5:	53                   	push   %ebx
  if(argstr(0, &path) < 0)
80104ff6:	8d 45 c0             	lea    -0x40(%ebp),%eax
{
80104ff9:	83 ec 44             	sub    $0x44,%esp
  if(argstr(0, &path) < 0)
80104ffc:	50                   	push   %eax
80104ffd:	6a 00                	push   $0x0
80104fff:	e8 1c fa ff ff       	call   80104a20 <argstr>
80105004:	83 c4 10             	add    $0x10,%esp
80105007:	85 c0                	test   %eax,%eax
80105009:	0f 88 77 01 00 00    	js     80105186 <sys_unlink+0x196>
  if((dp = nameiparent(path, name)) == 0){
8010500f:	8d 5d ca             	lea    -0x36(%ebp),%ebx
  begin_op();
80105012:	e8 b9 db ff ff       	call   80102bd0 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80105017:	83 ec 08             	sub    $0x8,%esp
8010501a:	53                   	push   %ebx
8010501b:	ff 75 c0             	pushl  -0x40(%ebp)
8010501e:	e8 0d cf ff ff       	call   80101f30 <nameiparent>
80105023:	83 c4 10             	add    $0x10,%esp
80105026:	85 c0                	test   %eax,%eax
80105028:	89 c6                	mov    %eax,%esi
8010502a:	0f 84 60 01 00 00    	je     80105190 <sys_unlink+0x1a0>
  ilock(dp);
80105030:	83 ec 0c             	sub    $0xc,%esp
80105033:	50                   	push   %eax
80105034:	e8 77 c6 ff ff       	call   801016b0 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
80105039:	58                   	pop    %eax
8010503a:	5a                   	pop    %edx
8010503b:	68 00 79 10 80       	push   $0x80107900
80105040:	53                   	push   %ebx
80105041:	e8 7a cb ff ff       	call   80101bc0 <namecmp>
80105046:	83 c4 10             	add    $0x10,%esp
80105049:	85 c0                	test   %eax,%eax
8010504b:	0f 84 03 01 00 00    	je     80105154 <sys_unlink+0x164>
80105051:	83 ec 08             	sub    $0x8,%esp
80105054:	68 ff 78 10 80       	push   $0x801078ff
80105059:	53                   	push   %ebx
8010505a:	e8 61 cb ff ff       	call   80101bc0 <namecmp>
8010505f:	83 c4 10             	add    $0x10,%esp
80105062:	85 c0                	test   %eax,%eax
80105064:	0f 84 ea 00 00 00    	je     80105154 <sys_unlink+0x164>
  if((ip = dirlookup(dp, name, &off)) == 0)
8010506a:	8d 45 c4             	lea    -0x3c(%ebp),%eax
8010506d:	83 ec 04             	sub    $0x4,%esp
80105070:	50                   	push   %eax
80105071:	53                   	push   %ebx
80105072:	56                   	push   %esi
80105073:	e8 68 cb ff ff       	call   80101be0 <dirlookup>
80105078:	83 c4 10             	add    $0x10,%esp
8010507b:	85 c0                	test   %eax,%eax
8010507d:	89 c3                	mov    %eax,%ebx
8010507f:	0f 84 cf 00 00 00    	je     80105154 <sys_unlink+0x164>
  ilock(ip);
80105085:	83 ec 0c             	sub    $0xc,%esp
80105088:	50                   	push   %eax
80105089:	e8 22 c6 ff ff       	call   801016b0 <ilock>
  if(ip->nlink < 1)
8010508e:	83 c4 10             	add    $0x10,%esp
80105091:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80105096:	0f 8e 10 01 00 00    	jle    801051ac <sys_unlink+0x1bc>
  if(ip->type == T_DIR && !isdirempty(ip)){
8010509c:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801050a1:	74 6d                	je     80105110 <sys_unlink+0x120>
  memset(&de, 0, sizeof(de));
801050a3:	8d 45 d8             	lea    -0x28(%ebp),%eax
801050a6:	83 ec 04             	sub    $0x4,%esp
801050a9:	6a 10                	push   $0x10
801050ab:	6a 00                	push   $0x0
801050ad:	50                   	push   %eax
801050ae:	e8 bd f5 ff ff       	call   80104670 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801050b3:	8d 45 d8             	lea    -0x28(%ebp),%eax
801050b6:	6a 10                	push   $0x10
801050b8:	ff 75 c4             	pushl  -0x3c(%ebp)
801050bb:	50                   	push   %eax
801050bc:	56                   	push   %esi
801050bd:	e8 ce c9 ff ff       	call   80101a90 <writei>
801050c2:	83 c4 20             	add    $0x20,%esp
801050c5:	83 f8 10             	cmp    $0x10,%eax
801050c8:	0f 85 eb 00 00 00    	jne    801051b9 <sys_unlink+0x1c9>
  if(ip->type == T_DIR){
801050ce:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801050d3:	0f 84 97 00 00 00    	je     80105170 <sys_unlink+0x180>
  iunlockput(dp);
801050d9:	83 ec 0c             	sub    $0xc,%esp
801050dc:	56                   	push   %esi
801050dd:	e8 5e c8 ff ff       	call   80101940 <iunlockput>
  ip->nlink--;
801050e2:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
801050e7:	89 1c 24             	mov    %ebx,(%esp)
801050ea:	e8 11 c5 ff ff       	call   80101600 <iupdate>
  iunlockput(ip);
801050ef:	89 1c 24             	mov    %ebx,(%esp)
801050f2:	e8 49 c8 ff ff       	call   80101940 <iunlockput>
  end_op();
801050f7:	e8 44 db ff ff       	call   80102c40 <end_op>
  return 0;
801050fc:	83 c4 10             	add    $0x10,%esp
801050ff:	31 c0                	xor    %eax,%eax
}
80105101:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105104:	5b                   	pop    %ebx
80105105:	5e                   	pop    %esi
80105106:	5f                   	pop    %edi
80105107:	5d                   	pop    %ebp
80105108:	c3                   	ret    
80105109:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105110:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
80105114:	76 8d                	jbe    801050a3 <sys_unlink+0xb3>
80105116:	bf 20 00 00 00       	mov    $0x20,%edi
8010511b:	eb 0f                	jmp    8010512c <sys_unlink+0x13c>
8010511d:	8d 76 00             	lea    0x0(%esi),%esi
80105120:	83 c7 10             	add    $0x10,%edi
80105123:	3b 7b 58             	cmp    0x58(%ebx),%edi
80105126:	0f 83 77 ff ff ff    	jae    801050a3 <sys_unlink+0xb3>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
8010512c:	8d 45 d8             	lea    -0x28(%ebp),%eax
8010512f:	6a 10                	push   $0x10
80105131:	57                   	push   %edi
80105132:	50                   	push   %eax
80105133:	53                   	push   %ebx
80105134:	e8 57 c8 ff ff       	call   80101990 <readi>
80105139:	83 c4 10             	add    $0x10,%esp
8010513c:	83 f8 10             	cmp    $0x10,%eax
8010513f:	75 5e                	jne    8010519f <sys_unlink+0x1af>
    if(de.inum != 0)
80105141:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80105146:	74 d8                	je     80105120 <sys_unlink+0x130>
    iunlockput(ip);
80105148:	83 ec 0c             	sub    $0xc,%esp
8010514b:	53                   	push   %ebx
8010514c:	e8 ef c7 ff ff       	call   80101940 <iunlockput>
    goto bad;
80105151:	83 c4 10             	add    $0x10,%esp
  iunlockput(dp);
80105154:	83 ec 0c             	sub    $0xc,%esp
80105157:	56                   	push   %esi
80105158:	e8 e3 c7 ff ff       	call   80101940 <iunlockput>
  end_op();
8010515d:	e8 de da ff ff       	call   80102c40 <end_op>
  return -1;
80105162:	83 c4 10             	add    $0x10,%esp
80105165:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010516a:	eb 95                	jmp    80105101 <sys_unlink+0x111>
8010516c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    dp->nlink--;
80105170:	66 83 6e 56 01       	subw   $0x1,0x56(%esi)
    iupdate(dp);
80105175:	83 ec 0c             	sub    $0xc,%esp
80105178:	56                   	push   %esi
80105179:	e8 82 c4 ff ff       	call   80101600 <iupdate>
8010517e:	83 c4 10             	add    $0x10,%esp
80105181:	e9 53 ff ff ff       	jmp    801050d9 <sys_unlink+0xe9>
    return -1;
80105186:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010518b:	e9 71 ff ff ff       	jmp    80105101 <sys_unlink+0x111>
    end_op();
80105190:	e8 ab da ff ff       	call   80102c40 <end_op>
    return -1;
80105195:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010519a:	e9 62 ff ff ff       	jmp    80105101 <sys_unlink+0x111>
      panic("isdirempty: readi");
8010519f:	83 ec 0c             	sub    $0xc,%esp
801051a2:	68 24 79 10 80       	push   $0x80107924
801051a7:	e8 e4 b1 ff ff       	call   80100390 <panic>
    panic("unlink: nlink < 1");
801051ac:	83 ec 0c             	sub    $0xc,%esp
801051af:	68 12 79 10 80       	push   $0x80107912
801051b4:	e8 d7 b1 ff ff       	call   80100390 <panic>
    panic("unlink: writei");
801051b9:	83 ec 0c             	sub    $0xc,%esp
801051bc:	68 36 79 10 80       	push   $0x80107936
801051c1:	e8 ca b1 ff ff       	call   80100390 <panic>
801051c6:	8d 76 00             	lea    0x0(%esi),%esi
801051c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801051d0 <sys_open>:

int
sys_open(void)
{
801051d0:	55                   	push   %ebp
801051d1:	89 e5                	mov    %esp,%ebp
801051d3:	57                   	push   %edi
801051d4:	56                   	push   %esi
801051d5:	53                   	push   %ebx
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
801051d6:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
801051d9:	83 ec 24             	sub    $0x24,%esp
  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
801051dc:	50                   	push   %eax
801051dd:	6a 00                	push   $0x0
801051df:	e8 3c f8 ff ff       	call   80104a20 <argstr>
801051e4:	83 c4 10             	add    $0x10,%esp
801051e7:	85 c0                	test   %eax,%eax
801051e9:	0f 88 1d 01 00 00    	js     8010530c <sys_open+0x13c>
801051ef:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801051f2:	83 ec 08             	sub    $0x8,%esp
801051f5:	50                   	push   %eax
801051f6:	6a 01                	push   $0x1
801051f8:	e8 73 f7 ff ff       	call   80104970 <argint>
801051fd:	83 c4 10             	add    $0x10,%esp
80105200:	85 c0                	test   %eax,%eax
80105202:	0f 88 04 01 00 00    	js     8010530c <sys_open+0x13c>
    return -1;

  begin_op();
80105208:	e8 c3 d9 ff ff       	call   80102bd0 <begin_op>

  if(omode & O_CREATE){
8010520d:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
80105211:	0f 85 a9 00 00 00    	jne    801052c0 <sys_open+0xf0>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
80105217:	83 ec 0c             	sub    $0xc,%esp
8010521a:	ff 75 e0             	pushl  -0x20(%ebp)
8010521d:	e8 ee cc ff ff       	call   80101f10 <namei>
80105222:	83 c4 10             	add    $0x10,%esp
80105225:	85 c0                	test   %eax,%eax
80105227:	89 c6                	mov    %eax,%esi
80105229:	0f 84 b2 00 00 00    	je     801052e1 <sys_open+0x111>
      end_op();
      return -1;
    }
    ilock(ip);
8010522f:	83 ec 0c             	sub    $0xc,%esp
80105232:	50                   	push   %eax
80105233:	e8 78 c4 ff ff       	call   801016b0 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
80105238:	83 c4 10             	add    $0x10,%esp
8010523b:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80105240:	0f 84 aa 00 00 00    	je     801052f0 <sys_open+0x120>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
80105246:	e8 65 bb ff ff       	call   80100db0 <filealloc>
8010524b:	85 c0                	test   %eax,%eax
8010524d:	89 c7                	mov    %eax,%edi
8010524f:	0f 84 a6 00 00 00    	je     801052fb <sys_open+0x12b>
  struct proc *curproc = myproc();
80105255:	e8 e6 e4 ff ff       	call   80103740 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
8010525a:	31 db                	xor    %ebx,%ebx
8010525c:	eb 0e                	jmp    8010526c <sys_open+0x9c>
8010525e:	66 90                	xchg   %ax,%ax
80105260:	83 c3 01             	add    $0x1,%ebx
80105263:	83 fb 10             	cmp    $0x10,%ebx
80105266:	0f 84 ac 00 00 00    	je     80105318 <sys_open+0x148>
    if(curproc->ofile[fd] == 0){
8010526c:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105270:	85 d2                	test   %edx,%edx
80105272:	75 ec                	jne    80105260 <sys_open+0x90>
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105274:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
80105277:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
  iunlock(ip);
8010527b:	56                   	push   %esi
8010527c:	e8 0f c5 ff ff       	call   80101790 <iunlock>
  end_op();
80105281:	e8 ba d9 ff ff       	call   80102c40 <end_op>

  f->type = FD_INODE;
80105286:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
8010528c:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
8010528f:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
80105292:	89 77 10             	mov    %esi,0x10(%edi)
  f->off = 0;
80105295:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
8010529c:	89 d0                	mov    %edx,%eax
8010529e:	f7 d0                	not    %eax
801052a0:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801052a3:	83 e2 03             	and    $0x3,%edx
  f->readable = !(omode & O_WRONLY);
801052a6:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801052a9:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
801052ad:	8d 65 f4             	lea    -0xc(%ebp),%esp
801052b0:	89 d8                	mov    %ebx,%eax
801052b2:	5b                   	pop    %ebx
801052b3:	5e                   	pop    %esi
801052b4:	5f                   	pop    %edi
801052b5:	5d                   	pop    %ebp
801052b6:	c3                   	ret    
801052b7:	89 f6                	mov    %esi,%esi
801052b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    ip = create(path, T_FILE, 0, 0);
801052c0:	83 ec 0c             	sub    $0xc,%esp
801052c3:	8b 45 e0             	mov    -0x20(%ebp),%eax
801052c6:	31 c9                	xor    %ecx,%ecx
801052c8:	6a 00                	push   $0x0
801052ca:	ba 02 00 00 00       	mov    $0x2,%edx
801052cf:	e8 ec f7 ff ff       	call   80104ac0 <create>
    if(ip == 0){
801052d4:	83 c4 10             	add    $0x10,%esp
801052d7:	85 c0                	test   %eax,%eax
    ip = create(path, T_FILE, 0, 0);
801052d9:	89 c6                	mov    %eax,%esi
    if(ip == 0){
801052db:	0f 85 65 ff ff ff    	jne    80105246 <sys_open+0x76>
      end_op();
801052e1:	e8 5a d9 ff ff       	call   80102c40 <end_op>
      return -1;
801052e6:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801052eb:	eb c0                	jmp    801052ad <sys_open+0xdd>
801052ed:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->type == T_DIR && omode != O_RDONLY){
801052f0:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801052f3:	85 c9                	test   %ecx,%ecx
801052f5:	0f 84 4b ff ff ff    	je     80105246 <sys_open+0x76>
    iunlockput(ip);
801052fb:	83 ec 0c             	sub    $0xc,%esp
801052fe:	56                   	push   %esi
801052ff:	e8 3c c6 ff ff       	call   80101940 <iunlockput>
    end_op();
80105304:	e8 37 d9 ff ff       	call   80102c40 <end_op>
    return -1;
80105309:	83 c4 10             	add    $0x10,%esp
8010530c:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105311:	eb 9a                	jmp    801052ad <sys_open+0xdd>
80105313:	90                   	nop
80105314:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      fileclose(f);
80105318:	83 ec 0c             	sub    $0xc,%esp
8010531b:	57                   	push   %edi
8010531c:	e8 4f bb ff ff       	call   80100e70 <fileclose>
80105321:	83 c4 10             	add    $0x10,%esp
80105324:	eb d5                	jmp    801052fb <sys_open+0x12b>
80105326:	8d 76 00             	lea    0x0(%esi),%esi
80105329:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105330 <sys_mkdir>:

int
sys_mkdir(void)
{
80105330:	55                   	push   %ebp
80105331:	89 e5                	mov    %esp,%ebp
80105333:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
80105336:	e8 95 d8 ff ff       	call   80102bd0 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
8010533b:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010533e:	83 ec 08             	sub    $0x8,%esp
80105341:	50                   	push   %eax
80105342:	6a 00                	push   $0x0
80105344:	e8 d7 f6 ff ff       	call   80104a20 <argstr>
80105349:	83 c4 10             	add    $0x10,%esp
8010534c:	85 c0                	test   %eax,%eax
8010534e:	78 30                	js     80105380 <sys_mkdir+0x50>
80105350:	83 ec 0c             	sub    $0xc,%esp
80105353:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105356:	31 c9                	xor    %ecx,%ecx
80105358:	6a 00                	push   $0x0
8010535a:	ba 01 00 00 00       	mov    $0x1,%edx
8010535f:	e8 5c f7 ff ff       	call   80104ac0 <create>
80105364:	83 c4 10             	add    $0x10,%esp
80105367:	85 c0                	test   %eax,%eax
80105369:	74 15                	je     80105380 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010536b:	83 ec 0c             	sub    $0xc,%esp
8010536e:	50                   	push   %eax
8010536f:	e8 cc c5 ff ff       	call   80101940 <iunlockput>
  end_op();
80105374:	e8 c7 d8 ff ff       	call   80102c40 <end_op>
  return 0;
80105379:	83 c4 10             	add    $0x10,%esp
8010537c:	31 c0                	xor    %eax,%eax
}
8010537e:	c9                   	leave  
8010537f:	c3                   	ret    
    end_op();
80105380:	e8 bb d8 ff ff       	call   80102c40 <end_op>
    return -1;
80105385:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010538a:	c9                   	leave  
8010538b:	c3                   	ret    
8010538c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105390 <sys_mknod>:

int
sys_mknod(void)
{
80105390:	55                   	push   %ebp
80105391:	89 e5                	mov    %esp,%ebp
80105393:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80105396:	e8 35 d8 ff ff       	call   80102bd0 <begin_op>
  if((argstr(0, &path)) < 0 ||
8010539b:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010539e:	83 ec 08             	sub    $0x8,%esp
801053a1:	50                   	push   %eax
801053a2:	6a 00                	push   $0x0
801053a4:	e8 77 f6 ff ff       	call   80104a20 <argstr>
801053a9:	83 c4 10             	add    $0x10,%esp
801053ac:	85 c0                	test   %eax,%eax
801053ae:	78 60                	js     80105410 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
801053b0:	8d 45 f0             	lea    -0x10(%ebp),%eax
801053b3:	83 ec 08             	sub    $0x8,%esp
801053b6:	50                   	push   %eax
801053b7:	6a 01                	push   $0x1
801053b9:	e8 b2 f5 ff ff       	call   80104970 <argint>
  if((argstr(0, &path)) < 0 ||
801053be:	83 c4 10             	add    $0x10,%esp
801053c1:	85 c0                	test   %eax,%eax
801053c3:	78 4b                	js     80105410 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
801053c5:	8d 45 f4             	lea    -0xc(%ebp),%eax
801053c8:	83 ec 08             	sub    $0x8,%esp
801053cb:	50                   	push   %eax
801053cc:	6a 02                	push   $0x2
801053ce:	e8 9d f5 ff ff       	call   80104970 <argint>
     argint(1, &major) < 0 ||
801053d3:	83 c4 10             	add    $0x10,%esp
801053d6:	85 c0                	test   %eax,%eax
801053d8:	78 36                	js     80105410 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
801053da:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
     argint(2, &minor) < 0 ||
801053de:	83 ec 0c             	sub    $0xc,%esp
     (ip = create(path, T_DEV, major, minor)) == 0){
801053e1:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
     argint(2, &minor) < 0 ||
801053e5:	ba 03 00 00 00       	mov    $0x3,%edx
801053ea:	50                   	push   %eax
801053eb:	8b 45 ec             	mov    -0x14(%ebp),%eax
801053ee:	e8 cd f6 ff ff       	call   80104ac0 <create>
801053f3:	83 c4 10             	add    $0x10,%esp
801053f6:	85 c0                	test   %eax,%eax
801053f8:	74 16                	je     80105410 <sys_mknod+0x80>
    end_op();
    return -1;
  }
  iunlockput(ip);
801053fa:	83 ec 0c             	sub    $0xc,%esp
801053fd:	50                   	push   %eax
801053fe:	e8 3d c5 ff ff       	call   80101940 <iunlockput>
  end_op();
80105403:	e8 38 d8 ff ff       	call   80102c40 <end_op>
  return 0;
80105408:	83 c4 10             	add    $0x10,%esp
8010540b:	31 c0                	xor    %eax,%eax
}
8010540d:	c9                   	leave  
8010540e:	c3                   	ret    
8010540f:	90                   	nop
    end_op();
80105410:	e8 2b d8 ff ff       	call   80102c40 <end_op>
    return -1;
80105415:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010541a:	c9                   	leave  
8010541b:	c3                   	ret    
8010541c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105420 <sys_chdir>:

int
sys_chdir(void)
{
80105420:	55                   	push   %ebp
80105421:	89 e5                	mov    %esp,%ebp
80105423:	56                   	push   %esi
80105424:	53                   	push   %ebx
80105425:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
80105428:	e8 13 e3 ff ff       	call   80103740 <myproc>
8010542d:	89 c6                	mov    %eax,%esi
  
  begin_op();
8010542f:	e8 9c d7 ff ff       	call   80102bd0 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80105434:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105437:	83 ec 08             	sub    $0x8,%esp
8010543a:	50                   	push   %eax
8010543b:	6a 00                	push   $0x0
8010543d:	e8 de f5 ff ff       	call   80104a20 <argstr>
80105442:	83 c4 10             	add    $0x10,%esp
80105445:	85 c0                	test   %eax,%eax
80105447:	78 77                	js     801054c0 <sys_chdir+0xa0>
80105449:	83 ec 0c             	sub    $0xc,%esp
8010544c:	ff 75 f4             	pushl  -0xc(%ebp)
8010544f:	e8 bc ca ff ff       	call   80101f10 <namei>
80105454:	83 c4 10             	add    $0x10,%esp
80105457:	85 c0                	test   %eax,%eax
80105459:	89 c3                	mov    %eax,%ebx
8010545b:	74 63                	je     801054c0 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
8010545d:	83 ec 0c             	sub    $0xc,%esp
80105460:	50                   	push   %eax
80105461:	e8 4a c2 ff ff       	call   801016b0 <ilock>
  if(ip->type != T_DIR){
80105466:	83 c4 10             	add    $0x10,%esp
80105469:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
8010546e:	75 30                	jne    801054a0 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105470:	83 ec 0c             	sub    $0xc,%esp
80105473:	53                   	push   %ebx
80105474:	e8 17 c3 ff ff       	call   80101790 <iunlock>
  iput(curproc->cwd);
80105479:	58                   	pop    %eax
8010547a:	ff 76 68             	pushl  0x68(%esi)
8010547d:	e8 5e c3 ff ff       	call   801017e0 <iput>
  end_op();
80105482:	e8 b9 d7 ff ff       	call   80102c40 <end_op>
  curproc->cwd = ip;
80105487:	89 5e 68             	mov    %ebx,0x68(%esi)
  return 0;
8010548a:	83 c4 10             	add    $0x10,%esp
8010548d:	31 c0                	xor    %eax,%eax
}
8010548f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105492:	5b                   	pop    %ebx
80105493:	5e                   	pop    %esi
80105494:	5d                   	pop    %ebp
80105495:	c3                   	ret    
80105496:	8d 76 00             	lea    0x0(%esi),%esi
80105499:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    iunlockput(ip);
801054a0:	83 ec 0c             	sub    $0xc,%esp
801054a3:	53                   	push   %ebx
801054a4:	e8 97 c4 ff ff       	call   80101940 <iunlockput>
    end_op();
801054a9:	e8 92 d7 ff ff       	call   80102c40 <end_op>
    return -1;
801054ae:	83 c4 10             	add    $0x10,%esp
801054b1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801054b6:	eb d7                	jmp    8010548f <sys_chdir+0x6f>
801054b8:	90                   	nop
801054b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    end_op();
801054c0:	e8 7b d7 ff ff       	call   80102c40 <end_op>
    return -1;
801054c5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801054ca:	eb c3                	jmp    8010548f <sys_chdir+0x6f>
801054cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801054d0 <sys_exec>:

int
sys_exec(void)
{
801054d0:	55                   	push   %ebp
801054d1:	89 e5                	mov    %esp,%ebp
801054d3:	57                   	push   %edi
801054d4:	56                   	push   %esi
801054d5:	53                   	push   %ebx
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
801054d6:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
{
801054dc:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
801054e2:	50                   	push   %eax
801054e3:	6a 00                	push   $0x0
801054e5:	e8 36 f5 ff ff       	call   80104a20 <argstr>
801054ea:	83 c4 10             	add    $0x10,%esp
801054ed:	85 c0                	test   %eax,%eax
801054ef:	0f 88 87 00 00 00    	js     8010557c <sys_exec+0xac>
801054f5:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
801054fb:	83 ec 08             	sub    $0x8,%esp
801054fe:	50                   	push   %eax
801054ff:	6a 01                	push   $0x1
80105501:	e8 6a f4 ff ff       	call   80104970 <argint>
80105506:	83 c4 10             	add    $0x10,%esp
80105509:	85 c0                	test   %eax,%eax
8010550b:	78 6f                	js     8010557c <sys_exec+0xac>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
8010550d:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80105513:	83 ec 04             	sub    $0x4,%esp
  for(i=0;; i++){
80105516:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
80105518:	68 80 00 00 00       	push   $0x80
8010551d:	6a 00                	push   $0x0
8010551f:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
80105525:	50                   	push   %eax
80105526:	e8 45 f1 ff ff       	call   80104670 <memset>
8010552b:	83 c4 10             	add    $0x10,%esp
8010552e:	eb 2c                	jmp    8010555c <sys_exec+0x8c>
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
      return -1;
    if(uarg == 0){
80105530:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80105536:	85 c0                	test   %eax,%eax
80105538:	74 56                	je     80105590 <sys_exec+0xc0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
8010553a:	8d 8d 68 ff ff ff    	lea    -0x98(%ebp),%ecx
80105540:	83 ec 08             	sub    $0x8,%esp
80105543:	8d 14 31             	lea    (%ecx,%esi,1),%edx
80105546:	52                   	push   %edx
80105547:	50                   	push   %eax
80105548:	e8 b3 f3 ff ff       	call   80104900 <fetchstr>
8010554d:	83 c4 10             	add    $0x10,%esp
80105550:	85 c0                	test   %eax,%eax
80105552:	78 28                	js     8010557c <sys_exec+0xac>
  for(i=0;; i++){
80105554:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
80105557:	83 fb 20             	cmp    $0x20,%ebx
8010555a:	74 20                	je     8010557c <sys_exec+0xac>
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
8010555c:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80105562:	8d 34 9d 00 00 00 00 	lea    0x0(,%ebx,4),%esi
80105569:	83 ec 08             	sub    $0x8,%esp
8010556c:	57                   	push   %edi
8010556d:	01 f0                	add    %esi,%eax
8010556f:	50                   	push   %eax
80105570:	e8 4b f3 ff ff       	call   801048c0 <fetchint>
80105575:	83 c4 10             	add    $0x10,%esp
80105578:	85 c0                	test   %eax,%eax
8010557a:	79 b4                	jns    80105530 <sys_exec+0x60>
      return -1;
  }
  return exec(path, argv);
}
8010557c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
8010557f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105584:	5b                   	pop    %ebx
80105585:	5e                   	pop    %esi
80105586:	5f                   	pop    %edi
80105587:	5d                   	pop    %ebp
80105588:	c3                   	ret    
80105589:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return exec(path, argv);
80105590:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80105596:	83 ec 08             	sub    $0x8,%esp
      argv[i] = 0;
80105599:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
801055a0:	00 00 00 00 
  return exec(path, argv);
801055a4:	50                   	push   %eax
801055a5:	ff b5 5c ff ff ff    	pushl  -0xa4(%ebp)
801055ab:	e8 60 b4 ff ff       	call   80100a10 <exec>
801055b0:	83 c4 10             	add    $0x10,%esp
}
801055b3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801055b6:	5b                   	pop    %ebx
801055b7:	5e                   	pop    %esi
801055b8:	5f                   	pop    %edi
801055b9:	5d                   	pop    %ebp
801055ba:	c3                   	ret    
801055bb:	90                   	nop
801055bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801055c0 <sys_pipe>:

int
sys_pipe(void)
{
801055c0:	55                   	push   %ebp
801055c1:	89 e5                	mov    %esp,%ebp
801055c3:	57                   	push   %edi
801055c4:	56                   	push   %esi
801055c5:	53                   	push   %ebx
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
801055c6:	8d 45 dc             	lea    -0x24(%ebp),%eax
{
801055c9:	83 ec 20             	sub    $0x20,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
801055cc:	6a 08                	push   $0x8
801055ce:	50                   	push   %eax
801055cf:	6a 00                	push   $0x0
801055d1:	e8 ea f3 ff ff       	call   801049c0 <argptr>
801055d6:	83 c4 10             	add    $0x10,%esp
801055d9:	85 c0                	test   %eax,%eax
801055db:	0f 88 ae 00 00 00    	js     8010568f <sys_pipe+0xcf>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
801055e1:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801055e4:	83 ec 08             	sub    $0x8,%esp
801055e7:	50                   	push   %eax
801055e8:	8d 45 e0             	lea    -0x20(%ebp),%eax
801055eb:	50                   	push   %eax
801055ec:	e8 7f dc ff ff       	call   80103270 <pipealloc>
801055f1:	83 c4 10             	add    $0x10,%esp
801055f4:	85 c0                	test   %eax,%eax
801055f6:	0f 88 93 00 00 00    	js     8010568f <sys_pipe+0xcf>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
801055fc:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
801055ff:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
80105601:	e8 3a e1 ff ff       	call   80103740 <myproc>
80105606:	eb 10                	jmp    80105618 <sys_pipe+0x58>
80105608:	90                   	nop
80105609:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(fd = 0; fd < NOFILE; fd++){
80105610:	83 c3 01             	add    $0x1,%ebx
80105613:	83 fb 10             	cmp    $0x10,%ebx
80105616:	74 60                	je     80105678 <sys_pipe+0xb8>
    if(curproc->ofile[fd] == 0){
80105618:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
8010561c:	85 f6                	test   %esi,%esi
8010561e:	75 f0                	jne    80105610 <sys_pipe+0x50>
      curproc->ofile[fd] = f;
80105620:	8d 73 08             	lea    0x8(%ebx),%esi
80105623:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105627:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
8010562a:	e8 11 e1 ff ff       	call   80103740 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
8010562f:	31 d2                	xor    %edx,%edx
80105631:	eb 0d                	jmp    80105640 <sys_pipe+0x80>
80105633:	90                   	nop
80105634:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105638:	83 c2 01             	add    $0x1,%edx
8010563b:	83 fa 10             	cmp    $0x10,%edx
8010563e:	74 28                	je     80105668 <sys_pipe+0xa8>
    if(curproc->ofile[fd] == 0){
80105640:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
80105644:	85 c9                	test   %ecx,%ecx
80105646:	75 f0                	jne    80105638 <sys_pipe+0x78>
      curproc->ofile[fd] = f;
80105648:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
8010564c:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010564f:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
80105651:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105654:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
80105657:	31 c0                	xor    %eax,%eax
}
80105659:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010565c:	5b                   	pop    %ebx
8010565d:	5e                   	pop    %esi
8010565e:	5f                   	pop    %edi
8010565f:	5d                   	pop    %ebp
80105660:	c3                   	ret    
80105661:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      myproc()->ofile[fd0] = 0;
80105668:	e8 d3 e0 ff ff       	call   80103740 <myproc>
8010566d:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
80105674:	00 
80105675:	8d 76 00             	lea    0x0(%esi),%esi
    fileclose(rf);
80105678:	83 ec 0c             	sub    $0xc,%esp
8010567b:	ff 75 e0             	pushl  -0x20(%ebp)
8010567e:	e8 ed b7 ff ff       	call   80100e70 <fileclose>
    fileclose(wf);
80105683:	58                   	pop    %eax
80105684:	ff 75 e4             	pushl  -0x1c(%ebp)
80105687:	e8 e4 b7 ff ff       	call   80100e70 <fileclose>
    return -1;
8010568c:	83 c4 10             	add    $0x10,%esp
8010568f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105694:	eb c3                	jmp    80105659 <sys_pipe+0x99>
80105696:	66 90                	xchg   %ax,%ax
80105698:	66 90                	xchg   %ax,%ax
8010569a:	66 90                	xchg   %ax,%ax
8010569c:	66 90                	xchg   %ax,%ax
8010569e:	66 90                	xchg   %ax,%ax

801056a0 <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
801056a0:	55                   	push   %ebp
801056a1:	89 e5                	mov    %esp,%ebp
  return fork();
}
801056a3:	5d                   	pop    %ebp
  return fork();
801056a4:	e9 87 e3 ff ff       	jmp    80103a30 <fork>
801056a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801056b0 <sys_exit>:

int
sys_exit(void)
{
801056b0:	55                   	push   %ebp
801056b1:	89 e5                	mov    %esp,%ebp
801056b3:	83 ec 08             	sub    $0x8,%esp
  exit();
801056b6:	e8 35 e6 ff ff       	call   80103cf0 <exit>
  return 0;  // not reached
}
801056bb:	31 c0                	xor    %eax,%eax
801056bd:	c9                   	leave  
801056be:	c3                   	ret    
801056bf:	90                   	nop

801056c0 <sys_wait>:

int
sys_wait(void)
{
801056c0:	55                   	push   %ebp
801056c1:	89 e5                	mov    %esp,%ebp
  return wait();
}
801056c3:	5d                   	pop    %ebp
  return wait();
801056c4:	e9 67 e8 ff ff       	jmp    80103f30 <wait>
801056c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801056d0 <sys_kill>:

int
sys_kill(void)
{
801056d0:	55                   	push   %ebp
801056d1:	89 e5                	mov    %esp,%ebp
801056d3:	83 ec 20             	sub    $0x20,%esp
  int pid;
  int signum;

  if(argint(0, &pid) < 0)
801056d6:	8d 45 f0             	lea    -0x10(%ebp),%eax
801056d9:	50                   	push   %eax
801056da:	6a 00                	push   $0x0
801056dc:	e8 8f f2 ff ff       	call   80104970 <argint>
801056e1:	83 c4 10             	add    $0x10,%esp
801056e4:	85 c0                	test   %eax,%eax
801056e6:	78 28                	js     80105710 <sys_kill+0x40>
    return -1;
  if(argint(0, &signum) < 0)
801056e8:	8d 45 f4             	lea    -0xc(%ebp),%eax
801056eb:	83 ec 08             	sub    $0x8,%esp
801056ee:	50                   	push   %eax
801056ef:	6a 00                	push   $0x0
801056f1:	e8 7a f2 ff ff       	call   80104970 <argint>
801056f6:	83 c4 10             	add    $0x10,%esp
801056f9:	85 c0                	test   %eax,%eax
801056fb:	78 13                	js     80105710 <sys_kill+0x40>
    return -1;
  return kill(pid, signum);
801056fd:	83 ec 08             	sub    $0x8,%esp
80105700:	ff 75 f4             	pushl  -0xc(%ebp)
80105703:	ff 75 f0             	pushl  -0x10(%ebp)
80105706:	e8 85 e9 ff ff       	call   80104090 <kill>
8010570b:	83 c4 10             	add    $0x10,%esp
}
8010570e:	c9                   	leave  
8010570f:	c3                   	ret    
    return -1;
80105710:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105715:	c9                   	leave  
80105716:	c3                   	ret    
80105717:	89 f6                	mov    %esi,%esi
80105719:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105720 <sys_getpid>:

int
sys_getpid(void)
{
80105720:	55                   	push   %ebp
80105721:	89 e5                	mov    %esp,%ebp
80105723:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
80105726:	e8 15 e0 ff ff       	call   80103740 <myproc>
8010572b:	8b 40 10             	mov    0x10(%eax),%eax
}
8010572e:	c9                   	leave  
8010572f:	c3                   	ret    

80105730 <sys_sbrk>:

int
sys_sbrk(void)
{
80105730:	55                   	push   %ebp
80105731:	89 e5                	mov    %esp,%ebp
80105733:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
80105734:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105737:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
8010573a:	50                   	push   %eax
8010573b:	6a 00                	push   $0x0
8010573d:	e8 2e f2 ff ff       	call   80104970 <argint>
80105742:	83 c4 10             	add    $0x10,%esp
80105745:	85 c0                	test   %eax,%eax
80105747:	78 27                	js     80105770 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
80105749:	e8 f2 df ff ff       	call   80103740 <myproc>
  if(growproc(n) < 0)
8010574e:	83 ec 0c             	sub    $0xc,%esp
  addr = myproc()->sz;
80105751:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80105753:	ff 75 f4             	pushl  -0xc(%ebp)
80105756:	e8 55 e2 ff ff       	call   801039b0 <growproc>
8010575b:	83 c4 10             	add    $0x10,%esp
8010575e:	85 c0                	test   %eax,%eax
80105760:	78 0e                	js     80105770 <sys_sbrk+0x40>
    return -1;
  return addr;
}
80105762:	89 d8                	mov    %ebx,%eax
80105764:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105767:	c9                   	leave  
80105768:	c3                   	ret    
80105769:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105770:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105775:	eb eb                	jmp    80105762 <sys_sbrk+0x32>
80105777:	89 f6                	mov    %esi,%esi
80105779:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105780 <sys_sleep>:

int
sys_sleep(void)
{
80105780:	55                   	push   %ebp
80105781:	89 e5                	mov    %esp,%ebp
80105783:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80105784:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105787:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
8010578a:	50                   	push   %eax
8010578b:	6a 00                	push   $0x0
8010578d:	e8 de f1 ff ff       	call   80104970 <argint>
80105792:	83 c4 10             	add    $0x10,%esp
80105795:	85 c0                	test   %eax,%eax
80105797:	0f 88 8a 00 00 00    	js     80105827 <sys_sleep+0xa7>
    return -1;
  acquire(&tickslock);
8010579d:	83 ec 0c             	sub    $0xc,%esp
801057a0:	68 60 6f 11 80       	push   $0x80116f60
801057a5:	e8 b6 ed ff ff       	call   80104560 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
801057aa:	8b 55 f4             	mov    -0xc(%ebp),%edx
801057ad:	83 c4 10             	add    $0x10,%esp
  ticks0 = ticks;
801057b0:	8b 1d a0 77 11 80    	mov    0x801177a0,%ebx
  while(ticks - ticks0 < n){
801057b6:	85 d2                	test   %edx,%edx
801057b8:	75 27                	jne    801057e1 <sys_sleep+0x61>
801057ba:	eb 54                	jmp    80105810 <sys_sleep+0x90>
801057bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
801057c0:	83 ec 08             	sub    $0x8,%esp
801057c3:	68 60 6f 11 80       	push   $0x80116f60
801057c8:	68 a0 77 11 80       	push   $0x801177a0
801057cd:	e8 9e e6 ff ff       	call   80103e70 <sleep>
  while(ticks - ticks0 < n){
801057d2:	a1 a0 77 11 80       	mov    0x801177a0,%eax
801057d7:	83 c4 10             	add    $0x10,%esp
801057da:	29 d8                	sub    %ebx,%eax
801057dc:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801057df:	73 2f                	jae    80105810 <sys_sleep+0x90>
    if(myproc()->killed){
801057e1:	e8 5a df ff ff       	call   80103740 <myproc>
801057e6:	8b 40 24             	mov    0x24(%eax),%eax
801057e9:	85 c0                	test   %eax,%eax
801057eb:	74 d3                	je     801057c0 <sys_sleep+0x40>
      release(&tickslock);
801057ed:	83 ec 0c             	sub    $0xc,%esp
801057f0:	68 60 6f 11 80       	push   $0x80116f60
801057f5:	e8 26 ee ff ff       	call   80104620 <release>
      return -1;
801057fa:	83 c4 10             	add    $0x10,%esp
801057fd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  release(&tickslock);
  return 0;
}
80105802:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105805:	c9                   	leave  
80105806:	c3                   	ret    
80105807:	89 f6                	mov    %esi,%esi
80105809:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  release(&tickslock);
80105810:	83 ec 0c             	sub    $0xc,%esp
80105813:	68 60 6f 11 80       	push   $0x80116f60
80105818:	e8 03 ee ff ff       	call   80104620 <release>
  return 0;
8010581d:	83 c4 10             	add    $0x10,%esp
80105820:	31 c0                	xor    %eax,%eax
}
80105822:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105825:	c9                   	leave  
80105826:	c3                   	ret    
    return -1;
80105827:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010582c:	eb f4                	jmp    80105822 <sys_sleep+0xa2>
8010582e:	66 90                	xchg   %ax,%ax

80105830 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80105830:	55                   	push   %ebp
80105831:	89 e5                	mov    %esp,%ebp
80105833:	53                   	push   %ebx
80105834:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
80105837:	68 60 6f 11 80       	push   $0x80116f60
8010583c:	e8 1f ed ff ff       	call   80104560 <acquire>
  xticks = ticks;
80105841:	8b 1d a0 77 11 80    	mov    0x801177a0,%ebx
  release(&tickslock);
80105847:	c7 04 24 60 6f 11 80 	movl   $0x80116f60,(%esp)
8010584e:	e8 cd ed ff ff       	call   80104620 <release>
  return xticks;
}
80105853:	89 d8                	mov    %ebx,%eax
80105855:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105858:	c9                   	leave  
80105859:	c3                   	ret    
8010585a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105860 <sys_sigprocmask>:

int 
 sys_sigprocmask(void){
80105860:	55                   	push   %ebp
80105861:	89 e5                	mov    %esp,%ebp
80105863:	83 ec 20             	sub    $0x20,%esp
  uint mask;

  if(argint(0, (int *)&mask) < 0)
80105866:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105869:	50                   	push   %eax
8010586a:	6a 00                	push   $0x0
8010586c:	e8 ff f0 ff ff       	call   80104970 <argint>
80105871:	83 c4 10             	add    $0x10,%esp
80105874:	85 c0                	test   %eax,%eax
80105876:	78 18                	js     80105890 <sys_sigprocmask+0x30>
    return -1;
  
  return sigprocmask(mask);
80105878:	83 ec 0c             	sub    $0xc,%esp
8010587b:	ff 75 f4             	pushl  -0xc(%ebp)
8010587e:	e8 ad e9 ff ff       	call   80104230 <sigprocmask>
80105883:	83 c4 10             	add    $0x10,%esp
 }
80105886:	c9                   	leave  
80105887:	c3                   	ret    
80105888:	90                   	nop
80105889:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105890:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 }
80105895:	c9                   	leave  
80105896:	c3                   	ret    
80105897:	89 f6                	mov    %esi,%esi
80105899:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801058a0 <sys_sigaction>:

 int
 sys_sigaction(void){
801058a0:	55                   	push   %ebp
801058a1:	89 e5                	mov    %esp,%ebp
801058a3:	83 ec 20             	sub    $0x20,%esp
   int signum;
   struct sigaction *act;
   struct sigaction *oldact;

  if(argint(0, &signum) < 0)
801058a6:	8d 45 ec             	lea    -0x14(%ebp),%eax
801058a9:	50                   	push   %eax
801058aa:	6a 00                	push   $0x0
801058ac:	e8 bf f0 ff ff       	call   80104970 <argint>
801058b1:	83 c4 10             	add    $0x10,%esp
801058b4:	85 c0                	test   %eax,%eax
801058b6:	78 48                	js     80105900 <sys_sigaction+0x60>
    return -1;
  if(argptr(1, (char**) &act, sizeof(struct sigaction)) < 0)
801058b8:	8d 45 f0             	lea    -0x10(%ebp),%eax
801058bb:	83 ec 04             	sub    $0x4,%esp
801058be:	6a 08                	push   $0x8
801058c0:	50                   	push   %eax
801058c1:	6a 01                	push   $0x1
801058c3:	e8 f8 f0 ff ff       	call   801049c0 <argptr>
801058c8:	83 c4 10             	add    $0x10,%esp
801058cb:	85 c0                	test   %eax,%eax
801058cd:	78 31                	js     80105900 <sys_sigaction+0x60>
    return -1;
  
  if(argptr(1, (char**)  &oldact, sizeof(struct sigaction)) < 0)
801058cf:	8d 45 f4             	lea    -0xc(%ebp),%eax
801058d2:	83 ec 04             	sub    $0x4,%esp
801058d5:	6a 08                	push   $0x8
801058d7:	50                   	push   %eax
801058d8:	6a 01                	push   $0x1
801058da:	e8 e1 f0 ff ff       	call   801049c0 <argptr>
801058df:	83 c4 10             	add    $0x10,%esp
801058e2:	85 c0                	test   %eax,%eax
801058e4:	78 1a                	js     80105900 <sys_sigaction+0x60>
    return -1;
  
  return sigaction(signum,act, oldact);
801058e6:	83 ec 04             	sub    $0x4,%esp
801058e9:	ff 75 f4             	pushl  -0xc(%ebp)
801058ec:	ff 75 f0             	pushl  -0x10(%ebp)
801058ef:	ff 75 ec             	pushl  -0x14(%ebp)
801058f2:	e8 79 e9 ff ff       	call   80104270 <sigaction>
801058f7:	83 c4 10             	add    $0x10,%esp
 }
801058fa:	c9                   	leave  
801058fb:	c3                   	ret    
801058fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105900:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 }
80105905:	c9                   	leave  
80105906:	c3                   	ret    
80105907:	89 f6                	mov    %esi,%esi
80105909:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105910 <sys_sigret>:

 int
 sys_sigret(void){
80105910:	55                   	push   %ebp
   return 0;
 }
80105911:	31 c0                	xor    %eax,%eax
 sys_sigret(void){
80105913:	89 e5                	mov    %esp,%ebp
 }
80105915:	5d                   	pop    %ebp
80105916:	c3                   	ret    

80105917 <alltraps>:
80105917:	1e                   	push   %ds
80105918:	06                   	push   %es
80105919:	0f a0                	push   %fs
8010591b:	0f a8                	push   %gs
8010591d:	60                   	pusha  
8010591e:	66 b8 10 00          	mov    $0x10,%ax
80105922:	8e d8                	mov    %eax,%ds
80105924:	8e c0                	mov    %eax,%es
80105926:	54                   	push   %esp
80105927:	e8 c4 00 00 00       	call   801059f0 <trap>
8010592c:	83 c4 04             	add    $0x4,%esp

8010592f <trapret>:
8010592f:	61                   	popa   
80105930:	0f a9                	pop    %gs
80105932:	0f a1                	pop    %fs
80105934:	07                   	pop    %es
80105935:	1f                   	pop    %ds
80105936:	83 c4 08             	add    $0x8,%esp
80105939:	cf                   	iret   
8010593a:	66 90                	xchg   %ax,%ax
8010593c:	66 90                	xchg   %ax,%ax
8010593e:	66 90                	xchg   %ax,%ax

80105940 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80105940:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
80105941:	31 c0                	xor    %eax,%eax
{
80105943:	89 e5                	mov    %esp,%ebp
80105945:	83 ec 08             	sub    $0x8,%esp
80105948:	90                   	nop
80105949:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80105950:	8b 14 85 08 a0 10 80 	mov    -0x7fef5ff8(,%eax,4),%edx
80105957:	c7 04 c5 a2 6f 11 80 	movl   $0x8e000008,-0x7fee905e(,%eax,8)
8010595e:	08 00 00 8e 
80105962:	66 89 14 c5 a0 6f 11 	mov    %dx,-0x7fee9060(,%eax,8)
80105969:	80 
8010596a:	c1 ea 10             	shr    $0x10,%edx
8010596d:	66 89 14 c5 a6 6f 11 	mov    %dx,-0x7fee905a(,%eax,8)
80105974:	80 
  for(i = 0; i < 256; i++)
80105975:	83 c0 01             	add    $0x1,%eax
80105978:	3d 00 01 00 00       	cmp    $0x100,%eax
8010597d:	75 d1                	jne    80105950 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
8010597f:	a1 08 a1 10 80       	mov    0x8010a108,%eax

  initlock(&tickslock, "time");
80105984:	83 ec 08             	sub    $0x8,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105987:	c7 05 a2 71 11 80 08 	movl   $0xef000008,0x801171a2
8010598e:	00 00 ef 
  initlock(&tickslock, "time");
80105991:	68 45 79 10 80       	push   $0x80107945
80105996:	68 60 6f 11 80       	push   $0x80116f60
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
8010599b:	66 a3 a0 71 11 80    	mov    %ax,0x801171a0
801059a1:	c1 e8 10             	shr    $0x10,%eax
801059a4:	66 a3 a6 71 11 80    	mov    %ax,0x801171a6
  initlock(&tickslock, "time");
801059aa:	e8 71 ea ff ff       	call   80104420 <initlock>
}
801059af:	83 c4 10             	add    $0x10,%esp
801059b2:	c9                   	leave  
801059b3:	c3                   	ret    
801059b4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801059ba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801059c0 <idtinit>:

void
idtinit(void)
{
801059c0:	55                   	push   %ebp
  pd[0] = size-1;
801059c1:	b8 ff 07 00 00       	mov    $0x7ff,%eax
801059c6:	89 e5                	mov    %esp,%ebp
801059c8:	83 ec 10             	sub    $0x10,%esp
801059cb:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
801059cf:	b8 a0 6f 11 80       	mov    $0x80116fa0,%eax
801059d4:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
801059d8:	c1 e8 10             	shr    $0x10,%eax
801059db:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
801059df:	8d 45 fa             	lea    -0x6(%ebp),%eax
801059e2:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
801059e5:	c9                   	leave  
801059e6:	c3                   	ret    
801059e7:	89 f6                	mov    %esi,%esi
801059e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801059f0 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
801059f0:	55                   	push   %ebp
801059f1:	89 e5                	mov    %esp,%ebp
801059f3:	57                   	push   %edi
801059f4:	56                   	push   %esi
801059f5:	53                   	push   %ebx
801059f6:	83 ec 1c             	sub    $0x1c,%esp
801059f9:	8b 7d 08             	mov    0x8(%ebp),%edi
  if(tf->trapno == T_SYSCALL){
801059fc:	8b 47 30             	mov    0x30(%edi),%eax
801059ff:	83 f8 40             	cmp    $0x40,%eax
80105a02:	0f 84 f0 00 00 00    	je     80105af8 <trap+0x108>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
80105a08:	83 e8 20             	sub    $0x20,%eax
80105a0b:	83 f8 1f             	cmp    $0x1f,%eax
80105a0e:	77 10                	ja     80105a20 <trap+0x30>
80105a10:	ff 24 85 ec 79 10 80 	jmp    *-0x7fef8614(,%eax,4)
80105a17:	89 f6                	mov    %esi,%esi
80105a19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    lapiceoi();
    break;

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
80105a20:	e8 1b dd ff ff       	call   80103740 <myproc>
80105a25:	85 c0                	test   %eax,%eax
80105a27:	8b 5f 38             	mov    0x38(%edi),%ebx
80105a2a:	0f 84 14 02 00 00    	je     80105c44 <trap+0x254>
80105a30:	f6 47 3c 03          	testb  $0x3,0x3c(%edi)
80105a34:	0f 84 0a 02 00 00    	je     80105c44 <trap+0x254>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80105a3a:	0f 20 d1             	mov    %cr2,%ecx
80105a3d:	89 4d d8             	mov    %ecx,-0x28(%ebp)
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105a40:	e8 db dc ff ff       	call   80103720 <cpuid>
80105a45:	89 45 dc             	mov    %eax,-0x24(%ebp)
80105a48:	8b 47 34             	mov    0x34(%edi),%eax
80105a4b:	8b 77 30             	mov    0x30(%edi),%esi
80105a4e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80105a51:	e8 ea dc ff ff       	call   80103740 <myproc>
80105a56:	89 45 e0             	mov    %eax,-0x20(%ebp)
80105a59:	e8 e2 dc ff ff       	call   80103740 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105a5e:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80105a61:	8b 55 dc             	mov    -0x24(%ebp),%edx
80105a64:	51                   	push   %ecx
80105a65:	53                   	push   %ebx
80105a66:	52                   	push   %edx
            myproc()->pid, myproc()->name, tf->trapno,
80105a67:	8b 55 e0             	mov    -0x20(%ebp),%edx
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105a6a:	ff 75 e4             	pushl  -0x1c(%ebp)
80105a6d:	56                   	push   %esi
            myproc()->pid, myproc()->name, tf->trapno,
80105a6e:	83 c2 6c             	add    $0x6c,%edx
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105a71:	52                   	push   %edx
80105a72:	ff 70 10             	pushl  0x10(%eax)
80105a75:	68 a8 79 10 80       	push   $0x801079a8
80105a7a:	e8 e1 ab ff ff       	call   80100660 <cprintf>
            tf->err, cpuid(), tf->eip, rcr2());
    myproc()->killed = 1;
80105a7f:	83 c4 20             	add    $0x20,%esp
80105a82:	e8 b9 dc ff ff       	call   80103740 <myproc>
80105a87:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105a8e:	e8 ad dc ff ff       	call   80103740 <myproc>
80105a93:	85 c0                	test   %eax,%eax
80105a95:	74 1d                	je     80105ab4 <trap+0xc4>
80105a97:	e8 a4 dc ff ff       	call   80103740 <myproc>
80105a9c:	8b 50 24             	mov    0x24(%eax),%edx
80105a9f:	85 d2                	test   %edx,%edx
80105aa1:	74 11                	je     80105ab4 <trap+0xc4>
80105aa3:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
80105aa7:	83 e0 03             	and    $0x3,%eax
80105aaa:	66 83 f8 03          	cmp    $0x3,%ax
80105aae:	0f 84 4c 01 00 00    	je     80105c00 <trap+0x210>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80105ab4:	e8 87 dc ff ff       	call   80103740 <myproc>
80105ab9:	85 c0                	test   %eax,%eax
80105abb:	74 0b                	je     80105ac8 <trap+0xd8>
80105abd:	e8 7e dc ff ff       	call   80103740 <myproc>
80105ac2:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80105ac6:	74 68                	je     80105b30 <trap+0x140>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105ac8:	e8 73 dc ff ff       	call   80103740 <myproc>
80105acd:	85 c0                	test   %eax,%eax
80105acf:	74 19                	je     80105aea <trap+0xfa>
80105ad1:	e8 6a dc ff ff       	call   80103740 <myproc>
80105ad6:	8b 40 24             	mov    0x24(%eax),%eax
80105ad9:	85 c0                	test   %eax,%eax
80105adb:	74 0d                	je     80105aea <trap+0xfa>
80105add:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
80105ae1:	83 e0 03             	and    $0x3,%eax
80105ae4:	66 83 f8 03          	cmp    $0x3,%ax
80105ae8:	74 37                	je     80105b21 <trap+0x131>
    exit();
}
80105aea:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105aed:	5b                   	pop    %ebx
80105aee:	5e                   	pop    %esi
80105aef:	5f                   	pop    %edi
80105af0:	5d                   	pop    %ebp
80105af1:	c3                   	ret    
80105af2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(myproc()->killed)
80105af8:	e8 43 dc ff ff       	call   80103740 <myproc>
80105afd:	8b 58 24             	mov    0x24(%eax),%ebx
80105b00:	85 db                	test   %ebx,%ebx
80105b02:	0f 85 e8 00 00 00    	jne    80105bf0 <trap+0x200>
    myproc()->tf = tf;
80105b08:	e8 33 dc ff ff       	call   80103740 <myproc>
80105b0d:	89 78 18             	mov    %edi,0x18(%eax)
    syscall();
80105b10:	e8 4b ef ff ff       	call   80104a60 <syscall>
    if(myproc()->killed)
80105b15:	e8 26 dc ff ff       	call   80103740 <myproc>
80105b1a:	8b 48 24             	mov    0x24(%eax),%ecx
80105b1d:	85 c9                	test   %ecx,%ecx
80105b1f:	74 c9                	je     80105aea <trap+0xfa>
}
80105b21:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105b24:	5b                   	pop    %ebx
80105b25:	5e                   	pop    %esi
80105b26:	5f                   	pop    %edi
80105b27:	5d                   	pop    %ebp
      exit();
80105b28:	e9 c3 e1 ff ff       	jmp    80103cf0 <exit>
80105b2d:	8d 76 00             	lea    0x0(%esi),%esi
  if(myproc() && myproc()->state == RUNNING &&
80105b30:	83 7f 30 20          	cmpl   $0x20,0x30(%edi)
80105b34:	75 92                	jne    80105ac8 <trap+0xd8>
    yield();
80105b36:	e8 e5 e2 ff ff       	call   80103e20 <yield>
80105b3b:	eb 8b                	jmp    80105ac8 <trap+0xd8>
80105b3d:	8d 76 00             	lea    0x0(%esi),%esi
    if(cpuid() == 0){
80105b40:	e8 db db ff ff       	call   80103720 <cpuid>
80105b45:	85 c0                	test   %eax,%eax
80105b47:	0f 84 c3 00 00 00    	je     80105c10 <trap+0x220>
    lapiceoi();
80105b4d:	e8 2e cc ff ff       	call   80102780 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105b52:	e8 e9 db ff ff       	call   80103740 <myproc>
80105b57:	85 c0                	test   %eax,%eax
80105b59:	0f 85 38 ff ff ff    	jne    80105a97 <trap+0xa7>
80105b5f:	e9 50 ff ff ff       	jmp    80105ab4 <trap+0xc4>
80105b64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    kbdintr();
80105b68:	e8 d3 ca ff ff       	call   80102640 <kbdintr>
    lapiceoi();
80105b6d:	e8 0e cc ff ff       	call   80102780 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105b72:	e8 c9 db ff ff       	call   80103740 <myproc>
80105b77:	85 c0                	test   %eax,%eax
80105b79:	0f 85 18 ff ff ff    	jne    80105a97 <trap+0xa7>
80105b7f:	e9 30 ff ff ff       	jmp    80105ab4 <trap+0xc4>
80105b84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    uartintr();
80105b88:	e8 53 02 00 00       	call   80105de0 <uartintr>
    lapiceoi();
80105b8d:	e8 ee cb ff ff       	call   80102780 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105b92:	e8 a9 db ff ff       	call   80103740 <myproc>
80105b97:	85 c0                	test   %eax,%eax
80105b99:	0f 85 f8 fe ff ff    	jne    80105a97 <trap+0xa7>
80105b9f:	e9 10 ff ff ff       	jmp    80105ab4 <trap+0xc4>
80105ba4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80105ba8:	0f b7 5f 3c          	movzwl 0x3c(%edi),%ebx
80105bac:	8b 77 38             	mov    0x38(%edi),%esi
80105baf:	e8 6c db ff ff       	call   80103720 <cpuid>
80105bb4:	56                   	push   %esi
80105bb5:	53                   	push   %ebx
80105bb6:	50                   	push   %eax
80105bb7:	68 50 79 10 80       	push   $0x80107950
80105bbc:	e8 9f aa ff ff       	call   80100660 <cprintf>
    lapiceoi();
80105bc1:	e8 ba cb ff ff       	call   80102780 <lapiceoi>
    break;
80105bc6:	83 c4 10             	add    $0x10,%esp
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105bc9:	e8 72 db ff ff       	call   80103740 <myproc>
80105bce:	85 c0                	test   %eax,%eax
80105bd0:	0f 85 c1 fe ff ff    	jne    80105a97 <trap+0xa7>
80105bd6:	e9 d9 fe ff ff       	jmp    80105ab4 <trap+0xc4>
80105bdb:	90                   	nop
80105bdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ideintr();
80105be0:	e8 cb c4 ff ff       	call   801020b0 <ideintr>
80105be5:	e9 63 ff ff ff       	jmp    80105b4d <trap+0x15d>
80105bea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit();
80105bf0:	e8 fb e0 ff ff       	call   80103cf0 <exit>
80105bf5:	e9 0e ff ff ff       	jmp    80105b08 <trap+0x118>
80105bfa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    exit();
80105c00:	e8 eb e0 ff ff       	call   80103cf0 <exit>
80105c05:	e9 aa fe ff ff       	jmp    80105ab4 <trap+0xc4>
80105c0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      acquire(&tickslock);
80105c10:	83 ec 0c             	sub    $0xc,%esp
80105c13:	68 60 6f 11 80       	push   $0x80116f60
80105c18:	e8 43 e9 ff ff       	call   80104560 <acquire>
      wakeup(&ticks);
80105c1d:	c7 04 24 a0 77 11 80 	movl   $0x801177a0,(%esp)
      ticks++;
80105c24:	83 05 a0 77 11 80 01 	addl   $0x1,0x801177a0
      wakeup(&ticks);
80105c2b:	e8 00 e4 ff ff       	call   80104030 <wakeup>
      release(&tickslock);
80105c30:	c7 04 24 60 6f 11 80 	movl   $0x80116f60,(%esp)
80105c37:	e8 e4 e9 ff ff       	call   80104620 <release>
80105c3c:	83 c4 10             	add    $0x10,%esp
80105c3f:	e9 09 ff ff ff       	jmp    80105b4d <trap+0x15d>
80105c44:	0f 20 d6             	mov    %cr2,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80105c47:	e8 d4 da ff ff       	call   80103720 <cpuid>
80105c4c:	83 ec 0c             	sub    $0xc,%esp
80105c4f:	56                   	push   %esi
80105c50:	53                   	push   %ebx
80105c51:	50                   	push   %eax
80105c52:	ff 77 30             	pushl  0x30(%edi)
80105c55:	68 74 79 10 80       	push   $0x80107974
80105c5a:	e8 01 aa ff ff       	call   80100660 <cprintf>
      panic("trap");
80105c5f:	83 c4 14             	add    $0x14,%esp
80105c62:	68 4a 79 10 80       	push   $0x8010794a
80105c67:	e8 24 a7 ff ff       	call   80100390 <panic>
80105c6c:	66 90                	xchg   %ax,%ax
80105c6e:	66 90                	xchg   %ax,%ax

80105c70 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80105c70:	a1 bc a5 10 80       	mov    0x8010a5bc,%eax
{
80105c75:	55                   	push   %ebp
80105c76:	89 e5                	mov    %esp,%ebp
  if(!uart)
80105c78:	85 c0                	test   %eax,%eax
80105c7a:	74 1c                	je     80105c98 <uartgetc+0x28>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105c7c:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105c81:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
80105c82:	a8 01                	test   $0x1,%al
80105c84:	74 12                	je     80105c98 <uartgetc+0x28>
80105c86:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105c8b:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
80105c8c:	0f b6 c0             	movzbl %al,%eax
}
80105c8f:	5d                   	pop    %ebp
80105c90:	c3                   	ret    
80105c91:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105c98:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105c9d:	5d                   	pop    %ebp
80105c9e:	c3                   	ret    
80105c9f:	90                   	nop

80105ca0 <uartputc.part.0>:
uartputc(int c)
80105ca0:	55                   	push   %ebp
80105ca1:	89 e5                	mov    %esp,%ebp
80105ca3:	57                   	push   %edi
80105ca4:	56                   	push   %esi
80105ca5:	53                   	push   %ebx
80105ca6:	89 c7                	mov    %eax,%edi
80105ca8:	bb 80 00 00 00       	mov    $0x80,%ebx
80105cad:	be fd 03 00 00       	mov    $0x3fd,%esi
80105cb2:	83 ec 0c             	sub    $0xc,%esp
80105cb5:	eb 1b                	jmp    80105cd2 <uartputc.part.0+0x32>
80105cb7:	89 f6                	mov    %esi,%esi
80105cb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    microdelay(10);
80105cc0:	83 ec 0c             	sub    $0xc,%esp
80105cc3:	6a 0a                	push   $0xa
80105cc5:	e8 d6 ca ff ff       	call   801027a0 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80105cca:	83 c4 10             	add    $0x10,%esp
80105ccd:	83 eb 01             	sub    $0x1,%ebx
80105cd0:	74 07                	je     80105cd9 <uartputc.part.0+0x39>
80105cd2:	89 f2                	mov    %esi,%edx
80105cd4:	ec                   	in     (%dx),%al
80105cd5:	a8 20                	test   $0x20,%al
80105cd7:	74 e7                	je     80105cc0 <uartputc.part.0+0x20>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80105cd9:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105cde:	89 f8                	mov    %edi,%eax
80105ce0:	ee                   	out    %al,(%dx)
}
80105ce1:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105ce4:	5b                   	pop    %ebx
80105ce5:	5e                   	pop    %esi
80105ce6:	5f                   	pop    %edi
80105ce7:	5d                   	pop    %ebp
80105ce8:	c3                   	ret    
80105ce9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105cf0 <uartinit>:
{
80105cf0:	55                   	push   %ebp
80105cf1:	31 c9                	xor    %ecx,%ecx
80105cf3:	89 c8                	mov    %ecx,%eax
80105cf5:	89 e5                	mov    %esp,%ebp
80105cf7:	57                   	push   %edi
80105cf8:	56                   	push   %esi
80105cf9:	53                   	push   %ebx
80105cfa:	bb fa 03 00 00       	mov    $0x3fa,%ebx
80105cff:	89 da                	mov    %ebx,%edx
80105d01:	83 ec 0c             	sub    $0xc,%esp
80105d04:	ee                   	out    %al,(%dx)
80105d05:	bf fb 03 00 00       	mov    $0x3fb,%edi
80105d0a:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
80105d0f:	89 fa                	mov    %edi,%edx
80105d11:	ee                   	out    %al,(%dx)
80105d12:	b8 0c 00 00 00       	mov    $0xc,%eax
80105d17:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105d1c:	ee                   	out    %al,(%dx)
80105d1d:	be f9 03 00 00       	mov    $0x3f9,%esi
80105d22:	89 c8                	mov    %ecx,%eax
80105d24:	89 f2                	mov    %esi,%edx
80105d26:	ee                   	out    %al,(%dx)
80105d27:	b8 03 00 00 00       	mov    $0x3,%eax
80105d2c:	89 fa                	mov    %edi,%edx
80105d2e:	ee                   	out    %al,(%dx)
80105d2f:	ba fc 03 00 00       	mov    $0x3fc,%edx
80105d34:	89 c8                	mov    %ecx,%eax
80105d36:	ee                   	out    %al,(%dx)
80105d37:	b8 01 00 00 00       	mov    $0x1,%eax
80105d3c:	89 f2                	mov    %esi,%edx
80105d3e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105d3f:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105d44:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
80105d45:	3c ff                	cmp    $0xff,%al
80105d47:	74 5a                	je     80105da3 <uartinit+0xb3>
  uart = 1;
80105d49:	c7 05 bc a5 10 80 01 	movl   $0x1,0x8010a5bc
80105d50:	00 00 00 
80105d53:	89 da                	mov    %ebx,%edx
80105d55:	ec                   	in     (%dx),%al
80105d56:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105d5b:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
80105d5c:	83 ec 08             	sub    $0x8,%esp
  for(p="xv6...\n"; *p; p++)
80105d5f:	bb 6c 7a 10 80       	mov    $0x80107a6c,%ebx
  ioapicenable(IRQ_COM1, 0);
80105d64:	6a 00                	push   $0x0
80105d66:	6a 04                	push   $0x4
80105d68:	e8 93 c5 ff ff       	call   80102300 <ioapicenable>
80105d6d:	83 c4 10             	add    $0x10,%esp
  for(p="xv6...\n"; *p; p++)
80105d70:	b8 78 00 00 00       	mov    $0x78,%eax
80105d75:	eb 13                	jmp    80105d8a <uartinit+0x9a>
80105d77:	89 f6                	mov    %esi,%esi
80105d79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105d80:	83 c3 01             	add    $0x1,%ebx
80105d83:	0f be 03             	movsbl (%ebx),%eax
80105d86:	84 c0                	test   %al,%al
80105d88:	74 19                	je     80105da3 <uartinit+0xb3>
  if(!uart)
80105d8a:	8b 15 bc a5 10 80    	mov    0x8010a5bc,%edx
80105d90:	85 d2                	test   %edx,%edx
80105d92:	74 ec                	je     80105d80 <uartinit+0x90>
  for(p="xv6...\n"; *p; p++)
80105d94:	83 c3 01             	add    $0x1,%ebx
80105d97:	e8 04 ff ff ff       	call   80105ca0 <uartputc.part.0>
80105d9c:	0f be 03             	movsbl (%ebx),%eax
80105d9f:	84 c0                	test   %al,%al
80105da1:	75 e7                	jne    80105d8a <uartinit+0x9a>
}
80105da3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105da6:	5b                   	pop    %ebx
80105da7:	5e                   	pop    %esi
80105da8:	5f                   	pop    %edi
80105da9:	5d                   	pop    %ebp
80105daa:	c3                   	ret    
80105dab:	90                   	nop
80105dac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105db0 <uartputc>:
  if(!uart)
80105db0:	8b 15 bc a5 10 80    	mov    0x8010a5bc,%edx
{
80105db6:	55                   	push   %ebp
80105db7:	89 e5                	mov    %esp,%ebp
  if(!uart)
80105db9:	85 d2                	test   %edx,%edx
{
80105dbb:	8b 45 08             	mov    0x8(%ebp),%eax
  if(!uart)
80105dbe:	74 10                	je     80105dd0 <uartputc+0x20>
}
80105dc0:	5d                   	pop    %ebp
80105dc1:	e9 da fe ff ff       	jmp    80105ca0 <uartputc.part.0>
80105dc6:	8d 76 00             	lea    0x0(%esi),%esi
80105dc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105dd0:	5d                   	pop    %ebp
80105dd1:	c3                   	ret    
80105dd2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105dd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105de0 <uartintr>:

void
uartintr(void)
{
80105de0:	55                   	push   %ebp
80105de1:	89 e5                	mov    %esp,%ebp
80105de3:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
80105de6:	68 70 5c 10 80       	push   $0x80105c70
80105deb:	e8 20 aa ff ff       	call   80100810 <consoleintr>
}
80105df0:	83 c4 10             	add    $0x10,%esp
80105df3:	c9                   	leave  
80105df4:	c3                   	ret    

80105df5 <vector0>:
80105df5:	6a 00                	push   $0x0
80105df7:	6a 00                	push   $0x0
80105df9:	e9 19 fb ff ff       	jmp    80105917 <alltraps>

80105dfe <vector1>:
80105dfe:	6a 00                	push   $0x0
80105e00:	6a 01                	push   $0x1
80105e02:	e9 10 fb ff ff       	jmp    80105917 <alltraps>

80105e07 <vector2>:
80105e07:	6a 00                	push   $0x0
80105e09:	6a 02                	push   $0x2
80105e0b:	e9 07 fb ff ff       	jmp    80105917 <alltraps>

80105e10 <vector3>:
80105e10:	6a 00                	push   $0x0
80105e12:	6a 03                	push   $0x3
80105e14:	e9 fe fa ff ff       	jmp    80105917 <alltraps>

80105e19 <vector4>:
80105e19:	6a 00                	push   $0x0
80105e1b:	6a 04                	push   $0x4
80105e1d:	e9 f5 fa ff ff       	jmp    80105917 <alltraps>

80105e22 <vector5>:
80105e22:	6a 00                	push   $0x0
80105e24:	6a 05                	push   $0x5
80105e26:	e9 ec fa ff ff       	jmp    80105917 <alltraps>

80105e2b <vector6>:
80105e2b:	6a 00                	push   $0x0
80105e2d:	6a 06                	push   $0x6
80105e2f:	e9 e3 fa ff ff       	jmp    80105917 <alltraps>

80105e34 <vector7>:
80105e34:	6a 00                	push   $0x0
80105e36:	6a 07                	push   $0x7
80105e38:	e9 da fa ff ff       	jmp    80105917 <alltraps>

80105e3d <vector8>:
80105e3d:	6a 08                	push   $0x8
80105e3f:	e9 d3 fa ff ff       	jmp    80105917 <alltraps>

80105e44 <vector9>:
80105e44:	6a 00                	push   $0x0
80105e46:	6a 09                	push   $0x9
80105e48:	e9 ca fa ff ff       	jmp    80105917 <alltraps>

80105e4d <vector10>:
80105e4d:	6a 0a                	push   $0xa
80105e4f:	e9 c3 fa ff ff       	jmp    80105917 <alltraps>

80105e54 <vector11>:
80105e54:	6a 0b                	push   $0xb
80105e56:	e9 bc fa ff ff       	jmp    80105917 <alltraps>

80105e5b <vector12>:
80105e5b:	6a 0c                	push   $0xc
80105e5d:	e9 b5 fa ff ff       	jmp    80105917 <alltraps>

80105e62 <vector13>:
80105e62:	6a 0d                	push   $0xd
80105e64:	e9 ae fa ff ff       	jmp    80105917 <alltraps>

80105e69 <vector14>:
80105e69:	6a 0e                	push   $0xe
80105e6b:	e9 a7 fa ff ff       	jmp    80105917 <alltraps>

80105e70 <vector15>:
80105e70:	6a 00                	push   $0x0
80105e72:	6a 0f                	push   $0xf
80105e74:	e9 9e fa ff ff       	jmp    80105917 <alltraps>

80105e79 <vector16>:
80105e79:	6a 00                	push   $0x0
80105e7b:	6a 10                	push   $0x10
80105e7d:	e9 95 fa ff ff       	jmp    80105917 <alltraps>

80105e82 <vector17>:
80105e82:	6a 11                	push   $0x11
80105e84:	e9 8e fa ff ff       	jmp    80105917 <alltraps>

80105e89 <vector18>:
80105e89:	6a 00                	push   $0x0
80105e8b:	6a 12                	push   $0x12
80105e8d:	e9 85 fa ff ff       	jmp    80105917 <alltraps>

80105e92 <vector19>:
80105e92:	6a 00                	push   $0x0
80105e94:	6a 13                	push   $0x13
80105e96:	e9 7c fa ff ff       	jmp    80105917 <alltraps>

80105e9b <vector20>:
80105e9b:	6a 00                	push   $0x0
80105e9d:	6a 14                	push   $0x14
80105e9f:	e9 73 fa ff ff       	jmp    80105917 <alltraps>

80105ea4 <vector21>:
80105ea4:	6a 00                	push   $0x0
80105ea6:	6a 15                	push   $0x15
80105ea8:	e9 6a fa ff ff       	jmp    80105917 <alltraps>

80105ead <vector22>:
80105ead:	6a 00                	push   $0x0
80105eaf:	6a 16                	push   $0x16
80105eb1:	e9 61 fa ff ff       	jmp    80105917 <alltraps>

80105eb6 <vector23>:
80105eb6:	6a 00                	push   $0x0
80105eb8:	6a 17                	push   $0x17
80105eba:	e9 58 fa ff ff       	jmp    80105917 <alltraps>

80105ebf <vector24>:
80105ebf:	6a 00                	push   $0x0
80105ec1:	6a 18                	push   $0x18
80105ec3:	e9 4f fa ff ff       	jmp    80105917 <alltraps>

80105ec8 <vector25>:
80105ec8:	6a 00                	push   $0x0
80105eca:	6a 19                	push   $0x19
80105ecc:	e9 46 fa ff ff       	jmp    80105917 <alltraps>

80105ed1 <vector26>:
80105ed1:	6a 00                	push   $0x0
80105ed3:	6a 1a                	push   $0x1a
80105ed5:	e9 3d fa ff ff       	jmp    80105917 <alltraps>

80105eda <vector27>:
80105eda:	6a 00                	push   $0x0
80105edc:	6a 1b                	push   $0x1b
80105ede:	e9 34 fa ff ff       	jmp    80105917 <alltraps>

80105ee3 <vector28>:
80105ee3:	6a 00                	push   $0x0
80105ee5:	6a 1c                	push   $0x1c
80105ee7:	e9 2b fa ff ff       	jmp    80105917 <alltraps>

80105eec <vector29>:
80105eec:	6a 00                	push   $0x0
80105eee:	6a 1d                	push   $0x1d
80105ef0:	e9 22 fa ff ff       	jmp    80105917 <alltraps>

80105ef5 <vector30>:
80105ef5:	6a 00                	push   $0x0
80105ef7:	6a 1e                	push   $0x1e
80105ef9:	e9 19 fa ff ff       	jmp    80105917 <alltraps>

80105efe <vector31>:
80105efe:	6a 00                	push   $0x0
80105f00:	6a 1f                	push   $0x1f
80105f02:	e9 10 fa ff ff       	jmp    80105917 <alltraps>

80105f07 <vector32>:
80105f07:	6a 00                	push   $0x0
80105f09:	6a 20                	push   $0x20
80105f0b:	e9 07 fa ff ff       	jmp    80105917 <alltraps>

80105f10 <vector33>:
80105f10:	6a 00                	push   $0x0
80105f12:	6a 21                	push   $0x21
80105f14:	e9 fe f9 ff ff       	jmp    80105917 <alltraps>

80105f19 <vector34>:
80105f19:	6a 00                	push   $0x0
80105f1b:	6a 22                	push   $0x22
80105f1d:	e9 f5 f9 ff ff       	jmp    80105917 <alltraps>

80105f22 <vector35>:
80105f22:	6a 00                	push   $0x0
80105f24:	6a 23                	push   $0x23
80105f26:	e9 ec f9 ff ff       	jmp    80105917 <alltraps>

80105f2b <vector36>:
80105f2b:	6a 00                	push   $0x0
80105f2d:	6a 24                	push   $0x24
80105f2f:	e9 e3 f9 ff ff       	jmp    80105917 <alltraps>

80105f34 <vector37>:
80105f34:	6a 00                	push   $0x0
80105f36:	6a 25                	push   $0x25
80105f38:	e9 da f9 ff ff       	jmp    80105917 <alltraps>

80105f3d <vector38>:
80105f3d:	6a 00                	push   $0x0
80105f3f:	6a 26                	push   $0x26
80105f41:	e9 d1 f9 ff ff       	jmp    80105917 <alltraps>

80105f46 <vector39>:
80105f46:	6a 00                	push   $0x0
80105f48:	6a 27                	push   $0x27
80105f4a:	e9 c8 f9 ff ff       	jmp    80105917 <alltraps>

80105f4f <vector40>:
80105f4f:	6a 00                	push   $0x0
80105f51:	6a 28                	push   $0x28
80105f53:	e9 bf f9 ff ff       	jmp    80105917 <alltraps>

80105f58 <vector41>:
80105f58:	6a 00                	push   $0x0
80105f5a:	6a 29                	push   $0x29
80105f5c:	e9 b6 f9 ff ff       	jmp    80105917 <alltraps>

80105f61 <vector42>:
80105f61:	6a 00                	push   $0x0
80105f63:	6a 2a                	push   $0x2a
80105f65:	e9 ad f9 ff ff       	jmp    80105917 <alltraps>

80105f6a <vector43>:
80105f6a:	6a 00                	push   $0x0
80105f6c:	6a 2b                	push   $0x2b
80105f6e:	e9 a4 f9 ff ff       	jmp    80105917 <alltraps>

80105f73 <vector44>:
80105f73:	6a 00                	push   $0x0
80105f75:	6a 2c                	push   $0x2c
80105f77:	e9 9b f9 ff ff       	jmp    80105917 <alltraps>

80105f7c <vector45>:
80105f7c:	6a 00                	push   $0x0
80105f7e:	6a 2d                	push   $0x2d
80105f80:	e9 92 f9 ff ff       	jmp    80105917 <alltraps>

80105f85 <vector46>:
80105f85:	6a 00                	push   $0x0
80105f87:	6a 2e                	push   $0x2e
80105f89:	e9 89 f9 ff ff       	jmp    80105917 <alltraps>

80105f8e <vector47>:
80105f8e:	6a 00                	push   $0x0
80105f90:	6a 2f                	push   $0x2f
80105f92:	e9 80 f9 ff ff       	jmp    80105917 <alltraps>

80105f97 <vector48>:
80105f97:	6a 00                	push   $0x0
80105f99:	6a 30                	push   $0x30
80105f9b:	e9 77 f9 ff ff       	jmp    80105917 <alltraps>

80105fa0 <vector49>:
80105fa0:	6a 00                	push   $0x0
80105fa2:	6a 31                	push   $0x31
80105fa4:	e9 6e f9 ff ff       	jmp    80105917 <alltraps>

80105fa9 <vector50>:
80105fa9:	6a 00                	push   $0x0
80105fab:	6a 32                	push   $0x32
80105fad:	e9 65 f9 ff ff       	jmp    80105917 <alltraps>

80105fb2 <vector51>:
80105fb2:	6a 00                	push   $0x0
80105fb4:	6a 33                	push   $0x33
80105fb6:	e9 5c f9 ff ff       	jmp    80105917 <alltraps>

80105fbb <vector52>:
80105fbb:	6a 00                	push   $0x0
80105fbd:	6a 34                	push   $0x34
80105fbf:	e9 53 f9 ff ff       	jmp    80105917 <alltraps>

80105fc4 <vector53>:
80105fc4:	6a 00                	push   $0x0
80105fc6:	6a 35                	push   $0x35
80105fc8:	e9 4a f9 ff ff       	jmp    80105917 <alltraps>

80105fcd <vector54>:
80105fcd:	6a 00                	push   $0x0
80105fcf:	6a 36                	push   $0x36
80105fd1:	e9 41 f9 ff ff       	jmp    80105917 <alltraps>

80105fd6 <vector55>:
80105fd6:	6a 00                	push   $0x0
80105fd8:	6a 37                	push   $0x37
80105fda:	e9 38 f9 ff ff       	jmp    80105917 <alltraps>

80105fdf <vector56>:
80105fdf:	6a 00                	push   $0x0
80105fe1:	6a 38                	push   $0x38
80105fe3:	e9 2f f9 ff ff       	jmp    80105917 <alltraps>

80105fe8 <vector57>:
80105fe8:	6a 00                	push   $0x0
80105fea:	6a 39                	push   $0x39
80105fec:	e9 26 f9 ff ff       	jmp    80105917 <alltraps>

80105ff1 <vector58>:
80105ff1:	6a 00                	push   $0x0
80105ff3:	6a 3a                	push   $0x3a
80105ff5:	e9 1d f9 ff ff       	jmp    80105917 <alltraps>

80105ffa <vector59>:
80105ffa:	6a 00                	push   $0x0
80105ffc:	6a 3b                	push   $0x3b
80105ffe:	e9 14 f9 ff ff       	jmp    80105917 <alltraps>

80106003 <vector60>:
80106003:	6a 00                	push   $0x0
80106005:	6a 3c                	push   $0x3c
80106007:	e9 0b f9 ff ff       	jmp    80105917 <alltraps>

8010600c <vector61>:
8010600c:	6a 00                	push   $0x0
8010600e:	6a 3d                	push   $0x3d
80106010:	e9 02 f9 ff ff       	jmp    80105917 <alltraps>

80106015 <vector62>:
80106015:	6a 00                	push   $0x0
80106017:	6a 3e                	push   $0x3e
80106019:	e9 f9 f8 ff ff       	jmp    80105917 <alltraps>

8010601e <vector63>:
8010601e:	6a 00                	push   $0x0
80106020:	6a 3f                	push   $0x3f
80106022:	e9 f0 f8 ff ff       	jmp    80105917 <alltraps>

80106027 <vector64>:
80106027:	6a 00                	push   $0x0
80106029:	6a 40                	push   $0x40
8010602b:	e9 e7 f8 ff ff       	jmp    80105917 <alltraps>

80106030 <vector65>:
80106030:	6a 00                	push   $0x0
80106032:	6a 41                	push   $0x41
80106034:	e9 de f8 ff ff       	jmp    80105917 <alltraps>

80106039 <vector66>:
80106039:	6a 00                	push   $0x0
8010603b:	6a 42                	push   $0x42
8010603d:	e9 d5 f8 ff ff       	jmp    80105917 <alltraps>

80106042 <vector67>:
80106042:	6a 00                	push   $0x0
80106044:	6a 43                	push   $0x43
80106046:	e9 cc f8 ff ff       	jmp    80105917 <alltraps>

8010604b <vector68>:
8010604b:	6a 00                	push   $0x0
8010604d:	6a 44                	push   $0x44
8010604f:	e9 c3 f8 ff ff       	jmp    80105917 <alltraps>

80106054 <vector69>:
80106054:	6a 00                	push   $0x0
80106056:	6a 45                	push   $0x45
80106058:	e9 ba f8 ff ff       	jmp    80105917 <alltraps>

8010605d <vector70>:
8010605d:	6a 00                	push   $0x0
8010605f:	6a 46                	push   $0x46
80106061:	e9 b1 f8 ff ff       	jmp    80105917 <alltraps>

80106066 <vector71>:
80106066:	6a 00                	push   $0x0
80106068:	6a 47                	push   $0x47
8010606a:	e9 a8 f8 ff ff       	jmp    80105917 <alltraps>

8010606f <vector72>:
8010606f:	6a 00                	push   $0x0
80106071:	6a 48                	push   $0x48
80106073:	e9 9f f8 ff ff       	jmp    80105917 <alltraps>

80106078 <vector73>:
80106078:	6a 00                	push   $0x0
8010607a:	6a 49                	push   $0x49
8010607c:	e9 96 f8 ff ff       	jmp    80105917 <alltraps>

80106081 <vector74>:
80106081:	6a 00                	push   $0x0
80106083:	6a 4a                	push   $0x4a
80106085:	e9 8d f8 ff ff       	jmp    80105917 <alltraps>

8010608a <vector75>:
8010608a:	6a 00                	push   $0x0
8010608c:	6a 4b                	push   $0x4b
8010608e:	e9 84 f8 ff ff       	jmp    80105917 <alltraps>

80106093 <vector76>:
80106093:	6a 00                	push   $0x0
80106095:	6a 4c                	push   $0x4c
80106097:	e9 7b f8 ff ff       	jmp    80105917 <alltraps>

8010609c <vector77>:
8010609c:	6a 00                	push   $0x0
8010609e:	6a 4d                	push   $0x4d
801060a0:	e9 72 f8 ff ff       	jmp    80105917 <alltraps>

801060a5 <vector78>:
801060a5:	6a 00                	push   $0x0
801060a7:	6a 4e                	push   $0x4e
801060a9:	e9 69 f8 ff ff       	jmp    80105917 <alltraps>

801060ae <vector79>:
801060ae:	6a 00                	push   $0x0
801060b0:	6a 4f                	push   $0x4f
801060b2:	e9 60 f8 ff ff       	jmp    80105917 <alltraps>

801060b7 <vector80>:
801060b7:	6a 00                	push   $0x0
801060b9:	6a 50                	push   $0x50
801060bb:	e9 57 f8 ff ff       	jmp    80105917 <alltraps>

801060c0 <vector81>:
801060c0:	6a 00                	push   $0x0
801060c2:	6a 51                	push   $0x51
801060c4:	e9 4e f8 ff ff       	jmp    80105917 <alltraps>

801060c9 <vector82>:
801060c9:	6a 00                	push   $0x0
801060cb:	6a 52                	push   $0x52
801060cd:	e9 45 f8 ff ff       	jmp    80105917 <alltraps>

801060d2 <vector83>:
801060d2:	6a 00                	push   $0x0
801060d4:	6a 53                	push   $0x53
801060d6:	e9 3c f8 ff ff       	jmp    80105917 <alltraps>

801060db <vector84>:
801060db:	6a 00                	push   $0x0
801060dd:	6a 54                	push   $0x54
801060df:	e9 33 f8 ff ff       	jmp    80105917 <alltraps>

801060e4 <vector85>:
801060e4:	6a 00                	push   $0x0
801060e6:	6a 55                	push   $0x55
801060e8:	e9 2a f8 ff ff       	jmp    80105917 <alltraps>

801060ed <vector86>:
801060ed:	6a 00                	push   $0x0
801060ef:	6a 56                	push   $0x56
801060f1:	e9 21 f8 ff ff       	jmp    80105917 <alltraps>

801060f6 <vector87>:
801060f6:	6a 00                	push   $0x0
801060f8:	6a 57                	push   $0x57
801060fa:	e9 18 f8 ff ff       	jmp    80105917 <alltraps>

801060ff <vector88>:
801060ff:	6a 00                	push   $0x0
80106101:	6a 58                	push   $0x58
80106103:	e9 0f f8 ff ff       	jmp    80105917 <alltraps>

80106108 <vector89>:
80106108:	6a 00                	push   $0x0
8010610a:	6a 59                	push   $0x59
8010610c:	e9 06 f8 ff ff       	jmp    80105917 <alltraps>

80106111 <vector90>:
80106111:	6a 00                	push   $0x0
80106113:	6a 5a                	push   $0x5a
80106115:	e9 fd f7 ff ff       	jmp    80105917 <alltraps>

8010611a <vector91>:
8010611a:	6a 00                	push   $0x0
8010611c:	6a 5b                	push   $0x5b
8010611e:	e9 f4 f7 ff ff       	jmp    80105917 <alltraps>

80106123 <vector92>:
80106123:	6a 00                	push   $0x0
80106125:	6a 5c                	push   $0x5c
80106127:	e9 eb f7 ff ff       	jmp    80105917 <alltraps>

8010612c <vector93>:
8010612c:	6a 00                	push   $0x0
8010612e:	6a 5d                	push   $0x5d
80106130:	e9 e2 f7 ff ff       	jmp    80105917 <alltraps>

80106135 <vector94>:
80106135:	6a 00                	push   $0x0
80106137:	6a 5e                	push   $0x5e
80106139:	e9 d9 f7 ff ff       	jmp    80105917 <alltraps>

8010613e <vector95>:
8010613e:	6a 00                	push   $0x0
80106140:	6a 5f                	push   $0x5f
80106142:	e9 d0 f7 ff ff       	jmp    80105917 <alltraps>

80106147 <vector96>:
80106147:	6a 00                	push   $0x0
80106149:	6a 60                	push   $0x60
8010614b:	e9 c7 f7 ff ff       	jmp    80105917 <alltraps>

80106150 <vector97>:
80106150:	6a 00                	push   $0x0
80106152:	6a 61                	push   $0x61
80106154:	e9 be f7 ff ff       	jmp    80105917 <alltraps>

80106159 <vector98>:
80106159:	6a 00                	push   $0x0
8010615b:	6a 62                	push   $0x62
8010615d:	e9 b5 f7 ff ff       	jmp    80105917 <alltraps>

80106162 <vector99>:
80106162:	6a 00                	push   $0x0
80106164:	6a 63                	push   $0x63
80106166:	e9 ac f7 ff ff       	jmp    80105917 <alltraps>

8010616b <vector100>:
8010616b:	6a 00                	push   $0x0
8010616d:	6a 64                	push   $0x64
8010616f:	e9 a3 f7 ff ff       	jmp    80105917 <alltraps>

80106174 <vector101>:
80106174:	6a 00                	push   $0x0
80106176:	6a 65                	push   $0x65
80106178:	e9 9a f7 ff ff       	jmp    80105917 <alltraps>

8010617d <vector102>:
8010617d:	6a 00                	push   $0x0
8010617f:	6a 66                	push   $0x66
80106181:	e9 91 f7 ff ff       	jmp    80105917 <alltraps>

80106186 <vector103>:
80106186:	6a 00                	push   $0x0
80106188:	6a 67                	push   $0x67
8010618a:	e9 88 f7 ff ff       	jmp    80105917 <alltraps>

8010618f <vector104>:
8010618f:	6a 00                	push   $0x0
80106191:	6a 68                	push   $0x68
80106193:	e9 7f f7 ff ff       	jmp    80105917 <alltraps>

80106198 <vector105>:
80106198:	6a 00                	push   $0x0
8010619a:	6a 69                	push   $0x69
8010619c:	e9 76 f7 ff ff       	jmp    80105917 <alltraps>

801061a1 <vector106>:
801061a1:	6a 00                	push   $0x0
801061a3:	6a 6a                	push   $0x6a
801061a5:	e9 6d f7 ff ff       	jmp    80105917 <alltraps>

801061aa <vector107>:
801061aa:	6a 00                	push   $0x0
801061ac:	6a 6b                	push   $0x6b
801061ae:	e9 64 f7 ff ff       	jmp    80105917 <alltraps>

801061b3 <vector108>:
801061b3:	6a 00                	push   $0x0
801061b5:	6a 6c                	push   $0x6c
801061b7:	e9 5b f7 ff ff       	jmp    80105917 <alltraps>

801061bc <vector109>:
801061bc:	6a 00                	push   $0x0
801061be:	6a 6d                	push   $0x6d
801061c0:	e9 52 f7 ff ff       	jmp    80105917 <alltraps>

801061c5 <vector110>:
801061c5:	6a 00                	push   $0x0
801061c7:	6a 6e                	push   $0x6e
801061c9:	e9 49 f7 ff ff       	jmp    80105917 <alltraps>

801061ce <vector111>:
801061ce:	6a 00                	push   $0x0
801061d0:	6a 6f                	push   $0x6f
801061d2:	e9 40 f7 ff ff       	jmp    80105917 <alltraps>

801061d7 <vector112>:
801061d7:	6a 00                	push   $0x0
801061d9:	6a 70                	push   $0x70
801061db:	e9 37 f7 ff ff       	jmp    80105917 <alltraps>

801061e0 <vector113>:
801061e0:	6a 00                	push   $0x0
801061e2:	6a 71                	push   $0x71
801061e4:	e9 2e f7 ff ff       	jmp    80105917 <alltraps>

801061e9 <vector114>:
801061e9:	6a 00                	push   $0x0
801061eb:	6a 72                	push   $0x72
801061ed:	e9 25 f7 ff ff       	jmp    80105917 <alltraps>

801061f2 <vector115>:
801061f2:	6a 00                	push   $0x0
801061f4:	6a 73                	push   $0x73
801061f6:	e9 1c f7 ff ff       	jmp    80105917 <alltraps>

801061fb <vector116>:
801061fb:	6a 00                	push   $0x0
801061fd:	6a 74                	push   $0x74
801061ff:	e9 13 f7 ff ff       	jmp    80105917 <alltraps>

80106204 <vector117>:
80106204:	6a 00                	push   $0x0
80106206:	6a 75                	push   $0x75
80106208:	e9 0a f7 ff ff       	jmp    80105917 <alltraps>

8010620d <vector118>:
8010620d:	6a 00                	push   $0x0
8010620f:	6a 76                	push   $0x76
80106211:	e9 01 f7 ff ff       	jmp    80105917 <alltraps>

80106216 <vector119>:
80106216:	6a 00                	push   $0x0
80106218:	6a 77                	push   $0x77
8010621a:	e9 f8 f6 ff ff       	jmp    80105917 <alltraps>

8010621f <vector120>:
8010621f:	6a 00                	push   $0x0
80106221:	6a 78                	push   $0x78
80106223:	e9 ef f6 ff ff       	jmp    80105917 <alltraps>

80106228 <vector121>:
80106228:	6a 00                	push   $0x0
8010622a:	6a 79                	push   $0x79
8010622c:	e9 e6 f6 ff ff       	jmp    80105917 <alltraps>

80106231 <vector122>:
80106231:	6a 00                	push   $0x0
80106233:	6a 7a                	push   $0x7a
80106235:	e9 dd f6 ff ff       	jmp    80105917 <alltraps>

8010623a <vector123>:
8010623a:	6a 00                	push   $0x0
8010623c:	6a 7b                	push   $0x7b
8010623e:	e9 d4 f6 ff ff       	jmp    80105917 <alltraps>

80106243 <vector124>:
80106243:	6a 00                	push   $0x0
80106245:	6a 7c                	push   $0x7c
80106247:	e9 cb f6 ff ff       	jmp    80105917 <alltraps>

8010624c <vector125>:
8010624c:	6a 00                	push   $0x0
8010624e:	6a 7d                	push   $0x7d
80106250:	e9 c2 f6 ff ff       	jmp    80105917 <alltraps>

80106255 <vector126>:
80106255:	6a 00                	push   $0x0
80106257:	6a 7e                	push   $0x7e
80106259:	e9 b9 f6 ff ff       	jmp    80105917 <alltraps>

8010625e <vector127>:
8010625e:	6a 00                	push   $0x0
80106260:	6a 7f                	push   $0x7f
80106262:	e9 b0 f6 ff ff       	jmp    80105917 <alltraps>

80106267 <vector128>:
80106267:	6a 00                	push   $0x0
80106269:	68 80 00 00 00       	push   $0x80
8010626e:	e9 a4 f6 ff ff       	jmp    80105917 <alltraps>

80106273 <vector129>:
80106273:	6a 00                	push   $0x0
80106275:	68 81 00 00 00       	push   $0x81
8010627a:	e9 98 f6 ff ff       	jmp    80105917 <alltraps>

8010627f <vector130>:
8010627f:	6a 00                	push   $0x0
80106281:	68 82 00 00 00       	push   $0x82
80106286:	e9 8c f6 ff ff       	jmp    80105917 <alltraps>

8010628b <vector131>:
8010628b:	6a 00                	push   $0x0
8010628d:	68 83 00 00 00       	push   $0x83
80106292:	e9 80 f6 ff ff       	jmp    80105917 <alltraps>

80106297 <vector132>:
80106297:	6a 00                	push   $0x0
80106299:	68 84 00 00 00       	push   $0x84
8010629e:	e9 74 f6 ff ff       	jmp    80105917 <alltraps>

801062a3 <vector133>:
801062a3:	6a 00                	push   $0x0
801062a5:	68 85 00 00 00       	push   $0x85
801062aa:	e9 68 f6 ff ff       	jmp    80105917 <alltraps>

801062af <vector134>:
801062af:	6a 00                	push   $0x0
801062b1:	68 86 00 00 00       	push   $0x86
801062b6:	e9 5c f6 ff ff       	jmp    80105917 <alltraps>

801062bb <vector135>:
801062bb:	6a 00                	push   $0x0
801062bd:	68 87 00 00 00       	push   $0x87
801062c2:	e9 50 f6 ff ff       	jmp    80105917 <alltraps>

801062c7 <vector136>:
801062c7:	6a 00                	push   $0x0
801062c9:	68 88 00 00 00       	push   $0x88
801062ce:	e9 44 f6 ff ff       	jmp    80105917 <alltraps>

801062d3 <vector137>:
801062d3:	6a 00                	push   $0x0
801062d5:	68 89 00 00 00       	push   $0x89
801062da:	e9 38 f6 ff ff       	jmp    80105917 <alltraps>

801062df <vector138>:
801062df:	6a 00                	push   $0x0
801062e1:	68 8a 00 00 00       	push   $0x8a
801062e6:	e9 2c f6 ff ff       	jmp    80105917 <alltraps>

801062eb <vector139>:
801062eb:	6a 00                	push   $0x0
801062ed:	68 8b 00 00 00       	push   $0x8b
801062f2:	e9 20 f6 ff ff       	jmp    80105917 <alltraps>

801062f7 <vector140>:
801062f7:	6a 00                	push   $0x0
801062f9:	68 8c 00 00 00       	push   $0x8c
801062fe:	e9 14 f6 ff ff       	jmp    80105917 <alltraps>

80106303 <vector141>:
80106303:	6a 00                	push   $0x0
80106305:	68 8d 00 00 00       	push   $0x8d
8010630a:	e9 08 f6 ff ff       	jmp    80105917 <alltraps>

8010630f <vector142>:
8010630f:	6a 00                	push   $0x0
80106311:	68 8e 00 00 00       	push   $0x8e
80106316:	e9 fc f5 ff ff       	jmp    80105917 <alltraps>

8010631b <vector143>:
8010631b:	6a 00                	push   $0x0
8010631d:	68 8f 00 00 00       	push   $0x8f
80106322:	e9 f0 f5 ff ff       	jmp    80105917 <alltraps>

80106327 <vector144>:
80106327:	6a 00                	push   $0x0
80106329:	68 90 00 00 00       	push   $0x90
8010632e:	e9 e4 f5 ff ff       	jmp    80105917 <alltraps>

80106333 <vector145>:
80106333:	6a 00                	push   $0x0
80106335:	68 91 00 00 00       	push   $0x91
8010633a:	e9 d8 f5 ff ff       	jmp    80105917 <alltraps>

8010633f <vector146>:
8010633f:	6a 00                	push   $0x0
80106341:	68 92 00 00 00       	push   $0x92
80106346:	e9 cc f5 ff ff       	jmp    80105917 <alltraps>

8010634b <vector147>:
8010634b:	6a 00                	push   $0x0
8010634d:	68 93 00 00 00       	push   $0x93
80106352:	e9 c0 f5 ff ff       	jmp    80105917 <alltraps>

80106357 <vector148>:
80106357:	6a 00                	push   $0x0
80106359:	68 94 00 00 00       	push   $0x94
8010635e:	e9 b4 f5 ff ff       	jmp    80105917 <alltraps>

80106363 <vector149>:
80106363:	6a 00                	push   $0x0
80106365:	68 95 00 00 00       	push   $0x95
8010636a:	e9 a8 f5 ff ff       	jmp    80105917 <alltraps>

8010636f <vector150>:
8010636f:	6a 00                	push   $0x0
80106371:	68 96 00 00 00       	push   $0x96
80106376:	e9 9c f5 ff ff       	jmp    80105917 <alltraps>

8010637b <vector151>:
8010637b:	6a 00                	push   $0x0
8010637d:	68 97 00 00 00       	push   $0x97
80106382:	e9 90 f5 ff ff       	jmp    80105917 <alltraps>

80106387 <vector152>:
80106387:	6a 00                	push   $0x0
80106389:	68 98 00 00 00       	push   $0x98
8010638e:	e9 84 f5 ff ff       	jmp    80105917 <alltraps>

80106393 <vector153>:
80106393:	6a 00                	push   $0x0
80106395:	68 99 00 00 00       	push   $0x99
8010639a:	e9 78 f5 ff ff       	jmp    80105917 <alltraps>

8010639f <vector154>:
8010639f:	6a 00                	push   $0x0
801063a1:	68 9a 00 00 00       	push   $0x9a
801063a6:	e9 6c f5 ff ff       	jmp    80105917 <alltraps>

801063ab <vector155>:
801063ab:	6a 00                	push   $0x0
801063ad:	68 9b 00 00 00       	push   $0x9b
801063b2:	e9 60 f5 ff ff       	jmp    80105917 <alltraps>

801063b7 <vector156>:
801063b7:	6a 00                	push   $0x0
801063b9:	68 9c 00 00 00       	push   $0x9c
801063be:	e9 54 f5 ff ff       	jmp    80105917 <alltraps>

801063c3 <vector157>:
801063c3:	6a 00                	push   $0x0
801063c5:	68 9d 00 00 00       	push   $0x9d
801063ca:	e9 48 f5 ff ff       	jmp    80105917 <alltraps>

801063cf <vector158>:
801063cf:	6a 00                	push   $0x0
801063d1:	68 9e 00 00 00       	push   $0x9e
801063d6:	e9 3c f5 ff ff       	jmp    80105917 <alltraps>

801063db <vector159>:
801063db:	6a 00                	push   $0x0
801063dd:	68 9f 00 00 00       	push   $0x9f
801063e2:	e9 30 f5 ff ff       	jmp    80105917 <alltraps>

801063e7 <vector160>:
801063e7:	6a 00                	push   $0x0
801063e9:	68 a0 00 00 00       	push   $0xa0
801063ee:	e9 24 f5 ff ff       	jmp    80105917 <alltraps>

801063f3 <vector161>:
801063f3:	6a 00                	push   $0x0
801063f5:	68 a1 00 00 00       	push   $0xa1
801063fa:	e9 18 f5 ff ff       	jmp    80105917 <alltraps>

801063ff <vector162>:
801063ff:	6a 00                	push   $0x0
80106401:	68 a2 00 00 00       	push   $0xa2
80106406:	e9 0c f5 ff ff       	jmp    80105917 <alltraps>

8010640b <vector163>:
8010640b:	6a 00                	push   $0x0
8010640d:	68 a3 00 00 00       	push   $0xa3
80106412:	e9 00 f5 ff ff       	jmp    80105917 <alltraps>

80106417 <vector164>:
80106417:	6a 00                	push   $0x0
80106419:	68 a4 00 00 00       	push   $0xa4
8010641e:	e9 f4 f4 ff ff       	jmp    80105917 <alltraps>

80106423 <vector165>:
80106423:	6a 00                	push   $0x0
80106425:	68 a5 00 00 00       	push   $0xa5
8010642a:	e9 e8 f4 ff ff       	jmp    80105917 <alltraps>

8010642f <vector166>:
8010642f:	6a 00                	push   $0x0
80106431:	68 a6 00 00 00       	push   $0xa6
80106436:	e9 dc f4 ff ff       	jmp    80105917 <alltraps>

8010643b <vector167>:
8010643b:	6a 00                	push   $0x0
8010643d:	68 a7 00 00 00       	push   $0xa7
80106442:	e9 d0 f4 ff ff       	jmp    80105917 <alltraps>

80106447 <vector168>:
80106447:	6a 00                	push   $0x0
80106449:	68 a8 00 00 00       	push   $0xa8
8010644e:	e9 c4 f4 ff ff       	jmp    80105917 <alltraps>

80106453 <vector169>:
80106453:	6a 00                	push   $0x0
80106455:	68 a9 00 00 00       	push   $0xa9
8010645a:	e9 b8 f4 ff ff       	jmp    80105917 <alltraps>

8010645f <vector170>:
8010645f:	6a 00                	push   $0x0
80106461:	68 aa 00 00 00       	push   $0xaa
80106466:	e9 ac f4 ff ff       	jmp    80105917 <alltraps>

8010646b <vector171>:
8010646b:	6a 00                	push   $0x0
8010646d:	68 ab 00 00 00       	push   $0xab
80106472:	e9 a0 f4 ff ff       	jmp    80105917 <alltraps>

80106477 <vector172>:
80106477:	6a 00                	push   $0x0
80106479:	68 ac 00 00 00       	push   $0xac
8010647e:	e9 94 f4 ff ff       	jmp    80105917 <alltraps>

80106483 <vector173>:
80106483:	6a 00                	push   $0x0
80106485:	68 ad 00 00 00       	push   $0xad
8010648a:	e9 88 f4 ff ff       	jmp    80105917 <alltraps>

8010648f <vector174>:
8010648f:	6a 00                	push   $0x0
80106491:	68 ae 00 00 00       	push   $0xae
80106496:	e9 7c f4 ff ff       	jmp    80105917 <alltraps>

8010649b <vector175>:
8010649b:	6a 00                	push   $0x0
8010649d:	68 af 00 00 00       	push   $0xaf
801064a2:	e9 70 f4 ff ff       	jmp    80105917 <alltraps>

801064a7 <vector176>:
801064a7:	6a 00                	push   $0x0
801064a9:	68 b0 00 00 00       	push   $0xb0
801064ae:	e9 64 f4 ff ff       	jmp    80105917 <alltraps>

801064b3 <vector177>:
801064b3:	6a 00                	push   $0x0
801064b5:	68 b1 00 00 00       	push   $0xb1
801064ba:	e9 58 f4 ff ff       	jmp    80105917 <alltraps>

801064bf <vector178>:
801064bf:	6a 00                	push   $0x0
801064c1:	68 b2 00 00 00       	push   $0xb2
801064c6:	e9 4c f4 ff ff       	jmp    80105917 <alltraps>

801064cb <vector179>:
801064cb:	6a 00                	push   $0x0
801064cd:	68 b3 00 00 00       	push   $0xb3
801064d2:	e9 40 f4 ff ff       	jmp    80105917 <alltraps>

801064d7 <vector180>:
801064d7:	6a 00                	push   $0x0
801064d9:	68 b4 00 00 00       	push   $0xb4
801064de:	e9 34 f4 ff ff       	jmp    80105917 <alltraps>

801064e3 <vector181>:
801064e3:	6a 00                	push   $0x0
801064e5:	68 b5 00 00 00       	push   $0xb5
801064ea:	e9 28 f4 ff ff       	jmp    80105917 <alltraps>

801064ef <vector182>:
801064ef:	6a 00                	push   $0x0
801064f1:	68 b6 00 00 00       	push   $0xb6
801064f6:	e9 1c f4 ff ff       	jmp    80105917 <alltraps>

801064fb <vector183>:
801064fb:	6a 00                	push   $0x0
801064fd:	68 b7 00 00 00       	push   $0xb7
80106502:	e9 10 f4 ff ff       	jmp    80105917 <alltraps>

80106507 <vector184>:
80106507:	6a 00                	push   $0x0
80106509:	68 b8 00 00 00       	push   $0xb8
8010650e:	e9 04 f4 ff ff       	jmp    80105917 <alltraps>

80106513 <vector185>:
80106513:	6a 00                	push   $0x0
80106515:	68 b9 00 00 00       	push   $0xb9
8010651a:	e9 f8 f3 ff ff       	jmp    80105917 <alltraps>

8010651f <vector186>:
8010651f:	6a 00                	push   $0x0
80106521:	68 ba 00 00 00       	push   $0xba
80106526:	e9 ec f3 ff ff       	jmp    80105917 <alltraps>

8010652b <vector187>:
8010652b:	6a 00                	push   $0x0
8010652d:	68 bb 00 00 00       	push   $0xbb
80106532:	e9 e0 f3 ff ff       	jmp    80105917 <alltraps>

80106537 <vector188>:
80106537:	6a 00                	push   $0x0
80106539:	68 bc 00 00 00       	push   $0xbc
8010653e:	e9 d4 f3 ff ff       	jmp    80105917 <alltraps>

80106543 <vector189>:
80106543:	6a 00                	push   $0x0
80106545:	68 bd 00 00 00       	push   $0xbd
8010654a:	e9 c8 f3 ff ff       	jmp    80105917 <alltraps>

8010654f <vector190>:
8010654f:	6a 00                	push   $0x0
80106551:	68 be 00 00 00       	push   $0xbe
80106556:	e9 bc f3 ff ff       	jmp    80105917 <alltraps>

8010655b <vector191>:
8010655b:	6a 00                	push   $0x0
8010655d:	68 bf 00 00 00       	push   $0xbf
80106562:	e9 b0 f3 ff ff       	jmp    80105917 <alltraps>

80106567 <vector192>:
80106567:	6a 00                	push   $0x0
80106569:	68 c0 00 00 00       	push   $0xc0
8010656e:	e9 a4 f3 ff ff       	jmp    80105917 <alltraps>

80106573 <vector193>:
80106573:	6a 00                	push   $0x0
80106575:	68 c1 00 00 00       	push   $0xc1
8010657a:	e9 98 f3 ff ff       	jmp    80105917 <alltraps>

8010657f <vector194>:
8010657f:	6a 00                	push   $0x0
80106581:	68 c2 00 00 00       	push   $0xc2
80106586:	e9 8c f3 ff ff       	jmp    80105917 <alltraps>

8010658b <vector195>:
8010658b:	6a 00                	push   $0x0
8010658d:	68 c3 00 00 00       	push   $0xc3
80106592:	e9 80 f3 ff ff       	jmp    80105917 <alltraps>

80106597 <vector196>:
80106597:	6a 00                	push   $0x0
80106599:	68 c4 00 00 00       	push   $0xc4
8010659e:	e9 74 f3 ff ff       	jmp    80105917 <alltraps>

801065a3 <vector197>:
801065a3:	6a 00                	push   $0x0
801065a5:	68 c5 00 00 00       	push   $0xc5
801065aa:	e9 68 f3 ff ff       	jmp    80105917 <alltraps>

801065af <vector198>:
801065af:	6a 00                	push   $0x0
801065b1:	68 c6 00 00 00       	push   $0xc6
801065b6:	e9 5c f3 ff ff       	jmp    80105917 <alltraps>

801065bb <vector199>:
801065bb:	6a 00                	push   $0x0
801065bd:	68 c7 00 00 00       	push   $0xc7
801065c2:	e9 50 f3 ff ff       	jmp    80105917 <alltraps>

801065c7 <vector200>:
801065c7:	6a 00                	push   $0x0
801065c9:	68 c8 00 00 00       	push   $0xc8
801065ce:	e9 44 f3 ff ff       	jmp    80105917 <alltraps>

801065d3 <vector201>:
801065d3:	6a 00                	push   $0x0
801065d5:	68 c9 00 00 00       	push   $0xc9
801065da:	e9 38 f3 ff ff       	jmp    80105917 <alltraps>

801065df <vector202>:
801065df:	6a 00                	push   $0x0
801065e1:	68 ca 00 00 00       	push   $0xca
801065e6:	e9 2c f3 ff ff       	jmp    80105917 <alltraps>

801065eb <vector203>:
801065eb:	6a 00                	push   $0x0
801065ed:	68 cb 00 00 00       	push   $0xcb
801065f2:	e9 20 f3 ff ff       	jmp    80105917 <alltraps>

801065f7 <vector204>:
801065f7:	6a 00                	push   $0x0
801065f9:	68 cc 00 00 00       	push   $0xcc
801065fe:	e9 14 f3 ff ff       	jmp    80105917 <alltraps>

80106603 <vector205>:
80106603:	6a 00                	push   $0x0
80106605:	68 cd 00 00 00       	push   $0xcd
8010660a:	e9 08 f3 ff ff       	jmp    80105917 <alltraps>

8010660f <vector206>:
8010660f:	6a 00                	push   $0x0
80106611:	68 ce 00 00 00       	push   $0xce
80106616:	e9 fc f2 ff ff       	jmp    80105917 <alltraps>

8010661b <vector207>:
8010661b:	6a 00                	push   $0x0
8010661d:	68 cf 00 00 00       	push   $0xcf
80106622:	e9 f0 f2 ff ff       	jmp    80105917 <alltraps>

80106627 <vector208>:
80106627:	6a 00                	push   $0x0
80106629:	68 d0 00 00 00       	push   $0xd0
8010662e:	e9 e4 f2 ff ff       	jmp    80105917 <alltraps>

80106633 <vector209>:
80106633:	6a 00                	push   $0x0
80106635:	68 d1 00 00 00       	push   $0xd1
8010663a:	e9 d8 f2 ff ff       	jmp    80105917 <alltraps>

8010663f <vector210>:
8010663f:	6a 00                	push   $0x0
80106641:	68 d2 00 00 00       	push   $0xd2
80106646:	e9 cc f2 ff ff       	jmp    80105917 <alltraps>

8010664b <vector211>:
8010664b:	6a 00                	push   $0x0
8010664d:	68 d3 00 00 00       	push   $0xd3
80106652:	e9 c0 f2 ff ff       	jmp    80105917 <alltraps>

80106657 <vector212>:
80106657:	6a 00                	push   $0x0
80106659:	68 d4 00 00 00       	push   $0xd4
8010665e:	e9 b4 f2 ff ff       	jmp    80105917 <alltraps>

80106663 <vector213>:
80106663:	6a 00                	push   $0x0
80106665:	68 d5 00 00 00       	push   $0xd5
8010666a:	e9 a8 f2 ff ff       	jmp    80105917 <alltraps>

8010666f <vector214>:
8010666f:	6a 00                	push   $0x0
80106671:	68 d6 00 00 00       	push   $0xd6
80106676:	e9 9c f2 ff ff       	jmp    80105917 <alltraps>

8010667b <vector215>:
8010667b:	6a 00                	push   $0x0
8010667d:	68 d7 00 00 00       	push   $0xd7
80106682:	e9 90 f2 ff ff       	jmp    80105917 <alltraps>

80106687 <vector216>:
80106687:	6a 00                	push   $0x0
80106689:	68 d8 00 00 00       	push   $0xd8
8010668e:	e9 84 f2 ff ff       	jmp    80105917 <alltraps>

80106693 <vector217>:
80106693:	6a 00                	push   $0x0
80106695:	68 d9 00 00 00       	push   $0xd9
8010669a:	e9 78 f2 ff ff       	jmp    80105917 <alltraps>

8010669f <vector218>:
8010669f:	6a 00                	push   $0x0
801066a1:	68 da 00 00 00       	push   $0xda
801066a6:	e9 6c f2 ff ff       	jmp    80105917 <alltraps>

801066ab <vector219>:
801066ab:	6a 00                	push   $0x0
801066ad:	68 db 00 00 00       	push   $0xdb
801066b2:	e9 60 f2 ff ff       	jmp    80105917 <alltraps>

801066b7 <vector220>:
801066b7:	6a 00                	push   $0x0
801066b9:	68 dc 00 00 00       	push   $0xdc
801066be:	e9 54 f2 ff ff       	jmp    80105917 <alltraps>

801066c3 <vector221>:
801066c3:	6a 00                	push   $0x0
801066c5:	68 dd 00 00 00       	push   $0xdd
801066ca:	e9 48 f2 ff ff       	jmp    80105917 <alltraps>

801066cf <vector222>:
801066cf:	6a 00                	push   $0x0
801066d1:	68 de 00 00 00       	push   $0xde
801066d6:	e9 3c f2 ff ff       	jmp    80105917 <alltraps>

801066db <vector223>:
801066db:	6a 00                	push   $0x0
801066dd:	68 df 00 00 00       	push   $0xdf
801066e2:	e9 30 f2 ff ff       	jmp    80105917 <alltraps>

801066e7 <vector224>:
801066e7:	6a 00                	push   $0x0
801066e9:	68 e0 00 00 00       	push   $0xe0
801066ee:	e9 24 f2 ff ff       	jmp    80105917 <alltraps>

801066f3 <vector225>:
801066f3:	6a 00                	push   $0x0
801066f5:	68 e1 00 00 00       	push   $0xe1
801066fa:	e9 18 f2 ff ff       	jmp    80105917 <alltraps>

801066ff <vector226>:
801066ff:	6a 00                	push   $0x0
80106701:	68 e2 00 00 00       	push   $0xe2
80106706:	e9 0c f2 ff ff       	jmp    80105917 <alltraps>

8010670b <vector227>:
8010670b:	6a 00                	push   $0x0
8010670d:	68 e3 00 00 00       	push   $0xe3
80106712:	e9 00 f2 ff ff       	jmp    80105917 <alltraps>

80106717 <vector228>:
80106717:	6a 00                	push   $0x0
80106719:	68 e4 00 00 00       	push   $0xe4
8010671e:	e9 f4 f1 ff ff       	jmp    80105917 <alltraps>

80106723 <vector229>:
80106723:	6a 00                	push   $0x0
80106725:	68 e5 00 00 00       	push   $0xe5
8010672a:	e9 e8 f1 ff ff       	jmp    80105917 <alltraps>

8010672f <vector230>:
8010672f:	6a 00                	push   $0x0
80106731:	68 e6 00 00 00       	push   $0xe6
80106736:	e9 dc f1 ff ff       	jmp    80105917 <alltraps>

8010673b <vector231>:
8010673b:	6a 00                	push   $0x0
8010673d:	68 e7 00 00 00       	push   $0xe7
80106742:	e9 d0 f1 ff ff       	jmp    80105917 <alltraps>

80106747 <vector232>:
80106747:	6a 00                	push   $0x0
80106749:	68 e8 00 00 00       	push   $0xe8
8010674e:	e9 c4 f1 ff ff       	jmp    80105917 <alltraps>

80106753 <vector233>:
80106753:	6a 00                	push   $0x0
80106755:	68 e9 00 00 00       	push   $0xe9
8010675a:	e9 b8 f1 ff ff       	jmp    80105917 <alltraps>

8010675f <vector234>:
8010675f:	6a 00                	push   $0x0
80106761:	68 ea 00 00 00       	push   $0xea
80106766:	e9 ac f1 ff ff       	jmp    80105917 <alltraps>

8010676b <vector235>:
8010676b:	6a 00                	push   $0x0
8010676d:	68 eb 00 00 00       	push   $0xeb
80106772:	e9 a0 f1 ff ff       	jmp    80105917 <alltraps>

80106777 <vector236>:
80106777:	6a 00                	push   $0x0
80106779:	68 ec 00 00 00       	push   $0xec
8010677e:	e9 94 f1 ff ff       	jmp    80105917 <alltraps>

80106783 <vector237>:
80106783:	6a 00                	push   $0x0
80106785:	68 ed 00 00 00       	push   $0xed
8010678a:	e9 88 f1 ff ff       	jmp    80105917 <alltraps>

8010678f <vector238>:
8010678f:	6a 00                	push   $0x0
80106791:	68 ee 00 00 00       	push   $0xee
80106796:	e9 7c f1 ff ff       	jmp    80105917 <alltraps>

8010679b <vector239>:
8010679b:	6a 00                	push   $0x0
8010679d:	68 ef 00 00 00       	push   $0xef
801067a2:	e9 70 f1 ff ff       	jmp    80105917 <alltraps>

801067a7 <vector240>:
801067a7:	6a 00                	push   $0x0
801067a9:	68 f0 00 00 00       	push   $0xf0
801067ae:	e9 64 f1 ff ff       	jmp    80105917 <alltraps>

801067b3 <vector241>:
801067b3:	6a 00                	push   $0x0
801067b5:	68 f1 00 00 00       	push   $0xf1
801067ba:	e9 58 f1 ff ff       	jmp    80105917 <alltraps>

801067bf <vector242>:
801067bf:	6a 00                	push   $0x0
801067c1:	68 f2 00 00 00       	push   $0xf2
801067c6:	e9 4c f1 ff ff       	jmp    80105917 <alltraps>

801067cb <vector243>:
801067cb:	6a 00                	push   $0x0
801067cd:	68 f3 00 00 00       	push   $0xf3
801067d2:	e9 40 f1 ff ff       	jmp    80105917 <alltraps>

801067d7 <vector244>:
801067d7:	6a 00                	push   $0x0
801067d9:	68 f4 00 00 00       	push   $0xf4
801067de:	e9 34 f1 ff ff       	jmp    80105917 <alltraps>

801067e3 <vector245>:
801067e3:	6a 00                	push   $0x0
801067e5:	68 f5 00 00 00       	push   $0xf5
801067ea:	e9 28 f1 ff ff       	jmp    80105917 <alltraps>

801067ef <vector246>:
801067ef:	6a 00                	push   $0x0
801067f1:	68 f6 00 00 00       	push   $0xf6
801067f6:	e9 1c f1 ff ff       	jmp    80105917 <alltraps>

801067fb <vector247>:
801067fb:	6a 00                	push   $0x0
801067fd:	68 f7 00 00 00       	push   $0xf7
80106802:	e9 10 f1 ff ff       	jmp    80105917 <alltraps>

80106807 <vector248>:
80106807:	6a 00                	push   $0x0
80106809:	68 f8 00 00 00       	push   $0xf8
8010680e:	e9 04 f1 ff ff       	jmp    80105917 <alltraps>

80106813 <vector249>:
80106813:	6a 00                	push   $0x0
80106815:	68 f9 00 00 00       	push   $0xf9
8010681a:	e9 f8 f0 ff ff       	jmp    80105917 <alltraps>

8010681f <vector250>:
8010681f:	6a 00                	push   $0x0
80106821:	68 fa 00 00 00       	push   $0xfa
80106826:	e9 ec f0 ff ff       	jmp    80105917 <alltraps>

8010682b <vector251>:
8010682b:	6a 00                	push   $0x0
8010682d:	68 fb 00 00 00       	push   $0xfb
80106832:	e9 e0 f0 ff ff       	jmp    80105917 <alltraps>

80106837 <vector252>:
80106837:	6a 00                	push   $0x0
80106839:	68 fc 00 00 00       	push   $0xfc
8010683e:	e9 d4 f0 ff ff       	jmp    80105917 <alltraps>

80106843 <vector253>:
80106843:	6a 00                	push   $0x0
80106845:	68 fd 00 00 00       	push   $0xfd
8010684a:	e9 c8 f0 ff ff       	jmp    80105917 <alltraps>

8010684f <vector254>:
8010684f:	6a 00                	push   $0x0
80106851:	68 fe 00 00 00       	push   $0xfe
80106856:	e9 bc f0 ff ff       	jmp    80105917 <alltraps>

8010685b <vector255>:
8010685b:	6a 00                	push   $0x0
8010685d:	68 ff 00 00 00       	push   $0xff
80106862:	e9 b0 f0 ff ff       	jmp    80105917 <alltraps>
80106867:	66 90                	xchg   %ax,%ax
80106869:	66 90                	xchg   %ax,%ax
8010686b:	66 90                	xchg   %ax,%ax
8010686d:	66 90                	xchg   %ax,%ax
8010686f:	90                   	nop

80106870 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80106870:	55                   	push   %ebp
80106871:	89 e5                	mov    %esp,%ebp
80106873:	57                   	push   %edi
80106874:	56                   	push   %esi
80106875:	53                   	push   %ebx
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80106876:	89 d3                	mov    %edx,%ebx
{
80106878:	89 d7                	mov    %edx,%edi
  pde = &pgdir[PDX(va)];
8010687a:	c1 eb 16             	shr    $0x16,%ebx
8010687d:	8d 34 98             	lea    (%eax,%ebx,4),%esi
{
80106880:	83 ec 0c             	sub    $0xc,%esp
  if(*pde & PTE_P){
80106883:	8b 06                	mov    (%esi),%eax
80106885:	a8 01                	test   $0x1,%al
80106887:	74 27                	je     801068b0 <walkpgdir+0x40>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106889:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010688e:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
80106894:	c1 ef 0a             	shr    $0xa,%edi
}
80106897:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return &pgtab[PTX(va)];
8010689a:	89 fa                	mov    %edi,%edx
8010689c:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
801068a2:	8d 04 13             	lea    (%ebx,%edx,1),%eax
}
801068a5:	5b                   	pop    %ebx
801068a6:	5e                   	pop    %esi
801068a7:	5f                   	pop    %edi
801068a8:	5d                   	pop    %ebp
801068a9:	c3                   	ret    
801068aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
801068b0:	85 c9                	test   %ecx,%ecx
801068b2:	74 2c                	je     801068e0 <walkpgdir+0x70>
801068b4:	e8 37 bc ff ff       	call   801024f0 <kalloc>
801068b9:	85 c0                	test   %eax,%eax
801068bb:	89 c3                	mov    %eax,%ebx
801068bd:	74 21                	je     801068e0 <walkpgdir+0x70>
    memset(pgtab, 0, PGSIZE);
801068bf:	83 ec 04             	sub    $0x4,%esp
801068c2:	68 00 10 00 00       	push   $0x1000
801068c7:	6a 00                	push   $0x0
801068c9:	50                   	push   %eax
801068ca:	e8 a1 dd ff ff       	call   80104670 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
801068cf:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801068d5:	83 c4 10             	add    $0x10,%esp
801068d8:	83 c8 07             	or     $0x7,%eax
801068db:	89 06                	mov    %eax,(%esi)
801068dd:	eb b5                	jmp    80106894 <walkpgdir+0x24>
801068df:	90                   	nop
}
801068e0:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 0;
801068e3:	31 c0                	xor    %eax,%eax
}
801068e5:	5b                   	pop    %ebx
801068e6:	5e                   	pop    %esi
801068e7:	5f                   	pop    %edi
801068e8:	5d                   	pop    %ebp
801068e9:	c3                   	ret    
801068ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801068f0 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
801068f0:	55                   	push   %ebp
801068f1:	89 e5                	mov    %esp,%ebp
801068f3:	57                   	push   %edi
801068f4:	56                   	push   %esi
801068f5:	53                   	push   %ebx
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
801068f6:	89 d3                	mov    %edx,%ebx
801068f8:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
{
801068fe:	83 ec 1c             	sub    $0x1c,%esp
80106901:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80106904:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
80106908:	8b 7d 08             	mov    0x8(%ebp),%edi
8010690b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106910:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
80106913:	8b 45 0c             	mov    0xc(%ebp),%eax
80106916:	29 df                	sub    %ebx,%edi
80106918:	83 c8 01             	or     $0x1,%eax
8010691b:	89 45 dc             	mov    %eax,-0x24(%ebp)
8010691e:	eb 15                	jmp    80106935 <mappages+0x45>
    if(*pte & PTE_P)
80106920:	f6 00 01             	testb  $0x1,(%eax)
80106923:	75 45                	jne    8010696a <mappages+0x7a>
    *pte = pa | perm | PTE_P;
80106925:	0b 75 dc             	or     -0x24(%ebp),%esi
    if(a == last)
80106928:	3b 5d e0             	cmp    -0x20(%ebp),%ebx
    *pte = pa | perm | PTE_P;
8010692b:	89 30                	mov    %esi,(%eax)
    if(a == last)
8010692d:	74 31                	je     80106960 <mappages+0x70>
      break;
    a += PGSIZE;
8010692f:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80106935:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106938:	b9 01 00 00 00       	mov    $0x1,%ecx
8010693d:	89 da                	mov    %ebx,%edx
8010693f:	8d 34 3b             	lea    (%ebx,%edi,1),%esi
80106942:	e8 29 ff ff ff       	call   80106870 <walkpgdir>
80106947:	85 c0                	test   %eax,%eax
80106949:	75 d5                	jne    80106920 <mappages+0x30>
    pa += PGSIZE;
  }
  return 0;
}
8010694b:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
8010694e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106953:	5b                   	pop    %ebx
80106954:	5e                   	pop    %esi
80106955:	5f                   	pop    %edi
80106956:	5d                   	pop    %ebp
80106957:	c3                   	ret    
80106958:	90                   	nop
80106959:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106960:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80106963:	31 c0                	xor    %eax,%eax
}
80106965:	5b                   	pop    %ebx
80106966:	5e                   	pop    %esi
80106967:	5f                   	pop    %edi
80106968:	5d                   	pop    %ebp
80106969:	c3                   	ret    
      panic("remap");
8010696a:	83 ec 0c             	sub    $0xc,%esp
8010696d:	68 74 7a 10 80       	push   $0x80107a74
80106972:	e8 19 9a ff ff       	call   80100390 <panic>
80106977:	89 f6                	mov    %esi,%esi
80106979:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106980 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106980:	55                   	push   %ebp
80106981:	89 e5                	mov    %esp,%ebp
80106983:	57                   	push   %edi
80106984:	56                   	push   %esi
80106985:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80106986:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
8010698c:	89 c7                	mov    %eax,%edi
  a = PGROUNDUP(newsz);
8010698e:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106994:	83 ec 1c             	sub    $0x1c,%esp
80106997:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  for(; a  < oldsz; a += PGSIZE){
8010699a:	39 d3                	cmp    %edx,%ebx
8010699c:	73 66                	jae    80106a04 <deallocuvm.part.0+0x84>
8010699e:	89 d6                	mov    %edx,%esi
801069a0:	eb 3d                	jmp    801069df <deallocuvm.part.0+0x5f>
801069a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
801069a8:	8b 10                	mov    (%eax),%edx
801069aa:	f6 c2 01             	test   $0x1,%dl
801069ad:	74 26                	je     801069d5 <deallocuvm.part.0+0x55>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
801069af:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
801069b5:	74 58                	je     80106a0f <deallocuvm.part.0+0x8f>
        panic("kfree");
      char *v = P2V(pa);
      kfree(v);
801069b7:	83 ec 0c             	sub    $0xc,%esp
      char *v = P2V(pa);
801069ba:	81 c2 00 00 00 80    	add    $0x80000000,%edx
801069c0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      kfree(v);
801069c3:	52                   	push   %edx
801069c4:	e8 77 b9 ff ff       	call   80102340 <kfree>
      *pte = 0;
801069c9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801069cc:	83 c4 10             	add    $0x10,%esp
801069cf:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; a  < oldsz; a += PGSIZE){
801069d5:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801069db:	39 f3                	cmp    %esi,%ebx
801069dd:	73 25                	jae    80106a04 <deallocuvm.part.0+0x84>
    pte = walkpgdir(pgdir, (char*)a, 0);
801069df:	31 c9                	xor    %ecx,%ecx
801069e1:	89 da                	mov    %ebx,%edx
801069e3:	89 f8                	mov    %edi,%eax
801069e5:	e8 86 fe ff ff       	call   80106870 <walkpgdir>
    if(!pte)
801069ea:	85 c0                	test   %eax,%eax
801069ec:	75 ba                	jne    801069a8 <deallocuvm.part.0+0x28>
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
801069ee:	81 e3 00 00 c0 ff    	and    $0xffc00000,%ebx
801069f4:	81 c3 00 f0 3f 00    	add    $0x3ff000,%ebx
  for(; a  < oldsz; a += PGSIZE){
801069fa:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106a00:	39 f3                	cmp    %esi,%ebx
80106a02:	72 db                	jb     801069df <deallocuvm.part.0+0x5f>
    }
  }
  return newsz;
}
80106a04:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106a07:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106a0a:	5b                   	pop    %ebx
80106a0b:	5e                   	pop    %esi
80106a0c:	5f                   	pop    %edi
80106a0d:	5d                   	pop    %ebp
80106a0e:	c3                   	ret    
        panic("kfree");
80106a0f:	83 ec 0c             	sub    $0xc,%esp
80106a12:	68 06 74 10 80       	push   $0x80107406
80106a17:	e8 74 99 ff ff       	call   80100390 <panic>
80106a1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106a20 <seginit>:
{
80106a20:	55                   	push   %ebp
80106a21:	89 e5                	mov    %esp,%ebp
80106a23:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
80106a26:	e8 f5 cc ff ff       	call   80103720 <cpuid>
80106a2b:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
  pd[0] = size-1;
80106a31:	ba 2f 00 00 00       	mov    $0x2f,%edx
80106a36:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80106a3a:	c7 80 f8 27 11 80 ff 	movl   $0xffff,-0x7feed808(%eax)
80106a41:	ff 00 00 
80106a44:	c7 80 fc 27 11 80 00 	movl   $0xcf9a00,-0x7feed804(%eax)
80106a4b:	9a cf 00 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106a4e:	c7 80 00 28 11 80 ff 	movl   $0xffff,-0x7feed800(%eax)
80106a55:	ff 00 00 
80106a58:	c7 80 04 28 11 80 00 	movl   $0xcf9200,-0x7feed7fc(%eax)
80106a5f:	92 cf 00 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106a62:	c7 80 08 28 11 80 ff 	movl   $0xffff,-0x7feed7f8(%eax)
80106a69:	ff 00 00 
80106a6c:	c7 80 0c 28 11 80 00 	movl   $0xcffa00,-0x7feed7f4(%eax)
80106a73:	fa cf 00 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106a76:	c7 80 10 28 11 80 ff 	movl   $0xffff,-0x7feed7f0(%eax)
80106a7d:	ff 00 00 
80106a80:	c7 80 14 28 11 80 00 	movl   $0xcff200,-0x7feed7ec(%eax)
80106a87:	f2 cf 00 
  lgdt(c->gdt, sizeof(c->gdt));
80106a8a:	05 f0 27 11 80       	add    $0x801127f0,%eax
  pd[1] = (uint)p;
80106a8f:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80106a93:	c1 e8 10             	shr    $0x10,%eax
80106a96:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
80106a9a:	8d 45 f2             	lea    -0xe(%ebp),%eax
80106a9d:	0f 01 10             	lgdtl  (%eax)
}
80106aa0:	c9                   	leave  
80106aa1:	c3                   	ret    
80106aa2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106aa9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106ab0 <switchkvm>:
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106ab0:	a1 a4 77 11 80       	mov    0x801177a4,%eax
{
80106ab5:	55                   	push   %ebp
80106ab6:	89 e5                	mov    %esp,%ebp
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106ab8:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106abd:	0f 22 d8             	mov    %eax,%cr3
}
80106ac0:	5d                   	pop    %ebp
80106ac1:	c3                   	ret    
80106ac2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106ac9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106ad0 <switchuvm>:
{
80106ad0:	55                   	push   %ebp
80106ad1:	89 e5                	mov    %esp,%ebp
80106ad3:	57                   	push   %edi
80106ad4:	56                   	push   %esi
80106ad5:	53                   	push   %ebx
80106ad6:	83 ec 1c             	sub    $0x1c,%esp
80106ad9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(p == 0)
80106adc:	85 db                	test   %ebx,%ebx
80106ade:	0f 84 cb 00 00 00    	je     80106baf <switchuvm+0xdf>
  if(p->kstack == 0)
80106ae4:	8b 43 08             	mov    0x8(%ebx),%eax
80106ae7:	85 c0                	test   %eax,%eax
80106ae9:	0f 84 da 00 00 00    	je     80106bc9 <switchuvm+0xf9>
  if(p->pgdir == 0)
80106aef:	8b 43 04             	mov    0x4(%ebx),%eax
80106af2:	85 c0                	test   %eax,%eax
80106af4:	0f 84 c2 00 00 00    	je     80106bbc <switchuvm+0xec>
  pushcli();
80106afa:	e8 91 d9 ff ff       	call   80104490 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80106aff:	e8 9c cb ff ff       	call   801036a0 <mycpu>
80106b04:	89 c6                	mov    %eax,%esi
80106b06:	e8 95 cb ff ff       	call   801036a0 <mycpu>
80106b0b:	89 c7                	mov    %eax,%edi
80106b0d:	e8 8e cb ff ff       	call   801036a0 <mycpu>
80106b12:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106b15:	83 c7 08             	add    $0x8,%edi
80106b18:	e8 83 cb ff ff       	call   801036a0 <mycpu>
80106b1d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80106b20:	83 c0 08             	add    $0x8,%eax
80106b23:	ba 67 00 00 00       	mov    $0x67,%edx
80106b28:	c1 e8 18             	shr    $0x18,%eax
80106b2b:	66 89 96 98 00 00 00 	mov    %dx,0x98(%esi)
80106b32:	66 89 be 9a 00 00 00 	mov    %di,0x9a(%esi)
80106b39:	88 86 9f 00 00 00    	mov    %al,0x9f(%esi)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106b3f:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80106b44:	83 c1 08             	add    $0x8,%ecx
80106b47:	c1 e9 10             	shr    $0x10,%ecx
80106b4a:	88 8e 9c 00 00 00    	mov    %cl,0x9c(%esi)
80106b50:	b9 99 40 00 00       	mov    $0x4099,%ecx
80106b55:	66 89 8e 9d 00 00 00 	mov    %cx,0x9d(%esi)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80106b5c:	be 10 00 00 00       	mov    $0x10,%esi
  mycpu()->gdt[SEG_TSS].s = 0;
80106b61:	e8 3a cb ff ff       	call   801036a0 <mycpu>
80106b66:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80106b6d:	e8 2e cb ff ff       	call   801036a0 <mycpu>
80106b72:	66 89 70 10          	mov    %si,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80106b76:	8b 73 08             	mov    0x8(%ebx),%esi
80106b79:	e8 22 cb ff ff       	call   801036a0 <mycpu>
80106b7e:	81 c6 00 10 00 00    	add    $0x1000,%esi
80106b84:	89 70 0c             	mov    %esi,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106b87:	e8 14 cb ff ff       	call   801036a0 <mycpu>
80106b8c:	66 89 78 6e          	mov    %di,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
80106b90:	b8 28 00 00 00       	mov    $0x28,%eax
80106b95:	0f 00 d8             	ltr    %ax
  lcr3(V2P(p->pgdir));  // switch to process's address space
80106b98:	8b 43 04             	mov    0x4(%ebx),%eax
80106b9b:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106ba0:	0f 22 d8             	mov    %eax,%cr3
}
80106ba3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106ba6:	5b                   	pop    %ebx
80106ba7:	5e                   	pop    %esi
80106ba8:	5f                   	pop    %edi
80106ba9:	5d                   	pop    %ebp
  popcli();
80106baa:	e9 21 d9 ff ff       	jmp    801044d0 <popcli>
    panic("switchuvm: no process");
80106baf:	83 ec 0c             	sub    $0xc,%esp
80106bb2:	68 7a 7a 10 80       	push   $0x80107a7a
80106bb7:	e8 d4 97 ff ff       	call   80100390 <panic>
    panic("switchuvm: no pgdir");
80106bbc:	83 ec 0c             	sub    $0xc,%esp
80106bbf:	68 a5 7a 10 80       	push   $0x80107aa5
80106bc4:	e8 c7 97 ff ff       	call   80100390 <panic>
    panic("switchuvm: no kstack");
80106bc9:	83 ec 0c             	sub    $0xc,%esp
80106bcc:	68 90 7a 10 80       	push   $0x80107a90
80106bd1:	e8 ba 97 ff ff       	call   80100390 <panic>
80106bd6:	8d 76 00             	lea    0x0(%esi),%esi
80106bd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106be0 <inituvm>:
{
80106be0:	55                   	push   %ebp
80106be1:	89 e5                	mov    %esp,%ebp
80106be3:	57                   	push   %edi
80106be4:	56                   	push   %esi
80106be5:	53                   	push   %ebx
80106be6:	83 ec 1c             	sub    $0x1c,%esp
80106be9:	8b 75 10             	mov    0x10(%ebp),%esi
80106bec:	8b 45 08             	mov    0x8(%ebp),%eax
80106bef:	8b 7d 0c             	mov    0xc(%ebp),%edi
  if(sz >= PGSIZE)
80106bf2:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
{
80106bf8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
80106bfb:	77 49                	ja     80106c46 <inituvm+0x66>
  mem = kalloc();
80106bfd:	e8 ee b8 ff ff       	call   801024f0 <kalloc>
  memset(mem, 0, PGSIZE);
80106c02:	83 ec 04             	sub    $0x4,%esp
  mem = kalloc();
80106c05:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80106c07:	68 00 10 00 00       	push   $0x1000
80106c0c:	6a 00                	push   $0x0
80106c0e:	50                   	push   %eax
80106c0f:	e8 5c da ff ff       	call   80104670 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80106c14:	58                   	pop    %eax
80106c15:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106c1b:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106c20:	5a                   	pop    %edx
80106c21:	6a 06                	push   $0x6
80106c23:	50                   	push   %eax
80106c24:	31 d2                	xor    %edx,%edx
80106c26:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106c29:	e8 c2 fc ff ff       	call   801068f0 <mappages>
  memmove(mem, init, sz);
80106c2e:	89 75 10             	mov    %esi,0x10(%ebp)
80106c31:	89 7d 0c             	mov    %edi,0xc(%ebp)
80106c34:	83 c4 10             	add    $0x10,%esp
80106c37:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80106c3a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106c3d:	5b                   	pop    %ebx
80106c3e:	5e                   	pop    %esi
80106c3f:	5f                   	pop    %edi
80106c40:	5d                   	pop    %ebp
  memmove(mem, init, sz);
80106c41:	e9 da da ff ff       	jmp    80104720 <memmove>
    panic("inituvm: more than a page");
80106c46:	83 ec 0c             	sub    $0xc,%esp
80106c49:	68 b9 7a 10 80       	push   $0x80107ab9
80106c4e:	e8 3d 97 ff ff       	call   80100390 <panic>
80106c53:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106c59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106c60 <loaduvm>:
{
80106c60:	55                   	push   %ebp
80106c61:	89 e5                	mov    %esp,%ebp
80106c63:	57                   	push   %edi
80106c64:	56                   	push   %esi
80106c65:	53                   	push   %ebx
80106c66:	83 ec 0c             	sub    $0xc,%esp
  if((uint) addr % PGSIZE != 0)
80106c69:	f7 45 0c ff 0f 00 00 	testl  $0xfff,0xc(%ebp)
80106c70:	0f 85 91 00 00 00    	jne    80106d07 <loaduvm+0xa7>
  for(i = 0; i < sz; i += PGSIZE){
80106c76:	8b 75 18             	mov    0x18(%ebp),%esi
80106c79:	31 db                	xor    %ebx,%ebx
80106c7b:	85 f6                	test   %esi,%esi
80106c7d:	75 1a                	jne    80106c99 <loaduvm+0x39>
80106c7f:	eb 6f                	jmp    80106cf0 <loaduvm+0x90>
80106c81:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106c88:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106c8e:	81 ee 00 10 00 00    	sub    $0x1000,%esi
80106c94:	39 5d 18             	cmp    %ebx,0x18(%ebp)
80106c97:	76 57                	jbe    80106cf0 <loaduvm+0x90>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80106c99:	8b 55 0c             	mov    0xc(%ebp),%edx
80106c9c:	8b 45 08             	mov    0x8(%ebp),%eax
80106c9f:	31 c9                	xor    %ecx,%ecx
80106ca1:	01 da                	add    %ebx,%edx
80106ca3:	e8 c8 fb ff ff       	call   80106870 <walkpgdir>
80106ca8:	85 c0                	test   %eax,%eax
80106caa:	74 4e                	je     80106cfa <loaduvm+0x9a>
    pa = PTE_ADDR(*pte);
80106cac:	8b 00                	mov    (%eax),%eax
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106cae:	8b 4d 14             	mov    0x14(%ebp),%ecx
    if(sz - i < PGSIZE)
80106cb1:	bf 00 10 00 00       	mov    $0x1000,%edi
    pa = PTE_ADDR(*pte);
80106cb6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
80106cbb:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
80106cc1:	0f 46 fe             	cmovbe %esi,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106cc4:	01 d9                	add    %ebx,%ecx
80106cc6:	05 00 00 00 80       	add    $0x80000000,%eax
80106ccb:	57                   	push   %edi
80106ccc:	51                   	push   %ecx
80106ccd:	50                   	push   %eax
80106cce:	ff 75 10             	pushl  0x10(%ebp)
80106cd1:	e8 ba ac ff ff       	call   80101990 <readi>
80106cd6:	83 c4 10             	add    $0x10,%esp
80106cd9:	39 f8                	cmp    %edi,%eax
80106cdb:	74 ab                	je     80106c88 <loaduvm+0x28>
}
80106cdd:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80106ce0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106ce5:	5b                   	pop    %ebx
80106ce6:	5e                   	pop    %esi
80106ce7:	5f                   	pop    %edi
80106ce8:	5d                   	pop    %ebp
80106ce9:	c3                   	ret    
80106cea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106cf0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80106cf3:	31 c0                	xor    %eax,%eax
}
80106cf5:	5b                   	pop    %ebx
80106cf6:	5e                   	pop    %esi
80106cf7:	5f                   	pop    %edi
80106cf8:	5d                   	pop    %ebp
80106cf9:	c3                   	ret    
      panic("loaduvm: address should exist");
80106cfa:	83 ec 0c             	sub    $0xc,%esp
80106cfd:	68 d3 7a 10 80       	push   $0x80107ad3
80106d02:	e8 89 96 ff ff       	call   80100390 <panic>
    panic("loaduvm: addr must be page aligned");
80106d07:	83 ec 0c             	sub    $0xc,%esp
80106d0a:	68 74 7b 10 80       	push   $0x80107b74
80106d0f:	e8 7c 96 ff ff       	call   80100390 <panic>
80106d14:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106d1a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106d20 <allocuvm>:
{
80106d20:	55                   	push   %ebp
80106d21:	89 e5                	mov    %esp,%ebp
80106d23:	57                   	push   %edi
80106d24:	56                   	push   %esi
80106d25:	53                   	push   %ebx
80106d26:	83 ec 1c             	sub    $0x1c,%esp
  if(newsz >= KERNBASE)
80106d29:	8b 7d 10             	mov    0x10(%ebp),%edi
80106d2c:	85 ff                	test   %edi,%edi
80106d2e:	0f 88 8e 00 00 00    	js     80106dc2 <allocuvm+0xa2>
  if(newsz < oldsz)
80106d34:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80106d37:	0f 82 93 00 00 00    	jb     80106dd0 <allocuvm+0xb0>
  a = PGROUNDUP(oldsz);
80106d3d:	8b 45 0c             	mov    0xc(%ebp),%eax
80106d40:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80106d46:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a < newsz; a += PGSIZE){
80106d4c:	39 5d 10             	cmp    %ebx,0x10(%ebp)
80106d4f:	0f 86 7e 00 00 00    	jbe    80106dd3 <allocuvm+0xb3>
80106d55:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80106d58:	8b 7d 08             	mov    0x8(%ebp),%edi
80106d5b:	eb 42                	jmp    80106d9f <allocuvm+0x7f>
80106d5d:	8d 76 00             	lea    0x0(%esi),%esi
    memset(mem, 0, PGSIZE);
80106d60:	83 ec 04             	sub    $0x4,%esp
80106d63:	68 00 10 00 00       	push   $0x1000
80106d68:	6a 00                	push   $0x0
80106d6a:	50                   	push   %eax
80106d6b:	e8 00 d9 ff ff       	call   80104670 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80106d70:	58                   	pop    %eax
80106d71:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80106d77:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106d7c:	5a                   	pop    %edx
80106d7d:	6a 06                	push   $0x6
80106d7f:	50                   	push   %eax
80106d80:	89 da                	mov    %ebx,%edx
80106d82:	89 f8                	mov    %edi,%eax
80106d84:	e8 67 fb ff ff       	call   801068f0 <mappages>
80106d89:	83 c4 10             	add    $0x10,%esp
80106d8c:	85 c0                	test   %eax,%eax
80106d8e:	78 50                	js     80106de0 <allocuvm+0xc0>
  for(; a < newsz; a += PGSIZE){
80106d90:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106d96:	39 5d 10             	cmp    %ebx,0x10(%ebp)
80106d99:	0f 86 81 00 00 00    	jbe    80106e20 <allocuvm+0x100>
    mem = kalloc();
80106d9f:	e8 4c b7 ff ff       	call   801024f0 <kalloc>
    if(mem == 0){
80106da4:	85 c0                	test   %eax,%eax
    mem = kalloc();
80106da6:	89 c6                	mov    %eax,%esi
    if(mem == 0){
80106da8:	75 b6                	jne    80106d60 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
80106daa:	83 ec 0c             	sub    $0xc,%esp
80106dad:	68 f1 7a 10 80       	push   $0x80107af1
80106db2:	e8 a9 98 ff ff       	call   80100660 <cprintf>
  if(newsz >= oldsz)
80106db7:	83 c4 10             	add    $0x10,%esp
80106dba:	8b 45 0c             	mov    0xc(%ebp),%eax
80106dbd:	39 45 10             	cmp    %eax,0x10(%ebp)
80106dc0:	77 6e                	ja     80106e30 <allocuvm+0x110>
}
80106dc2:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
80106dc5:	31 ff                	xor    %edi,%edi
}
80106dc7:	89 f8                	mov    %edi,%eax
80106dc9:	5b                   	pop    %ebx
80106dca:	5e                   	pop    %esi
80106dcb:	5f                   	pop    %edi
80106dcc:	5d                   	pop    %ebp
80106dcd:	c3                   	ret    
80106dce:	66 90                	xchg   %ax,%ax
    return oldsz;
80106dd0:	8b 7d 0c             	mov    0xc(%ebp),%edi
}
80106dd3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106dd6:	89 f8                	mov    %edi,%eax
80106dd8:	5b                   	pop    %ebx
80106dd9:	5e                   	pop    %esi
80106dda:	5f                   	pop    %edi
80106ddb:	5d                   	pop    %ebp
80106ddc:	c3                   	ret    
80106ddd:	8d 76 00             	lea    0x0(%esi),%esi
      cprintf("allocuvm out of memory (2)\n");
80106de0:	83 ec 0c             	sub    $0xc,%esp
80106de3:	68 09 7b 10 80       	push   $0x80107b09
80106de8:	e8 73 98 ff ff       	call   80100660 <cprintf>
  if(newsz >= oldsz)
80106ded:	83 c4 10             	add    $0x10,%esp
80106df0:	8b 45 0c             	mov    0xc(%ebp),%eax
80106df3:	39 45 10             	cmp    %eax,0x10(%ebp)
80106df6:	76 0d                	jbe    80106e05 <allocuvm+0xe5>
80106df8:	89 c1                	mov    %eax,%ecx
80106dfa:	8b 55 10             	mov    0x10(%ebp),%edx
80106dfd:	8b 45 08             	mov    0x8(%ebp),%eax
80106e00:	e8 7b fb ff ff       	call   80106980 <deallocuvm.part.0>
      kfree(mem);
80106e05:	83 ec 0c             	sub    $0xc,%esp
      return 0;
80106e08:	31 ff                	xor    %edi,%edi
      kfree(mem);
80106e0a:	56                   	push   %esi
80106e0b:	e8 30 b5 ff ff       	call   80102340 <kfree>
      return 0;
80106e10:	83 c4 10             	add    $0x10,%esp
}
80106e13:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106e16:	89 f8                	mov    %edi,%eax
80106e18:	5b                   	pop    %ebx
80106e19:	5e                   	pop    %esi
80106e1a:	5f                   	pop    %edi
80106e1b:	5d                   	pop    %ebp
80106e1c:	c3                   	ret    
80106e1d:	8d 76 00             	lea    0x0(%esi),%esi
80106e20:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80106e23:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106e26:	5b                   	pop    %ebx
80106e27:	89 f8                	mov    %edi,%eax
80106e29:	5e                   	pop    %esi
80106e2a:	5f                   	pop    %edi
80106e2b:	5d                   	pop    %ebp
80106e2c:	c3                   	ret    
80106e2d:	8d 76 00             	lea    0x0(%esi),%esi
80106e30:	89 c1                	mov    %eax,%ecx
80106e32:	8b 55 10             	mov    0x10(%ebp),%edx
80106e35:	8b 45 08             	mov    0x8(%ebp),%eax
      return 0;
80106e38:	31 ff                	xor    %edi,%edi
80106e3a:	e8 41 fb ff ff       	call   80106980 <deallocuvm.part.0>
80106e3f:	eb 92                	jmp    80106dd3 <allocuvm+0xb3>
80106e41:	eb 0d                	jmp    80106e50 <deallocuvm>
80106e43:	90                   	nop
80106e44:	90                   	nop
80106e45:	90                   	nop
80106e46:	90                   	nop
80106e47:	90                   	nop
80106e48:	90                   	nop
80106e49:	90                   	nop
80106e4a:	90                   	nop
80106e4b:	90                   	nop
80106e4c:	90                   	nop
80106e4d:	90                   	nop
80106e4e:	90                   	nop
80106e4f:	90                   	nop

80106e50 <deallocuvm>:
{
80106e50:	55                   	push   %ebp
80106e51:	89 e5                	mov    %esp,%ebp
80106e53:	8b 55 0c             	mov    0xc(%ebp),%edx
80106e56:	8b 4d 10             	mov    0x10(%ebp),%ecx
80106e59:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
80106e5c:	39 d1                	cmp    %edx,%ecx
80106e5e:	73 10                	jae    80106e70 <deallocuvm+0x20>
}
80106e60:	5d                   	pop    %ebp
80106e61:	e9 1a fb ff ff       	jmp    80106980 <deallocuvm.part.0>
80106e66:	8d 76 00             	lea    0x0(%esi),%esi
80106e69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80106e70:	89 d0                	mov    %edx,%eax
80106e72:	5d                   	pop    %ebp
80106e73:	c3                   	ret    
80106e74:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106e7a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106e80 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80106e80:	55                   	push   %ebp
80106e81:	89 e5                	mov    %esp,%ebp
80106e83:	57                   	push   %edi
80106e84:	56                   	push   %esi
80106e85:	53                   	push   %ebx
80106e86:	83 ec 0c             	sub    $0xc,%esp
80106e89:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
80106e8c:	85 f6                	test   %esi,%esi
80106e8e:	74 59                	je     80106ee9 <freevm+0x69>
80106e90:	31 c9                	xor    %ecx,%ecx
80106e92:	ba 00 00 00 80       	mov    $0x80000000,%edx
80106e97:	89 f0                	mov    %esi,%eax
80106e99:	e8 e2 fa ff ff       	call   80106980 <deallocuvm.part.0>
80106e9e:	89 f3                	mov    %esi,%ebx
80106ea0:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80106ea6:	eb 0f                	jmp    80106eb7 <freevm+0x37>
80106ea8:	90                   	nop
80106ea9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106eb0:	83 c3 04             	add    $0x4,%ebx
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80106eb3:	39 fb                	cmp    %edi,%ebx
80106eb5:	74 23                	je     80106eda <freevm+0x5a>
    if(pgdir[i] & PTE_P){
80106eb7:	8b 03                	mov    (%ebx),%eax
80106eb9:	a8 01                	test   $0x1,%al
80106ebb:	74 f3                	je     80106eb0 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
80106ebd:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      kfree(v);
80106ec2:	83 ec 0c             	sub    $0xc,%esp
80106ec5:	83 c3 04             	add    $0x4,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
80106ec8:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
80106ecd:	50                   	push   %eax
80106ece:	e8 6d b4 ff ff       	call   80102340 <kfree>
80106ed3:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
80106ed6:	39 fb                	cmp    %edi,%ebx
80106ed8:	75 dd                	jne    80106eb7 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
80106eda:	89 75 08             	mov    %esi,0x8(%ebp)
}
80106edd:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106ee0:	5b                   	pop    %ebx
80106ee1:	5e                   	pop    %esi
80106ee2:	5f                   	pop    %edi
80106ee3:	5d                   	pop    %ebp
  kfree((char*)pgdir);
80106ee4:	e9 57 b4 ff ff       	jmp    80102340 <kfree>
    panic("freevm: no pgdir");
80106ee9:	83 ec 0c             	sub    $0xc,%esp
80106eec:	68 25 7b 10 80       	push   $0x80107b25
80106ef1:	e8 9a 94 ff ff       	call   80100390 <panic>
80106ef6:	8d 76 00             	lea    0x0(%esi),%esi
80106ef9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106f00 <setupkvm>:
{
80106f00:	55                   	push   %ebp
80106f01:	89 e5                	mov    %esp,%ebp
80106f03:	56                   	push   %esi
80106f04:	53                   	push   %ebx
  if((pgdir = (pde_t*)kalloc()) == 0)
80106f05:	e8 e6 b5 ff ff       	call   801024f0 <kalloc>
80106f0a:	85 c0                	test   %eax,%eax
80106f0c:	89 c6                	mov    %eax,%esi
80106f0e:	74 42                	je     80106f52 <setupkvm+0x52>
  memset(pgdir, 0, PGSIZE);
80106f10:	83 ec 04             	sub    $0x4,%esp
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106f13:	bb 20 a4 10 80       	mov    $0x8010a420,%ebx
  memset(pgdir, 0, PGSIZE);
80106f18:	68 00 10 00 00       	push   $0x1000
80106f1d:	6a 00                	push   $0x0
80106f1f:	50                   	push   %eax
80106f20:	e8 4b d7 ff ff       	call   80104670 <memset>
80106f25:	83 c4 10             	add    $0x10,%esp
                (uint)k->phys_start, k->perm) < 0) {
80106f28:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
80106f2b:	8b 4b 08             	mov    0x8(%ebx),%ecx
80106f2e:	83 ec 08             	sub    $0x8,%esp
80106f31:	8b 13                	mov    (%ebx),%edx
80106f33:	ff 73 0c             	pushl  0xc(%ebx)
80106f36:	50                   	push   %eax
80106f37:	29 c1                	sub    %eax,%ecx
80106f39:	89 f0                	mov    %esi,%eax
80106f3b:	e8 b0 f9 ff ff       	call   801068f0 <mappages>
80106f40:	83 c4 10             	add    $0x10,%esp
80106f43:	85 c0                	test   %eax,%eax
80106f45:	78 19                	js     80106f60 <setupkvm+0x60>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106f47:	83 c3 10             	add    $0x10,%ebx
80106f4a:	81 fb 60 a4 10 80    	cmp    $0x8010a460,%ebx
80106f50:	75 d6                	jne    80106f28 <setupkvm+0x28>
}
80106f52:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106f55:	89 f0                	mov    %esi,%eax
80106f57:	5b                   	pop    %ebx
80106f58:	5e                   	pop    %esi
80106f59:	5d                   	pop    %ebp
80106f5a:	c3                   	ret    
80106f5b:	90                   	nop
80106f5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      freevm(pgdir);
80106f60:	83 ec 0c             	sub    $0xc,%esp
80106f63:	56                   	push   %esi
      return 0;
80106f64:	31 f6                	xor    %esi,%esi
      freevm(pgdir);
80106f66:	e8 15 ff ff ff       	call   80106e80 <freevm>
      return 0;
80106f6b:	83 c4 10             	add    $0x10,%esp
}
80106f6e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106f71:	89 f0                	mov    %esi,%eax
80106f73:	5b                   	pop    %ebx
80106f74:	5e                   	pop    %esi
80106f75:	5d                   	pop    %ebp
80106f76:	c3                   	ret    
80106f77:	89 f6                	mov    %esi,%esi
80106f79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106f80 <kvmalloc>:
{
80106f80:	55                   	push   %ebp
80106f81:	89 e5                	mov    %esp,%ebp
80106f83:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80106f86:	e8 75 ff ff ff       	call   80106f00 <setupkvm>
80106f8b:	a3 a4 77 11 80       	mov    %eax,0x801177a4
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106f90:	05 00 00 00 80       	add    $0x80000000,%eax
80106f95:	0f 22 d8             	mov    %eax,%cr3
}
80106f98:	c9                   	leave  
80106f99:	c3                   	ret    
80106f9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106fa0 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80106fa0:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80106fa1:	31 c9                	xor    %ecx,%ecx
{
80106fa3:	89 e5                	mov    %esp,%ebp
80106fa5:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
80106fa8:	8b 55 0c             	mov    0xc(%ebp),%edx
80106fab:	8b 45 08             	mov    0x8(%ebp),%eax
80106fae:	e8 bd f8 ff ff       	call   80106870 <walkpgdir>
  if(pte == 0)
80106fb3:	85 c0                	test   %eax,%eax
80106fb5:	74 05                	je     80106fbc <clearpteu+0x1c>
    panic("clearpteu");
  *pte &= ~PTE_U;
80106fb7:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
80106fba:	c9                   	leave  
80106fbb:	c3                   	ret    
    panic("clearpteu");
80106fbc:	83 ec 0c             	sub    $0xc,%esp
80106fbf:	68 36 7b 10 80       	push   $0x80107b36
80106fc4:	e8 c7 93 ff ff       	call   80100390 <panic>
80106fc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106fd0 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80106fd0:	55                   	push   %ebp
80106fd1:	89 e5                	mov    %esp,%ebp
80106fd3:	57                   	push   %edi
80106fd4:	56                   	push   %esi
80106fd5:	53                   	push   %ebx
80106fd6:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80106fd9:	e8 22 ff ff ff       	call   80106f00 <setupkvm>
80106fde:	85 c0                	test   %eax,%eax
80106fe0:	89 45 e0             	mov    %eax,-0x20(%ebp)
80106fe3:	0f 84 9f 00 00 00    	je     80107088 <copyuvm+0xb8>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80106fe9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80106fec:	85 c9                	test   %ecx,%ecx
80106fee:	0f 84 94 00 00 00    	je     80107088 <copyuvm+0xb8>
80106ff4:	31 ff                	xor    %edi,%edi
80106ff6:	eb 4a                	jmp    80107042 <copyuvm+0x72>
80106ff8:	90                   	nop
80106ff9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80107000:	83 ec 04             	sub    $0x4,%esp
80107003:	81 c3 00 00 00 80    	add    $0x80000000,%ebx
80107009:	68 00 10 00 00       	push   $0x1000
8010700e:	53                   	push   %ebx
8010700f:	50                   	push   %eax
80107010:	e8 0b d7 ff ff       	call   80104720 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
80107015:	58                   	pop    %eax
80107016:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
8010701c:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107021:	5a                   	pop    %edx
80107022:	ff 75 e4             	pushl  -0x1c(%ebp)
80107025:	50                   	push   %eax
80107026:	89 fa                	mov    %edi,%edx
80107028:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010702b:	e8 c0 f8 ff ff       	call   801068f0 <mappages>
80107030:	83 c4 10             	add    $0x10,%esp
80107033:	85 c0                	test   %eax,%eax
80107035:	78 61                	js     80107098 <copyuvm+0xc8>
  for(i = 0; i < sz; i += PGSIZE){
80107037:	81 c7 00 10 00 00    	add    $0x1000,%edi
8010703d:	39 7d 0c             	cmp    %edi,0xc(%ebp)
80107040:	76 46                	jbe    80107088 <copyuvm+0xb8>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80107042:	8b 45 08             	mov    0x8(%ebp),%eax
80107045:	31 c9                	xor    %ecx,%ecx
80107047:	89 fa                	mov    %edi,%edx
80107049:	e8 22 f8 ff ff       	call   80106870 <walkpgdir>
8010704e:	85 c0                	test   %eax,%eax
80107050:	74 61                	je     801070b3 <copyuvm+0xe3>
    if(!(*pte & PTE_P))
80107052:	8b 00                	mov    (%eax),%eax
80107054:	a8 01                	test   $0x1,%al
80107056:	74 4e                	je     801070a6 <copyuvm+0xd6>
    pa = PTE_ADDR(*pte);
80107058:	89 c3                	mov    %eax,%ebx
    flags = PTE_FLAGS(*pte);
8010705a:	25 ff 0f 00 00       	and    $0xfff,%eax
    pa = PTE_ADDR(*pte);
8010705f:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
    flags = PTE_FLAGS(*pte);
80107065:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if((mem = kalloc()) == 0)
80107068:	e8 83 b4 ff ff       	call   801024f0 <kalloc>
8010706d:	85 c0                	test   %eax,%eax
8010706f:	89 c6                	mov    %eax,%esi
80107071:	75 8d                	jne    80107000 <copyuvm+0x30>
    }
  }
  return d;

bad:
  freevm(d);
80107073:	83 ec 0c             	sub    $0xc,%esp
80107076:	ff 75 e0             	pushl  -0x20(%ebp)
80107079:	e8 02 fe ff ff       	call   80106e80 <freevm>
  return 0;
8010707e:	83 c4 10             	add    $0x10,%esp
80107081:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
}
80107088:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010708b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010708e:	5b                   	pop    %ebx
8010708f:	5e                   	pop    %esi
80107090:	5f                   	pop    %edi
80107091:	5d                   	pop    %ebp
80107092:	c3                   	ret    
80107093:	90                   	nop
80107094:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      kfree(mem);
80107098:	83 ec 0c             	sub    $0xc,%esp
8010709b:	56                   	push   %esi
8010709c:	e8 9f b2 ff ff       	call   80102340 <kfree>
      goto bad;
801070a1:	83 c4 10             	add    $0x10,%esp
801070a4:	eb cd                	jmp    80107073 <copyuvm+0xa3>
      panic("copyuvm: page not present");
801070a6:	83 ec 0c             	sub    $0xc,%esp
801070a9:	68 5a 7b 10 80       	push   $0x80107b5a
801070ae:	e8 dd 92 ff ff       	call   80100390 <panic>
      panic("copyuvm: pte should exist");
801070b3:	83 ec 0c             	sub    $0xc,%esp
801070b6:	68 40 7b 10 80       	push   $0x80107b40
801070bb:	e8 d0 92 ff ff       	call   80100390 <panic>

801070c0 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
801070c0:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
801070c1:	31 c9                	xor    %ecx,%ecx
{
801070c3:	89 e5                	mov    %esp,%ebp
801070c5:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
801070c8:	8b 55 0c             	mov    0xc(%ebp),%edx
801070cb:	8b 45 08             	mov    0x8(%ebp),%eax
801070ce:	e8 9d f7 ff ff       	call   80106870 <walkpgdir>
  if((*pte & PTE_P) == 0)
801070d3:	8b 00                	mov    (%eax),%eax
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
801070d5:	c9                   	leave  
  if((*pte & PTE_U) == 0)
801070d6:	89 c2                	mov    %eax,%edx
  return (char*)P2V(PTE_ADDR(*pte));
801070d8:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((*pte & PTE_U) == 0)
801070dd:	83 e2 05             	and    $0x5,%edx
  return (char*)P2V(PTE_ADDR(*pte));
801070e0:	05 00 00 00 80       	add    $0x80000000,%eax
801070e5:	83 fa 05             	cmp    $0x5,%edx
801070e8:	ba 00 00 00 00       	mov    $0x0,%edx
801070ed:	0f 45 c2             	cmovne %edx,%eax
}
801070f0:	c3                   	ret    
801070f1:	eb 0d                	jmp    80107100 <copyout>
801070f3:	90                   	nop
801070f4:	90                   	nop
801070f5:	90                   	nop
801070f6:	90                   	nop
801070f7:	90                   	nop
801070f8:	90                   	nop
801070f9:	90                   	nop
801070fa:	90                   	nop
801070fb:	90                   	nop
801070fc:	90                   	nop
801070fd:	90                   	nop
801070fe:	90                   	nop
801070ff:	90                   	nop

80107100 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80107100:	55                   	push   %ebp
80107101:	89 e5                	mov    %esp,%ebp
80107103:	57                   	push   %edi
80107104:	56                   	push   %esi
80107105:	53                   	push   %ebx
80107106:	83 ec 1c             	sub    $0x1c,%esp
80107109:	8b 5d 14             	mov    0x14(%ebp),%ebx
8010710c:	8b 55 0c             	mov    0xc(%ebp),%edx
8010710f:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80107112:	85 db                	test   %ebx,%ebx
80107114:	75 40                	jne    80107156 <copyout+0x56>
80107116:	eb 70                	jmp    80107188 <copyout+0x88>
80107118:	90                   	nop
80107119:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
80107120:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80107123:	89 f1                	mov    %esi,%ecx
80107125:	29 d1                	sub    %edx,%ecx
80107127:	81 c1 00 10 00 00    	add    $0x1000,%ecx
8010712d:	39 d9                	cmp    %ebx,%ecx
8010712f:	0f 47 cb             	cmova  %ebx,%ecx
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80107132:	29 f2                	sub    %esi,%edx
80107134:	83 ec 04             	sub    $0x4,%esp
80107137:	01 d0                	add    %edx,%eax
80107139:	51                   	push   %ecx
8010713a:	57                   	push   %edi
8010713b:	50                   	push   %eax
8010713c:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
8010713f:	e8 dc d5 ff ff       	call   80104720 <memmove>
    len -= n;
    buf += n;
80107144:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
  while(len > 0){
80107147:	83 c4 10             	add    $0x10,%esp
    va = va0 + PGSIZE;
8010714a:	8d 96 00 10 00 00    	lea    0x1000(%esi),%edx
    buf += n;
80107150:	01 cf                	add    %ecx,%edi
  while(len > 0){
80107152:	29 cb                	sub    %ecx,%ebx
80107154:	74 32                	je     80107188 <copyout+0x88>
    va0 = (uint)PGROUNDDOWN(va);
80107156:	89 d6                	mov    %edx,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80107158:	83 ec 08             	sub    $0x8,%esp
    va0 = (uint)PGROUNDDOWN(va);
8010715b:	89 55 e4             	mov    %edx,-0x1c(%ebp)
8010715e:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80107164:	56                   	push   %esi
80107165:	ff 75 08             	pushl  0x8(%ebp)
80107168:	e8 53 ff ff ff       	call   801070c0 <uva2ka>
    if(pa0 == 0)
8010716d:	83 c4 10             	add    $0x10,%esp
80107170:	85 c0                	test   %eax,%eax
80107172:	75 ac                	jne    80107120 <copyout+0x20>
  }
  return 0;
}
80107174:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80107177:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010717c:	5b                   	pop    %ebx
8010717d:	5e                   	pop    %esi
8010717e:	5f                   	pop    %edi
8010717f:	5d                   	pop    %ebp
80107180:	c3                   	ret    
80107181:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107188:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010718b:	31 c0                	xor    %eax,%eax
}
8010718d:	5b                   	pop    %ebx
8010718e:	5e                   	pop    %esi
8010718f:	5f                   	pop    %edi
80107190:	5d                   	pop    %ebp
80107191:	c3                   	ret    
