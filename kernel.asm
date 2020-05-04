
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

8010000c <entry>:

# Entering xv6 on boot processor, with paging off.
.globl entry
entry:
  # Turn on page size extension for 4Mbyte pages
  movl    %cr4, %eax
8010000c:	0f 20 e0             	mov    %cr4,%eax
  orl     $(CR4_PSE), %eax
8010000f:	83 c8 10             	or     $0x10,%eax
  movl    %eax, %cr4
80100012:	0f 22 e0             	mov    %eax,%cr4
  # Set page directory
  movl    $(V2P_WO(entrypgdir)), %eax
80100015:	b8 00 90 10 00       	mov    $0x109000,%eax
  movl    %eax, %cr3
8010001a:	0f 22 d8             	mov    %eax,%cr3
  # Turn on paging.
  movl    %cr0, %eax
8010001d:	0f 20 c0             	mov    %cr0,%eax
  orl     $(CR0_PG|CR0_WP), %eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
  movl    %eax, %cr0
80100025:	0f 22 c0             	mov    %eax,%cr0

  # Set up the stack pointer.
  movl $(stack + KSTACKSIZE), %esp
80100028:	bc c0 b5 10 80       	mov    $0x8010b5c0,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 d0 2e 10 80       	mov    $0x80102ed0,%eax
  jmp *%eax
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
8010004c:	68 00 75 10 80       	push   $0x80107500
80100051:	68 c0 b5 10 80       	push   $0x8010b5c0
80100056:	e8 b5 46 00 00       	call   80104710 <initlock>
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
80100092:	68 07 75 10 80       	push   $0x80107507
80100097:	50                   	push   %eax
80100098:	e8 43 45 00 00       	call   801045e0 <initsleeplock>
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
801000e4:	e8 67 47 00 00       	call   80104850 <acquire>
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
80100162:	e8 a9 47 00 00       	call   80104910 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 ae 44 00 00       	call   80104620 <acquiresleep>
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
80100193:	68 0e 75 10 80       	push   $0x8010750e
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
801001ae:	e8 0d 45 00 00       	call   801046c0 <holdingsleep>
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
801001cc:	68 1f 75 10 80       	push   $0x8010751f
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
801001ef:	e8 cc 44 00 00       	call   801046c0 <holdingsleep>
801001f4:	83 c4 10             	add    $0x10,%esp
801001f7:	85 c0                	test   %eax,%eax
801001f9:	74 66                	je     80100261 <brelse+0x81>
    panic("brelse");

  releasesleep(&b->lock);
801001fb:	83 ec 0c             	sub    $0xc,%esp
801001fe:	56                   	push   %esi
801001ff:	e8 7c 44 00 00       	call   80104680 <releasesleep>

  acquire(&bcache.lock);
80100204:	c7 04 24 c0 b5 10 80 	movl   $0x8010b5c0,(%esp)
8010020b:	e8 40 46 00 00       	call   80104850 <acquire>
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
8010025c:	e9 af 46 00 00       	jmp    80104910 <release>
    panic("brelse");
80100261:	83 ec 0c             	sub    $0xc,%esp
80100264:	68 26 75 10 80       	push   $0x80107526
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
8010028c:	e8 bf 45 00 00       	call   80104850 <acquire>
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
801002c5:	e8 f6 3b 00 00       	call   80103ec0 <sleep>
    while(input.r == input.w){
801002ca:	8b 15 a0 ff 10 80    	mov    0x8010ffa0,%edx
801002d0:	83 c4 10             	add    $0x10,%esp
801002d3:	3b 15 a4 ff 10 80    	cmp    0x8010ffa4,%edx
801002d9:	75 35                	jne    80100310 <consoleread+0xa0>
      if(myproc()->killed){
801002db:	e8 70 34 00 00       	call   80103750 <myproc>
801002e0:	8b 40 24             	mov    0x24(%eax),%eax
801002e3:	85 c0                	test   %eax,%eax
801002e5:	74 d1                	je     801002b8 <consoleread+0x48>
        release(&cons.lock);
801002e7:	83 ec 0c             	sub    $0xc,%esp
801002ea:	68 20 a5 10 80       	push   $0x8010a520
801002ef:	e8 1c 46 00 00       	call   80104910 <release>
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
8010034d:	e8 be 45 00 00       	call   80104910 <release>
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
801003b2:	68 2d 75 10 80       	push   $0x8010752d
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
801003d8:	e8 53 43 00 00       	call   80104730 <getcallerpcs>
801003dd:	83 c4 10             	add    $0x10,%esp
    cprintf(" %p", pcs[i]);
801003e0:	83 ec 08             	sub    $0x8,%esp
801003e3:	ff 33                	pushl  (%ebx)
801003e5:	83 c3 04             	add    $0x4,%ebx
801003e8:	68 41 75 10 80       	push   $0x80107541
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
8010043a:	e8 c1 5c 00 00       	call   80106100 <uartputc>
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
801004ec:	e8 0f 5c 00 00       	call   80106100 <uartputc>
801004f1:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801004f8:	e8 03 5c 00 00       	call   80106100 <uartputc>
801004fd:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80100504:	e8 f7 5b 00 00       	call   80106100 <uartputc>
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
80100524:	e8 e7 44 00 00       	call   80104a10 <memmove>
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
80100541:	e8 1a 44 00 00       	call   80104960 <memset>
80100546:	83 c4 10             	add    $0x10,%esp
80100549:	e9 5d ff ff ff       	jmp    801004ab <consputc+0x9b>
    panic("pos under/overflow");
8010054e:	83 ec 0c             	sub    $0xc,%esp
80100551:	68 45 75 10 80       	push   $0x80107545
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
801005b1:	0f b6 92 70 75 10 80 	movzbl -0x7fef8a90(%edx),%edx
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
8010061b:	e8 30 42 00 00       	call   80104850 <acquire>
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
80100647:	e8 c4 42 00 00       	call   80104910 <release>
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
8010071f:	e8 ec 41 00 00       	call   80104910 <release>
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
801007d0:	ba 58 75 10 80       	mov    $0x80107558,%edx
      for(; *s; s++)
801007d5:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
801007d8:	b8 28 00 00 00       	mov    $0x28,%eax
801007dd:	89 d3                	mov    %edx,%ebx
801007df:	eb bf                	jmp    801007a0 <cprintf+0x140>
801007e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    acquire(&cons.lock);
801007e8:	83 ec 0c             	sub    $0xc,%esp
801007eb:	68 20 a5 10 80       	push   $0x8010a520
801007f0:	e8 5b 40 00 00       	call   80104850 <acquire>
801007f5:	83 c4 10             	add    $0x10,%esp
801007f8:	e9 7c fe ff ff       	jmp    80100679 <cprintf+0x19>
    panic("null fmt");
801007fd:	83 ec 0c             	sub    $0xc,%esp
80100800:	68 5f 75 10 80       	push   $0x8010755f
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
80100823:	e8 28 40 00 00       	call   80104850 <acquire>
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
80100888:	e8 83 40 00 00       	call   80104910 <release>
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
80100916:	e8 65 37 00 00       	call   80104080 <wakeup>
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
80100997:	e9 24 38 00 00       	jmp    801041c0 <procdump>
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
801009c6:	68 68 75 10 80       	push   $0x80107568
801009cb:	68 20 a5 10 80       	push   $0x8010a520
801009d0:	e8 3b 3d 00 00       	call   80104710 <initlock>

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
80100a1c:	e8 2f 2d 00 00       	call   80103750 <myproc>
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
80100a94:	e8 b7 67 00 00       	call   80107250 <setupkvm>
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
80100af6:	e8 75 65 00 00       	call   80107070 <allocuvm>
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
80100b28:	e8 83 64 00 00       	call   80106fb0 <loaduvm>
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
80100b72:	e8 59 66 00 00       	call   801071d0 <freevm>
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
80100baa:	e8 c1 64 00 00       	call   80107070 <allocuvm>
80100baf:	83 c4 10             	add    $0x10,%esp
80100bb2:	85 c0                	test   %eax,%eax
80100bb4:	89 c6                	mov    %eax,%esi
80100bb6:	75 3a                	jne    80100bf2 <exec+0x1e2>
    freevm(pgdir);
80100bb8:	83 ec 0c             	sub    $0xc,%esp
80100bbb:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100bc1:	e8 0a 66 00 00       	call   801071d0 <freevm>
80100bc6:	83 c4 10             	add    $0x10,%esp
  return -1;
80100bc9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100bce:	e9 a9 fe ff ff       	jmp    80100a7c <exec+0x6c>
    end_op();
80100bd3:	e8 68 20 00 00       	call   80102c40 <end_op>
    cprintf("exec: fail\n");
80100bd8:	83 ec 0c             	sub    $0xc,%esp
80100bdb:	68 81 75 10 80       	push   $0x80107581
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
80100c06:	e8 e5 66 00 00       	call   801072f0 <clearpteu>
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
80100c39:	e8 42 3f 00 00       	call   80104b80 <strlen>
80100c3e:	f7 d0                	not    %eax
80100c40:	01 c3                	add    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c42:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c45:	5a                   	pop    %edx
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100c46:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c49:	ff 34 b8             	pushl  (%eax,%edi,4)
80100c4c:	e8 2f 3f 00 00       	call   80104b80 <strlen>
80100c51:	83 c0 01             	add    $0x1,%eax
80100c54:	50                   	push   %eax
80100c55:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c58:	ff 34 b8             	pushl  (%eax,%edi,4)
80100c5b:	53                   	push   %ebx
80100c5c:	56                   	push   %esi
80100c5d:	e8 ee 67 00 00       	call   80107450 <copyout>
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
80100cc7:	e8 84 67 00 00       	call   80107450 <copyout>
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
80100d08:	e8 33 3e 00 00       	call   80104b40 <safestrcpy>
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
80100d63:	e8 b8 60 00 00       	call   80106e20 <switchuvm>
  freevm(oldpgdir);
80100d68:	89 3c 24             	mov    %edi,(%esp)
80100d6b:	e8 60 64 00 00       	call   801071d0 <freevm>
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
80100d96:	68 8d 75 10 80       	push   $0x8010758d
80100d9b:	68 c0 ff 10 80       	push   $0x8010ffc0
80100da0:	e8 6b 39 00 00       	call   80104710 <initlock>
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
80100dc1:	e8 8a 3a 00 00       	call   80104850 <acquire>
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
80100df1:	e8 1a 3b 00 00       	call   80104910 <release>
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
80100e0a:	e8 01 3b 00 00       	call   80104910 <release>
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
80100e2f:	e8 1c 3a 00 00       	call   80104850 <acquire>
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
80100e4c:	e8 bf 3a 00 00       	call   80104910 <release>
  return f;
}
80100e51:	89 d8                	mov    %ebx,%eax
80100e53:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100e56:	c9                   	leave  
80100e57:	c3                   	ret    
    panic("filedup");
80100e58:	83 ec 0c             	sub    $0xc,%esp
80100e5b:	68 94 75 10 80       	push   $0x80107594
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
80100e81:	e8 ca 39 00 00       	call   80104850 <acquire>
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
80100eac:	e9 5f 3a 00 00       	jmp    80104910 <release>
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
80100ed8:	e8 33 3a 00 00       	call   80104910 <release>
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
80100f32:	68 9c 75 10 80       	push   $0x8010759c
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
80101012:	68 a6 75 10 80       	push   $0x801075a6
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
80101125:	68 af 75 10 80       	push   $0x801075af
8010112a:	e8 61 f2 ff ff       	call   80100390 <panic>
  panic("filewrite");
8010112f:	83 ec 0c             	sub    $0xc,%esp
80101132:	68 b5 75 10 80       	push   $0x801075b5
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
801011a3:	68 bf 75 10 80       	push   $0x801075bf
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
80101254:	68 d2 75 10 80       	push   $0x801075d2
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
80101295:	e8 c6 36 00 00       	call   80104960 <memset>
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
801012da:	e8 71 35 00 00       	call   80104850 <acquire>
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
8010133f:	e8 cc 35 00 00       	call   80104910 <release>

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
8010136d:	e8 9e 35 00 00       	call   80104910 <release>
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
80101382:	68 e8 75 10 80       	push   $0x801075e8
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
80101457:	68 f8 75 10 80       	push   $0x801075f8
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
80101491:	e8 7a 35 00 00       	call   80104a10 <memmove>
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
801014bc:	68 0b 76 10 80       	push   $0x8010760b
801014c1:	68 e0 09 11 80       	push   $0x801109e0
801014c6:	e8 45 32 00 00       	call   80104710 <initlock>
801014cb:	83 c4 10             	add    $0x10,%esp
801014ce:	66 90                	xchg   %ax,%ax
    initsleeplock(&icache.inode[i].lock, "inode");
801014d0:	83 ec 08             	sub    $0x8,%esp
801014d3:	68 12 76 10 80       	push   $0x80107612
801014d8:	53                   	push   %ebx
801014d9:	81 c3 90 00 00 00    	add    $0x90,%ebx
801014df:	e8 fc 30 00 00       	call   801045e0 <initsleeplock>
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
80101529:	68 78 76 10 80       	push   $0x80107678
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
801015be:	e8 9d 33 00 00       	call   80104960 <memset>
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
801015f3:	68 18 76 10 80       	push   $0x80107618
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
80101661:	e8 aa 33 00 00       	call   80104a10 <memmove>
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
8010168f:	e8 bc 31 00 00       	call   80104850 <acquire>
  ip->ref++;
80101694:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101698:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
8010169f:	e8 6c 32 00 00       	call   80104910 <release>
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
801016d2:	e8 49 2f 00 00       	call   80104620 <acquiresleep>
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
80101748:	e8 c3 32 00 00       	call   80104a10 <memmove>
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
8010176d:	68 30 76 10 80       	push   $0x80107630
80101772:	e8 19 ec ff ff       	call   80100390 <panic>
    panic("ilock");
80101777:	83 ec 0c             	sub    $0xc,%esp
8010177a:	68 2a 76 10 80       	push   $0x8010762a
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
801017a3:	e8 18 2f 00 00       	call   801046c0 <holdingsleep>
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
801017bf:	e9 bc 2e 00 00       	jmp    80104680 <releasesleep>
    panic("iunlock");
801017c4:	83 ec 0c             	sub    $0xc,%esp
801017c7:	68 3f 76 10 80       	push   $0x8010763f
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
801017f0:	e8 2b 2e 00 00       	call   80104620 <acquiresleep>
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
8010180a:	e8 71 2e 00 00       	call   80104680 <releasesleep>
  acquire(&icache.lock);
8010180f:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
80101816:	e8 35 30 00 00       	call   80104850 <acquire>
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
80101830:	e9 db 30 00 00       	jmp    80104910 <release>
80101835:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&icache.lock);
80101838:	83 ec 0c             	sub    $0xc,%esp
8010183b:	68 e0 09 11 80       	push   $0x801109e0
80101840:	e8 0b 30 00 00       	call   80104850 <acquire>
    int r = ip->ref;
80101845:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
80101848:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
8010184f:	e8 bc 30 00 00       	call   80104910 <release>
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
80101a37:	e8 d4 2f 00 00       	call   80104a10 <memmove>
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
80101b33:	e8 d8 2e 00 00       	call   80104a10 <memmove>
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
80101bce:	e8 ad 2e 00 00       	call   80104a80 <strncmp>
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
80101c2d:	e8 4e 2e 00 00       	call   80104a80 <strncmp>
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
80101c72:	68 59 76 10 80       	push   $0x80107659
80101c77:	e8 14 e7 ff ff       	call   80100390 <panic>
    panic("dirlookup not DIR");
80101c7c:	83 ec 0c             	sub    $0xc,%esp
80101c7f:	68 47 76 10 80       	push   $0x80107647
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
80101ca9:	e8 a2 1a 00 00       	call   80103750 <myproc>
  acquire(&icache.lock);
80101cae:	83 ec 0c             	sub    $0xc,%esp
    ip = idup(myproc()->cwd);
80101cb1:	8b 70 68             	mov    0x68(%eax),%esi
  acquire(&icache.lock);
80101cb4:	68 e0 09 11 80       	push   $0x801109e0
80101cb9:	e8 92 2b 00 00       	call   80104850 <acquire>
  ip->ref++;
80101cbe:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80101cc2:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
80101cc9:	e8 42 2c 00 00       	call   80104910 <release>
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
80101d25:	e8 e6 2c 00 00       	call   80104a10 <memmove>
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
80101db8:	e8 53 2c 00 00       	call   80104a10 <memmove>
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
80101ead:	e8 2e 2c 00 00       	call   80104ae0 <strncpy>
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
80101eeb:	68 68 76 10 80       	push   $0x80107668
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
8010200b:	68 d4 76 10 80       	push   $0x801076d4
80102010:	e8 7b e3 ff ff       	call   80100390 <panic>
    panic("idestart");
80102015:	83 ec 0c             	sub    $0xc,%esp
80102018:	68 cb 76 10 80       	push   $0x801076cb
8010201d:	e8 6e e3 ff ff       	call   80100390 <panic>
80102022:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102029:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102030 <ideinit>:
{
80102030:	55                   	push   %ebp
80102031:	89 e5                	mov    %esp,%ebp
80102033:	83 ec 10             	sub    $0x10,%esp
  initlock(&idelock, "ide");
80102036:	68 e6 76 10 80       	push   $0x801076e6
8010203b:	68 80 a5 10 80       	push   $0x8010a580
80102040:	e8 cb 26 00 00       	call   80104710 <initlock>
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
801020be:	e8 8d 27 00 00       	call   80104850 <acquire>

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
80102121:	e8 5a 1f 00 00       	call   80104080 <wakeup>

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
8010213f:	e8 cc 27 00 00       	call   80104910 <release>

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
8010215e:	e8 5d 25 00 00       	call   801046c0 <holdingsleep>
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
80102198:	e8 b3 26 00 00       	call   80104850 <acquire>

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
801021e9:	e8 d2 1c 00 00       	call   80103ec0 <sleep>
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
80102206:	e9 05 27 00 00       	jmp    80104910 <release>
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
8010222a:	68 00 77 10 80       	push   $0x80107700
8010222f:	e8 5c e1 ff ff       	call   80100390 <panic>
    panic("iderw: buf not locked");
80102234:	83 ec 0c             	sub    $0xc,%esp
80102237:	68 ea 76 10 80       	push   $0x801076ea
8010223c:	e8 4f e1 ff ff       	call   80100390 <panic>
    panic("iderw: ide disk 1 not present");
80102241:	83 ec 0c             	sub    $0xc,%esp
80102244:	68 15 77 10 80       	push   $0x80107715
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
80102297:	68 34 77 10 80       	push   $0x80107734
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
80102352:	81 fb a8 99 11 80    	cmp    $0x801199a8,%ebx
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
80102372:	e8 e9 25 00 00       	call   80104960 <memset>

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
801023ab:	e9 60 25 00 00       	jmp    80104910 <release>
    acquire(&kmem.lock);
801023b0:	83 ec 0c             	sub    $0xc,%esp
801023b3:	68 40 26 11 80       	push   $0x80112640
801023b8:	e8 93 24 00 00       	call   80104850 <acquire>
801023bd:	83 c4 10             	add    $0x10,%esp
801023c0:	eb c2                	jmp    80102384 <kfree+0x44>
    panic("kfree");
801023c2:	83 ec 0c             	sub    $0xc,%esp
801023c5:	68 66 77 10 80       	push   $0x80107766
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
8010242b:	68 6c 77 10 80       	push   $0x8010776c
80102430:	68 40 26 11 80       	push   $0x80112640
80102435:	e8 d6 22 00 00       	call   80104710 <initlock>
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
80102523:	e8 28 23 00 00       	call   80104850 <acquire>
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
80102551:	e8 ba 23 00 00       	call   80104910 <release>
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
801025a3:	0f b6 82 a0 78 10 80 	movzbl -0x7fef8760(%edx),%eax
801025aa:	09 c1                	or     %eax,%ecx
  shift ^= togglecode[data];
801025ac:	0f b6 82 a0 77 10 80 	movzbl -0x7fef8860(%edx),%eax
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
801025c3:	8b 04 85 80 77 10 80 	mov    -0x7fef8880(,%eax,4),%eax
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
801025e8:	0f b6 82 a0 78 10 80 	movzbl -0x7fef8760(%edx),%eax
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
80102967:	e8 44 20 00 00       	call   801049b0 <memcmp>
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
80102a94:	e8 77 1f 00 00       	call   80104a10 <memmove>
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
80102b3a:	68 a0 79 10 80       	push   $0x801079a0
80102b3f:	68 80 26 11 80       	push   $0x80112680
80102b44:	e8 c7 1b 00 00       	call   80104710 <initlock>
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
80102bdb:	e8 70 1c 00 00       	call   80104850 <acquire>
80102be0:	83 c4 10             	add    $0x10,%esp
80102be3:	eb 18                	jmp    80102bfd <begin_op+0x2d>
80102be5:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102be8:	83 ec 08             	sub    $0x8,%esp
80102beb:	68 80 26 11 80       	push   $0x80112680
80102bf0:	68 80 26 11 80       	push   $0x80112680
80102bf5:	e8 c6 12 00 00       	call   80103ec0 <sleep>
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
80102c2c:	e8 df 1c 00 00       	call   80104910 <release>
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
80102c4e:	e8 fd 1b 00 00       	call   80104850 <acquire>
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
80102c8c:	e8 7f 1c 00 00       	call   80104910 <release>
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
80102ce6:	e8 25 1d 00 00       	call   80104a10 <memmove>
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
80102d2f:	e8 1c 1b 00 00       	call   80104850 <acquire>
    wakeup(&log);
80102d34:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
    log.committing = 0;
80102d3b:	c7 05 c0 26 11 80 00 	movl   $0x0,0x801126c0
80102d42:	00 00 00 
    wakeup(&log);
80102d45:	e8 36 13 00 00       	call   80104080 <wakeup>
    release(&log.lock);
80102d4a:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
80102d51:	e8 ba 1b 00 00       	call   80104910 <release>
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
80102d70:	e8 0b 13 00 00       	call   80104080 <wakeup>
  release(&log.lock);
80102d75:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
80102d7c:	e8 8f 1b 00 00       	call   80104910 <release>
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
80102d8f:	68 a4 79 10 80       	push   $0x801079a4
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
80102dde:	e8 6d 1a 00 00       	call   80104850 <acquire>
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
80102e2d:	e9 de 1a 00 00       	jmp    80104910 <release>
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
80102e59:	68 b3 79 10 80       	push   $0x801079b3
80102e5e:	e8 2d d5 ff ff       	call   80100390 <panic>
    panic("log_write outside of trans");
80102e63:	83 ec 0c             	sub    $0xc,%esp
80102e66:	68 c9 79 10 80       	push   $0x801079c9
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
80102e77:	e8 b4 08 00 00       	call   80103730 <cpuid>
80102e7c:	89 c3                	mov    %eax,%ebx
80102e7e:	e8 ad 08 00 00       	call   80103730 <cpuid>
80102e83:	83 ec 04             	sub    $0x4,%esp
80102e86:	53                   	push   %ebx
80102e87:	50                   	push   %eax
80102e88:	68 e4 79 10 80       	push   $0x801079e4
80102e8d:	e8 ce d7 ff ff       	call   80100660 <cprintf>
  idtinit();       // load idt register
80102e92:	e8 29 2e 00 00       	call   80105cc0 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
80102e97:	e8 14 08 00 00       	call   801036b0 <mycpu>
80102e9c:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80102e9e:	b8 01 00 00 00       	mov    $0x1,%eax
80102ea3:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
80102eaa:	e8 31 0d 00 00       	call   80103be0 <scheduler>
80102eaf:	90                   	nop

80102eb0 <mpenter>:
{
80102eb0:	55                   	push   %ebp
80102eb1:	89 e5                	mov    %esp,%ebp
80102eb3:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80102eb6:	e8 45 3f 00 00       	call   80106e00 <switchkvm>
  seginit();
80102ebb:	e8 b0 3e 00 00       	call   80106d70 <seginit>
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
80102ee7:	68 a8 99 11 80       	push   $0x801199a8
80102eec:	e8 2f f5 ff ff       	call   80102420 <kinit1>
  kvmalloc();      // kernel page table
80102ef1:	e8 da 43 00 00       	call   801072d0 <kvmalloc>
  mpinit();        // detect other processors
80102ef6:	e8 75 01 00 00       	call   80103070 <mpinit>
  lapicinit();     // interrupt controller
80102efb:	e8 60 f7 ff ff       	call   80102660 <lapicinit>
  seginit();       // segment descriptors
80102f00:	e8 6b 3e 00 00       	call   80106d70 <seginit>
  picinit();       // disable pic
80102f05:	e8 46 03 00 00       	call   80103250 <picinit>
  ioapicinit();    // another interrupt controller
80102f0a:	e8 41 f3 ff ff       	call   80102250 <ioapicinit>
  consoleinit();   // console hardware
80102f0f:	e8 ac da ff ff       	call   801009c0 <consoleinit>
  uartinit();      // serial port
80102f14:	e8 27 31 00 00       	call   80106040 <uartinit>
  pinit();         // process table
80102f19:	e8 72 07 00 00       	call   80103690 <pinit>
  tvinit();        // trap vectors
80102f1e:	e8 1d 2d 00 00       	call   80105c40 <tvinit>
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
80102f44:	e8 c7 1a 00 00       	call   80104a10 <memmove>

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
80102f70:	e8 3b 07 00 00       	call   801036b0 <mycpu>
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
80102fe5:	e8 b6 08 00 00       	call   801038a0 <userinit>
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
8010301e:	68 f8 79 10 80       	push   $0x801079f8
80103023:	56                   	push   %esi
80103024:	e8 87 19 00 00       	call   801049b0 <memcmp>
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
801030dc:	68 15 7a 10 80       	push   $0x80107a15
801030e1:	56                   	push   %esi
801030e2:	e8 c9 18 00 00       	call   801049b0 <memcmp>
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
80103170:	ff 24 95 3c 7a 10 80 	jmp    *-0x7fef85c4(,%edx,4)
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
80103223:	68 fd 79 10 80       	push   $0x801079fd
80103228:	e8 63 d1 ff ff       	call   80100390 <panic>
    panic("Didn't find a suitable machine");
8010322d:	83 ec 0c             	sub    $0xc,%esp
80103230:	68 1c 7a 10 80       	push   $0x80107a1c
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
8010332b:	68 50 7a 10 80       	push   $0x80107a50
80103330:	50                   	push   %eax
80103331:	e8 da 13 00 00       	call   80104710 <initlock>
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
8010338f:	e8 bc 14 00 00       	call   80104850 <acquire>
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
801033af:	e8 cc 0c 00 00       	call   80104080 <wakeup>
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
801033d4:	e9 37 15 00 00       	jmp    80104910 <release>
801033d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    wakeup(&p->nwrite);
801033e0:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
801033e6:	83 ec 0c             	sub    $0xc,%esp
    p->readopen = 0;
801033e9:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
801033f0:	00 00 00 
    wakeup(&p->nwrite);
801033f3:	50                   	push   %eax
801033f4:	e8 87 0c 00 00       	call   80104080 <wakeup>
801033f9:	83 c4 10             	add    $0x10,%esp
801033fc:	eb b9                	jmp    801033b7 <pipeclose+0x37>
801033fe:	66 90                	xchg   %ax,%ax
    release(&p->lock);
80103400:	83 ec 0c             	sub    $0xc,%esp
80103403:	53                   	push   %ebx
80103404:	e8 07 15 00 00       	call   80104910 <release>
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
8010342d:	e8 1e 14 00 00       	call   80104850 <acquire>
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
80103484:	e8 f7 0b 00 00       	call   80104080 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103489:	5a                   	pop    %edx
8010348a:	59                   	pop    %ecx
8010348b:	53                   	push   %ebx
8010348c:	56                   	push   %esi
8010348d:	e8 2e 0a 00 00       	call   80103ec0 <sleep>
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
801034b4:	e8 97 02 00 00       	call   80103750 <myproc>
801034b9:	8b 40 24             	mov    0x24(%eax),%eax
801034bc:	85 c0                	test   %eax,%eax
801034be:	74 c0                	je     80103480 <pipewrite+0x60>
        release(&p->lock);
801034c0:	83 ec 0c             	sub    $0xc,%esp
801034c3:	53                   	push   %ebx
801034c4:	e8 47 14 00 00       	call   80104910 <release>
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
80103513:	e8 68 0b 00 00       	call   80104080 <wakeup>
  release(&p->lock);
80103518:	89 1c 24             	mov    %ebx,(%esp)
8010351b:	e8 f0 13 00 00       	call   80104910 <release>
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
80103540:	e8 0b 13 00 00       	call   80104850 <acquire>
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
80103575:	e8 46 09 00 00       	call   80103ec0 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
8010357a:	83 c4 10             	add    $0x10,%esp
8010357d:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
80103583:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
80103589:	75 35                	jne    801035c0 <piperead+0x90>
8010358b:	8b 96 40 02 00 00    	mov    0x240(%esi),%edx
80103591:	85 d2                	test   %edx,%edx
80103593:	0f 84 8f 00 00 00    	je     80103628 <piperead+0xf8>
    if(myproc()->killed){
80103599:	e8 b2 01 00 00       	call   80103750 <myproc>
8010359e:	8b 48 24             	mov    0x24(%eax),%ecx
801035a1:	85 c9                	test   %ecx,%ecx
801035a3:	74 cb                	je     80103570 <piperead+0x40>
      release(&p->lock);
801035a5:	83 ec 0c             	sub    $0xc,%esp
      return -1;
801035a8:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      release(&p->lock);
801035ad:	56                   	push   %esi
801035ae:	e8 5d 13 00 00       	call   80104910 <release>
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
80103607:	e8 74 0a 00 00       	call   80104080 <wakeup>
  release(&p->lock);
8010360c:	89 34 24             	mov    %esi,(%esp)
8010360f:	e8 fc 12 00 00       	call   80104910 <release>
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

80103630 <call_sigret>:
  struct proc *p = myproc();
  if (p-> suspended == 1)
    p->suspended = 0; 
}

void call_sigret(void){
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

80103640 <forkret>:
{
80103640:	55                   	push   %ebp
80103641:	89 e5                	mov    %esp,%ebp
80103643:	83 ec 14             	sub    $0x14,%esp
  release(&ptable.lock);
80103646:	68 20 2d 11 80       	push   $0x80112d20
8010364b:	e8 c0 12 00 00       	call   80104910 <release>
  if (first) {
80103650:	a1 00 a0 10 80       	mov    0x8010a000,%eax
80103655:	83 c4 10             	add    $0x10,%esp
80103658:	85 c0                	test   %eax,%eax
8010365a:	75 04                	jne    80103660 <forkret+0x20>
}
8010365c:	c9                   	leave  
8010365d:	c3                   	ret    
8010365e:	66 90                	xchg   %ax,%ax
    iinit(ROOTDEV);
80103660:	83 ec 0c             	sub    $0xc,%esp
    first = 0;
80103663:	c7 05 00 a0 10 80 00 	movl   $0x0,0x8010a000
8010366a:	00 00 00 
    iinit(ROOTDEV);
8010366d:	6a 01                	push   $0x1
8010366f:	e8 3c de ff ff       	call   801014b0 <iinit>
    initlog(ROOTDEV);
80103674:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010367b:	e8 b0 f4 ff ff       	call   80102b30 <initlog>
80103680:	83 c4 10             	add    $0x10,%esp
}
80103683:	c9                   	leave  
80103684:	c3                   	ret    
80103685:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103689:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103690 <pinit>:
{
80103690:	55                   	push   %ebp
80103691:	89 e5                	mov    %esp,%ebp
80103693:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
80103696:	68 55 7a 10 80       	push   $0x80107a55
8010369b:	68 20 2d 11 80       	push   $0x80112d20
801036a0:	e8 6b 10 00 00       	call   80104710 <initlock>
}
801036a5:	83 c4 10             	add    $0x10,%esp
801036a8:	c9                   	leave  
801036a9:	c3                   	ret    
801036aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801036b0 <mycpu>:
{
801036b0:	55                   	push   %ebp
801036b1:	89 e5                	mov    %esp,%ebp
801036b3:	56                   	push   %esi
801036b4:	53                   	push   %ebx
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801036b5:	9c                   	pushf  
801036b6:	58                   	pop    %eax
  if(readeflags()&FL_IF)
801036b7:	f6 c4 02             	test   $0x2,%ah
801036ba:	75 5e                	jne    8010371a <mycpu+0x6a>
  apicid = lapicid();
801036bc:	e8 9f f0 ff ff       	call   80102760 <lapicid>
  for (i = 0; i < ncpu; ++i) {
801036c1:	8b 35 00 2d 11 80    	mov    0x80112d00,%esi
801036c7:	85 f6                	test   %esi,%esi
801036c9:	7e 42                	jle    8010370d <mycpu+0x5d>
    if (cpus[i].apicid == apicid)
801036cb:	0f b6 15 80 27 11 80 	movzbl 0x80112780,%edx
801036d2:	39 d0                	cmp    %edx,%eax
801036d4:	74 30                	je     80103706 <mycpu+0x56>
801036d6:	b9 30 28 11 80       	mov    $0x80112830,%ecx
  for (i = 0; i < ncpu; ++i) {
801036db:	31 d2                	xor    %edx,%edx
801036dd:	8d 76 00             	lea    0x0(%esi),%esi
801036e0:	83 c2 01             	add    $0x1,%edx
801036e3:	39 f2                	cmp    %esi,%edx
801036e5:	74 26                	je     8010370d <mycpu+0x5d>
    if (cpus[i].apicid == apicid)
801036e7:	0f b6 19             	movzbl (%ecx),%ebx
801036ea:	81 c1 b0 00 00 00    	add    $0xb0,%ecx
801036f0:	39 c3                	cmp    %eax,%ebx
801036f2:	75 ec                	jne    801036e0 <mycpu+0x30>
801036f4:	69 c2 b0 00 00 00    	imul   $0xb0,%edx,%eax
801036fa:	05 80 27 11 80       	add    $0x80112780,%eax
}
801036ff:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103702:	5b                   	pop    %ebx
80103703:	5e                   	pop    %esi
80103704:	5d                   	pop    %ebp
80103705:	c3                   	ret    
    if (cpus[i].apicid == apicid)
80103706:	b8 80 27 11 80       	mov    $0x80112780,%eax
      return &cpus[i];
8010370b:	eb f2                	jmp    801036ff <mycpu+0x4f>
  panic("unknown apicid\n");
8010370d:	83 ec 0c             	sub    $0xc,%esp
80103710:	68 5c 7a 10 80       	push   $0x80107a5c
80103715:	e8 76 cc ff ff       	call   80100390 <panic>
    panic("mycpu called with interrupts enabled\n");
8010371a:	83 ec 0c             	sub    $0xc,%esp
8010371d:	68 70 7b 10 80       	push   $0x80107b70
80103722:	e8 69 cc ff ff       	call   80100390 <panic>
80103727:	89 f6                	mov    %esi,%esi
80103729:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103730 <cpuid>:
cpuid() {
80103730:	55                   	push   %ebp
80103731:	89 e5                	mov    %esp,%ebp
80103733:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
80103736:	e8 75 ff ff ff       	call   801036b0 <mycpu>
8010373b:	2d 80 27 11 80       	sub    $0x80112780,%eax
}
80103740:	c9                   	leave  
  return mycpu()-cpus;
80103741:	c1 f8 04             	sar    $0x4,%eax
80103744:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
8010374a:	c3                   	ret    
8010374b:	90                   	nop
8010374c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103750 <myproc>:
myproc(void) {
80103750:	55                   	push   %ebp
80103751:	89 e5                	mov    %esp,%ebp
80103753:	53                   	push   %ebx
80103754:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80103757:	e8 24 10 00 00       	call   80104780 <pushcli>
  c = mycpu();
8010375c:	e8 4f ff ff ff       	call   801036b0 <mycpu>
  p = c->proc;
80103761:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103767:	e8 54 10 00 00       	call   801047c0 <popcli>
}
8010376c:	83 c4 04             	add    $0x4,%esp
8010376f:	89 d8                	mov    %ebx,%eax
80103771:	5b                   	pop    %ebx
80103772:	5d                   	pop    %ebp
80103773:	c3                   	ret    
80103774:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010377a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103780 <allocpid>:
{
80103780:	55                   	push   %ebp
80103781:	89 e5                	mov    %esp,%ebp
80103783:	53                   	push   %ebx
80103784:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);
80103787:	68 20 2d 11 80       	push   $0x80112d20
8010378c:	e8 bf 10 00 00       	call   80104850 <acquire>
  pid = nextpid++;
80103791:	8b 1d 04 a0 10 80    	mov    0x8010a004,%ebx
  release(&ptable.lock);
80103797:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
  pid = nextpid++;
8010379e:	8d 43 01             	lea    0x1(%ebx),%eax
801037a1:	a3 04 a0 10 80       	mov    %eax,0x8010a004
  release(&ptable.lock);
801037a6:	e8 65 11 00 00       	call   80104910 <release>
}
801037ab:	89 d8                	mov    %ebx,%eax
801037ad:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801037b0:	c9                   	leave  
801037b1:	c3                   	ret    
801037b2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801037b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801037c0 <allocproc>:
{
801037c0:	55                   	push   %ebp
801037c1:	89 e5                	mov    %esp,%ebp
801037c3:	53                   	push   %ebx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801037c4:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
{
801037c9:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);
801037cc:	68 20 2d 11 80       	push   $0x80112d20
801037d1:	e8 7a 10 00 00       	call   80104850 <acquire>
801037d6:	83 c4 10             	add    $0x10,%esp
801037d9:	eb 17                	jmp    801037f2 <allocproc+0x32>
801037db:	90                   	nop
801037dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801037e0:	81 c3 90 01 00 00    	add    $0x190,%ebx
801037e6:	81 fb 54 91 11 80    	cmp    $0x80119154,%ebx
801037ec:	0f 83 7e 00 00 00    	jae    80103870 <allocproc+0xb0>
    if(p->state == UNUSED)
801037f2:	8b 43 0c             	mov    0xc(%ebx),%eax
801037f5:	85 c0                	test   %eax,%eax
801037f7:	75 e7                	jne    801037e0 <allocproc+0x20>
  release(&ptable.lock);
801037f9:	83 ec 0c             	sub    $0xc,%esp
  p->state = EMBRYO;
801037fc:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  release(&ptable.lock);
80103803:	68 20 2d 11 80       	push   $0x80112d20
80103808:	e8 03 11 00 00       	call   80104910 <release>
  p->pid = allocpid();
8010380d:	e8 6e ff ff ff       	call   80103780 <allocpid>
80103812:	89 43 10             	mov    %eax,0x10(%ebx)
  if((p->kstack = kalloc()) == 0){
80103815:	e8 d6 ec ff ff       	call   801024f0 <kalloc>
8010381a:	83 c4 10             	add    $0x10,%esp
8010381d:	85 c0                	test   %eax,%eax
8010381f:	89 43 08             	mov    %eax,0x8(%ebx)
80103822:	74 65                	je     80103889 <allocproc+0xc9>
  sp -= sizeof *p->tf;
80103824:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  memset(p->context, 0, sizeof *p->context);
8010382a:	83 ec 04             	sub    $0x4,%esp
  sp -= sizeof *p->context;
8010382d:	05 9c 0f 00 00       	add    $0xf9c,%eax
  sp -= sizeof *p->tf;
80103832:	89 53 18             	mov    %edx,0x18(%ebx)
  *(uint*)sp = (uint)trapret;
80103835:	c7 40 14 1f 5c 10 80 	movl   $0x80105c1f,0x14(%eax)
  p->context = (struct context*)sp;
8010383c:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
8010383f:	6a 14                	push   $0x14
80103841:	6a 00                	push   $0x0
80103843:	50                   	push   %eax
80103844:	e8 17 11 00 00       	call   80104960 <memset>
  p->context->eip = (uint)forkret;
80103849:	8b 43 1c             	mov    0x1c(%ebx),%eax
8010384c:	c7 40 10 40 36 10 80 	movl   $0x80103640,0x10(%eax)
  p->backup = (struct trapframe*)kalloc();
80103853:	e8 98 ec ff ff       	call   801024f0 <kalloc>
  p->already_in_signal = 0;
80103858:	c7 83 80 00 00 00 00 	movl   $0x0,0x80(%ebx)
8010385f:	00 00 00 
  p->backup = (struct trapframe*)kalloc();
80103862:	89 43 7c             	mov    %eax,0x7c(%ebx)
  return p;
80103865:	83 c4 10             	add    $0x10,%esp
}
80103868:	89 d8                	mov    %ebx,%eax
8010386a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010386d:	c9                   	leave  
8010386e:	c3                   	ret    
8010386f:	90                   	nop
  release(&ptable.lock);
80103870:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80103873:	31 db                	xor    %ebx,%ebx
  release(&ptable.lock);
80103875:	68 20 2d 11 80       	push   $0x80112d20
8010387a:	e8 91 10 00 00       	call   80104910 <release>
}
8010387f:	89 d8                	mov    %ebx,%eax
  return 0;
80103881:	83 c4 10             	add    $0x10,%esp
}
80103884:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103887:	c9                   	leave  
80103888:	c3                   	ret    
    p->state = UNUSED;
80103889:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
80103890:	31 db                	xor    %ebx,%ebx
80103892:	eb d4                	jmp    80103868 <allocproc+0xa8>
80103894:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010389a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801038a0 <userinit>:
{
801038a0:	55                   	push   %ebp
801038a1:	89 e5                	mov    %esp,%ebp
801038a3:	53                   	push   %ebx
801038a4:	83 ec 04             	sub    $0x4,%esp
  p = allocproc();
801038a7:	e8 14 ff ff ff       	call   801037c0 <allocproc>
801038ac:	89 c3                	mov    %eax,%ebx
  initproc = p;
801038ae:	a3 b8 a5 10 80       	mov    %eax,0x8010a5b8
  if((p->pgdir = setupkvm()) == 0)
801038b3:	e8 98 39 00 00       	call   80107250 <setupkvm>
801038b8:	85 c0                	test   %eax,%eax
801038ba:	89 43 04             	mov    %eax,0x4(%ebx)
801038bd:	0f 84 02 01 00 00    	je     801039c5 <userinit+0x125>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
801038c3:	83 ec 04             	sub    $0x4,%esp
801038c6:	68 2c 00 00 00       	push   $0x2c
801038cb:	68 60 a4 10 80       	push   $0x8010a460
801038d0:	50                   	push   %eax
801038d1:	e8 5a 36 00 00       	call   80106f30 <inituvm>
  memset(p->tf, 0, sizeof(*p->tf));
801038d6:	83 c4 0c             	add    $0xc,%esp
  p->sz = PGSIZE;
801038d9:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
801038df:	6a 4c                	push   $0x4c
801038e1:	6a 00                	push   $0x0
801038e3:	ff 73 18             	pushl  0x18(%ebx)
801038e6:	e8 75 10 00 00       	call   80104960 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
801038eb:	8b 43 18             	mov    0x18(%ebx),%eax
801038ee:	ba 1b 00 00 00       	mov    $0x1b,%edx
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
801038f3:	b9 23 00 00 00       	mov    $0x23,%ecx
  safestrcpy(p->name, "initcode", sizeof(p->name));
801038f8:	83 c4 0c             	add    $0xc,%esp
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
801038fb:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
801038ff:	8b 43 18             	mov    0x18(%ebx),%eax
80103902:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
80103906:	8b 43 18             	mov    0x18(%ebx),%eax
80103909:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
8010390d:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80103911:	8b 43 18             	mov    0x18(%ebx),%eax
80103914:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103918:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
8010391c:	8b 43 18             	mov    0x18(%ebx),%eax
8010391f:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80103926:	8b 43 18             	mov    0x18(%ebx),%eax
80103929:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80103930:	8b 43 18             	mov    0x18(%ebx),%eax
80103933:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
8010393a:	8d 43 6c             	lea    0x6c(%ebx),%eax
8010393d:	6a 10                	push   $0x10
8010393f:	68 85 7a 10 80       	push   $0x80107a85
80103944:	50                   	push   %eax
80103945:	e8 f6 11 00 00       	call   80104b40 <safestrcpy>
  p->cwd = namei("/");
8010394a:	c7 04 24 8e 7a 10 80 	movl   $0x80107a8e,(%esp)
80103951:	e8 ba e5 ff ff       	call   80101f10 <namei>
80103956:	8d 93 8c 01 00 00    	lea    0x18c(%ebx),%edx
8010395c:	89 43 68             	mov    %eax,0x68(%ebx)
8010395f:	8d 83 8c 00 00 00    	lea    0x8c(%ebx),%eax
  p->signal_mask = 0;
80103965:	c7 83 88 00 00 00 00 	movl   $0x0,0x88(%ebx)
8010396c:	00 00 00 
  p->pending_signals =0;
8010396f:	c7 83 84 00 00 00 00 	movl   $0x0,0x84(%ebx)
80103976:	00 00 00 
80103979:	83 c4 10             	add    $0x10,%esp
  p->suspended =0;
8010397c:	c7 83 8c 01 00 00 00 	movl   $0x0,0x18c(%ebx)
80103983:	00 00 00 
80103986:	8d 76 00             	lea    0x0(%esi),%esi
80103989:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p->signal_handlers[i].sa_handler = SIG_DFL;
80103990:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80103996:	83 c0 08             	add    $0x8,%eax
  for(int i=0; i<32; i++){
80103999:	39 d0                	cmp    %edx,%eax
8010399b:	75 f3                	jne    80103990 <userinit+0xf0>
  acquire(&ptable.lock);
8010399d:	83 ec 0c             	sub    $0xc,%esp
801039a0:	68 20 2d 11 80       	push   $0x80112d20
801039a5:	e8 a6 0e 00 00       	call   80104850 <acquire>
  p->state = RUNNABLE;
801039aa:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
801039b1:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
801039b8:	e8 53 0f 00 00       	call   80104910 <release>
}
801039bd:	83 c4 10             	add    $0x10,%esp
801039c0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801039c3:	c9                   	leave  
801039c4:	c3                   	ret    
    panic("userinit: out of memory?");
801039c5:	83 ec 0c             	sub    $0xc,%esp
801039c8:	68 6c 7a 10 80       	push   $0x80107a6c
801039cd:	e8 be c9 ff ff       	call   80100390 <panic>
801039d2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801039d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801039e0 <growproc>:
{
801039e0:	55                   	push   %ebp
801039e1:	89 e5                	mov    %esp,%ebp
801039e3:	56                   	push   %esi
801039e4:	53                   	push   %ebx
801039e5:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
801039e8:	e8 93 0d 00 00       	call   80104780 <pushcli>
  c = mycpu();
801039ed:	e8 be fc ff ff       	call   801036b0 <mycpu>
  p = c->proc;
801039f2:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801039f8:	e8 c3 0d 00 00       	call   801047c0 <popcli>
  if(n > 0){
801039fd:	83 fe 00             	cmp    $0x0,%esi
  sz = curproc->sz;
80103a00:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
80103a02:	7f 1c                	jg     80103a20 <growproc+0x40>
  } else if(n < 0){
80103a04:	75 3a                	jne    80103a40 <growproc+0x60>
  switchuvm(curproc);
80103a06:	83 ec 0c             	sub    $0xc,%esp
  curproc->sz = sz;
80103a09:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
80103a0b:	53                   	push   %ebx
80103a0c:	e8 0f 34 00 00       	call   80106e20 <switchuvm>
  return 0;
80103a11:	83 c4 10             	add    $0x10,%esp
80103a14:	31 c0                	xor    %eax,%eax
}
80103a16:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103a19:	5b                   	pop    %ebx
80103a1a:	5e                   	pop    %esi
80103a1b:	5d                   	pop    %ebp
80103a1c:	c3                   	ret    
80103a1d:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103a20:	83 ec 04             	sub    $0x4,%esp
80103a23:	01 c6                	add    %eax,%esi
80103a25:	56                   	push   %esi
80103a26:	50                   	push   %eax
80103a27:	ff 73 04             	pushl  0x4(%ebx)
80103a2a:	e8 41 36 00 00       	call   80107070 <allocuvm>
80103a2f:	83 c4 10             	add    $0x10,%esp
80103a32:	85 c0                	test   %eax,%eax
80103a34:	75 d0                	jne    80103a06 <growproc+0x26>
      return -1;
80103a36:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103a3b:	eb d9                	jmp    80103a16 <growproc+0x36>
80103a3d:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103a40:	83 ec 04             	sub    $0x4,%esp
80103a43:	01 c6                	add    %eax,%esi
80103a45:	56                   	push   %esi
80103a46:	50                   	push   %eax
80103a47:	ff 73 04             	pushl  0x4(%ebx)
80103a4a:	e8 51 37 00 00       	call   801071a0 <deallocuvm>
80103a4f:	83 c4 10             	add    $0x10,%esp
80103a52:	85 c0                	test   %eax,%eax
80103a54:	75 b0                	jne    80103a06 <growproc+0x26>
80103a56:	eb de                	jmp    80103a36 <growproc+0x56>
80103a58:	90                   	nop
80103a59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103a60 <fork>:
{
80103a60:	55                   	push   %ebp
80103a61:	89 e5                	mov    %esp,%ebp
80103a63:	57                   	push   %edi
80103a64:	56                   	push   %esi
80103a65:	53                   	push   %ebx
80103a66:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
80103a69:	e8 12 0d 00 00       	call   80104780 <pushcli>
  c = mycpu();
80103a6e:	e8 3d fc ff ff       	call   801036b0 <mycpu>
  p = c->proc;
80103a73:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103a79:	e8 42 0d 00 00       	call   801047c0 <popcli>
  if((np = allocproc()) == 0){
80103a7e:	e8 3d fd ff ff       	call   801037c0 <allocproc>
80103a83:	85 c0                	test   %eax,%eax
80103a85:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103a88:	0f 84 1a 01 00 00    	je     80103ba8 <fork+0x148>
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
80103a8e:	83 ec 08             	sub    $0x8,%esp
80103a91:	ff 33                	pushl  (%ebx)
80103a93:	ff 73 04             	pushl  0x4(%ebx)
80103a96:	e8 85 38 00 00       	call   80107320 <copyuvm>
80103a9b:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103a9e:	83 c4 10             	add    $0x10,%esp
80103aa1:	85 c0                	test   %eax,%eax
80103aa3:	89 42 04             	mov    %eax,0x4(%edx)
80103aa6:	0f 84 05 01 00 00    	je     80103bb1 <fork+0x151>
  np->sz = curproc->sz;
80103aac:	8b 03                	mov    (%ebx),%eax
  *np->tf = *curproc->tf;
80103aae:	8b 7a 18             	mov    0x18(%edx),%edi
80103ab1:	b9 13 00 00 00       	mov    $0x13,%ecx
  np->parent = curproc;
80103ab6:	89 5a 14             	mov    %ebx,0x14(%edx)
  np->sz = curproc->sz;
80103ab9:	89 02                	mov    %eax,(%edx)
  *np->tf = *curproc->tf;
80103abb:	8b 73 18             	mov    0x18(%ebx),%esi
80103abe:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  for(i = 0; i < NOFILE; i++)
80103ac0:	31 f6                	xor    %esi,%esi
  np->tf->eax = 0;
80103ac2:	8b 42 18             	mov    0x18(%edx),%eax
80103ac5:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
80103acc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[i])
80103ad0:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
80103ad4:	85 c0                	test   %eax,%eax
80103ad6:	74 16                	je     80103aee <fork+0x8e>
      np->ofile[i] = filedup(curproc->ofile[i]);
80103ad8:	83 ec 0c             	sub    $0xc,%esp
80103adb:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80103ade:	50                   	push   %eax
80103adf:	e8 3c d3 ff ff       	call   80100e20 <filedup>
80103ae4:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103ae7:	83 c4 10             	add    $0x10,%esp
80103aea:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
  for(i = 0; i < NOFILE; i++)
80103aee:	83 c6 01             	add    $0x1,%esi
80103af1:	83 fe 10             	cmp    $0x10,%esi
80103af4:	75 da                	jne    80103ad0 <fork+0x70>
  np->cwd = idup(curproc->cwd);
80103af6:	83 ec 0c             	sub    $0xc,%esp
80103af9:	ff 73 68             	pushl  0x68(%ebx)
80103afc:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80103aff:	e8 7c db ff ff       	call   80101680 <idup>
80103b04:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103b07:	83 c4 0c             	add    $0xc,%esp
  np->cwd = idup(curproc->cwd);
80103b0a:	89 42 68             	mov    %eax,0x68(%edx)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103b0d:	8d 43 6c             	lea    0x6c(%ebx),%eax
80103b10:	6a 10                	push   $0x10
80103b12:	50                   	push   %eax
80103b13:	8d 42 6c             	lea    0x6c(%edx),%eax
80103b16:	50                   	push   %eax
80103b17:	e8 24 10 00 00       	call   80104b40 <safestrcpy>
  pid = np->pid;
80103b1c:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  np->signal_mask = curproc->signal_mask;
80103b1f:	8b 8b 88 00 00 00    	mov    0x88(%ebx),%ecx
  np->suspended = 0;
80103b25:	83 c4 10             	add    $0x10,%esp
  pid = np->pid;
80103b28:	8b 42 10             	mov    0x10(%edx),%eax
  np->signal_mask = curproc->signal_mask;
80103b2b:	89 8a 88 00 00 00    	mov    %ecx,0x88(%edx)
  for(int i=0; i<32; i++){
80103b31:	31 c9                	xor    %ecx,%ecx
  np->pending_signals = 0; 
80103b33:	c7 82 84 00 00 00 00 	movl   $0x0,0x84(%edx)
80103b3a:	00 00 00 
  np->suspended = 0;
80103b3d:	c7 82 8c 01 00 00 00 	movl   $0x0,0x18c(%edx)
80103b44:	00 00 00 
  pid = np->pid;
80103b47:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103b4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    np->signal_handlers[i] = curproc->signal_handlers[i];
80103b50:	8b b4 cb 8c 00 00 00 	mov    0x8c(%ebx,%ecx,8),%esi
80103b57:	8b bc cb 90 00 00 00 	mov    0x90(%ebx,%ecx,8),%edi
80103b5e:	89 b4 ca 8c 00 00 00 	mov    %esi,0x8c(%edx,%ecx,8)
80103b65:	89 bc ca 90 00 00 00 	mov    %edi,0x90(%edx,%ecx,8)
  for(int i=0; i<32; i++){
80103b6c:	83 c1 01             	add    $0x1,%ecx
80103b6f:	83 f9 20             	cmp    $0x20,%ecx
80103b72:	75 dc                	jne    80103b50 <fork+0xf0>
  acquire(&ptable.lock);
80103b74:	83 ec 0c             	sub    $0xc,%esp
80103b77:	89 55 e0             	mov    %edx,-0x20(%ebp)
80103b7a:	68 20 2d 11 80       	push   $0x80112d20
80103b7f:	e8 cc 0c 00 00       	call   80104850 <acquire>
  np->state = RUNNABLE;
80103b84:	8b 55 e0             	mov    -0x20(%ebp),%edx
80103b87:	c7 42 0c 03 00 00 00 	movl   $0x3,0xc(%edx)
  release(&ptable.lock);
80103b8e:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103b95:	e8 76 0d 00 00       	call   80104910 <release>
  return pid;
80103b9a:	83 c4 10             	add    $0x10,%esp
}
80103b9d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103ba0:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103ba3:	5b                   	pop    %ebx
80103ba4:	5e                   	pop    %esi
80103ba5:	5f                   	pop    %edi
80103ba6:	5d                   	pop    %ebp
80103ba7:	c3                   	ret    
    return -1;
80103ba8:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
80103baf:	eb ec                	jmp    80103b9d <fork+0x13d>
    kfree(np->kstack);
80103bb1:	83 ec 0c             	sub    $0xc,%esp
80103bb4:	ff 72 08             	pushl  0x8(%edx)
80103bb7:	e8 84 e7 ff ff       	call   80102340 <kfree>
    np->kstack = 0;
80103bbc:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    return -1;
80103bbf:	83 c4 10             	add    $0x10,%esp
80103bc2:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
    np->kstack = 0;
80103bc9:	c7 42 08 00 00 00 00 	movl   $0x0,0x8(%edx)
    np->state = UNUSED;
80103bd0:	c7 42 0c 00 00 00 00 	movl   $0x0,0xc(%edx)
    return -1;
80103bd7:	eb c4                	jmp    80103b9d <fork+0x13d>
80103bd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103be0 <scheduler>:
{
80103be0:	55                   	push   %ebp
80103be1:	89 e5                	mov    %esp,%ebp
80103be3:	57                   	push   %edi
80103be4:	56                   	push   %esi
80103be5:	53                   	push   %ebx
80103be6:	83 ec 0c             	sub    $0xc,%esp
  struct cpu *c = mycpu();
80103be9:	e8 c2 fa ff ff       	call   801036b0 <mycpu>
80103bee:	8d 78 04             	lea    0x4(%eax),%edi
80103bf1:	89 c6                	mov    %eax,%esi
  c->proc = 0;
80103bf3:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80103bfa:	00 00 00 
80103bfd:	8d 76 00             	lea    0x0(%esi),%esi
  asm volatile("sti");
80103c00:	fb                   	sti    
    acquire(&ptable.lock);
80103c01:	83 ec 0c             	sub    $0xc,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103c04:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
    acquire(&ptable.lock);
80103c09:	68 20 2d 11 80       	push   $0x80112d20
80103c0e:	e8 3d 0c 00 00       	call   80104850 <acquire>
80103c13:	83 c4 10             	add    $0x10,%esp
80103c16:	8d 76 00             	lea    0x0(%esi),%esi
80103c19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      if(p->state != RUNNABLE)
80103c20:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
80103c24:	75 33                	jne    80103c59 <scheduler+0x79>
      switchuvm(p);
80103c26:	83 ec 0c             	sub    $0xc,%esp
      c->proc = p;
80103c29:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
      switchuvm(p);
80103c2f:	53                   	push   %ebx
80103c30:	e8 eb 31 00 00       	call   80106e20 <switchuvm>
      swtch(&(c->scheduler), p->context);
80103c35:	58                   	pop    %eax
80103c36:	5a                   	pop    %edx
80103c37:	ff 73 1c             	pushl  0x1c(%ebx)
80103c3a:	57                   	push   %edi
      p->state = RUNNING;
80103c3b:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
      swtch(&(c->scheduler), p->context);
80103c42:	e8 54 0f 00 00       	call   80104b9b <swtch>
      switchkvm();
80103c47:	e8 b4 31 00 00       	call   80106e00 <switchkvm>
      c->proc = 0;
80103c4c:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
80103c53:	00 00 00 
80103c56:	83 c4 10             	add    $0x10,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103c59:	81 c3 90 01 00 00    	add    $0x190,%ebx
80103c5f:	81 fb 54 91 11 80    	cmp    $0x80119154,%ebx
80103c65:	72 b9                	jb     80103c20 <scheduler+0x40>
    release(&ptable.lock);
80103c67:	83 ec 0c             	sub    $0xc,%esp
80103c6a:	68 20 2d 11 80       	push   $0x80112d20
80103c6f:	e8 9c 0c 00 00       	call   80104910 <release>
    sti();
80103c74:	83 c4 10             	add    $0x10,%esp
80103c77:	eb 87                	jmp    80103c00 <scheduler+0x20>
80103c79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103c80 <sched>:
{
80103c80:	55                   	push   %ebp
80103c81:	89 e5                	mov    %esp,%ebp
80103c83:	56                   	push   %esi
80103c84:	53                   	push   %ebx
  pushcli();
80103c85:	e8 f6 0a 00 00       	call   80104780 <pushcli>
  c = mycpu();
80103c8a:	e8 21 fa ff ff       	call   801036b0 <mycpu>
  p = c->proc;
80103c8f:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103c95:	e8 26 0b 00 00       	call   801047c0 <popcli>
  if(!holding(&ptable.lock))
80103c9a:	83 ec 0c             	sub    $0xc,%esp
80103c9d:	68 20 2d 11 80       	push   $0x80112d20
80103ca2:	e8 79 0b 00 00       	call   80104820 <holding>
80103ca7:	83 c4 10             	add    $0x10,%esp
80103caa:	85 c0                	test   %eax,%eax
80103cac:	74 4f                	je     80103cfd <sched+0x7d>
  if(mycpu()->ncli != 1)
80103cae:	e8 fd f9 ff ff       	call   801036b0 <mycpu>
80103cb3:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
80103cba:	75 68                	jne    80103d24 <sched+0xa4>
  if(p->state == RUNNING)
80103cbc:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80103cc0:	74 55                	je     80103d17 <sched+0x97>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103cc2:	9c                   	pushf  
80103cc3:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103cc4:	f6 c4 02             	test   $0x2,%ah
80103cc7:	75 41                	jne    80103d0a <sched+0x8a>
  intena = mycpu()->intena;
80103cc9:	e8 e2 f9 ff ff       	call   801036b0 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
80103cce:	83 c3 1c             	add    $0x1c,%ebx
  intena = mycpu()->intena;
80103cd1:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80103cd7:	e8 d4 f9 ff ff       	call   801036b0 <mycpu>
80103cdc:	83 ec 08             	sub    $0x8,%esp
80103cdf:	ff 70 04             	pushl  0x4(%eax)
80103ce2:	53                   	push   %ebx
80103ce3:	e8 b3 0e 00 00       	call   80104b9b <swtch>
  mycpu()->intena = intena;
80103ce8:	e8 c3 f9 ff ff       	call   801036b0 <mycpu>
}
80103ced:	83 c4 10             	add    $0x10,%esp
  mycpu()->intena = intena;
80103cf0:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80103cf6:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103cf9:	5b                   	pop    %ebx
80103cfa:	5e                   	pop    %esi
80103cfb:	5d                   	pop    %ebp
80103cfc:	c3                   	ret    
    panic("sched ptable.lock");
80103cfd:	83 ec 0c             	sub    $0xc,%esp
80103d00:	68 90 7a 10 80       	push   $0x80107a90
80103d05:	e8 86 c6 ff ff       	call   80100390 <panic>
    panic("sched interruptible");
80103d0a:	83 ec 0c             	sub    $0xc,%esp
80103d0d:	68 bc 7a 10 80       	push   $0x80107abc
80103d12:	e8 79 c6 ff ff       	call   80100390 <panic>
    panic("sched running");
80103d17:	83 ec 0c             	sub    $0xc,%esp
80103d1a:	68 ae 7a 10 80       	push   $0x80107aae
80103d1f:	e8 6c c6 ff ff       	call   80100390 <panic>
    panic("sched locks");
80103d24:	83 ec 0c             	sub    $0xc,%esp
80103d27:	68 a2 7a 10 80       	push   $0x80107aa2
80103d2c:	e8 5f c6 ff ff       	call   80100390 <panic>
80103d31:	eb 0d                	jmp    80103d40 <exit>
80103d33:	90                   	nop
80103d34:	90                   	nop
80103d35:	90                   	nop
80103d36:	90                   	nop
80103d37:	90                   	nop
80103d38:	90                   	nop
80103d39:	90                   	nop
80103d3a:	90                   	nop
80103d3b:	90                   	nop
80103d3c:	90                   	nop
80103d3d:	90                   	nop
80103d3e:	90                   	nop
80103d3f:	90                   	nop

80103d40 <exit>:
{
80103d40:	55                   	push   %ebp
80103d41:	89 e5                	mov    %esp,%ebp
80103d43:	57                   	push   %edi
80103d44:	56                   	push   %esi
80103d45:	53                   	push   %ebx
80103d46:	83 ec 0c             	sub    $0xc,%esp
  pushcli();
80103d49:	e8 32 0a 00 00       	call   80104780 <pushcli>
  c = mycpu();
80103d4e:	e8 5d f9 ff ff       	call   801036b0 <mycpu>
  p = c->proc;
80103d53:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80103d59:	e8 62 0a 00 00       	call   801047c0 <popcli>
  if(curproc == initproc)
80103d5e:	39 35 b8 a5 10 80    	cmp    %esi,0x8010a5b8
80103d64:	8d 5e 28             	lea    0x28(%esi),%ebx
80103d67:	8d 7e 68             	lea    0x68(%esi),%edi
80103d6a:	0f 84 f1 00 00 00    	je     80103e61 <exit+0x121>
    if(curproc->ofile[fd]){
80103d70:	8b 03                	mov    (%ebx),%eax
80103d72:	85 c0                	test   %eax,%eax
80103d74:	74 12                	je     80103d88 <exit+0x48>
      fileclose(curproc->ofile[fd]);
80103d76:	83 ec 0c             	sub    $0xc,%esp
80103d79:	50                   	push   %eax
80103d7a:	e8 f1 d0 ff ff       	call   80100e70 <fileclose>
      curproc->ofile[fd] = 0;
80103d7f:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80103d85:	83 c4 10             	add    $0x10,%esp
80103d88:	83 c3 04             	add    $0x4,%ebx
  for(fd = 0; fd < NOFILE; fd++){
80103d8b:	39 fb                	cmp    %edi,%ebx
80103d8d:	75 e1                	jne    80103d70 <exit+0x30>
  begin_op();
80103d8f:	e8 3c ee ff ff       	call   80102bd0 <begin_op>
  iput(curproc->cwd);
80103d94:	83 ec 0c             	sub    $0xc,%esp
80103d97:	ff 76 68             	pushl  0x68(%esi)
80103d9a:	e8 41 da ff ff       	call   801017e0 <iput>
  end_op();
80103d9f:	e8 9c ee ff ff       	call   80102c40 <end_op>
  curproc->cwd = 0;
80103da4:	c7 46 68 00 00 00 00 	movl   $0x0,0x68(%esi)
  acquire(&ptable.lock);
80103dab:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103db2:	e8 99 0a 00 00       	call   80104850 <acquire>
  wakeup1(curproc->parent);
80103db7:	8b 56 14             	mov    0x14(%esi),%edx
80103dba:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103dbd:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
80103dc2:	eb 10                	jmp    80103dd4 <exit+0x94>
80103dc4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103dc8:	05 90 01 00 00       	add    $0x190,%eax
80103dcd:	3d 54 91 11 80       	cmp    $0x80119154,%eax
80103dd2:	73 1e                	jae    80103df2 <exit+0xb2>
    if(p->state == SLEEPING && p->chan == chan)
80103dd4:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103dd8:	75 ee                	jne    80103dc8 <exit+0x88>
80103dda:	3b 50 20             	cmp    0x20(%eax),%edx
80103ddd:	75 e9                	jne    80103dc8 <exit+0x88>
      p->state = RUNNABLE;
80103ddf:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103de6:	05 90 01 00 00       	add    $0x190,%eax
80103deb:	3d 54 91 11 80       	cmp    $0x80119154,%eax
80103df0:	72 e2                	jb     80103dd4 <exit+0x94>
      p->parent = initproc;
80103df2:	8b 0d b8 a5 10 80    	mov    0x8010a5b8,%ecx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103df8:	ba 54 2d 11 80       	mov    $0x80112d54,%edx
80103dfd:	eb 0f                	jmp    80103e0e <exit+0xce>
80103dff:	90                   	nop
80103e00:	81 c2 90 01 00 00    	add    $0x190,%edx
80103e06:	81 fa 54 91 11 80    	cmp    $0x80119154,%edx
80103e0c:	73 3a                	jae    80103e48 <exit+0x108>
    if(p->parent == curproc){
80103e0e:	39 72 14             	cmp    %esi,0x14(%edx)
80103e11:	75 ed                	jne    80103e00 <exit+0xc0>
      if(p->state == ZOMBIE)
80103e13:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
      p->parent = initproc;
80103e17:	89 4a 14             	mov    %ecx,0x14(%edx)
      if(p->state == ZOMBIE)
80103e1a:	75 e4                	jne    80103e00 <exit+0xc0>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103e1c:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
80103e21:	eb 11                	jmp    80103e34 <exit+0xf4>
80103e23:	90                   	nop
80103e24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103e28:	05 90 01 00 00       	add    $0x190,%eax
80103e2d:	3d 54 91 11 80       	cmp    $0x80119154,%eax
80103e32:	73 cc                	jae    80103e00 <exit+0xc0>
    if(p->state == SLEEPING && p->chan == chan)
80103e34:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103e38:	75 ee                	jne    80103e28 <exit+0xe8>
80103e3a:	3b 48 20             	cmp    0x20(%eax),%ecx
80103e3d:	75 e9                	jne    80103e28 <exit+0xe8>
      p->state = RUNNABLE;
80103e3f:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80103e46:	eb e0                	jmp    80103e28 <exit+0xe8>
  curproc->state = ZOMBIE;
80103e48:	c7 46 0c 05 00 00 00 	movl   $0x5,0xc(%esi)
  sched();
80103e4f:	e8 2c fe ff ff       	call   80103c80 <sched>
  panic("zombie exit");
80103e54:	83 ec 0c             	sub    $0xc,%esp
80103e57:	68 dd 7a 10 80       	push   $0x80107add
80103e5c:	e8 2f c5 ff ff       	call   80100390 <panic>
    panic("init exiting");
80103e61:	83 ec 0c             	sub    $0xc,%esp
80103e64:	68 d0 7a 10 80       	push   $0x80107ad0
80103e69:	e8 22 c5 ff ff       	call   80100390 <panic>
80103e6e:	66 90                	xchg   %ax,%ax

80103e70 <yield>:
{
80103e70:	55                   	push   %ebp
80103e71:	89 e5                	mov    %esp,%ebp
80103e73:	53                   	push   %ebx
80103e74:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80103e77:	68 20 2d 11 80       	push   $0x80112d20
80103e7c:	e8 cf 09 00 00       	call   80104850 <acquire>
  pushcli();
80103e81:	e8 fa 08 00 00       	call   80104780 <pushcli>
  c = mycpu();
80103e86:	e8 25 f8 ff ff       	call   801036b0 <mycpu>
  p = c->proc;
80103e8b:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103e91:	e8 2a 09 00 00       	call   801047c0 <popcli>
  myproc()->state = RUNNABLE;
80103e96:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  sched();
80103e9d:	e8 de fd ff ff       	call   80103c80 <sched>
  release(&ptable.lock);
80103ea2:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103ea9:	e8 62 0a 00 00       	call   80104910 <release>
}
80103eae:	83 c4 10             	add    $0x10,%esp
80103eb1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103eb4:	c9                   	leave  
80103eb5:	c3                   	ret    
80103eb6:	8d 76 00             	lea    0x0(%esi),%esi
80103eb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103ec0 <sleep>:
{
80103ec0:	55                   	push   %ebp
80103ec1:	89 e5                	mov    %esp,%ebp
80103ec3:	57                   	push   %edi
80103ec4:	56                   	push   %esi
80103ec5:	53                   	push   %ebx
80103ec6:	83 ec 0c             	sub    $0xc,%esp
80103ec9:	8b 7d 08             	mov    0x8(%ebp),%edi
80103ecc:	8b 75 0c             	mov    0xc(%ebp),%esi
  pushcli();
80103ecf:	e8 ac 08 00 00       	call   80104780 <pushcli>
  c = mycpu();
80103ed4:	e8 d7 f7 ff ff       	call   801036b0 <mycpu>
  p = c->proc;
80103ed9:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103edf:	e8 dc 08 00 00       	call   801047c0 <popcli>
  if(p == 0)
80103ee4:	85 db                	test   %ebx,%ebx
80103ee6:	0f 84 87 00 00 00    	je     80103f73 <sleep+0xb3>
  if(lk == 0)
80103eec:	85 f6                	test   %esi,%esi
80103eee:	74 76                	je     80103f66 <sleep+0xa6>
  if(lk != &ptable.lock){  //DOC: sleeplock0
80103ef0:	81 fe 20 2d 11 80    	cmp    $0x80112d20,%esi
80103ef6:	74 50                	je     80103f48 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
80103ef8:	83 ec 0c             	sub    $0xc,%esp
80103efb:	68 20 2d 11 80       	push   $0x80112d20
80103f00:	e8 4b 09 00 00       	call   80104850 <acquire>
    release(lk);
80103f05:	89 34 24             	mov    %esi,(%esp)
80103f08:	e8 03 0a 00 00       	call   80104910 <release>
  p->chan = chan;
80103f0d:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80103f10:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80103f17:	e8 64 fd ff ff       	call   80103c80 <sched>
  p->chan = 0;
80103f1c:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
    release(&ptable.lock);
80103f23:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103f2a:	e8 e1 09 00 00       	call   80104910 <release>
    acquire(lk);
80103f2f:	89 75 08             	mov    %esi,0x8(%ebp)
80103f32:	83 c4 10             	add    $0x10,%esp
}
80103f35:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103f38:	5b                   	pop    %ebx
80103f39:	5e                   	pop    %esi
80103f3a:	5f                   	pop    %edi
80103f3b:	5d                   	pop    %ebp
    acquire(lk);
80103f3c:	e9 0f 09 00 00       	jmp    80104850 <acquire>
80103f41:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  p->chan = chan;
80103f48:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80103f4b:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80103f52:	e8 29 fd ff ff       	call   80103c80 <sched>
  p->chan = 0;
80103f57:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
80103f5e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103f61:	5b                   	pop    %ebx
80103f62:	5e                   	pop    %esi
80103f63:	5f                   	pop    %edi
80103f64:	5d                   	pop    %ebp
80103f65:	c3                   	ret    
    panic("sleep without lk");
80103f66:	83 ec 0c             	sub    $0xc,%esp
80103f69:	68 ef 7a 10 80       	push   $0x80107aef
80103f6e:	e8 1d c4 ff ff       	call   80100390 <panic>
    panic("sleep");
80103f73:	83 ec 0c             	sub    $0xc,%esp
80103f76:	68 e9 7a 10 80       	push   $0x80107ae9
80103f7b:	e8 10 c4 ff ff       	call   80100390 <panic>

80103f80 <wait>:
{
80103f80:	55                   	push   %ebp
80103f81:	89 e5                	mov    %esp,%ebp
80103f83:	56                   	push   %esi
80103f84:	53                   	push   %ebx
  pushcli();
80103f85:	e8 f6 07 00 00       	call   80104780 <pushcli>
  c = mycpu();
80103f8a:	e8 21 f7 ff ff       	call   801036b0 <mycpu>
  p = c->proc;
80103f8f:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80103f95:	e8 26 08 00 00       	call   801047c0 <popcli>
  acquire(&ptable.lock);
80103f9a:	83 ec 0c             	sub    $0xc,%esp
80103f9d:	68 20 2d 11 80       	push   $0x80112d20
80103fa2:	e8 a9 08 00 00       	call   80104850 <acquire>
80103fa7:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
80103faa:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103fac:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
80103fb1:	eb 13                	jmp    80103fc6 <wait+0x46>
80103fb3:	90                   	nop
80103fb4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103fb8:	81 c3 90 01 00 00    	add    $0x190,%ebx
80103fbe:	81 fb 54 91 11 80    	cmp    $0x80119154,%ebx
80103fc4:	73 1e                	jae    80103fe4 <wait+0x64>
      if(p->parent != curproc)
80103fc6:	39 73 14             	cmp    %esi,0x14(%ebx)
80103fc9:	75 ed                	jne    80103fb8 <wait+0x38>
      if(p->state == ZOMBIE){
80103fcb:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
80103fcf:	74 37                	je     80104008 <wait+0x88>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103fd1:	81 c3 90 01 00 00    	add    $0x190,%ebx
      havekids = 1;
80103fd7:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103fdc:	81 fb 54 91 11 80    	cmp    $0x80119154,%ebx
80103fe2:	72 e2                	jb     80103fc6 <wait+0x46>
    if(!havekids || curproc->killed){
80103fe4:	85 c0                	test   %eax,%eax
80103fe6:	74 7f                	je     80104067 <wait+0xe7>
80103fe8:	8b 46 24             	mov    0x24(%esi),%eax
80103feb:	85 c0                	test   %eax,%eax
80103fed:	75 78                	jne    80104067 <wait+0xe7>
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
80103fef:	83 ec 08             	sub    $0x8,%esp
80103ff2:	68 20 2d 11 80       	push   $0x80112d20
80103ff7:	56                   	push   %esi
80103ff8:	e8 c3 fe ff ff       	call   80103ec0 <sleep>
    havekids = 0;
80103ffd:	83 c4 10             	add    $0x10,%esp
80104000:	eb a8                	jmp    80103faa <wait+0x2a>
80104002:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        kfree(p->kstack);
80104008:	83 ec 0c             	sub    $0xc,%esp
8010400b:	ff 73 08             	pushl  0x8(%ebx)
        pid = p->pid;
8010400e:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80104011:	e8 2a e3 ff ff       	call   80102340 <kfree>
        freevm(p->pgdir);
80104016:	5a                   	pop    %edx
80104017:	ff 73 04             	pushl  0x4(%ebx)
        p->kstack = 0;
8010401a:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80104021:	e8 aa 31 00 00       	call   801071d0 <freevm>
        kfree((char *)p->backup);
80104026:	59                   	pop    %ecx
80104027:	ff 73 7c             	pushl  0x7c(%ebx)
        p->pid = 0;
8010402a:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80104031:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
80104038:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
8010403c:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
80104043:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        kfree((char *)p->backup);
8010404a:	e8 f1 e2 ff ff       	call   80102340 <kfree>
        release(&ptable.lock);
8010404f:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80104056:	e8 b5 08 00 00       	call   80104910 <release>
        return pid;
8010405b:	83 c4 10             	add    $0x10,%esp
}
8010405e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104061:	89 f0                	mov    %esi,%eax
80104063:	5b                   	pop    %ebx
80104064:	5e                   	pop    %esi
80104065:	5d                   	pop    %ebp
80104066:	c3                   	ret    
      release(&ptable.lock);
80104067:	83 ec 0c             	sub    $0xc,%esp
      return -1;
8010406a:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
8010406f:	68 20 2d 11 80       	push   $0x80112d20
80104074:	e8 97 08 00 00       	call   80104910 <release>
      return -1;
80104079:	83 c4 10             	add    $0x10,%esp
8010407c:	eb e0                	jmp    8010405e <wait+0xde>
8010407e:	66 90                	xchg   %ax,%ax

80104080 <wakeup>:
{
80104080:	55                   	push   %ebp
80104081:	89 e5                	mov    %esp,%ebp
80104083:	53                   	push   %ebx
80104084:	83 ec 10             	sub    $0x10,%esp
80104087:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
8010408a:	68 20 2d 11 80       	push   $0x80112d20
8010408f:	e8 bc 07 00 00       	call   80104850 <acquire>
80104094:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104097:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
8010409c:	eb 0e                	jmp    801040ac <wakeup+0x2c>
8010409e:	66 90                	xchg   %ax,%ax
801040a0:	05 90 01 00 00       	add    $0x190,%eax
801040a5:	3d 54 91 11 80       	cmp    $0x80119154,%eax
801040aa:	73 1e                	jae    801040ca <wakeup+0x4a>
    if(p->state == SLEEPING && p->chan == chan)
801040ac:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
801040b0:	75 ee                	jne    801040a0 <wakeup+0x20>
801040b2:	3b 58 20             	cmp    0x20(%eax),%ebx
801040b5:	75 e9                	jne    801040a0 <wakeup+0x20>
      p->state = RUNNABLE;
801040b7:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801040be:	05 90 01 00 00       	add    $0x190,%eax
801040c3:	3d 54 91 11 80       	cmp    $0x80119154,%eax
801040c8:	72 e2                	jb     801040ac <wakeup+0x2c>
  release(&ptable.lock);
801040ca:	c7 45 08 20 2d 11 80 	movl   $0x80112d20,0x8(%ebp)
}
801040d1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801040d4:	c9                   	leave  
  release(&ptable.lock);
801040d5:	e9 36 08 00 00       	jmp    80104910 <release>
801040da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801040e0 <kill>:
{
801040e0:	55                   	push   %ebp
801040e1:	89 e5                	mov    %esp,%ebp
801040e3:	56                   	push   %esi
801040e4:	53                   	push   %ebx
801040e5:	8b 75 0c             	mov    0xc(%ebp),%esi
801040e8:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (signum > 31 || signum < 0)
801040eb:	83 fe 1f             	cmp    $0x1f,%esi
801040ee:	0f 87 88 00 00 00    	ja     8010417c <kill+0x9c>
  acquire(&ptable.lock);
801040f4:	83 ec 0c             	sub    $0xc,%esp
801040f7:	68 20 2d 11 80       	push   $0x80112d20
801040fc:	e8 4f 07 00 00       	call   80104850 <acquire>
80104101:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104104:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
80104109:	eb 11                	jmp    8010411c <kill+0x3c>
8010410b:	90                   	nop
8010410c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104110:	05 90 01 00 00       	add    $0x190,%eax
80104115:	3d 54 91 11 80       	cmp    $0x80119154,%eax
8010411a:	73 44                	jae    80104160 <kill+0x80>
    if(p->pid == pid){
8010411c:	39 58 10             	cmp    %ebx,0x10(%eax)
8010411f:	75 ef                	jne    80104110 <kill+0x30>
      p->pending_signals = p->pending_signals | 1<<signum;
80104121:	ba 01 00 00 00       	mov    $0x1,%edx
80104126:	89 f1                	mov    %esi,%ecx
80104128:	d3 e2                	shl    %cl,%edx
8010412a:	09 90 84 00 00 00    	or     %edx,0x84(%eax)
      if((signum == SIGKILL) & (p->state == SLEEPING))
80104130:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104134:	75 0c                	jne    80104142 <kill+0x62>
80104136:	83 fe 09             	cmp    $0x9,%esi
80104139:	75 07                	jne    80104142 <kill+0x62>
        p->state = RUNNABLE; 
8010413b:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
80104142:	83 ec 0c             	sub    $0xc,%esp
80104145:	68 20 2d 11 80       	push   $0x80112d20
8010414a:	e8 c1 07 00 00       	call   80104910 <release>
      return 0;
8010414f:	83 c4 10             	add    $0x10,%esp
80104152:	31 c0                	xor    %eax,%eax
}
80104154:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104157:	5b                   	pop    %ebx
80104158:	5e                   	pop    %esi
80104159:	5d                   	pop    %ebp
8010415a:	c3                   	ret    
8010415b:	90                   	nop
8010415c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  release(&ptable.lock);
80104160:	83 ec 0c             	sub    $0xc,%esp
80104163:	68 20 2d 11 80       	push   $0x80112d20
80104168:	e8 a3 07 00 00       	call   80104910 <release>
  return -1;
8010416d:	83 c4 10             	add    $0x10,%esp
}
80104170:	8d 65 f8             	lea    -0x8(%ebp),%esp
  return -1;
80104173:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104178:	5b                   	pop    %ebx
80104179:	5e                   	pop    %esi
8010417a:	5d                   	pop    %ebp
8010417b:	c3                   	ret    
  return -1;
8010417c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104181:	eb d1                	jmp    80104154 <kill+0x74>
80104183:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104189:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104190 <kill_handler>:
void kill_handler(void){
80104190:	55                   	push   %ebp
80104191:	89 e5                	mov    %esp,%ebp
80104193:	53                   	push   %ebx
80104194:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80104197:	e8 e4 05 00 00       	call   80104780 <pushcli>
  c = mycpu();
8010419c:	e8 0f f5 ff ff       	call   801036b0 <mycpu>
  p = c->proc;
801041a1:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801041a7:	e8 14 06 00 00       	call   801047c0 <popcli>
  p->killed = 1;
801041ac:	c7 43 24 01 00 00 00 	movl   $0x1,0x24(%ebx)
}
801041b3:	83 c4 04             	add    $0x4,%esp
801041b6:	5b                   	pop    %ebx
801041b7:	5d                   	pop    %ebp
801041b8:	c3                   	ret    
801041b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801041c0 <procdump>:
{
801041c0:	55                   	push   %ebp
801041c1:	89 e5                	mov    %esp,%ebp
801041c3:	57                   	push   %edi
801041c4:	56                   	push   %esi
801041c5:	53                   	push   %ebx
801041c6:	8d 75 e8             	lea    -0x18(%ebp),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801041c9:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
{
801041ce:	83 ec 3c             	sub    $0x3c,%esp
801041d1:	eb 27                	jmp    801041fa <procdump+0x3a>
801041d3:	90                   	nop
801041d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("\n");
801041d8:	83 ec 0c             	sub    $0xc,%esp
801041db:	68 c3 7e 10 80       	push   $0x80107ec3
801041e0:	e8 7b c4 ff ff       	call   80100660 <cprintf>
801041e5:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801041e8:	81 c3 90 01 00 00    	add    $0x190,%ebx
801041ee:	81 fb 54 91 11 80    	cmp    $0x80119154,%ebx
801041f4:	0f 83 86 00 00 00    	jae    80104280 <procdump+0xc0>
    if(p->state == UNUSED)
801041fa:	8b 43 0c             	mov    0xc(%ebx),%eax
801041fd:	85 c0                	test   %eax,%eax
801041ff:	74 e7                	je     801041e8 <procdump+0x28>
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104201:	83 f8 05             	cmp    $0x5,%eax
      state = "???";
80104204:	ba 00 7b 10 80       	mov    $0x80107b00,%edx
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104209:	77 11                	ja     8010421c <procdump+0x5c>
8010420b:	8b 14 85 98 7b 10 80 	mov    -0x7fef8468(,%eax,4),%edx
      state = "???";
80104212:	b8 00 7b 10 80       	mov    $0x80107b00,%eax
80104217:	85 d2                	test   %edx,%edx
80104219:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
8010421c:	8d 43 6c             	lea    0x6c(%ebx),%eax
8010421f:	50                   	push   %eax
80104220:	52                   	push   %edx
80104221:	ff 73 10             	pushl  0x10(%ebx)
80104224:	68 04 7b 10 80       	push   $0x80107b04
80104229:	e8 32 c4 ff ff       	call   80100660 <cprintf>
    if(p->state == SLEEPING){
8010422e:	83 c4 10             	add    $0x10,%esp
80104231:	83 7b 0c 02          	cmpl   $0x2,0xc(%ebx)
80104235:	75 a1                	jne    801041d8 <procdump+0x18>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80104237:	8d 45 c0             	lea    -0x40(%ebp),%eax
8010423a:	83 ec 08             	sub    $0x8,%esp
8010423d:	8d 7d c0             	lea    -0x40(%ebp),%edi
80104240:	50                   	push   %eax
80104241:	8b 43 1c             	mov    0x1c(%ebx),%eax
80104244:	8b 40 0c             	mov    0xc(%eax),%eax
80104247:	83 c0 08             	add    $0x8,%eax
8010424a:	50                   	push   %eax
8010424b:	e8 e0 04 00 00       	call   80104730 <getcallerpcs>
80104250:	83 c4 10             	add    $0x10,%esp
80104253:	90                   	nop
80104254:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      for(i=0; i<10 && pc[i] != 0; i++)
80104258:	8b 17                	mov    (%edi),%edx
8010425a:	85 d2                	test   %edx,%edx
8010425c:	0f 84 76 ff ff ff    	je     801041d8 <procdump+0x18>
        cprintf(" %p", pc[i]);
80104262:	83 ec 08             	sub    $0x8,%esp
80104265:	83 c7 04             	add    $0x4,%edi
80104268:	52                   	push   %edx
80104269:	68 41 75 10 80       	push   $0x80107541
8010426e:	e8 ed c3 ff ff       	call   80100660 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
80104273:	83 c4 10             	add    $0x10,%esp
80104276:	39 fe                	cmp    %edi,%esi
80104278:	75 de                	jne    80104258 <procdump+0x98>
8010427a:	e9 59 ff ff ff       	jmp    801041d8 <procdump+0x18>
8010427f:	90                   	nop
}
80104280:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104283:	5b                   	pop    %ebx
80104284:	5e                   	pop    %esi
80104285:	5f                   	pop    %edi
80104286:	5d                   	pop    %ebp
80104287:	c3                   	ret    
80104288:	90                   	nop
80104289:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104290 <sigprocmask>:
uint sigprocmask (uint sigmask){
80104290:	55                   	push   %ebp
80104291:	89 e5                	mov    %esp,%ebp
80104293:	53                   	push   %ebx
80104294:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80104297:	e8 e4 04 00 00       	call   80104780 <pushcli>
  c = mycpu();
8010429c:	e8 0f f4 ff ff       	call   801036b0 <mycpu>
  p = c->proc;
801042a1:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801042a7:	e8 14 05 00 00       	call   801047c0 <popcli>
  p->signal_mask = sigmask;
801042ac:	8b 55 08             	mov    0x8(%ebp),%edx
  uint oldmask = p->signal_mask;
801042af:	8b 83 88 00 00 00    	mov    0x88(%ebx),%eax
  p->signal_mask = sigmask;
801042b5:	89 93 88 00 00 00    	mov    %edx,0x88(%ebx)
}
801042bb:	83 c4 04             	add    $0x4,%esp
801042be:	5b                   	pop    %ebx
801042bf:	5d                   	pop    %ebp
801042c0:	c3                   	ret    
801042c1:	eb 0d                	jmp    801042d0 <sigaction>
801042c3:	90                   	nop
801042c4:	90                   	nop
801042c5:	90                   	nop
801042c6:	90                   	nop
801042c7:	90                   	nop
801042c8:	90                   	nop
801042c9:	90                   	nop
801042ca:	90                   	nop
801042cb:	90                   	nop
801042cc:	90                   	nop
801042cd:	90                   	nop
801042ce:	90                   	nop
801042cf:	90                   	nop

801042d0 <sigaction>:
int sigaction(int signum , const struct sigaction *act, struct sigaction *oldact){
801042d0:	55                   	push   %ebp
801042d1:	89 e5                	mov    %esp,%ebp
801042d3:	57                   	push   %edi
801042d4:	56                   	push   %esi
801042d5:	53                   	push   %ebx
801042d6:	83 ec 0c             	sub    $0xc,%esp
801042d9:	8b 7d 08             	mov    0x8(%ebp),%edi
801042dc:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  pushcli();
801042df:	e8 9c 04 00 00       	call   80104780 <pushcli>
  c = mycpu();
801042e4:	e8 c7 f3 ff ff       	call   801036b0 <mycpu>
  p = c->proc;
801042e9:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
801042ef:	e8 cc 04 00 00       	call   801047c0 <popcli>
    if (signum > 31 || signum < 0 || signum == SIGSTOP || signum == SIGKILL)
801042f4:	8d 47 f7             	lea    -0x9(%edi),%eax
801042f7:	83 e0 f7             	and    $0xfffffff7,%eax
801042fa:	74 64                	je     80104360 <sigaction+0x90>
801042fc:	83 ff 1f             	cmp    $0x1f,%edi
801042ff:	77 5f                	ja     80104360 <sigaction+0x90>
    if (oldact != null){
80104301:	8b 45 10             	mov    0x10(%ebp),%eax
80104304:	85 c0                	test   %eax,%eax
80104306:	74 16                	je     8010431e <sigaction+0x4e>
      *oldact = p->signal_handlers[signum];
80104308:	8b 4d 10             	mov    0x10(%ebp),%ecx
8010430b:	8b 84 fe 8c 00 00 00 	mov    0x8c(%esi,%edi,8),%eax
80104312:	8b 94 fe 90 00 00 00 	mov    0x90(%esi,%edi,8),%edx
80104319:	89 01                	mov    %eax,(%ecx)
8010431b:	89 51 04             	mov    %edx,0x4(%ecx)
    cprintf("in sigaction %d", signum);
8010431e:	83 ec 08             	sub    $0x8,%esp
80104321:	8d 34 fe             	lea    (%esi,%edi,8),%esi
80104324:	57                   	push   %edi
80104325:	68 0d 7b 10 80       	push   $0x80107b0d
8010432a:	e8 31 c3 ff ff       	call   80100660 <cprintf>
    p->signal_handlers[signum].sa_handler = act->sa_handler;
8010432f:	8b 03                	mov    (%ebx),%eax
80104331:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
    cprintf("sa handler %d", p->signal_handlers[signum].sa_handler);
80104337:	5a                   	pop    %edx
80104338:	59                   	pop    %ecx
80104339:	50                   	push   %eax
8010433a:	68 1d 7b 10 80       	push   $0x80107b1d
8010433f:	e8 1c c3 ff ff       	call   80100660 <cprintf>
    p->signal_handlers[signum].sigmask = act->sigmask;
80104344:	8b 43 04             	mov    0x4(%ebx),%eax
    return 0;
80104347:	83 c4 10             	add    $0x10,%esp
    p->signal_handlers[signum].sigmask = act->sigmask;
8010434a:	89 86 90 00 00 00    	mov    %eax,0x90(%esi)
    return 0;
80104350:	31 c0                	xor    %eax,%eax
}
80104352:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104355:	5b                   	pop    %ebx
80104356:	5e                   	pop    %esi
80104357:	5f                   	pop    %edi
80104358:	5d                   	pop    %ebp
80104359:	c3                   	ret    
8010435a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      return -1;
80104360:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104365:	eb eb                	jmp    80104352 <sigaction+0x82>
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
80104379:	e8 02 04 00 00       	call   80104780 <pushcli>
  c = mycpu();
8010437e:	e8 2d f3 ff ff       	call   801036b0 <mycpu>
  p = c->proc;
80104383:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104389:	e8 32 04 00 00       	call   801047c0 <popcli>
  *p->tf = *p->backup; 
8010438e:	b9 13 00 00 00       	mov    $0x13,%ecx
80104393:	8b 73 7c             	mov    0x7c(%ebx),%esi
80104396:	8b 7b 18             	mov    0x18(%ebx),%edi
80104399:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
   p->already_in_signal = 0;
8010439b:	c7 83 80 00 00 00 00 	movl   $0x0,0x80(%ebx)
801043a2:	00 00 00 
}
801043a5:	83 c4 0c             	add    $0xc,%esp
801043a8:	5b                   	pop    %ebx
801043a9:	5e                   	pop    %esi
801043aa:	5f                   	pop    %edi
801043ab:	5d                   	pop    %ebp
801043ac:	c3                   	ret    
801043ad:	8d 76 00             	lea    0x0(%esi),%esi

801043b0 <stop_handler>:
void stop_handler(void){
801043b0:	55                   	push   %ebp
801043b1:	89 e5                	mov    %esp,%ebp
801043b3:	53                   	push   %ebx
801043b4:	83 ec 04             	sub    $0x4,%esp
  pushcli();
801043b7:	e8 c4 03 00 00       	call   80104780 <pushcli>
  c = mycpu();
801043bc:	e8 ef f2 ff ff       	call   801036b0 <mycpu>
  p = c->proc;
801043c1:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801043c7:	e8 f4 03 00 00       	call   801047c0 <popcli>
  p->suspended = 1; 
801043cc:	c7 83 8c 01 00 00 01 	movl   $0x1,0x18c(%ebx)
801043d3:	00 00 00 
}
801043d6:	83 c4 04             	add    $0x4,%esp
801043d9:	5b                   	pop    %ebx
801043da:	5d                   	pop    %ebp
801043db:	c3                   	ret    
801043dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801043e0 <cont_handler>:
void cont_handler(void){
801043e0:	55                   	push   %ebp
801043e1:	89 e5                	mov    %esp,%ebp
801043e3:	53                   	push   %ebx
801043e4:	83 ec 04             	sub    $0x4,%esp
  pushcli();
801043e7:	e8 94 03 00 00       	call   80104780 <pushcli>
  c = mycpu();
801043ec:	e8 bf f2 ff ff       	call   801036b0 <mycpu>
  p = c->proc;
801043f1:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801043f7:	e8 c4 03 00 00       	call   801047c0 <popcli>
  if (p-> suspended == 1)
801043fc:	83 bb 8c 01 00 00 01 	cmpl   $0x1,0x18c(%ebx)
80104403:	75 0a                	jne    8010440f <cont_handler+0x2f>
    p->suspended = 0; 
80104405:	c7 83 8c 01 00 00 00 	movl   $0x0,0x18c(%ebx)
8010440c:	00 00 00 
}
8010440f:	83 c4 04             	add    $0x4,%esp
80104412:	5b                   	pop    %ebx
80104413:	5d                   	pop    %ebp
80104414:	c3                   	ret    
80104415:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104419:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104420 <default_handlers>:

void default_handlers(int i){
80104420:	55                   	push   %ebp
80104421:	89 e5                	mov    %esp,%ebp
80104423:	8b 45 08             	mov    0x8(%ebp),%eax
  if(i == SIGCONT)
80104426:	83 f8 13             	cmp    $0x13,%eax
80104429:	74 25                	je     80104450 <default_handlers+0x30>
    cont_handler();
  else if(i==SIGSTOP)
8010442b:	83 f8 11             	cmp    $0x11,%eax
8010442e:	74 10                	je     80104440 <default_handlers+0x20>
    stop_handler();
  else
    kill_handler();

}
80104430:	5d                   	pop    %ebp
    kill_handler();
80104431:	e9 5a fd ff ff       	jmp    80104190 <kill_handler>
80104436:	8d 76 00             	lea    0x0(%esi),%esi
80104439:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
}
80104440:	5d                   	pop    %ebp
    stop_handler();
80104441:	e9 6a ff ff ff       	jmp    801043b0 <stop_handler>
80104446:	8d 76 00             	lea    0x0(%esi),%esi
80104449:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
}
80104450:	5d                   	pop    %ebp
    cont_handler();
80104451:	eb 8d                	jmp    801043e0 <cont_handler>
80104453:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104459:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104460 <user_handlers>:

void user_handlers(int i, struct proc * p){
80104460:	55                   	push   %ebp
    int functionSize = ((int)default_handlers - (int)call_sigret); 
    //backup trapframe 
    *p->backup = *p->tf;
80104461:	b9 13 00 00 00       	mov    $0x13,%ecx
    int functionSize = ((int)default_handlers - (int)call_sigret); 
80104466:	b8 20 44 10 80       	mov    $0x80104420,%eax
8010446b:	2d 30 36 10 80       	sub    $0x80103630,%eax
void user_handlers(int i, struct proc * p){
80104470:	89 e5                	mov    %esp,%ebp
80104472:	57                   	push   %edi
80104473:	56                   	push   %esi
80104474:	53                   	push   %ebx
80104475:	83 ec 20             	sub    $0x20,%esp
80104478:	8b 5d 0c             	mov    0xc(%ebp),%ebx
8010447b:	8b 55 08             	mov    0x8(%ebp),%edx
    *p->backup = *p->tf;
8010447e:	8b 73 18             	mov    0x18(%ebx),%esi
80104481:	8b 7b 7c             	mov    0x7c(%ebx),%edi
80104484:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
void user_handlers(int i, struct proc * p){
80104486:	89 55 e4             	mov    %edx,-0x1c(%ebp)

    //put functionn
    p->tf->esp -= functionSize;
80104489:	8b 4b 18             	mov    0x18(%ebx),%ecx
8010448c:	29 41 44             	sub    %eax,0x44(%ecx)
    memmove((int*)p->tf->esp, &call_sigret, functionSize);
8010448f:	50                   	push   %eax
80104490:	68 30 36 10 80       	push   $0x80103630
80104495:	8b 43 18             	mov    0x18(%ebx),%eax
80104498:	ff 70 44             	pushl  0x44(%eax)
8010449b:	e8 70 05 00 00       	call   80104a10 <memmove>
    uint returnAdress = p->tf->esp;
801044a0:	8b 4b 18             	mov    0x18(%ebx),%ecx

    // push argumants
    p->tf->esp -= sizeof i;
    *(int*)p->tf->esp = i;
801044a3:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    //push return address
    p->tf->esp -= sizeof(int);
    *(int*)p->tf->esp = returnAdress; //adrees to the function that calls sigret 
    struct sigaction handler = p->signal_handlers[i]; 
    p->tf->eip = (uint)handler.sa_handler; 
    trapret_handler(p->tf);
801044a6:	83 c4 10             	add    $0x10,%esp
    uint returnAdress = p->tf->esp;
801044a9:	8b 41 44             	mov    0x44(%ecx),%eax
    p->tf->esp -= sizeof i;
801044ac:	8d 70 fc             	lea    -0x4(%eax),%esi
801044af:	89 71 44             	mov    %esi,0x44(%ecx)
    *(int*)p->tf->esp = i;
801044b2:	8b 4b 18             	mov    0x18(%ebx),%ecx
801044b5:	8b 49 44             	mov    0x44(%ecx),%ecx
801044b8:	89 11                	mov    %edx,(%ecx)
    p->tf->esp -= sizeof(int);
801044ba:	8b 4b 18             	mov    0x18(%ebx),%ecx
801044bd:	83 69 44 04          	subl   $0x4,0x44(%ecx)
    *(int*)p->tf->esp = returnAdress; //adrees to the function that calls sigret 
801044c1:	8b 4b 18             	mov    0x18(%ebx),%ecx
801044c4:	8b 49 44             	mov    0x44(%ecx),%ecx
801044c7:	89 01                	mov    %eax,(%ecx)
    p->tf->eip = (uint)handler.sa_handler; 
801044c9:	8b 43 18             	mov    0x18(%ebx),%eax
801044cc:	8b 94 d3 8c 00 00 00 	mov    0x8c(%ebx,%edx,8),%edx
801044d3:	89 50 38             	mov    %edx,0x38(%eax)
    trapret_handler(p->tf);
801044d6:	8b 43 18             	mov    0x18(%ebx),%eax
801044d9:	89 45 08             	mov    %eax,0x8(%ebp)

}
801044dc:	8d 65 f4             	lea    -0xc(%ebp),%esp
801044df:	5b                   	pop    %ebx
801044e0:	5e                   	pop    %esi
801044e1:	5f                   	pop    %edi
801044e2:	5d                   	pop    %ebp
    trapret_handler(p->tf);
801044e3:	e9 47 17 00 00       	jmp    80105c2f <trapret_handler>
801044e8:	90                   	nop
801044e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801044f0 <check_for_signals>:

void check_for_signals(void){
801044f0:	55                   	push   %ebp
801044f1:	89 e5                	mov    %esp,%ebp
801044f3:	57                   	push   %edi
801044f4:	56                   	push   %esi
801044f5:	53                   	push   %ebx
801044f6:	83 ec 0c             	sub    $0xc,%esp
  pushcli();
801044f9:	e8 82 02 00 00       	call   80104780 <pushcli>
  c = mycpu();
801044fe:	e8 ad f1 ff ff       	call   801036b0 <mycpu>
  p = c->proc;
80104503:	8b b8 ac 00 00 00    	mov    0xac(%eax),%edi
  popcli();
80104509:	e8 b2 02 00 00       	call   801047c0 <popcli>
  struct proc *p = myproc();
  if (p == 0)
8010450e:	85 ff                	test   %edi,%edi
80104510:	74 0a                	je     8010451c <check_for_signals+0x2c>
    return; 
  if(p->already_in_signal)
80104512:	8b b7 80 00 00 00    	mov    0x80(%edi),%esi
80104518:	85 f6                	test   %esi,%esi
8010451a:	74 3c                	je     80104558 <check_for_signals+0x68>
          user_handlers(i, p);
        }      
     }
    }
  }
}
8010451c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010451f:	5b                   	pop    %ebx
80104520:	5e                   	pop    %esi
80104521:	5f                   	pop    %edi
80104522:	5d                   	pop    %ebp
80104523:	c3                   	ret    
80104524:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
          cprintf("not %d", i);
80104528:	83 ec 08             	sub    $0x8,%esp
          p->already_in_signal = 1; 
8010452b:	c7 87 80 00 00 00 01 	movl   $0x1,0x80(%edi)
80104532:	00 00 00 
          cprintf("not %d", i);
80104535:	56                   	push   %esi
80104536:	68 3d 7b 10 80       	push   $0x80107b3d
8010453b:	e8 20 c1 ff ff       	call   80100660 <cprintf>
          user_handlers(i, p);
80104540:	58                   	pop    %eax
80104541:	5a                   	pop    %edx
80104542:	57                   	push   %edi
80104543:	56                   	push   %esi
80104544:	e8 17 ff ff ff       	call   80104460 <user_handlers>
80104549:	83 c4 10             	add    $0x10,%esp
8010454c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(int i=0; i<32; i=i+1){
80104550:	83 c6 01             	add    $0x1,%esi
80104553:	83 fe 20             	cmp    $0x20,%esi
80104556:	74 c4                	je     8010451c <check_for_signals+0x2c>
    is_blocked = (p->signal_mask & signal_index) == signal_index; //check if signal is blocked 
80104558:	8b 87 88 00 00 00    	mov    0x88(%edi),%eax
    signal_index = 1<<i; 
8010455e:	bb 01 00 00 00       	mov    $0x1,%ebx
80104563:	89 f1                	mov    %esi,%ecx
80104565:	d3 e3                	shl    %cl,%ebx
    if(((p->pending_signals & signal_index) == signal_index) & !is_blocked){
80104567:	8b 97 84 00 00 00    	mov    0x84(%edi),%edx
    is_blocked = (p->signal_mask & signal_index) == signal_index; //check if signal is blocked 
8010456d:	21 d8                	and    %ebx,%eax
    if(((p->pending_signals & signal_index) == signal_index) & !is_blocked){
8010456f:	39 d8                	cmp    %ebx,%eax
80104571:	74 dd                	je     80104550 <check_for_signals+0x60>
80104573:	89 d8                	mov    %ebx,%eax
80104575:	21 d0                	and    %edx,%eax
80104577:	39 d8                	cmp    %ebx,%eax
80104579:	75 d5                	jne    80104550 <check_for_signals+0x60>
      cprintf("%d %d\n", p->pending_signals, i);
8010457b:	83 ec 04             	sub    $0x4,%esp
      p->pending_signals = p->pending_signals & (~signal_index); //discard signal
8010457e:	f7 d3                	not    %ebx
      cprintf("%d %d\n", p->pending_signals, i);
80104580:	56                   	push   %esi
80104581:	52                   	push   %edx
80104582:	68 2b 7b 10 80       	push   $0x80107b2b
80104587:	e8 d4 c0 ff ff       	call   80100660 <cprintf>
      p->pending_signals = p->pending_signals & (~signal_index); //discard signal
8010458c:	23 9f 84 00 00 00    	and    0x84(%edi),%ebx
80104592:	89 9f 84 00 00 00    	mov    %ebx,0x84(%edi)
      cprintf("%d", p->pending_signals);
80104598:	59                   	pop    %ecx
80104599:	58                   	pop    %eax
8010459a:	53                   	push   %ebx
8010459b:	68 1a 7b 10 80       	push   $0x80107b1a
801045a0:	e8 bb c0 ff ff       	call   80100660 <cprintf>
      if(p->signal_handlers[i].sa_handler != (void*)SIG_IGN){
801045a5:	8b 84 f7 8c 00 00 00 	mov    0x8c(%edi,%esi,8),%eax
801045ac:	83 c4 10             	add    $0x10,%esp
801045af:	83 f8 01             	cmp    $0x1,%eax
801045b2:	74 9c                	je     80104550 <check_for_signals+0x60>
        if (p->signal_handlers[i].sa_handler == SIG_DFL){
801045b4:	85 c0                	test   %eax,%eax
801045b6:	0f 85 6c ff ff ff    	jne    80104528 <check_for_signals+0x38>
            cprintf("default %d", i);
801045bc:	83 ec 08             	sub    $0x8,%esp
801045bf:	56                   	push   %esi
801045c0:	68 32 7b 10 80       	push   $0x80107b32
801045c5:	e8 96 c0 ff ff       	call   80100660 <cprintf>
          default_handlers(i);
801045ca:	89 34 24             	mov    %esi,(%esp)
801045cd:	e8 4e fe ff ff       	call   80104420 <default_handlers>
801045d2:	83 c4 10             	add    $0x10,%esp
801045d5:	e9 76 ff ff ff       	jmp    80104550 <check_for_signals+0x60>
801045da:	66 90                	xchg   %ax,%ax
801045dc:	66 90                	xchg   %ax,%ax
801045de:	66 90                	xchg   %ax,%ax

801045e0 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
801045e0:	55                   	push   %ebp
801045e1:	89 e5                	mov    %esp,%ebp
801045e3:	53                   	push   %ebx
801045e4:	83 ec 0c             	sub    $0xc,%esp
801045e7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
801045ea:	68 b0 7b 10 80       	push   $0x80107bb0
801045ef:	8d 43 04             	lea    0x4(%ebx),%eax
801045f2:	50                   	push   %eax
801045f3:	e8 18 01 00 00       	call   80104710 <initlock>
  lk->name = name;
801045f8:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
801045fb:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
80104601:	83 c4 10             	add    $0x10,%esp
  lk->pid = 0;
80104604:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
8010460b:	89 43 38             	mov    %eax,0x38(%ebx)
}
8010460e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104611:	c9                   	leave  
80104612:	c3                   	ret    
80104613:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104619:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104620 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80104620:	55                   	push   %ebp
80104621:	89 e5                	mov    %esp,%ebp
80104623:	56                   	push   %esi
80104624:	53                   	push   %ebx
80104625:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104628:	83 ec 0c             	sub    $0xc,%esp
8010462b:	8d 73 04             	lea    0x4(%ebx),%esi
8010462e:	56                   	push   %esi
8010462f:	e8 1c 02 00 00       	call   80104850 <acquire>
  while (lk->locked) {
80104634:	8b 13                	mov    (%ebx),%edx
80104636:	83 c4 10             	add    $0x10,%esp
80104639:	85 d2                	test   %edx,%edx
8010463b:	74 16                	je     80104653 <acquiresleep+0x33>
8010463d:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
80104640:	83 ec 08             	sub    $0x8,%esp
80104643:	56                   	push   %esi
80104644:	53                   	push   %ebx
80104645:	e8 76 f8 ff ff       	call   80103ec0 <sleep>
  while (lk->locked) {
8010464a:	8b 03                	mov    (%ebx),%eax
8010464c:	83 c4 10             	add    $0x10,%esp
8010464f:	85 c0                	test   %eax,%eax
80104651:	75 ed                	jne    80104640 <acquiresleep+0x20>
  }
  lk->locked = 1;
80104653:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80104659:	e8 f2 f0 ff ff       	call   80103750 <myproc>
8010465e:	8b 40 10             	mov    0x10(%eax),%eax
80104661:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80104664:	89 75 08             	mov    %esi,0x8(%ebp)
}
80104667:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010466a:	5b                   	pop    %ebx
8010466b:	5e                   	pop    %esi
8010466c:	5d                   	pop    %ebp
  release(&lk->lk);
8010466d:	e9 9e 02 00 00       	jmp    80104910 <release>
80104672:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104679:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104680 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
80104680:	55                   	push   %ebp
80104681:	89 e5                	mov    %esp,%ebp
80104683:	56                   	push   %esi
80104684:	53                   	push   %ebx
80104685:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104688:	83 ec 0c             	sub    $0xc,%esp
8010468b:	8d 73 04             	lea    0x4(%ebx),%esi
8010468e:	56                   	push   %esi
8010468f:	e8 bc 01 00 00       	call   80104850 <acquire>
  lk->locked = 0;
80104694:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
8010469a:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
801046a1:	89 1c 24             	mov    %ebx,(%esp)
801046a4:	e8 d7 f9 ff ff       	call   80104080 <wakeup>
  release(&lk->lk);
801046a9:	89 75 08             	mov    %esi,0x8(%ebp)
801046ac:	83 c4 10             	add    $0x10,%esp
}
801046af:	8d 65 f8             	lea    -0x8(%ebp),%esp
801046b2:	5b                   	pop    %ebx
801046b3:	5e                   	pop    %esi
801046b4:	5d                   	pop    %ebp
  release(&lk->lk);
801046b5:	e9 56 02 00 00       	jmp    80104910 <release>
801046ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801046c0 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
801046c0:	55                   	push   %ebp
801046c1:	89 e5                	mov    %esp,%ebp
801046c3:	57                   	push   %edi
801046c4:	56                   	push   %esi
801046c5:	53                   	push   %ebx
801046c6:	31 ff                	xor    %edi,%edi
801046c8:	83 ec 18             	sub    $0x18,%esp
801046cb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  
  acquire(&lk->lk);
801046ce:	8d 73 04             	lea    0x4(%ebx),%esi
801046d1:	56                   	push   %esi
801046d2:	e8 79 01 00 00       	call   80104850 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
801046d7:	8b 03                	mov    (%ebx),%eax
801046d9:	83 c4 10             	add    $0x10,%esp
801046dc:	85 c0                	test   %eax,%eax
801046de:	74 13                	je     801046f3 <holdingsleep+0x33>
801046e0:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
801046e3:	e8 68 f0 ff ff       	call   80103750 <myproc>
801046e8:	39 58 10             	cmp    %ebx,0x10(%eax)
801046eb:	0f 94 c0             	sete   %al
801046ee:	0f b6 c0             	movzbl %al,%eax
801046f1:	89 c7                	mov    %eax,%edi
  release(&lk->lk);
801046f3:	83 ec 0c             	sub    $0xc,%esp
801046f6:	56                   	push   %esi
801046f7:	e8 14 02 00 00       	call   80104910 <release>
  return r;
}
801046fc:	8d 65 f4             	lea    -0xc(%ebp),%esp
801046ff:	89 f8                	mov    %edi,%eax
80104701:	5b                   	pop    %ebx
80104702:	5e                   	pop    %esi
80104703:	5f                   	pop    %edi
80104704:	5d                   	pop    %ebp
80104705:	c3                   	ret    
80104706:	66 90                	xchg   %ax,%ax
80104708:	66 90                	xchg   %ax,%ax
8010470a:	66 90                	xchg   %ax,%ax
8010470c:	66 90                	xchg   %ax,%ax
8010470e:	66 90                	xchg   %ax,%ax

80104710 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80104710:	55                   	push   %ebp
80104711:	89 e5                	mov    %esp,%ebp
80104713:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80104716:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80104719:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
8010471f:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
80104722:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80104729:	5d                   	pop    %ebp
8010472a:	c3                   	ret    
8010472b:	90                   	nop
8010472c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104730 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104730:	55                   	push   %ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104731:	31 d2                	xor    %edx,%edx
{
80104733:	89 e5                	mov    %esp,%ebp
80104735:	53                   	push   %ebx
  ebp = (uint*)v - 2;
80104736:	8b 45 08             	mov    0x8(%ebp),%eax
{
80104739:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  ebp = (uint*)v - 2;
8010473c:	83 e8 08             	sub    $0x8,%eax
8010473f:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104740:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
80104746:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
8010474c:	77 1a                	ja     80104768 <getcallerpcs+0x38>
      break;
    pcs[i] = ebp[1];     // saved %eip
8010474e:	8b 58 04             	mov    0x4(%eax),%ebx
80104751:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
80104754:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
80104757:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80104759:	83 fa 0a             	cmp    $0xa,%edx
8010475c:	75 e2                	jne    80104740 <getcallerpcs+0x10>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
8010475e:	5b                   	pop    %ebx
8010475f:	5d                   	pop    %ebp
80104760:	c3                   	ret    
80104761:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104768:	8d 04 91             	lea    (%ecx,%edx,4),%eax
8010476b:	83 c1 28             	add    $0x28,%ecx
8010476e:	66 90                	xchg   %ax,%ax
    pcs[i] = 0;
80104770:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104776:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
80104779:	39 c1                	cmp    %eax,%ecx
8010477b:	75 f3                	jne    80104770 <getcallerpcs+0x40>
}
8010477d:	5b                   	pop    %ebx
8010477e:	5d                   	pop    %ebp
8010477f:	c3                   	ret    

80104780 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80104780:	55                   	push   %ebp
80104781:	89 e5                	mov    %esp,%ebp
80104783:	53                   	push   %ebx
80104784:	83 ec 04             	sub    $0x4,%esp
80104787:	9c                   	pushf  
80104788:	5b                   	pop    %ebx
  asm volatile("cli");
80104789:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
8010478a:	e8 21 ef ff ff       	call   801036b0 <mycpu>
8010478f:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80104795:	85 c0                	test   %eax,%eax
80104797:	75 11                	jne    801047aa <pushcli+0x2a>
    mycpu()->intena = eflags & FL_IF;
80104799:	81 e3 00 02 00 00    	and    $0x200,%ebx
8010479f:	e8 0c ef ff ff       	call   801036b0 <mycpu>
801047a4:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
  mycpu()->ncli += 1;
801047aa:	e8 01 ef ff ff       	call   801036b0 <mycpu>
801047af:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
801047b6:	83 c4 04             	add    $0x4,%esp
801047b9:	5b                   	pop    %ebx
801047ba:	5d                   	pop    %ebp
801047bb:	c3                   	ret    
801047bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801047c0 <popcli>:

void
popcli(void)
{
801047c0:	55                   	push   %ebp
801047c1:	89 e5                	mov    %esp,%ebp
801047c3:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801047c6:	9c                   	pushf  
801047c7:	58                   	pop    %eax
  if(readeflags()&FL_IF)
801047c8:	f6 c4 02             	test   $0x2,%ah
801047cb:	75 35                	jne    80104802 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
801047cd:	e8 de ee ff ff       	call   801036b0 <mycpu>
801047d2:	83 a8 a4 00 00 00 01 	subl   $0x1,0xa4(%eax)
801047d9:	78 34                	js     8010480f <popcli+0x4f>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
801047db:	e8 d0 ee ff ff       	call   801036b0 <mycpu>
801047e0:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
801047e6:	85 d2                	test   %edx,%edx
801047e8:	74 06                	je     801047f0 <popcli+0x30>
    sti();
}
801047ea:	c9                   	leave  
801047eb:	c3                   	ret    
801047ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(mycpu()->ncli == 0 && mycpu()->intena)
801047f0:	e8 bb ee ff ff       	call   801036b0 <mycpu>
801047f5:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
801047fb:	85 c0                	test   %eax,%eax
801047fd:	74 eb                	je     801047ea <popcli+0x2a>
  asm volatile("sti");
801047ff:	fb                   	sti    
}
80104800:	c9                   	leave  
80104801:	c3                   	ret    
    panic("popcli - interruptible");
80104802:	83 ec 0c             	sub    $0xc,%esp
80104805:	68 bb 7b 10 80       	push   $0x80107bbb
8010480a:	e8 81 bb ff ff       	call   80100390 <panic>
    panic("popcli");
8010480f:	83 ec 0c             	sub    $0xc,%esp
80104812:	68 d2 7b 10 80       	push   $0x80107bd2
80104817:	e8 74 bb ff ff       	call   80100390 <panic>
8010481c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104820 <holding>:
{
80104820:	55                   	push   %ebp
80104821:	89 e5                	mov    %esp,%ebp
80104823:	56                   	push   %esi
80104824:	53                   	push   %ebx
80104825:	8b 75 08             	mov    0x8(%ebp),%esi
80104828:	31 db                	xor    %ebx,%ebx
  pushcli();
8010482a:	e8 51 ff ff ff       	call   80104780 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
8010482f:	8b 06                	mov    (%esi),%eax
80104831:	85 c0                	test   %eax,%eax
80104833:	74 10                	je     80104845 <holding+0x25>
80104835:	8b 5e 08             	mov    0x8(%esi),%ebx
80104838:	e8 73 ee ff ff       	call   801036b0 <mycpu>
8010483d:	39 c3                	cmp    %eax,%ebx
8010483f:	0f 94 c3             	sete   %bl
80104842:	0f b6 db             	movzbl %bl,%ebx
  popcli();
80104845:	e8 76 ff ff ff       	call   801047c0 <popcli>
}
8010484a:	89 d8                	mov    %ebx,%eax
8010484c:	5b                   	pop    %ebx
8010484d:	5e                   	pop    %esi
8010484e:	5d                   	pop    %ebp
8010484f:	c3                   	ret    

80104850 <acquire>:
{
80104850:	55                   	push   %ebp
80104851:	89 e5                	mov    %esp,%ebp
80104853:	56                   	push   %esi
80104854:	53                   	push   %ebx
  pushcli(); // disable interrupts to avoid deadlock.
80104855:	e8 26 ff ff ff       	call   80104780 <pushcli>
  if(holding(lk))
8010485a:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010485d:	83 ec 0c             	sub    $0xc,%esp
80104860:	53                   	push   %ebx
80104861:	e8 ba ff ff ff       	call   80104820 <holding>
80104866:	83 c4 10             	add    $0x10,%esp
80104869:	85 c0                	test   %eax,%eax
8010486b:	0f 85 83 00 00 00    	jne    801048f4 <acquire+0xa4>
80104871:	89 c6                	mov    %eax,%esi
  asm volatile("lock; xchgl %0, %1" :
80104873:	ba 01 00 00 00       	mov    $0x1,%edx
80104878:	eb 09                	jmp    80104883 <acquire+0x33>
8010487a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104880:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104883:	89 d0                	mov    %edx,%eax
80104885:	f0 87 03             	lock xchg %eax,(%ebx)
  while(xchg(&lk->locked, 1) != 0)
80104888:	85 c0                	test   %eax,%eax
8010488a:	75 f4                	jne    80104880 <acquire+0x30>
  __sync_synchronize();
8010488c:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
80104891:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104894:	e8 17 ee ff ff       	call   801036b0 <mycpu>
  getcallerpcs(&lk, lk->pcs);
80104899:	8d 53 0c             	lea    0xc(%ebx),%edx
  lk->cpu = mycpu();
8010489c:	89 43 08             	mov    %eax,0x8(%ebx)
  ebp = (uint*)v - 2;
8010489f:	89 e8                	mov    %ebp,%eax
801048a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801048a8:	8d 88 00 00 00 80    	lea    -0x80000000(%eax),%ecx
801048ae:	81 f9 fe ff ff 7f    	cmp    $0x7ffffffe,%ecx
801048b4:	77 1a                	ja     801048d0 <acquire+0x80>
    pcs[i] = ebp[1];     // saved %eip
801048b6:	8b 48 04             	mov    0x4(%eax),%ecx
801048b9:	89 0c b2             	mov    %ecx,(%edx,%esi,4)
  for(i = 0; i < 10; i++){
801048bc:	83 c6 01             	add    $0x1,%esi
    ebp = (uint*)ebp[0]; // saved %ebp
801048bf:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
801048c1:	83 fe 0a             	cmp    $0xa,%esi
801048c4:	75 e2                	jne    801048a8 <acquire+0x58>
}
801048c6:	8d 65 f8             	lea    -0x8(%ebp),%esp
801048c9:	5b                   	pop    %ebx
801048ca:	5e                   	pop    %esi
801048cb:	5d                   	pop    %ebp
801048cc:	c3                   	ret    
801048cd:	8d 76 00             	lea    0x0(%esi),%esi
801048d0:	8d 04 b2             	lea    (%edx,%esi,4),%eax
801048d3:	83 c2 28             	add    $0x28,%edx
801048d6:	8d 76 00             	lea    0x0(%esi),%esi
801048d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    pcs[i] = 0;
801048e0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
801048e6:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
801048e9:	39 d0                	cmp    %edx,%eax
801048eb:	75 f3                	jne    801048e0 <acquire+0x90>
}
801048ed:	8d 65 f8             	lea    -0x8(%ebp),%esp
801048f0:	5b                   	pop    %ebx
801048f1:	5e                   	pop    %esi
801048f2:	5d                   	pop    %ebp
801048f3:	c3                   	ret    
    panic("acquire");
801048f4:	83 ec 0c             	sub    $0xc,%esp
801048f7:	68 d9 7b 10 80       	push   $0x80107bd9
801048fc:	e8 8f ba ff ff       	call   80100390 <panic>
80104901:	eb 0d                	jmp    80104910 <release>
80104903:	90                   	nop
80104904:	90                   	nop
80104905:	90                   	nop
80104906:	90                   	nop
80104907:	90                   	nop
80104908:	90                   	nop
80104909:	90                   	nop
8010490a:	90                   	nop
8010490b:	90                   	nop
8010490c:	90                   	nop
8010490d:	90                   	nop
8010490e:	90                   	nop
8010490f:	90                   	nop

80104910 <release>:
{
80104910:	55                   	push   %ebp
80104911:	89 e5                	mov    %esp,%ebp
80104913:	53                   	push   %ebx
80104914:	83 ec 10             	sub    $0x10,%esp
80104917:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holding(lk))
8010491a:	53                   	push   %ebx
8010491b:	e8 00 ff ff ff       	call   80104820 <holding>
80104920:	83 c4 10             	add    $0x10,%esp
80104923:	85 c0                	test   %eax,%eax
80104925:	74 22                	je     80104949 <release+0x39>
  lk->pcs[0] = 0;
80104927:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
8010492e:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
80104935:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
8010493a:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
80104940:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104943:	c9                   	leave  
  popcli();
80104944:	e9 77 fe ff ff       	jmp    801047c0 <popcli>
    panic("release");
80104949:	83 ec 0c             	sub    $0xc,%esp
8010494c:	68 e1 7b 10 80       	push   $0x80107be1
80104951:	e8 3a ba ff ff       	call   80100390 <panic>
80104956:	66 90                	xchg   %ax,%ax
80104958:	66 90                	xchg   %ax,%ax
8010495a:	66 90                	xchg   %ax,%ax
8010495c:	66 90                	xchg   %ax,%ax
8010495e:	66 90                	xchg   %ax,%ax

80104960 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80104960:	55                   	push   %ebp
80104961:	89 e5                	mov    %esp,%ebp
80104963:	57                   	push   %edi
80104964:	53                   	push   %ebx
80104965:	8b 55 08             	mov    0x8(%ebp),%edx
80104968:	8b 4d 10             	mov    0x10(%ebp),%ecx
  if ((int)dst%4 == 0 && n%4 == 0){
8010496b:	f6 c2 03             	test   $0x3,%dl
8010496e:	75 05                	jne    80104975 <memset+0x15>
80104970:	f6 c1 03             	test   $0x3,%cl
80104973:	74 13                	je     80104988 <memset+0x28>
  asm volatile("cld; rep stosb" :
80104975:	89 d7                	mov    %edx,%edi
80104977:	8b 45 0c             	mov    0xc(%ebp),%eax
8010497a:	fc                   	cld    
8010497b:	f3 aa                	rep stos %al,%es:(%edi)
    c &= 0xFF;
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
8010497d:	5b                   	pop    %ebx
8010497e:	89 d0                	mov    %edx,%eax
80104980:	5f                   	pop    %edi
80104981:	5d                   	pop    %ebp
80104982:	c3                   	ret    
80104983:	90                   	nop
80104984:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c &= 0xFF;
80104988:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
8010498c:	c1 e9 02             	shr    $0x2,%ecx
8010498f:	89 f8                	mov    %edi,%eax
80104991:	89 fb                	mov    %edi,%ebx
80104993:	c1 e0 18             	shl    $0x18,%eax
80104996:	c1 e3 10             	shl    $0x10,%ebx
80104999:	09 d8                	or     %ebx,%eax
8010499b:	09 f8                	or     %edi,%eax
8010499d:	c1 e7 08             	shl    $0x8,%edi
801049a0:	09 f8                	or     %edi,%eax
  asm volatile("cld; rep stosl" :
801049a2:	89 d7                	mov    %edx,%edi
801049a4:	fc                   	cld    
801049a5:	f3 ab                	rep stos %eax,%es:(%edi)
}
801049a7:	5b                   	pop    %ebx
801049a8:	89 d0                	mov    %edx,%eax
801049aa:	5f                   	pop    %edi
801049ab:	5d                   	pop    %ebp
801049ac:	c3                   	ret    
801049ad:	8d 76 00             	lea    0x0(%esi),%esi

801049b0 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
801049b0:	55                   	push   %ebp
801049b1:	89 e5                	mov    %esp,%ebp
801049b3:	57                   	push   %edi
801049b4:	56                   	push   %esi
801049b5:	53                   	push   %ebx
801049b6:	8b 5d 10             	mov    0x10(%ebp),%ebx
801049b9:	8b 75 08             	mov    0x8(%ebp),%esi
801049bc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
801049bf:	85 db                	test   %ebx,%ebx
801049c1:	74 29                	je     801049ec <memcmp+0x3c>
    if(*s1 != *s2)
801049c3:	0f b6 16             	movzbl (%esi),%edx
801049c6:	0f b6 0f             	movzbl (%edi),%ecx
801049c9:	38 d1                	cmp    %dl,%cl
801049cb:	75 2b                	jne    801049f8 <memcmp+0x48>
801049cd:	b8 01 00 00 00       	mov    $0x1,%eax
801049d2:	eb 14                	jmp    801049e8 <memcmp+0x38>
801049d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801049d8:	0f b6 14 06          	movzbl (%esi,%eax,1),%edx
801049dc:	83 c0 01             	add    $0x1,%eax
801049df:	0f b6 4c 07 ff       	movzbl -0x1(%edi,%eax,1),%ecx
801049e4:	38 ca                	cmp    %cl,%dl
801049e6:	75 10                	jne    801049f8 <memcmp+0x48>
  while(n-- > 0){
801049e8:	39 d8                	cmp    %ebx,%eax
801049ea:	75 ec                	jne    801049d8 <memcmp+0x28>
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
}
801049ec:	5b                   	pop    %ebx
  return 0;
801049ed:	31 c0                	xor    %eax,%eax
}
801049ef:	5e                   	pop    %esi
801049f0:	5f                   	pop    %edi
801049f1:	5d                   	pop    %ebp
801049f2:	c3                   	ret    
801049f3:	90                   	nop
801049f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      return *s1 - *s2;
801049f8:	0f b6 c2             	movzbl %dl,%eax
}
801049fb:	5b                   	pop    %ebx
      return *s1 - *s2;
801049fc:	29 c8                	sub    %ecx,%eax
}
801049fe:	5e                   	pop    %esi
801049ff:	5f                   	pop    %edi
80104a00:	5d                   	pop    %ebp
80104a01:	c3                   	ret    
80104a02:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104a09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104a10 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80104a10:	55                   	push   %ebp
80104a11:	89 e5                	mov    %esp,%ebp
80104a13:	56                   	push   %esi
80104a14:	53                   	push   %ebx
80104a15:	8b 45 08             	mov    0x8(%ebp),%eax
80104a18:	8b 5d 0c             	mov    0xc(%ebp),%ebx
80104a1b:	8b 75 10             	mov    0x10(%ebp),%esi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
80104a1e:	39 c3                	cmp    %eax,%ebx
80104a20:	73 26                	jae    80104a48 <memmove+0x38>
80104a22:	8d 0c 33             	lea    (%ebx,%esi,1),%ecx
80104a25:	39 c8                	cmp    %ecx,%eax
80104a27:	73 1f                	jae    80104a48 <memmove+0x38>
    s += n;
    d += n;
    while(n-- > 0)
80104a29:	85 f6                	test   %esi,%esi
80104a2b:	8d 56 ff             	lea    -0x1(%esi),%edx
80104a2e:	74 0f                	je     80104a3f <memmove+0x2f>
      *--d = *--s;
80104a30:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
80104a34:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    while(n-- > 0)
80104a37:	83 ea 01             	sub    $0x1,%edx
80104a3a:	83 fa ff             	cmp    $0xffffffff,%edx
80104a3d:	75 f1                	jne    80104a30 <memmove+0x20>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
80104a3f:	5b                   	pop    %ebx
80104a40:	5e                   	pop    %esi
80104a41:	5d                   	pop    %ebp
80104a42:	c3                   	ret    
80104a43:	90                   	nop
80104a44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    while(n-- > 0)
80104a48:	31 d2                	xor    %edx,%edx
80104a4a:	85 f6                	test   %esi,%esi
80104a4c:	74 f1                	je     80104a3f <memmove+0x2f>
80104a4e:	66 90                	xchg   %ax,%ax
      *d++ = *s++;
80104a50:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
80104a54:	88 0c 10             	mov    %cl,(%eax,%edx,1)
80104a57:	83 c2 01             	add    $0x1,%edx
    while(n-- > 0)
80104a5a:	39 d6                	cmp    %edx,%esi
80104a5c:	75 f2                	jne    80104a50 <memmove+0x40>
}
80104a5e:	5b                   	pop    %ebx
80104a5f:	5e                   	pop    %esi
80104a60:	5d                   	pop    %ebp
80104a61:	c3                   	ret    
80104a62:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104a69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104a70 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
80104a70:	55                   	push   %ebp
80104a71:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
}
80104a73:	5d                   	pop    %ebp
  return memmove(dst, src, n);
80104a74:	eb 9a                	jmp    80104a10 <memmove>
80104a76:	8d 76 00             	lea    0x0(%esi),%esi
80104a79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104a80 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
80104a80:	55                   	push   %ebp
80104a81:	89 e5                	mov    %esp,%ebp
80104a83:	57                   	push   %edi
80104a84:	56                   	push   %esi
80104a85:	8b 7d 10             	mov    0x10(%ebp),%edi
80104a88:	53                   	push   %ebx
80104a89:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104a8c:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(n > 0 && *p && *p == *q)
80104a8f:	85 ff                	test   %edi,%edi
80104a91:	74 2f                	je     80104ac2 <strncmp+0x42>
80104a93:	0f b6 01             	movzbl (%ecx),%eax
80104a96:	0f b6 1e             	movzbl (%esi),%ebx
80104a99:	84 c0                	test   %al,%al
80104a9b:	74 37                	je     80104ad4 <strncmp+0x54>
80104a9d:	38 c3                	cmp    %al,%bl
80104a9f:	75 33                	jne    80104ad4 <strncmp+0x54>
80104aa1:	01 f7                	add    %esi,%edi
80104aa3:	eb 13                	jmp    80104ab8 <strncmp+0x38>
80104aa5:	8d 76 00             	lea    0x0(%esi),%esi
80104aa8:	0f b6 01             	movzbl (%ecx),%eax
80104aab:	84 c0                	test   %al,%al
80104aad:	74 21                	je     80104ad0 <strncmp+0x50>
80104aaf:	0f b6 1a             	movzbl (%edx),%ebx
80104ab2:	89 d6                	mov    %edx,%esi
80104ab4:	38 d8                	cmp    %bl,%al
80104ab6:	75 1c                	jne    80104ad4 <strncmp+0x54>
    n--, p++, q++;
80104ab8:	8d 56 01             	lea    0x1(%esi),%edx
80104abb:	83 c1 01             	add    $0x1,%ecx
  while(n > 0 && *p && *p == *q)
80104abe:	39 fa                	cmp    %edi,%edx
80104ac0:	75 e6                	jne    80104aa8 <strncmp+0x28>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
}
80104ac2:	5b                   	pop    %ebx
    return 0;
80104ac3:	31 c0                	xor    %eax,%eax
}
80104ac5:	5e                   	pop    %esi
80104ac6:	5f                   	pop    %edi
80104ac7:	5d                   	pop    %ebp
80104ac8:	c3                   	ret    
80104ac9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104ad0:	0f b6 5e 01          	movzbl 0x1(%esi),%ebx
  return (uchar)*p - (uchar)*q;
80104ad4:	29 d8                	sub    %ebx,%eax
}
80104ad6:	5b                   	pop    %ebx
80104ad7:	5e                   	pop    %esi
80104ad8:	5f                   	pop    %edi
80104ad9:	5d                   	pop    %ebp
80104ada:	c3                   	ret    
80104adb:	90                   	nop
80104adc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104ae0 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80104ae0:	55                   	push   %ebp
80104ae1:	89 e5                	mov    %esp,%ebp
80104ae3:	56                   	push   %esi
80104ae4:	53                   	push   %ebx
80104ae5:	8b 45 08             	mov    0x8(%ebp),%eax
80104ae8:	8b 5d 0c             	mov    0xc(%ebp),%ebx
80104aeb:	8b 4d 10             	mov    0x10(%ebp),%ecx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
80104aee:	89 c2                	mov    %eax,%edx
80104af0:	eb 19                	jmp    80104b0b <strncpy+0x2b>
80104af2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104af8:	83 c3 01             	add    $0x1,%ebx
80104afb:	0f b6 4b ff          	movzbl -0x1(%ebx),%ecx
80104aff:	83 c2 01             	add    $0x1,%edx
80104b02:	84 c9                	test   %cl,%cl
80104b04:	88 4a ff             	mov    %cl,-0x1(%edx)
80104b07:	74 09                	je     80104b12 <strncpy+0x32>
80104b09:	89 f1                	mov    %esi,%ecx
80104b0b:	85 c9                	test   %ecx,%ecx
80104b0d:	8d 71 ff             	lea    -0x1(%ecx),%esi
80104b10:	7f e6                	jg     80104af8 <strncpy+0x18>
    ;
  while(n-- > 0)
80104b12:	31 c9                	xor    %ecx,%ecx
80104b14:	85 f6                	test   %esi,%esi
80104b16:	7e 17                	jle    80104b2f <strncpy+0x4f>
80104b18:	90                   	nop
80104b19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    *s++ = 0;
80104b20:	c6 04 0a 00          	movb   $0x0,(%edx,%ecx,1)
80104b24:	89 f3                	mov    %esi,%ebx
80104b26:	83 c1 01             	add    $0x1,%ecx
80104b29:	29 cb                	sub    %ecx,%ebx
  while(n-- > 0)
80104b2b:	85 db                	test   %ebx,%ebx
80104b2d:	7f f1                	jg     80104b20 <strncpy+0x40>
  return os;
}
80104b2f:	5b                   	pop    %ebx
80104b30:	5e                   	pop    %esi
80104b31:	5d                   	pop    %ebp
80104b32:	c3                   	ret    
80104b33:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104b39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104b40 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80104b40:	55                   	push   %ebp
80104b41:	89 e5                	mov    %esp,%ebp
80104b43:	56                   	push   %esi
80104b44:	53                   	push   %ebx
80104b45:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104b48:	8b 45 08             	mov    0x8(%ebp),%eax
80104b4b:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  if(n <= 0)
80104b4e:	85 c9                	test   %ecx,%ecx
80104b50:	7e 26                	jle    80104b78 <safestrcpy+0x38>
80104b52:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
80104b56:	89 c1                	mov    %eax,%ecx
80104b58:	eb 17                	jmp    80104b71 <safestrcpy+0x31>
80104b5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80104b60:	83 c2 01             	add    $0x1,%edx
80104b63:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
80104b67:	83 c1 01             	add    $0x1,%ecx
80104b6a:	84 db                	test   %bl,%bl
80104b6c:	88 59 ff             	mov    %bl,-0x1(%ecx)
80104b6f:	74 04                	je     80104b75 <safestrcpy+0x35>
80104b71:	39 f2                	cmp    %esi,%edx
80104b73:	75 eb                	jne    80104b60 <safestrcpy+0x20>
    ;
  *s = 0;
80104b75:	c6 01 00             	movb   $0x0,(%ecx)
  return os;
}
80104b78:	5b                   	pop    %ebx
80104b79:	5e                   	pop    %esi
80104b7a:	5d                   	pop    %ebp
80104b7b:	c3                   	ret    
80104b7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104b80 <strlen>:

int
strlen(const char *s)
{
80104b80:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80104b81:	31 c0                	xor    %eax,%eax
{
80104b83:	89 e5                	mov    %esp,%ebp
80104b85:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
80104b88:	80 3a 00             	cmpb   $0x0,(%edx)
80104b8b:	74 0c                	je     80104b99 <strlen+0x19>
80104b8d:	8d 76 00             	lea    0x0(%esi),%esi
80104b90:	83 c0 01             	add    $0x1,%eax
80104b93:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80104b97:	75 f7                	jne    80104b90 <strlen+0x10>
    ;
  return n;
}
80104b99:	5d                   	pop    %ebp
80104b9a:	c3                   	ret    

80104b9b <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
80104b9b:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
80104b9f:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-saved registers
  pushl %ebp
80104ba3:	55                   	push   %ebp
  pushl %ebx
80104ba4:	53                   	push   %ebx
  pushl %esi
80104ba5:	56                   	push   %esi
  pushl %edi
80104ba6:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80104ba7:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
80104ba9:	89 d4                	mov    %edx,%esp

  # Load new callee-saved registers
  popl %edi
80104bab:	5f                   	pop    %edi
  popl %esi
80104bac:	5e                   	pop    %esi
  popl %ebx
80104bad:	5b                   	pop    %ebx
  popl %ebp
80104bae:	5d                   	pop    %ebp
  ret
80104baf:	c3                   	ret    

80104bb0 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80104bb0:	55                   	push   %ebp
80104bb1:	89 e5                	mov    %esp,%ebp
80104bb3:	53                   	push   %ebx
80104bb4:	83 ec 04             	sub    $0x4,%esp
80104bb7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
80104bba:	e8 91 eb ff ff       	call   80103750 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104bbf:	8b 00                	mov    (%eax),%eax
80104bc1:	39 d8                	cmp    %ebx,%eax
80104bc3:	76 1b                	jbe    80104be0 <fetchint+0x30>
80104bc5:	8d 53 04             	lea    0x4(%ebx),%edx
80104bc8:	39 d0                	cmp    %edx,%eax
80104bca:	72 14                	jb     80104be0 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
80104bcc:	8b 45 0c             	mov    0xc(%ebp),%eax
80104bcf:	8b 13                	mov    (%ebx),%edx
80104bd1:	89 10                	mov    %edx,(%eax)
  return 0;
80104bd3:	31 c0                	xor    %eax,%eax
}
80104bd5:	83 c4 04             	add    $0x4,%esp
80104bd8:	5b                   	pop    %ebx
80104bd9:	5d                   	pop    %ebp
80104bda:	c3                   	ret    
80104bdb:	90                   	nop
80104bdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104be0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104be5:	eb ee                	jmp    80104bd5 <fetchint+0x25>
80104be7:	89 f6                	mov    %esi,%esi
80104be9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104bf0 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80104bf0:	55                   	push   %ebp
80104bf1:	89 e5                	mov    %esp,%ebp
80104bf3:	53                   	push   %ebx
80104bf4:	83 ec 04             	sub    $0x4,%esp
80104bf7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
80104bfa:	e8 51 eb ff ff       	call   80103750 <myproc>

  if(addr >= curproc->sz)
80104bff:	39 18                	cmp    %ebx,(%eax)
80104c01:	76 29                	jbe    80104c2c <fetchstr+0x3c>
    return -1;
  *pp = (char*)addr;
80104c03:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80104c06:	89 da                	mov    %ebx,%edx
80104c08:	89 19                	mov    %ebx,(%ecx)
  ep = (char*)curproc->sz;
80104c0a:	8b 00                	mov    (%eax),%eax
  for(s = *pp; s < ep; s++){
80104c0c:	39 c3                	cmp    %eax,%ebx
80104c0e:	73 1c                	jae    80104c2c <fetchstr+0x3c>
    if(*s == 0)
80104c10:	80 3b 00             	cmpb   $0x0,(%ebx)
80104c13:	75 10                	jne    80104c25 <fetchstr+0x35>
80104c15:	eb 39                	jmp    80104c50 <fetchstr+0x60>
80104c17:	89 f6                	mov    %esi,%esi
80104c19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104c20:	80 3a 00             	cmpb   $0x0,(%edx)
80104c23:	74 1b                	je     80104c40 <fetchstr+0x50>
  for(s = *pp; s < ep; s++){
80104c25:	83 c2 01             	add    $0x1,%edx
80104c28:	39 d0                	cmp    %edx,%eax
80104c2a:	77 f4                	ja     80104c20 <fetchstr+0x30>
    return -1;
80104c2c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      return s - *pp;
  }
  return -1;
}
80104c31:	83 c4 04             	add    $0x4,%esp
80104c34:	5b                   	pop    %ebx
80104c35:	5d                   	pop    %ebp
80104c36:	c3                   	ret    
80104c37:	89 f6                	mov    %esi,%esi
80104c39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104c40:	83 c4 04             	add    $0x4,%esp
80104c43:	89 d0                	mov    %edx,%eax
80104c45:	29 d8                	sub    %ebx,%eax
80104c47:	5b                   	pop    %ebx
80104c48:	5d                   	pop    %ebp
80104c49:	c3                   	ret    
80104c4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(*s == 0)
80104c50:	31 c0                	xor    %eax,%eax
      return s - *pp;
80104c52:	eb dd                	jmp    80104c31 <fetchstr+0x41>
80104c54:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104c5a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104c60 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80104c60:	55                   	push   %ebp
80104c61:	89 e5                	mov    %esp,%ebp
80104c63:	56                   	push   %esi
80104c64:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104c65:	e8 e6 ea ff ff       	call   80103750 <myproc>
80104c6a:	8b 40 18             	mov    0x18(%eax),%eax
80104c6d:	8b 55 08             	mov    0x8(%ebp),%edx
80104c70:	8b 40 44             	mov    0x44(%eax),%eax
80104c73:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80104c76:	e8 d5 ea ff ff       	call   80103750 <myproc>
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104c7b:	8b 00                	mov    (%eax),%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104c7d:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104c80:	39 c6                	cmp    %eax,%esi
80104c82:	73 1c                	jae    80104ca0 <argint+0x40>
80104c84:	8d 53 08             	lea    0x8(%ebx),%edx
80104c87:	39 d0                	cmp    %edx,%eax
80104c89:	72 15                	jb     80104ca0 <argint+0x40>
  *ip = *(int*)(addr);
80104c8b:	8b 45 0c             	mov    0xc(%ebp),%eax
80104c8e:	8b 53 04             	mov    0x4(%ebx),%edx
80104c91:	89 10                	mov    %edx,(%eax)
  return 0;
80104c93:	31 c0                	xor    %eax,%eax
}
80104c95:	5b                   	pop    %ebx
80104c96:	5e                   	pop    %esi
80104c97:	5d                   	pop    %ebp
80104c98:	c3                   	ret    
80104c99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104ca0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104ca5:	eb ee                	jmp    80104c95 <argint+0x35>
80104ca7:	89 f6                	mov    %esi,%esi
80104ca9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104cb0 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80104cb0:	55                   	push   %ebp
80104cb1:	89 e5                	mov    %esp,%ebp
80104cb3:	56                   	push   %esi
80104cb4:	53                   	push   %ebx
80104cb5:	83 ec 10             	sub    $0x10,%esp
80104cb8:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int i;
  struct proc *curproc = myproc();
80104cbb:	e8 90 ea ff ff       	call   80103750 <myproc>
80104cc0:	89 c6                	mov    %eax,%esi
 
  if(argint(n, &i) < 0)
80104cc2:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104cc5:	83 ec 08             	sub    $0x8,%esp
80104cc8:	50                   	push   %eax
80104cc9:	ff 75 08             	pushl  0x8(%ebp)
80104ccc:	e8 8f ff ff ff       	call   80104c60 <argint>
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80104cd1:	83 c4 10             	add    $0x10,%esp
80104cd4:	85 c0                	test   %eax,%eax
80104cd6:	78 28                	js     80104d00 <argptr+0x50>
80104cd8:	85 db                	test   %ebx,%ebx
80104cda:	78 24                	js     80104d00 <argptr+0x50>
80104cdc:	8b 16                	mov    (%esi),%edx
80104cde:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104ce1:	39 c2                	cmp    %eax,%edx
80104ce3:	76 1b                	jbe    80104d00 <argptr+0x50>
80104ce5:	01 c3                	add    %eax,%ebx
80104ce7:	39 da                	cmp    %ebx,%edx
80104ce9:	72 15                	jb     80104d00 <argptr+0x50>
    return -1;
  *pp = (char*)i;
80104ceb:	8b 55 0c             	mov    0xc(%ebp),%edx
80104cee:	89 02                	mov    %eax,(%edx)
  return 0;
80104cf0:	31 c0                	xor    %eax,%eax
}
80104cf2:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104cf5:	5b                   	pop    %ebx
80104cf6:	5e                   	pop    %esi
80104cf7:	5d                   	pop    %ebp
80104cf8:	c3                   	ret    
80104cf9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104d00:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104d05:	eb eb                	jmp    80104cf2 <argptr+0x42>
80104d07:	89 f6                	mov    %esi,%esi
80104d09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104d10 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80104d10:	55                   	push   %ebp
80104d11:	89 e5                	mov    %esp,%ebp
80104d13:	83 ec 20             	sub    $0x20,%esp
  int addr;
  if(argint(n, &addr) < 0)
80104d16:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104d19:	50                   	push   %eax
80104d1a:	ff 75 08             	pushl  0x8(%ebp)
80104d1d:	e8 3e ff ff ff       	call   80104c60 <argint>
80104d22:	83 c4 10             	add    $0x10,%esp
80104d25:	85 c0                	test   %eax,%eax
80104d27:	78 17                	js     80104d40 <argstr+0x30>
    return -1;
  return fetchstr(addr, pp);
80104d29:	83 ec 08             	sub    $0x8,%esp
80104d2c:	ff 75 0c             	pushl  0xc(%ebp)
80104d2f:	ff 75 f4             	pushl  -0xc(%ebp)
80104d32:	e8 b9 fe ff ff       	call   80104bf0 <fetchstr>
80104d37:	83 c4 10             	add    $0x10,%esp
}
80104d3a:	c9                   	leave  
80104d3b:	c3                   	ret    
80104d3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104d40:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104d45:	c9                   	leave  
80104d46:	c3                   	ret    
80104d47:	89 f6                	mov    %esi,%esi
80104d49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104d50 <syscall>:
[SYS_sigret] sys_sigret
};

void
syscall(void)
{
80104d50:	55                   	push   %ebp
80104d51:	89 e5                	mov    %esp,%ebp
80104d53:	53                   	push   %ebx
80104d54:	83 ec 04             	sub    $0x4,%esp
  int num;
  struct proc *curproc = myproc();
80104d57:	e8 f4 e9 ff ff       	call   80103750 <myproc>
80104d5c:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
80104d5e:	8b 40 18             	mov    0x18(%eax),%eax
80104d61:	8b 40 1c             	mov    0x1c(%eax),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80104d64:	8d 50 ff             	lea    -0x1(%eax),%edx
80104d67:	83 fa 17             	cmp    $0x17,%edx
80104d6a:	77 1c                	ja     80104d88 <syscall+0x38>
80104d6c:	8b 14 85 20 7c 10 80 	mov    -0x7fef83e0(,%eax,4),%edx
80104d73:	85 d2                	test   %edx,%edx
80104d75:	74 11                	je     80104d88 <syscall+0x38>
    curproc->tf->eax = syscalls[num]();
80104d77:	ff d2                	call   *%edx
80104d79:	8b 53 18             	mov    0x18(%ebx),%edx
80104d7c:	89 42 1c             	mov    %eax,0x1c(%edx)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
80104d7f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104d82:	c9                   	leave  
80104d83:	c3                   	ret    
80104d84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("%d %s: unknown sys call %d\n",
80104d88:	50                   	push   %eax
            curproc->pid, curproc->name, num);
80104d89:	8d 43 6c             	lea    0x6c(%ebx),%eax
    cprintf("%d %s: unknown sys call %d\n",
80104d8c:	50                   	push   %eax
80104d8d:	ff 73 10             	pushl  0x10(%ebx)
80104d90:	68 e9 7b 10 80       	push   $0x80107be9
80104d95:	e8 c6 b8 ff ff       	call   80100660 <cprintf>
    curproc->tf->eax = -1;
80104d9a:	8b 43 18             	mov    0x18(%ebx),%eax
80104d9d:	83 c4 10             	add    $0x10,%esp
80104da0:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
80104da7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104daa:	c9                   	leave  
80104dab:	c3                   	ret    
80104dac:	66 90                	xchg   %ax,%ax
80104dae:	66 90                	xchg   %ax,%ax

80104db0 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104db0:	55                   	push   %ebp
80104db1:	89 e5                	mov    %esp,%ebp
80104db3:	57                   	push   %edi
80104db4:	56                   	push   %esi
80104db5:	53                   	push   %ebx
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104db6:	8d 75 da             	lea    -0x26(%ebp),%esi
{
80104db9:	83 ec 34             	sub    $0x34,%esp
80104dbc:	89 4d d0             	mov    %ecx,-0x30(%ebp)
80104dbf:	8b 4d 08             	mov    0x8(%ebp),%ecx
  if((dp = nameiparent(path, name)) == 0)
80104dc2:	56                   	push   %esi
80104dc3:	50                   	push   %eax
{
80104dc4:	89 55 d4             	mov    %edx,-0x2c(%ebp)
80104dc7:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  if((dp = nameiparent(path, name)) == 0)
80104dca:	e8 61 d1 ff ff       	call   80101f30 <nameiparent>
80104dcf:	83 c4 10             	add    $0x10,%esp
80104dd2:	85 c0                	test   %eax,%eax
80104dd4:	0f 84 46 01 00 00    	je     80104f20 <create+0x170>
    return 0;
  ilock(dp);
80104dda:	83 ec 0c             	sub    $0xc,%esp
80104ddd:	89 c3                	mov    %eax,%ebx
80104ddf:	50                   	push   %eax
80104de0:	e8 cb c8 ff ff       	call   801016b0 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
80104de5:	83 c4 0c             	add    $0xc,%esp
80104de8:	6a 00                	push   $0x0
80104dea:	56                   	push   %esi
80104deb:	53                   	push   %ebx
80104dec:	e8 ef cd ff ff       	call   80101be0 <dirlookup>
80104df1:	83 c4 10             	add    $0x10,%esp
80104df4:	85 c0                	test   %eax,%eax
80104df6:	89 c7                	mov    %eax,%edi
80104df8:	74 36                	je     80104e30 <create+0x80>
    iunlockput(dp);
80104dfa:	83 ec 0c             	sub    $0xc,%esp
80104dfd:	53                   	push   %ebx
80104dfe:	e8 3d cb ff ff       	call   80101940 <iunlockput>
    ilock(ip);
80104e03:	89 3c 24             	mov    %edi,(%esp)
80104e06:	e8 a5 c8 ff ff       	call   801016b0 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
80104e0b:	83 c4 10             	add    $0x10,%esp
80104e0e:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
80104e13:	0f 85 97 00 00 00    	jne    80104eb0 <create+0x100>
80104e19:	66 83 7f 50 02       	cmpw   $0x2,0x50(%edi)
80104e1e:	0f 85 8c 00 00 00    	jne    80104eb0 <create+0x100>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104e24:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104e27:	89 f8                	mov    %edi,%eax
80104e29:	5b                   	pop    %ebx
80104e2a:	5e                   	pop    %esi
80104e2b:	5f                   	pop    %edi
80104e2c:	5d                   	pop    %ebp
80104e2d:	c3                   	ret    
80104e2e:	66 90                	xchg   %ax,%ax
  if((ip = ialloc(dp->dev, type)) == 0)
80104e30:	0f bf 45 d4          	movswl -0x2c(%ebp),%eax
80104e34:	83 ec 08             	sub    $0x8,%esp
80104e37:	50                   	push   %eax
80104e38:	ff 33                	pushl  (%ebx)
80104e3a:	e8 01 c7 ff ff       	call   80101540 <ialloc>
80104e3f:	83 c4 10             	add    $0x10,%esp
80104e42:	85 c0                	test   %eax,%eax
80104e44:	89 c7                	mov    %eax,%edi
80104e46:	0f 84 e8 00 00 00    	je     80104f34 <create+0x184>
  ilock(ip);
80104e4c:	83 ec 0c             	sub    $0xc,%esp
80104e4f:	50                   	push   %eax
80104e50:	e8 5b c8 ff ff       	call   801016b0 <ilock>
  ip->major = major;
80104e55:	0f b7 45 d0          	movzwl -0x30(%ebp),%eax
80104e59:	66 89 47 52          	mov    %ax,0x52(%edi)
  ip->minor = minor;
80104e5d:	0f b7 45 cc          	movzwl -0x34(%ebp),%eax
80104e61:	66 89 47 54          	mov    %ax,0x54(%edi)
  ip->nlink = 1;
80104e65:	b8 01 00 00 00       	mov    $0x1,%eax
80104e6a:	66 89 47 56          	mov    %ax,0x56(%edi)
  iupdate(ip);
80104e6e:	89 3c 24             	mov    %edi,(%esp)
80104e71:	e8 8a c7 ff ff       	call   80101600 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
80104e76:	83 c4 10             	add    $0x10,%esp
80104e79:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
80104e7e:	74 50                	je     80104ed0 <create+0x120>
  if(dirlink(dp, name, ip->inum) < 0)
80104e80:	83 ec 04             	sub    $0x4,%esp
80104e83:	ff 77 04             	pushl  0x4(%edi)
80104e86:	56                   	push   %esi
80104e87:	53                   	push   %ebx
80104e88:	e8 c3 cf ff ff       	call   80101e50 <dirlink>
80104e8d:	83 c4 10             	add    $0x10,%esp
80104e90:	85 c0                	test   %eax,%eax
80104e92:	0f 88 8f 00 00 00    	js     80104f27 <create+0x177>
  iunlockput(dp);
80104e98:	83 ec 0c             	sub    $0xc,%esp
80104e9b:	53                   	push   %ebx
80104e9c:	e8 9f ca ff ff       	call   80101940 <iunlockput>
  return ip;
80104ea1:	83 c4 10             	add    $0x10,%esp
}
80104ea4:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104ea7:	89 f8                	mov    %edi,%eax
80104ea9:	5b                   	pop    %ebx
80104eaa:	5e                   	pop    %esi
80104eab:	5f                   	pop    %edi
80104eac:	5d                   	pop    %ebp
80104ead:	c3                   	ret    
80104eae:	66 90                	xchg   %ax,%ax
    iunlockput(ip);
80104eb0:	83 ec 0c             	sub    $0xc,%esp
80104eb3:	57                   	push   %edi
    return 0;
80104eb4:	31 ff                	xor    %edi,%edi
    iunlockput(ip);
80104eb6:	e8 85 ca ff ff       	call   80101940 <iunlockput>
    return 0;
80104ebb:	83 c4 10             	add    $0x10,%esp
}
80104ebe:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104ec1:	89 f8                	mov    %edi,%eax
80104ec3:	5b                   	pop    %ebx
80104ec4:	5e                   	pop    %esi
80104ec5:	5f                   	pop    %edi
80104ec6:	5d                   	pop    %ebp
80104ec7:	c3                   	ret    
80104ec8:	90                   	nop
80104ec9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    dp->nlink++;  // for ".."
80104ed0:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
    iupdate(dp);
80104ed5:	83 ec 0c             	sub    $0xc,%esp
80104ed8:	53                   	push   %ebx
80104ed9:	e8 22 c7 ff ff       	call   80101600 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80104ede:	83 c4 0c             	add    $0xc,%esp
80104ee1:	ff 77 04             	pushl  0x4(%edi)
80104ee4:	68 a0 7c 10 80       	push   $0x80107ca0
80104ee9:	57                   	push   %edi
80104eea:	e8 61 cf ff ff       	call   80101e50 <dirlink>
80104eef:	83 c4 10             	add    $0x10,%esp
80104ef2:	85 c0                	test   %eax,%eax
80104ef4:	78 1c                	js     80104f12 <create+0x162>
80104ef6:	83 ec 04             	sub    $0x4,%esp
80104ef9:	ff 73 04             	pushl  0x4(%ebx)
80104efc:	68 9f 7c 10 80       	push   $0x80107c9f
80104f01:	57                   	push   %edi
80104f02:	e8 49 cf ff ff       	call   80101e50 <dirlink>
80104f07:	83 c4 10             	add    $0x10,%esp
80104f0a:	85 c0                	test   %eax,%eax
80104f0c:	0f 89 6e ff ff ff    	jns    80104e80 <create+0xd0>
      panic("create dots");
80104f12:	83 ec 0c             	sub    $0xc,%esp
80104f15:	68 93 7c 10 80       	push   $0x80107c93
80104f1a:	e8 71 b4 ff ff       	call   80100390 <panic>
80104f1f:	90                   	nop
    return 0;
80104f20:	31 ff                	xor    %edi,%edi
80104f22:	e9 fd fe ff ff       	jmp    80104e24 <create+0x74>
    panic("create: dirlink");
80104f27:	83 ec 0c             	sub    $0xc,%esp
80104f2a:	68 a2 7c 10 80       	push   $0x80107ca2
80104f2f:	e8 5c b4 ff ff       	call   80100390 <panic>
    panic("create: ialloc");
80104f34:	83 ec 0c             	sub    $0xc,%esp
80104f37:	68 84 7c 10 80       	push   $0x80107c84
80104f3c:	e8 4f b4 ff ff       	call   80100390 <panic>
80104f41:	eb 0d                	jmp    80104f50 <argfd.constprop.0>
80104f43:	90                   	nop
80104f44:	90                   	nop
80104f45:	90                   	nop
80104f46:	90                   	nop
80104f47:	90                   	nop
80104f48:	90                   	nop
80104f49:	90                   	nop
80104f4a:	90                   	nop
80104f4b:	90                   	nop
80104f4c:	90                   	nop
80104f4d:	90                   	nop
80104f4e:	90                   	nop
80104f4f:	90                   	nop

80104f50 <argfd.constprop.0>:
argfd(int n, int *pfd, struct file **pf)
80104f50:	55                   	push   %ebp
80104f51:	89 e5                	mov    %esp,%ebp
80104f53:	56                   	push   %esi
80104f54:	53                   	push   %ebx
80104f55:	89 c3                	mov    %eax,%ebx
  if(argint(n, &fd) < 0)
80104f57:	8d 45 f4             	lea    -0xc(%ebp),%eax
argfd(int n, int *pfd, struct file **pf)
80104f5a:	89 d6                	mov    %edx,%esi
80104f5c:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80104f5f:	50                   	push   %eax
80104f60:	6a 00                	push   $0x0
80104f62:	e8 f9 fc ff ff       	call   80104c60 <argint>
80104f67:	83 c4 10             	add    $0x10,%esp
80104f6a:	85 c0                	test   %eax,%eax
80104f6c:	78 2a                	js     80104f98 <argfd.constprop.0+0x48>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80104f6e:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80104f72:	77 24                	ja     80104f98 <argfd.constprop.0+0x48>
80104f74:	e8 d7 e7 ff ff       	call   80103750 <myproc>
80104f79:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104f7c:	8b 44 90 28          	mov    0x28(%eax,%edx,4),%eax
80104f80:	85 c0                	test   %eax,%eax
80104f82:	74 14                	je     80104f98 <argfd.constprop.0+0x48>
  if(pfd)
80104f84:	85 db                	test   %ebx,%ebx
80104f86:	74 02                	je     80104f8a <argfd.constprop.0+0x3a>
    *pfd = fd;
80104f88:	89 13                	mov    %edx,(%ebx)
    *pf = f;
80104f8a:	89 06                	mov    %eax,(%esi)
  return 0;
80104f8c:	31 c0                	xor    %eax,%eax
}
80104f8e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104f91:	5b                   	pop    %ebx
80104f92:	5e                   	pop    %esi
80104f93:	5d                   	pop    %ebp
80104f94:	c3                   	ret    
80104f95:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80104f98:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104f9d:	eb ef                	jmp    80104f8e <argfd.constprop.0+0x3e>
80104f9f:	90                   	nop

80104fa0 <sys_dup>:
{
80104fa0:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0)
80104fa1:	31 c0                	xor    %eax,%eax
{
80104fa3:	89 e5                	mov    %esp,%ebp
80104fa5:	56                   	push   %esi
80104fa6:	53                   	push   %ebx
  if(argfd(0, 0, &f) < 0)
80104fa7:	8d 55 f4             	lea    -0xc(%ebp),%edx
{
80104faa:	83 ec 10             	sub    $0x10,%esp
  if(argfd(0, 0, &f) < 0)
80104fad:	e8 9e ff ff ff       	call   80104f50 <argfd.constprop.0>
80104fb2:	85 c0                	test   %eax,%eax
80104fb4:	78 42                	js     80104ff8 <sys_dup+0x58>
  if((fd=fdalloc(f)) < 0)
80104fb6:	8b 75 f4             	mov    -0xc(%ebp),%esi
  for(fd = 0; fd < NOFILE; fd++){
80104fb9:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
80104fbb:	e8 90 e7 ff ff       	call   80103750 <myproc>
80104fc0:	eb 0e                	jmp    80104fd0 <sys_dup+0x30>
80104fc2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(fd = 0; fd < NOFILE; fd++){
80104fc8:	83 c3 01             	add    $0x1,%ebx
80104fcb:	83 fb 10             	cmp    $0x10,%ebx
80104fce:	74 28                	je     80104ff8 <sys_dup+0x58>
    if(curproc->ofile[fd] == 0){
80104fd0:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80104fd4:	85 d2                	test   %edx,%edx
80104fd6:	75 f0                	jne    80104fc8 <sys_dup+0x28>
      curproc->ofile[fd] = f;
80104fd8:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
  filedup(f);
80104fdc:	83 ec 0c             	sub    $0xc,%esp
80104fdf:	ff 75 f4             	pushl  -0xc(%ebp)
80104fe2:	e8 39 be ff ff       	call   80100e20 <filedup>
  return fd;
80104fe7:	83 c4 10             	add    $0x10,%esp
}
80104fea:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104fed:	89 d8                	mov    %ebx,%eax
80104fef:	5b                   	pop    %ebx
80104ff0:	5e                   	pop    %esi
80104ff1:	5d                   	pop    %ebp
80104ff2:	c3                   	ret    
80104ff3:	90                   	nop
80104ff4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104ff8:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return -1;
80104ffb:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
80105000:	89 d8                	mov    %ebx,%eax
80105002:	5b                   	pop    %ebx
80105003:	5e                   	pop    %esi
80105004:	5d                   	pop    %ebp
80105005:	c3                   	ret    
80105006:	8d 76 00             	lea    0x0(%esi),%esi
80105009:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105010 <sys_read>:
{
80105010:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105011:	31 c0                	xor    %eax,%eax
{
80105013:	89 e5                	mov    %esp,%ebp
80105015:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105018:	8d 55 ec             	lea    -0x14(%ebp),%edx
8010501b:	e8 30 ff ff ff       	call   80104f50 <argfd.constprop.0>
80105020:	85 c0                	test   %eax,%eax
80105022:	78 4c                	js     80105070 <sys_read+0x60>
80105024:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105027:	83 ec 08             	sub    $0x8,%esp
8010502a:	50                   	push   %eax
8010502b:	6a 02                	push   $0x2
8010502d:	e8 2e fc ff ff       	call   80104c60 <argint>
80105032:	83 c4 10             	add    $0x10,%esp
80105035:	85 c0                	test   %eax,%eax
80105037:	78 37                	js     80105070 <sys_read+0x60>
80105039:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010503c:	83 ec 04             	sub    $0x4,%esp
8010503f:	ff 75 f0             	pushl  -0x10(%ebp)
80105042:	50                   	push   %eax
80105043:	6a 01                	push   $0x1
80105045:	e8 66 fc ff ff       	call   80104cb0 <argptr>
8010504a:	83 c4 10             	add    $0x10,%esp
8010504d:	85 c0                	test   %eax,%eax
8010504f:	78 1f                	js     80105070 <sys_read+0x60>
  return fileread(f, p, n);
80105051:	83 ec 04             	sub    $0x4,%esp
80105054:	ff 75 f0             	pushl  -0x10(%ebp)
80105057:	ff 75 f4             	pushl  -0xc(%ebp)
8010505a:	ff 75 ec             	pushl  -0x14(%ebp)
8010505d:	e8 2e bf ff ff       	call   80100f90 <fileread>
80105062:	83 c4 10             	add    $0x10,%esp
}
80105065:	c9                   	leave  
80105066:	c3                   	ret    
80105067:	89 f6                	mov    %esi,%esi
80105069:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80105070:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105075:	c9                   	leave  
80105076:	c3                   	ret    
80105077:	89 f6                	mov    %esi,%esi
80105079:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105080 <sys_write>:
{
80105080:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105081:	31 c0                	xor    %eax,%eax
{
80105083:	89 e5                	mov    %esp,%ebp
80105085:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105088:	8d 55 ec             	lea    -0x14(%ebp),%edx
8010508b:	e8 c0 fe ff ff       	call   80104f50 <argfd.constprop.0>
80105090:	85 c0                	test   %eax,%eax
80105092:	78 4c                	js     801050e0 <sys_write+0x60>
80105094:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105097:	83 ec 08             	sub    $0x8,%esp
8010509a:	50                   	push   %eax
8010509b:	6a 02                	push   $0x2
8010509d:	e8 be fb ff ff       	call   80104c60 <argint>
801050a2:	83 c4 10             	add    $0x10,%esp
801050a5:	85 c0                	test   %eax,%eax
801050a7:	78 37                	js     801050e0 <sys_write+0x60>
801050a9:	8d 45 f4             	lea    -0xc(%ebp),%eax
801050ac:	83 ec 04             	sub    $0x4,%esp
801050af:	ff 75 f0             	pushl  -0x10(%ebp)
801050b2:	50                   	push   %eax
801050b3:	6a 01                	push   $0x1
801050b5:	e8 f6 fb ff ff       	call   80104cb0 <argptr>
801050ba:	83 c4 10             	add    $0x10,%esp
801050bd:	85 c0                	test   %eax,%eax
801050bf:	78 1f                	js     801050e0 <sys_write+0x60>
  return filewrite(f, p, n);
801050c1:	83 ec 04             	sub    $0x4,%esp
801050c4:	ff 75 f0             	pushl  -0x10(%ebp)
801050c7:	ff 75 f4             	pushl  -0xc(%ebp)
801050ca:	ff 75 ec             	pushl  -0x14(%ebp)
801050cd:	e8 4e bf ff ff       	call   80101020 <filewrite>
801050d2:	83 c4 10             	add    $0x10,%esp
}
801050d5:	c9                   	leave  
801050d6:	c3                   	ret    
801050d7:	89 f6                	mov    %esi,%esi
801050d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
801050e0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801050e5:	c9                   	leave  
801050e6:	c3                   	ret    
801050e7:	89 f6                	mov    %esi,%esi
801050e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801050f0 <sys_close>:
{
801050f0:	55                   	push   %ebp
801050f1:	89 e5                	mov    %esp,%ebp
801050f3:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, &fd, &f) < 0)
801050f6:	8d 55 f4             	lea    -0xc(%ebp),%edx
801050f9:	8d 45 f0             	lea    -0x10(%ebp),%eax
801050fc:	e8 4f fe ff ff       	call   80104f50 <argfd.constprop.0>
80105101:	85 c0                	test   %eax,%eax
80105103:	78 2b                	js     80105130 <sys_close+0x40>
  myproc()->ofile[fd] = 0;
80105105:	e8 46 e6 ff ff       	call   80103750 <myproc>
8010510a:	8b 55 f0             	mov    -0x10(%ebp),%edx
  fileclose(f);
8010510d:	83 ec 0c             	sub    $0xc,%esp
  myproc()->ofile[fd] = 0;
80105110:	c7 44 90 28 00 00 00 	movl   $0x0,0x28(%eax,%edx,4)
80105117:	00 
  fileclose(f);
80105118:	ff 75 f4             	pushl  -0xc(%ebp)
8010511b:	e8 50 bd ff ff       	call   80100e70 <fileclose>
  return 0;
80105120:	83 c4 10             	add    $0x10,%esp
80105123:	31 c0                	xor    %eax,%eax
}
80105125:	c9                   	leave  
80105126:	c3                   	ret    
80105127:	89 f6                	mov    %esi,%esi
80105129:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80105130:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105135:	c9                   	leave  
80105136:	c3                   	ret    
80105137:	89 f6                	mov    %esi,%esi
80105139:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105140 <sys_fstat>:
{
80105140:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80105141:	31 c0                	xor    %eax,%eax
{
80105143:	89 e5                	mov    %esp,%ebp
80105145:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80105148:	8d 55 f0             	lea    -0x10(%ebp),%edx
8010514b:	e8 00 fe ff ff       	call   80104f50 <argfd.constprop.0>
80105150:	85 c0                	test   %eax,%eax
80105152:	78 2c                	js     80105180 <sys_fstat+0x40>
80105154:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105157:	83 ec 04             	sub    $0x4,%esp
8010515a:	6a 14                	push   $0x14
8010515c:	50                   	push   %eax
8010515d:	6a 01                	push   $0x1
8010515f:	e8 4c fb ff ff       	call   80104cb0 <argptr>
80105164:	83 c4 10             	add    $0x10,%esp
80105167:	85 c0                	test   %eax,%eax
80105169:	78 15                	js     80105180 <sys_fstat+0x40>
  return filestat(f, st);
8010516b:	83 ec 08             	sub    $0x8,%esp
8010516e:	ff 75 f4             	pushl  -0xc(%ebp)
80105171:	ff 75 f0             	pushl  -0x10(%ebp)
80105174:	e8 c7 bd ff ff       	call   80100f40 <filestat>
80105179:	83 c4 10             	add    $0x10,%esp
}
8010517c:	c9                   	leave  
8010517d:	c3                   	ret    
8010517e:	66 90                	xchg   %ax,%ax
    return -1;
80105180:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105185:	c9                   	leave  
80105186:	c3                   	ret    
80105187:	89 f6                	mov    %esi,%esi
80105189:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105190 <sys_link>:
{
80105190:	55                   	push   %ebp
80105191:	89 e5                	mov    %esp,%ebp
80105193:	57                   	push   %edi
80105194:	56                   	push   %esi
80105195:	53                   	push   %ebx
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80105196:	8d 45 d4             	lea    -0x2c(%ebp),%eax
{
80105199:	83 ec 34             	sub    $0x34,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
8010519c:	50                   	push   %eax
8010519d:	6a 00                	push   $0x0
8010519f:	e8 6c fb ff ff       	call   80104d10 <argstr>
801051a4:	83 c4 10             	add    $0x10,%esp
801051a7:	85 c0                	test   %eax,%eax
801051a9:	0f 88 fb 00 00 00    	js     801052aa <sys_link+0x11a>
801051af:	8d 45 d0             	lea    -0x30(%ebp),%eax
801051b2:	83 ec 08             	sub    $0x8,%esp
801051b5:	50                   	push   %eax
801051b6:	6a 01                	push   $0x1
801051b8:	e8 53 fb ff ff       	call   80104d10 <argstr>
801051bd:	83 c4 10             	add    $0x10,%esp
801051c0:	85 c0                	test   %eax,%eax
801051c2:	0f 88 e2 00 00 00    	js     801052aa <sys_link+0x11a>
  begin_op();
801051c8:	e8 03 da ff ff       	call   80102bd0 <begin_op>
  if((ip = namei(old)) == 0){
801051cd:	83 ec 0c             	sub    $0xc,%esp
801051d0:	ff 75 d4             	pushl  -0x2c(%ebp)
801051d3:	e8 38 cd ff ff       	call   80101f10 <namei>
801051d8:	83 c4 10             	add    $0x10,%esp
801051db:	85 c0                	test   %eax,%eax
801051dd:	89 c3                	mov    %eax,%ebx
801051df:	0f 84 ea 00 00 00    	je     801052cf <sys_link+0x13f>
  ilock(ip);
801051e5:	83 ec 0c             	sub    $0xc,%esp
801051e8:	50                   	push   %eax
801051e9:	e8 c2 c4 ff ff       	call   801016b0 <ilock>
  if(ip->type == T_DIR){
801051ee:	83 c4 10             	add    $0x10,%esp
801051f1:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801051f6:	0f 84 bb 00 00 00    	je     801052b7 <sys_link+0x127>
  ip->nlink++;
801051fc:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  iupdate(ip);
80105201:	83 ec 0c             	sub    $0xc,%esp
  if((dp = nameiparent(new, name)) == 0)
80105204:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
80105207:	53                   	push   %ebx
80105208:	e8 f3 c3 ff ff       	call   80101600 <iupdate>
  iunlock(ip);
8010520d:	89 1c 24             	mov    %ebx,(%esp)
80105210:	e8 7b c5 ff ff       	call   80101790 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
80105215:	58                   	pop    %eax
80105216:	5a                   	pop    %edx
80105217:	57                   	push   %edi
80105218:	ff 75 d0             	pushl  -0x30(%ebp)
8010521b:	e8 10 cd ff ff       	call   80101f30 <nameiparent>
80105220:	83 c4 10             	add    $0x10,%esp
80105223:	85 c0                	test   %eax,%eax
80105225:	89 c6                	mov    %eax,%esi
80105227:	74 5b                	je     80105284 <sys_link+0xf4>
  ilock(dp);
80105229:	83 ec 0c             	sub    $0xc,%esp
8010522c:	50                   	push   %eax
8010522d:	e8 7e c4 ff ff       	call   801016b0 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80105232:	83 c4 10             	add    $0x10,%esp
80105235:	8b 03                	mov    (%ebx),%eax
80105237:	39 06                	cmp    %eax,(%esi)
80105239:	75 3d                	jne    80105278 <sys_link+0xe8>
8010523b:	83 ec 04             	sub    $0x4,%esp
8010523e:	ff 73 04             	pushl  0x4(%ebx)
80105241:	57                   	push   %edi
80105242:	56                   	push   %esi
80105243:	e8 08 cc ff ff       	call   80101e50 <dirlink>
80105248:	83 c4 10             	add    $0x10,%esp
8010524b:	85 c0                	test   %eax,%eax
8010524d:	78 29                	js     80105278 <sys_link+0xe8>
  iunlockput(dp);
8010524f:	83 ec 0c             	sub    $0xc,%esp
80105252:	56                   	push   %esi
80105253:	e8 e8 c6 ff ff       	call   80101940 <iunlockput>
  iput(ip);
80105258:	89 1c 24             	mov    %ebx,(%esp)
8010525b:	e8 80 c5 ff ff       	call   801017e0 <iput>
  end_op();
80105260:	e8 db d9 ff ff       	call   80102c40 <end_op>
  return 0;
80105265:	83 c4 10             	add    $0x10,%esp
80105268:	31 c0                	xor    %eax,%eax
}
8010526a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010526d:	5b                   	pop    %ebx
8010526e:	5e                   	pop    %esi
8010526f:	5f                   	pop    %edi
80105270:	5d                   	pop    %ebp
80105271:	c3                   	ret    
80105272:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(dp);
80105278:	83 ec 0c             	sub    $0xc,%esp
8010527b:	56                   	push   %esi
8010527c:	e8 bf c6 ff ff       	call   80101940 <iunlockput>
    goto bad;
80105281:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80105284:	83 ec 0c             	sub    $0xc,%esp
80105287:	53                   	push   %ebx
80105288:	e8 23 c4 ff ff       	call   801016b0 <ilock>
  ip->nlink--;
8010528d:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105292:	89 1c 24             	mov    %ebx,(%esp)
80105295:	e8 66 c3 ff ff       	call   80101600 <iupdate>
  iunlockput(ip);
8010529a:	89 1c 24             	mov    %ebx,(%esp)
8010529d:	e8 9e c6 ff ff       	call   80101940 <iunlockput>
  end_op();
801052a2:	e8 99 d9 ff ff       	call   80102c40 <end_op>
  return -1;
801052a7:	83 c4 10             	add    $0x10,%esp
}
801052aa:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
801052ad:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801052b2:	5b                   	pop    %ebx
801052b3:	5e                   	pop    %esi
801052b4:	5f                   	pop    %edi
801052b5:	5d                   	pop    %ebp
801052b6:	c3                   	ret    
    iunlockput(ip);
801052b7:	83 ec 0c             	sub    $0xc,%esp
801052ba:	53                   	push   %ebx
801052bb:	e8 80 c6 ff ff       	call   80101940 <iunlockput>
    end_op();
801052c0:	e8 7b d9 ff ff       	call   80102c40 <end_op>
    return -1;
801052c5:	83 c4 10             	add    $0x10,%esp
801052c8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801052cd:	eb 9b                	jmp    8010526a <sys_link+0xda>
    end_op();
801052cf:	e8 6c d9 ff ff       	call   80102c40 <end_op>
    return -1;
801052d4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801052d9:	eb 8f                	jmp    8010526a <sys_link+0xda>
801052db:	90                   	nop
801052dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801052e0 <sys_unlink>:
{
801052e0:	55                   	push   %ebp
801052e1:	89 e5                	mov    %esp,%ebp
801052e3:	57                   	push   %edi
801052e4:	56                   	push   %esi
801052e5:	53                   	push   %ebx
  if(argstr(0, &path) < 0)
801052e6:	8d 45 c0             	lea    -0x40(%ebp),%eax
{
801052e9:	83 ec 44             	sub    $0x44,%esp
  if(argstr(0, &path) < 0)
801052ec:	50                   	push   %eax
801052ed:	6a 00                	push   $0x0
801052ef:	e8 1c fa ff ff       	call   80104d10 <argstr>
801052f4:	83 c4 10             	add    $0x10,%esp
801052f7:	85 c0                	test   %eax,%eax
801052f9:	0f 88 77 01 00 00    	js     80105476 <sys_unlink+0x196>
  if((dp = nameiparent(path, name)) == 0){
801052ff:	8d 5d ca             	lea    -0x36(%ebp),%ebx
  begin_op();
80105302:	e8 c9 d8 ff ff       	call   80102bd0 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80105307:	83 ec 08             	sub    $0x8,%esp
8010530a:	53                   	push   %ebx
8010530b:	ff 75 c0             	pushl  -0x40(%ebp)
8010530e:	e8 1d cc ff ff       	call   80101f30 <nameiparent>
80105313:	83 c4 10             	add    $0x10,%esp
80105316:	85 c0                	test   %eax,%eax
80105318:	89 c6                	mov    %eax,%esi
8010531a:	0f 84 60 01 00 00    	je     80105480 <sys_unlink+0x1a0>
  ilock(dp);
80105320:	83 ec 0c             	sub    $0xc,%esp
80105323:	50                   	push   %eax
80105324:	e8 87 c3 ff ff       	call   801016b0 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
80105329:	58                   	pop    %eax
8010532a:	5a                   	pop    %edx
8010532b:	68 a0 7c 10 80       	push   $0x80107ca0
80105330:	53                   	push   %ebx
80105331:	e8 8a c8 ff ff       	call   80101bc0 <namecmp>
80105336:	83 c4 10             	add    $0x10,%esp
80105339:	85 c0                	test   %eax,%eax
8010533b:	0f 84 03 01 00 00    	je     80105444 <sys_unlink+0x164>
80105341:	83 ec 08             	sub    $0x8,%esp
80105344:	68 9f 7c 10 80       	push   $0x80107c9f
80105349:	53                   	push   %ebx
8010534a:	e8 71 c8 ff ff       	call   80101bc0 <namecmp>
8010534f:	83 c4 10             	add    $0x10,%esp
80105352:	85 c0                	test   %eax,%eax
80105354:	0f 84 ea 00 00 00    	je     80105444 <sys_unlink+0x164>
  if((ip = dirlookup(dp, name, &off)) == 0)
8010535a:	8d 45 c4             	lea    -0x3c(%ebp),%eax
8010535d:	83 ec 04             	sub    $0x4,%esp
80105360:	50                   	push   %eax
80105361:	53                   	push   %ebx
80105362:	56                   	push   %esi
80105363:	e8 78 c8 ff ff       	call   80101be0 <dirlookup>
80105368:	83 c4 10             	add    $0x10,%esp
8010536b:	85 c0                	test   %eax,%eax
8010536d:	89 c3                	mov    %eax,%ebx
8010536f:	0f 84 cf 00 00 00    	je     80105444 <sys_unlink+0x164>
  ilock(ip);
80105375:	83 ec 0c             	sub    $0xc,%esp
80105378:	50                   	push   %eax
80105379:	e8 32 c3 ff ff       	call   801016b0 <ilock>
  if(ip->nlink < 1)
8010537e:	83 c4 10             	add    $0x10,%esp
80105381:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80105386:	0f 8e 10 01 00 00    	jle    8010549c <sys_unlink+0x1bc>
  if(ip->type == T_DIR && !isdirempty(ip)){
8010538c:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105391:	74 6d                	je     80105400 <sys_unlink+0x120>
  memset(&de, 0, sizeof(de));
80105393:	8d 45 d8             	lea    -0x28(%ebp),%eax
80105396:	83 ec 04             	sub    $0x4,%esp
80105399:	6a 10                	push   $0x10
8010539b:	6a 00                	push   $0x0
8010539d:	50                   	push   %eax
8010539e:	e8 bd f5 ff ff       	call   80104960 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801053a3:	8d 45 d8             	lea    -0x28(%ebp),%eax
801053a6:	6a 10                	push   $0x10
801053a8:	ff 75 c4             	pushl  -0x3c(%ebp)
801053ab:	50                   	push   %eax
801053ac:	56                   	push   %esi
801053ad:	e8 de c6 ff ff       	call   80101a90 <writei>
801053b2:	83 c4 20             	add    $0x20,%esp
801053b5:	83 f8 10             	cmp    $0x10,%eax
801053b8:	0f 85 eb 00 00 00    	jne    801054a9 <sys_unlink+0x1c9>
  if(ip->type == T_DIR){
801053be:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801053c3:	0f 84 97 00 00 00    	je     80105460 <sys_unlink+0x180>
  iunlockput(dp);
801053c9:	83 ec 0c             	sub    $0xc,%esp
801053cc:	56                   	push   %esi
801053cd:	e8 6e c5 ff ff       	call   80101940 <iunlockput>
  ip->nlink--;
801053d2:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
801053d7:	89 1c 24             	mov    %ebx,(%esp)
801053da:	e8 21 c2 ff ff       	call   80101600 <iupdate>
  iunlockput(ip);
801053df:	89 1c 24             	mov    %ebx,(%esp)
801053e2:	e8 59 c5 ff ff       	call   80101940 <iunlockput>
  end_op();
801053e7:	e8 54 d8 ff ff       	call   80102c40 <end_op>
  return 0;
801053ec:	83 c4 10             	add    $0x10,%esp
801053ef:	31 c0                	xor    %eax,%eax
}
801053f1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801053f4:	5b                   	pop    %ebx
801053f5:	5e                   	pop    %esi
801053f6:	5f                   	pop    %edi
801053f7:	5d                   	pop    %ebp
801053f8:	c3                   	ret    
801053f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105400:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
80105404:	76 8d                	jbe    80105393 <sys_unlink+0xb3>
80105406:	bf 20 00 00 00       	mov    $0x20,%edi
8010540b:	eb 0f                	jmp    8010541c <sys_unlink+0x13c>
8010540d:	8d 76 00             	lea    0x0(%esi),%esi
80105410:	83 c7 10             	add    $0x10,%edi
80105413:	3b 7b 58             	cmp    0x58(%ebx),%edi
80105416:	0f 83 77 ff ff ff    	jae    80105393 <sys_unlink+0xb3>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
8010541c:	8d 45 d8             	lea    -0x28(%ebp),%eax
8010541f:	6a 10                	push   $0x10
80105421:	57                   	push   %edi
80105422:	50                   	push   %eax
80105423:	53                   	push   %ebx
80105424:	e8 67 c5 ff ff       	call   80101990 <readi>
80105429:	83 c4 10             	add    $0x10,%esp
8010542c:	83 f8 10             	cmp    $0x10,%eax
8010542f:	75 5e                	jne    8010548f <sys_unlink+0x1af>
    if(de.inum != 0)
80105431:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80105436:	74 d8                	je     80105410 <sys_unlink+0x130>
    iunlockput(ip);
80105438:	83 ec 0c             	sub    $0xc,%esp
8010543b:	53                   	push   %ebx
8010543c:	e8 ff c4 ff ff       	call   80101940 <iunlockput>
    goto bad;
80105441:	83 c4 10             	add    $0x10,%esp
  iunlockput(dp);
80105444:	83 ec 0c             	sub    $0xc,%esp
80105447:	56                   	push   %esi
80105448:	e8 f3 c4 ff ff       	call   80101940 <iunlockput>
  end_op();
8010544d:	e8 ee d7 ff ff       	call   80102c40 <end_op>
  return -1;
80105452:	83 c4 10             	add    $0x10,%esp
80105455:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010545a:	eb 95                	jmp    801053f1 <sys_unlink+0x111>
8010545c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    dp->nlink--;
80105460:	66 83 6e 56 01       	subw   $0x1,0x56(%esi)
    iupdate(dp);
80105465:	83 ec 0c             	sub    $0xc,%esp
80105468:	56                   	push   %esi
80105469:	e8 92 c1 ff ff       	call   80101600 <iupdate>
8010546e:	83 c4 10             	add    $0x10,%esp
80105471:	e9 53 ff ff ff       	jmp    801053c9 <sys_unlink+0xe9>
    return -1;
80105476:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010547b:	e9 71 ff ff ff       	jmp    801053f1 <sys_unlink+0x111>
    end_op();
80105480:	e8 bb d7 ff ff       	call   80102c40 <end_op>
    return -1;
80105485:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010548a:	e9 62 ff ff ff       	jmp    801053f1 <sys_unlink+0x111>
      panic("isdirempty: readi");
8010548f:	83 ec 0c             	sub    $0xc,%esp
80105492:	68 c4 7c 10 80       	push   $0x80107cc4
80105497:	e8 f4 ae ff ff       	call   80100390 <panic>
    panic("unlink: nlink < 1");
8010549c:	83 ec 0c             	sub    $0xc,%esp
8010549f:	68 b2 7c 10 80       	push   $0x80107cb2
801054a4:	e8 e7 ae ff ff       	call   80100390 <panic>
    panic("unlink: writei");
801054a9:	83 ec 0c             	sub    $0xc,%esp
801054ac:	68 d6 7c 10 80       	push   $0x80107cd6
801054b1:	e8 da ae ff ff       	call   80100390 <panic>
801054b6:	8d 76 00             	lea    0x0(%esi),%esi
801054b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801054c0 <sys_open>:

int
sys_open(void)
{
801054c0:	55                   	push   %ebp
801054c1:	89 e5                	mov    %esp,%ebp
801054c3:	57                   	push   %edi
801054c4:	56                   	push   %esi
801054c5:	53                   	push   %ebx
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
801054c6:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
801054c9:	83 ec 24             	sub    $0x24,%esp
  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
801054cc:	50                   	push   %eax
801054cd:	6a 00                	push   $0x0
801054cf:	e8 3c f8 ff ff       	call   80104d10 <argstr>
801054d4:	83 c4 10             	add    $0x10,%esp
801054d7:	85 c0                	test   %eax,%eax
801054d9:	0f 88 1d 01 00 00    	js     801055fc <sys_open+0x13c>
801054df:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801054e2:	83 ec 08             	sub    $0x8,%esp
801054e5:	50                   	push   %eax
801054e6:	6a 01                	push   $0x1
801054e8:	e8 73 f7 ff ff       	call   80104c60 <argint>
801054ed:	83 c4 10             	add    $0x10,%esp
801054f0:	85 c0                	test   %eax,%eax
801054f2:	0f 88 04 01 00 00    	js     801055fc <sys_open+0x13c>
    return -1;

  begin_op();
801054f8:	e8 d3 d6 ff ff       	call   80102bd0 <begin_op>

  if(omode & O_CREATE){
801054fd:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
80105501:	0f 85 a9 00 00 00    	jne    801055b0 <sys_open+0xf0>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
80105507:	83 ec 0c             	sub    $0xc,%esp
8010550a:	ff 75 e0             	pushl  -0x20(%ebp)
8010550d:	e8 fe c9 ff ff       	call   80101f10 <namei>
80105512:	83 c4 10             	add    $0x10,%esp
80105515:	85 c0                	test   %eax,%eax
80105517:	89 c6                	mov    %eax,%esi
80105519:	0f 84 b2 00 00 00    	je     801055d1 <sys_open+0x111>
      end_op();
      return -1;
    }
    ilock(ip);
8010551f:	83 ec 0c             	sub    $0xc,%esp
80105522:	50                   	push   %eax
80105523:	e8 88 c1 ff ff       	call   801016b0 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
80105528:	83 c4 10             	add    $0x10,%esp
8010552b:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80105530:	0f 84 aa 00 00 00    	je     801055e0 <sys_open+0x120>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
80105536:	e8 75 b8 ff ff       	call   80100db0 <filealloc>
8010553b:	85 c0                	test   %eax,%eax
8010553d:	89 c7                	mov    %eax,%edi
8010553f:	0f 84 a6 00 00 00    	je     801055eb <sys_open+0x12b>
  struct proc *curproc = myproc();
80105545:	e8 06 e2 ff ff       	call   80103750 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
8010554a:	31 db                	xor    %ebx,%ebx
8010554c:	eb 0e                	jmp    8010555c <sys_open+0x9c>
8010554e:	66 90                	xchg   %ax,%ax
80105550:	83 c3 01             	add    $0x1,%ebx
80105553:	83 fb 10             	cmp    $0x10,%ebx
80105556:	0f 84 ac 00 00 00    	je     80105608 <sys_open+0x148>
    if(curproc->ofile[fd] == 0){
8010555c:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105560:	85 d2                	test   %edx,%edx
80105562:	75 ec                	jne    80105550 <sys_open+0x90>
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105564:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
80105567:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
  iunlock(ip);
8010556b:	56                   	push   %esi
8010556c:	e8 1f c2 ff ff       	call   80101790 <iunlock>
  end_op();
80105571:	e8 ca d6 ff ff       	call   80102c40 <end_op>

  f->type = FD_INODE;
80105576:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
8010557c:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
8010557f:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
80105582:	89 77 10             	mov    %esi,0x10(%edi)
  f->off = 0;
80105585:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
8010558c:	89 d0                	mov    %edx,%eax
8010558e:	f7 d0                	not    %eax
80105590:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105593:	83 e2 03             	and    $0x3,%edx
  f->readable = !(omode & O_WRONLY);
80105596:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105599:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
8010559d:	8d 65 f4             	lea    -0xc(%ebp),%esp
801055a0:	89 d8                	mov    %ebx,%eax
801055a2:	5b                   	pop    %ebx
801055a3:	5e                   	pop    %esi
801055a4:	5f                   	pop    %edi
801055a5:	5d                   	pop    %ebp
801055a6:	c3                   	ret    
801055a7:	89 f6                	mov    %esi,%esi
801055a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    ip = create(path, T_FILE, 0, 0);
801055b0:	83 ec 0c             	sub    $0xc,%esp
801055b3:	8b 45 e0             	mov    -0x20(%ebp),%eax
801055b6:	31 c9                	xor    %ecx,%ecx
801055b8:	6a 00                	push   $0x0
801055ba:	ba 02 00 00 00       	mov    $0x2,%edx
801055bf:	e8 ec f7 ff ff       	call   80104db0 <create>
    if(ip == 0){
801055c4:	83 c4 10             	add    $0x10,%esp
801055c7:	85 c0                	test   %eax,%eax
    ip = create(path, T_FILE, 0, 0);
801055c9:	89 c6                	mov    %eax,%esi
    if(ip == 0){
801055cb:	0f 85 65 ff ff ff    	jne    80105536 <sys_open+0x76>
      end_op();
801055d1:	e8 6a d6 ff ff       	call   80102c40 <end_op>
      return -1;
801055d6:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801055db:	eb c0                	jmp    8010559d <sys_open+0xdd>
801055dd:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->type == T_DIR && omode != O_RDONLY){
801055e0:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801055e3:	85 c9                	test   %ecx,%ecx
801055e5:	0f 84 4b ff ff ff    	je     80105536 <sys_open+0x76>
    iunlockput(ip);
801055eb:	83 ec 0c             	sub    $0xc,%esp
801055ee:	56                   	push   %esi
801055ef:	e8 4c c3 ff ff       	call   80101940 <iunlockput>
    end_op();
801055f4:	e8 47 d6 ff ff       	call   80102c40 <end_op>
    return -1;
801055f9:	83 c4 10             	add    $0x10,%esp
801055fc:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105601:	eb 9a                	jmp    8010559d <sys_open+0xdd>
80105603:	90                   	nop
80105604:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      fileclose(f);
80105608:	83 ec 0c             	sub    $0xc,%esp
8010560b:	57                   	push   %edi
8010560c:	e8 5f b8 ff ff       	call   80100e70 <fileclose>
80105611:	83 c4 10             	add    $0x10,%esp
80105614:	eb d5                	jmp    801055eb <sys_open+0x12b>
80105616:	8d 76 00             	lea    0x0(%esi),%esi
80105619:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105620 <sys_mkdir>:

int
sys_mkdir(void)
{
80105620:	55                   	push   %ebp
80105621:	89 e5                	mov    %esp,%ebp
80105623:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
80105626:	e8 a5 d5 ff ff       	call   80102bd0 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
8010562b:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010562e:	83 ec 08             	sub    $0x8,%esp
80105631:	50                   	push   %eax
80105632:	6a 00                	push   $0x0
80105634:	e8 d7 f6 ff ff       	call   80104d10 <argstr>
80105639:	83 c4 10             	add    $0x10,%esp
8010563c:	85 c0                	test   %eax,%eax
8010563e:	78 30                	js     80105670 <sys_mkdir+0x50>
80105640:	83 ec 0c             	sub    $0xc,%esp
80105643:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105646:	31 c9                	xor    %ecx,%ecx
80105648:	6a 00                	push   $0x0
8010564a:	ba 01 00 00 00       	mov    $0x1,%edx
8010564f:	e8 5c f7 ff ff       	call   80104db0 <create>
80105654:	83 c4 10             	add    $0x10,%esp
80105657:	85 c0                	test   %eax,%eax
80105659:	74 15                	je     80105670 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010565b:	83 ec 0c             	sub    $0xc,%esp
8010565e:	50                   	push   %eax
8010565f:	e8 dc c2 ff ff       	call   80101940 <iunlockput>
  end_op();
80105664:	e8 d7 d5 ff ff       	call   80102c40 <end_op>
  return 0;
80105669:	83 c4 10             	add    $0x10,%esp
8010566c:	31 c0                	xor    %eax,%eax
}
8010566e:	c9                   	leave  
8010566f:	c3                   	ret    
    end_op();
80105670:	e8 cb d5 ff ff       	call   80102c40 <end_op>
    return -1;
80105675:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010567a:	c9                   	leave  
8010567b:	c3                   	ret    
8010567c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105680 <sys_mknod>:

int
sys_mknod(void)
{
80105680:	55                   	push   %ebp
80105681:	89 e5                	mov    %esp,%ebp
80105683:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80105686:	e8 45 d5 ff ff       	call   80102bd0 <begin_op>
  if((argstr(0, &path)) < 0 ||
8010568b:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010568e:	83 ec 08             	sub    $0x8,%esp
80105691:	50                   	push   %eax
80105692:	6a 00                	push   $0x0
80105694:	e8 77 f6 ff ff       	call   80104d10 <argstr>
80105699:	83 c4 10             	add    $0x10,%esp
8010569c:	85 c0                	test   %eax,%eax
8010569e:	78 60                	js     80105700 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
801056a0:	8d 45 f0             	lea    -0x10(%ebp),%eax
801056a3:	83 ec 08             	sub    $0x8,%esp
801056a6:	50                   	push   %eax
801056a7:	6a 01                	push   $0x1
801056a9:	e8 b2 f5 ff ff       	call   80104c60 <argint>
  if((argstr(0, &path)) < 0 ||
801056ae:	83 c4 10             	add    $0x10,%esp
801056b1:	85 c0                	test   %eax,%eax
801056b3:	78 4b                	js     80105700 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
801056b5:	8d 45 f4             	lea    -0xc(%ebp),%eax
801056b8:	83 ec 08             	sub    $0x8,%esp
801056bb:	50                   	push   %eax
801056bc:	6a 02                	push   $0x2
801056be:	e8 9d f5 ff ff       	call   80104c60 <argint>
     argint(1, &major) < 0 ||
801056c3:	83 c4 10             	add    $0x10,%esp
801056c6:	85 c0                	test   %eax,%eax
801056c8:	78 36                	js     80105700 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
801056ca:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
     argint(2, &minor) < 0 ||
801056ce:	83 ec 0c             	sub    $0xc,%esp
     (ip = create(path, T_DEV, major, minor)) == 0){
801056d1:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
     argint(2, &minor) < 0 ||
801056d5:	ba 03 00 00 00       	mov    $0x3,%edx
801056da:	50                   	push   %eax
801056db:	8b 45 ec             	mov    -0x14(%ebp),%eax
801056de:	e8 cd f6 ff ff       	call   80104db0 <create>
801056e3:	83 c4 10             	add    $0x10,%esp
801056e6:	85 c0                	test   %eax,%eax
801056e8:	74 16                	je     80105700 <sys_mknod+0x80>
    end_op();
    return -1;
  }
  iunlockput(ip);
801056ea:	83 ec 0c             	sub    $0xc,%esp
801056ed:	50                   	push   %eax
801056ee:	e8 4d c2 ff ff       	call   80101940 <iunlockput>
  end_op();
801056f3:	e8 48 d5 ff ff       	call   80102c40 <end_op>
  return 0;
801056f8:	83 c4 10             	add    $0x10,%esp
801056fb:	31 c0                	xor    %eax,%eax
}
801056fd:	c9                   	leave  
801056fe:	c3                   	ret    
801056ff:	90                   	nop
    end_op();
80105700:	e8 3b d5 ff ff       	call   80102c40 <end_op>
    return -1;
80105705:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010570a:	c9                   	leave  
8010570b:	c3                   	ret    
8010570c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105710 <sys_chdir>:

int
sys_chdir(void)
{
80105710:	55                   	push   %ebp
80105711:	89 e5                	mov    %esp,%ebp
80105713:	56                   	push   %esi
80105714:	53                   	push   %ebx
80105715:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
80105718:	e8 33 e0 ff ff       	call   80103750 <myproc>
8010571d:	89 c6                	mov    %eax,%esi
  
  begin_op();
8010571f:	e8 ac d4 ff ff       	call   80102bd0 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80105724:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105727:	83 ec 08             	sub    $0x8,%esp
8010572a:	50                   	push   %eax
8010572b:	6a 00                	push   $0x0
8010572d:	e8 de f5 ff ff       	call   80104d10 <argstr>
80105732:	83 c4 10             	add    $0x10,%esp
80105735:	85 c0                	test   %eax,%eax
80105737:	78 77                	js     801057b0 <sys_chdir+0xa0>
80105739:	83 ec 0c             	sub    $0xc,%esp
8010573c:	ff 75 f4             	pushl  -0xc(%ebp)
8010573f:	e8 cc c7 ff ff       	call   80101f10 <namei>
80105744:	83 c4 10             	add    $0x10,%esp
80105747:	85 c0                	test   %eax,%eax
80105749:	89 c3                	mov    %eax,%ebx
8010574b:	74 63                	je     801057b0 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
8010574d:	83 ec 0c             	sub    $0xc,%esp
80105750:	50                   	push   %eax
80105751:	e8 5a bf ff ff       	call   801016b0 <ilock>
  if(ip->type != T_DIR){
80105756:	83 c4 10             	add    $0x10,%esp
80105759:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
8010575e:	75 30                	jne    80105790 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105760:	83 ec 0c             	sub    $0xc,%esp
80105763:	53                   	push   %ebx
80105764:	e8 27 c0 ff ff       	call   80101790 <iunlock>
  iput(curproc->cwd);
80105769:	58                   	pop    %eax
8010576a:	ff 76 68             	pushl  0x68(%esi)
8010576d:	e8 6e c0 ff ff       	call   801017e0 <iput>
  end_op();
80105772:	e8 c9 d4 ff ff       	call   80102c40 <end_op>
  curproc->cwd = ip;
80105777:	89 5e 68             	mov    %ebx,0x68(%esi)
  return 0;
8010577a:	83 c4 10             	add    $0x10,%esp
8010577d:	31 c0                	xor    %eax,%eax
}
8010577f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105782:	5b                   	pop    %ebx
80105783:	5e                   	pop    %esi
80105784:	5d                   	pop    %ebp
80105785:	c3                   	ret    
80105786:	8d 76 00             	lea    0x0(%esi),%esi
80105789:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    iunlockput(ip);
80105790:	83 ec 0c             	sub    $0xc,%esp
80105793:	53                   	push   %ebx
80105794:	e8 a7 c1 ff ff       	call   80101940 <iunlockput>
    end_op();
80105799:	e8 a2 d4 ff ff       	call   80102c40 <end_op>
    return -1;
8010579e:	83 c4 10             	add    $0x10,%esp
801057a1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801057a6:	eb d7                	jmp    8010577f <sys_chdir+0x6f>
801057a8:	90                   	nop
801057a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    end_op();
801057b0:	e8 8b d4 ff ff       	call   80102c40 <end_op>
    return -1;
801057b5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801057ba:	eb c3                	jmp    8010577f <sys_chdir+0x6f>
801057bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801057c0 <sys_exec>:

int
sys_exec(void)
{
801057c0:	55                   	push   %ebp
801057c1:	89 e5                	mov    %esp,%ebp
801057c3:	57                   	push   %edi
801057c4:	56                   	push   %esi
801057c5:	53                   	push   %ebx
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
801057c6:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
{
801057cc:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
801057d2:	50                   	push   %eax
801057d3:	6a 00                	push   $0x0
801057d5:	e8 36 f5 ff ff       	call   80104d10 <argstr>
801057da:	83 c4 10             	add    $0x10,%esp
801057dd:	85 c0                	test   %eax,%eax
801057df:	0f 88 87 00 00 00    	js     8010586c <sys_exec+0xac>
801057e5:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
801057eb:	83 ec 08             	sub    $0x8,%esp
801057ee:	50                   	push   %eax
801057ef:	6a 01                	push   $0x1
801057f1:	e8 6a f4 ff ff       	call   80104c60 <argint>
801057f6:	83 c4 10             	add    $0x10,%esp
801057f9:	85 c0                	test   %eax,%eax
801057fb:	78 6f                	js     8010586c <sys_exec+0xac>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
801057fd:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80105803:	83 ec 04             	sub    $0x4,%esp
  for(i=0;; i++){
80105806:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
80105808:	68 80 00 00 00       	push   $0x80
8010580d:	6a 00                	push   $0x0
8010580f:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
80105815:	50                   	push   %eax
80105816:	e8 45 f1 ff ff       	call   80104960 <memset>
8010581b:	83 c4 10             	add    $0x10,%esp
8010581e:	eb 2c                	jmp    8010584c <sys_exec+0x8c>
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
      return -1;
    if(uarg == 0){
80105820:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80105826:	85 c0                	test   %eax,%eax
80105828:	74 56                	je     80105880 <sys_exec+0xc0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
8010582a:	8d 8d 68 ff ff ff    	lea    -0x98(%ebp),%ecx
80105830:	83 ec 08             	sub    $0x8,%esp
80105833:	8d 14 31             	lea    (%ecx,%esi,1),%edx
80105836:	52                   	push   %edx
80105837:	50                   	push   %eax
80105838:	e8 b3 f3 ff ff       	call   80104bf0 <fetchstr>
8010583d:	83 c4 10             	add    $0x10,%esp
80105840:	85 c0                	test   %eax,%eax
80105842:	78 28                	js     8010586c <sys_exec+0xac>
  for(i=0;; i++){
80105844:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
80105847:	83 fb 20             	cmp    $0x20,%ebx
8010584a:	74 20                	je     8010586c <sys_exec+0xac>
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
8010584c:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80105852:	8d 34 9d 00 00 00 00 	lea    0x0(,%ebx,4),%esi
80105859:	83 ec 08             	sub    $0x8,%esp
8010585c:	57                   	push   %edi
8010585d:	01 f0                	add    %esi,%eax
8010585f:	50                   	push   %eax
80105860:	e8 4b f3 ff ff       	call   80104bb0 <fetchint>
80105865:	83 c4 10             	add    $0x10,%esp
80105868:	85 c0                	test   %eax,%eax
8010586a:	79 b4                	jns    80105820 <sys_exec+0x60>
      return -1;
  }
  return exec(path, argv);
}
8010586c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
8010586f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105874:	5b                   	pop    %ebx
80105875:	5e                   	pop    %esi
80105876:	5f                   	pop    %edi
80105877:	5d                   	pop    %ebp
80105878:	c3                   	ret    
80105879:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return exec(path, argv);
80105880:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80105886:	83 ec 08             	sub    $0x8,%esp
      argv[i] = 0;
80105889:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
80105890:	00 00 00 00 
  return exec(path, argv);
80105894:	50                   	push   %eax
80105895:	ff b5 5c ff ff ff    	pushl  -0xa4(%ebp)
8010589b:	e8 70 b1 ff ff       	call   80100a10 <exec>
801058a0:	83 c4 10             	add    $0x10,%esp
}
801058a3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801058a6:	5b                   	pop    %ebx
801058a7:	5e                   	pop    %esi
801058a8:	5f                   	pop    %edi
801058a9:	5d                   	pop    %ebp
801058aa:	c3                   	ret    
801058ab:	90                   	nop
801058ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801058b0 <sys_pipe>:

int
sys_pipe(void)
{
801058b0:	55                   	push   %ebp
801058b1:	89 e5                	mov    %esp,%ebp
801058b3:	57                   	push   %edi
801058b4:	56                   	push   %esi
801058b5:	53                   	push   %ebx
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
801058b6:	8d 45 dc             	lea    -0x24(%ebp),%eax
{
801058b9:	83 ec 20             	sub    $0x20,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
801058bc:	6a 08                	push   $0x8
801058be:	50                   	push   %eax
801058bf:	6a 00                	push   $0x0
801058c1:	e8 ea f3 ff ff       	call   80104cb0 <argptr>
801058c6:	83 c4 10             	add    $0x10,%esp
801058c9:	85 c0                	test   %eax,%eax
801058cb:	0f 88 ae 00 00 00    	js     8010597f <sys_pipe+0xcf>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
801058d1:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801058d4:	83 ec 08             	sub    $0x8,%esp
801058d7:	50                   	push   %eax
801058d8:	8d 45 e0             	lea    -0x20(%ebp),%eax
801058db:	50                   	push   %eax
801058dc:	e8 8f d9 ff ff       	call   80103270 <pipealloc>
801058e1:	83 c4 10             	add    $0x10,%esp
801058e4:	85 c0                	test   %eax,%eax
801058e6:	0f 88 93 00 00 00    	js     8010597f <sys_pipe+0xcf>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
801058ec:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
801058ef:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
801058f1:	e8 5a de ff ff       	call   80103750 <myproc>
801058f6:	eb 10                	jmp    80105908 <sys_pipe+0x58>
801058f8:	90                   	nop
801058f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(fd = 0; fd < NOFILE; fd++){
80105900:	83 c3 01             	add    $0x1,%ebx
80105903:	83 fb 10             	cmp    $0x10,%ebx
80105906:	74 60                	je     80105968 <sys_pipe+0xb8>
    if(curproc->ofile[fd] == 0){
80105908:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
8010590c:	85 f6                	test   %esi,%esi
8010590e:	75 f0                	jne    80105900 <sys_pipe+0x50>
      curproc->ofile[fd] = f;
80105910:	8d 73 08             	lea    0x8(%ebx),%esi
80105913:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105917:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
8010591a:	e8 31 de ff ff       	call   80103750 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
8010591f:	31 d2                	xor    %edx,%edx
80105921:	eb 0d                	jmp    80105930 <sys_pipe+0x80>
80105923:	90                   	nop
80105924:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105928:	83 c2 01             	add    $0x1,%edx
8010592b:	83 fa 10             	cmp    $0x10,%edx
8010592e:	74 28                	je     80105958 <sys_pipe+0xa8>
    if(curproc->ofile[fd] == 0){
80105930:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
80105934:	85 c9                	test   %ecx,%ecx
80105936:	75 f0                	jne    80105928 <sys_pipe+0x78>
      curproc->ofile[fd] = f;
80105938:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
8010593c:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010593f:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
80105941:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105944:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
80105947:	31 c0                	xor    %eax,%eax
}
80105949:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010594c:	5b                   	pop    %ebx
8010594d:	5e                   	pop    %esi
8010594e:	5f                   	pop    %edi
8010594f:	5d                   	pop    %ebp
80105950:	c3                   	ret    
80105951:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      myproc()->ofile[fd0] = 0;
80105958:	e8 f3 dd ff ff       	call   80103750 <myproc>
8010595d:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
80105964:	00 
80105965:	8d 76 00             	lea    0x0(%esi),%esi
    fileclose(rf);
80105968:	83 ec 0c             	sub    $0xc,%esp
8010596b:	ff 75 e0             	pushl  -0x20(%ebp)
8010596e:	e8 fd b4 ff ff       	call   80100e70 <fileclose>
    fileclose(wf);
80105973:	58                   	pop    %eax
80105974:	ff 75 e4             	pushl  -0x1c(%ebp)
80105977:	e8 f4 b4 ff ff       	call   80100e70 <fileclose>
    return -1;
8010597c:	83 c4 10             	add    $0x10,%esp
8010597f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105984:	eb c3                	jmp    80105949 <sys_pipe+0x99>
80105986:	66 90                	xchg   %ax,%ax
80105988:	66 90                	xchg   %ax,%ax
8010598a:	66 90                	xchg   %ax,%ax
8010598c:	66 90                	xchg   %ax,%ax
8010598e:	66 90                	xchg   %ax,%ax

80105990 <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
80105990:	55                   	push   %ebp
80105991:	89 e5                	mov    %esp,%ebp
  return fork();
}
80105993:	5d                   	pop    %ebp
  return fork();
80105994:	e9 c7 e0 ff ff       	jmp    80103a60 <fork>
80105999:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801059a0 <sys_exit>:

int
sys_exit(void)
{
801059a0:	55                   	push   %ebp
801059a1:	89 e5                	mov    %esp,%ebp
801059a3:	83 ec 08             	sub    $0x8,%esp
  exit();
801059a6:	e8 95 e3 ff ff       	call   80103d40 <exit>
  return 0;  // not reached
}
801059ab:	31 c0                	xor    %eax,%eax
801059ad:	c9                   	leave  
801059ae:	c3                   	ret    
801059af:	90                   	nop

801059b0 <sys_wait>:

int
sys_wait(void)
{
801059b0:	55                   	push   %ebp
801059b1:	89 e5                	mov    %esp,%ebp
  return wait();
}
801059b3:	5d                   	pop    %ebp
  return wait();
801059b4:	e9 c7 e5 ff ff       	jmp    80103f80 <wait>
801059b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801059c0 <sys_kill>:

int
sys_kill(void)
{
801059c0:	55                   	push   %ebp
801059c1:	89 e5                	mov    %esp,%ebp
801059c3:	83 ec 20             	sub    $0x20,%esp
  int pid;
  int signum;

  if(argint(0, &pid) < 0)
801059c6:	8d 45 f0             	lea    -0x10(%ebp),%eax
801059c9:	50                   	push   %eax
801059ca:	6a 00                	push   $0x0
801059cc:	e8 8f f2 ff ff       	call   80104c60 <argint>
801059d1:	83 c4 10             	add    $0x10,%esp
801059d4:	85 c0                	test   %eax,%eax
801059d6:	78 28                	js     80105a00 <sys_kill+0x40>
    return -1;
  if(argint(1, &signum) < 0)
801059d8:	8d 45 f4             	lea    -0xc(%ebp),%eax
801059db:	83 ec 08             	sub    $0x8,%esp
801059de:	50                   	push   %eax
801059df:	6a 01                	push   $0x1
801059e1:	e8 7a f2 ff ff       	call   80104c60 <argint>
801059e6:	83 c4 10             	add    $0x10,%esp
801059e9:	85 c0                	test   %eax,%eax
801059eb:	78 13                	js     80105a00 <sys_kill+0x40>
    return -1;
  return kill(pid, signum);
801059ed:	83 ec 08             	sub    $0x8,%esp
801059f0:	ff 75 f4             	pushl  -0xc(%ebp)
801059f3:	ff 75 f0             	pushl  -0x10(%ebp)
801059f6:	e8 e5 e6 ff ff       	call   801040e0 <kill>
801059fb:	83 c4 10             	add    $0x10,%esp
}
801059fe:	c9                   	leave  
801059ff:	c3                   	ret    
    return -1;
80105a00:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105a05:	c9                   	leave  
80105a06:	c3                   	ret    
80105a07:	89 f6                	mov    %esi,%esi
80105a09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105a10 <sys_getpid>:

int
sys_getpid(void)
{
80105a10:	55                   	push   %ebp
80105a11:	89 e5                	mov    %esp,%ebp
80105a13:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
80105a16:	e8 35 dd ff ff       	call   80103750 <myproc>
80105a1b:	8b 40 10             	mov    0x10(%eax),%eax
}
80105a1e:	c9                   	leave  
80105a1f:	c3                   	ret    

80105a20 <sys_sbrk>:

int
sys_sbrk(void)
{
80105a20:	55                   	push   %ebp
80105a21:	89 e5                	mov    %esp,%ebp
80105a23:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
80105a24:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105a27:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
80105a2a:	50                   	push   %eax
80105a2b:	6a 00                	push   $0x0
80105a2d:	e8 2e f2 ff ff       	call   80104c60 <argint>
80105a32:	83 c4 10             	add    $0x10,%esp
80105a35:	85 c0                	test   %eax,%eax
80105a37:	78 27                	js     80105a60 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
80105a39:	e8 12 dd ff ff       	call   80103750 <myproc>
  if(growproc(n) < 0)
80105a3e:	83 ec 0c             	sub    $0xc,%esp
  addr = myproc()->sz;
80105a41:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80105a43:	ff 75 f4             	pushl  -0xc(%ebp)
80105a46:	e8 95 df ff ff       	call   801039e0 <growproc>
80105a4b:	83 c4 10             	add    $0x10,%esp
80105a4e:	85 c0                	test   %eax,%eax
80105a50:	78 0e                	js     80105a60 <sys_sbrk+0x40>
    return -1;
  return addr;
}
80105a52:	89 d8                	mov    %ebx,%eax
80105a54:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105a57:	c9                   	leave  
80105a58:	c3                   	ret    
80105a59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105a60:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105a65:	eb eb                	jmp    80105a52 <sys_sbrk+0x32>
80105a67:	89 f6                	mov    %esi,%esi
80105a69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105a70 <sys_sleep>:

int
sys_sleep(void)
{
80105a70:	55                   	push   %ebp
80105a71:	89 e5                	mov    %esp,%ebp
80105a73:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80105a74:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105a77:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
80105a7a:	50                   	push   %eax
80105a7b:	6a 00                	push   $0x0
80105a7d:	e8 de f1 ff ff       	call   80104c60 <argint>
80105a82:	83 c4 10             	add    $0x10,%esp
80105a85:	85 c0                	test   %eax,%eax
80105a87:	0f 88 8a 00 00 00    	js     80105b17 <sys_sleep+0xa7>
    return -1;
  acquire(&tickslock);
80105a8d:	83 ec 0c             	sub    $0xc,%esp
80105a90:	68 60 91 11 80       	push   $0x80119160
80105a95:	e8 b6 ed ff ff       	call   80104850 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
80105a9a:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105a9d:	83 c4 10             	add    $0x10,%esp
  ticks0 = ticks;
80105aa0:	8b 1d a0 99 11 80    	mov    0x801199a0,%ebx
  while(ticks - ticks0 < n){
80105aa6:	85 d2                	test   %edx,%edx
80105aa8:	75 27                	jne    80105ad1 <sys_sleep+0x61>
80105aaa:	eb 54                	jmp    80105b00 <sys_sleep+0x90>
80105aac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80105ab0:	83 ec 08             	sub    $0x8,%esp
80105ab3:	68 60 91 11 80       	push   $0x80119160
80105ab8:	68 a0 99 11 80       	push   $0x801199a0
80105abd:	e8 fe e3 ff ff       	call   80103ec0 <sleep>
  while(ticks - ticks0 < n){
80105ac2:	a1 a0 99 11 80       	mov    0x801199a0,%eax
80105ac7:	83 c4 10             	add    $0x10,%esp
80105aca:	29 d8                	sub    %ebx,%eax
80105acc:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80105acf:	73 2f                	jae    80105b00 <sys_sleep+0x90>
    if(myproc()->killed){
80105ad1:	e8 7a dc ff ff       	call   80103750 <myproc>
80105ad6:	8b 40 24             	mov    0x24(%eax),%eax
80105ad9:	85 c0                	test   %eax,%eax
80105adb:	74 d3                	je     80105ab0 <sys_sleep+0x40>
      release(&tickslock);
80105add:	83 ec 0c             	sub    $0xc,%esp
80105ae0:	68 60 91 11 80       	push   $0x80119160
80105ae5:	e8 26 ee ff ff       	call   80104910 <release>
      return -1;
80105aea:	83 c4 10             	add    $0x10,%esp
80105aed:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  release(&tickslock);
  return 0;
}
80105af2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105af5:	c9                   	leave  
80105af6:	c3                   	ret    
80105af7:	89 f6                	mov    %esi,%esi
80105af9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  release(&tickslock);
80105b00:	83 ec 0c             	sub    $0xc,%esp
80105b03:	68 60 91 11 80       	push   $0x80119160
80105b08:	e8 03 ee ff ff       	call   80104910 <release>
  return 0;
80105b0d:	83 c4 10             	add    $0x10,%esp
80105b10:	31 c0                	xor    %eax,%eax
}
80105b12:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105b15:	c9                   	leave  
80105b16:	c3                   	ret    
    return -1;
80105b17:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105b1c:	eb f4                	jmp    80105b12 <sys_sleep+0xa2>
80105b1e:	66 90                	xchg   %ax,%ax

80105b20 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80105b20:	55                   	push   %ebp
80105b21:	89 e5                	mov    %esp,%ebp
80105b23:	53                   	push   %ebx
80105b24:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
80105b27:	68 60 91 11 80       	push   $0x80119160
80105b2c:	e8 1f ed ff ff       	call   80104850 <acquire>
  xticks = ticks;
80105b31:	8b 1d a0 99 11 80    	mov    0x801199a0,%ebx
  release(&tickslock);
80105b37:	c7 04 24 60 91 11 80 	movl   $0x80119160,(%esp)
80105b3e:	e8 cd ed ff ff       	call   80104910 <release>
  return xticks;
}
80105b43:	89 d8                	mov    %ebx,%eax
80105b45:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105b48:	c9                   	leave  
80105b49:	c3                   	ret    
80105b4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105b50 <sys_sigprocmask>:

int 
 sys_sigprocmask(void){
80105b50:	55                   	push   %ebp
80105b51:	89 e5                	mov    %esp,%ebp
80105b53:	83 ec 20             	sub    $0x20,%esp
  uint mask;

  if(argint(0, (int *)&mask) < 0)
80105b56:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105b59:	50                   	push   %eax
80105b5a:	6a 00                	push   $0x0
80105b5c:	e8 ff f0 ff ff       	call   80104c60 <argint>
80105b61:	83 c4 10             	add    $0x10,%esp
80105b64:	85 c0                	test   %eax,%eax
80105b66:	78 18                	js     80105b80 <sys_sigprocmask+0x30>
    return -1;
  
  return sigprocmask(mask);
80105b68:	83 ec 0c             	sub    $0xc,%esp
80105b6b:	ff 75 f4             	pushl  -0xc(%ebp)
80105b6e:	e8 1d e7 ff ff       	call   80104290 <sigprocmask>
80105b73:	83 c4 10             	add    $0x10,%esp
 }
80105b76:	c9                   	leave  
80105b77:	c3                   	ret    
80105b78:	90                   	nop
80105b79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105b80:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 }
80105b85:	c9                   	leave  
80105b86:	c3                   	ret    
80105b87:	89 f6                	mov    %esi,%esi
80105b89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105b90 <sys_sigaction>:

 int
 sys_sigaction(void){
80105b90:	55                   	push   %ebp
80105b91:	89 e5                	mov    %esp,%ebp
80105b93:	83 ec 20             	sub    $0x20,%esp
   int signum;
   char *act;
   char *oldact;

  if(argint(0, &signum) < 0)
80105b96:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105b99:	50                   	push   %eax
80105b9a:	6a 00                	push   $0x0
80105b9c:	e8 bf f0 ff ff       	call   80104c60 <argint>
80105ba1:	83 c4 10             	add    $0x10,%esp
80105ba4:	85 c0                	test   %eax,%eax
80105ba6:	78 48                	js     80105bf0 <sys_sigaction+0x60>
    return -1;
  if(argptr(1, &act, sizeof(struct sigaction)) < 0)
80105ba8:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105bab:	83 ec 04             	sub    $0x4,%esp
80105bae:	6a 08                	push   $0x8
80105bb0:	50                   	push   %eax
80105bb1:	6a 01                	push   $0x1
80105bb3:	e8 f8 f0 ff ff       	call   80104cb0 <argptr>
80105bb8:	83 c4 10             	add    $0x10,%esp
80105bbb:	85 c0                	test   %eax,%eax
80105bbd:	78 31                	js     80105bf0 <sys_sigaction+0x60>
    return -1;
  
  if(argptr(2, &oldact, sizeof(struct sigaction)) < 0)
80105bbf:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105bc2:	83 ec 04             	sub    $0x4,%esp
80105bc5:	6a 08                	push   $0x8
80105bc7:	50                   	push   %eax
80105bc8:	6a 02                	push   $0x2
80105bca:	e8 e1 f0 ff ff       	call   80104cb0 <argptr>
80105bcf:	83 c4 10             	add    $0x10,%esp
80105bd2:	85 c0                	test   %eax,%eax
80105bd4:	78 1a                	js     80105bf0 <sys_sigaction+0x60>
    return -1;
  
  return sigaction(signum,(struct sigaction *)act, (struct sigaction *)oldact);
80105bd6:	83 ec 04             	sub    $0x4,%esp
80105bd9:	ff 75 f4             	pushl  -0xc(%ebp)
80105bdc:	ff 75 f0             	pushl  -0x10(%ebp)
80105bdf:	ff 75 ec             	pushl  -0x14(%ebp)
80105be2:	e8 e9 e6 ff ff       	call   801042d0 <sigaction>
80105be7:	83 c4 10             	add    $0x10,%esp
 }
80105bea:	c9                   	leave  
80105beb:	c3                   	ret    
80105bec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105bf0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 }
80105bf5:	c9                   	leave  
80105bf6:	c3                   	ret    
80105bf7:	89 f6                	mov    %esi,%esi
80105bf9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105c00 <sys_sigret>:

 int
 sys_sigret(void){
80105c00:	55                   	push   %ebp
   return 0;
 }
80105c01:	31 c0                	xor    %eax,%eax
 sys_sigret(void){
80105c03:	89 e5                	mov    %esp,%ebp
 }
80105c05:	5d                   	pop    %ebp
80105c06:	c3                   	ret    

80105c07 <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
80105c07:	1e                   	push   %ds
  pushl %es
80105c08:	06                   	push   %es
  pushl %fs
80105c09:	0f a0                	push   %fs
  pushl %gs
80105c0b:	0f a8                	push   %gs
  pushal
80105c0d:	60                   	pusha  
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
80105c0e:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80105c12:	8e d8                	mov    %eax,%ds
  movw %ax, %es
80105c14:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
80105c16:	54                   	push   %esp
  call trap
80105c17:	e8 d4 00 00 00       	call   80105cf0 <trap>
  addl $4, %esp
80105c1c:	83 c4 04             	add    $0x4,%esp

80105c1f <trapret>:
  # Return falls through to trapret...
.globl trapret
.globl trapret_handler

trapret:
  call check_for_signals
80105c1f:	e8 cc e8 ff ff       	call   801044f0 <check_for_signals>
  popal
80105c24:	61                   	popa   
  popl %gs
80105c25:	0f a9                	pop    %gs
  popl %fs
80105c27:	0f a1                	pop    %fs
  popl %es
80105c29:	07                   	pop    %es
  popl %ds
80105c2a:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80105c2b:	83 c4 08             	add    $0x8,%esp
  iret
80105c2e:	cf                   	iret   

80105c2f <trapret_handler>:

trapret_handler:
  popl %eax 
80105c2f:	58                   	pop    %eax
  popl %esp
80105c30:	5c                   	pop    %esp
  popal
80105c31:	61                   	popa   
  popl %gs
80105c32:	0f a9                	pop    %gs
  popl %fs
80105c34:	0f a1                	pop    %fs
  popl %es
80105c36:	07                   	pop    %es
  popl %ds
80105c37:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80105c38:	83 c4 08             	add    $0x8,%esp
  iret
80105c3b:	cf                   	iret   
80105c3c:	66 90                	xchg   %ax,%ax
80105c3e:	66 90                	xchg   %ax,%ax

80105c40 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80105c40:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
80105c41:	31 c0                	xor    %eax,%eax
{
80105c43:	89 e5                	mov    %esp,%ebp
80105c45:	83 ec 08             	sub    $0x8,%esp
80105c48:	90                   	nop
80105c49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80105c50:	8b 14 85 08 a0 10 80 	mov    -0x7fef5ff8(,%eax,4),%edx
80105c57:	c7 04 c5 a2 91 11 80 	movl   $0x8e000008,-0x7fee6e5e(,%eax,8)
80105c5e:	08 00 00 8e 
80105c62:	66 89 14 c5 a0 91 11 	mov    %dx,-0x7fee6e60(,%eax,8)
80105c69:	80 
80105c6a:	c1 ea 10             	shr    $0x10,%edx
80105c6d:	66 89 14 c5 a6 91 11 	mov    %dx,-0x7fee6e5a(,%eax,8)
80105c74:	80 
  for(i = 0; i < 256; i++)
80105c75:	83 c0 01             	add    $0x1,%eax
80105c78:	3d 00 01 00 00       	cmp    $0x100,%eax
80105c7d:	75 d1                	jne    80105c50 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105c7f:	a1 08 a1 10 80       	mov    0x8010a108,%eax

  initlock(&tickslock, "time");
80105c84:	83 ec 08             	sub    $0x8,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105c87:	c7 05 a2 93 11 80 08 	movl   $0xef000008,0x801193a2
80105c8e:	00 00 ef 
  initlock(&tickslock, "time");
80105c91:	68 e5 7c 10 80       	push   $0x80107ce5
80105c96:	68 60 91 11 80       	push   $0x80119160
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105c9b:	66 a3 a0 93 11 80    	mov    %ax,0x801193a0
80105ca1:	c1 e8 10             	shr    $0x10,%eax
80105ca4:	66 a3 a6 93 11 80    	mov    %ax,0x801193a6
  initlock(&tickslock, "time");
80105caa:	e8 61 ea ff ff       	call   80104710 <initlock>
}
80105caf:	83 c4 10             	add    $0x10,%esp
80105cb2:	c9                   	leave  
80105cb3:	c3                   	ret    
80105cb4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105cba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80105cc0 <idtinit>:

void
idtinit(void)
{
80105cc0:	55                   	push   %ebp
  pd[0] = size-1;
80105cc1:	b8 ff 07 00 00       	mov    $0x7ff,%eax
80105cc6:	89 e5                	mov    %esp,%ebp
80105cc8:	83 ec 10             	sub    $0x10,%esp
80105ccb:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
80105ccf:	b8 a0 91 11 80       	mov    $0x801191a0,%eax
80105cd4:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80105cd8:	c1 e8 10             	shr    $0x10,%eax
80105cdb:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
80105cdf:	8d 45 fa             	lea    -0x6(%ebp),%eax
80105ce2:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80105ce5:	c9                   	leave  
80105ce6:	c3                   	ret    
80105ce7:	89 f6                	mov    %esi,%esi
80105ce9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105cf0 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80105cf0:	55                   	push   %ebp
80105cf1:	89 e5                	mov    %esp,%ebp
80105cf3:	57                   	push   %edi
80105cf4:	56                   	push   %esi
80105cf5:	53                   	push   %ebx
80105cf6:	83 ec 1c             	sub    $0x1c,%esp
80105cf9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(tf->trapno == T_SYSCALL){
80105cfc:	8b 43 30             	mov    0x30(%ebx),%eax
80105cff:	83 f8 40             	cmp    $0x40,%eax
80105d02:	0f 84 f8 00 00 00    	je     80105e00 <trap+0x110>
    *tf = *(myproc()->tf); 
    //check_for_signals();
    return;
  }

  switch(tf->trapno){
80105d08:	83 e8 20             	sub    $0x20,%eax
80105d0b:	83 f8 1f             	cmp    $0x1f,%eax
80105d0e:	77 10                	ja     80105d20 <trap+0x30>
80105d10:	ff 24 85 8c 7d 10 80 	jmp    *-0x7fef8274(,%eax,4)
80105d17:	89 f6                	mov    %esi,%esi
80105d19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    lapiceoi();
    break;

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
80105d20:	e8 2b da ff ff       	call   80103750 <myproc>
80105d25:	85 c0                	test   %eax,%eax
80105d27:	8b 7b 38             	mov    0x38(%ebx),%edi
80105d2a:	0f 84 5c 02 00 00    	je     80105f8c <trap+0x29c>
80105d30:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
80105d34:	0f 84 52 02 00 00    	je     80105f8c <trap+0x29c>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80105d3a:	0f 20 d1             	mov    %cr2,%ecx
80105d3d:	89 4d d8             	mov    %ecx,-0x28(%ebp)
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105d40:	e8 eb d9 ff ff       	call   80103730 <cpuid>
80105d45:	89 45 dc             	mov    %eax,-0x24(%ebp)
80105d48:	8b 43 34             	mov    0x34(%ebx),%eax
80105d4b:	8b 73 30             	mov    0x30(%ebx),%esi
80105d4e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80105d51:	e8 fa d9 ff ff       	call   80103750 <myproc>
80105d56:	89 45 e0             	mov    %eax,-0x20(%ebp)
80105d59:	e8 f2 d9 ff ff       	call   80103750 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105d5e:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80105d61:	8b 55 dc             	mov    -0x24(%ebp),%edx
80105d64:	51                   	push   %ecx
80105d65:	57                   	push   %edi
80105d66:	52                   	push   %edx
            myproc()->pid, myproc()->name, tf->trapno,
80105d67:	8b 55 e0             	mov    -0x20(%ebp),%edx
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105d6a:	ff 75 e4             	pushl  -0x1c(%ebp)
80105d6d:	56                   	push   %esi
            myproc()->pid, myproc()->name, tf->trapno,
80105d6e:	83 c2 6c             	add    $0x6c,%edx
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105d71:	52                   	push   %edx
80105d72:	ff 70 10             	pushl  0x10(%eax)
80105d75:	68 48 7d 10 80       	push   $0x80107d48
80105d7a:	e8 e1 a8 ff ff       	call   80100660 <cprintf>
            tf->err, cpuid(), tf->eip, rcr2());
    myproc()->killed = 1;
80105d7f:	83 c4 20             	add    $0x20,%esp
80105d82:	e8 c9 d9 ff ff       	call   80103750 <myproc>
80105d87:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105d8e:	e8 bd d9 ff ff       	call   80103750 <myproc>
80105d93:	85 c0                	test   %eax,%eax
80105d95:	74 1d                	je     80105db4 <trap+0xc4>
80105d97:	e8 b4 d9 ff ff       	call   80103750 <myproc>
80105d9c:	8b 50 24             	mov    0x24(%eax),%edx
80105d9f:	85 d2                	test   %edx,%edx
80105da1:	74 11                	je     80105db4 <trap+0xc4>
80105da3:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80105da7:	83 e0 03             	and    $0x3,%eax
80105daa:	66 83 f8 03          	cmp    $0x3,%ax
80105dae:	0f 84 94 01 00 00    	je     80105f48 <trap+0x258>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80105db4:	e8 97 d9 ff ff       	call   80103750 <myproc>
80105db9:	85 c0                	test   %eax,%eax
80105dbb:	74 0f                	je     80105dcc <trap+0xdc>
80105dbd:	e8 8e d9 ff ff       	call   80103750 <myproc>
80105dc2:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80105dc6:	0f 84 84 00 00 00    	je     80105e50 <trap+0x160>
    yield();
    //check_for_signals();
   }

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105dcc:	e8 7f d9 ff ff       	call   80103750 <myproc>
80105dd1:	85 c0                	test   %eax,%eax
80105dd3:	74 1d                	je     80105df2 <trap+0x102>
80105dd5:	e8 76 d9 ff ff       	call   80103750 <myproc>
80105dda:	8b 40 24             	mov    0x24(%eax),%eax
80105ddd:	85 c0                	test   %eax,%eax
80105ddf:	74 11                	je     80105df2 <trap+0x102>
80105de1:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80105de5:	83 e0 03             	and    $0x3,%eax
80105de8:	66 83 f8 03          	cmp    $0x3,%ax
80105dec:	0f 84 46 01 00 00    	je     80105f38 <trap+0x248>
    exit();
}
80105df2:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105df5:	5b                   	pop    %ebx
80105df6:	5e                   	pop    %esi
80105df7:	5f                   	pop    %edi
80105df8:	5d                   	pop    %ebp
80105df9:	c3                   	ret    
80105dfa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(myproc()->killed)
80105e00:	e8 4b d9 ff ff       	call   80103750 <myproc>
80105e05:	8b 70 24             	mov    0x24(%eax),%esi
80105e08:	85 f6                	test   %esi,%esi
80105e0a:	0f 85 18 01 00 00    	jne    80105f28 <trap+0x238>
    myproc()->tf = tf;
80105e10:	e8 3b d9 ff ff       	call   80103750 <myproc>
80105e15:	89 58 18             	mov    %ebx,0x18(%eax)
    syscall();
80105e18:	e8 33 ef ff ff       	call   80104d50 <syscall>
    if(myproc()->killed)
80105e1d:	e8 2e d9 ff ff       	call   80103750 <myproc>
80105e22:	8b 48 24             	mov    0x24(%eax),%ecx
80105e25:	85 c9                	test   %ecx,%ecx
80105e27:	0f 85 eb 00 00 00    	jne    80105f18 <trap+0x228>
    *tf = *(myproc()->tf); 
80105e2d:	e8 1e d9 ff ff       	call   80103750 <myproc>
80105e32:	89 df                	mov    %ebx,%edi
80105e34:	8b 70 18             	mov    0x18(%eax),%esi
80105e37:	b9 13 00 00 00       	mov    $0x13,%ecx
80105e3c:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
}
80105e3e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105e41:	5b                   	pop    %ebx
80105e42:	5e                   	pop    %esi
80105e43:	5f                   	pop    %edi
80105e44:	5d                   	pop    %ebp
80105e45:	c3                   	ret    
80105e46:	8d 76 00             	lea    0x0(%esi),%esi
80105e49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  if(myproc() && myproc()->state == RUNNING &&
80105e50:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
80105e54:	0f 85 72 ff ff ff    	jne    80105dcc <trap+0xdc>
    yield();
80105e5a:	e8 11 e0 ff ff       	call   80103e70 <yield>
80105e5f:	e9 68 ff ff ff       	jmp    80105dcc <trap+0xdc>
80105e64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(cpuid() == 0){
80105e68:	e8 c3 d8 ff ff       	call   80103730 <cpuid>
80105e6d:	85 c0                	test   %eax,%eax
80105e6f:	0f 84 e3 00 00 00    	je     80105f58 <trap+0x268>
    lapiceoi();
80105e75:	e8 06 c9 ff ff       	call   80102780 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105e7a:	e8 d1 d8 ff ff       	call   80103750 <myproc>
80105e7f:	85 c0                	test   %eax,%eax
80105e81:	0f 85 10 ff ff ff    	jne    80105d97 <trap+0xa7>
80105e87:	e9 28 ff ff ff       	jmp    80105db4 <trap+0xc4>
80105e8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    kbdintr();
80105e90:	e8 ab c7 ff ff       	call   80102640 <kbdintr>
    lapiceoi();
80105e95:	e8 e6 c8 ff ff       	call   80102780 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105e9a:	e8 b1 d8 ff ff       	call   80103750 <myproc>
80105e9f:	85 c0                	test   %eax,%eax
80105ea1:	0f 85 f0 fe ff ff    	jne    80105d97 <trap+0xa7>
80105ea7:	e9 08 ff ff ff       	jmp    80105db4 <trap+0xc4>
80105eac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    uartintr();
80105eb0:	e8 7b 02 00 00       	call   80106130 <uartintr>
    lapiceoi();
80105eb5:	e8 c6 c8 ff ff       	call   80102780 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105eba:	e8 91 d8 ff ff       	call   80103750 <myproc>
80105ebf:	85 c0                	test   %eax,%eax
80105ec1:	0f 85 d0 fe ff ff    	jne    80105d97 <trap+0xa7>
80105ec7:	e9 e8 fe ff ff       	jmp    80105db4 <trap+0xc4>
80105ecc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80105ed0:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
80105ed4:	8b 7b 38             	mov    0x38(%ebx),%edi
80105ed7:	e8 54 d8 ff ff       	call   80103730 <cpuid>
80105edc:	57                   	push   %edi
80105edd:	56                   	push   %esi
80105ede:	50                   	push   %eax
80105edf:	68 f0 7c 10 80       	push   $0x80107cf0
80105ee4:	e8 77 a7 ff ff       	call   80100660 <cprintf>
    lapiceoi();
80105ee9:	e8 92 c8 ff ff       	call   80102780 <lapiceoi>
    break;
80105eee:	83 c4 10             	add    $0x10,%esp
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105ef1:	e8 5a d8 ff ff       	call   80103750 <myproc>
80105ef6:	85 c0                	test   %eax,%eax
80105ef8:	0f 85 99 fe ff ff    	jne    80105d97 <trap+0xa7>
80105efe:	e9 b1 fe ff ff       	jmp    80105db4 <trap+0xc4>
80105f03:	90                   	nop
80105f04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ideintr();
80105f08:	e8 a3 c1 ff ff       	call   801020b0 <ideintr>
80105f0d:	e9 63 ff ff ff       	jmp    80105e75 <trap+0x185>
80105f12:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit();
80105f18:	e8 23 de ff ff       	call   80103d40 <exit>
80105f1d:	e9 0b ff ff ff       	jmp    80105e2d <trap+0x13d>
80105f22:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit();
80105f28:	e8 13 de ff ff       	call   80103d40 <exit>
80105f2d:	e9 de fe ff ff       	jmp    80105e10 <trap+0x120>
80105f32:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
}
80105f38:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105f3b:	5b                   	pop    %ebx
80105f3c:	5e                   	pop    %esi
80105f3d:	5f                   	pop    %edi
80105f3e:	5d                   	pop    %ebp
    exit();
80105f3f:	e9 fc dd ff ff       	jmp    80103d40 <exit>
80105f44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    exit();
80105f48:	e8 f3 dd ff ff       	call   80103d40 <exit>
80105f4d:	e9 62 fe ff ff       	jmp    80105db4 <trap+0xc4>
80105f52:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      acquire(&tickslock);
80105f58:	83 ec 0c             	sub    $0xc,%esp
80105f5b:	68 60 91 11 80       	push   $0x80119160
80105f60:	e8 eb e8 ff ff       	call   80104850 <acquire>
      wakeup(&ticks);
80105f65:	c7 04 24 a0 99 11 80 	movl   $0x801199a0,(%esp)
      ticks++;
80105f6c:	83 05 a0 99 11 80 01 	addl   $0x1,0x801199a0
      wakeup(&ticks);
80105f73:	e8 08 e1 ff ff       	call   80104080 <wakeup>
      release(&tickslock);
80105f78:	c7 04 24 60 91 11 80 	movl   $0x80119160,(%esp)
80105f7f:	e8 8c e9 ff ff       	call   80104910 <release>
80105f84:	83 c4 10             	add    $0x10,%esp
80105f87:	e9 e9 fe ff ff       	jmp    80105e75 <trap+0x185>
80105f8c:	0f 20 d6             	mov    %cr2,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80105f8f:	e8 9c d7 ff ff       	call   80103730 <cpuid>
80105f94:	83 ec 0c             	sub    $0xc,%esp
80105f97:	56                   	push   %esi
80105f98:	57                   	push   %edi
80105f99:	50                   	push   %eax
80105f9a:	ff 73 30             	pushl  0x30(%ebx)
80105f9d:	68 14 7d 10 80       	push   $0x80107d14
80105fa2:	e8 b9 a6 ff ff       	call   80100660 <cprintf>
      panic("trap");
80105fa7:	83 c4 14             	add    $0x14,%esp
80105faa:	68 ea 7c 10 80       	push   $0x80107cea
80105faf:	e8 dc a3 ff ff       	call   80100390 <panic>
80105fb4:	66 90                	xchg   %ax,%ax
80105fb6:	66 90                	xchg   %ax,%ax
80105fb8:	66 90                	xchg   %ax,%ax
80105fba:	66 90                	xchg   %ax,%ax
80105fbc:	66 90                	xchg   %ax,%ax
80105fbe:	66 90                	xchg   %ax,%ax

80105fc0 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80105fc0:	a1 bc a5 10 80       	mov    0x8010a5bc,%eax
{
80105fc5:	55                   	push   %ebp
80105fc6:	89 e5                	mov    %esp,%ebp
  if(!uart)
80105fc8:	85 c0                	test   %eax,%eax
80105fca:	74 1c                	je     80105fe8 <uartgetc+0x28>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105fcc:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105fd1:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
80105fd2:	a8 01                	test   $0x1,%al
80105fd4:	74 12                	je     80105fe8 <uartgetc+0x28>
80105fd6:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105fdb:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
80105fdc:	0f b6 c0             	movzbl %al,%eax
}
80105fdf:	5d                   	pop    %ebp
80105fe0:	c3                   	ret    
80105fe1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105fe8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105fed:	5d                   	pop    %ebp
80105fee:	c3                   	ret    
80105fef:	90                   	nop

80105ff0 <uartputc.part.0>:
uartputc(int c)
80105ff0:	55                   	push   %ebp
80105ff1:	89 e5                	mov    %esp,%ebp
80105ff3:	57                   	push   %edi
80105ff4:	56                   	push   %esi
80105ff5:	53                   	push   %ebx
80105ff6:	89 c7                	mov    %eax,%edi
80105ff8:	bb 80 00 00 00       	mov    $0x80,%ebx
80105ffd:	be fd 03 00 00       	mov    $0x3fd,%esi
80106002:	83 ec 0c             	sub    $0xc,%esp
80106005:	eb 1b                	jmp    80106022 <uartputc.part.0+0x32>
80106007:	89 f6                	mov    %esi,%esi
80106009:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    microdelay(10);
80106010:	83 ec 0c             	sub    $0xc,%esp
80106013:	6a 0a                	push   $0xa
80106015:	e8 86 c7 ff ff       	call   801027a0 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
8010601a:	83 c4 10             	add    $0x10,%esp
8010601d:	83 eb 01             	sub    $0x1,%ebx
80106020:	74 07                	je     80106029 <uartputc.part.0+0x39>
80106022:	89 f2                	mov    %esi,%edx
80106024:	ec                   	in     (%dx),%al
80106025:	a8 20                	test   $0x20,%al
80106027:	74 e7                	je     80106010 <uartputc.part.0+0x20>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106029:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010602e:	89 f8                	mov    %edi,%eax
80106030:	ee                   	out    %al,(%dx)
}
80106031:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106034:	5b                   	pop    %ebx
80106035:	5e                   	pop    %esi
80106036:	5f                   	pop    %edi
80106037:	5d                   	pop    %ebp
80106038:	c3                   	ret    
80106039:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106040 <uartinit>:
{
80106040:	55                   	push   %ebp
80106041:	31 c9                	xor    %ecx,%ecx
80106043:	89 c8                	mov    %ecx,%eax
80106045:	89 e5                	mov    %esp,%ebp
80106047:	57                   	push   %edi
80106048:	56                   	push   %esi
80106049:	53                   	push   %ebx
8010604a:	bb fa 03 00 00       	mov    $0x3fa,%ebx
8010604f:	89 da                	mov    %ebx,%edx
80106051:	83 ec 0c             	sub    $0xc,%esp
80106054:	ee                   	out    %al,(%dx)
80106055:	bf fb 03 00 00       	mov    $0x3fb,%edi
8010605a:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
8010605f:	89 fa                	mov    %edi,%edx
80106061:	ee                   	out    %al,(%dx)
80106062:	b8 0c 00 00 00       	mov    $0xc,%eax
80106067:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010606c:	ee                   	out    %al,(%dx)
8010606d:	be f9 03 00 00       	mov    $0x3f9,%esi
80106072:	89 c8                	mov    %ecx,%eax
80106074:	89 f2                	mov    %esi,%edx
80106076:	ee                   	out    %al,(%dx)
80106077:	b8 03 00 00 00       	mov    $0x3,%eax
8010607c:	89 fa                	mov    %edi,%edx
8010607e:	ee                   	out    %al,(%dx)
8010607f:	ba fc 03 00 00       	mov    $0x3fc,%edx
80106084:	89 c8                	mov    %ecx,%eax
80106086:	ee                   	out    %al,(%dx)
80106087:	b8 01 00 00 00       	mov    $0x1,%eax
8010608c:	89 f2                	mov    %esi,%edx
8010608e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010608f:	ba fd 03 00 00       	mov    $0x3fd,%edx
80106094:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
80106095:	3c ff                	cmp    $0xff,%al
80106097:	74 5a                	je     801060f3 <uartinit+0xb3>
  uart = 1;
80106099:	c7 05 bc a5 10 80 01 	movl   $0x1,0x8010a5bc
801060a0:	00 00 00 
801060a3:	89 da                	mov    %ebx,%edx
801060a5:	ec                   	in     (%dx),%al
801060a6:	ba f8 03 00 00       	mov    $0x3f8,%edx
801060ab:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
801060ac:	83 ec 08             	sub    $0x8,%esp
  for(p="xv6...\n"; *p; p++)
801060af:	bb 0c 7e 10 80       	mov    $0x80107e0c,%ebx
  ioapicenable(IRQ_COM1, 0);
801060b4:	6a 00                	push   $0x0
801060b6:	6a 04                	push   $0x4
801060b8:	e8 43 c2 ff ff       	call   80102300 <ioapicenable>
801060bd:	83 c4 10             	add    $0x10,%esp
  for(p="xv6...\n"; *p; p++)
801060c0:	b8 78 00 00 00       	mov    $0x78,%eax
801060c5:	eb 13                	jmp    801060da <uartinit+0x9a>
801060c7:	89 f6                	mov    %esi,%esi
801060c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801060d0:	83 c3 01             	add    $0x1,%ebx
801060d3:	0f be 03             	movsbl (%ebx),%eax
801060d6:	84 c0                	test   %al,%al
801060d8:	74 19                	je     801060f3 <uartinit+0xb3>
  if(!uart)
801060da:	8b 15 bc a5 10 80    	mov    0x8010a5bc,%edx
801060e0:	85 d2                	test   %edx,%edx
801060e2:	74 ec                	je     801060d0 <uartinit+0x90>
  for(p="xv6...\n"; *p; p++)
801060e4:	83 c3 01             	add    $0x1,%ebx
801060e7:	e8 04 ff ff ff       	call   80105ff0 <uartputc.part.0>
801060ec:	0f be 03             	movsbl (%ebx),%eax
801060ef:	84 c0                	test   %al,%al
801060f1:	75 e7                	jne    801060da <uartinit+0x9a>
}
801060f3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801060f6:	5b                   	pop    %ebx
801060f7:	5e                   	pop    %esi
801060f8:	5f                   	pop    %edi
801060f9:	5d                   	pop    %ebp
801060fa:	c3                   	ret    
801060fb:	90                   	nop
801060fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106100 <uartputc>:
  if(!uart)
80106100:	8b 15 bc a5 10 80    	mov    0x8010a5bc,%edx
{
80106106:	55                   	push   %ebp
80106107:	89 e5                	mov    %esp,%ebp
  if(!uart)
80106109:	85 d2                	test   %edx,%edx
{
8010610b:	8b 45 08             	mov    0x8(%ebp),%eax
  if(!uart)
8010610e:	74 10                	je     80106120 <uartputc+0x20>
}
80106110:	5d                   	pop    %ebp
80106111:	e9 da fe ff ff       	jmp    80105ff0 <uartputc.part.0>
80106116:	8d 76 00             	lea    0x0(%esi),%esi
80106119:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80106120:	5d                   	pop    %ebp
80106121:	c3                   	ret    
80106122:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106129:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106130 <uartintr>:

void
uartintr(void)
{
80106130:	55                   	push   %ebp
80106131:	89 e5                	mov    %esp,%ebp
80106133:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
80106136:	68 c0 5f 10 80       	push   $0x80105fc0
8010613b:	e8 d0 a6 ff ff       	call   80100810 <consoleintr>
}
80106140:	83 c4 10             	add    $0x10,%esp
80106143:	c9                   	leave  
80106144:	c3                   	ret    

80106145 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80106145:	6a 00                	push   $0x0
  pushl $0
80106147:	6a 00                	push   $0x0
  jmp alltraps
80106149:	e9 b9 fa ff ff       	jmp    80105c07 <alltraps>

8010614e <vector1>:
.globl vector1
vector1:
  pushl $0
8010614e:	6a 00                	push   $0x0
  pushl $1
80106150:	6a 01                	push   $0x1
  jmp alltraps
80106152:	e9 b0 fa ff ff       	jmp    80105c07 <alltraps>

80106157 <vector2>:
.globl vector2
vector2:
  pushl $0
80106157:	6a 00                	push   $0x0
  pushl $2
80106159:	6a 02                	push   $0x2
  jmp alltraps
8010615b:	e9 a7 fa ff ff       	jmp    80105c07 <alltraps>

80106160 <vector3>:
.globl vector3
vector3:
  pushl $0
80106160:	6a 00                	push   $0x0
  pushl $3
80106162:	6a 03                	push   $0x3
  jmp alltraps
80106164:	e9 9e fa ff ff       	jmp    80105c07 <alltraps>

80106169 <vector4>:
.globl vector4
vector4:
  pushl $0
80106169:	6a 00                	push   $0x0
  pushl $4
8010616b:	6a 04                	push   $0x4
  jmp alltraps
8010616d:	e9 95 fa ff ff       	jmp    80105c07 <alltraps>

80106172 <vector5>:
.globl vector5
vector5:
  pushl $0
80106172:	6a 00                	push   $0x0
  pushl $5
80106174:	6a 05                	push   $0x5
  jmp alltraps
80106176:	e9 8c fa ff ff       	jmp    80105c07 <alltraps>

8010617b <vector6>:
.globl vector6
vector6:
  pushl $0
8010617b:	6a 00                	push   $0x0
  pushl $6
8010617d:	6a 06                	push   $0x6
  jmp alltraps
8010617f:	e9 83 fa ff ff       	jmp    80105c07 <alltraps>

80106184 <vector7>:
.globl vector7
vector7:
  pushl $0
80106184:	6a 00                	push   $0x0
  pushl $7
80106186:	6a 07                	push   $0x7
  jmp alltraps
80106188:	e9 7a fa ff ff       	jmp    80105c07 <alltraps>

8010618d <vector8>:
.globl vector8
vector8:
  pushl $8
8010618d:	6a 08                	push   $0x8
  jmp alltraps
8010618f:	e9 73 fa ff ff       	jmp    80105c07 <alltraps>

80106194 <vector9>:
.globl vector9
vector9:
  pushl $0
80106194:	6a 00                	push   $0x0
  pushl $9
80106196:	6a 09                	push   $0x9
  jmp alltraps
80106198:	e9 6a fa ff ff       	jmp    80105c07 <alltraps>

8010619d <vector10>:
.globl vector10
vector10:
  pushl $10
8010619d:	6a 0a                	push   $0xa
  jmp alltraps
8010619f:	e9 63 fa ff ff       	jmp    80105c07 <alltraps>

801061a4 <vector11>:
.globl vector11
vector11:
  pushl $11
801061a4:	6a 0b                	push   $0xb
  jmp alltraps
801061a6:	e9 5c fa ff ff       	jmp    80105c07 <alltraps>

801061ab <vector12>:
.globl vector12
vector12:
  pushl $12
801061ab:	6a 0c                	push   $0xc
  jmp alltraps
801061ad:	e9 55 fa ff ff       	jmp    80105c07 <alltraps>

801061b2 <vector13>:
.globl vector13
vector13:
  pushl $13
801061b2:	6a 0d                	push   $0xd
  jmp alltraps
801061b4:	e9 4e fa ff ff       	jmp    80105c07 <alltraps>

801061b9 <vector14>:
.globl vector14
vector14:
  pushl $14
801061b9:	6a 0e                	push   $0xe
  jmp alltraps
801061bb:	e9 47 fa ff ff       	jmp    80105c07 <alltraps>

801061c0 <vector15>:
.globl vector15
vector15:
  pushl $0
801061c0:	6a 00                	push   $0x0
  pushl $15
801061c2:	6a 0f                	push   $0xf
  jmp alltraps
801061c4:	e9 3e fa ff ff       	jmp    80105c07 <alltraps>

801061c9 <vector16>:
.globl vector16
vector16:
  pushl $0
801061c9:	6a 00                	push   $0x0
  pushl $16
801061cb:	6a 10                	push   $0x10
  jmp alltraps
801061cd:	e9 35 fa ff ff       	jmp    80105c07 <alltraps>

801061d2 <vector17>:
.globl vector17
vector17:
  pushl $17
801061d2:	6a 11                	push   $0x11
  jmp alltraps
801061d4:	e9 2e fa ff ff       	jmp    80105c07 <alltraps>

801061d9 <vector18>:
.globl vector18
vector18:
  pushl $0
801061d9:	6a 00                	push   $0x0
  pushl $18
801061db:	6a 12                	push   $0x12
  jmp alltraps
801061dd:	e9 25 fa ff ff       	jmp    80105c07 <alltraps>

801061e2 <vector19>:
.globl vector19
vector19:
  pushl $0
801061e2:	6a 00                	push   $0x0
  pushl $19
801061e4:	6a 13                	push   $0x13
  jmp alltraps
801061e6:	e9 1c fa ff ff       	jmp    80105c07 <alltraps>

801061eb <vector20>:
.globl vector20
vector20:
  pushl $0
801061eb:	6a 00                	push   $0x0
  pushl $20
801061ed:	6a 14                	push   $0x14
  jmp alltraps
801061ef:	e9 13 fa ff ff       	jmp    80105c07 <alltraps>

801061f4 <vector21>:
.globl vector21
vector21:
  pushl $0
801061f4:	6a 00                	push   $0x0
  pushl $21
801061f6:	6a 15                	push   $0x15
  jmp alltraps
801061f8:	e9 0a fa ff ff       	jmp    80105c07 <alltraps>

801061fd <vector22>:
.globl vector22
vector22:
  pushl $0
801061fd:	6a 00                	push   $0x0
  pushl $22
801061ff:	6a 16                	push   $0x16
  jmp alltraps
80106201:	e9 01 fa ff ff       	jmp    80105c07 <alltraps>

80106206 <vector23>:
.globl vector23
vector23:
  pushl $0
80106206:	6a 00                	push   $0x0
  pushl $23
80106208:	6a 17                	push   $0x17
  jmp alltraps
8010620a:	e9 f8 f9 ff ff       	jmp    80105c07 <alltraps>

8010620f <vector24>:
.globl vector24
vector24:
  pushl $0
8010620f:	6a 00                	push   $0x0
  pushl $24
80106211:	6a 18                	push   $0x18
  jmp alltraps
80106213:	e9 ef f9 ff ff       	jmp    80105c07 <alltraps>

80106218 <vector25>:
.globl vector25
vector25:
  pushl $0
80106218:	6a 00                	push   $0x0
  pushl $25
8010621a:	6a 19                	push   $0x19
  jmp alltraps
8010621c:	e9 e6 f9 ff ff       	jmp    80105c07 <alltraps>

80106221 <vector26>:
.globl vector26
vector26:
  pushl $0
80106221:	6a 00                	push   $0x0
  pushl $26
80106223:	6a 1a                	push   $0x1a
  jmp alltraps
80106225:	e9 dd f9 ff ff       	jmp    80105c07 <alltraps>

8010622a <vector27>:
.globl vector27
vector27:
  pushl $0
8010622a:	6a 00                	push   $0x0
  pushl $27
8010622c:	6a 1b                	push   $0x1b
  jmp alltraps
8010622e:	e9 d4 f9 ff ff       	jmp    80105c07 <alltraps>

80106233 <vector28>:
.globl vector28
vector28:
  pushl $0
80106233:	6a 00                	push   $0x0
  pushl $28
80106235:	6a 1c                	push   $0x1c
  jmp alltraps
80106237:	e9 cb f9 ff ff       	jmp    80105c07 <alltraps>

8010623c <vector29>:
.globl vector29
vector29:
  pushl $0
8010623c:	6a 00                	push   $0x0
  pushl $29
8010623e:	6a 1d                	push   $0x1d
  jmp alltraps
80106240:	e9 c2 f9 ff ff       	jmp    80105c07 <alltraps>

80106245 <vector30>:
.globl vector30
vector30:
  pushl $0
80106245:	6a 00                	push   $0x0
  pushl $30
80106247:	6a 1e                	push   $0x1e
  jmp alltraps
80106249:	e9 b9 f9 ff ff       	jmp    80105c07 <alltraps>

8010624e <vector31>:
.globl vector31
vector31:
  pushl $0
8010624e:	6a 00                	push   $0x0
  pushl $31
80106250:	6a 1f                	push   $0x1f
  jmp alltraps
80106252:	e9 b0 f9 ff ff       	jmp    80105c07 <alltraps>

80106257 <vector32>:
.globl vector32
vector32:
  pushl $0
80106257:	6a 00                	push   $0x0
  pushl $32
80106259:	6a 20                	push   $0x20
  jmp alltraps
8010625b:	e9 a7 f9 ff ff       	jmp    80105c07 <alltraps>

80106260 <vector33>:
.globl vector33
vector33:
  pushl $0
80106260:	6a 00                	push   $0x0
  pushl $33
80106262:	6a 21                	push   $0x21
  jmp alltraps
80106264:	e9 9e f9 ff ff       	jmp    80105c07 <alltraps>

80106269 <vector34>:
.globl vector34
vector34:
  pushl $0
80106269:	6a 00                	push   $0x0
  pushl $34
8010626b:	6a 22                	push   $0x22
  jmp alltraps
8010626d:	e9 95 f9 ff ff       	jmp    80105c07 <alltraps>

80106272 <vector35>:
.globl vector35
vector35:
  pushl $0
80106272:	6a 00                	push   $0x0
  pushl $35
80106274:	6a 23                	push   $0x23
  jmp alltraps
80106276:	e9 8c f9 ff ff       	jmp    80105c07 <alltraps>

8010627b <vector36>:
.globl vector36
vector36:
  pushl $0
8010627b:	6a 00                	push   $0x0
  pushl $36
8010627d:	6a 24                	push   $0x24
  jmp alltraps
8010627f:	e9 83 f9 ff ff       	jmp    80105c07 <alltraps>

80106284 <vector37>:
.globl vector37
vector37:
  pushl $0
80106284:	6a 00                	push   $0x0
  pushl $37
80106286:	6a 25                	push   $0x25
  jmp alltraps
80106288:	e9 7a f9 ff ff       	jmp    80105c07 <alltraps>

8010628d <vector38>:
.globl vector38
vector38:
  pushl $0
8010628d:	6a 00                	push   $0x0
  pushl $38
8010628f:	6a 26                	push   $0x26
  jmp alltraps
80106291:	e9 71 f9 ff ff       	jmp    80105c07 <alltraps>

80106296 <vector39>:
.globl vector39
vector39:
  pushl $0
80106296:	6a 00                	push   $0x0
  pushl $39
80106298:	6a 27                	push   $0x27
  jmp alltraps
8010629a:	e9 68 f9 ff ff       	jmp    80105c07 <alltraps>

8010629f <vector40>:
.globl vector40
vector40:
  pushl $0
8010629f:	6a 00                	push   $0x0
  pushl $40
801062a1:	6a 28                	push   $0x28
  jmp alltraps
801062a3:	e9 5f f9 ff ff       	jmp    80105c07 <alltraps>

801062a8 <vector41>:
.globl vector41
vector41:
  pushl $0
801062a8:	6a 00                	push   $0x0
  pushl $41
801062aa:	6a 29                	push   $0x29
  jmp alltraps
801062ac:	e9 56 f9 ff ff       	jmp    80105c07 <alltraps>

801062b1 <vector42>:
.globl vector42
vector42:
  pushl $0
801062b1:	6a 00                	push   $0x0
  pushl $42
801062b3:	6a 2a                	push   $0x2a
  jmp alltraps
801062b5:	e9 4d f9 ff ff       	jmp    80105c07 <alltraps>

801062ba <vector43>:
.globl vector43
vector43:
  pushl $0
801062ba:	6a 00                	push   $0x0
  pushl $43
801062bc:	6a 2b                	push   $0x2b
  jmp alltraps
801062be:	e9 44 f9 ff ff       	jmp    80105c07 <alltraps>

801062c3 <vector44>:
.globl vector44
vector44:
  pushl $0
801062c3:	6a 00                	push   $0x0
  pushl $44
801062c5:	6a 2c                	push   $0x2c
  jmp alltraps
801062c7:	e9 3b f9 ff ff       	jmp    80105c07 <alltraps>

801062cc <vector45>:
.globl vector45
vector45:
  pushl $0
801062cc:	6a 00                	push   $0x0
  pushl $45
801062ce:	6a 2d                	push   $0x2d
  jmp alltraps
801062d0:	e9 32 f9 ff ff       	jmp    80105c07 <alltraps>

801062d5 <vector46>:
.globl vector46
vector46:
  pushl $0
801062d5:	6a 00                	push   $0x0
  pushl $46
801062d7:	6a 2e                	push   $0x2e
  jmp alltraps
801062d9:	e9 29 f9 ff ff       	jmp    80105c07 <alltraps>

801062de <vector47>:
.globl vector47
vector47:
  pushl $0
801062de:	6a 00                	push   $0x0
  pushl $47
801062e0:	6a 2f                	push   $0x2f
  jmp alltraps
801062e2:	e9 20 f9 ff ff       	jmp    80105c07 <alltraps>

801062e7 <vector48>:
.globl vector48
vector48:
  pushl $0
801062e7:	6a 00                	push   $0x0
  pushl $48
801062e9:	6a 30                	push   $0x30
  jmp alltraps
801062eb:	e9 17 f9 ff ff       	jmp    80105c07 <alltraps>

801062f0 <vector49>:
.globl vector49
vector49:
  pushl $0
801062f0:	6a 00                	push   $0x0
  pushl $49
801062f2:	6a 31                	push   $0x31
  jmp alltraps
801062f4:	e9 0e f9 ff ff       	jmp    80105c07 <alltraps>

801062f9 <vector50>:
.globl vector50
vector50:
  pushl $0
801062f9:	6a 00                	push   $0x0
  pushl $50
801062fb:	6a 32                	push   $0x32
  jmp alltraps
801062fd:	e9 05 f9 ff ff       	jmp    80105c07 <alltraps>

80106302 <vector51>:
.globl vector51
vector51:
  pushl $0
80106302:	6a 00                	push   $0x0
  pushl $51
80106304:	6a 33                	push   $0x33
  jmp alltraps
80106306:	e9 fc f8 ff ff       	jmp    80105c07 <alltraps>

8010630b <vector52>:
.globl vector52
vector52:
  pushl $0
8010630b:	6a 00                	push   $0x0
  pushl $52
8010630d:	6a 34                	push   $0x34
  jmp alltraps
8010630f:	e9 f3 f8 ff ff       	jmp    80105c07 <alltraps>

80106314 <vector53>:
.globl vector53
vector53:
  pushl $0
80106314:	6a 00                	push   $0x0
  pushl $53
80106316:	6a 35                	push   $0x35
  jmp alltraps
80106318:	e9 ea f8 ff ff       	jmp    80105c07 <alltraps>

8010631d <vector54>:
.globl vector54
vector54:
  pushl $0
8010631d:	6a 00                	push   $0x0
  pushl $54
8010631f:	6a 36                	push   $0x36
  jmp alltraps
80106321:	e9 e1 f8 ff ff       	jmp    80105c07 <alltraps>

80106326 <vector55>:
.globl vector55
vector55:
  pushl $0
80106326:	6a 00                	push   $0x0
  pushl $55
80106328:	6a 37                	push   $0x37
  jmp alltraps
8010632a:	e9 d8 f8 ff ff       	jmp    80105c07 <alltraps>

8010632f <vector56>:
.globl vector56
vector56:
  pushl $0
8010632f:	6a 00                	push   $0x0
  pushl $56
80106331:	6a 38                	push   $0x38
  jmp alltraps
80106333:	e9 cf f8 ff ff       	jmp    80105c07 <alltraps>

80106338 <vector57>:
.globl vector57
vector57:
  pushl $0
80106338:	6a 00                	push   $0x0
  pushl $57
8010633a:	6a 39                	push   $0x39
  jmp alltraps
8010633c:	e9 c6 f8 ff ff       	jmp    80105c07 <alltraps>

80106341 <vector58>:
.globl vector58
vector58:
  pushl $0
80106341:	6a 00                	push   $0x0
  pushl $58
80106343:	6a 3a                	push   $0x3a
  jmp alltraps
80106345:	e9 bd f8 ff ff       	jmp    80105c07 <alltraps>

8010634a <vector59>:
.globl vector59
vector59:
  pushl $0
8010634a:	6a 00                	push   $0x0
  pushl $59
8010634c:	6a 3b                	push   $0x3b
  jmp alltraps
8010634e:	e9 b4 f8 ff ff       	jmp    80105c07 <alltraps>

80106353 <vector60>:
.globl vector60
vector60:
  pushl $0
80106353:	6a 00                	push   $0x0
  pushl $60
80106355:	6a 3c                	push   $0x3c
  jmp alltraps
80106357:	e9 ab f8 ff ff       	jmp    80105c07 <alltraps>

8010635c <vector61>:
.globl vector61
vector61:
  pushl $0
8010635c:	6a 00                	push   $0x0
  pushl $61
8010635e:	6a 3d                	push   $0x3d
  jmp alltraps
80106360:	e9 a2 f8 ff ff       	jmp    80105c07 <alltraps>

80106365 <vector62>:
.globl vector62
vector62:
  pushl $0
80106365:	6a 00                	push   $0x0
  pushl $62
80106367:	6a 3e                	push   $0x3e
  jmp alltraps
80106369:	e9 99 f8 ff ff       	jmp    80105c07 <alltraps>

8010636e <vector63>:
.globl vector63
vector63:
  pushl $0
8010636e:	6a 00                	push   $0x0
  pushl $63
80106370:	6a 3f                	push   $0x3f
  jmp alltraps
80106372:	e9 90 f8 ff ff       	jmp    80105c07 <alltraps>

80106377 <vector64>:
.globl vector64
vector64:
  pushl $0
80106377:	6a 00                	push   $0x0
  pushl $64
80106379:	6a 40                	push   $0x40
  jmp alltraps
8010637b:	e9 87 f8 ff ff       	jmp    80105c07 <alltraps>

80106380 <vector65>:
.globl vector65
vector65:
  pushl $0
80106380:	6a 00                	push   $0x0
  pushl $65
80106382:	6a 41                	push   $0x41
  jmp alltraps
80106384:	e9 7e f8 ff ff       	jmp    80105c07 <alltraps>

80106389 <vector66>:
.globl vector66
vector66:
  pushl $0
80106389:	6a 00                	push   $0x0
  pushl $66
8010638b:	6a 42                	push   $0x42
  jmp alltraps
8010638d:	e9 75 f8 ff ff       	jmp    80105c07 <alltraps>

80106392 <vector67>:
.globl vector67
vector67:
  pushl $0
80106392:	6a 00                	push   $0x0
  pushl $67
80106394:	6a 43                	push   $0x43
  jmp alltraps
80106396:	e9 6c f8 ff ff       	jmp    80105c07 <alltraps>

8010639b <vector68>:
.globl vector68
vector68:
  pushl $0
8010639b:	6a 00                	push   $0x0
  pushl $68
8010639d:	6a 44                	push   $0x44
  jmp alltraps
8010639f:	e9 63 f8 ff ff       	jmp    80105c07 <alltraps>

801063a4 <vector69>:
.globl vector69
vector69:
  pushl $0
801063a4:	6a 00                	push   $0x0
  pushl $69
801063a6:	6a 45                	push   $0x45
  jmp alltraps
801063a8:	e9 5a f8 ff ff       	jmp    80105c07 <alltraps>

801063ad <vector70>:
.globl vector70
vector70:
  pushl $0
801063ad:	6a 00                	push   $0x0
  pushl $70
801063af:	6a 46                	push   $0x46
  jmp alltraps
801063b1:	e9 51 f8 ff ff       	jmp    80105c07 <alltraps>

801063b6 <vector71>:
.globl vector71
vector71:
  pushl $0
801063b6:	6a 00                	push   $0x0
  pushl $71
801063b8:	6a 47                	push   $0x47
  jmp alltraps
801063ba:	e9 48 f8 ff ff       	jmp    80105c07 <alltraps>

801063bf <vector72>:
.globl vector72
vector72:
  pushl $0
801063bf:	6a 00                	push   $0x0
  pushl $72
801063c1:	6a 48                	push   $0x48
  jmp alltraps
801063c3:	e9 3f f8 ff ff       	jmp    80105c07 <alltraps>

801063c8 <vector73>:
.globl vector73
vector73:
  pushl $0
801063c8:	6a 00                	push   $0x0
  pushl $73
801063ca:	6a 49                	push   $0x49
  jmp alltraps
801063cc:	e9 36 f8 ff ff       	jmp    80105c07 <alltraps>

801063d1 <vector74>:
.globl vector74
vector74:
  pushl $0
801063d1:	6a 00                	push   $0x0
  pushl $74
801063d3:	6a 4a                	push   $0x4a
  jmp alltraps
801063d5:	e9 2d f8 ff ff       	jmp    80105c07 <alltraps>

801063da <vector75>:
.globl vector75
vector75:
  pushl $0
801063da:	6a 00                	push   $0x0
  pushl $75
801063dc:	6a 4b                	push   $0x4b
  jmp alltraps
801063de:	e9 24 f8 ff ff       	jmp    80105c07 <alltraps>

801063e3 <vector76>:
.globl vector76
vector76:
  pushl $0
801063e3:	6a 00                	push   $0x0
  pushl $76
801063e5:	6a 4c                	push   $0x4c
  jmp alltraps
801063e7:	e9 1b f8 ff ff       	jmp    80105c07 <alltraps>

801063ec <vector77>:
.globl vector77
vector77:
  pushl $0
801063ec:	6a 00                	push   $0x0
  pushl $77
801063ee:	6a 4d                	push   $0x4d
  jmp alltraps
801063f0:	e9 12 f8 ff ff       	jmp    80105c07 <alltraps>

801063f5 <vector78>:
.globl vector78
vector78:
  pushl $0
801063f5:	6a 00                	push   $0x0
  pushl $78
801063f7:	6a 4e                	push   $0x4e
  jmp alltraps
801063f9:	e9 09 f8 ff ff       	jmp    80105c07 <alltraps>

801063fe <vector79>:
.globl vector79
vector79:
  pushl $0
801063fe:	6a 00                	push   $0x0
  pushl $79
80106400:	6a 4f                	push   $0x4f
  jmp alltraps
80106402:	e9 00 f8 ff ff       	jmp    80105c07 <alltraps>

80106407 <vector80>:
.globl vector80
vector80:
  pushl $0
80106407:	6a 00                	push   $0x0
  pushl $80
80106409:	6a 50                	push   $0x50
  jmp alltraps
8010640b:	e9 f7 f7 ff ff       	jmp    80105c07 <alltraps>

80106410 <vector81>:
.globl vector81
vector81:
  pushl $0
80106410:	6a 00                	push   $0x0
  pushl $81
80106412:	6a 51                	push   $0x51
  jmp alltraps
80106414:	e9 ee f7 ff ff       	jmp    80105c07 <alltraps>

80106419 <vector82>:
.globl vector82
vector82:
  pushl $0
80106419:	6a 00                	push   $0x0
  pushl $82
8010641b:	6a 52                	push   $0x52
  jmp alltraps
8010641d:	e9 e5 f7 ff ff       	jmp    80105c07 <alltraps>

80106422 <vector83>:
.globl vector83
vector83:
  pushl $0
80106422:	6a 00                	push   $0x0
  pushl $83
80106424:	6a 53                	push   $0x53
  jmp alltraps
80106426:	e9 dc f7 ff ff       	jmp    80105c07 <alltraps>

8010642b <vector84>:
.globl vector84
vector84:
  pushl $0
8010642b:	6a 00                	push   $0x0
  pushl $84
8010642d:	6a 54                	push   $0x54
  jmp alltraps
8010642f:	e9 d3 f7 ff ff       	jmp    80105c07 <alltraps>

80106434 <vector85>:
.globl vector85
vector85:
  pushl $0
80106434:	6a 00                	push   $0x0
  pushl $85
80106436:	6a 55                	push   $0x55
  jmp alltraps
80106438:	e9 ca f7 ff ff       	jmp    80105c07 <alltraps>

8010643d <vector86>:
.globl vector86
vector86:
  pushl $0
8010643d:	6a 00                	push   $0x0
  pushl $86
8010643f:	6a 56                	push   $0x56
  jmp alltraps
80106441:	e9 c1 f7 ff ff       	jmp    80105c07 <alltraps>

80106446 <vector87>:
.globl vector87
vector87:
  pushl $0
80106446:	6a 00                	push   $0x0
  pushl $87
80106448:	6a 57                	push   $0x57
  jmp alltraps
8010644a:	e9 b8 f7 ff ff       	jmp    80105c07 <alltraps>

8010644f <vector88>:
.globl vector88
vector88:
  pushl $0
8010644f:	6a 00                	push   $0x0
  pushl $88
80106451:	6a 58                	push   $0x58
  jmp alltraps
80106453:	e9 af f7 ff ff       	jmp    80105c07 <alltraps>

80106458 <vector89>:
.globl vector89
vector89:
  pushl $0
80106458:	6a 00                	push   $0x0
  pushl $89
8010645a:	6a 59                	push   $0x59
  jmp alltraps
8010645c:	e9 a6 f7 ff ff       	jmp    80105c07 <alltraps>

80106461 <vector90>:
.globl vector90
vector90:
  pushl $0
80106461:	6a 00                	push   $0x0
  pushl $90
80106463:	6a 5a                	push   $0x5a
  jmp alltraps
80106465:	e9 9d f7 ff ff       	jmp    80105c07 <alltraps>

8010646a <vector91>:
.globl vector91
vector91:
  pushl $0
8010646a:	6a 00                	push   $0x0
  pushl $91
8010646c:	6a 5b                	push   $0x5b
  jmp alltraps
8010646e:	e9 94 f7 ff ff       	jmp    80105c07 <alltraps>

80106473 <vector92>:
.globl vector92
vector92:
  pushl $0
80106473:	6a 00                	push   $0x0
  pushl $92
80106475:	6a 5c                	push   $0x5c
  jmp alltraps
80106477:	e9 8b f7 ff ff       	jmp    80105c07 <alltraps>

8010647c <vector93>:
.globl vector93
vector93:
  pushl $0
8010647c:	6a 00                	push   $0x0
  pushl $93
8010647e:	6a 5d                	push   $0x5d
  jmp alltraps
80106480:	e9 82 f7 ff ff       	jmp    80105c07 <alltraps>

80106485 <vector94>:
.globl vector94
vector94:
  pushl $0
80106485:	6a 00                	push   $0x0
  pushl $94
80106487:	6a 5e                	push   $0x5e
  jmp alltraps
80106489:	e9 79 f7 ff ff       	jmp    80105c07 <alltraps>

8010648e <vector95>:
.globl vector95
vector95:
  pushl $0
8010648e:	6a 00                	push   $0x0
  pushl $95
80106490:	6a 5f                	push   $0x5f
  jmp alltraps
80106492:	e9 70 f7 ff ff       	jmp    80105c07 <alltraps>

80106497 <vector96>:
.globl vector96
vector96:
  pushl $0
80106497:	6a 00                	push   $0x0
  pushl $96
80106499:	6a 60                	push   $0x60
  jmp alltraps
8010649b:	e9 67 f7 ff ff       	jmp    80105c07 <alltraps>

801064a0 <vector97>:
.globl vector97
vector97:
  pushl $0
801064a0:	6a 00                	push   $0x0
  pushl $97
801064a2:	6a 61                	push   $0x61
  jmp alltraps
801064a4:	e9 5e f7 ff ff       	jmp    80105c07 <alltraps>

801064a9 <vector98>:
.globl vector98
vector98:
  pushl $0
801064a9:	6a 00                	push   $0x0
  pushl $98
801064ab:	6a 62                	push   $0x62
  jmp alltraps
801064ad:	e9 55 f7 ff ff       	jmp    80105c07 <alltraps>

801064b2 <vector99>:
.globl vector99
vector99:
  pushl $0
801064b2:	6a 00                	push   $0x0
  pushl $99
801064b4:	6a 63                	push   $0x63
  jmp alltraps
801064b6:	e9 4c f7 ff ff       	jmp    80105c07 <alltraps>

801064bb <vector100>:
.globl vector100
vector100:
  pushl $0
801064bb:	6a 00                	push   $0x0
  pushl $100
801064bd:	6a 64                	push   $0x64
  jmp alltraps
801064bf:	e9 43 f7 ff ff       	jmp    80105c07 <alltraps>

801064c4 <vector101>:
.globl vector101
vector101:
  pushl $0
801064c4:	6a 00                	push   $0x0
  pushl $101
801064c6:	6a 65                	push   $0x65
  jmp alltraps
801064c8:	e9 3a f7 ff ff       	jmp    80105c07 <alltraps>

801064cd <vector102>:
.globl vector102
vector102:
  pushl $0
801064cd:	6a 00                	push   $0x0
  pushl $102
801064cf:	6a 66                	push   $0x66
  jmp alltraps
801064d1:	e9 31 f7 ff ff       	jmp    80105c07 <alltraps>

801064d6 <vector103>:
.globl vector103
vector103:
  pushl $0
801064d6:	6a 00                	push   $0x0
  pushl $103
801064d8:	6a 67                	push   $0x67
  jmp alltraps
801064da:	e9 28 f7 ff ff       	jmp    80105c07 <alltraps>

801064df <vector104>:
.globl vector104
vector104:
  pushl $0
801064df:	6a 00                	push   $0x0
  pushl $104
801064e1:	6a 68                	push   $0x68
  jmp alltraps
801064e3:	e9 1f f7 ff ff       	jmp    80105c07 <alltraps>

801064e8 <vector105>:
.globl vector105
vector105:
  pushl $0
801064e8:	6a 00                	push   $0x0
  pushl $105
801064ea:	6a 69                	push   $0x69
  jmp alltraps
801064ec:	e9 16 f7 ff ff       	jmp    80105c07 <alltraps>

801064f1 <vector106>:
.globl vector106
vector106:
  pushl $0
801064f1:	6a 00                	push   $0x0
  pushl $106
801064f3:	6a 6a                	push   $0x6a
  jmp alltraps
801064f5:	e9 0d f7 ff ff       	jmp    80105c07 <alltraps>

801064fa <vector107>:
.globl vector107
vector107:
  pushl $0
801064fa:	6a 00                	push   $0x0
  pushl $107
801064fc:	6a 6b                	push   $0x6b
  jmp alltraps
801064fe:	e9 04 f7 ff ff       	jmp    80105c07 <alltraps>

80106503 <vector108>:
.globl vector108
vector108:
  pushl $0
80106503:	6a 00                	push   $0x0
  pushl $108
80106505:	6a 6c                	push   $0x6c
  jmp alltraps
80106507:	e9 fb f6 ff ff       	jmp    80105c07 <alltraps>

8010650c <vector109>:
.globl vector109
vector109:
  pushl $0
8010650c:	6a 00                	push   $0x0
  pushl $109
8010650e:	6a 6d                	push   $0x6d
  jmp alltraps
80106510:	e9 f2 f6 ff ff       	jmp    80105c07 <alltraps>

80106515 <vector110>:
.globl vector110
vector110:
  pushl $0
80106515:	6a 00                	push   $0x0
  pushl $110
80106517:	6a 6e                	push   $0x6e
  jmp alltraps
80106519:	e9 e9 f6 ff ff       	jmp    80105c07 <alltraps>

8010651e <vector111>:
.globl vector111
vector111:
  pushl $0
8010651e:	6a 00                	push   $0x0
  pushl $111
80106520:	6a 6f                	push   $0x6f
  jmp alltraps
80106522:	e9 e0 f6 ff ff       	jmp    80105c07 <alltraps>

80106527 <vector112>:
.globl vector112
vector112:
  pushl $0
80106527:	6a 00                	push   $0x0
  pushl $112
80106529:	6a 70                	push   $0x70
  jmp alltraps
8010652b:	e9 d7 f6 ff ff       	jmp    80105c07 <alltraps>

80106530 <vector113>:
.globl vector113
vector113:
  pushl $0
80106530:	6a 00                	push   $0x0
  pushl $113
80106532:	6a 71                	push   $0x71
  jmp alltraps
80106534:	e9 ce f6 ff ff       	jmp    80105c07 <alltraps>

80106539 <vector114>:
.globl vector114
vector114:
  pushl $0
80106539:	6a 00                	push   $0x0
  pushl $114
8010653b:	6a 72                	push   $0x72
  jmp alltraps
8010653d:	e9 c5 f6 ff ff       	jmp    80105c07 <alltraps>

80106542 <vector115>:
.globl vector115
vector115:
  pushl $0
80106542:	6a 00                	push   $0x0
  pushl $115
80106544:	6a 73                	push   $0x73
  jmp alltraps
80106546:	e9 bc f6 ff ff       	jmp    80105c07 <alltraps>

8010654b <vector116>:
.globl vector116
vector116:
  pushl $0
8010654b:	6a 00                	push   $0x0
  pushl $116
8010654d:	6a 74                	push   $0x74
  jmp alltraps
8010654f:	e9 b3 f6 ff ff       	jmp    80105c07 <alltraps>

80106554 <vector117>:
.globl vector117
vector117:
  pushl $0
80106554:	6a 00                	push   $0x0
  pushl $117
80106556:	6a 75                	push   $0x75
  jmp alltraps
80106558:	e9 aa f6 ff ff       	jmp    80105c07 <alltraps>

8010655d <vector118>:
.globl vector118
vector118:
  pushl $0
8010655d:	6a 00                	push   $0x0
  pushl $118
8010655f:	6a 76                	push   $0x76
  jmp alltraps
80106561:	e9 a1 f6 ff ff       	jmp    80105c07 <alltraps>

80106566 <vector119>:
.globl vector119
vector119:
  pushl $0
80106566:	6a 00                	push   $0x0
  pushl $119
80106568:	6a 77                	push   $0x77
  jmp alltraps
8010656a:	e9 98 f6 ff ff       	jmp    80105c07 <alltraps>

8010656f <vector120>:
.globl vector120
vector120:
  pushl $0
8010656f:	6a 00                	push   $0x0
  pushl $120
80106571:	6a 78                	push   $0x78
  jmp alltraps
80106573:	e9 8f f6 ff ff       	jmp    80105c07 <alltraps>

80106578 <vector121>:
.globl vector121
vector121:
  pushl $0
80106578:	6a 00                	push   $0x0
  pushl $121
8010657a:	6a 79                	push   $0x79
  jmp alltraps
8010657c:	e9 86 f6 ff ff       	jmp    80105c07 <alltraps>

80106581 <vector122>:
.globl vector122
vector122:
  pushl $0
80106581:	6a 00                	push   $0x0
  pushl $122
80106583:	6a 7a                	push   $0x7a
  jmp alltraps
80106585:	e9 7d f6 ff ff       	jmp    80105c07 <alltraps>

8010658a <vector123>:
.globl vector123
vector123:
  pushl $0
8010658a:	6a 00                	push   $0x0
  pushl $123
8010658c:	6a 7b                	push   $0x7b
  jmp alltraps
8010658e:	e9 74 f6 ff ff       	jmp    80105c07 <alltraps>

80106593 <vector124>:
.globl vector124
vector124:
  pushl $0
80106593:	6a 00                	push   $0x0
  pushl $124
80106595:	6a 7c                	push   $0x7c
  jmp alltraps
80106597:	e9 6b f6 ff ff       	jmp    80105c07 <alltraps>

8010659c <vector125>:
.globl vector125
vector125:
  pushl $0
8010659c:	6a 00                	push   $0x0
  pushl $125
8010659e:	6a 7d                	push   $0x7d
  jmp alltraps
801065a0:	e9 62 f6 ff ff       	jmp    80105c07 <alltraps>

801065a5 <vector126>:
.globl vector126
vector126:
  pushl $0
801065a5:	6a 00                	push   $0x0
  pushl $126
801065a7:	6a 7e                	push   $0x7e
  jmp alltraps
801065a9:	e9 59 f6 ff ff       	jmp    80105c07 <alltraps>

801065ae <vector127>:
.globl vector127
vector127:
  pushl $0
801065ae:	6a 00                	push   $0x0
  pushl $127
801065b0:	6a 7f                	push   $0x7f
  jmp alltraps
801065b2:	e9 50 f6 ff ff       	jmp    80105c07 <alltraps>

801065b7 <vector128>:
.globl vector128
vector128:
  pushl $0
801065b7:	6a 00                	push   $0x0
  pushl $128
801065b9:	68 80 00 00 00       	push   $0x80
  jmp alltraps
801065be:	e9 44 f6 ff ff       	jmp    80105c07 <alltraps>

801065c3 <vector129>:
.globl vector129
vector129:
  pushl $0
801065c3:	6a 00                	push   $0x0
  pushl $129
801065c5:	68 81 00 00 00       	push   $0x81
  jmp alltraps
801065ca:	e9 38 f6 ff ff       	jmp    80105c07 <alltraps>

801065cf <vector130>:
.globl vector130
vector130:
  pushl $0
801065cf:	6a 00                	push   $0x0
  pushl $130
801065d1:	68 82 00 00 00       	push   $0x82
  jmp alltraps
801065d6:	e9 2c f6 ff ff       	jmp    80105c07 <alltraps>

801065db <vector131>:
.globl vector131
vector131:
  pushl $0
801065db:	6a 00                	push   $0x0
  pushl $131
801065dd:	68 83 00 00 00       	push   $0x83
  jmp alltraps
801065e2:	e9 20 f6 ff ff       	jmp    80105c07 <alltraps>

801065e7 <vector132>:
.globl vector132
vector132:
  pushl $0
801065e7:	6a 00                	push   $0x0
  pushl $132
801065e9:	68 84 00 00 00       	push   $0x84
  jmp alltraps
801065ee:	e9 14 f6 ff ff       	jmp    80105c07 <alltraps>

801065f3 <vector133>:
.globl vector133
vector133:
  pushl $0
801065f3:	6a 00                	push   $0x0
  pushl $133
801065f5:	68 85 00 00 00       	push   $0x85
  jmp alltraps
801065fa:	e9 08 f6 ff ff       	jmp    80105c07 <alltraps>

801065ff <vector134>:
.globl vector134
vector134:
  pushl $0
801065ff:	6a 00                	push   $0x0
  pushl $134
80106601:	68 86 00 00 00       	push   $0x86
  jmp alltraps
80106606:	e9 fc f5 ff ff       	jmp    80105c07 <alltraps>

8010660b <vector135>:
.globl vector135
vector135:
  pushl $0
8010660b:	6a 00                	push   $0x0
  pushl $135
8010660d:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80106612:	e9 f0 f5 ff ff       	jmp    80105c07 <alltraps>

80106617 <vector136>:
.globl vector136
vector136:
  pushl $0
80106617:	6a 00                	push   $0x0
  pushl $136
80106619:	68 88 00 00 00       	push   $0x88
  jmp alltraps
8010661e:	e9 e4 f5 ff ff       	jmp    80105c07 <alltraps>

80106623 <vector137>:
.globl vector137
vector137:
  pushl $0
80106623:	6a 00                	push   $0x0
  pushl $137
80106625:	68 89 00 00 00       	push   $0x89
  jmp alltraps
8010662a:	e9 d8 f5 ff ff       	jmp    80105c07 <alltraps>

8010662f <vector138>:
.globl vector138
vector138:
  pushl $0
8010662f:	6a 00                	push   $0x0
  pushl $138
80106631:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
80106636:	e9 cc f5 ff ff       	jmp    80105c07 <alltraps>

8010663b <vector139>:
.globl vector139
vector139:
  pushl $0
8010663b:	6a 00                	push   $0x0
  pushl $139
8010663d:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
80106642:	e9 c0 f5 ff ff       	jmp    80105c07 <alltraps>

80106647 <vector140>:
.globl vector140
vector140:
  pushl $0
80106647:	6a 00                	push   $0x0
  pushl $140
80106649:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
8010664e:	e9 b4 f5 ff ff       	jmp    80105c07 <alltraps>

80106653 <vector141>:
.globl vector141
vector141:
  pushl $0
80106653:	6a 00                	push   $0x0
  pushl $141
80106655:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
8010665a:	e9 a8 f5 ff ff       	jmp    80105c07 <alltraps>

8010665f <vector142>:
.globl vector142
vector142:
  pushl $0
8010665f:	6a 00                	push   $0x0
  pushl $142
80106661:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80106666:	e9 9c f5 ff ff       	jmp    80105c07 <alltraps>

8010666b <vector143>:
.globl vector143
vector143:
  pushl $0
8010666b:	6a 00                	push   $0x0
  pushl $143
8010666d:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80106672:	e9 90 f5 ff ff       	jmp    80105c07 <alltraps>

80106677 <vector144>:
.globl vector144
vector144:
  pushl $0
80106677:	6a 00                	push   $0x0
  pushl $144
80106679:	68 90 00 00 00       	push   $0x90
  jmp alltraps
8010667e:	e9 84 f5 ff ff       	jmp    80105c07 <alltraps>

80106683 <vector145>:
.globl vector145
vector145:
  pushl $0
80106683:	6a 00                	push   $0x0
  pushl $145
80106685:	68 91 00 00 00       	push   $0x91
  jmp alltraps
8010668a:	e9 78 f5 ff ff       	jmp    80105c07 <alltraps>

8010668f <vector146>:
.globl vector146
vector146:
  pushl $0
8010668f:	6a 00                	push   $0x0
  pushl $146
80106691:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80106696:	e9 6c f5 ff ff       	jmp    80105c07 <alltraps>

8010669b <vector147>:
.globl vector147
vector147:
  pushl $0
8010669b:	6a 00                	push   $0x0
  pushl $147
8010669d:	68 93 00 00 00       	push   $0x93
  jmp alltraps
801066a2:	e9 60 f5 ff ff       	jmp    80105c07 <alltraps>

801066a7 <vector148>:
.globl vector148
vector148:
  pushl $0
801066a7:	6a 00                	push   $0x0
  pushl $148
801066a9:	68 94 00 00 00       	push   $0x94
  jmp alltraps
801066ae:	e9 54 f5 ff ff       	jmp    80105c07 <alltraps>

801066b3 <vector149>:
.globl vector149
vector149:
  pushl $0
801066b3:	6a 00                	push   $0x0
  pushl $149
801066b5:	68 95 00 00 00       	push   $0x95
  jmp alltraps
801066ba:	e9 48 f5 ff ff       	jmp    80105c07 <alltraps>

801066bf <vector150>:
.globl vector150
vector150:
  pushl $0
801066bf:	6a 00                	push   $0x0
  pushl $150
801066c1:	68 96 00 00 00       	push   $0x96
  jmp alltraps
801066c6:	e9 3c f5 ff ff       	jmp    80105c07 <alltraps>

801066cb <vector151>:
.globl vector151
vector151:
  pushl $0
801066cb:	6a 00                	push   $0x0
  pushl $151
801066cd:	68 97 00 00 00       	push   $0x97
  jmp alltraps
801066d2:	e9 30 f5 ff ff       	jmp    80105c07 <alltraps>

801066d7 <vector152>:
.globl vector152
vector152:
  pushl $0
801066d7:	6a 00                	push   $0x0
  pushl $152
801066d9:	68 98 00 00 00       	push   $0x98
  jmp alltraps
801066de:	e9 24 f5 ff ff       	jmp    80105c07 <alltraps>

801066e3 <vector153>:
.globl vector153
vector153:
  pushl $0
801066e3:	6a 00                	push   $0x0
  pushl $153
801066e5:	68 99 00 00 00       	push   $0x99
  jmp alltraps
801066ea:	e9 18 f5 ff ff       	jmp    80105c07 <alltraps>

801066ef <vector154>:
.globl vector154
vector154:
  pushl $0
801066ef:	6a 00                	push   $0x0
  pushl $154
801066f1:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
801066f6:	e9 0c f5 ff ff       	jmp    80105c07 <alltraps>

801066fb <vector155>:
.globl vector155
vector155:
  pushl $0
801066fb:	6a 00                	push   $0x0
  pushl $155
801066fd:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
80106702:	e9 00 f5 ff ff       	jmp    80105c07 <alltraps>

80106707 <vector156>:
.globl vector156
vector156:
  pushl $0
80106707:	6a 00                	push   $0x0
  pushl $156
80106709:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
8010670e:	e9 f4 f4 ff ff       	jmp    80105c07 <alltraps>

80106713 <vector157>:
.globl vector157
vector157:
  pushl $0
80106713:	6a 00                	push   $0x0
  pushl $157
80106715:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
8010671a:	e9 e8 f4 ff ff       	jmp    80105c07 <alltraps>

8010671f <vector158>:
.globl vector158
vector158:
  pushl $0
8010671f:	6a 00                	push   $0x0
  pushl $158
80106721:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
80106726:	e9 dc f4 ff ff       	jmp    80105c07 <alltraps>

8010672b <vector159>:
.globl vector159
vector159:
  pushl $0
8010672b:	6a 00                	push   $0x0
  pushl $159
8010672d:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
80106732:	e9 d0 f4 ff ff       	jmp    80105c07 <alltraps>

80106737 <vector160>:
.globl vector160
vector160:
  pushl $0
80106737:	6a 00                	push   $0x0
  pushl $160
80106739:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
8010673e:	e9 c4 f4 ff ff       	jmp    80105c07 <alltraps>

80106743 <vector161>:
.globl vector161
vector161:
  pushl $0
80106743:	6a 00                	push   $0x0
  pushl $161
80106745:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
8010674a:	e9 b8 f4 ff ff       	jmp    80105c07 <alltraps>

8010674f <vector162>:
.globl vector162
vector162:
  pushl $0
8010674f:	6a 00                	push   $0x0
  pushl $162
80106751:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
80106756:	e9 ac f4 ff ff       	jmp    80105c07 <alltraps>

8010675b <vector163>:
.globl vector163
vector163:
  pushl $0
8010675b:	6a 00                	push   $0x0
  pushl $163
8010675d:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
80106762:	e9 a0 f4 ff ff       	jmp    80105c07 <alltraps>

80106767 <vector164>:
.globl vector164
vector164:
  pushl $0
80106767:	6a 00                	push   $0x0
  pushl $164
80106769:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
8010676e:	e9 94 f4 ff ff       	jmp    80105c07 <alltraps>

80106773 <vector165>:
.globl vector165
vector165:
  pushl $0
80106773:	6a 00                	push   $0x0
  pushl $165
80106775:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
8010677a:	e9 88 f4 ff ff       	jmp    80105c07 <alltraps>

8010677f <vector166>:
.globl vector166
vector166:
  pushl $0
8010677f:	6a 00                	push   $0x0
  pushl $166
80106781:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80106786:	e9 7c f4 ff ff       	jmp    80105c07 <alltraps>

8010678b <vector167>:
.globl vector167
vector167:
  pushl $0
8010678b:	6a 00                	push   $0x0
  pushl $167
8010678d:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80106792:	e9 70 f4 ff ff       	jmp    80105c07 <alltraps>

80106797 <vector168>:
.globl vector168
vector168:
  pushl $0
80106797:	6a 00                	push   $0x0
  pushl $168
80106799:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
8010679e:	e9 64 f4 ff ff       	jmp    80105c07 <alltraps>

801067a3 <vector169>:
.globl vector169
vector169:
  pushl $0
801067a3:	6a 00                	push   $0x0
  pushl $169
801067a5:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
801067aa:	e9 58 f4 ff ff       	jmp    80105c07 <alltraps>

801067af <vector170>:
.globl vector170
vector170:
  pushl $0
801067af:	6a 00                	push   $0x0
  pushl $170
801067b1:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
801067b6:	e9 4c f4 ff ff       	jmp    80105c07 <alltraps>

801067bb <vector171>:
.globl vector171
vector171:
  pushl $0
801067bb:	6a 00                	push   $0x0
  pushl $171
801067bd:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
801067c2:	e9 40 f4 ff ff       	jmp    80105c07 <alltraps>

801067c7 <vector172>:
.globl vector172
vector172:
  pushl $0
801067c7:	6a 00                	push   $0x0
  pushl $172
801067c9:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
801067ce:	e9 34 f4 ff ff       	jmp    80105c07 <alltraps>

801067d3 <vector173>:
.globl vector173
vector173:
  pushl $0
801067d3:	6a 00                	push   $0x0
  pushl $173
801067d5:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
801067da:	e9 28 f4 ff ff       	jmp    80105c07 <alltraps>

801067df <vector174>:
.globl vector174
vector174:
  pushl $0
801067df:	6a 00                	push   $0x0
  pushl $174
801067e1:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
801067e6:	e9 1c f4 ff ff       	jmp    80105c07 <alltraps>

801067eb <vector175>:
.globl vector175
vector175:
  pushl $0
801067eb:	6a 00                	push   $0x0
  pushl $175
801067ed:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
801067f2:	e9 10 f4 ff ff       	jmp    80105c07 <alltraps>

801067f7 <vector176>:
.globl vector176
vector176:
  pushl $0
801067f7:	6a 00                	push   $0x0
  pushl $176
801067f9:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
801067fe:	e9 04 f4 ff ff       	jmp    80105c07 <alltraps>

80106803 <vector177>:
.globl vector177
vector177:
  pushl $0
80106803:	6a 00                	push   $0x0
  pushl $177
80106805:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
8010680a:	e9 f8 f3 ff ff       	jmp    80105c07 <alltraps>

8010680f <vector178>:
.globl vector178
vector178:
  pushl $0
8010680f:	6a 00                	push   $0x0
  pushl $178
80106811:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80106816:	e9 ec f3 ff ff       	jmp    80105c07 <alltraps>

8010681b <vector179>:
.globl vector179
vector179:
  pushl $0
8010681b:	6a 00                	push   $0x0
  pushl $179
8010681d:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
80106822:	e9 e0 f3 ff ff       	jmp    80105c07 <alltraps>

80106827 <vector180>:
.globl vector180
vector180:
  pushl $0
80106827:	6a 00                	push   $0x0
  pushl $180
80106829:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
8010682e:	e9 d4 f3 ff ff       	jmp    80105c07 <alltraps>

80106833 <vector181>:
.globl vector181
vector181:
  pushl $0
80106833:	6a 00                	push   $0x0
  pushl $181
80106835:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
8010683a:	e9 c8 f3 ff ff       	jmp    80105c07 <alltraps>

8010683f <vector182>:
.globl vector182
vector182:
  pushl $0
8010683f:	6a 00                	push   $0x0
  pushl $182
80106841:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
80106846:	e9 bc f3 ff ff       	jmp    80105c07 <alltraps>

8010684b <vector183>:
.globl vector183
vector183:
  pushl $0
8010684b:	6a 00                	push   $0x0
  pushl $183
8010684d:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
80106852:	e9 b0 f3 ff ff       	jmp    80105c07 <alltraps>

80106857 <vector184>:
.globl vector184
vector184:
  pushl $0
80106857:	6a 00                	push   $0x0
  pushl $184
80106859:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
8010685e:	e9 a4 f3 ff ff       	jmp    80105c07 <alltraps>

80106863 <vector185>:
.globl vector185
vector185:
  pushl $0
80106863:	6a 00                	push   $0x0
  pushl $185
80106865:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
8010686a:	e9 98 f3 ff ff       	jmp    80105c07 <alltraps>

8010686f <vector186>:
.globl vector186
vector186:
  pushl $0
8010686f:	6a 00                	push   $0x0
  pushl $186
80106871:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
80106876:	e9 8c f3 ff ff       	jmp    80105c07 <alltraps>

8010687b <vector187>:
.globl vector187
vector187:
  pushl $0
8010687b:	6a 00                	push   $0x0
  pushl $187
8010687d:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80106882:	e9 80 f3 ff ff       	jmp    80105c07 <alltraps>

80106887 <vector188>:
.globl vector188
vector188:
  pushl $0
80106887:	6a 00                	push   $0x0
  pushl $188
80106889:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
8010688e:	e9 74 f3 ff ff       	jmp    80105c07 <alltraps>

80106893 <vector189>:
.globl vector189
vector189:
  pushl $0
80106893:	6a 00                	push   $0x0
  pushl $189
80106895:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
8010689a:	e9 68 f3 ff ff       	jmp    80105c07 <alltraps>

8010689f <vector190>:
.globl vector190
vector190:
  pushl $0
8010689f:	6a 00                	push   $0x0
  pushl $190
801068a1:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
801068a6:	e9 5c f3 ff ff       	jmp    80105c07 <alltraps>

801068ab <vector191>:
.globl vector191
vector191:
  pushl $0
801068ab:	6a 00                	push   $0x0
  pushl $191
801068ad:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
801068b2:	e9 50 f3 ff ff       	jmp    80105c07 <alltraps>

801068b7 <vector192>:
.globl vector192
vector192:
  pushl $0
801068b7:	6a 00                	push   $0x0
  pushl $192
801068b9:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
801068be:	e9 44 f3 ff ff       	jmp    80105c07 <alltraps>

801068c3 <vector193>:
.globl vector193
vector193:
  pushl $0
801068c3:	6a 00                	push   $0x0
  pushl $193
801068c5:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
801068ca:	e9 38 f3 ff ff       	jmp    80105c07 <alltraps>

801068cf <vector194>:
.globl vector194
vector194:
  pushl $0
801068cf:	6a 00                	push   $0x0
  pushl $194
801068d1:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
801068d6:	e9 2c f3 ff ff       	jmp    80105c07 <alltraps>

801068db <vector195>:
.globl vector195
vector195:
  pushl $0
801068db:	6a 00                	push   $0x0
  pushl $195
801068dd:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
801068e2:	e9 20 f3 ff ff       	jmp    80105c07 <alltraps>

801068e7 <vector196>:
.globl vector196
vector196:
  pushl $0
801068e7:	6a 00                	push   $0x0
  pushl $196
801068e9:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
801068ee:	e9 14 f3 ff ff       	jmp    80105c07 <alltraps>

801068f3 <vector197>:
.globl vector197
vector197:
  pushl $0
801068f3:	6a 00                	push   $0x0
  pushl $197
801068f5:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
801068fa:	e9 08 f3 ff ff       	jmp    80105c07 <alltraps>

801068ff <vector198>:
.globl vector198
vector198:
  pushl $0
801068ff:	6a 00                	push   $0x0
  pushl $198
80106901:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
80106906:	e9 fc f2 ff ff       	jmp    80105c07 <alltraps>

8010690b <vector199>:
.globl vector199
vector199:
  pushl $0
8010690b:	6a 00                	push   $0x0
  pushl $199
8010690d:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
80106912:	e9 f0 f2 ff ff       	jmp    80105c07 <alltraps>

80106917 <vector200>:
.globl vector200
vector200:
  pushl $0
80106917:	6a 00                	push   $0x0
  pushl $200
80106919:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
8010691e:	e9 e4 f2 ff ff       	jmp    80105c07 <alltraps>

80106923 <vector201>:
.globl vector201
vector201:
  pushl $0
80106923:	6a 00                	push   $0x0
  pushl $201
80106925:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
8010692a:	e9 d8 f2 ff ff       	jmp    80105c07 <alltraps>

8010692f <vector202>:
.globl vector202
vector202:
  pushl $0
8010692f:	6a 00                	push   $0x0
  pushl $202
80106931:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
80106936:	e9 cc f2 ff ff       	jmp    80105c07 <alltraps>

8010693b <vector203>:
.globl vector203
vector203:
  pushl $0
8010693b:	6a 00                	push   $0x0
  pushl $203
8010693d:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
80106942:	e9 c0 f2 ff ff       	jmp    80105c07 <alltraps>

80106947 <vector204>:
.globl vector204
vector204:
  pushl $0
80106947:	6a 00                	push   $0x0
  pushl $204
80106949:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
8010694e:	e9 b4 f2 ff ff       	jmp    80105c07 <alltraps>

80106953 <vector205>:
.globl vector205
vector205:
  pushl $0
80106953:	6a 00                	push   $0x0
  pushl $205
80106955:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
8010695a:	e9 a8 f2 ff ff       	jmp    80105c07 <alltraps>

8010695f <vector206>:
.globl vector206
vector206:
  pushl $0
8010695f:	6a 00                	push   $0x0
  pushl $206
80106961:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
80106966:	e9 9c f2 ff ff       	jmp    80105c07 <alltraps>

8010696b <vector207>:
.globl vector207
vector207:
  pushl $0
8010696b:	6a 00                	push   $0x0
  pushl $207
8010696d:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80106972:	e9 90 f2 ff ff       	jmp    80105c07 <alltraps>

80106977 <vector208>:
.globl vector208
vector208:
  pushl $0
80106977:	6a 00                	push   $0x0
  pushl $208
80106979:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
8010697e:	e9 84 f2 ff ff       	jmp    80105c07 <alltraps>

80106983 <vector209>:
.globl vector209
vector209:
  pushl $0
80106983:	6a 00                	push   $0x0
  pushl $209
80106985:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
8010698a:	e9 78 f2 ff ff       	jmp    80105c07 <alltraps>

8010698f <vector210>:
.globl vector210
vector210:
  pushl $0
8010698f:	6a 00                	push   $0x0
  pushl $210
80106991:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80106996:	e9 6c f2 ff ff       	jmp    80105c07 <alltraps>

8010699b <vector211>:
.globl vector211
vector211:
  pushl $0
8010699b:	6a 00                	push   $0x0
  pushl $211
8010699d:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
801069a2:	e9 60 f2 ff ff       	jmp    80105c07 <alltraps>

801069a7 <vector212>:
.globl vector212
vector212:
  pushl $0
801069a7:	6a 00                	push   $0x0
  pushl $212
801069a9:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
801069ae:	e9 54 f2 ff ff       	jmp    80105c07 <alltraps>

801069b3 <vector213>:
.globl vector213
vector213:
  pushl $0
801069b3:	6a 00                	push   $0x0
  pushl $213
801069b5:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
801069ba:	e9 48 f2 ff ff       	jmp    80105c07 <alltraps>

801069bf <vector214>:
.globl vector214
vector214:
  pushl $0
801069bf:	6a 00                	push   $0x0
  pushl $214
801069c1:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
801069c6:	e9 3c f2 ff ff       	jmp    80105c07 <alltraps>

801069cb <vector215>:
.globl vector215
vector215:
  pushl $0
801069cb:	6a 00                	push   $0x0
  pushl $215
801069cd:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
801069d2:	e9 30 f2 ff ff       	jmp    80105c07 <alltraps>

801069d7 <vector216>:
.globl vector216
vector216:
  pushl $0
801069d7:	6a 00                	push   $0x0
  pushl $216
801069d9:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
801069de:	e9 24 f2 ff ff       	jmp    80105c07 <alltraps>

801069e3 <vector217>:
.globl vector217
vector217:
  pushl $0
801069e3:	6a 00                	push   $0x0
  pushl $217
801069e5:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
801069ea:	e9 18 f2 ff ff       	jmp    80105c07 <alltraps>

801069ef <vector218>:
.globl vector218
vector218:
  pushl $0
801069ef:	6a 00                	push   $0x0
  pushl $218
801069f1:	68 da 00 00 00       	push   $0xda
  jmp alltraps
801069f6:	e9 0c f2 ff ff       	jmp    80105c07 <alltraps>

801069fb <vector219>:
.globl vector219
vector219:
  pushl $0
801069fb:	6a 00                	push   $0x0
  pushl $219
801069fd:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80106a02:	e9 00 f2 ff ff       	jmp    80105c07 <alltraps>

80106a07 <vector220>:
.globl vector220
vector220:
  pushl $0
80106a07:	6a 00                	push   $0x0
  pushl $220
80106a09:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
80106a0e:	e9 f4 f1 ff ff       	jmp    80105c07 <alltraps>

80106a13 <vector221>:
.globl vector221
vector221:
  pushl $0
80106a13:	6a 00                	push   $0x0
  pushl $221
80106a15:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
80106a1a:	e9 e8 f1 ff ff       	jmp    80105c07 <alltraps>

80106a1f <vector222>:
.globl vector222
vector222:
  pushl $0
80106a1f:	6a 00                	push   $0x0
  pushl $222
80106a21:	68 de 00 00 00       	push   $0xde
  jmp alltraps
80106a26:	e9 dc f1 ff ff       	jmp    80105c07 <alltraps>

80106a2b <vector223>:
.globl vector223
vector223:
  pushl $0
80106a2b:	6a 00                	push   $0x0
  pushl $223
80106a2d:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
80106a32:	e9 d0 f1 ff ff       	jmp    80105c07 <alltraps>

80106a37 <vector224>:
.globl vector224
vector224:
  pushl $0
80106a37:	6a 00                	push   $0x0
  pushl $224
80106a39:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
80106a3e:	e9 c4 f1 ff ff       	jmp    80105c07 <alltraps>

80106a43 <vector225>:
.globl vector225
vector225:
  pushl $0
80106a43:	6a 00                	push   $0x0
  pushl $225
80106a45:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
80106a4a:	e9 b8 f1 ff ff       	jmp    80105c07 <alltraps>

80106a4f <vector226>:
.globl vector226
vector226:
  pushl $0
80106a4f:	6a 00                	push   $0x0
  pushl $226
80106a51:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80106a56:	e9 ac f1 ff ff       	jmp    80105c07 <alltraps>

80106a5b <vector227>:
.globl vector227
vector227:
  pushl $0
80106a5b:	6a 00                	push   $0x0
  pushl $227
80106a5d:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80106a62:	e9 a0 f1 ff ff       	jmp    80105c07 <alltraps>

80106a67 <vector228>:
.globl vector228
vector228:
  pushl $0
80106a67:	6a 00                	push   $0x0
  pushl $228
80106a69:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
80106a6e:	e9 94 f1 ff ff       	jmp    80105c07 <alltraps>

80106a73 <vector229>:
.globl vector229
vector229:
  pushl $0
80106a73:	6a 00                	push   $0x0
  pushl $229
80106a75:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
80106a7a:	e9 88 f1 ff ff       	jmp    80105c07 <alltraps>

80106a7f <vector230>:
.globl vector230
vector230:
  pushl $0
80106a7f:	6a 00                	push   $0x0
  pushl $230
80106a81:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80106a86:	e9 7c f1 ff ff       	jmp    80105c07 <alltraps>

80106a8b <vector231>:
.globl vector231
vector231:
  pushl $0
80106a8b:	6a 00                	push   $0x0
  pushl $231
80106a8d:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80106a92:	e9 70 f1 ff ff       	jmp    80105c07 <alltraps>

80106a97 <vector232>:
.globl vector232
vector232:
  pushl $0
80106a97:	6a 00                	push   $0x0
  pushl $232
80106a99:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
80106a9e:	e9 64 f1 ff ff       	jmp    80105c07 <alltraps>

80106aa3 <vector233>:
.globl vector233
vector233:
  pushl $0
80106aa3:	6a 00                	push   $0x0
  pushl $233
80106aa5:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
80106aaa:	e9 58 f1 ff ff       	jmp    80105c07 <alltraps>

80106aaf <vector234>:
.globl vector234
vector234:
  pushl $0
80106aaf:	6a 00                	push   $0x0
  pushl $234
80106ab1:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80106ab6:	e9 4c f1 ff ff       	jmp    80105c07 <alltraps>

80106abb <vector235>:
.globl vector235
vector235:
  pushl $0
80106abb:	6a 00                	push   $0x0
  pushl $235
80106abd:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80106ac2:	e9 40 f1 ff ff       	jmp    80105c07 <alltraps>

80106ac7 <vector236>:
.globl vector236
vector236:
  pushl $0
80106ac7:	6a 00                	push   $0x0
  pushl $236
80106ac9:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
80106ace:	e9 34 f1 ff ff       	jmp    80105c07 <alltraps>

80106ad3 <vector237>:
.globl vector237
vector237:
  pushl $0
80106ad3:	6a 00                	push   $0x0
  pushl $237
80106ad5:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
80106ada:	e9 28 f1 ff ff       	jmp    80105c07 <alltraps>

80106adf <vector238>:
.globl vector238
vector238:
  pushl $0
80106adf:	6a 00                	push   $0x0
  pushl $238
80106ae1:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80106ae6:	e9 1c f1 ff ff       	jmp    80105c07 <alltraps>

80106aeb <vector239>:
.globl vector239
vector239:
  pushl $0
80106aeb:	6a 00                	push   $0x0
  pushl $239
80106aed:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80106af2:	e9 10 f1 ff ff       	jmp    80105c07 <alltraps>

80106af7 <vector240>:
.globl vector240
vector240:
  pushl $0
80106af7:	6a 00                	push   $0x0
  pushl $240
80106af9:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
80106afe:	e9 04 f1 ff ff       	jmp    80105c07 <alltraps>

80106b03 <vector241>:
.globl vector241
vector241:
  pushl $0
80106b03:	6a 00                	push   $0x0
  pushl $241
80106b05:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
80106b0a:	e9 f8 f0 ff ff       	jmp    80105c07 <alltraps>

80106b0f <vector242>:
.globl vector242
vector242:
  pushl $0
80106b0f:	6a 00                	push   $0x0
  pushl $242
80106b11:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80106b16:	e9 ec f0 ff ff       	jmp    80105c07 <alltraps>

80106b1b <vector243>:
.globl vector243
vector243:
  pushl $0
80106b1b:	6a 00                	push   $0x0
  pushl $243
80106b1d:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
80106b22:	e9 e0 f0 ff ff       	jmp    80105c07 <alltraps>

80106b27 <vector244>:
.globl vector244
vector244:
  pushl $0
80106b27:	6a 00                	push   $0x0
  pushl $244
80106b29:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
80106b2e:	e9 d4 f0 ff ff       	jmp    80105c07 <alltraps>

80106b33 <vector245>:
.globl vector245
vector245:
  pushl $0
80106b33:	6a 00                	push   $0x0
  pushl $245
80106b35:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
80106b3a:	e9 c8 f0 ff ff       	jmp    80105c07 <alltraps>

80106b3f <vector246>:
.globl vector246
vector246:
  pushl $0
80106b3f:	6a 00                	push   $0x0
  pushl $246
80106b41:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80106b46:	e9 bc f0 ff ff       	jmp    80105c07 <alltraps>

80106b4b <vector247>:
.globl vector247
vector247:
  pushl $0
80106b4b:	6a 00                	push   $0x0
  pushl $247
80106b4d:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80106b52:	e9 b0 f0 ff ff       	jmp    80105c07 <alltraps>

80106b57 <vector248>:
.globl vector248
vector248:
  pushl $0
80106b57:	6a 00                	push   $0x0
  pushl $248
80106b59:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
80106b5e:	e9 a4 f0 ff ff       	jmp    80105c07 <alltraps>

80106b63 <vector249>:
.globl vector249
vector249:
  pushl $0
80106b63:	6a 00                	push   $0x0
  pushl $249
80106b65:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
80106b6a:	e9 98 f0 ff ff       	jmp    80105c07 <alltraps>

80106b6f <vector250>:
.globl vector250
vector250:
  pushl $0
80106b6f:	6a 00                	push   $0x0
  pushl $250
80106b71:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80106b76:	e9 8c f0 ff ff       	jmp    80105c07 <alltraps>

80106b7b <vector251>:
.globl vector251
vector251:
  pushl $0
80106b7b:	6a 00                	push   $0x0
  pushl $251
80106b7d:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80106b82:	e9 80 f0 ff ff       	jmp    80105c07 <alltraps>

80106b87 <vector252>:
.globl vector252
vector252:
  pushl $0
80106b87:	6a 00                	push   $0x0
  pushl $252
80106b89:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
80106b8e:	e9 74 f0 ff ff       	jmp    80105c07 <alltraps>

80106b93 <vector253>:
.globl vector253
vector253:
  pushl $0
80106b93:	6a 00                	push   $0x0
  pushl $253
80106b95:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
80106b9a:	e9 68 f0 ff ff       	jmp    80105c07 <alltraps>

80106b9f <vector254>:
.globl vector254
vector254:
  pushl $0
80106b9f:	6a 00                	push   $0x0
  pushl $254
80106ba1:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80106ba6:	e9 5c f0 ff ff       	jmp    80105c07 <alltraps>

80106bab <vector255>:
.globl vector255
vector255:
  pushl $0
80106bab:	6a 00                	push   $0x0
  pushl $255
80106bad:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80106bb2:	e9 50 f0 ff ff       	jmp    80105c07 <alltraps>
80106bb7:	66 90                	xchg   %ax,%ax
80106bb9:	66 90                	xchg   %ax,%ax
80106bbb:	66 90                	xchg   %ax,%ax
80106bbd:	66 90                	xchg   %ax,%ax
80106bbf:	90                   	nop

80106bc0 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80106bc0:	55                   	push   %ebp
80106bc1:	89 e5                	mov    %esp,%ebp
80106bc3:	57                   	push   %edi
80106bc4:	56                   	push   %esi
80106bc5:	53                   	push   %ebx
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80106bc6:	89 d3                	mov    %edx,%ebx
{
80106bc8:	89 d7                	mov    %edx,%edi
  pde = &pgdir[PDX(va)];
80106bca:	c1 eb 16             	shr    $0x16,%ebx
80106bcd:	8d 34 98             	lea    (%eax,%ebx,4),%esi
{
80106bd0:	83 ec 0c             	sub    $0xc,%esp
  if(*pde & PTE_P){
80106bd3:	8b 06                	mov    (%esi),%eax
80106bd5:	a8 01                	test   $0x1,%al
80106bd7:	74 27                	je     80106c00 <walkpgdir+0x40>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106bd9:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106bde:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
80106be4:	c1 ef 0a             	shr    $0xa,%edi
}
80106be7:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return &pgtab[PTX(va)];
80106bea:	89 fa                	mov    %edi,%edx
80106bec:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80106bf2:	8d 04 13             	lea    (%ebx,%edx,1),%eax
}
80106bf5:	5b                   	pop    %ebx
80106bf6:	5e                   	pop    %esi
80106bf7:	5f                   	pop    %edi
80106bf8:	5d                   	pop    %ebp
80106bf9:	c3                   	ret    
80106bfa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80106c00:	85 c9                	test   %ecx,%ecx
80106c02:	74 2c                	je     80106c30 <walkpgdir+0x70>
80106c04:	e8 e7 b8 ff ff       	call   801024f0 <kalloc>
80106c09:	85 c0                	test   %eax,%eax
80106c0b:	89 c3                	mov    %eax,%ebx
80106c0d:	74 21                	je     80106c30 <walkpgdir+0x70>
    memset(pgtab, 0, PGSIZE);
80106c0f:	83 ec 04             	sub    $0x4,%esp
80106c12:	68 00 10 00 00       	push   $0x1000
80106c17:	6a 00                	push   $0x0
80106c19:	50                   	push   %eax
80106c1a:	e8 41 dd ff ff       	call   80104960 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80106c1f:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106c25:	83 c4 10             	add    $0x10,%esp
80106c28:	83 c8 07             	or     $0x7,%eax
80106c2b:	89 06                	mov    %eax,(%esi)
80106c2d:	eb b5                	jmp    80106be4 <walkpgdir+0x24>
80106c2f:	90                   	nop
}
80106c30:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 0;
80106c33:	31 c0                	xor    %eax,%eax
}
80106c35:	5b                   	pop    %ebx
80106c36:	5e                   	pop    %esi
80106c37:	5f                   	pop    %edi
80106c38:	5d                   	pop    %ebp
80106c39:	c3                   	ret    
80106c3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106c40 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80106c40:	55                   	push   %ebp
80106c41:	89 e5                	mov    %esp,%ebp
80106c43:	57                   	push   %edi
80106c44:	56                   	push   %esi
80106c45:	53                   	push   %ebx
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
80106c46:	89 d3                	mov    %edx,%ebx
80106c48:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
{
80106c4e:	83 ec 1c             	sub    $0x1c,%esp
80106c51:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80106c54:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
80106c58:	8b 7d 08             	mov    0x8(%ebp),%edi
80106c5b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106c60:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
80106c63:	8b 45 0c             	mov    0xc(%ebp),%eax
80106c66:	29 df                	sub    %ebx,%edi
80106c68:	83 c8 01             	or     $0x1,%eax
80106c6b:	89 45 dc             	mov    %eax,-0x24(%ebp)
80106c6e:	eb 15                	jmp    80106c85 <mappages+0x45>
    if(*pte & PTE_P)
80106c70:	f6 00 01             	testb  $0x1,(%eax)
80106c73:	75 45                	jne    80106cba <mappages+0x7a>
    *pte = pa | perm | PTE_P;
80106c75:	0b 75 dc             	or     -0x24(%ebp),%esi
    if(a == last)
80106c78:	3b 5d e0             	cmp    -0x20(%ebp),%ebx
    *pte = pa | perm | PTE_P;
80106c7b:	89 30                	mov    %esi,(%eax)
    if(a == last)
80106c7d:	74 31                	je     80106cb0 <mappages+0x70>
      break;
    a += PGSIZE;
80106c7f:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80106c85:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106c88:	b9 01 00 00 00       	mov    $0x1,%ecx
80106c8d:	89 da                	mov    %ebx,%edx
80106c8f:	8d 34 3b             	lea    (%ebx,%edi,1),%esi
80106c92:	e8 29 ff ff ff       	call   80106bc0 <walkpgdir>
80106c97:	85 c0                	test   %eax,%eax
80106c99:	75 d5                	jne    80106c70 <mappages+0x30>
    pa += PGSIZE;
  }
  return 0;
}
80106c9b:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80106c9e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106ca3:	5b                   	pop    %ebx
80106ca4:	5e                   	pop    %esi
80106ca5:	5f                   	pop    %edi
80106ca6:	5d                   	pop    %ebp
80106ca7:	c3                   	ret    
80106ca8:	90                   	nop
80106ca9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106cb0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80106cb3:	31 c0                	xor    %eax,%eax
}
80106cb5:	5b                   	pop    %ebx
80106cb6:	5e                   	pop    %esi
80106cb7:	5f                   	pop    %edi
80106cb8:	5d                   	pop    %ebp
80106cb9:	c3                   	ret    
      panic("remap");
80106cba:	83 ec 0c             	sub    $0xc,%esp
80106cbd:	68 14 7e 10 80       	push   $0x80107e14
80106cc2:	e8 c9 96 ff ff       	call   80100390 <panic>
80106cc7:	89 f6                	mov    %esi,%esi
80106cc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106cd0 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106cd0:	55                   	push   %ebp
80106cd1:	89 e5                	mov    %esp,%ebp
80106cd3:	57                   	push   %edi
80106cd4:	56                   	push   %esi
80106cd5:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80106cd6:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106cdc:	89 c7                	mov    %eax,%edi
  a = PGROUNDUP(newsz);
80106cde:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106ce4:	83 ec 1c             	sub    $0x1c,%esp
80106ce7:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  for(; a  < oldsz; a += PGSIZE){
80106cea:	39 d3                	cmp    %edx,%ebx
80106cec:	73 66                	jae    80106d54 <deallocuvm.part.0+0x84>
80106cee:	89 d6                	mov    %edx,%esi
80106cf0:	eb 3d                	jmp    80106d2f <deallocuvm.part.0+0x5f>
80106cf2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
80106cf8:	8b 10                	mov    (%eax),%edx
80106cfa:	f6 c2 01             	test   $0x1,%dl
80106cfd:	74 26                	je     80106d25 <deallocuvm.part.0+0x55>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
80106cff:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80106d05:	74 58                	je     80106d5f <deallocuvm.part.0+0x8f>
        panic("kfree");
      char *v = P2V(pa);
      kfree(v);
80106d07:	83 ec 0c             	sub    $0xc,%esp
      char *v = P2V(pa);
80106d0a:	81 c2 00 00 00 80    	add    $0x80000000,%edx
80106d10:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      kfree(v);
80106d13:	52                   	push   %edx
80106d14:	e8 27 b6 ff ff       	call   80102340 <kfree>
      *pte = 0;
80106d19:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106d1c:	83 c4 10             	add    $0x10,%esp
80106d1f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; a  < oldsz; a += PGSIZE){
80106d25:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106d2b:	39 f3                	cmp    %esi,%ebx
80106d2d:	73 25                	jae    80106d54 <deallocuvm.part.0+0x84>
    pte = walkpgdir(pgdir, (char*)a, 0);
80106d2f:	31 c9                	xor    %ecx,%ecx
80106d31:	89 da                	mov    %ebx,%edx
80106d33:	89 f8                	mov    %edi,%eax
80106d35:	e8 86 fe ff ff       	call   80106bc0 <walkpgdir>
    if(!pte)
80106d3a:	85 c0                	test   %eax,%eax
80106d3c:	75 ba                	jne    80106cf8 <deallocuvm.part.0+0x28>
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
80106d3e:	81 e3 00 00 c0 ff    	and    $0xffc00000,%ebx
80106d44:	81 c3 00 f0 3f 00    	add    $0x3ff000,%ebx
  for(; a  < oldsz; a += PGSIZE){
80106d4a:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106d50:	39 f3                	cmp    %esi,%ebx
80106d52:	72 db                	jb     80106d2f <deallocuvm.part.0+0x5f>
    }
  }
  return newsz;
}
80106d54:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106d57:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106d5a:	5b                   	pop    %ebx
80106d5b:	5e                   	pop    %esi
80106d5c:	5f                   	pop    %edi
80106d5d:	5d                   	pop    %ebp
80106d5e:	c3                   	ret    
        panic("kfree");
80106d5f:	83 ec 0c             	sub    $0xc,%esp
80106d62:	68 66 77 10 80       	push   $0x80107766
80106d67:	e8 24 96 ff ff       	call   80100390 <panic>
80106d6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106d70 <seginit>:
{
80106d70:	55                   	push   %ebp
80106d71:	89 e5                	mov    %esp,%ebp
80106d73:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
80106d76:	e8 b5 c9 ff ff       	call   80103730 <cpuid>
80106d7b:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
  pd[0] = size-1;
80106d81:	ba 2f 00 00 00       	mov    $0x2f,%edx
80106d86:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80106d8a:	c7 80 f8 27 11 80 ff 	movl   $0xffff,-0x7feed808(%eax)
80106d91:	ff 00 00 
80106d94:	c7 80 fc 27 11 80 00 	movl   $0xcf9a00,-0x7feed804(%eax)
80106d9b:	9a cf 00 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106d9e:	c7 80 00 28 11 80 ff 	movl   $0xffff,-0x7feed800(%eax)
80106da5:	ff 00 00 
80106da8:	c7 80 04 28 11 80 00 	movl   $0xcf9200,-0x7feed7fc(%eax)
80106daf:	92 cf 00 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106db2:	c7 80 08 28 11 80 ff 	movl   $0xffff,-0x7feed7f8(%eax)
80106db9:	ff 00 00 
80106dbc:	c7 80 0c 28 11 80 00 	movl   $0xcffa00,-0x7feed7f4(%eax)
80106dc3:	fa cf 00 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106dc6:	c7 80 10 28 11 80 ff 	movl   $0xffff,-0x7feed7f0(%eax)
80106dcd:	ff 00 00 
80106dd0:	c7 80 14 28 11 80 00 	movl   $0xcff200,-0x7feed7ec(%eax)
80106dd7:	f2 cf 00 
  lgdt(c->gdt, sizeof(c->gdt));
80106dda:	05 f0 27 11 80       	add    $0x801127f0,%eax
  pd[1] = (uint)p;
80106ddf:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80106de3:	c1 e8 10             	shr    $0x10,%eax
80106de6:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
80106dea:	8d 45 f2             	lea    -0xe(%ebp),%eax
80106ded:	0f 01 10             	lgdtl  (%eax)
}
80106df0:	c9                   	leave  
80106df1:	c3                   	ret    
80106df2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106df9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106e00 <switchkvm>:
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106e00:	a1 a4 99 11 80       	mov    0x801199a4,%eax
{
80106e05:	55                   	push   %ebp
80106e06:	89 e5                	mov    %esp,%ebp
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106e08:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106e0d:	0f 22 d8             	mov    %eax,%cr3
}
80106e10:	5d                   	pop    %ebp
80106e11:	c3                   	ret    
80106e12:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106e19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106e20 <switchuvm>:
{
80106e20:	55                   	push   %ebp
80106e21:	89 e5                	mov    %esp,%ebp
80106e23:	57                   	push   %edi
80106e24:	56                   	push   %esi
80106e25:	53                   	push   %ebx
80106e26:	83 ec 1c             	sub    $0x1c,%esp
80106e29:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(p == 0)
80106e2c:	85 db                	test   %ebx,%ebx
80106e2e:	0f 84 cb 00 00 00    	je     80106eff <switchuvm+0xdf>
  if(p->kstack == 0)
80106e34:	8b 43 08             	mov    0x8(%ebx),%eax
80106e37:	85 c0                	test   %eax,%eax
80106e39:	0f 84 da 00 00 00    	je     80106f19 <switchuvm+0xf9>
  if(p->pgdir == 0)
80106e3f:	8b 43 04             	mov    0x4(%ebx),%eax
80106e42:	85 c0                	test   %eax,%eax
80106e44:	0f 84 c2 00 00 00    	je     80106f0c <switchuvm+0xec>
  pushcli();
80106e4a:	e8 31 d9 ff ff       	call   80104780 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80106e4f:	e8 5c c8 ff ff       	call   801036b0 <mycpu>
80106e54:	89 c6                	mov    %eax,%esi
80106e56:	e8 55 c8 ff ff       	call   801036b0 <mycpu>
80106e5b:	89 c7                	mov    %eax,%edi
80106e5d:	e8 4e c8 ff ff       	call   801036b0 <mycpu>
80106e62:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106e65:	83 c7 08             	add    $0x8,%edi
80106e68:	e8 43 c8 ff ff       	call   801036b0 <mycpu>
80106e6d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80106e70:	83 c0 08             	add    $0x8,%eax
80106e73:	ba 67 00 00 00       	mov    $0x67,%edx
80106e78:	c1 e8 18             	shr    $0x18,%eax
80106e7b:	66 89 96 98 00 00 00 	mov    %dx,0x98(%esi)
80106e82:	66 89 be 9a 00 00 00 	mov    %di,0x9a(%esi)
80106e89:	88 86 9f 00 00 00    	mov    %al,0x9f(%esi)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106e8f:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80106e94:	83 c1 08             	add    $0x8,%ecx
80106e97:	c1 e9 10             	shr    $0x10,%ecx
80106e9a:	88 8e 9c 00 00 00    	mov    %cl,0x9c(%esi)
80106ea0:	b9 99 40 00 00       	mov    $0x4099,%ecx
80106ea5:	66 89 8e 9d 00 00 00 	mov    %cx,0x9d(%esi)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80106eac:	be 10 00 00 00       	mov    $0x10,%esi
  mycpu()->gdt[SEG_TSS].s = 0;
80106eb1:	e8 fa c7 ff ff       	call   801036b0 <mycpu>
80106eb6:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80106ebd:	e8 ee c7 ff ff       	call   801036b0 <mycpu>
80106ec2:	66 89 70 10          	mov    %si,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80106ec6:	8b 73 08             	mov    0x8(%ebx),%esi
80106ec9:	e8 e2 c7 ff ff       	call   801036b0 <mycpu>
80106ece:	81 c6 00 10 00 00    	add    $0x1000,%esi
80106ed4:	89 70 0c             	mov    %esi,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106ed7:	e8 d4 c7 ff ff       	call   801036b0 <mycpu>
80106edc:	66 89 78 6e          	mov    %di,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
80106ee0:	b8 28 00 00 00       	mov    $0x28,%eax
80106ee5:	0f 00 d8             	ltr    %ax
  lcr3(V2P(p->pgdir));  // switch to process's address space
80106ee8:	8b 43 04             	mov    0x4(%ebx),%eax
80106eeb:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106ef0:	0f 22 d8             	mov    %eax,%cr3
}
80106ef3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106ef6:	5b                   	pop    %ebx
80106ef7:	5e                   	pop    %esi
80106ef8:	5f                   	pop    %edi
80106ef9:	5d                   	pop    %ebp
  popcli();
80106efa:	e9 c1 d8 ff ff       	jmp    801047c0 <popcli>
    panic("switchuvm: no process");
80106eff:	83 ec 0c             	sub    $0xc,%esp
80106f02:	68 1a 7e 10 80       	push   $0x80107e1a
80106f07:	e8 84 94 ff ff       	call   80100390 <panic>
    panic("switchuvm: no pgdir");
80106f0c:	83 ec 0c             	sub    $0xc,%esp
80106f0f:	68 45 7e 10 80       	push   $0x80107e45
80106f14:	e8 77 94 ff ff       	call   80100390 <panic>
    panic("switchuvm: no kstack");
80106f19:	83 ec 0c             	sub    $0xc,%esp
80106f1c:	68 30 7e 10 80       	push   $0x80107e30
80106f21:	e8 6a 94 ff ff       	call   80100390 <panic>
80106f26:	8d 76 00             	lea    0x0(%esi),%esi
80106f29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106f30 <inituvm>:
{
80106f30:	55                   	push   %ebp
80106f31:	89 e5                	mov    %esp,%ebp
80106f33:	57                   	push   %edi
80106f34:	56                   	push   %esi
80106f35:	53                   	push   %ebx
80106f36:	83 ec 1c             	sub    $0x1c,%esp
80106f39:	8b 75 10             	mov    0x10(%ebp),%esi
80106f3c:	8b 45 08             	mov    0x8(%ebp),%eax
80106f3f:	8b 7d 0c             	mov    0xc(%ebp),%edi
  if(sz >= PGSIZE)
80106f42:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
{
80106f48:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
80106f4b:	77 49                	ja     80106f96 <inituvm+0x66>
  mem = kalloc();
80106f4d:	e8 9e b5 ff ff       	call   801024f0 <kalloc>
  memset(mem, 0, PGSIZE);
80106f52:	83 ec 04             	sub    $0x4,%esp
  mem = kalloc();
80106f55:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80106f57:	68 00 10 00 00       	push   $0x1000
80106f5c:	6a 00                	push   $0x0
80106f5e:	50                   	push   %eax
80106f5f:	e8 fc d9 ff ff       	call   80104960 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80106f64:	58                   	pop    %eax
80106f65:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106f6b:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106f70:	5a                   	pop    %edx
80106f71:	6a 06                	push   $0x6
80106f73:	50                   	push   %eax
80106f74:	31 d2                	xor    %edx,%edx
80106f76:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106f79:	e8 c2 fc ff ff       	call   80106c40 <mappages>
  memmove(mem, init, sz);
80106f7e:	89 75 10             	mov    %esi,0x10(%ebp)
80106f81:	89 7d 0c             	mov    %edi,0xc(%ebp)
80106f84:	83 c4 10             	add    $0x10,%esp
80106f87:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80106f8a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106f8d:	5b                   	pop    %ebx
80106f8e:	5e                   	pop    %esi
80106f8f:	5f                   	pop    %edi
80106f90:	5d                   	pop    %ebp
  memmove(mem, init, sz);
80106f91:	e9 7a da ff ff       	jmp    80104a10 <memmove>
    panic("inituvm: more than a page");
80106f96:	83 ec 0c             	sub    $0xc,%esp
80106f99:	68 59 7e 10 80       	push   $0x80107e59
80106f9e:	e8 ed 93 ff ff       	call   80100390 <panic>
80106fa3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106fa9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106fb0 <loaduvm>:
{
80106fb0:	55                   	push   %ebp
80106fb1:	89 e5                	mov    %esp,%ebp
80106fb3:	57                   	push   %edi
80106fb4:	56                   	push   %esi
80106fb5:	53                   	push   %ebx
80106fb6:	83 ec 0c             	sub    $0xc,%esp
  if((uint) addr % PGSIZE != 0)
80106fb9:	f7 45 0c ff 0f 00 00 	testl  $0xfff,0xc(%ebp)
80106fc0:	0f 85 91 00 00 00    	jne    80107057 <loaduvm+0xa7>
  for(i = 0; i < sz; i += PGSIZE){
80106fc6:	8b 75 18             	mov    0x18(%ebp),%esi
80106fc9:	31 db                	xor    %ebx,%ebx
80106fcb:	85 f6                	test   %esi,%esi
80106fcd:	75 1a                	jne    80106fe9 <loaduvm+0x39>
80106fcf:	eb 6f                	jmp    80107040 <loaduvm+0x90>
80106fd1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106fd8:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106fde:	81 ee 00 10 00 00    	sub    $0x1000,%esi
80106fe4:	39 5d 18             	cmp    %ebx,0x18(%ebp)
80106fe7:	76 57                	jbe    80107040 <loaduvm+0x90>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80106fe9:	8b 55 0c             	mov    0xc(%ebp),%edx
80106fec:	8b 45 08             	mov    0x8(%ebp),%eax
80106fef:	31 c9                	xor    %ecx,%ecx
80106ff1:	01 da                	add    %ebx,%edx
80106ff3:	e8 c8 fb ff ff       	call   80106bc0 <walkpgdir>
80106ff8:	85 c0                	test   %eax,%eax
80106ffa:	74 4e                	je     8010704a <loaduvm+0x9a>
    pa = PTE_ADDR(*pte);
80106ffc:	8b 00                	mov    (%eax),%eax
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106ffe:	8b 4d 14             	mov    0x14(%ebp),%ecx
    if(sz - i < PGSIZE)
80107001:	bf 00 10 00 00       	mov    $0x1000,%edi
    pa = PTE_ADDR(*pte);
80107006:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
8010700b:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
80107011:	0f 46 fe             	cmovbe %esi,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
80107014:	01 d9                	add    %ebx,%ecx
80107016:	05 00 00 00 80       	add    $0x80000000,%eax
8010701b:	57                   	push   %edi
8010701c:	51                   	push   %ecx
8010701d:	50                   	push   %eax
8010701e:	ff 75 10             	pushl  0x10(%ebp)
80107021:	e8 6a a9 ff ff       	call   80101990 <readi>
80107026:	83 c4 10             	add    $0x10,%esp
80107029:	39 f8                	cmp    %edi,%eax
8010702b:	74 ab                	je     80106fd8 <loaduvm+0x28>
}
8010702d:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80107030:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107035:	5b                   	pop    %ebx
80107036:	5e                   	pop    %esi
80107037:	5f                   	pop    %edi
80107038:	5d                   	pop    %ebp
80107039:	c3                   	ret    
8010703a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107040:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80107043:	31 c0                	xor    %eax,%eax
}
80107045:	5b                   	pop    %ebx
80107046:	5e                   	pop    %esi
80107047:	5f                   	pop    %edi
80107048:	5d                   	pop    %ebp
80107049:	c3                   	ret    
      panic("loaduvm: address should exist");
8010704a:	83 ec 0c             	sub    $0xc,%esp
8010704d:	68 73 7e 10 80       	push   $0x80107e73
80107052:	e8 39 93 ff ff       	call   80100390 <panic>
    panic("loaduvm: addr must be page aligned");
80107057:	83 ec 0c             	sub    $0xc,%esp
8010705a:	68 14 7f 10 80       	push   $0x80107f14
8010705f:	e8 2c 93 ff ff       	call   80100390 <panic>
80107064:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010706a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80107070 <allocuvm>:
{
80107070:	55                   	push   %ebp
80107071:	89 e5                	mov    %esp,%ebp
80107073:	57                   	push   %edi
80107074:	56                   	push   %esi
80107075:	53                   	push   %ebx
80107076:	83 ec 1c             	sub    $0x1c,%esp
  if(newsz >= KERNBASE)
80107079:	8b 7d 10             	mov    0x10(%ebp),%edi
8010707c:	85 ff                	test   %edi,%edi
8010707e:	0f 88 8e 00 00 00    	js     80107112 <allocuvm+0xa2>
  if(newsz < oldsz)
80107084:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80107087:	0f 82 93 00 00 00    	jb     80107120 <allocuvm+0xb0>
  a = PGROUNDUP(oldsz);
8010708d:	8b 45 0c             	mov    0xc(%ebp),%eax
80107090:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80107096:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a < newsz; a += PGSIZE){
8010709c:	39 5d 10             	cmp    %ebx,0x10(%ebp)
8010709f:	0f 86 7e 00 00 00    	jbe    80107123 <allocuvm+0xb3>
801070a5:	89 7d e4             	mov    %edi,-0x1c(%ebp)
801070a8:	8b 7d 08             	mov    0x8(%ebp),%edi
801070ab:	eb 42                	jmp    801070ef <allocuvm+0x7f>
801070ad:	8d 76 00             	lea    0x0(%esi),%esi
    memset(mem, 0, PGSIZE);
801070b0:	83 ec 04             	sub    $0x4,%esp
801070b3:	68 00 10 00 00       	push   $0x1000
801070b8:	6a 00                	push   $0x0
801070ba:	50                   	push   %eax
801070bb:	e8 a0 d8 ff ff       	call   80104960 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
801070c0:	58                   	pop    %eax
801070c1:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
801070c7:	b9 00 10 00 00       	mov    $0x1000,%ecx
801070cc:	5a                   	pop    %edx
801070cd:	6a 06                	push   $0x6
801070cf:	50                   	push   %eax
801070d0:	89 da                	mov    %ebx,%edx
801070d2:	89 f8                	mov    %edi,%eax
801070d4:	e8 67 fb ff ff       	call   80106c40 <mappages>
801070d9:	83 c4 10             	add    $0x10,%esp
801070dc:	85 c0                	test   %eax,%eax
801070de:	78 50                	js     80107130 <allocuvm+0xc0>
  for(; a < newsz; a += PGSIZE){
801070e0:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801070e6:	39 5d 10             	cmp    %ebx,0x10(%ebp)
801070e9:	0f 86 81 00 00 00    	jbe    80107170 <allocuvm+0x100>
    mem = kalloc();
801070ef:	e8 fc b3 ff ff       	call   801024f0 <kalloc>
    if(mem == 0){
801070f4:	85 c0                	test   %eax,%eax
    mem = kalloc();
801070f6:	89 c6                	mov    %eax,%esi
    if(mem == 0){
801070f8:	75 b6                	jne    801070b0 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
801070fa:	83 ec 0c             	sub    $0xc,%esp
801070fd:	68 91 7e 10 80       	push   $0x80107e91
80107102:	e8 59 95 ff ff       	call   80100660 <cprintf>
  if(newsz >= oldsz)
80107107:	83 c4 10             	add    $0x10,%esp
8010710a:	8b 45 0c             	mov    0xc(%ebp),%eax
8010710d:	39 45 10             	cmp    %eax,0x10(%ebp)
80107110:	77 6e                	ja     80107180 <allocuvm+0x110>
}
80107112:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
80107115:	31 ff                	xor    %edi,%edi
}
80107117:	89 f8                	mov    %edi,%eax
80107119:	5b                   	pop    %ebx
8010711a:	5e                   	pop    %esi
8010711b:	5f                   	pop    %edi
8010711c:	5d                   	pop    %ebp
8010711d:	c3                   	ret    
8010711e:	66 90                	xchg   %ax,%ax
    return oldsz;
80107120:	8b 7d 0c             	mov    0xc(%ebp),%edi
}
80107123:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107126:	89 f8                	mov    %edi,%eax
80107128:	5b                   	pop    %ebx
80107129:	5e                   	pop    %esi
8010712a:	5f                   	pop    %edi
8010712b:	5d                   	pop    %ebp
8010712c:	c3                   	ret    
8010712d:	8d 76 00             	lea    0x0(%esi),%esi
      cprintf("allocuvm out of memory (2)\n");
80107130:	83 ec 0c             	sub    $0xc,%esp
80107133:	68 a9 7e 10 80       	push   $0x80107ea9
80107138:	e8 23 95 ff ff       	call   80100660 <cprintf>
  if(newsz >= oldsz)
8010713d:	83 c4 10             	add    $0x10,%esp
80107140:	8b 45 0c             	mov    0xc(%ebp),%eax
80107143:	39 45 10             	cmp    %eax,0x10(%ebp)
80107146:	76 0d                	jbe    80107155 <allocuvm+0xe5>
80107148:	89 c1                	mov    %eax,%ecx
8010714a:	8b 55 10             	mov    0x10(%ebp),%edx
8010714d:	8b 45 08             	mov    0x8(%ebp),%eax
80107150:	e8 7b fb ff ff       	call   80106cd0 <deallocuvm.part.0>
      kfree(mem);
80107155:	83 ec 0c             	sub    $0xc,%esp
      return 0;
80107158:	31 ff                	xor    %edi,%edi
      kfree(mem);
8010715a:	56                   	push   %esi
8010715b:	e8 e0 b1 ff ff       	call   80102340 <kfree>
      return 0;
80107160:	83 c4 10             	add    $0x10,%esp
}
80107163:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107166:	89 f8                	mov    %edi,%eax
80107168:	5b                   	pop    %ebx
80107169:	5e                   	pop    %esi
8010716a:	5f                   	pop    %edi
8010716b:	5d                   	pop    %ebp
8010716c:	c3                   	ret    
8010716d:	8d 76 00             	lea    0x0(%esi),%esi
80107170:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80107173:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107176:	5b                   	pop    %ebx
80107177:	89 f8                	mov    %edi,%eax
80107179:	5e                   	pop    %esi
8010717a:	5f                   	pop    %edi
8010717b:	5d                   	pop    %ebp
8010717c:	c3                   	ret    
8010717d:	8d 76 00             	lea    0x0(%esi),%esi
80107180:	89 c1                	mov    %eax,%ecx
80107182:	8b 55 10             	mov    0x10(%ebp),%edx
80107185:	8b 45 08             	mov    0x8(%ebp),%eax
      return 0;
80107188:	31 ff                	xor    %edi,%edi
8010718a:	e8 41 fb ff ff       	call   80106cd0 <deallocuvm.part.0>
8010718f:	eb 92                	jmp    80107123 <allocuvm+0xb3>
80107191:	eb 0d                	jmp    801071a0 <deallocuvm>
80107193:	90                   	nop
80107194:	90                   	nop
80107195:	90                   	nop
80107196:	90                   	nop
80107197:	90                   	nop
80107198:	90                   	nop
80107199:	90                   	nop
8010719a:	90                   	nop
8010719b:	90                   	nop
8010719c:	90                   	nop
8010719d:	90                   	nop
8010719e:	90                   	nop
8010719f:	90                   	nop

801071a0 <deallocuvm>:
{
801071a0:	55                   	push   %ebp
801071a1:	89 e5                	mov    %esp,%ebp
801071a3:	8b 55 0c             	mov    0xc(%ebp),%edx
801071a6:	8b 4d 10             	mov    0x10(%ebp),%ecx
801071a9:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
801071ac:	39 d1                	cmp    %edx,%ecx
801071ae:	73 10                	jae    801071c0 <deallocuvm+0x20>
}
801071b0:	5d                   	pop    %ebp
801071b1:	e9 1a fb ff ff       	jmp    80106cd0 <deallocuvm.part.0>
801071b6:	8d 76 00             	lea    0x0(%esi),%esi
801071b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801071c0:	89 d0                	mov    %edx,%eax
801071c2:	5d                   	pop    %ebp
801071c3:	c3                   	ret    
801071c4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801071ca:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801071d0 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
801071d0:	55                   	push   %ebp
801071d1:	89 e5                	mov    %esp,%ebp
801071d3:	57                   	push   %edi
801071d4:	56                   	push   %esi
801071d5:	53                   	push   %ebx
801071d6:	83 ec 0c             	sub    $0xc,%esp
801071d9:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
801071dc:	85 f6                	test   %esi,%esi
801071de:	74 59                	je     80107239 <freevm+0x69>
801071e0:	31 c9                	xor    %ecx,%ecx
801071e2:	ba 00 00 00 80       	mov    $0x80000000,%edx
801071e7:	89 f0                	mov    %esi,%eax
801071e9:	e8 e2 fa ff ff       	call   80106cd0 <deallocuvm.part.0>
801071ee:	89 f3                	mov    %esi,%ebx
801071f0:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
801071f6:	eb 0f                	jmp    80107207 <freevm+0x37>
801071f8:	90                   	nop
801071f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107200:	83 c3 04             	add    $0x4,%ebx
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80107203:	39 fb                	cmp    %edi,%ebx
80107205:	74 23                	je     8010722a <freevm+0x5a>
    if(pgdir[i] & PTE_P){
80107207:	8b 03                	mov    (%ebx),%eax
80107209:	a8 01                	test   $0x1,%al
8010720b:	74 f3                	je     80107200 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
8010720d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      kfree(v);
80107212:	83 ec 0c             	sub    $0xc,%esp
80107215:	83 c3 04             	add    $0x4,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
80107218:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
8010721d:	50                   	push   %eax
8010721e:	e8 1d b1 ff ff       	call   80102340 <kfree>
80107223:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
80107226:	39 fb                	cmp    %edi,%ebx
80107228:	75 dd                	jne    80107207 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
8010722a:	89 75 08             	mov    %esi,0x8(%ebp)
}
8010722d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107230:	5b                   	pop    %ebx
80107231:	5e                   	pop    %esi
80107232:	5f                   	pop    %edi
80107233:	5d                   	pop    %ebp
  kfree((char*)pgdir);
80107234:	e9 07 b1 ff ff       	jmp    80102340 <kfree>
    panic("freevm: no pgdir");
80107239:	83 ec 0c             	sub    $0xc,%esp
8010723c:	68 c5 7e 10 80       	push   $0x80107ec5
80107241:	e8 4a 91 ff ff       	call   80100390 <panic>
80107246:	8d 76 00             	lea    0x0(%esi),%esi
80107249:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107250 <setupkvm>:
{
80107250:	55                   	push   %ebp
80107251:	89 e5                	mov    %esp,%ebp
80107253:	56                   	push   %esi
80107254:	53                   	push   %ebx
  if((pgdir = (pde_t*)kalloc()) == 0)
80107255:	e8 96 b2 ff ff       	call   801024f0 <kalloc>
8010725a:	85 c0                	test   %eax,%eax
8010725c:	89 c6                	mov    %eax,%esi
8010725e:	74 42                	je     801072a2 <setupkvm+0x52>
  memset(pgdir, 0, PGSIZE);
80107260:	83 ec 04             	sub    $0x4,%esp
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107263:	bb 20 a4 10 80       	mov    $0x8010a420,%ebx
  memset(pgdir, 0, PGSIZE);
80107268:	68 00 10 00 00       	push   $0x1000
8010726d:	6a 00                	push   $0x0
8010726f:	50                   	push   %eax
80107270:	e8 eb d6 ff ff       	call   80104960 <memset>
80107275:	83 c4 10             	add    $0x10,%esp
                (uint)k->phys_start, k->perm) < 0) {
80107278:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
8010727b:	8b 4b 08             	mov    0x8(%ebx),%ecx
8010727e:	83 ec 08             	sub    $0x8,%esp
80107281:	8b 13                	mov    (%ebx),%edx
80107283:	ff 73 0c             	pushl  0xc(%ebx)
80107286:	50                   	push   %eax
80107287:	29 c1                	sub    %eax,%ecx
80107289:	89 f0                	mov    %esi,%eax
8010728b:	e8 b0 f9 ff ff       	call   80106c40 <mappages>
80107290:	83 c4 10             	add    $0x10,%esp
80107293:	85 c0                	test   %eax,%eax
80107295:	78 19                	js     801072b0 <setupkvm+0x60>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107297:	83 c3 10             	add    $0x10,%ebx
8010729a:	81 fb 60 a4 10 80    	cmp    $0x8010a460,%ebx
801072a0:	75 d6                	jne    80107278 <setupkvm+0x28>
}
801072a2:	8d 65 f8             	lea    -0x8(%ebp),%esp
801072a5:	89 f0                	mov    %esi,%eax
801072a7:	5b                   	pop    %ebx
801072a8:	5e                   	pop    %esi
801072a9:	5d                   	pop    %ebp
801072aa:	c3                   	ret    
801072ab:	90                   	nop
801072ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      freevm(pgdir);
801072b0:	83 ec 0c             	sub    $0xc,%esp
801072b3:	56                   	push   %esi
      return 0;
801072b4:	31 f6                	xor    %esi,%esi
      freevm(pgdir);
801072b6:	e8 15 ff ff ff       	call   801071d0 <freevm>
      return 0;
801072bb:	83 c4 10             	add    $0x10,%esp
}
801072be:	8d 65 f8             	lea    -0x8(%ebp),%esp
801072c1:	89 f0                	mov    %esi,%eax
801072c3:	5b                   	pop    %ebx
801072c4:	5e                   	pop    %esi
801072c5:	5d                   	pop    %ebp
801072c6:	c3                   	ret    
801072c7:	89 f6                	mov    %esi,%esi
801072c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801072d0 <kvmalloc>:
{
801072d0:	55                   	push   %ebp
801072d1:	89 e5                	mov    %esp,%ebp
801072d3:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
801072d6:	e8 75 ff ff ff       	call   80107250 <setupkvm>
801072db:	a3 a4 99 11 80       	mov    %eax,0x801199a4
  lcr3(V2P(kpgdir));   // switch to the kernel page table
801072e0:	05 00 00 00 80       	add    $0x80000000,%eax
801072e5:	0f 22 d8             	mov    %eax,%cr3
}
801072e8:	c9                   	leave  
801072e9:	c3                   	ret    
801072ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801072f0 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
801072f0:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
801072f1:	31 c9                	xor    %ecx,%ecx
{
801072f3:	89 e5                	mov    %esp,%ebp
801072f5:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
801072f8:	8b 55 0c             	mov    0xc(%ebp),%edx
801072fb:	8b 45 08             	mov    0x8(%ebp),%eax
801072fe:	e8 bd f8 ff ff       	call   80106bc0 <walkpgdir>
  if(pte == 0)
80107303:	85 c0                	test   %eax,%eax
80107305:	74 05                	je     8010730c <clearpteu+0x1c>
    panic("clearpteu");
  *pte &= ~PTE_U;
80107307:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
8010730a:	c9                   	leave  
8010730b:	c3                   	ret    
    panic("clearpteu");
8010730c:	83 ec 0c             	sub    $0xc,%esp
8010730f:	68 d6 7e 10 80       	push   $0x80107ed6
80107314:	e8 77 90 ff ff       	call   80100390 <panic>
80107319:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107320 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80107320:	55                   	push   %ebp
80107321:	89 e5                	mov    %esp,%ebp
80107323:	57                   	push   %edi
80107324:	56                   	push   %esi
80107325:	53                   	push   %ebx
80107326:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80107329:	e8 22 ff ff ff       	call   80107250 <setupkvm>
8010732e:	85 c0                	test   %eax,%eax
80107330:	89 45 e0             	mov    %eax,-0x20(%ebp)
80107333:	0f 84 9f 00 00 00    	je     801073d8 <copyuvm+0xb8>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80107339:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010733c:	85 c9                	test   %ecx,%ecx
8010733e:	0f 84 94 00 00 00    	je     801073d8 <copyuvm+0xb8>
80107344:	31 ff                	xor    %edi,%edi
80107346:	eb 4a                	jmp    80107392 <copyuvm+0x72>
80107348:	90                   	nop
80107349:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80107350:	83 ec 04             	sub    $0x4,%esp
80107353:	81 c3 00 00 00 80    	add    $0x80000000,%ebx
80107359:	68 00 10 00 00       	push   $0x1000
8010735e:	53                   	push   %ebx
8010735f:	50                   	push   %eax
80107360:	e8 ab d6 ff ff       	call   80104a10 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
80107365:	58                   	pop    %eax
80107366:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
8010736c:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107371:	5a                   	pop    %edx
80107372:	ff 75 e4             	pushl  -0x1c(%ebp)
80107375:	50                   	push   %eax
80107376:	89 fa                	mov    %edi,%edx
80107378:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010737b:	e8 c0 f8 ff ff       	call   80106c40 <mappages>
80107380:	83 c4 10             	add    $0x10,%esp
80107383:	85 c0                	test   %eax,%eax
80107385:	78 61                	js     801073e8 <copyuvm+0xc8>
  for(i = 0; i < sz; i += PGSIZE){
80107387:	81 c7 00 10 00 00    	add    $0x1000,%edi
8010738d:	39 7d 0c             	cmp    %edi,0xc(%ebp)
80107390:	76 46                	jbe    801073d8 <copyuvm+0xb8>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80107392:	8b 45 08             	mov    0x8(%ebp),%eax
80107395:	31 c9                	xor    %ecx,%ecx
80107397:	89 fa                	mov    %edi,%edx
80107399:	e8 22 f8 ff ff       	call   80106bc0 <walkpgdir>
8010739e:	85 c0                	test   %eax,%eax
801073a0:	74 61                	je     80107403 <copyuvm+0xe3>
    if(!(*pte & PTE_P))
801073a2:	8b 00                	mov    (%eax),%eax
801073a4:	a8 01                	test   $0x1,%al
801073a6:	74 4e                	je     801073f6 <copyuvm+0xd6>
    pa = PTE_ADDR(*pte);
801073a8:	89 c3                	mov    %eax,%ebx
    flags = PTE_FLAGS(*pte);
801073aa:	25 ff 0f 00 00       	and    $0xfff,%eax
    pa = PTE_ADDR(*pte);
801073af:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
    flags = PTE_FLAGS(*pte);
801073b5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if((mem = kalloc()) == 0)
801073b8:	e8 33 b1 ff ff       	call   801024f0 <kalloc>
801073bd:	85 c0                	test   %eax,%eax
801073bf:	89 c6                	mov    %eax,%esi
801073c1:	75 8d                	jne    80107350 <copyuvm+0x30>
    }
  }
  return d;

bad:
  freevm(d);
801073c3:	83 ec 0c             	sub    $0xc,%esp
801073c6:	ff 75 e0             	pushl  -0x20(%ebp)
801073c9:	e8 02 fe ff ff       	call   801071d0 <freevm>
  return 0;
801073ce:	83 c4 10             	add    $0x10,%esp
801073d1:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
}
801073d8:	8b 45 e0             	mov    -0x20(%ebp),%eax
801073db:	8d 65 f4             	lea    -0xc(%ebp),%esp
801073de:	5b                   	pop    %ebx
801073df:	5e                   	pop    %esi
801073e0:	5f                   	pop    %edi
801073e1:	5d                   	pop    %ebp
801073e2:	c3                   	ret    
801073e3:	90                   	nop
801073e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      kfree(mem);
801073e8:	83 ec 0c             	sub    $0xc,%esp
801073eb:	56                   	push   %esi
801073ec:	e8 4f af ff ff       	call   80102340 <kfree>
      goto bad;
801073f1:	83 c4 10             	add    $0x10,%esp
801073f4:	eb cd                	jmp    801073c3 <copyuvm+0xa3>
      panic("copyuvm: page not present");
801073f6:	83 ec 0c             	sub    $0xc,%esp
801073f9:	68 fa 7e 10 80       	push   $0x80107efa
801073fe:	e8 8d 8f ff ff       	call   80100390 <panic>
      panic("copyuvm: pte should exist");
80107403:	83 ec 0c             	sub    $0xc,%esp
80107406:	68 e0 7e 10 80       	push   $0x80107ee0
8010740b:	e8 80 8f ff ff       	call   80100390 <panic>

80107410 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80107410:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107411:	31 c9                	xor    %ecx,%ecx
{
80107413:	89 e5                	mov    %esp,%ebp
80107415:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
80107418:	8b 55 0c             	mov    0xc(%ebp),%edx
8010741b:	8b 45 08             	mov    0x8(%ebp),%eax
8010741e:	e8 9d f7 ff ff       	call   80106bc0 <walkpgdir>
  if((*pte & PTE_P) == 0)
80107423:	8b 00                	mov    (%eax),%eax
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
80107425:	c9                   	leave  
  if((*pte & PTE_U) == 0)
80107426:	89 c2                	mov    %eax,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80107428:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((*pte & PTE_U) == 0)
8010742d:	83 e2 05             	and    $0x5,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80107430:	05 00 00 00 80       	add    $0x80000000,%eax
80107435:	83 fa 05             	cmp    $0x5,%edx
80107438:	ba 00 00 00 00       	mov    $0x0,%edx
8010743d:	0f 45 c2             	cmovne %edx,%eax
}
80107440:	c3                   	ret    
80107441:	eb 0d                	jmp    80107450 <copyout>
80107443:	90                   	nop
80107444:	90                   	nop
80107445:	90                   	nop
80107446:	90                   	nop
80107447:	90                   	nop
80107448:	90                   	nop
80107449:	90                   	nop
8010744a:	90                   	nop
8010744b:	90                   	nop
8010744c:	90                   	nop
8010744d:	90                   	nop
8010744e:	90                   	nop
8010744f:	90                   	nop

80107450 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80107450:	55                   	push   %ebp
80107451:	89 e5                	mov    %esp,%ebp
80107453:	57                   	push   %edi
80107454:	56                   	push   %esi
80107455:	53                   	push   %ebx
80107456:	83 ec 1c             	sub    $0x1c,%esp
80107459:	8b 5d 14             	mov    0x14(%ebp),%ebx
8010745c:	8b 55 0c             	mov    0xc(%ebp),%edx
8010745f:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80107462:	85 db                	test   %ebx,%ebx
80107464:	75 40                	jne    801074a6 <copyout+0x56>
80107466:	eb 70                	jmp    801074d8 <copyout+0x88>
80107468:	90                   	nop
80107469:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
80107470:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80107473:	89 f1                	mov    %esi,%ecx
80107475:	29 d1                	sub    %edx,%ecx
80107477:	81 c1 00 10 00 00    	add    $0x1000,%ecx
8010747d:	39 d9                	cmp    %ebx,%ecx
8010747f:	0f 47 cb             	cmova  %ebx,%ecx
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80107482:	29 f2                	sub    %esi,%edx
80107484:	83 ec 04             	sub    $0x4,%esp
80107487:	01 d0                	add    %edx,%eax
80107489:	51                   	push   %ecx
8010748a:	57                   	push   %edi
8010748b:	50                   	push   %eax
8010748c:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
8010748f:	e8 7c d5 ff ff       	call   80104a10 <memmove>
    len -= n;
    buf += n;
80107494:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
  while(len > 0){
80107497:	83 c4 10             	add    $0x10,%esp
    va = va0 + PGSIZE;
8010749a:	8d 96 00 10 00 00    	lea    0x1000(%esi),%edx
    buf += n;
801074a0:	01 cf                	add    %ecx,%edi
  while(len > 0){
801074a2:	29 cb                	sub    %ecx,%ebx
801074a4:	74 32                	je     801074d8 <copyout+0x88>
    va0 = (uint)PGROUNDDOWN(va);
801074a6:	89 d6                	mov    %edx,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
801074a8:	83 ec 08             	sub    $0x8,%esp
    va0 = (uint)PGROUNDDOWN(va);
801074ab:	89 55 e4             	mov    %edx,-0x1c(%ebp)
801074ae:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
801074b4:	56                   	push   %esi
801074b5:	ff 75 08             	pushl  0x8(%ebp)
801074b8:	e8 53 ff ff ff       	call   80107410 <uva2ka>
    if(pa0 == 0)
801074bd:	83 c4 10             	add    $0x10,%esp
801074c0:	85 c0                	test   %eax,%eax
801074c2:	75 ac                	jne    80107470 <copyout+0x20>
  }
  return 0;
}
801074c4:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
801074c7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801074cc:	5b                   	pop    %ebx
801074cd:	5e                   	pop    %esi
801074ce:	5f                   	pop    %edi
801074cf:	5d                   	pop    %ebp
801074d0:	c3                   	ret    
801074d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801074d8:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801074db:	31 c0                	xor    %eax,%eax
}
801074dd:	5b                   	pop    %ebx
801074de:	5e                   	pop    %esi
801074df:	5f                   	pop    %edi
801074e0:	5d                   	pop    %ebp
801074e1:	c3                   	ret    
