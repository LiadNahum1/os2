
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
80100015:	b8 00 a0 10 00       	mov    $0x10a000,%eax
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
80100028:	bc c0 c5 10 80       	mov    $0x8010c5c0,%esp

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
80100044:	bb f4 c5 10 80       	mov    $0x8010c5f4,%ebx
{
80100049:	83 ec 0c             	sub    $0xc,%esp
  initlock(&bcache.lock, "bcache");
8010004c:	68 c0 76 10 80       	push   $0x801076c0
80100051:	68 c0 c5 10 80       	push   $0x8010c5c0
80100056:	e8 75 48 00 00       	call   801048d0 <initlock>
  bcache.head.prev = &bcache.head;
8010005b:	c7 05 0c 0d 11 80 bc 	movl   $0x80110cbc,0x80110d0c
80100062:	0c 11 80 
  bcache.head.next = &bcache.head;
80100065:	c7 05 10 0d 11 80 bc 	movl   $0x80110cbc,0x80110d10
8010006c:	0c 11 80 
8010006f:	83 c4 10             	add    $0x10,%esp
80100072:	ba bc 0c 11 80       	mov    $0x80110cbc,%edx
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
8010008b:	c7 43 50 bc 0c 11 80 	movl   $0x80110cbc,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100092:	68 c7 76 10 80       	push   $0x801076c7
80100097:	50                   	push   %eax
80100098:	e8 03 47 00 00       	call   801047a0 <initsleeplock>
    bcache.head.next->prev = b;
8010009d:	a1 10 0d 11 80       	mov    0x80110d10,%eax
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000a2:	83 c4 10             	add    $0x10,%esp
801000a5:	89 da                	mov    %ebx,%edx
    bcache.head.next->prev = b;
801000a7:	89 58 50             	mov    %ebx,0x50(%eax)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000aa:	8d 83 5c 02 00 00    	lea    0x25c(%ebx),%eax
    bcache.head.next = b;
801000b0:	89 1d 10 0d 11 80    	mov    %ebx,0x80110d10
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000b6:	3d bc 0c 11 80       	cmp    $0x80110cbc,%eax
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
801000df:	68 c0 c5 10 80       	push   $0x8010c5c0
801000e4:	e8 27 49 00 00       	call   80104a10 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000e9:	8b 1d 10 0d 11 80    	mov    0x80110d10,%ebx
801000ef:	83 c4 10             	add    $0x10,%esp
801000f2:	81 fb bc 0c 11 80    	cmp    $0x80110cbc,%ebx
801000f8:	75 11                	jne    8010010b <bread+0x3b>
801000fa:	eb 24                	jmp    80100120 <bread+0x50>
801000fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb bc 0c 11 80    	cmp    $0x80110cbc,%ebx
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
80100120:	8b 1d 0c 0d 11 80    	mov    0x80110d0c,%ebx
80100126:	81 fb bc 0c 11 80    	cmp    $0x80110cbc,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 60                	jmp    80100190 <bread+0xc0>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb bc 0c 11 80    	cmp    $0x80110cbc,%ebx
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
8010015d:	68 c0 c5 10 80       	push   $0x8010c5c0
80100162:	e8 69 49 00 00       	call   80104ad0 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 6e 46 00 00       	call   801047e0 <acquiresleep>
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
80100193:	68 ce 76 10 80       	push   $0x801076ce
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
801001ae:	e8 cd 46 00 00       	call   80104880 <holdingsleep>
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
801001cc:	68 df 76 10 80       	push   $0x801076df
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
801001ef:	e8 8c 46 00 00       	call   80104880 <holdingsleep>
801001f4:	83 c4 10             	add    $0x10,%esp
801001f7:	85 c0                	test   %eax,%eax
801001f9:	74 66                	je     80100261 <brelse+0x81>
    panic("brelse");

  releasesleep(&b->lock);
801001fb:	83 ec 0c             	sub    $0xc,%esp
801001fe:	56                   	push   %esi
801001ff:	e8 3c 46 00 00       	call   80104840 <releasesleep>

  acquire(&bcache.lock);
80100204:	c7 04 24 c0 c5 10 80 	movl   $0x8010c5c0,(%esp)
8010020b:	e8 00 48 00 00       	call   80104a10 <acquire>
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
80100232:	a1 10 0d 11 80       	mov    0x80110d10,%eax
    b->prev = &bcache.head;
80100237:	c7 43 50 bc 0c 11 80 	movl   $0x80110cbc,0x50(%ebx)
    b->next = bcache.head.next;
8010023e:	89 43 54             	mov    %eax,0x54(%ebx)
    bcache.head.next->prev = b;
80100241:	a1 10 0d 11 80       	mov    0x80110d10,%eax
80100246:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
80100249:	89 1d 10 0d 11 80    	mov    %ebx,0x80110d10
  }
  
  release(&bcache.lock);
8010024f:	c7 45 08 c0 c5 10 80 	movl   $0x8010c5c0,0x8(%ebp)
}
80100256:	8d 65 f8             	lea    -0x8(%ebp),%esp
80100259:	5b                   	pop    %ebx
8010025a:	5e                   	pop    %esi
8010025b:	5d                   	pop    %ebp
  release(&bcache.lock);
8010025c:	e9 6f 48 00 00       	jmp    80104ad0 <release>
    panic("brelse");
80100261:	83 ec 0c             	sub    $0xc,%esp
80100264:	68 e6 76 10 80       	push   $0x801076e6
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
80100285:	c7 04 24 20 b5 10 80 	movl   $0x8010b520,(%esp)
8010028c:	e8 7f 47 00 00       	call   80104a10 <acquire>
  while(n > 0){
80100291:	8b 5d 10             	mov    0x10(%ebp),%ebx
80100294:	83 c4 10             	add    $0x10,%esp
80100297:	31 c0                	xor    %eax,%eax
80100299:	85 db                	test   %ebx,%ebx
8010029b:	0f 8e a1 00 00 00    	jle    80100342 <consoleread+0xd2>
    while(input.r == input.w){
801002a1:	8b 15 a0 0f 11 80    	mov    0x80110fa0,%edx
801002a7:	39 15 a4 0f 11 80    	cmp    %edx,0x80110fa4
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
801002bb:	68 20 b5 10 80       	push   $0x8010b520
801002c0:	68 a0 0f 11 80       	push   $0x80110fa0
801002c5:	e8 06 3d 00 00       	call   80103fd0 <sleep>
    while(input.r == input.w){
801002ca:	8b 15 a0 0f 11 80    	mov    0x80110fa0,%edx
801002d0:	83 c4 10             	add    $0x10,%esp
801002d3:	3b 15 a4 0f 11 80    	cmp    0x80110fa4,%edx
801002d9:	75 35                	jne    80100310 <consoleread+0xa0>
      if(myproc()->killed){
801002db:	e8 70 35 00 00       	call   80103850 <myproc>
801002e0:	8b 40 24             	mov    0x24(%eax),%eax
801002e3:	85 c0                	test   %eax,%eax
801002e5:	74 d1                	je     801002b8 <consoleread+0x48>
        release(&cons.lock);
801002e7:	83 ec 0c             	sub    $0xc,%esp
801002ea:	68 20 b5 10 80       	push   $0x8010b520
801002ef:	e8 dc 47 00 00       	call   80104ad0 <release>
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
80100313:	a3 a0 0f 11 80       	mov    %eax,0x80110fa0
80100318:	89 d0                	mov    %edx,%eax
8010031a:	83 e0 7f             	and    $0x7f,%eax
8010031d:	0f be 80 20 0f 11 80 	movsbl -0x7feef0e0(%eax),%eax
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
80100348:	68 20 b5 10 80       	push   $0x8010b520
8010034d:	e8 7e 47 00 00       	call   80104ad0 <release>
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
80100372:	89 15 a0 0f 11 80    	mov    %edx,0x80110fa0
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
80100399:	c7 05 54 b5 10 80 00 	movl   $0x0,0x8010b554
801003a0:	00 00 00 
  getcallerpcs(&s, pcs);
801003a3:	8d 5d d0             	lea    -0x30(%ebp),%ebx
801003a6:	8d 75 f8             	lea    -0x8(%ebp),%esi
  cprintf("lapicid %d: panic: ", lapicid());
801003a9:	e8 b2 23 00 00       	call   80102760 <lapicid>
801003ae:	83 ec 08             	sub    $0x8,%esp
801003b1:	50                   	push   %eax
801003b2:	68 ed 76 10 80       	push   $0x801076ed
801003b7:	e8 a4 02 00 00       	call   80100660 <cprintf>
  cprintf(s);
801003bc:	58                   	pop    %eax
801003bd:	ff 75 08             	pushl  0x8(%ebp)
801003c0:	e8 9b 02 00 00       	call   80100660 <cprintf>
  cprintf("\n");
801003c5:	c7 04 24 23 80 10 80 	movl   $0x80108023,(%esp)
801003cc:	e8 8f 02 00 00       	call   80100660 <cprintf>
  getcallerpcs(&s, pcs);
801003d1:	5a                   	pop    %edx
801003d2:	8d 45 08             	lea    0x8(%ebp),%eax
801003d5:	59                   	pop    %ecx
801003d6:	53                   	push   %ebx
801003d7:	50                   	push   %eax
801003d8:	e8 13 45 00 00       	call   801048f0 <getcallerpcs>
801003dd:	83 c4 10             	add    $0x10,%esp
    cprintf(" %p", pcs[i]);
801003e0:	83 ec 08             	sub    $0x8,%esp
801003e3:	ff 33                	pushl  (%ebx)
801003e5:	83 c3 04             	add    $0x4,%ebx
801003e8:	68 01 77 10 80       	push   $0x80107701
801003ed:	e8 6e 02 00 00       	call   80100660 <cprintf>
  for(i=0; i<10; i++)
801003f2:	83 c4 10             	add    $0x10,%esp
801003f5:	39 f3                	cmp    %esi,%ebx
801003f7:	75 e7                	jne    801003e0 <panic+0x50>
  panicked = 1; // freeze other CPU
801003f9:	c7 05 58 b5 10 80 01 	movl   $0x1,0x8010b558
80100400:	00 00 00 
80100403:	eb fe                	jmp    80100403 <panic+0x73>
80100405:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100409:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100410 <consputc>:
  if(panicked){
80100410:	8b 0d 58 b5 10 80    	mov    0x8010b558,%ecx
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
8010043a:	e8 91 5e 00 00       	call   801062d0 <uartputc>
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
801004ec:	e8 df 5d 00 00       	call   801062d0 <uartputc>
801004f1:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801004f8:	e8 d3 5d 00 00       	call   801062d0 <uartputc>
801004fd:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80100504:	e8 c7 5d 00 00       	call   801062d0 <uartputc>
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
80100524:	e8 a7 46 00 00       	call   80104bd0 <memmove>
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
80100541:	e8 da 45 00 00       	call   80104b20 <memset>
80100546:	83 c4 10             	add    $0x10,%esp
80100549:	e9 5d ff ff ff       	jmp    801004ab <consputc+0x9b>
    panic("pos under/overflow");
8010054e:	83 ec 0c             	sub    $0xc,%esp
80100551:	68 05 77 10 80       	push   $0x80107705
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
801005b1:	0f b6 92 30 77 10 80 	movzbl -0x7fef88d0(%edx),%edx
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
80100614:	c7 04 24 20 b5 10 80 	movl   $0x8010b520,(%esp)
8010061b:	e8 f0 43 00 00       	call   80104a10 <acquire>
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
80100642:	68 20 b5 10 80       	push   $0x8010b520
80100647:	e8 84 44 00 00       	call   80104ad0 <release>
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
80100669:	a1 54 b5 10 80       	mov    0x8010b554,%eax
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
8010071a:	68 20 b5 10 80       	push   $0x8010b520
8010071f:	e8 ac 43 00 00       	call   80104ad0 <release>
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
801007d0:	ba 18 77 10 80       	mov    $0x80107718,%edx
      for(; *s; s++)
801007d5:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
801007d8:	b8 28 00 00 00       	mov    $0x28,%eax
801007dd:	89 d3                	mov    %edx,%ebx
801007df:	eb bf                	jmp    801007a0 <cprintf+0x140>
801007e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    acquire(&cons.lock);
801007e8:	83 ec 0c             	sub    $0xc,%esp
801007eb:	68 20 b5 10 80       	push   $0x8010b520
801007f0:	e8 1b 42 00 00       	call   80104a10 <acquire>
801007f5:	83 c4 10             	add    $0x10,%esp
801007f8:	e9 7c fe ff ff       	jmp    80100679 <cprintf+0x19>
    panic("null fmt");
801007fd:	83 ec 0c             	sub    $0xc,%esp
80100800:	68 1f 77 10 80       	push   $0x8010771f
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
8010081e:	68 20 b5 10 80       	push   $0x8010b520
80100823:	e8 e8 41 00 00       	call   80104a10 <acquire>
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
80100851:	a1 a8 0f 11 80       	mov    0x80110fa8,%eax
80100856:	3b 05 a4 0f 11 80    	cmp    0x80110fa4,%eax
8010085c:	74 d2                	je     80100830 <consoleintr+0x20>
        input.e--;
8010085e:	83 e8 01             	sub    $0x1,%eax
80100861:	a3 a8 0f 11 80       	mov    %eax,0x80110fa8
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
80100883:	68 20 b5 10 80       	push   $0x8010b520
80100888:	e8 43 42 00 00       	call   80104ad0 <release>
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
801008a9:	a1 a8 0f 11 80       	mov    0x80110fa8,%eax
801008ae:	89 c2                	mov    %eax,%edx
801008b0:	2b 15 a0 0f 11 80    	sub    0x80110fa0,%edx
801008b6:	83 fa 7f             	cmp    $0x7f,%edx
801008b9:	0f 87 71 ff ff ff    	ja     80100830 <consoleintr+0x20>
801008bf:	8d 50 01             	lea    0x1(%eax),%edx
801008c2:	83 e0 7f             	and    $0x7f,%eax
        c = (c == '\r') ? '\n' : c;
801008c5:	83 ff 0d             	cmp    $0xd,%edi
        input.buf[input.e++ % INPUT_BUF] = c;
801008c8:	89 15 a8 0f 11 80    	mov    %edx,0x80110fa8
        c = (c == '\r') ? '\n' : c;
801008ce:	0f 84 cc 00 00 00    	je     801009a0 <consoleintr+0x190>
        input.buf[input.e++ % INPUT_BUF] = c;
801008d4:	89 f9                	mov    %edi,%ecx
801008d6:	88 88 20 0f 11 80    	mov    %cl,-0x7feef0e0(%eax)
        consputc(c);
801008dc:	89 f8                	mov    %edi,%eax
801008de:	e8 2d fb ff ff       	call   80100410 <consputc>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
801008e3:	83 ff 0a             	cmp    $0xa,%edi
801008e6:	0f 84 c5 00 00 00    	je     801009b1 <consoleintr+0x1a1>
801008ec:	83 ff 04             	cmp    $0x4,%edi
801008ef:	0f 84 bc 00 00 00    	je     801009b1 <consoleintr+0x1a1>
801008f5:	a1 a0 0f 11 80       	mov    0x80110fa0,%eax
801008fa:	83 e8 80             	sub    $0xffffff80,%eax
801008fd:	39 05 a8 0f 11 80    	cmp    %eax,0x80110fa8
80100903:	0f 85 27 ff ff ff    	jne    80100830 <consoleintr+0x20>
          wakeup(&input.r);
80100909:	83 ec 0c             	sub    $0xc,%esp
          input.w = input.e;
8010090c:	a3 a4 0f 11 80       	mov    %eax,0x80110fa4
          wakeup(&input.r);
80100911:	68 a0 0f 11 80       	push   $0x80110fa0
80100916:	e8 b5 38 00 00       	call   801041d0 <wakeup>
8010091b:	83 c4 10             	add    $0x10,%esp
8010091e:	e9 0d ff ff ff       	jmp    80100830 <consoleintr+0x20>
80100923:	90                   	nop
80100924:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      doprocdump = 1;
80100928:	be 01 00 00 00       	mov    $0x1,%esi
8010092d:	e9 fe fe ff ff       	jmp    80100830 <consoleintr+0x20>
80100932:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      while(input.e != input.w &&
80100938:	a1 a8 0f 11 80       	mov    0x80110fa8,%eax
8010093d:	39 05 a4 0f 11 80    	cmp    %eax,0x80110fa4
80100943:	75 2b                	jne    80100970 <consoleintr+0x160>
80100945:	e9 e6 fe ff ff       	jmp    80100830 <consoleintr+0x20>
8010094a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        input.e--;
80100950:	a3 a8 0f 11 80       	mov    %eax,0x80110fa8
        consputc(BACKSPACE);
80100955:	b8 00 01 00 00       	mov    $0x100,%eax
8010095a:	e8 b1 fa ff ff       	call   80100410 <consputc>
      while(input.e != input.w &&
8010095f:	a1 a8 0f 11 80       	mov    0x80110fa8,%eax
80100964:	3b 05 a4 0f 11 80    	cmp    0x80110fa4,%eax
8010096a:	0f 84 c0 fe ff ff    	je     80100830 <consoleintr+0x20>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100970:	83 e8 01             	sub    $0x1,%eax
80100973:	89 c2                	mov    %eax,%edx
80100975:	83 e2 7f             	and    $0x7f,%edx
      while(input.e != input.w &&
80100978:	80 ba 20 0f 11 80 0a 	cmpb   $0xa,-0x7feef0e0(%edx)
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
80100997:	e9 54 39 00 00       	jmp    801042f0 <procdump>
8010099c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        input.buf[input.e++ % INPUT_BUF] = c;
801009a0:	c6 80 20 0f 11 80 0a 	movb   $0xa,-0x7feef0e0(%eax)
        consputc(c);
801009a7:	b8 0a 00 00 00       	mov    $0xa,%eax
801009ac:	e8 5f fa ff ff       	call   80100410 <consputc>
801009b1:	a1 a8 0f 11 80       	mov    0x80110fa8,%eax
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
801009c6:	68 28 77 10 80       	push   $0x80107728
801009cb:	68 20 b5 10 80       	push   $0x8010b520
801009d0:	e8 fb 3e 00 00       	call   801048d0 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  ioapicenable(IRQ_KBD, 0);
801009d5:	58                   	pop    %eax
801009d6:	5a                   	pop    %edx
801009d7:	6a 00                	push   $0x0
801009d9:	6a 01                	push   $0x1
  devsw[CONSOLE].write = consolewrite;
801009db:	c7 05 6c 19 11 80 00 	movl   $0x80100600,0x8011196c
801009e2:	06 10 80 
  devsw[CONSOLE].read = consoleread;
801009e5:	c7 05 68 19 11 80 70 	movl   $0x80100270,0x80111968
801009ec:	02 10 80 
  cons.locking = 1;
801009ef:	c7 05 54 b5 10 80 01 	movl   $0x1,0x8010b554
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
80100a1c:	e8 2f 2e 00 00       	call   80103850 <myproc>
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
80100a94:	e8 87 69 00 00       	call   80107420 <setupkvm>
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
80100af6:	e8 45 67 00 00       	call   80107240 <allocuvm>
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
80100b28:	e8 53 66 00 00       	call   80107180 <loaduvm>
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
80100b72:	e8 29 68 00 00       	call   801073a0 <freevm>
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
80100baa:	e8 91 66 00 00       	call   80107240 <allocuvm>
80100baf:	83 c4 10             	add    $0x10,%esp
80100bb2:	85 c0                	test   %eax,%eax
80100bb4:	89 c6                	mov    %eax,%esi
80100bb6:	75 3a                	jne    80100bf2 <exec+0x1e2>
    freevm(pgdir);
80100bb8:	83 ec 0c             	sub    $0xc,%esp
80100bbb:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100bc1:	e8 da 67 00 00       	call   801073a0 <freevm>
80100bc6:	83 c4 10             	add    $0x10,%esp
  return -1;
80100bc9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100bce:	e9 a9 fe ff ff       	jmp    80100a7c <exec+0x6c>
    end_op();
80100bd3:	e8 68 20 00 00       	call   80102c40 <end_op>
    cprintf("exec: fail\n");
80100bd8:	83 ec 0c             	sub    $0xc,%esp
80100bdb:	68 41 77 10 80       	push   $0x80107741
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
80100c06:	e8 b5 68 00 00       	call   801074c0 <clearpteu>
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
80100c39:	e8 02 41 00 00       	call   80104d40 <strlen>
80100c3e:	f7 d0                	not    %eax
80100c40:	01 c3                	add    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c42:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c45:	5a                   	pop    %edx
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100c46:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c49:	ff 34 b8             	pushl  (%eax,%edi,4)
80100c4c:	e8 ef 40 00 00       	call   80104d40 <strlen>
80100c51:	83 c0 01             	add    $0x1,%eax
80100c54:	50                   	push   %eax
80100c55:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c58:	ff 34 b8             	pushl  (%eax,%edi,4)
80100c5b:	53                   	push   %ebx
80100c5c:	56                   	push   %esi
80100c5d:	e8 be 69 00 00       	call   80107620 <copyout>
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
80100cc7:	e8 54 69 00 00       	call   80107620 <copyout>
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
80100d08:	e8 f3 3f 00 00       	call   80104d00 <safestrcpy>
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
80100d63:	e8 88 62 00 00       	call   80106ff0 <switchuvm>
  freevm(oldpgdir);
80100d68:	89 3c 24             	mov    %edi,(%esp)
80100d6b:	e8 30 66 00 00       	call   801073a0 <freevm>
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
80100d96:	68 4d 77 10 80       	push   $0x8010774d
80100d9b:	68 c0 0f 11 80       	push   $0x80110fc0
80100da0:	e8 2b 3b 00 00       	call   801048d0 <initlock>
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
80100db4:	bb f4 0f 11 80       	mov    $0x80110ff4,%ebx
{
80100db9:	83 ec 10             	sub    $0x10,%esp
  acquire(&ftable.lock);
80100dbc:	68 c0 0f 11 80       	push   $0x80110fc0
80100dc1:	e8 4a 3c 00 00       	call   80104a10 <acquire>
80100dc6:	83 c4 10             	add    $0x10,%esp
80100dc9:	eb 10                	jmp    80100ddb <filealloc+0x2b>
80100dcb:	90                   	nop
80100dcc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100dd0:	83 c3 18             	add    $0x18,%ebx
80100dd3:	81 fb 54 19 11 80    	cmp    $0x80111954,%ebx
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
80100dec:	68 c0 0f 11 80       	push   $0x80110fc0
80100df1:	e8 da 3c 00 00       	call   80104ad0 <release>
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
80100e05:	68 c0 0f 11 80       	push   $0x80110fc0
80100e0a:	e8 c1 3c 00 00       	call   80104ad0 <release>
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
80100e2a:	68 c0 0f 11 80       	push   $0x80110fc0
80100e2f:	e8 dc 3b 00 00       	call   80104a10 <acquire>
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
80100e47:	68 c0 0f 11 80       	push   $0x80110fc0
80100e4c:	e8 7f 3c 00 00       	call   80104ad0 <release>
  return f;
}
80100e51:	89 d8                	mov    %ebx,%eax
80100e53:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100e56:	c9                   	leave  
80100e57:	c3                   	ret    
    panic("filedup");
80100e58:	83 ec 0c             	sub    $0xc,%esp
80100e5b:	68 54 77 10 80       	push   $0x80107754
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
80100e7c:	68 c0 0f 11 80       	push   $0x80110fc0
80100e81:	e8 8a 3b 00 00       	call   80104a10 <acquire>
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
80100e9e:	c7 45 08 c0 0f 11 80 	movl   $0x80110fc0,0x8(%ebp)
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
80100eac:	e9 1f 3c 00 00       	jmp    80104ad0 <release>
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
80100ed0:	68 c0 0f 11 80       	push   $0x80110fc0
  ff = *f;
80100ed5:	89 45 e0             	mov    %eax,-0x20(%ebp)
  release(&ftable.lock);
80100ed8:	e8 f3 3b 00 00       	call   80104ad0 <release>
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
80100f32:	68 5c 77 10 80       	push   $0x8010775c
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
80101012:	68 66 77 10 80       	push   $0x80107766
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
80101125:	68 6f 77 10 80       	push   $0x8010776f
8010112a:	e8 61 f2 ff ff       	call   80100390 <panic>
  panic("filewrite");
8010112f:	83 ec 0c             	sub    $0xc,%esp
80101132:	68 75 77 10 80       	push   $0x80107775
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
8010114a:	03 15 d8 19 11 80    	add    0x801119d8,%edx
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
801011a3:	68 7f 77 10 80       	push   $0x8010777f
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
801011b9:	8b 0d c0 19 11 80    	mov    0x801119c0,%ecx
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
801011dc:	03 05 d8 19 11 80    	add    0x801119d8,%eax
801011e2:	50                   	push   %eax
801011e3:	ff 75 d8             	pushl  -0x28(%ebp)
801011e6:	e8 e5 ee ff ff       	call   801000d0 <bread>
801011eb:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801011ee:	a1 c0 19 11 80       	mov    0x801119c0,%eax
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
80101249:	39 05 c0 19 11 80    	cmp    %eax,0x801119c0
8010124f:	77 80                	ja     801011d1 <balloc+0x21>
  panic("balloc: out of blocks");
80101251:	83 ec 0c             	sub    $0xc,%esp
80101254:	68 92 77 10 80       	push   $0x80107792
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
80101295:	e8 86 38 00 00       	call   80104b20 <memset>
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
801012ca:	bb 14 1a 11 80       	mov    $0x80111a14,%ebx
{
801012cf:	83 ec 28             	sub    $0x28,%esp
801012d2:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  acquire(&icache.lock);
801012d5:	68 e0 19 11 80       	push   $0x801119e0
801012da:	e8 31 37 00 00       	call   80104a10 <acquire>
801012df:	83 c4 10             	add    $0x10,%esp
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801012e2:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801012e5:	eb 17                	jmp    801012fe <iget+0x3e>
801012e7:	89 f6                	mov    %esi,%esi
801012e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801012f0:	81 c3 90 00 00 00    	add    $0x90,%ebx
801012f6:	81 fb 34 36 11 80    	cmp    $0x80113634,%ebx
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
80101318:	81 fb 34 36 11 80    	cmp    $0x80113634,%ebx
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
8010133a:	68 e0 19 11 80       	push   $0x801119e0
8010133f:	e8 8c 37 00 00       	call   80104ad0 <release>

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
80101365:	68 e0 19 11 80       	push   $0x801119e0
      ip->ref++;
8010136a:	89 4b 08             	mov    %ecx,0x8(%ebx)
      release(&icache.lock);
8010136d:	e8 5e 37 00 00       	call   80104ad0 <release>
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
80101382:	68 a8 77 10 80       	push   $0x801077a8
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
80101457:	68 b8 77 10 80       	push   $0x801077b8
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
80101491:	e8 3a 37 00 00       	call   80104bd0 <memmove>
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
801014b4:	bb 20 1a 11 80       	mov    $0x80111a20,%ebx
801014b9:	83 ec 0c             	sub    $0xc,%esp
  initlock(&icache.lock, "icache");
801014bc:	68 cb 77 10 80       	push   $0x801077cb
801014c1:	68 e0 19 11 80       	push   $0x801119e0
801014c6:	e8 05 34 00 00       	call   801048d0 <initlock>
801014cb:	83 c4 10             	add    $0x10,%esp
801014ce:	66 90                	xchg   %ax,%ax
    initsleeplock(&icache.inode[i].lock, "inode");
801014d0:	83 ec 08             	sub    $0x8,%esp
801014d3:	68 d2 77 10 80       	push   $0x801077d2
801014d8:	53                   	push   %ebx
801014d9:	81 c3 90 00 00 00    	add    $0x90,%ebx
801014df:	e8 bc 32 00 00       	call   801047a0 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
801014e4:	83 c4 10             	add    $0x10,%esp
801014e7:	81 fb 40 36 11 80    	cmp    $0x80113640,%ebx
801014ed:	75 e1                	jne    801014d0 <iinit+0x20>
  readsb(dev, &sb);
801014ef:	83 ec 08             	sub    $0x8,%esp
801014f2:	68 c0 19 11 80       	push   $0x801119c0
801014f7:	ff 75 08             	pushl  0x8(%ebp)
801014fa:	e8 71 ff ff ff       	call   80101470 <readsb>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
801014ff:	ff 35 d8 19 11 80    	pushl  0x801119d8
80101505:	ff 35 d4 19 11 80    	pushl  0x801119d4
8010150b:	ff 35 d0 19 11 80    	pushl  0x801119d0
80101511:	ff 35 cc 19 11 80    	pushl  0x801119cc
80101517:	ff 35 c8 19 11 80    	pushl  0x801119c8
8010151d:	ff 35 c4 19 11 80    	pushl  0x801119c4
80101523:	ff 35 c0 19 11 80    	pushl  0x801119c0
80101529:	68 38 78 10 80       	push   $0x80107838
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
80101549:	83 3d c8 19 11 80 01 	cmpl   $0x1,0x801119c8
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
8010157f:	39 1d c8 19 11 80    	cmp    %ebx,0x801119c8
80101585:	76 69                	jbe    801015f0 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
80101587:	89 d8                	mov    %ebx,%eax
80101589:	83 ec 08             	sub    $0x8,%esp
8010158c:	c1 e8 03             	shr    $0x3,%eax
8010158f:	03 05 d4 19 11 80    	add    0x801119d4,%eax
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
801015be:	e8 5d 35 00 00       	call   80104b20 <memset>
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
801015f3:	68 d8 77 10 80       	push   $0x801077d8
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
80101614:	03 05 d4 19 11 80    	add    0x801119d4,%eax
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
80101661:	e8 6a 35 00 00       	call   80104bd0 <memmove>
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
8010168a:	68 e0 19 11 80       	push   $0x801119e0
8010168f:	e8 7c 33 00 00       	call   80104a10 <acquire>
  ip->ref++;
80101694:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101698:	c7 04 24 e0 19 11 80 	movl   $0x801119e0,(%esp)
8010169f:	e8 2c 34 00 00       	call   80104ad0 <release>
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
801016d2:	e8 09 31 00 00       	call   801047e0 <acquiresleep>
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
801016f9:	03 05 d4 19 11 80    	add    0x801119d4,%eax
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
80101748:	e8 83 34 00 00       	call   80104bd0 <memmove>
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
8010176d:	68 f0 77 10 80       	push   $0x801077f0
80101772:	e8 19 ec ff ff       	call   80100390 <panic>
    panic("ilock");
80101777:	83 ec 0c             	sub    $0xc,%esp
8010177a:	68 ea 77 10 80       	push   $0x801077ea
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
801017a3:	e8 d8 30 00 00       	call   80104880 <holdingsleep>
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
801017bf:	e9 7c 30 00 00       	jmp    80104840 <releasesleep>
    panic("iunlock");
801017c4:	83 ec 0c             	sub    $0xc,%esp
801017c7:	68 ff 77 10 80       	push   $0x801077ff
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
801017f0:	e8 eb 2f 00 00       	call   801047e0 <acquiresleep>
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
8010180a:	e8 31 30 00 00       	call   80104840 <releasesleep>
  acquire(&icache.lock);
8010180f:	c7 04 24 e0 19 11 80 	movl   $0x801119e0,(%esp)
80101816:	e8 f5 31 00 00       	call   80104a10 <acquire>
  ip->ref--;
8010181b:	83 6b 08 01          	subl   $0x1,0x8(%ebx)
  release(&icache.lock);
8010181f:	83 c4 10             	add    $0x10,%esp
80101822:	c7 45 08 e0 19 11 80 	movl   $0x801119e0,0x8(%ebp)
}
80101829:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010182c:	5b                   	pop    %ebx
8010182d:	5e                   	pop    %esi
8010182e:	5f                   	pop    %edi
8010182f:	5d                   	pop    %ebp
  release(&icache.lock);
80101830:	e9 9b 32 00 00       	jmp    80104ad0 <release>
80101835:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&icache.lock);
80101838:	83 ec 0c             	sub    $0xc,%esp
8010183b:	68 e0 19 11 80       	push   $0x801119e0
80101840:	e8 cb 31 00 00       	call   80104a10 <acquire>
    int r = ip->ref;
80101845:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
80101848:	c7 04 24 e0 19 11 80 	movl   $0x801119e0,(%esp)
8010184f:	e8 7c 32 00 00       	call   80104ad0 <release>
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
80101a37:	e8 94 31 00 00       	call   80104bd0 <memmove>
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
80101a6a:	8b 04 c5 60 19 11 80 	mov    -0x7feee6a0(,%eax,8),%eax
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
80101b33:	e8 98 30 00 00       	call   80104bd0 <memmove>
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
80101b7a:	8b 04 c5 64 19 11 80 	mov    -0x7feee69c(,%eax,8),%eax
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
80101bce:	e8 6d 30 00 00       	call   80104c40 <strncmp>
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
80101c2d:	e8 0e 30 00 00       	call   80104c40 <strncmp>
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
80101c72:	68 19 78 10 80       	push   $0x80107819
80101c77:	e8 14 e7 ff ff       	call   80100390 <panic>
    panic("dirlookup not DIR");
80101c7c:	83 ec 0c             	sub    $0xc,%esp
80101c7f:	68 07 78 10 80       	push   $0x80107807
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
80101ca9:	e8 a2 1b 00 00       	call   80103850 <myproc>
  acquire(&icache.lock);
80101cae:	83 ec 0c             	sub    $0xc,%esp
    ip = idup(myproc()->cwd);
80101cb1:	8b 70 68             	mov    0x68(%eax),%esi
  acquire(&icache.lock);
80101cb4:	68 e0 19 11 80       	push   $0x801119e0
80101cb9:	e8 52 2d 00 00       	call   80104a10 <acquire>
  ip->ref++;
80101cbe:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80101cc2:	c7 04 24 e0 19 11 80 	movl   $0x801119e0,(%esp)
80101cc9:	e8 02 2e 00 00       	call   80104ad0 <release>
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
80101d25:	e8 a6 2e 00 00       	call   80104bd0 <memmove>
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
80101db8:	e8 13 2e 00 00       	call   80104bd0 <memmove>
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
80101ead:	e8 ee 2d 00 00       	call   80104ca0 <strncpy>
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
80101eeb:	68 28 78 10 80       	push   $0x80107828
80101ef0:	e8 9b e4 ff ff       	call   80100390 <panic>
    panic("dirlink");
80101ef5:	83 ec 0c             	sub    $0xc,%esp
80101ef8:	68 0a 7e 10 80       	push   $0x80107e0a
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
8010200b:	68 94 78 10 80       	push   $0x80107894
80102010:	e8 7b e3 ff ff       	call   80100390 <panic>
    panic("idestart");
80102015:	83 ec 0c             	sub    $0xc,%esp
80102018:	68 8b 78 10 80       	push   $0x8010788b
8010201d:	e8 6e e3 ff ff       	call   80100390 <panic>
80102022:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102029:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102030 <ideinit>:
{
80102030:	55                   	push   %ebp
80102031:	89 e5                	mov    %esp,%ebp
80102033:	83 ec 10             	sub    $0x10,%esp
  initlock(&idelock, "ide");
80102036:	68 a6 78 10 80       	push   $0x801078a6
8010203b:	68 80 b5 10 80       	push   $0x8010b580
80102040:	e8 8b 28 00 00       	call   801048d0 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
80102045:	58                   	pop    %eax
80102046:	a1 00 3d 11 80       	mov    0x80113d00,%eax
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
8010208a:	c7 05 60 b5 10 80 01 	movl   $0x1,0x8010b560
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
801020b9:	68 80 b5 10 80       	push   $0x8010b580
801020be:	e8 4d 29 00 00       	call   80104a10 <acquire>

  if((b = idequeue) == 0){
801020c3:	8b 1d 64 b5 10 80    	mov    0x8010b564,%ebx
801020c9:	83 c4 10             	add    $0x10,%esp
801020cc:	85 db                	test   %ebx,%ebx
801020ce:	74 67                	je     80102137 <ideintr+0x87>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
801020d0:	8b 43 58             	mov    0x58(%ebx),%eax
801020d3:	a3 64 b5 10 80       	mov    %eax,0x8010b564

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
80102121:	e8 aa 20 00 00       	call   801041d0 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
80102126:	a1 64 b5 10 80       	mov    0x8010b564,%eax
8010212b:	83 c4 10             	add    $0x10,%esp
8010212e:	85 c0                	test   %eax,%eax
80102130:	74 05                	je     80102137 <ideintr+0x87>
    idestart(idequeue);
80102132:	e8 19 fe ff ff       	call   80101f50 <idestart>
    release(&idelock);
80102137:	83 ec 0c             	sub    $0xc,%esp
8010213a:	68 80 b5 10 80       	push   $0x8010b580
8010213f:	e8 8c 29 00 00       	call   80104ad0 <release>

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
8010215e:	e8 1d 27 00 00       	call   80104880 <holdingsleep>
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
80102183:	a1 60 b5 10 80       	mov    0x8010b560,%eax
80102188:	85 c0                	test   %eax,%eax
8010218a:	0f 84 b1 00 00 00    	je     80102241 <iderw+0xf1>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
80102190:	83 ec 0c             	sub    $0xc,%esp
80102193:	68 80 b5 10 80       	push   $0x8010b580
80102198:	e8 73 28 00 00       	call   80104a10 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010219d:	8b 15 64 b5 10 80    	mov    0x8010b564,%edx
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
801021c6:	39 1d 64 b5 10 80    	cmp    %ebx,0x8010b564
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
801021e3:	68 80 b5 10 80       	push   $0x8010b580
801021e8:	53                   	push   %ebx
801021e9:	e8 e2 1d 00 00       	call   80103fd0 <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
801021ee:	8b 03                	mov    (%ebx),%eax
801021f0:	83 c4 10             	add    $0x10,%esp
801021f3:	83 e0 06             	and    $0x6,%eax
801021f6:	83 f8 02             	cmp    $0x2,%eax
801021f9:	75 e5                	jne    801021e0 <iderw+0x90>
  }


  release(&idelock);
801021fb:	c7 45 08 80 b5 10 80 	movl   $0x8010b580,0x8(%ebp)
}
80102202:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102205:	c9                   	leave  
  release(&idelock);
80102206:	e9 c5 28 00 00       	jmp    80104ad0 <release>
8010220b:	90                   	nop
8010220c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    idestart(b);
80102210:	89 d8                	mov    %ebx,%eax
80102212:	e8 39 fd ff ff       	call   80101f50 <idestart>
80102217:	eb b5                	jmp    801021ce <iderw+0x7e>
80102219:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102220:	ba 64 b5 10 80       	mov    $0x8010b564,%edx
80102225:	eb 9d                	jmp    801021c4 <iderw+0x74>
    panic("iderw: nothing to do");
80102227:	83 ec 0c             	sub    $0xc,%esp
8010222a:	68 c0 78 10 80       	push   $0x801078c0
8010222f:	e8 5c e1 ff ff       	call   80100390 <panic>
    panic("iderw: buf not locked");
80102234:	83 ec 0c             	sub    $0xc,%esp
80102237:	68 aa 78 10 80       	push   $0x801078aa
8010223c:	e8 4f e1 ff ff       	call   80100390 <panic>
    panic("iderw: ide disk 1 not present");
80102241:	83 ec 0c             	sub    $0xc,%esp
80102244:	68 d5 78 10 80       	push   $0x801078d5
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
80102251:	c7 05 34 36 11 80 00 	movl   $0xfec00000,0x80113634
80102258:	00 c0 fe 
{
8010225b:	89 e5                	mov    %esp,%ebp
8010225d:	56                   	push   %esi
8010225e:	53                   	push   %ebx
  ioapic->reg = reg;
8010225f:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
80102266:	00 00 00 
  return ioapic->data;
80102269:	a1 34 36 11 80       	mov    0x80113634,%eax
8010226e:	8b 58 10             	mov    0x10(%eax),%ebx
  ioapic->reg = reg;
80102271:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  return ioapic->data;
80102277:	8b 0d 34 36 11 80    	mov    0x80113634,%ecx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
8010227d:	0f b6 15 60 37 11 80 	movzbl 0x80113760,%edx
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
80102297:	68 f4 78 10 80       	push   $0x801078f4
8010229c:	e8 bf e3 ff ff       	call   80100660 <cprintf>
801022a1:	8b 0d 34 36 11 80    	mov    0x80113634,%ecx
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
801022c2:	8b 0d 34 36 11 80    	mov    0x80113634,%ecx

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
801022e0:	8b 0d 34 36 11 80    	mov    0x80113634,%ecx
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
80102301:	8b 0d 34 36 11 80    	mov    0x80113634,%ecx
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
80102315:	8b 0d 34 36 11 80    	mov    0x80113634,%ecx
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010231b:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
8010231e:	89 51 10             	mov    %edx,0x10(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80102321:	8b 55 0c             	mov    0xc(%ebp),%edx
  ioapic->reg = reg;
80102324:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80102326:	a1 34 36 11 80       	mov    0x80113634,%eax
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
80102352:	81 fb a8 ac 11 80    	cmp    $0x8011aca8,%ebx
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
80102372:	e8 a9 27 00 00       	call   80104b20 <memset>

  if(kmem.use_lock)
80102377:	8b 15 74 36 11 80    	mov    0x80113674,%edx
8010237d:	83 c4 10             	add    $0x10,%esp
80102380:	85 d2                	test   %edx,%edx
80102382:	75 2c                	jne    801023b0 <kfree+0x70>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
80102384:	a1 78 36 11 80       	mov    0x80113678,%eax
80102389:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
8010238b:	a1 74 36 11 80       	mov    0x80113674,%eax
  kmem.freelist = r;
80102390:	89 1d 78 36 11 80    	mov    %ebx,0x80113678
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
801023a0:	c7 45 08 40 36 11 80 	movl   $0x80113640,0x8(%ebp)
}
801023a7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801023aa:	c9                   	leave  
    release(&kmem.lock);
801023ab:	e9 20 27 00 00       	jmp    80104ad0 <release>
    acquire(&kmem.lock);
801023b0:	83 ec 0c             	sub    $0xc,%esp
801023b3:	68 40 36 11 80       	push   $0x80113640
801023b8:	e8 53 26 00 00       	call   80104a10 <acquire>
801023bd:	83 c4 10             	add    $0x10,%esp
801023c0:	eb c2                	jmp    80102384 <kfree+0x44>
    panic("kfree");
801023c2:	83 ec 0c             	sub    $0xc,%esp
801023c5:	68 26 79 10 80       	push   $0x80107926
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
8010242b:	68 2c 79 10 80       	push   $0x8010792c
80102430:	68 40 36 11 80       	push   $0x80113640
80102435:	e8 96 24 00 00       	call   801048d0 <initlock>
  p = (char*)PGROUNDUP((uint)vstart);
8010243a:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010243d:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
80102440:	c7 05 74 36 11 80 00 	movl   $0x0,0x80113674
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
801024d4:	c7 05 74 36 11 80 01 	movl   $0x1,0x80113674
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
801024f0:	a1 74 36 11 80       	mov    0x80113674,%eax
801024f5:	85 c0                	test   %eax,%eax
801024f7:	75 1f                	jne    80102518 <kalloc+0x28>
    acquire(&kmem.lock);
  r = kmem.freelist;
801024f9:	a1 78 36 11 80       	mov    0x80113678,%eax
  if(r)
801024fe:	85 c0                	test   %eax,%eax
80102500:	74 0e                	je     80102510 <kalloc+0x20>
    kmem.freelist = r->next;
80102502:	8b 10                	mov    (%eax),%edx
80102504:	89 15 78 36 11 80    	mov    %edx,0x80113678
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
8010251e:	68 40 36 11 80       	push   $0x80113640
80102523:	e8 e8 24 00 00       	call   80104a10 <acquire>
  r = kmem.freelist;
80102528:	a1 78 36 11 80       	mov    0x80113678,%eax
  if(r)
8010252d:	83 c4 10             	add    $0x10,%esp
80102530:	8b 15 74 36 11 80    	mov    0x80113674,%edx
80102536:	85 c0                	test   %eax,%eax
80102538:	74 08                	je     80102542 <kalloc+0x52>
    kmem.freelist = r->next;
8010253a:	8b 08                	mov    (%eax),%ecx
8010253c:	89 0d 78 36 11 80    	mov    %ecx,0x80113678
  if(kmem.use_lock)
80102542:	85 d2                	test   %edx,%edx
80102544:	74 16                	je     8010255c <kalloc+0x6c>
    release(&kmem.lock);
80102546:	83 ec 0c             	sub    $0xc,%esp
80102549:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010254c:	68 40 36 11 80       	push   $0x80113640
80102551:	e8 7a 25 00 00       	call   80104ad0 <release>
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
80102577:	8b 0d b4 b5 10 80    	mov    0x8010b5b4,%ecx

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
801025a3:	0f b6 82 60 7a 10 80 	movzbl -0x7fef85a0(%edx),%eax
801025aa:	09 c1                	or     %eax,%ecx
  shift ^= togglecode[data];
801025ac:	0f b6 82 60 79 10 80 	movzbl -0x7fef86a0(%edx),%eax
801025b3:	31 c1                	xor    %eax,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
801025b5:	89 c8                	mov    %ecx,%eax
  shift ^= togglecode[data];
801025b7:	89 0d b4 b5 10 80    	mov    %ecx,0x8010b5b4
  c = charcode[shift & (CTL | SHIFT)][data];
801025bd:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
801025c0:	83 e1 08             	and    $0x8,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
801025c3:	8b 04 85 40 79 10 80 	mov    -0x7fef86c0(,%eax,4),%eax
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
801025e8:	0f b6 82 60 7a 10 80 	movzbl -0x7fef85a0(%edx),%eax
801025ef:	83 c8 40             	or     $0x40,%eax
801025f2:	0f b6 c0             	movzbl %al,%eax
801025f5:	f7 d0                	not    %eax
801025f7:	21 c1                	and    %eax,%ecx
    return 0;
801025f9:	31 c0                	xor    %eax,%eax
    shift &= ~(shiftcode[data] | E0ESC);
801025fb:	89 0d b4 b5 10 80    	mov    %ecx,0x8010b5b4
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
8010260d:	89 0d b4 b5 10 80    	mov    %ecx,0x8010b5b4
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
80102660:	a1 7c 36 11 80       	mov    0x8011367c,%eax
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
80102760:	8b 15 7c 36 11 80    	mov    0x8011367c,%edx
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
80102780:	a1 7c 36 11 80       	mov    0x8011367c,%eax
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
801027ee:	a1 7c 36 11 80       	mov    0x8011367c,%eax
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
80102967:	e8 04 22 00 00       	call   80104b70 <memcmp>
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
80102a30:	8b 0d c8 36 11 80    	mov    0x801136c8,%ecx
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
80102a50:	a1 b4 36 11 80       	mov    0x801136b4,%eax
80102a55:	83 ec 08             	sub    $0x8,%esp
80102a58:	01 d8                	add    %ebx,%eax
80102a5a:	83 c0 01             	add    $0x1,%eax
80102a5d:	50                   	push   %eax
80102a5e:	ff 35 c4 36 11 80    	pushl  0x801136c4
80102a64:	e8 67 d6 ff ff       	call   801000d0 <bread>
80102a69:	89 c7                	mov    %eax,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102a6b:	58                   	pop    %eax
80102a6c:	5a                   	pop    %edx
80102a6d:	ff 34 9d cc 36 11 80 	pushl  -0x7feec934(,%ebx,4)
80102a74:	ff 35 c4 36 11 80    	pushl  0x801136c4
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
80102a94:	e8 37 21 00 00       	call   80104bd0 <memmove>
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
80102ab4:	39 1d c8 36 11 80    	cmp    %ebx,0x801136c8
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
80102ad8:	ff 35 b4 36 11 80    	pushl  0x801136b4
80102ade:	ff 35 c4 36 11 80    	pushl  0x801136c4
80102ae4:	e8 e7 d5 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80102ae9:	8b 1d c8 36 11 80    	mov    0x801136c8,%ebx
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
80102b00:	8b 8a cc 36 11 80    	mov    -0x7feec934(%edx),%ecx
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
80102b3a:	68 60 7b 10 80       	push   $0x80107b60
80102b3f:	68 80 36 11 80       	push   $0x80113680
80102b44:	e8 87 1d 00 00       	call   801048d0 <initlock>
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
80102b5c:	89 1d c4 36 11 80    	mov    %ebx,0x801136c4
  log.size = sb.nlog;
80102b62:	89 15 b8 36 11 80    	mov    %edx,0x801136b8
  log.start = sb.logstart;
80102b68:	a3 b4 36 11 80       	mov    %eax,0x801136b4
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
80102b7d:	89 1d c8 36 11 80    	mov    %ebx,0x801136c8
  for (i = 0; i < log.lh.n; i++) {
80102b83:	7e 1c                	jle    80102ba1 <initlog+0x71>
80102b85:	c1 e3 02             	shl    $0x2,%ebx
80102b88:	31 d2                	xor    %edx,%edx
80102b8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    log.lh.block[i] = lh->block[i];
80102b90:	8b 4c 10 60          	mov    0x60(%eax,%edx,1),%ecx
80102b94:	83 c2 04             	add    $0x4,%edx
80102b97:	89 8a c8 36 11 80    	mov    %ecx,-0x7feec938(%edx)
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
80102baf:	c7 05 c8 36 11 80 00 	movl   $0x0,0x801136c8
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
80102bd6:	68 80 36 11 80       	push   $0x80113680
80102bdb:	e8 30 1e 00 00       	call   80104a10 <acquire>
80102be0:	83 c4 10             	add    $0x10,%esp
80102be3:	eb 18                	jmp    80102bfd <begin_op+0x2d>
80102be5:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102be8:	83 ec 08             	sub    $0x8,%esp
80102beb:	68 80 36 11 80       	push   $0x80113680
80102bf0:	68 80 36 11 80       	push   $0x80113680
80102bf5:	e8 d6 13 00 00       	call   80103fd0 <sleep>
80102bfa:	83 c4 10             	add    $0x10,%esp
    if(log.committing){
80102bfd:	a1 c0 36 11 80       	mov    0x801136c0,%eax
80102c02:	85 c0                	test   %eax,%eax
80102c04:	75 e2                	jne    80102be8 <begin_op+0x18>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80102c06:	a1 bc 36 11 80       	mov    0x801136bc,%eax
80102c0b:	8b 15 c8 36 11 80    	mov    0x801136c8,%edx
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
80102c22:	a3 bc 36 11 80       	mov    %eax,0x801136bc
      release(&log.lock);
80102c27:	68 80 36 11 80       	push   $0x80113680
80102c2c:	e8 9f 1e 00 00       	call   80104ad0 <release>
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
80102c49:	68 80 36 11 80       	push   $0x80113680
80102c4e:	e8 bd 1d 00 00       	call   80104a10 <acquire>
  log.outstanding -= 1;
80102c53:	a1 bc 36 11 80       	mov    0x801136bc,%eax
  if(log.committing)
80102c58:	8b 35 c0 36 11 80    	mov    0x801136c0,%esi
80102c5e:	83 c4 10             	add    $0x10,%esp
  log.outstanding -= 1;
80102c61:	8d 58 ff             	lea    -0x1(%eax),%ebx
  if(log.committing)
80102c64:	85 f6                	test   %esi,%esi
  log.outstanding -= 1;
80102c66:	89 1d bc 36 11 80    	mov    %ebx,0x801136bc
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
80102c7d:	c7 05 c0 36 11 80 01 	movl   $0x1,0x801136c0
80102c84:	00 00 00 
  release(&log.lock);
80102c87:	68 80 36 11 80       	push   $0x80113680
80102c8c:	e8 3f 1e 00 00       	call   80104ad0 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80102c91:	8b 0d c8 36 11 80    	mov    0x801136c8,%ecx
80102c97:	83 c4 10             	add    $0x10,%esp
80102c9a:	85 c9                	test   %ecx,%ecx
80102c9c:	0f 8e 85 00 00 00    	jle    80102d27 <end_op+0xe7>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80102ca2:	a1 b4 36 11 80       	mov    0x801136b4,%eax
80102ca7:	83 ec 08             	sub    $0x8,%esp
80102caa:	01 d8                	add    %ebx,%eax
80102cac:	83 c0 01             	add    $0x1,%eax
80102caf:	50                   	push   %eax
80102cb0:	ff 35 c4 36 11 80    	pushl  0x801136c4
80102cb6:	e8 15 d4 ff ff       	call   801000d0 <bread>
80102cbb:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102cbd:	58                   	pop    %eax
80102cbe:	5a                   	pop    %edx
80102cbf:	ff 34 9d cc 36 11 80 	pushl  -0x7feec934(,%ebx,4)
80102cc6:	ff 35 c4 36 11 80    	pushl  0x801136c4
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
80102ce6:	e8 e5 1e 00 00       	call   80104bd0 <memmove>
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
80102d06:	3b 1d c8 36 11 80    	cmp    0x801136c8,%ebx
80102d0c:	7c 94                	jl     80102ca2 <end_op+0x62>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
80102d0e:	e8 bd fd ff ff       	call   80102ad0 <write_head>
    install_trans(); // Now install writes to home locations
80102d13:	e8 18 fd ff ff       	call   80102a30 <install_trans>
    log.lh.n = 0;
80102d18:	c7 05 c8 36 11 80 00 	movl   $0x0,0x801136c8
80102d1f:	00 00 00 
    write_head();    // Erase the transaction from the log
80102d22:	e8 a9 fd ff ff       	call   80102ad0 <write_head>
    acquire(&log.lock);
80102d27:	83 ec 0c             	sub    $0xc,%esp
80102d2a:	68 80 36 11 80       	push   $0x80113680
80102d2f:	e8 dc 1c 00 00       	call   80104a10 <acquire>
    wakeup(&log);
80102d34:	c7 04 24 80 36 11 80 	movl   $0x80113680,(%esp)
    log.committing = 0;
80102d3b:	c7 05 c0 36 11 80 00 	movl   $0x0,0x801136c0
80102d42:	00 00 00 
    wakeup(&log);
80102d45:	e8 86 14 00 00       	call   801041d0 <wakeup>
    release(&log.lock);
80102d4a:	c7 04 24 80 36 11 80 	movl   $0x80113680,(%esp)
80102d51:	e8 7a 1d 00 00       	call   80104ad0 <release>
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
80102d6b:	68 80 36 11 80       	push   $0x80113680
80102d70:	e8 5b 14 00 00       	call   801041d0 <wakeup>
  release(&log.lock);
80102d75:	c7 04 24 80 36 11 80 	movl   $0x80113680,(%esp)
80102d7c:	e8 4f 1d 00 00       	call   80104ad0 <release>
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
80102d8f:	68 64 7b 10 80       	push   $0x80107b64
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
80102da7:	8b 15 c8 36 11 80    	mov    0x801136c8,%edx
{
80102dad:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102db0:	83 fa 1d             	cmp    $0x1d,%edx
80102db3:	0f 8f 9d 00 00 00    	jg     80102e56 <log_write+0xb6>
80102db9:	a1 b8 36 11 80       	mov    0x801136b8,%eax
80102dbe:	83 e8 01             	sub    $0x1,%eax
80102dc1:	39 c2                	cmp    %eax,%edx
80102dc3:	0f 8d 8d 00 00 00    	jge    80102e56 <log_write+0xb6>
    panic("too big a transaction");
  if (log.outstanding < 1)
80102dc9:	a1 bc 36 11 80       	mov    0x801136bc,%eax
80102dce:	85 c0                	test   %eax,%eax
80102dd0:	0f 8e 8d 00 00 00    	jle    80102e63 <log_write+0xc3>
    panic("log_write outside of trans");

  acquire(&log.lock);
80102dd6:	83 ec 0c             	sub    $0xc,%esp
80102dd9:	68 80 36 11 80       	push   $0x80113680
80102dde:	e8 2d 1c 00 00       	call   80104a10 <acquire>
  for (i = 0; i < log.lh.n; i++) {
80102de3:	8b 0d c8 36 11 80    	mov    0x801136c8,%ecx
80102de9:	83 c4 10             	add    $0x10,%esp
80102dec:	83 f9 00             	cmp    $0x0,%ecx
80102def:	7e 57                	jle    80102e48 <log_write+0xa8>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102df1:	8b 53 08             	mov    0x8(%ebx),%edx
  for (i = 0; i < log.lh.n; i++) {
80102df4:	31 c0                	xor    %eax,%eax
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102df6:	3b 15 cc 36 11 80    	cmp    0x801136cc,%edx
80102dfc:	75 0b                	jne    80102e09 <log_write+0x69>
80102dfe:	eb 38                	jmp    80102e38 <log_write+0x98>
80102e00:	39 14 85 cc 36 11 80 	cmp    %edx,-0x7feec934(,%eax,4)
80102e07:	74 2f                	je     80102e38 <log_write+0x98>
  for (i = 0; i < log.lh.n; i++) {
80102e09:	83 c0 01             	add    $0x1,%eax
80102e0c:	39 c1                	cmp    %eax,%ecx
80102e0e:	75 f0                	jne    80102e00 <log_write+0x60>
      break;
  }
  log.lh.block[i] = b->blockno;
80102e10:	89 14 85 cc 36 11 80 	mov    %edx,-0x7feec934(,%eax,4)
  if (i == log.lh.n)
    log.lh.n++;
80102e17:	83 c0 01             	add    $0x1,%eax
80102e1a:	a3 c8 36 11 80       	mov    %eax,0x801136c8
  b->flags |= B_DIRTY; // prevent eviction
80102e1f:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
80102e22:	c7 45 08 80 36 11 80 	movl   $0x80113680,0x8(%ebp)
}
80102e29:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102e2c:	c9                   	leave  
  release(&log.lock);
80102e2d:	e9 9e 1c 00 00       	jmp    80104ad0 <release>
80102e32:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  log.lh.block[i] = b->blockno;
80102e38:	89 14 85 cc 36 11 80 	mov    %edx,-0x7feec934(,%eax,4)
80102e3f:	eb de                	jmp    80102e1f <log_write+0x7f>
80102e41:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102e48:	8b 43 08             	mov    0x8(%ebx),%eax
80102e4b:	a3 cc 36 11 80       	mov    %eax,0x801136cc
  if (i == log.lh.n)
80102e50:	75 cd                	jne    80102e1f <log_write+0x7f>
80102e52:	31 c0                	xor    %eax,%eax
80102e54:	eb c1                	jmp    80102e17 <log_write+0x77>
    panic("too big a transaction");
80102e56:	83 ec 0c             	sub    $0xc,%esp
80102e59:	68 73 7b 10 80       	push   $0x80107b73
80102e5e:	e8 2d d5 ff ff       	call   80100390 <panic>
    panic("log_write outside of trans");
80102e63:	83 ec 0c             	sub    $0xc,%esp
80102e66:	68 89 7b 10 80       	push   $0x80107b89
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
80102e77:	e8 b4 09 00 00       	call   80103830 <cpuid>
80102e7c:	89 c3                	mov    %eax,%ebx
80102e7e:	e8 ad 09 00 00       	call   80103830 <cpuid>
80102e83:	83 ec 04             	sub    $0x4,%esp
80102e86:	53                   	push   %ebx
80102e87:	50                   	push   %eax
80102e88:	68 a4 7b 10 80       	push   $0x80107ba4
80102e8d:	e8 ce d7 ff ff       	call   80100660 <cprintf>
  idtinit();       // load idt register
80102e92:	e8 f9 2f 00 00       	call   80105e90 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
80102e97:	e8 14 09 00 00       	call   801037b0 <mycpu>
80102e9c:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80102e9e:	b8 01 00 00 00       	mov    $0x1,%eax
80102ea3:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
80102eaa:	e8 21 0e 00 00       	call   80103cd0 <scheduler>
80102eaf:	90                   	nop

80102eb0 <mpenter>:
{
80102eb0:	55                   	push   %ebp
80102eb1:	89 e5                	mov    %esp,%ebp
80102eb3:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80102eb6:	e8 15 41 00 00       	call   80106fd0 <switchkvm>
  seginit();
80102ebb:	e8 80 40 00 00       	call   80106f40 <seginit>
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
80102ee7:	68 a8 ac 11 80       	push   $0x8011aca8
80102eec:	e8 2f f5 ff ff       	call   80102420 <kinit1>
  kvmalloc();      // kernel page table
80102ef1:	e8 aa 45 00 00       	call   801074a0 <kvmalloc>
  mpinit();        // detect other processors
80102ef6:	e8 75 01 00 00       	call   80103070 <mpinit>
  lapicinit();     // interrupt controller
80102efb:	e8 60 f7 ff ff       	call   80102660 <lapicinit>
  seginit();       // segment descriptors
80102f00:	e8 3b 40 00 00       	call   80106f40 <seginit>
  picinit();       // disable pic
80102f05:	e8 46 03 00 00       	call   80103250 <picinit>
  ioapicinit();    // another interrupt controller
80102f0a:	e8 41 f3 ff ff       	call   80102250 <ioapicinit>
  consoleinit();   // console hardware
80102f0f:	e8 ac da ff ff       	call   801009c0 <consoleinit>
  uartinit();      // serial port
80102f14:	e8 f7 32 00 00       	call   80106210 <uartinit>
  pinit();         // process table
80102f19:	e8 82 08 00 00       	call   801037a0 <pinit>
  tvinit();        // trap vectors
80102f1e:	e8 ed 2e 00 00       	call   80105e10 <tvinit>
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
80102f3a:	68 8c b4 10 80       	push   $0x8010b48c
80102f3f:	68 00 70 00 80       	push   $0x80007000
80102f44:	e8 87 1c 00 00       	call   80104bd0 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
80102f49:	69 05 00 3d 11 80 b0 	imul   $0xb0,0x80113d00,%eax
80102f50:	00 00 00 
80102f53:	83 c4 10             	add    $0x10,%esp
80102f56:	05 80 37 11 80       	add    $0x80113780,%eax
80102f5b:	3d 80 37 11 80       	cmp    $0x80113780,%eax
80102f60:	76 71                	jbe    80102fd3 <main+0x103>
80102f62:	bb 80 37 11 80       	mov    $0x80113780,%ebx
80102f67:	89 f6                	mov    %esi,%esi
80102f69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(c == mycpu())  // We've started already.
80102f70:	e8 3b 08 00 00       	call   801037b0 <mycpu>
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
80102f8d:	c7 05 f4 6f 00 80 00 	movl   $0x10a000,0x80006ff4
80102f94:	a0 10 00 
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
80102fba:	69 05 00 3d 11 80 b0 	imul   $0xb0,0x80113d00,%eax
80102fc1:	00 00 00 
80102fc4:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
80102fca:	05 80 37 11 80       	add    $0x80113780,%eax
80102fcf:	39 c3                	cmp    %eax,%ebx
80102fd1:	72 9d                	jb     80102f70 <main+0xa0>
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80102fd3:	83 ec 08             	sub    $0x8,%esp
80102fd6:	68 00 00 00 8e       	push   $0x8e000000
80102fdb:	68 00 00 40 80       	push   $0x80400000
80102fe0:	e8 ab f4 ff ff       	call   80102490 <kinit2>
  userinit();      // first user process
80102fe5:	e8 06 0a 00 00       	call   801039f0 <userinit>
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
8010301e:	68 b8 7b 10 80       	push   $0x80107bb8
80103023:	56                   	push   %esi
80103024:	e8 47 1b 00 00       	call   80104b70 <memcmp>
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
801030dc:	68 d5 7b 10 80       	push   $0x80107bd5
801030e1:	56                   	push   %esi
801030e2:	e8 89 1a 00 00       	call   80104b70 <memcmp>
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
80103147:	a3 7c 36 11 80       	mov    %eax,0x8011367c
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
80103170:	ff 24 95 fc 7b 10 80 	jmp    *-0x7fef8404(,%edx,4)
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
801031b8:	8b 0d 00 3d 11 80    	mov    0x80113d00,%ecx
801031be:	83 f9 07             	cmp    $0x7,%ecx
801031c1:	7f 19                	jg     801031dc <mpinit+0x16c>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
801031c3:	0f b6 50 01          	movzbl 0x1(%eax),%edx
801031c7:	69 f9 b0 00 00 00    	imul   $0xb0,%ecx,%edi
        ncpu++;
801031cd:	83 c1 01             	add    $0x1,%ecx
801031d0:	89 0d 00 3d 11 80    	mov    %ecx,0x80113d00
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
801031d6:	88 97 80 37 11 80    	mov    %dl,-0x7feec880(%edi)
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
801031ef:	88 15 60 37 11 80    	mov    %dl,0x80113760
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
80103223:	68 bd 7b 10 80       	push   $0x80107bbd
80103228:	e8 63 d1 ff ff       	call   80100390 <panic>
    panic("Didn't find a suitable machine");
8010322d:	83 ec 0c             	sub    $0xc,%esp
80103230:	68 dc 7b 10 80       	push   $0x80107bdc
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
8010332b:	68 10 7c 10 80       	push   $0x80107c10
80103330:	50                   	push   %eax
80103331:	e8 9a 15 00 00       	call   801048d0 <initlock>
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
8010338f:	e8 7c 16 00 00       	call   80104a10 <acquire>
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
801033af:	e8 1c 0e 00 00       	call   801041d0 <wakeup>
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
801033d4:	e9 f7 16 00 00       	jmp    80104ad0 <release>
801033d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    wakeup(&p->nwrite);
801033e0:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
801033e6:	83 ec 0c             	sub    $0xc,%esp
    p->readopen = 0;
801033e9:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
801033f0:	00 00 00 
    wakeup(&p->nwrite);
801033f3:	50                   	push   %eax
801033f4:	e8 d7 0d 00 00       	call   801041d0 <wakeup>
801033f9:	83 c4 10             	add    $0x10,%esp
801033fc:	eb b9                	jmp    801033b7 <pipeclose+0x37>
801033fe:	66 90                	xchg   %ax,%ax
    release(&p->lock);
80103400:	83 ec 0c             	sub    $0xc,%esp
80103403:	53                   	push   %ebx
80103404:	e8 c7 16 00 00       	call   80104ad0 <release>
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
8010342d:	e8 de 15 00 00       	call   80104a10 <acquire>
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
80103484:	e8 47 0d 00 00       	call   801041d0 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103489:	5a                   	pop    %edx
8010348a:	59                   	pop    %ecx
8010348b:	53                   	push   %ebx
8010348c:	56                   	push   %esi
8010348d:	e8 3e 0b 00 00       	call   80103fd0 <sleep>
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
801034b4:	e8 97 03 00 00       	call   80103850 <myproc>
801034b9:	8b 40 24             	mov    0x24(%eax),%eax
801034bc:	85 c0                	test   %eax,%eax
801034be:	74 c0                	je     80103480 <pipewrite+0x60>
        release(&p->lock);
801034c0:	83 ec 0c             	sub    $0xc,%esp
801034c3:	53                   	push   %ebx
801034c4:	e8 07 16 00 00       	call   80104ad0 <release>
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
80103513:	e8 b8 0c 00 00       	call   801041d0 <wakeup>
  release(&p->lock);
80103518:	89 1c 24             	mov    %ebx,(%esp)
8010351b:	e8 b0 15 00 00       	call   80104ad0 <release>
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
80103540:	e8 cb 14 00 00       	call   80104a10 <acquire>
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
80103575:	e8 56 0a 00 00       	call   80103fd0 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
8010357a:	83 c4 10             	add    $0x10,%esp
8010357d:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
80103583:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
80103589:	75 35                	jne    801035c0 <piperead+0x90>
8010358b:	8b 96 40 02 00 00    	mov    0x240(%esi),%edx
80103591:	85 d2                	test   %edx,%edx
80103593:	0f 84 8f 00 00 00    	je     80103628 <piperead+0xf8>
    if(myproc()->killed){
80103599:	e8 b2 02 00 00       	call   80103850 <myproc>
8010359e:	8b 48 24             	mov    0x24(%eax),%ecx
801035a1:	85 c9                	test   %ecx,%ecx
801035a3:	74 cb                	je     80103570 <piperead+0x40>
      release(&p->lock);
801035a5:	83 ec 0c             	sub    $0xc,%esp
      return -1;
801035a8:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      release(&p->lock);
801035ad:	56                   	push   %esi
801035ae:	e8 1d 15 00 00       	call   80104ad0 <release>
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
80103607:	e8 c4 0b 00 00       	call   801041d0 <wakeup>
  release(&p->lock);
8010360c:	89 34 24             	mov    %esi,(%esp)
8010360f:	e8 bc 14 00 00       	call   80104ad0 <release>
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
80103631:	ba 54 3d 11 80       	mov    $0x80113d54,%edx
{
80103636:	89 e5                	mov    %esp,%ebp
80103638:	57                   	push   %edi

static inline int cas (volatile void * addr, int expected, int newval)
{
  
  int ret;
  asm volatile("movl %2 , %%eax\n\t"
80103639:	bf fe ff ff ff       	mov    $0xfffffffe,%edi
8010363e:	56                   	push   %esi
8010363f:	89 c6                	mov    %eax,%esi
80103641:	53                   	push   %ebx
80103642:	eb 17                	jmp    8010365b <wakeup1+0x2b>
80103644:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if((p->state == SLEEPING || p->state == -SLEEPING) && p->chan == chan){
80103648:	83 f8 fe             	cmp    $0xfffffffe,%eax
8010364b:	74 16                	je     80103663 <wakeup1+0x33>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010364d:	81 c2 9c 01 00 00    	add    $0x19c,%edx
80103653:	81 fa 54 a4 11 80    	cmp    $0x8011a454,%edx
80103659:	73 42                	jae    8010369d <wakeup1+0x6d>
    if((p->state == SLEEPING || p->state == -SLEEPING) && p->chan == chan){
8010365b:	8b 42 0c             	mov    0xc(%edx),%eax
8010365e:	83 f8 02             	cmp    $0x2,%eax
80103661:	75 e5                	jne    80103648 <wakeup1+0x18>
80103663:	39 72 20             	cmp    %esi,0x20(%edx)
80103666:	75 e5                	jne    8010364d <wakeup1+0x1d>
80103668:	bb fd ff ff ff       	mov    $0xfffffffd,%ebx
8010366d:	89 f8                	mov    %edi,%eax
8010366f:	f0 0f b1 5a 0c       	lock cmpxchg %ebx,0xc(%edx)
80103674:	9c                   	pushf  
80103675:	59                   	pop    %ecx
80103676:	83 e1 40             	and    $0x40,%ecx
80103679:	b9 02 00 00 00       	mov    $0x2,%ecx
8010367e:	bb 03 00 00 00       	mov    $0x3,%ebx
80103683:	89 c8                	mov    %ecx,%eax
80103685:	f0 0f b1 5a 0c       	lock cmpxchg %ebx,0xc(%edx)
8010368a:	9c                   	pushf  
8010368b:	59                   	pop    %ecx
8010368c:	83 e1 40             	and    $0x40,%ecx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010368f:	81 c2 9c 01 00 00    	add    $0x19c,%edx
80103695:	81 fa 54 a4 11 80    	cmp    $0x8011a454,%edx
8010369b:	72 be                	jb     8010365b <wakeup1+0x2b>
      cas(&p->state, -SLEEPING, -RUNNABLE);
      cas(&p->state, SLEEPING, RUNNABLE);
    }
  }
}
8010369d:	5b                   	pop    %ebx
8010369e:	5e                   	pop    %esi
8010369f:	5f                   	pop    %edi
801036a0:	5d                   	pop    %ebp
801036a1:	c3                   	ret    
801036a2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801036a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

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

801036c0 <user_handlers>:


void user_handlers(int i, struct proc * p){
801036c0:	55                   	push   %ebp
    int functionSize = ((int)user_handlers - (int)call_sigret); 
    //backup trapframe 
    *p->backup = *p->tf;
801036c1:	b9 13 00 00 00       	mov    $0x13,%ecx
    int functionSize = ((int)user_handlers - (int)call_sigret); 
801036c6:	b8 c0 36 10 80       	mov    $0x801036c0,%eax
801036cb:	2d b0 36 10 80       	sub    $0x801036b0,%eax
void user_handlers(int i, struct proc * p){
801036d0:	89 e5                	mov    %esp,%ebp
801036d2:	57                   	push   %edi
801036d3:	56                   	push   %esi
801036d4:	53                   	push   %ebx
801036d5:	83 ec 20             	sub    $0x20,%esp
801036d8:	8b 5d 0c             	mov    0xc(%ebp),%ebx
801036db:	8b 55 08             	mov    0x8(%ebp),%edx
    *p->backup = *p->tf;
801036de:	8b 73 18             	mov    0x18(%ebx),%esi
801036e1:	8b 7b 7c             	mov    0x7c(%ebx),%edi
801036e4:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
void user_handlers(int i, struct proc * p){
801036e6:	89 55 e4             	mov    %edx,-0x1c(%ebp)

    //put functionn
    p->tf->esp -= functionSize;
801036e9:	8b 4b 18             	mov    0x18(%ebx),%ecx
801036ec:	29 41 44             	sub    %eax,0x44(%ecx)
    memmove((int*)p->tf->esp, &call_sigret, functionSize);
801036ef:	50                   	push   %eax
801036f0:	68 b0 36 10 80       	push   $0x801036b0
801036f5:	8b 43 18             	mov    0x18(%ebx),%eax
801036f8:	ff 70 44             	pushl  0x44(%eax)
801036fb:	e8 d0 14 00 00       	call   80104bd0 <memmove>
    uint returnAdress = p->tf->esp;
80103700:	8b 4b 18             	mov    0x18(%ebx),%ecx

    // push argumants
    p->tf->esp -= sizeof i;
    *(int*)p->tf->esp = i;
80103703:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    //push return address
    p->tf->esp -= sizeof(int);
    *(int*)p->tf->esp = returnAdress; //adrees to the function that calls sigret 
    struct sigaction handler = p->signal_handlers[i]; 
    p->tf->eip = (uint)handler.sa_handler; 
    trapret_handler(p->tf);
80103706:	83 c4 10             	add    $0x10,%esp
    uint returnAdress = p->tf->esp;
80103709:	8b 41 44             	mov    0x44(%ecx),%eax
    p->tf->esp -= sizeof i;
8010370c:	8d 70 fc             	lea    -0x4(%eax),%esi
8010370f:	89 71 44             	mov    %esi,0x44(%ecx)
    *(int*)p->tf->esp = i;
80103712:	8b 4b 18             	mov    0x18(%ebx),%ecx
80103715:	8b 49 44             	mov    0x44(%ecx),%ecx
80103718:	89 11                	mov    %edx,(%ecx)
    p->tf->esp -= sizeof(int);
8010371a:	8b 4b 18             	mov    0x18(%ebx),%ecx
8010371d:	83 69 44 04          	subl   $0x4,0x44(%ecx)
    *(int*)p->tf->esp = returnAdress; //adrees to the function that calls sigret 
80103721:	8b 4b 18             	mov    0x18(%ebx),%ecx
80103724:	8b 49 44             	mov    0x44(%ecx),%ecx
80103727:	89 01                	mov    %eax,(%ecx)
    p->tf->eip = (uint)handler.sa_handler; 
80103729:	8b 43 18             	mov    0x18(%ebx),%eax
8010372c:	8b 94 d3 8c 00 00 00 	mov    0x8c(%ebx,%edx,8),%edx
80103733:	89 50 38             	mov    %edx,0x38(%eax)
    trapret_handler(p->tf);
80103736:	8b 43 18             	mov    0x18(%ebx),%eax
80103739:	89 45 08             	mov    %eax,0x8(%ebp)

}
8010373c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010373f:	5b                   	pop    %ebx
80103740:	5e                   	pop    %esi
80103741:	5f                   	pop    %edi
80103742:	5d                   	pop    %ebp
    trapret_handler(p->tf);
80103743:	e9 af 26 00 00       	jmp    80105df7 <trapret_handler>
80103748:	90                   	nop
80103749:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103750 <forkret>:
{
80103750:	55                   	push   %ebp
80103751:	89 e5                	mov    %esp,%ebp
80103753:	83 ec 08             	sub    $0x8,%esp
  popcli();
80103756:	e8 25 12 00 00       	call   80104980 <popcli>
  if (first) {
8010375b:	a1 00 b0 10 80       	mov    0x8010b000,%eax
80103760:	85 c0                	test   %eax,%eax
80103762:	75 0c                	jne    80103770 <forkret+0x20>
}
80103764:	c9                   	leave  
80103765:	c3                   	ret    
80103766:	8d 76 00             	lea    0x0(%esi),%esi
80103769:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    iinit(ROOTDEV);
80103770:	83 ec 0c             	sub    $0xc,%esp
    first = 0;
80103773:	c7 05 00 b0 10 80 00 	movl   $0x0,0x8010b000
8010377a:	00 00 00 
    iinit(ROOTDEV);
8010377d:	6a 01                	push   $0x1
8010377f:	e8 2c dd ff ff       	call   801014b0 <iinit>
    initlog(ROOTDEV);
80103784:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010378b:	e8 a0 f3 ff ff       	call   80102b30 <initlog>
80103790:	83 c4 10             	add    $0x10,%esp
}
80103793:	c9                   	leave  
80103794:	c3                   	ret    
80103795:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103799:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801037a0 <pinit>:
{
801037a0:	55                   	push   %ebp
801037a1:	89 e5                	mov    %esp,%ebp
}
801037a3:	5d                   	pop    %ebp
801037a4:	c3                   	ret    
801037a5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801037a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801037b0 <mycpu>:
{
801037b0:	55                   	push   %ebp
801037b1:	89 e5                	mov    %esp,%ebp
801037b3:	56                   	push   %esi
801037b4:	53                   	push   %ebx
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801037b5:	9c                   	pushf  
801037b6:	58                   	pop    %eax
  if(readeflags()&FL_IF)
801037b7:	f6 c4 02             	test   $0x2,%ah
801037ba:	75 5e                	jne    8010381a <mycpu+0x6a>
  apicid = lapicid();
801037bc:	e8 9f ef ff ff       	call   80102760 <lapicid>
  for (i = 0; i < ncpu; ++i) {
801037c1:	8b 35 00 3d 11 80    	mov    0x80113d00,%esi
801037c7:	85 f6                	test   %esi,%esi
801037c9:	7e 42                	jle    8010380d <mycpu+0x5d>
    if (cpus[i].apicid == apicid)
801037cb:	0f b6 15 80 37 11 80 	movzbl 0x80113780,%edx
801037d2:	39 d0                	cmp    %edx,%eax
801037d4:	74 30                	je     80103806 <mycpu+0x56>
801037d6:	b9 30 38 11 80       	mov    $0x80113830,%ecx
  for (i = 0; i < ncpu; ++i) {
801037db:	31 d2                	xor    %edx,%edx
801037dd:	8d 76 00             	lea    0x0(%esi),%esi
801037e0:	83 c2 01             	add    $0x1,%edx
801037e3:	39 f2                	cmp    %esi,%edx
801037e5:	74 26                	je     8010380d <mycpu+0x5d>
    if (cpus[i].apicid == apicid)
801037e7:	0f b6 19             	movzbl (%ecx),%ebx
801037ea:	81 c1 b0 00 00 00    	add    $0xb0,%ecx
801037f0:	39 c3                	cmp    %eax,%ebx
801037f2:	75 ec                	jne    801037e0 <mycpu+0x30>
801037f4:	69 c2 b0 00 00 00    	imul   $0xb0,%edx,%eax
801037fa:	05 80 37 11 80       	add    $0x80113780,%eax
}
801037ff:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103802:	5b                   	pop    %ebx
80103803:	5e                   	pop    %esi
80103804:	5d                   	pop    %ebp
80103805:	c3                   	ret    
    if (cpus[i].apicid == apicid)
80103806:	b8 80 37 11 80       	mov    $0x80113780,%eax
      return &cpus[i];
8010380b:	eb f2                	jmp    801037ff <mycpu+0x4f>
  panic("unknown apicid\n");
8010380d:	83 ec 0c             	sub    $0xc,%esp
80103810:	68 3e 7c 10 80       	push   $0x80107c3e
80103815:	e8 76 cb ff ff       	call   80100390 <panic>
    panic("mycpu called with interrupts enabled\n");
8010381a:	83 ec 0c             	sub    $0xc,%esp
8010381d:	68 18 7c 10 80       	push   $0x80107c18
80103822:	e8 69 cb ff ff       	call   80100390 <panic>
80103827:	89 f6                	mov    %esi,%esi
80103829:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103830 <cpuid>:
cpuid() {
80103830:	55                   	push   %ebp
80103831:	89 e5                	mov    %esp,%ebp
80103833:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
80103836:	e8 75 ff ff ff       	call   801037b0 <mycpu>
8010383b:	2d 80 37 11 80       	sub    $0x80113780,%eax
}
80103840:	c9                   	leave  
  return mycpu()-cpus;
80103841:	c1 f8 04             	sar    $0x4,%eax
80103844:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
8010384a:	c3                   	ret    
8010384b:	90                   	nop
8010384c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103850 <myproc>:
myproc(void) {
80103850:	55                   	push   %ebp
80103851:	89 e5                	mov    %esp,%ebp
80103853:	53                   	push   %ebx
80103854:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80103857:	e8 e4 10 00 00       	call   80104940 <pushcli>
  c = mycpu();
8010385c:	e8 4f ff ff ff       	call   801037b0 <mycpu>
  p = c->proc;
80103861:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103867:	e8 14 11 00 00       	call   80104980 <popcli>
}
8010386c:	83 c4 04             	add    $0x4,%esp
8010386f:	89 d8                	mov    %ebx,%eax
80103871:	5b                   	pop    %ebx
80103872:	5d                   	pop    %ebp
80103873:	c3                   	ret    
80103874:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010387a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103880 <allocpid>:
{
80103880:	55                   	push   %ebp
80103881:	89 e5                	mov    %esp,%ebp
80103883:	53                   	push   %ebx
80103884:	83 ec 04             	sub    $0x4,%esp
   pushcli(); //add now
80103887:	e8 b4 10 00 00       	call   80104940 <pushcli>
8010388c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    pid = nextpid;
80103890:	8b 15 04 b0 10 80    	mov    0x8010b004,%edx
  }while (!cas(&nextpid , pid, pid+1));
80103896:	8d 5a 01             	lea    0x1(%edx),%ebx
  asm volatile("movl %2 , %%eax\n\t"
80103899:	89 d0                	mov    %edx,%eax
8010389b:	f0 0f b1 1d 04 b0 10 	lock cmpxchg %ebx,0x8010b004
801038a2:	80 
801038a3:	9c                   	pushf  
801038a4:	5a                   	pop    %edx
801038a5:	83 e2 40             	and    $0x40,%edx
              "and $0x0040, %1\n\t"
              : "+m" (*(int *)addr), "=r" (ret)
              : "r" (expected), "r" (newval)
              : "%eax"
              );
  return ret>>6;
801038a8:	c1 fa 06             	sar    $0x6,%edx
801038ab:	85 d2                	test   %edx,%edx
801038ad:	74 e1                	je     80103890 <allocpid+0x10>
  popcli(); 
801038af:	e8 cc 10 00 00       	call   80104980 <popcli>
}
801038b4:	83 c4 04             	add    $0x4,%esp
801038b7:	89 d8                	mov    %ebx,%eax
801038b9:	5b                   	pop    %ebx
801038ba:	5d                   	pop    %ebp
801038bb:	c3                   	ret    
801038bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801038c0 <allocproc>:
{
801038c0:	55                   	push   %ebp
801038c1:	89 e5                	mov    %esp,%ebp
801038c3:	56                   	push   %esi
801038c4:	53                   	push   %ebx
  asm volatile("movl %2 , %%eax\n\t"
801038c5:	31 f6                	xor    %esi,%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801038c7:	bb 54 3d 11 80       	mov    $0x80113d54,%ebx
  pushcli();
801038cc:	e8 6f 10 00 00       	call   80104940 <pushcli>
801038d1:	b9 01 00 00 00       	mov    $0x1,%ecx
801038d6:	eb 1a                	jmp    801038f2 <allocproc+0x32>
801038d8:	90                   	nop
801038d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801038e0:	81 c3 9c 01 00 00    	add    $0x19c,%ebx
801038e6:	81 fb 54 a4 11 80    	cmp    $0x8011a454,%ebx
801038ec:	0f 83 e1 00 00 00    	jae    801039d3 <allocproc+0x113>
801038f2:	89 f0                	mov    %esi,%eax
801038f4:	f0 0f b1 4b 0c       	lock cmpxchg %ecx,0xc(%ebx)
801038f9:	9c                   	pushf  
801038fa:	5a                   	pop    %edx
801038fb:	83 e2 40             	and    $0x40,%edx
  return ret>>6;
801038fe:	c1 fa 06             	sar    $0x6,%edx
    if(cas(&p->state, UNUSED, EMBRYO))
80103901:	85 d2                	test   %edx,%edx
80103903:	74 db                	je     801038e0 <allocproc+0x20>
  popcli();
80103905:	e8 76 10 00 00       	call   80104980 <popcli>
  p->pid = allocpid();
8010390a:	e8 71 ff ff ff       	call   80103880 <allocpid>
8010390f:	89 43 10             	mov    %eax,0x10(%ebx)
  if((p->kstack = kalloc()) == 0){
80103912:	e8 d9 eb ff ff       	call   801024f0 <kalloc>
80103917:	85 c0                	test   %eax,%eax
80103919:	89 43 08             	mov    %eax,0x8(%ebx)
8010391c:	0f 84 c1 00 00 00    	je     801039e3 <allocproc+0x123>
  sp -= sizeof *p->tf;
80103922:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  memset(p->context, 0, sizeof *p->context);
80103928:	83 ec 04             	sub    $0x4,%esp
  sp -= sizeof *p->context;
8010392b:	05 9c 0f 00 00       	add    $0xf9c,%eax
  sp -= sizeof *p->tf;
80103930:	89 53 18             	mov    %edx,0x18(%ebx)
  *(uint*)sp = (uint)trapret;
80103933:	c7 40 14 e7 5d 10 80 	movl   $0x80105de7,0x14(%eax)
  p->context = (struct context*)sp;
8010393a:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
8010393d:	6a 14                	push   $0x14
8010393f:	6a 00                	push   $0x0
80103941:	50                   	push   %eax
80103942:	e8 d9 11 00 00       	call   80104b20 <memset>
  p->context->eip = (uint)forkret;
80103947:	8b 43 1c             	mov    0x1c(%ebx),%eax
8010394a:	c7 40 10 50 37 10 80 	movl   $0x80103750,0x10(%eax)
  p->backup = (struct trapframe*)kalloc();
80103951:	e8 9a eb ff ff       	call   801024f0 <kalloc>
80103956:	8d 93 8c 01 00 00    	lea    0x18c(%ebx),%edx
8010395c:	89 43 7c             	mov    %eax,0x7c(%ebx)
8010395f:	8d 83 8c 00 00 00    	lea    0x8c(%ebx),%eax
80103965:	83 c4 10             	add    $0x10,%esp
80103968:	90                   	nop
80103969:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    p->signal_handlers[i].sa_handler = SIG_DFL;
80103970:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    p->signal_handlers[i].sigmask = 0;
80103976:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
8010397d:	83 c0 08             	add    $0x8,%eax
  for(int i=0; i<32; i++){
80103980:	39 c2                	cmp    %eax,%edx
80103982:	75 ec                	jne    80103970 <allocproc+0xb0>
  p->pending_signals =0;
80103984:	c7 83 80 00 00 00 00 	movl   $0x0,0x80(%ebx)
8010398b:	00 00 00 
  p->signal_mask = 0;
8010398e:	c7 83 84 00 00 00 00 	movl   $0x0,0x84(%ebx)
80103995:	00 00 00 
  p->signal_mask_backup = 0;
80103998:	c7 83 88 00 00 00 00 	movl   $0x0,0x88(%ebx)
8010399f:	00 00 00 
  p->suspended =0;
801039a2:	c7 83 8c 01 00 00 00 	movl   $0x0,0x18c(%ebx)
801039a9:	00 00 00 
  p->already_in_signal = 0;
801039ac:	c7 83 90 01 00 00 00 	movl   $0x0,0x190(%ebx)
801039b3:	00 00 00 
  p->in_wait =0;
801039b6:	c7 83 94 01 00 00 00 	movl   $0x0,0x194(%ebx)
801039bd:	00 00 00 
  p->parent_in_wait =0;
801039c0:	c7 83 98 01 00 00 00 	movl   $0x0,0x198(%ebx)
801039c7:	00 00 00 
}
801039ca:	8d 65 f8             	lea    -0x8(%ebp),%esp
801039cd:	89 d8                	mov    %ebx,%eax
801039cf:	5b                   	pop    %ebx
801039d0:	5e                   	pop    %esi
801039d1:	5d                   	pop    %ebp
801039d2:	c3                   	ret    
  popcli();
801039d3:	e8 a8 0f 00 00       	call   80104980 <popcli>
}
801039d8:	8d 65 f8             	lea    -0x8(%ebp),%esp
  return 0;
801039db:	31 db                	xor    %ebx,%ebx
}
801039dd:	89 d8                	mov    %ebx,%eax
801039df:	5b                   	pop    %ebx
801039e0:	5e                   	pop    %esi
801039e1:	5d                   	pop    %ebp
801039e2:	c3                   	ret    
    p->state = UNUSED;
801039e3:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
801039ea:	31 db                	xor    %ebx,%ebx
801039ec:	eb dc                	jmp    801039ca <allocproc+0x10a>
801039ee:	66 90                	xchg   %ax,%ax

801039f0 <userinit>:
{
801039f0:	55                   	push   %ebp
801039f1:	89 e5                	mov    %esp,%ebp
801039f3:	53                   	push   %ebx
801039f4:	83 ec 04             	sub    $0x4,%esp
  p = allocproc();
801039f7:	e8 c4 fe ff ff       	call   801038c0 <allocproc>
801039fc:	89 c3                	mov    %eax,%ebx
  initproc = p;
801039fe:	a3 b8 b5 10 80       	mov    %eax,0x8010b5b8
  if((p->pgdir = setupkvm()) == 0)
80103a03:	e8 18 3a 00 00       	call   80107420 <setupkvm>
80103a08:	85 c0                	test   %eax,%eax
80103a0a:	89 43 04             	mov    %eax,0x4(%ebx)
80103a0d:	0f 84 bd 00 00 00    	je     80103ad0 <userinit+0xe0>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80103a13:	83 ec 04             	sub    $0x4,%esp
80103a16:	68 2c 00 00 00       	push   $0x2c
80103a1b:	68 60 b4 10 80       	push   $0x8010b460
80103a20:	50                   	push   %eax
80103a21:	e8 da 36 00 00       	call   80107100 <inituvm>
  memset(p->tf, 0, sizeof(*p->tf));
80103a26:	83 c4 0c             	add    $0xc,%esp
  p->sz = PGSIZE;
80103a29:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
80103a2f:	6a 4c                	push   $0x4c
80103a31:	6a 00                	push   $0x0
80103a33:	ff 73 18             	pushl  0x18(%ebx)
80103a36:	e8 e5 10 00 00       	call   80104b20 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103a3b:	8b 43 18             	mov    0x18(%ebx),%eax
80103a3e:	ba 1b 00 00 00       	mov    $0x1b,%edx
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103a43:	b9 23 00 00 00       	mov    $0x23,%ecx
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103a48:	83 c4 0c             	add    $0xc,%esp
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103a4b:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103a4f:	8b 43 18             	mov    0x18(%ebx),%eax
80103a52:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
80103a56:	8b 43 18             	mov    0x18(%ebx),%eax
80103a59:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103a5d:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80103a61:	8b 43 18             	mov    0x18(%ebx),%eax
80103a64:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103a68:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
80103a6c:	8b 43 18             	mov    0x18(%ebx),%eax
80103a6f:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80103a76:	8b 43 18             	mov    0x18(%ebx),%eax
80103a79:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80103a80:	8b 43 18             	mov    0x18(%ebx),%eax
80103a83:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103a8a:	8d 43 6c             	lea    0x6c(%ebx),%eax
80103a8d:	6a 10                	push   $0x10
80103a8f:	68 67 7c 10 80       	push   $0x80107c67
80103a94:	50                   	push   %eax
80103a95:	e8 66 12 00 00       	call   80104d00 <safestrcpy>
  p->cwd = namei("/");
80103a9a:	c7 04 24 70 7c 10 80 	movl   $0x80107c70,(%esp)
80103aa1:	e8 6a e4 ff ff       	call   80101f10 <namei>
80103aa6:	89 43 68             	mov    %eax,0x68(%ebx)
  pushcli();
80103aa9:	e8 92 0e 00 00       	call   80104940 <pushcli>
  asm volatile("movl %2 , %%eax\n\t"
80103aae:	ba 01 00 00 00       	mov    $0x1,%edx
80103ab3:	b9 03 00 00 00       	mov    $0x3,%ecx
80103ab8:	89 d0                	mov    %edx,%eax
80103aba:	f0 0f b1 4b 0c       	lock cmpxchg %ecx,0xc(%ebx)
80103abf:	9c                   	pushf  
80103ac0:	5a                   	pop    %edx
80103ac1:	83 e2 40             	and    $0x40,%edx
  popcli();
80103ac4:	83 c4 10             	add    $0x10,%esp
}
80103ac7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103aca:	c9                   	leave  
  popcli();
80103acb:	e9 b0 0e 00 00       	jmp    80104980 <popcli>
    panic("userinit: out of memory?");
80103ad0:	83 ec 0c             	sub    $0xc,%esp
80103ad3:	68 4e 7c 10 80       	push   $0x80107c4e
80103ad8:	e8 b3 c8 ff ff       	call   80100390 <panic>
80103add:	8d 76 00             	lea    0x0(%esi),%esi

80103ae0 <growproc>:
{
80103ae0:	55                   	push   %ebp
80103ae1:	89 e5                	mov    %esp,%ebp
80103ae3:	56                   	push   %esi
80103ae4:	53                   	push   %ebx
80103ae5:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
80103ae8:	e8 53 0e 00 00       	call   80104940 <pushcli>
  c = mycpu();
80103aed:	e8 be fc ff ff       	call   801037b0 <mycpu>
  p = c->proc;
80103af2:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103af8:	e8 83 0e 00 00       	call   80104980 <popcli>
  if(n > 0){
80103afd:	83 fe 00             	cmp    $0x0,%esi
  sz = curproc->sz;
80103b00:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
80103b02:	7f 1c                	jg     80103b20 <growproc+0x40>
  } else if(n < 0){
80103b04:	75 3a                	jne    80103b40 <growproc+0x60>
  switchuvm(curproc);
80103b06:	83 ec 0c             	sub    $0xc,%esp
  curproc->sz = sz;
80103b09:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
80103b0b:	53                   	push   %ebx
80103b0c:	e8 df 34 00 00       	call   80106ff0 <switchuvm>
  return 0;
80103b11:	83 c4 10             	add    $0x10,%esp
80103b14:	31 c0                	xor    %eax,%eax
}
80103b16:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103b19:	5b                   	pop    %ebx
80103b1a:	5e                   	pop    %esi
80103b1b:	5d                   	pop    %ebp
80103b1c:	c3                   	ret    
80103b1d:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103b20:	83 ec 04             	sub    $0x4,%esp
80103b23:	01 c6                	add    %eax,%esi
80103b25:	56                   	push   %esi
80103b26:	50                   	push   %eax
80103b27:	ff 73 04             	pushl  0x4(%ebx)
80103b2a:	e8 11 37 00 00       	call   80107240 <allocuvm>
80103b2f:	83 c4 10             	add    $0x10,%esp
80103b32:	85 c0                	test   %eax,%eax
80103b34:	75 d0                	jne    80103b06 <growproc+0x26>
      return -1;
80103b36:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103b3b:	eb d9                	jmp    80103b16 <growproc+0x36>
80103b3d:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103b40:	83 ec 04             	sub    $0x4,%esp
80103b43:	01 c6                	add    %eax,%esi
80103b45:	56                   	push   %esi
80103b46:	50                   	push   %eax
80103b47:	ff 73 04             	pushl  0x4(%ebx)
80103b4a:	e8 21 38 00 00       	call   80107370 <deallocuvm>
80103b4f:	83 c4 10             	add    $0x10,%esp
80103b52:	85 c0                	test   %eax,%eax
80103b54:	75 b0                	jne    80103b06 <growproc+0x26>
80103b56:	eb de                	jmp    80103b36 <growproc+0x56>
80103b58:	90                   	nop
80103b59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103b60 <fork>:
{
80103b60:	55                   	push   %ebp
80103b61:	89 e5                	mov    %esp,%ebp
80103b63:	57                   	push   %edi
80103b64:	56                   	push   %esi
80103b65:	53                   	push   %ebx
80103b66:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
80103b69:	e8 d2 0d 00 00       	call   80104940 <pushcli>
  c = mycpu();
80103b6e:	e8 3d fc ff ff       	call   801037b0 <mycpu>
  p = c->proc;
80103b73:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103b79:	e8 02 0e 00 00       	call   80104980 <popcli>
  if((np = allocproc()) == 0){
80103b7e:	e8 3d fd ff ff       	call   801038c0 <allocproc>
80103b83:	85 c0                	test   %eax,%eax
80103b85:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103b88:	0f 84 07 01 00 00    	je     80103c95 <fork+0x135>
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
80103b8e:	83 ec 08             	sub    $0x8,%esp
80103b91:	ff 33                	pushl  (%ebx)
80103b93:	ff 73 04             	pushl  0x4(%ebx)
80103b96:	e8 55 39 00 00       	call   801074f0 <copyuvm>
80103b9b:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103b9e:	83 c4 10             	add    $0x10,%esp
80103ba1:	85 c0                	test   %eax,%eax
80103ba3:	89 42 04             	mov    %eax,0x4(%edx)
80103ba6:	0f 84 f2 00 00 00    	je     80103c9e <fork+0x13e>
  np->sz = curproc->sz;
80103bac:	8b 03                	mov    (%ebx),%eax
  *np->tf = *curproc->tf;
80103bae:	8b 7a 18             	mov    0x18(%edx),%edi
80103bb1:	b9 13 00 00 00       	mov    $0x13,%ecx
  np->parent = curproc;
80103bb6:	89 5a 14             	mov    %ebx,0x14(%edx)
  np->sz = curproc->sz;
80103bb9:	89 02                	mov    %eax,(%edx)
  *np->tf = *curproc->tf;
80103bbb:	8b 73 18             	mov    0x18(%ebx),%esi
80103bbe:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  for(i = 0; i < NOFILE; i++)
80103bc0:	31 f6                	xor    %esi,%esi
  np->tf->eax = 0;
80103bc2:	8b 42 18             	mov    0x18(%edx),%eax
80103bc5:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
80103bcc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[i])
80103bd0:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
80103bd4:	85 c0                	test   %eax,%eax
80103bd6:	74 16                	je     80103bee <fork+0x8e>
      np->ofile[i] = filedup(curproc->ofile[i]);
80103bd8:	83 ec 0c             	sub    $0xc,%esp
80103bdb:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80103bde:	50                   	push   %eax
80103bdf:	e8 3c d2 ff ff       	call   80100e20 <filedup>
80103be4:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103be7:	83 c4 10             	add    $0x10,%esp
80103bea:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
  for(i = 0; i < NOFILE; i++)
80103bee:	83 c6 01             	add    $0x1,%esi
80103bf1:	83 fe 10             	cmp    $0x10,%esi
80103bf4:	75 da                	jne    80103bd0 <fork+0x70>
  np->cwd = idup(curproc->cwd);
80103bf6:	83 ec 0c             	sub    $0xc,%esp
80103bf9:	ff 73 68             	pushl  0x68(%ebx)
80103bfc:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80103bff:	e8 7c da ff ff       	call   80101680 <idup>
80103c04:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103c07:	83 c4 0c             	add    $0xc,%esp
  np->cwd = idup(curproc->cwd);
80103c0a:	89 42 68             	mov    %eax,0x68(%edx)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103c0d:	8d 43 6c             	lea    0x6c(%ebx),%eax
80103c10:	6a 10                	push   $0x10
80103c12:	50                   	push   %eax
80103c13:	8d 42 6c             	lea    0x6c(%edx),%eax
80103c16:	50                   	push   %eax
80103c17:	e8 e4 10 00 00       	call   80104d00 <safestrcpy>
  pid = np->pid;
80103c1c:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  np->signal_mask = curproc->signal_mask;
80103c1f:	83 c4 10             	add    $0x10,%esp
  pid = np->pid;
80103c22:	8b 42 10             	mov    0x10(%edx),%eax
80103c25:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  np->signal_mask = curproc->signal_mask;
80103c28:	8b 83 84 00 00 00    	mov    0x84(%ebx),%eax
80103c2e:	89 82 84 00 00 00    	mov    %eax,0x84(%edx)
  for(int i=0; i<32; i++){
80103c34:	31 c0                	xor    %eax,%eax
80103c36:	8d 76 00             	lea    0x0(%esi),%esi
80103c39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    np->signal_handlers[i] = curproc->signal_handlers[i];
80103c40:	8b b4 c3 8c 00 00 00 	mov    0x8c(%ebx,%eax,8),%esi
80103c47:	8b bc c3 90 00 00 00 	mov    0x90(%ebx,%eax,8),%edi
80103c4e:	89 b4 c2 8c 00 00 00 	mov    %esi,0x8c(%edx,%eax,8)
80103c55:	89 bc c2 90 00 00 00 	mov    %edi,0x90(%edx,%eax,8)
  for(int i=0; i<32; i++){
80103c5c:	83 c0 01             	add    $0x1,%eax
80103c5f:	83 f8 20             	cmp    $0x20,%eax
80103c62:	75 dc                	jne    80103c40 <fork+0xe0>
80103c64:	89 55 e0             	mov    %edx,-0x20(%ebp)
80103c67:	bb 03 00 00 00       	mov    $0x3,%ebx
  pushcli();
80103c6c:	e8 cf 0c 00 00       	call   80104940 <pushcli>
80103c71:	b9 01 00 00 00       	mov    $0x1,%ecx
80103c76:	8b 55 e0             	mov    -0x20(%ebp),%edx
80103c79:	89 c8                	mov    %ecx,%eax
80103c7b:	f0 0f b1 5a 0c       	lock cmpxchg %ebx,0xc(%edx)
80103c80:	9c                   	pushf  
80103c81:	59                   	pop    %ecx
80103c82:	83 e1 40             	and    $0x40,%ecx
  popcli();
80103c85:	e8 f6 0c 00 00       	call   80104980 <popcli>
}
80103c8a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103c8d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103c90:	5b                   	pop    %ebx
80103c91:	5e                   	pop    %esi
80103c92:	5f                   	pop    %edi
80103c93:	5d                   	pop    %ebp
80103c94:	c3                   	ret    
    return -1;
80103c95:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
80103c9c:	eb ec                	jmp    80103c8a <fork+0x12a>
    kfree(np->kstack);
80103c9e:	83 ec 0c             	sub    $0xc,%esp
80103ca1:	ff 72 08             	pushl  0x8(%edx)
80103ca4:	e8 97 e6 ff ff       	call   80102340 <kfree>
    np->kstack = 0;
80103ca9:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    return -1;
80103cac:	83 c4 10             	add    $0x10,%esp
80103caf:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
    np->kstack = 0;
80103cb6:	c7 42 08 00 00 00 00 	movl   $0x0,0x8(%edx)
    np->state = UNUSED;
80103cbd:	c7 42 0c 00 00 00 00 	movl   $0x0,0xc(%edx)
    return -1;
80103cc4:	eb c4                	jmp    80103c8a <fork+0x12a>
80103cc6:	8d 76 00             	lea    0x0(%esi),%esi
80103cc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103cd0 <scheduler>:
{
80103cd0:	55                   	push   %ebp
80103cd1:	89 e5                	mov    %esp,%ebp
80103cd3:	57                   	push   %edi
80103cd4:	56                   	push   %esi
80103cd5:	53                   	push   %ebx
80103cd6:	bf 03 00 00 00       	mov    $0x3,%edi
80103cdb:	83 ec 1c             	sub    $0x1c,%esp
  struct cpu *c = mycpu();
80103cde:	e8 cd fa ff ff       	call   801037b0 <mycpu>
  c->proc = 0;
80103ce3:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80103cea:	00 00 00 
  struct cpu *c = mycpu();
80103ced:	89 c6                	mov    %eax,%esi
80103cef:	8d 40 04             	lea    0x4(%eax),%eax
80103cf2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103cf5:	8d 76 00             	lea    0x0(%esi),%esi
  asm volatile("sti");
80103cf8:	fb                   	sti    
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103cf9:	bb 54 3d 11 80       	mov    $0x80113d54,%ebx
    pushcli();
80103cfe:	e8 3d 0c 00 00       	call   80104940 <pushcli>
80103d03:	90                   	nop
80103d04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  asm volatile("movl %2 , %%eax\n\t"
80103d08:	b9 04 00 00 00       	mov    $0x4,%ecx
80103d0d:	89 f8                	mov    %edi,%eax
80103d0f:	f0 0f b1 4b 0c       	lock cmpxchg %ecx,0xc(%ebx)
80103d14:	9c                   	pushf  
80103d15:	5a                   	pop    %edx
80103d16:	83 e2 40             	and    $0x40,%edx
  return ret>>6;
80103d19:	c1 fa 06             	sar    $0x6,%edx
      if (!result)
80103d1c:	85 d2                	test   %edx,%edx
80103d1e:	74 72                	je     80103d92 <scheduler+0xc2>
      switchuvm(p);
80103d20:	83 ec 0c             	sub    $0xc,%esp
      c->proc = p;
80103d23:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
      switchuvm(p);
80103d29:	53                   	push   %ebx
80103d2a:	e8 c1 32 00 00       	call   80106ff0 <switchuvm>
      swtch(&(c->scheduler), p->context);
80103d2f:	58                   	pop    %eax
80103d30:	5a                   	pop    %edx
80103d31:	ff 73 1c             	pushl  0x1c(%ebx)
80103d34:	ff 75 e4             	pushl  -0x1c(%ebp)
      p->state = RUNNING;
80103d37:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
      swtch(&(c->scheduler), p->context);
80103d3e:	e8 18 10 00 00       	call   80104d5b <swtch>
      switchkvm();
80103d43:	e8 88 32 00 00       	call   80106fd0 <switchkvm>
  asm volatile("movl %2 , %%eax\n\t"
80103d48:	ba fe ff ff ff       	mov    $0xfffffffe,%edx
80103d4d:	b9 02 00 00 00       	mov    $0x2,%ecx
80103d52:	89 d0                	mov    %edx,%eax
80103d54:	f0 0f b1 4b 0c       	lock cmpxchg %ecx,0xc(%ebx)
80103d59:	9c                   	pushf  
80103d5a:	5a                   	pop    %edx
80103d5b:	83 e2 40             	and    $0x40,%edx
80103d5e:	ba fd ff ff ff       	mov    $0xfffffffd,%edx
80103d63:	89 d0                	mov    %edx,%eax
80103d65:	f0 0f b1 7b 0c       	lock cmpxchg %edi,0xc(%ebx)
80103d6a:	9c                   	pushf  
80103d6b:	5a                   	pop    %edx
80103d6c:	83 e2 40             	and    $0x40,%edx
80103d6f:	ba fb ff ff ff       	mov    $0xfffffffb,%edx
80103d74:	b9 05 00 00 00       	mov    $0x5,%ecx
80103d79:	89 d0                	mov    %edx,%eax
80103d7b:	f0 0f b1 4b 0c       	lock cmpxchg %ecx,0xc(%ebx)
80103d80:	9c                   	pushf  
80103d81:	5a                   	pop    %edx
80103d82:	83 e2 40             	and    $0x40,%edx
      c->proc = 0;
80103d85:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
80103d8c:	00 00 00 
80103d8f:	83 c4 10             	add    $0x10,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103d92:	81 c3 9c 01 00 00    	add    $0x19c,%ebx
80103d98:	81 fb 54 a4 11 80    	cmp    $0x8011a454,%ebx
80103d9e:	0f 82 64 ff ff ff    	jb     80103d08 <scheduler+0x38>
    popcli();
80103da4:	e8 d7 0b 00 00       	call   80104980 <popcli>
    sti();
80103da9:	e9 4a ff ff ff       	jmp    80103cf8 <scheduler+0x28>
80103dae:	66 90                	xchg   %ax,%ax

80103db0 <sched>:
{
80103db0:	55                   	push   %ebp
80103db1:	89 e5                	mov    %esp,%ebp
80103db3:	56                   	push   %esi
80103db4:	53                   	push   %ebx
  pushcli();
80103db5:	e8 86 0b 00 00       	call   80104940 <pushcli>
  c = mycpu();
80103dba:	e8 f1 f9 ff ff       	call   801037b0 <mycpu>
  p = c->proc;
80103dbf:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103dc5:	e8 b6 0b 00 00       	call   80104980 <popcli>
  if(mycpu()->ncli != 1)
80103dca:	e8 e1 f9 ff ff       	call   801037b0 <mycpu>
80103dcf:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
80103dd6:	75 41                	jne    80103e19 <sched+0x69>
  if(p->state == RUNNING)
80103dd8:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80103ddc:	74 55                	je     80103e33 <sched+0x83>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103dde:	9c                   	pushf  
80103ddf:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103de0:	f6 c4 02             	test   $0x2,%ah
80103de3:	75 41                	jne    80103e26 <sched+0x76>
  intena = mycpu()->intena;
80103de5:	e8 c6 f9 ff ff       	call   801037b0 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
80103dea:	83 c3 1c             	add    $0x1c,%ebx
  intena = mycpu()->intena;
80103ded:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80103df3:	e8 b8 f9 ff ff       	call   801037b0 <mycpu>
80103df8:	83 ec 08             	sub    $0x8,%esp
80103dfb:	ff 70 04             	pushl  0x4(%eax)
80103dfe:	53                   	push   %ebx
80103dff:	e8 57 0f 00 00       	call   80104d5b <swtch>
  mycpu()->intena = intena;
80103e04:	e8 a7 f9 ff ff       	call   801037b0 <mycpu>
}
80103e09:	83 c4 10             	add    $0x10,%esp
  mycpu()->intena = intena;
80103e0c:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80103e12:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103e15:	5b                   	pop    %ebx
80103e16:	5e                   	pop    %esi
80103e17:	5d                   	pop    %ebp
80103e18:	c3                   	ret    
    panic("sched locks");
80103e19:	83 ec 0c             	sub    $0xc,%esp
80103e1c:	68 72 7c 10 80       	push   $0x80107c72
80103e21:	e8 6a c5 ff ff       	call   80100390 <panic>
    panic("sched interruptible");
80103e26:	83 ec 0c             	sub    $0xc,%esp
80103e29:	68 8c 7c 10 80       	push   $0x80107c8c
80103e2e:	e8 5d c5 ff ff       	call   80100390 <panic>
    panic("sched running");
80103e33:	83 ec 0c             	sub    $0xc,%esp
80103e36:	68 7e 7c 10 80       	push   $0x80107c7e
80103e3b:	e8 50 c5 ff ff       	call   80100390 <panic>

80103e40 <exit>:
{
80103e40:	55                   	push   %ebp
80103e41:	89 e5                	mov    %esp,%ebp
80103e43:	57                   	push   %edi
80103e44:	56                   	push   %esi
80103e45:	53                   	push   %ebx
80103e46:	83 ec 0c             	sub    $0xc,%esp
  pushcli();
80103e49:	e8 f2 0a 00 00       	call   80104940 <pushcli>
  c = mycpu();
80103e4e:	e8 5d f9 ff ff       	call   801037b0 <mycpu>
  p = c->proc;
80103e53:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80103e59:	e8 22 0b 00 00       	call   80104980 <popcli>
  if(curproc == initproc)
80103e5e:	39 35 b8 b5 10 80    	cmp    %esi,0x8010b5b8
80103e64:	8d 5e 28             	lea    0x28(%esi),%ebx
80103e67:	8d 7e 68             	lea    0x68(%esi),%edi
80103e6a:	0f 84 02 01 00 00    	je     80103f72 <exit+0x132>
    if(curproc->ofile[fd]){
80103e70:	8b 03                	mov    (%ebx),%eax
80103e72:	85 c0                	test   %eax,%eax
80103e74:	74 12                	je     80103e88 <exit+0x48>
      fileclose(curproc->ofile[fd]);
80103e76:	83 ec 0c             	sub    $0xc,%esp
80103e79:	50                   	push   %eax
80103e7a:	e8 f1 cf ff ff       	call   80100e70 <fileclose>
      curproc->ofile[fd] = 0;
80103e7f:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80103e85:	83 c4 10             	add    $0x10,%esp
80103e88:	83 c3 04             	add    $0x4,%ebx
  for(fd = 0; fd < NOFILE; fd++){
80103e8b:	39 df                	cmp    %ebx,%edi
80103e8d:	75 e1                	jne    80103e70 <exit+0x30>
  begin_op();
80103e8f:	e8 3c ed ff ff       	call   80102bd0 <begin_op>
  iput(curproc->cwd);
80103e94:	83 ec 0c             	sub    $0xc,%esp
80103e97:	ff 76 68             	pushl  0x68(%esi)
80103e9a:	e8 41 d9 ff ff       	call   801017e0 <iput>
  end_op();
80103e9f:	e8 9c ed ff ff       	call   80102c40 <end_op>
  curproc->cwd = 0;
80103ea4:	c7 46 68 00 00 00 00 	movl   $0x0,0x68(%esi)
  pushcli();
80103eab:	e8 90 0a 00 00       	call   80104940 <pushcli>
  asm volatile("movl %2 , %%eax\n\t"
80103eb0:	ba 04 00 00 00       	mov    $0x4,%edx
80103eb5:	b9 fb ff ff ff       	mov    $0xfffffffb,%ecx
80103eba:	89 d0                	mov    %edx,%eax
80103ebc:	f0 0f b1 4e 0c       	lock cmpxchg %ecx,0xc(%esi)
80103ec1:	9c                   	pushf  
80103ec2:	5a                   	pop    %edx
80103ec3:	83 e2 40             	and    $0x40,%edx
80103ec6:	31 ff                	xor    %edi,%edi
80103ec8:	83 c4 10             	add    $0x10,%esp
80103ecb:	eb 23                	jmp    80103ef0 <exit+0xb0>
80103ecd:	8d 76 00             	lea    0x0(%esi),%esi
80103ed0:	89 f8                	mov    %edi,%eax
80103ed2:	f0 0f b1 ba 94 01 00 	lock cmpxchg %edi,0x194(%edx)
80103ed9:	00 
80103eda:	9c                   	pushf  
80103edb:	59                   	pop    %ecx
80103edc:	83 e1 40             	and    $0x40,%ecx
  return ret>>6;
80103edf:	c1 f9 06             	sar    $0x6,%ecx
  }while((!cas(&curproc->parent->in_wait, 0,0)) && (!curproc->parent_in_wait));
80103ee2:	85 c9                	test   %ecx,%ecx
80103ee4:	75 7a                	jne    80103f60 <exit+0x120>
80103ee6:	8b 86 98 01 00 00    	mov    0x198(%esi),%eax
80103eec:	85 c0                	test   %eax,%eax
80103eee:	75 70                	jne    80103f60 <exit+0x120>
    if((!curproc->parent->in_wait) || (curproc->parent_in_wait) ){
80103ef0:	8b 56 14             	mov    0x14(%esi),%edx
80103ef3:	8b 9a 94 01 00 00    	mov    0x194(%edx),%ebx
80103ef9:	85 db                	test   %ebx,%ebx
80103efb:	74 0a                	je     80103f07 <exit+0xc7>
80103efd:	8b 8e 98 01 00 00    	mov    0x198(%esi),%ecx
80103f03:	85 c9                	test   %ecx,%ecx
80103f05:	74 c9                	je     80103ed0 <exit+0x90>
      wakeup1(curproc->parent);
80103f07:	89 d0                	mov    %edx,%eax
      for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103f09:	bb 54 3d 11 80       	mov    $0x80113d54,%ebx
      wakeup1(curproc->parent);
80103f0e:	e8 1d f7 ff ff       	call   80103630 <wakeup1>
80103f13:	eb 11                	jmp    80103f26 <exit+0xe6>
80103f15:	8d 76 00             	lea    0x0(%esi),%esi
      for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103f18:	81 c3 9c 01 00 00    	add    $0x19c,%ebx
80103f1e:	81 fb 54 a4 11 80    	cmp    $0x8011a454,%ebx
80103f24:	73 32                	jae    80103f58 <exit+0x118>
        if(p->parent == curproc){
80103f26:	39 73 14             	cmp    %esi,0x14(%ebx)
80103f29:	75 ed                	jne    80103f18 <exit+0xd8>
          if(p->state == ZOMBIE || p->state == -ZOMBIE){
80103f2b:	8b 53 0c             	mov    0xc(%ebx),%edx
          p->parent = initproc;
80103f2e:	a1 b8 b5 10 80       	mov    0x8010b5b8,%eax
          if(p->state == ZOMBIE || p->state == -ZOMBIE){
80103f33:	83 fa 05             	cmp    $0x5,%edx
          p->parent = initproc;
80103f36:	89 43 14             	mov    %eax,0x14(%ebx)
          if(p->state == ZOMBIE || p->state == -ZOMBIE){
80103f39:	74 05                	je     80103f40 <exit+0x100>
80103f3b:	83 fa fb             	cmp    $0xfffffffb,%edx
80103f3e:	75 d8                	jne    80103f18 <exit+0xd8>
      for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103f40:	81 c3 9c 01 00 00    	add    $0x19c,%ebx
            wakeup1(initproc);
80103f46:	e8 e5 f6 ff ff       	call   80103630 <wakeup1>
      for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103f4b:	81 fb 54 a4 11 80    	cmp    $0x8011a454,%ebx
80103f51:	72 d3                	jb     80103f26 <exit+0xe6>
80103f53:	90                   	nop
80103f54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103f58:	8b 56 14             	mov    0x14(%esi),%edx
80103f5b:	e9 70 ff ff ff       	jmp    80103ed0 <exit+0x90>
  sched();
80103f60:	e8 4b fe ff ff       	call   80103db0 <sched>
  panic("zombie exit");
80103f65:	83 ec 0c             	sub    $0xc,%esp
80103f68:	68 ad 7c 10 80       	push   $0x80107cad
80103f6d:	e8 1e c4 ff ff       	call   80100390 <panic>
    panic("init exiting");
80103f72:	83 ec 0c             	sub    $0xc,%esp
80103f75:	68 a0 7c 10 80       	push   $0x80107ca0
80103f7a:	e8 11 c4 ff ff       	call   80100390 <panic>
80103f7f:	90                   	nop

80103f80 <yield>:
{
80103f80:	55                   	push   %ebp
80103f81:	89 e5                	mov    %esp,%ebp
80103f83:	53                   	push   %ebx
80103f84:	83 ec 04             	sub    $0x4,%esp
  pushcli();  //DOC: yieldlock
80103f87:	e8 b4 09 00 00       	call   80104940 <pushcli>
  pushcli();
80103f8c:	e8 af 09 00 00       	call   80104940 <pushcli>
  c = mycpu();
80103f91:	e8 1a f8 ff ff       	call   801037b0 <mycpu>
  p = c->proc;
80103f96:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103f9c:	e8 df 09 00 00       	call   80104980 <popcli>
  asm volatile("movl %2 , %%eax\n\t"
80103fa1:	ba 04 00 00 00       	mov    $0x4,%edx
80103fa6:	b9 fd ff ff ff       	mov    $0xfffffffd,%ecx
80103fab:	89 d0                	mov    %edx,%eax
80103fad:	f0 0f b1 4b 0c       	lock cmpxchg %ecx,0xc(%ebx)
80103fb2:	9c                   	pushf  
80103fb3:	5a                   	pop    %edx
80103fb4:	83 e2 40             	and    $0x40,%edx
  sched();
80103fb7:	e8 f4 fd ff ff       	call   80103db0 <sched>
}
80103fbc:	83 c4 04             	add    $0x4,%esp
80103fbf:	5b                   	pop    %ebx
80103fc0:	5d                   	pop    %ebp
  popcli();
80103fc1:	e9 ba 09 00 00       	jmp    80104980 <popcli>
80103fc6:	8d 76 00             	lea    0x0(%esi),%esi
80103fc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103fd0 <sleep>:
{
80103fd0:	55                   	push   %ebp
80103fd1:	89 e5                	mov    %esp,%ebp
80103fd3:	57                   	push   %edi
80103fd4:	56                   	push   %esi
80103fd5:	53                   	push   %ebx
80103fd6:	83 ec 0c             	sub    $0xc,%esp
80103fd9:	8b 7d 08             	mov    0x8(%ebp),%edi
80103fdc:	8b 75 0c             	mov    0xc(%ebp),%esi
  pushcli();
80103fdf:	e8 5c 09 00 00       	call   80104940 <pushcli>
  c = mycpu();
80103fe4:	e8 c7 f7 ff ff       	call   801037b0 <mycpu>
  p = c->proc;
80103fe9:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103fef:	e8 8c 09 00 00       	call   80104980 <popcli>
  if(p == 0)
80103ff4:	85 db                	test   %ebx,%ebx
80103ff6:	74 7d                	je     80104075 <sleep+0xa5>
  if(lk == 0)
80103ff8:	85 f6                	test   %esi,%esi
80103ffa:	74 6c                	je     80104068 <sleep+0x98>
  if(lk != &ptable.lock){  //DOC: sleeplock0
80103ffc:	81 fe 20 3d 11 80    	cmp    $0x80113d20,%esi
80104002:	74 11                	je     80104015 <sleep+0x45>
    pushcli();  //DOC: sleeplock1
80104004:	e8 37 09 00 00       	call   80104940 <pushcli>
    release(lk);
80104009:	83 ec 0c             	sub    $0xc,%esp
8010400c:	56                   	push   %esi
8010400d:	e8 be 0a 00 00       	call   80104ad0 <release>
80104012:	83 c4 10             	add    $0x10,%esp
  p->chan = chan;
80104015:	89 7b 20             	mov    %edi,0x20(%ebx)
80104018:	ba 04 00 00 00       	mov    $0x4,%edx
8010401d:	b9 fe ff ff ff       	mov    $0xfffffffe,%ecx
80104022:	89 d0                	mov    %edx,%eax
80104024:	f0 0f b1 4b 0c       	lock cmpxchg %ecx,0xc(%ebx)
80104029:	9c                   	pushf  
8010402a:	5a                   	pop    %edx
8010402b:	83 e2 40             	and    $0x40,%edx
  p->in_wait = 0;
8010402e:	c7 83 94 01 00 00 00 	movl   $0x0,0x194(%ebx)
80104035:	00 00 00 
  sched();
80104038:	e8 73 fd ff ff       	call   80103db0 <sched>
  if(lk != &ptable.lock){  //DOC: sleeplock2
8010403d:	81 fe 20 3d 11 80    	cmp    $0x80113d20,%esi
  p->chan = 0;
80104043:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
  if(lk != &ptable.lock){  //DOC: sleeplock2
8010404a:	74 14                	je     80104060 <sleep+0x90>
    popcli();
8010404c:	e8 2f 09 00 00       	call   80104980 <popcli>
    acquire(lk);
80104051:	89 75 08             	mov    %esi,0x8(%ebp)
}
80104054:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104057:	5b                   	pop    %ebx
80104058:	5e                   	pop    %esi
80104059:	5f                   	pop    %edi
8010405a:	5d                   	pop    %ebp
    acquire(lk);
8010405b:	e9 b0 09 00 00       	jmp    80104a10 <acquire>
}
80104060:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104063:	5b                   	pop    %ebx
80104064:	5e                   	pop    %esi
80104065:	5f                   	pop    %edi
80104066:	5d                   	pop    %ebp
80104067:	c3                   	ret    
    panic("sleep without lk");
80104068:	83 ec 0c             	sub    $0xc,%esp
8010406b:	68 bf 7c 10 80       	push   $0x80107cbf
80104070:	e8 1b c3 ff ff       	call   80100390 <panic>
    panic("sleep");
80104075:	83 ec 0c             	sub    $0xc,%esp
80104078:	68 b9 7c 10 80       	push   $0x80107cb9
8010407d:	e8 0e c3 ff ff       	call   80100390 <panic>
80104082:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104089:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104090 <wait>:
{
80104090:	55                   	push   %ebp
80104091:	89 e5                	mov    %esp,%ebp
80104093:	57                   	push   %edi
80104094:	56                   	push   %esi
80104095:	53                   	push   %ebx
80104096:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
80104099:	e8 a2 08 00 00       	call   80104940 <pushcli>
  c = mycpu();
8010409e:	e8 0d f7 ff ff       	call   801037b0 <mycpu>
  p = c->proc;
801040a3:	8b b8 ac 00 00 00    	mov    0xac(%eax),%edi
  popcli();
801040a9:	e8 d2 08 00 00       	call   80104980 <popcli>
  pushcli();
801040ae:	e8 8d 08 00 00       	call   80104940 <pushcli>
    curproc->in_wait =1;
801040b3:	ba 01 00 00 00       	mov    $0x1,%edx
801040b8:	89 97 94 01 00 00    	mov    %edx,0x194(%edi)
    havekids = 0;
801040be:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801040c0:	bb 54 3d 11 80       	mov    $0x80113d54,%ebx
801040c5:	eb 17                	jmp    801040de <wait+0x4e>
801040c7:	89 f6                	mov    %esi,%esi
801040c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801040d0:	81 c3 9c 01 00 00    	add    $0x19c,%ebx
801040d6:	81 fb 54 a4 11 80    	cmp    $0x8011a454,%ebx
801040dc:	73 27                	jae    80104105 <wait+0x75>
      if(p->parent != curproc)
801040de:	8b 73 14             	mov    0x14(%ebx),%esi
801040e1:	39 fe                	cmp    %edi,%esi
801040e3:	75 eb                	jne    801040d0 <wait+0x40>
      if(p->state == ZOMBIE || p->state == -ZOMBIE){
801040e5:	8b 43 0c             	mov    0xc(%ebx),%eax
801040e8:	83 f8 05             	cmp    $0x5,%eax
801040eb:	74 4b                	je     80104138 <wait+0xa8>
801040ed:	83 f8 fb             	cmp    $0xfffffffb,%eax
801040f0:	74 46                	je     80104138 <wait+0xa8>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801040f2:	81 c3 9c 01 00 00    	add    $0x19c,%ebx
      havekids = 1;
801040f8:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801040fd:	81 fb 54 a4 11 80    	cmp    $0x8011a454,%ebx
80104103:	72 d9                	jb     801040de <wait+0x4e>
    if(!havekids || curproc->killed){
80104105:	85 c0                	test   %eax,%eax
80104107:	0f 84 ac 00 00 00    	je     801041b9 <wait+0x129>
8010410d:	8b 47 24             	mov    0x24(%edi),%eax
80104110:	85 c0                	test   %eax,%eax
80104112:	0f 85 a1 00 00 00    	jne    801041b9 <wait+0x129>
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
80104118:	83 ec 08             	sub    $0x8,%esp
8010411b:	89 55 e4             	mov    %edx,-0x1c(%ebp)
8010411e:	68 20 3d 11 80       	push   $0x80113d20
80104123:	57                   	push   %edi
80104124:	e8 a7 fe ff ff       	call   80103fd0 <sleep>
    havekids = 0;
80104129:	83 c4 10             	add    $0x10,%esp
8010412c:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010412f:	eb 87                	jmp    801040b8 <wait+0x28>
80104131:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        while(p->state == -ZOMBIE){ // need to wait antil it zombie so i will not realse before done turning states
80104138:	83 f8 fb             	cmp    $0xfffffffb,%eax
8010413b:	75 03                	jne    80104140 <wait+0xb0>
8010413d:	eb fe                	jmp    8010413d <wait+0xad>
8010413f:	90                   	nop
        kfree(p->kstack);
80104140:	83 ec 0c             	sub    $0xc,%esp
80104143:	ff 73 08             	pushl  0x8(%ebx)
        p->parent_in_wait =0;
80104146:	c7 83 98 01 00 00 00 	movl   $0x0,0x198(%ebx)
8010414d:	00 00 00 
        pid = p->pid;
80104150:	8b 7b 10             	mov    0x10(%ebx),%edi
        kfree(p->kstack);
80104153:	e8 e8 e1 ff ff       	call   80102340 <kfree>
        freevm(p->pgdir);
80104158:	5a                   	pop    %edx
80104159:	ff 73 04             	pushl  0x4(%ebx)
        p->kstack = 0;
8010415c:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80104163:	e8 38 32 00 00       	call   801073a0 <freevm>
        p->pid = 0;
80104168:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
8010416f:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
80104176:	ba 05 00 00 00       	mov    $0x5,%edx
        p->name[0] = 0;
8010417b:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
8010417f:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
80104186:	31 c9                	xor    %ecx,%ecx
80104188:	89 d0                	mov    %edx,%eax
8010418a:	f0 0f b1 4b 0c       	lock cmpxchg %ecx,0xc(%ebx)
8010418f:	9c                   	pushf  
80104190:	5a                   	pop    %edx
80104191:	83 e2 40             	and    $0x40,%edx
        kfree((char *)p->backup);
80104194:	59                   	pop    %ecx
80104195:	ff 73 7c             	pushl  0x7c(%ebx)
80104198:	e8 a3 e1 ff ff       	call   80102340 <kfree>
        popcli();
8010419d:	e8 de 07 00 00       	call   80104980 <popcli>
        curproc->in_wait =0;
801041a2:	c7 86 94 01 00 00 00 	movl   $0x0,0x194(%esi)
801041a9:	00 00 00 
        return pid;
801041ac:	83 c4 10             	add    $0x10,%esp
}
801041af:	8d 65 f4             	lea    -0xc(%ebp),%esp
801041b2:	89 f8                	mov    %edi,%eax
801041b4:	5b                   	pop    %ebx
801041b5:	5e                   	pop    %esi
801041b6:	5f                   	pop    %edi
801041b7:	5d                   	pop    %ebp
801041b8:	c3                   	ret    
      popcli();
801041b9:	e8 c2 07 00 00       	call   80104980 <popcli>
      return -1;
801041be:	bf ff ff ff ff       	mov    $0xffffffff,%edi
801041c3:	eb ea                	jmp    801041af <wait+0x11f>
801041c5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801041c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801041d0 <wakeup>:
{
801041d0:	55                   	push   %ebp
801041d1:	89 e5                	mov    %esp,%ebp
801041d3:	53                   	push   %ebx
801041d4:	83 ec 04             	sub    $0x4,%esp
801041d7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
801041da:	e8 61 07 00 00       	call   80104940 <pushcli>
  wakeup1(chan);
801041df:	89 d8                	mov    %ebx,%eax
801041e1:	e8 4a f4 ff ff       	call   80103630 <wakeup1>
}
801041e6:	83 c4 04             	add    $0x4,%esp
801041e9:	5b                   	pop    %ebx
801041ea:	5d                   	pop    %ebp
  popcli();
801041eb:	e9 90 07 00 00       	jmp    80104980 <popcli>

801041f0 <kill>:
{
801041f0:	55                   	push   %ebp
801041f1:	89 e5                	mov    %esp,%ebp
801041f3:	57                   	push   %edi
801041f4:	56                   	push   %esi
801041f5:	53                   	push   %ebx
801041f6:	83 ec 0c             	sub    $0xc,%esp
801041f9:	8b 75 0c             	mov    0xc(%ebp),%esi
801041fc:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (signum > 31 || signum < 0)
801041ff:	83 fe 1f             	cmp    $0x1f,%esi
80104202:	0f 87 aa 00 00 00    	ja     801042b2 <kill+0xc2>
  pushcli();
80104208:	e8 33 07 00 00       	call   80104940 <pushcli>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010420d:	ba 54 3d 11 80       	mov    $0x80113d54,%edx
80104212:	eb 12                	jmp    80104226 <kill+0x36>
80104214:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104218:	81 c2 9c 01 00 00    	add    $0x19c,%edx
8010421e:	81 fa 54 a4 11 80    	cmp    $0x8011a454,%edx
80104224:	73 7a                	jae    801042a0 <kill+0xb0>
    if(p->pid == pid){
80104226:	39 5a 10             	cmp    %ebx,0x10(%edx)
80104229:	75 ed                	jne    80104218 <kill+0x28>
      p->pending_signals = p->pending_signals | (1<<signum);
8010422b:	b8 01 00 00 00       	mov    $0x1,%eax
80104230:	89 f1                	mov    %esi,%ecx
80104232:	d3 e0                	shl    %cl,%eax
80104234:	09 82 80 00 00 00    	or     %eax,0x80(%edx)
      if(signum == SIGKILL){
8010423a:	83 fe 09             	cmp    $0x9,%esi
8010423d:	74 11                	je     80104250 <kill+0x60>
      popcli();
8010423f:	e8 3c 07 00 00       	call   80104980 <popcli>
      return 0;
80104244:	31 c0                	xor    %eax,%eax
}
80104246:	83 c4 0c             	add    $0xc,%esp
80104249:	5b                   	pop    %ebx
8010424a:	5e                   	pop    %esi
8010424b:	5f                   	pop    %edi
8010424c:	5d                   	pop    %ebp
8010424d:	c3                   	ret    
8010424e:	66 90                	xchg   %ax,%ax
        while(p->state == SLEEPING || p->state == -SLEEPING){
80104250:	8b 42 0c             	mov    0xc(%edx),%eax
80104253:	83 f8 02             	cmp    $0x2,%eax
80104256:	74 05                	je     8010425d <kill+0x6d>
80104258:	83 f8 fe             	cmp    $0xfffffffe,%eax
8010425b:	75 e2                	jne    8010423f <kill+0x4f>
8010425d:	8d 72 0c             	lea    0xc(%edx),%esi
80104260:	bf fe ff ff ff       	mov    $0xfffffffe,%edi
80104265:	8d 76 00             	lea    0x0(%esi),%esi
80104268:	b9 fd ff ff ff       	mov    $0xfffffffd,%ecx
8010426d:	89 f8                	mov    %edi,%eax
8010426f:	f0 0f b1 0e          	lock cmpxchg %ecx,(%esi)
80104273:	9c                   	pushf  
80104274:	59                   	pop    %ecx
80104275:	83 e1 40             	and    $0x40,%ecx
80104278:	b9 02 00 00 00       	mov    $0x2,%ecx
8010427d:	bb 03 00 00 00       	mov    $0x3,%ebx
80104282:	89 c8                	mov    %ecx,%eax
80104284:	f0 0f b1 1e          	lock cmpxchg %ebx,(%esi)
80104288:	9c                   	pushf  
80104289:	59                   	pop    %ecx
8010428a:	83 e1 40             	and    $0x40,%ecx
8010428d:	8b 42 0c             	mov    0xc(%edx),%eax
80104290:	83 f8 02             	cmp    $0x2,%eax
80104293:	74 d3                	je     80104268 <kill+0x78>
80104295:	83 f8 fe             	cmp    $0xfffffffe,%eax
80104298:	74 ce                	je     80104268 <kill+0x78>
8010429a:	eb a3                	jmp    8010423f <kill+0x4f>
8010429c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  popcli();
801042a0:	e8 db 06 00 00       	call   80104980 <popcli>
}
801042a5:	83 c4 0c             	add    $0xc,%esp
  return -1;
801042a8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801042ad:	5b                   	pop    %ebx
801042ae:	5e                   	pop    %esi
801042af:	5f                   	pop    %edi
801042b0:	5d                   	pop    %ebp
801042b1:	c3                   	ret    
  return -1;
801042b2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801042b7:	eb 8d                	jmp    80104246 <kill+0x56>
801042b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801042c0 <kill_handler>:
void kill_handler(void){
801042c0:	55                   	push   %ebp
801042c1:	89 e5                	mov    %esp,%ebp
801042c3:	53                   	push   %ebx
801042c4:	83 ec 04             	sub    $0x4,%esp
  pushcli();
801042c7:	e8 74 06 00 00       	call   80104940 <pushcli>
  c = mycpu();
801042cc:	e8 df f4 ff ff       	call   801037b0 <mycpu>
  p = c->proc;
801042d1:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801042d7:	e8 a4 06 00 00       	call   80104980 <popcli>
  p->killed = 1;
801042dc:	c7 43 24 01 00 00 00 	movl   $0x1,0x24(%ebx)
}
801042e3:	83 c4 04             	add    $0x4,%esp
801042e6:	5b                   	pop    %ebx
801042e7:	5d                   	pop    %ebp
801042e8:	c3                   	ret    
801042e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801042f0 <procdump>:
{
801042f0:	55                   	push   %ebp
801042f1:	89 e5                	mov    %esp,%ebp
801042f3:	57                   	push   %edi
801042f4:	56                   	push   %esi
801042f5:	53                   	push   %ebx
801042f6:	8d 75 e8             	lea    -0x18(%ebp),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801042f9:	bb 54 3d 11 80       	mov    $0x80113d54,%ebx
{
801042fe:	83 ec 3c             	sub    $0x3c,%esp
80104301:	eb 27                	jmp    8010432a <procdump+0x3a>
80104303:	90                   	nop
80104304:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("\n");
80104308:	83 ec 0c             	sub    $0xc,%esp
8010430b:	68 23 80 10 80       	push   $0x80108023
80104310:	e8 4b c3 ff ff       	call   80100660 <cprintf>
80104315:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104318:	81 c3 9c 01 00 00    	add    $0x19c,%ebx
8010431e:	81 fb 54 a4 11 80    	cmp    $0x8011a454,%ebx
80104324:	0f 83 86 00 00 00    	jae    801043b0 <procdump+0xc0>
    if(p->state == UNUSED)
8010432a:	8b 43 0c             	mov    0xc(%ebx),%eax
8010432d:	85 c0                	test   %eax,%eax
8010432f:	74 e7                	je     80104318 <procdump+0x28>
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104331:	83 f8 05             	cmp    $0x5,%eax
      state = "???";
80104334:	ba d0 7c 10 80       	mov    $0x80107cd0,%edx
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104339:	77 11                	ja     8010434c <procdump+0x5c>
8010433b:	8b 14 85 08 7d 10 80 	mov    -0x7fef82f8(,%eax,4),%edx
      state = "???";
80104342:	b8 d0 7c 10 80       	mov    $0x80107cd0,%eax
80104347:	85 d2                	test   %edx,%edx
80104349:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
8010434c:	8d 43 6c             	lea    0x6c(%ebx),%eax
8010434f:	50                   	push   %eax
80104350:	52                   	push   %edx
80104351:	ff 73 10             	pushl  0x10(%ebx)
80104354:	68 d4 7c 10 80       	push   $0x80107cd4
80104359:	e8 02 c3 ff ff       	call   80100660 <cprintf>
    if(p->state == SLEEPING){
8010435e:	83 c4 10             	add    $0x10,%esp
80104361:	83 7b 0c 02          	cmpl   $0x2,0xc(%ebx)
80104365:	75 a1                	jne    80104308 <procdump+0x18>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80104367:	8d 45 c0             	lea    -0x40(%ebp),%eax
8010436a:	83 ec 08             	sub    $0x8,%esp
8010436d:	8d 7d c0             	lea    -0x40(%ebp),%edi
80104370:	50                   	push   %eax
80104371:	8b 43 1c             	mov    0x1c(%ebx),%eax
80104374:	8b 40 0c             	mov    0xc(%eax),%eax
80104377:	83 c0 08             	add    $0x8,%eax
8010437a:	50                   	push   %eax
8010437b:	e8 70 05 00 00       	call   801048f0 <getcallerpcs>
80104380:	83 c4 10             	add    $0x10,%esp
80104383:	90                   	nop
80104384:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      for(i=0; i<10 && pc[i] != 0; i++)
80104388:	8b 17                	mov    (%edi),%edx
8010438a:	85 d2                	test   %edx,%edx
8010438c:	0f 84 76 ff ff ff    	je     80104308 <procdump+0x18>
        cprintf(" %p", pc[i]);
80104392:	83 ec 08             	sub    $0x8,%esp
80104395:	83 c7 04             	add    $0x4,%edi
80104398:	52                   	push   %edx
80104399:	68 01 77 10 80       	push   $0x80107701
8010439e:	e8 bd c2 ff ff       	call   80100660 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
801043a3:	83 c4 10             	add    $0x10,%esp
801043a6:	39 fe                	cmp    %edi,%esi
801043a8:	75 de                	jne    80104388 <procdump+0x98>
801043aa:	e9 59 ff ff ff       	jmp    80104308 <procdump+0x18>
801043af:	90                   	nop
}
801043b0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801043b3:	5b                   	pop    %ebx
801043b4:	5e                   	pop    %esi
801043b5:	5f                   	pop    %edi
801043b6:	5d                   	pop    %ebp
801043b7:	c3                   	ret    
801043b8:	90                   	nop
801043b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801043c0 <sigprocmask>:
uint sigprocmask (uint sigmask){
801043c0:	55                   	push   %ebp
801043c1:	89 e5                	mov    %esp,%ebp
801043c3:	56                   	push   %esi
801043c4:	53                   	push   %ebx
801043c5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
801043c8:	e8 73 05 00 00       	call   80104940 <pushcli>
  c = mycpu();
801043cd:	e8 de f3 ff ff       	call   801037b0 <mycpu>
  p = c->proc;
801043d2:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
801043d8:	e8 a3 05 00 00       	call   80104980 <popcli>
  if (((sigmask & 1<<SIGKILL) == 1<<SIGKILL))
801043dd:	f7 c3 00 02 02 00    	test   $0x20200,%ebx
801043e3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801043e8:	75 0c                	jne    801043f6 <sigprocmask+0x36>
  uint oldmask = p->signal_mask;
801043ea:	8b 86 84 00 00 00    	mov    0x84(%esi),%eax
  p->signal_mask = sigmask;
801043f0:	89 9e 84 00 00 00    	mov    %ebx,0x84(%esi)
}
801043f6:	5b                   	pop    %ebx
801043f7:	5e                   	pop    %esi
801043f8:	5d                   	pop    %ebp
801043f9:	c3                   	ret    
801043fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104400 <sigaction>:
int sigaction(int signum , const struct sigaction *act, struct sigaction *oldact){
80104400:	55                   	push   %ebp
80104401:	89 e5                	mov    %esp,%ebp
80104403:	57                   	push   %edi
80104404:	56                   	push   %esi
80104405:	53                   	push   %ebx
80104406:	83 ec 0c             	sub    $0xc,%esp
80104409:	8b 75 08             	mov    0x8(%ebp),%esi
8010440c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  pushcli();
8010440f:	e8 2c 05 00 00       	call   80104940 <pushcli>
  c = mycpu();
80104414:	e8 97 f3 ff ff       	call   801037b0 <mycpu>
  p = c->proc;
80104419:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
8010441f:	e8 5c 05 00 00       	call   80104980 <popcli>
    if (signum > 31 || signum < 0 || signum == SIGSTOP || signum == SIGKILL)
80104424:	8d 46 f7             	lea    -0x9(%esi),%eax
80104427:	83 e0 f7             	and    $0xfffffff7,%eax
8010442a:	74 44                	je     80104470 <sigaction+0x70>
8010442c:	83 fe 1f             	cmp    $0x1f,%esi
8010442f:	77 3f                	ja     80104470 <sigaction+0x70>
    if (oldact != null){
80104431:	8b 45 10             	mov    0x10(%ebp),%eax
80104434:	85 c0                	test   %eax,%eax
80104436:	74 16                	je     8010444e <sigaction+0x4e>
      *oldact = p->signal_handlers[signum];
80104438:	8b 84 f3 8c 00 00 00 	mov    0x8c(%ebx,%esi,8),%eax
8010443f:	8b 94 f3 90 00 00 00 	mov    0x90(%ebx,%esi,8),%edx
80104446:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104449:	89 01                	mov    %eax,(%ecx)
8010444b:	89 51 04             	mov    %edx,0x4(%ecx)
    p->signal_handlers[signum].sa_handler = act->sa_handler;
8010444e:	8b 17                	mov    (%edi),%edx
80104450:	8d 04 f3             	lea    (%ebx,%esi,8),%eax
80104453:	89 90 8c 00 00 00    	mov    %edx,0x8c(%eax)
    p->signal_handlers[signum].sigmask = act->sigmask;
80104459:	8b 57 04             	mov    0x4(%edi),%edx
8010445c:	89 90 90 00 00 00    	mov    %edx,0x90(%eax)
    return 0;
80104462:	31 c0                	xor    %eax,%eax
}
80104464:	83 c4 0c             	add    $0xc,%esp
80104467:	5b                   	pop    %ebx
80104468:	5e                   	pop    %esi
80104469:	5f                   	pop    %edi
8010446a:	5d                   	pop    %ebp
8010446b:	c3                   	ret    
8010446c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      return -1;
80104470:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104475:	eb ed                	jmp    80104464 <sigaction+0x64>
80104477:	89 f6                	mov    %esi,%esi
80104479:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104480 <sigret>:
void sigret(void){
80104480:	55                   	push   %ebp
80104481:	89 e5                	mov    %esp,%ebp
80104483:	57                   	push   %edi
80104484:	56                   	push   %esi
80104485:	53                   	push   %ebx
80104486:	83 ec 0c             	sub    $0xc,%esp
  pushcli();
80104489:	e8 b2 04 00 00       	call   80104940 <pushcli>
  c = mycpu();
8010448e:	e8 1d f3 ff ff       	call   801037b0 <mycpu>
  p = c->proc;
80104493:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104499:	e8 e2 04 00 00       	call   80104980 <popcli>
  *p->tf = *p->backup; 
8010449e:	b9 13 00 00 00       	mov    $0x13,%ecx
801044a3:	8b 73 7c             	mov    0x7c(%ebx),%esi
801044a6:	8b 7b 18             	mov    0x18(%ebx),%edi
801044a9:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
   p->already_in_signal = 0;
801044ab:	c7 83 90 01 00 00 00 	movl   $0x0,0x190(%ebx)
801044b2:	00 00 00 
   p->signal_mask = p->signal_mask_backup;
801044b5:	8b 83 88 00 00 00    	mov    0x88(%ebx),%eax
801044bb:	89 83 84 00 00 00    	mov    %eax,0x84(%ebx)
}
801044c1:	83 c4 0c             	add    $0xc,%esp
801044c4:	5b                   	pop    %ebx
801044c5:	5e                   	pop    %esi
801044c6:	5f                   	pop    %edi
801044c7:	5d                   	pop    %ebp
801044c8:	c3                   	ret    
801044c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801044d0 <stop_handler>:
void stop_handler(void){
801044d0:	55                   	push   %ebp
801044d1:	89 e5                	mov    %esp,%ebp
801044d3:	53                   	push   %ebx
801044d4:	83 ec 04             	sub    $0x4,%esp
  pushcli();
801044d7:	e8 64 04 00 00       	call   80104940 <pushcli>
  c = mycpu();
801044dc:	e8 cf f2 ff ff       	call   801037b0 <mycpu>
  p = c->proc;
801044e1:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801044e7:	e8 94 04 00 00       	call   80104980 <popcli>
  p->suspended = 1;
801044ec:	c7 83 8c 01 00 00 01 	movl   $0x1,0x18c(%ebx)
801044f3:	00 00 00 
}
801044f6:	83 c4 04             	add    $0x4,%esp
801044f9:	5b                   	pop    %ebx
801044fa:	5d                   	pop    %ebp
  yield(); 
801044fb:	e9 80 fa ff ff       	jmp    80103f80 <yield>

80104500 <cont_handler>:
void cont_handler(void){
80104500:	55                   	push   %ebp
80104501:	89 e5                	mov    %esp,%ebp
80104503:	53                   	push   %ebx
80104504:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80104507:	e8 34 04 00 00       	call   80104940 <pushcli>
  c = mycpu();
8010450c:	e8 9f f2 ff ff       	call   801037b0 <mycpu>
  p = c->proc;
80104511:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104517:	e8 64 04 00 00       	call   80104980 <popcli>
  if (p-> suspended == 1)
8010451c:	83 bb 8c 01 00 00 01 	cmpl   $0x1,0x18c(%ebx)
80104523:	75 0a                	jne    8010452f <cont_handler+0x2f>
    p->suspended = 0; 
80104525:	c7 83 8c 01 00 00 00 	movl   $0x0,0x18c(%ebx)
8010452c:	00 00 00 
}
8010452f:	83 c4 04             	add    $0x4,%esp
80104532:	5b                   	pop    %ebx
80104533:	5d                   	pop    %ebp
80104534:	c3                   	ret    
80104535:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104539:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104540 <return_from_sig_stop_handler>:

void return_from_sig_stop_handler(void){
80104540:	55                   	push   %ebp
80104541:	89 e5                	mov    %esp,%ebp
80104543:	57                   	push   %edi
80104544:	56                   	push   %esi
80104545:	53                   	push   %ebx
80104546:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
80104549:	e8 f2 03 00 00       	call   80104940 <pushcli>
  c = mycpu();
8010454e:	e8 5d f2 ff ff       	call   801037b0 <mycpu>
  p = c->proc;
80104553:	8b b8 ac 00 00 00    	mov    0xac(%eax),%edi
  popcli();
80104559:	e8 22 04 00 00       	call   80104980 <popcli>
8010455e:	b8 01 00 00 00       	mov    $0x1,%eax
  struct proc *p = myproc();
  if (p == 0)
80104563:	85 ff                	test   %edi,%edi
80104565:	74 7b                	je     801045e2 <return_from_sig_stop_handler+0xa2>
    return; 
  int signal_index_in_stop;
  int is_blocked_in_stop;
  //check if p is suspended and has SIGCOUNT
  while(p->suspended){
80104567:	8b 97 8c 01 00 00    	mov    0x18c(%edi),%edx
8010456d:	85 d2                	test   %edx,%edx
8010456f:	74 71                	je     801045e2 <return_from_sig_stop_handler+0xa2>
     //cprintf("in return_from_sig_stop!!!!!" );
    for(int j=0; j<32; j=j+1){
80104571:	31 f6                	xor    %esi,%esi
80104573:	eb 15                	jmp    8010458a <return_from_sig_stop_handler+0x4a>
80104575:	8d 76 00             	lea    0x0(%esi),%esi
      if(((p->pending_signals & signal_index_in_stop) == signal_index_in_stop) & !is_blocked_in_stop ){
        if((j == SIGCONT) || ((int)p->signal_handlers[j].sa_handler == SIGCONT)){
            cont_handler();
            p->pending_signals = p->pending_signals & (~signal_index_in_stop); //discard signal
        }
        else if((j == SIGKILL) || ((int)p->signal_handlers[j].sa_handler == SIGKILL)){
80104578:	83 fe 09             	cmp    $0x9,%esi
8010457b:	74 73                	je     801045f0 <return_from_sig_stop_handler+0xb0>
8010457d:	83 fa 09             	cmp    $0x9,%edx
80104580:	74 6e                	je     801045f0 <return_from_sig_stop_handler+0xb0>
    for(int j=0; j<32; j=j+1){
80104582:	83 c6 01             	add    $0x1,%esi
80104585:	83 fe 20             	cmp    $0x20,%esi
80104588:	74 4e                	je     801045d8 <return_from_sig_stop_handler+0x98>
      if(((p->pending_signals & signal_index_in_stop) == signal_index_in_stop) & !is_blocked_in_stop ){
8010458a:	8b 97 80 00 00 00    	mov    0x80(%edi),%edx
      signal_index_in_stop = 1<<j; 
80104590:	89 c3                	mov    %eax,%ebx
80104592:	89 f1                	mov    %esi,%ecx
80104594:	d3 e3                	shl    %cl,%ebx
      if(((p->pending_signals & signal_index_in_stop) == signal_index_in_stop) & !is_blocked_in_stop ){
80104596:	21 da                	and    %ebx,%edx
80104598:	39 da                	cmp    %ebx,%edx
8010459a:	75 e6                	jne    80104582 <return_from_sig_stop_handler+0x42>
      is_blocked_in_stop = (p->signal_mask & signal_index_in_stop) == signal_index_in_stop;
8010459c:	8b 97 84 00 00 00    	mov    0x84(%edi),%edx
801045a2:	21 da                	and    %ebx,%edx
      if(((p->pending_signals & signal_index_in_stop) == signal_index_in_stop) & !is_blocked_in_stop ){
801045a4:	39 da                	cmp    %ebx,%edx
801045a6:	74 da                	je     80104582 <return_from_sig_stop_handler+0x42>
        if((j == SIGCONT) || ((int)p->signal_handlers[j].sa_handler == SIGCONT)){
801045a8:	83 fe 13             	cmp    $0x13,%esi
801045ab:	74 0c                	je     801045b9 <return_from_sig_stop_handler+0x79>
801045ad:	8b 94 f7 8c 00 00 00 	mov    0x8c(%edi,%esi,8),%edx
801045b4:	83 fa 13             	cmp    $0x13,%edx
801045b7:	75 bf                	jne    80104578 <return_from_sig_stop_handler+0x38>
    for(int j=0; j<32; j=j+1){
801045b9:	83 c6 01             	add    $0x1,%esi
801045bc:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            p->pending_signals = p->pending_signals & (~signal_index_in_stop); //discard signal
801045bf:	f7 d3                	not    %ebx
            cont_handler();
801045c1:	e8 3a ff ff ff       	call   80104500 <cont_handler>
            p->pending_signals = p->pending_signals & (~signal_index_in_stop); //discard signal
801045c6:	21 9f 80 00 00 00    	and    %ebx,0x80(%edi)
    for(int j=0; j<32; j=j+1){
801045cc:	83 fe 20             	cmp    $0x20,%esi
            p->pending_signals = p->pending_signals & (~signal_index_in_stop); //discard signal
801045cf:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    for(int j=0; j<32; j=j+1){
801045d2:	75 b6                	jne    8010458a <return_from_sig_stop_handler+0x4a>
801045d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            p->suspended = 0;
            p->pending_signals = p->pending_signals & (~signal_index_in_stop); //discard signal
        }
      }
    }
    if(p->suspended)
801045d8:	8b 8f 8c 01 00 00    	mov    0x18c(%edi),%ecx
801045de:	85 c9                	test   %ecx,%ecx
801045e0:	75 30                	jne    80104612 <return_from_sig_stop_handler+0xd2>
    yield();
  }
}
801045e2:	83 c4 1c             	add    $0x1c,%esp
801045e5:	5b                   	pop    %ebx
801045e6:	5e                   	pop    %esi
801045e7:	5f                   	pop    %edi
801045e8:	5d                   	pop    %ebp
801045e9:	c3                   	ret    
801045ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801045f0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            p->pending_signals = p->pending_signals & (~signal_index_in_stop); //discard signal
801045f3:	f7 d3                	not    %ebx
            kill_handler();
801045f5:	e8 c6 fc ff ff       	call   801042c0 <kill_handler>
            p->suspended = 0;
801045fa:	c7 87 8c 01 00 00 00 	movl   $0x0,0x18c(%edi)
80104601:	00 00 00 
            p->pending_signals = p->pending_signals & (~signal_index_in_stop); //discard signal
80104604:	21 9f 80 00 00 00    	and    %ebx,0x80(%edi)
8010460a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010460d:	e9 70 ff ff ff       	jmp    80104582 <return_from_sig_stop_handler+0x42>
80104612:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    yield();
80104615:	e8 66 f9 ff ff       	call   80103f80 <yield>
8010461a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010461d:	e9 45 ff ff ff       	jmp    80104567 <return_from_sig_stop_handler+0x27>
80104622:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104629:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104630 <default_handlers>:

void default_handlers(int i){
80104630:	55                   	push   %ebp
80104631:	89 e5                	mov    %esp,%ebp
80104633:	83 ec 08             	sub    $0x8,%esp
80104636:	8b 45 08             	mov    0x8(%ebp),%eax
  if(i == SIGCONT)
80104639:	83 f8 13             	cmp    $0x13,%eax
8010463c:	74 22                	je     80104660 <default_handlers+0x30>
    cont_handler();
  else if(i==SIGSTOP){
8010463e:	83 f8 11             	cmp    $0x11,%eax
80104641:	74 0d                	je     80104650 <default_handlers+0x20>
    stop_handler();
    return_from_sig_stop_handler();
  }
  else
    kill_handler();
}
80104643:	c9                   	leave  
    kill_handler();
80104644:	e9 77 fc ff ff       	jmp    801042c0 <kill_handler>
80104649:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    stop_handler();
80104650:	e8 7b fe ff ff       	call   801044d0 <stop_handler>
}
80104655:	c9                   	leave  
    return_from_sig_stop_handler();
80104656:	e9 e5 fe ff ff       	jmp    80104540 <return_from_sig_stop_handler>
8010465b:	90                   	nop
8010465c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
}
80104660:	c9                   	leave  
    cont_handler();
80104661:	e9 9a fe ff ff       	jmp    80104500 <cont_handler>
80104666:	8d 76 00             	lea    0x0(%esi),%esi
80104669:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104670 <check_for_signals>:

void check_for_signals(void){
80104670:	55                   	push   %ebp
80104671:	89 e5                	mov    %esp,%ebp
80104673:	57                   	push   %edi
80104674:	56                   	push   %esi
80104675:	53                   	push   %ebx
80104676:	83 ec 0c             	sub    $0xc,%esp
  pushcli();
80104679:	e8 c2 02 00 00       	call   80104940 <pushcli>
  c = mycpu();
8010467e:	e8 2d f1 ff ff       	call   801037b0 <mycpu>
  p = c->proc;
80104683:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80104689:	e8 f2 02 00 00       	call   80104980 <popcli>
  struct proc *p = myproc();
  if (p == 0)
8010468e:	85 f6                	test   %esi,%esi
80104690:	74 0a                	je     8010469c <check_for_signals+0x2c>
    return; 

  if(p->already_in_signal)
80104692:	8b 9e 90 01 00 00    	mov    0x190(%esi),%ebx
80104698:	85 db                	test   %ebx,%ebx
8010469a:	74 2c                	je     801046c8 <check_for_signals+0x58>
     }
    }
  }


}
8010469c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010469f:	5b                   	pop    %ebx
801046a0:	5e                   	pop    %esi
801046a1:	5f                   	pop    %edi
801046a2:	5d                   	pop    %ebp
801046a3:	c3                   	ret    
801046a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
          user_handlers(i, p);
801046a8:	83 ec 08             	sub    $0x8,%esp
          p->already_in_signal = 1; 
801046ab:	c7 86 90 01 00 00 01 	movl   $0x1,0x190(%esi)
801046b2:	00 00 00 
          user_handlers(i, p);
801046b5:	56                   	push   %esi
801046b6:	53                   	push   %ebx
801046b7:	e8 04 f0 ff ff       	call   801036c0 <user_handlers>
801046bc:	83 c4 10             	add    $0x10,%esp
801046bf:	90                   	nop
  for(int i=0; i<32; i=i+1){
801046c0:	83 c3 01             	add    $0x1,%ebx
801046c3:	83 fb 20             	cmp    $0x20,%ebx
801046c6:	74 d4                	je     8010469c <check_for_signals+0x2c>
    signal_index = 1<<i; 
801046c8:	89 d9                	mov    %ebx,%ecx
801046ca:	b8 01 00 00 00       	mov    $0x1,%eax
    is_blocked = (p->signal_mask & signal_index) == signal_index; //check if signal is blocked 
801046cf:	8b 96 84 00 00 00    	mov    0x84(%esi),%edx
    signal_index = 1<<i; 
801046d5:	d3 e0                	shl    %cl,%eax
    if(((p->pending_signals & signal_index) == signal_index) & !is_blocked){
801046d7:	8b 8e 80 00 00 00    	mov    0x80(%esi),%ecx
801046dd:	89 c7                	mov    %eax,%edi
801046df:	21 cf                	and    %ecx,%edi
801046e1:	39 c7                	cmp    %eax,%edi
801046e3:	75 db                	jne    801046c0 <check_for_signals+0x50>
    is_blocked = (p->signal_mask & signal_index) == signal_index; //check if signal is blocked 
801046e5:	89 d7                	mov    %edx,%edi
801046e7:	21 c7                	and    %eax,%edi
    if(((p->pending_signals & signal_index) == signal_index) & !is_blocked){
801046e9:	39 c7                	cmp    %eax,%edi
801046eb:	74 d3                	je     801046c0 <check_for_signals+0x50>
      p->pending_signals = p->pending_signals & (~signal_index); //discard signal
801046ed:	f7 d0                	not    %eax
801046ef:	21 c8                	and    %ecx,%eax
801046f1:	89 86 80 00 00 00    	mov    %eax,0x80(%esi)
      if(p->signal_handlers[i].sa_handler != (void*)SIG_IGN){
801046f7:	8b 84 de 8c 00 00 00 	mov    0x8c(%esi,%ebx,8),%eax
801046fe:	83 f8 01             	cmp    $0x1,%eax
80104701:	74 bd                	je     801046c0 <check_for_signals+0x50>
        p->signal_mask_backup = p->signal_mask;
80104703:	89 96 88 00 00 00    	mov    %edx,0x88(%esi)
        p->signal_mask = p->signal_handlers[i].sigmask;
80104709:	8b 94 de 90 00 00 00 	mov    0x90(%esi,%ebx,8),%edx
        if (p->signal_handlers[i].sa_handler == SIG_DFL){
80104710:	85 c0                	test   %eax,%eax
        p->signal_mask = p->signal_handlers[i].sigmask;
80104712:	89 96 84 00 00 00    	mov    %edx,0x84(%esi)
        if (p->signal_handlers[i].sa_handler == SIG_DFL){
80104718:	74 26                	je     80104740 <check_for_signals+0xd0>
        else if ((int)p->signal_handlers[i].sa_handler == SIGSTOP){
8010471a:	83 f8 11             	cmp    $0x11,%eax
8010471d:	74 41                	je     80104760 <check_for_signals+0xf0>
        else if ((int)p->signal_handlers[i].sa_handler == SIGKILL){
8010471f:	83 f8 09             	cmp    $0x9,%eax
80104722:	74 5c                	je     80104780 <check_for_signals+0x110>
        else if ((int)p->signal_handlers[i].sa_handler == SIGCONT){
80104724:	83 f8 13             	cmp    $0x13,%eax
80104727:	0f 85 7b ff ff ff    	jne    801046a8 <check_for_signals+0x38>
          cont_handler();
8010472d:	e8 ce fd ff ff       	call   80104500 <cont_handler>
          p->signal_mask = p->signal_mask_backup;
80104732:	8b 86 88 00 00 00    	mov    0x88(%esi),%eax
80104738:	89 86 84 00 00 00    	mov    %eax,0x84(%esi)
8010473e:	eb 80                	jmp    801046c0 <check_for_signals+0x50>
          default_handlers(i);
80104740:	83 ec 0c             	sub    $0xc,%esp
80104743:	53                   	push   %ebx
80104744:	e8 e7 fe ff ff       	call   80104630 <default_handlers>
          p->signal_mask = p->signal_mask_backup;
80104749:	8b 86 88 00 00 00    	mov    0x88(%esi),%eax
8010474f:	83 c4 10             	add    $0x10,%esp
80104752:	89 86 84 00 00 00    	mov    %eax,0x84(%esi)
80104758:	e9 63 ff ff ff       	jmp    801046c0 <check_for_signals+0x50>
8010475d:	8d 76 00             	lea    0x0(%esi),%esi
          stop_handler();
80104760:	e8 6b fd ff ff       	call   801044d0 <stop_handler>
          p->signal_mask = p->signal_mask_backup;
80104765:	8b 86 88 00 00 00    	mov    0x88(%esi),%eax
8010476b:	89 86 84 00 00 00    	mov    %eax,0x84(%esi)
          return_from_sig_stop_handler();
80104771:	e8 ca fd ff ff       	call   80104540 <return_from_sig_stop_handler>
80104776:	e9 45 ff ff ff       	jmp    801046c0 <check_for_signals+0x50>
8010477b:	90                   	nop
8010477c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
          kill_handler();
80104780:	e8 3b fb ff ff       	call   801042c0 <kill_handler>
          p->signal_mask = p->signal_mask_backup;
80104785:	8b 86 88 00 00 00    	mov    0x88(%esi),%eax
8010478b:	89 86 84 00 00 00    	mov    %eax,0x84(%esi)
80104791:	e9 2a ff ff ff       	jmp    801046c0 <check_for_signals+0x50>
80104796:	66 90                	xchg   %ax,%ax
80104798:	66 90                	xchg   %ax,%ax
8010479a:	66 90                	xchg   %ax,%ax
8010479c:	66 90                	xchg   %ax,%ax
8010479e:	66 90                	xchg   %ax,%ax

801047a0 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
801047a0:	55                   	push   %ebp
801047a1:	89 e5                	mov    %esp,%ebp
801047a3:	53                   	push   %ebx
801047a4:	83 ec 0c             	sub    $0xc,%esp
801047a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
801047aa:	68 20 7d 10 80       	push   $0x80107d20
801047af:	8d 43 04             	lea    0x4(%ebx),%eax
801047b2:	50                   	push   %eax
801047b3:	e8 18 01 00 00       	call   801048d0 <initlock>
  lk->name = name;
801047b8:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
801047bb:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
801047c1:	83 c4 10             	add    $0x10,%esp
  lk->pid = 0;
801047c4:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
801047cb:	89 43 38             	mov    %eax,0x38(%ebx)
}
801047ce:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801047d1:	c9                   	leave  
801047d2:	c3                   	ret    
801047d3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801047d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801047e0 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
801047e0:	55                   	push   %ebp
801047e1:	89 e5                	mov    %esp,%ebp
801047e3:	56                   	push   %esi
801047e4:	53                   	push   %ebx
801047e5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
801047e8:	83 ec 0c             	sub    $0xc,%esp
801047eb:	8d 73 04             	lea    0x4(%ebx),%esi
801047ee:	56                   	push   %esi
801047ef:	e8 1c 02 00 00       	call   80104a10 <acquire>
  while (lk->locked) {
801047f4:	8b 13                	mov    (%ebx),%edx
801047f6:	83 c4 10             	add    $0x10,%esp
801047f9:	85 d2                	test   %edx,%edx
801047fb:	74 16                	je     80104813 <acquiresleep+0x33>
801047fd:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
80104800:	83 ec 08             	sub    $0x8,%esp
80104803:	56                   	push   %esi
80104804:	53                   	push   %ebx
80104805:	e8 c6 f7 ff ff       	call   80103fd0 <sleep>
  while (lk->locked) {
8010480a:	8b 03                	mov    (%ebx),%eax
8010480c:	83 c4 10             	add    $0x10,%esp
8010480f:	85 c0                	test   %eax,%eax
80104811:	75 ed                	jne    80104800 <acquiresleep+0x20>
  }
  lk->locked = 1;
80104813:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80104819:	e8 32 f0 ff ff       	call   80103850 <myproc>
8010481e:	8b 40 10             	mov    0x10(%eax),%eax
80104821:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80104824:	89 75 08             	mov    %esi,0x8(%ebp)
}
80104827:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010482a:	5b                   	pop    %ebx
8010482b:	5e                   	pop    %esi
8010482c:	5d                   	pop    %ebp
  release(&lk->lk);
8010482d:	e9 9e 02 00 00       	jmp    80104ad0 <release>
80104832:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104839:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104840 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
80104840:	55                   	push   %ebp
80104841:	89 e5                	mov    %esp,%ebp
80104843:	56                   	push   %esi
80104844:	53                   	push   %ebx
80104845:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104848:	83 ec 0c             	sub    $0xc,%esp
8010484b:	8d 73 04             	lea    0x4(%ebx),%esi
8010484e:	56                   	push   %esi
8010484f:	e8 bc 01 00 00       	call   80104a10 <acquire>
  lk->locked = 0;
80104854:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
8010485a:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80104861:	89 1c 24             	mov    %ebx,(%esp)
80104864:	e8 67 f9 ff ff       	call   801041d0 <wakeup>
  release(&lk->lk);
80104869:	89 75 08             	mov    %esi,0x8(%ebp)
8010486c:	83 c4 10             	add    $0x10,%esp
}
8010486f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104872:	5b                   	pop    %ebx
80104873:	5e                   	pop    %esi
80104874:	5d                   	pop    %ebp
  release(&lk->lk);
80104875:	e9 56 02 00 00       	jmp    80104ad0 <release>
8010487a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104880 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
80104880:	55                   	push   %ebp
80104881:	89 e5                	mov    %esp,%ebp
80104883:	57                   	push   %edi
80104884:	56                   	push   %esi
80104885:	53                   	push   %ebx
80104886:	31 ff                	xor    %edi,%edi
80104888:	83 ec 18             	sub    $0x18,%esp
8010488b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  
  acquire(&lk->lk);
8010488e:	8d 73 04             	lea    0x4(%ebx),%esi
80104891:	56                   	push   %esi
80104892:	e8 79 01 00 00       	call   80104a10 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
80104897:	8b 03                	mov    (%ebx),%eax
80104899:	83 c4 10             	add    $0x10,%esp
8010489c:	85 c0                	test   %eax,%eax
8010489e:	74 13                	je     801048b3 <holdingsleep+0x33>
801048a0:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
801048a3:	e8 a8 ef ff ff       	call   80103850 <myproc>
801048a8:	39 58 10             	cmp    %ebx,0x10(%eax)
801048ab:	0f 94 c0             	sete   %al
801048ae:	0f b6 c0             	movzbl %al,%eax
801048b1:	89 c7                	mov    %eax,%edi
  release(&lk->lk);
801048b3:	83 ec 0c             	sub    $0xc,%esp
801048b6:	56                   	push   %esi
801048b7:	e8 14 02 00 00       	call   80104ad0 <release>
  return r;
}
801048bc:	8d 65 f4             	lea    -0xc(%ebp),%esp
801048bf:	89 f8                	mov    %edi,%eax
801048c1:	5b                   	pop    %ebx
801048c2:	5e                   	pop    %esi
801048c3:	5f                   	pop    %edi
801048c4:	5d                   	pop    %ebp
801048c5:	c3                   	ret    
801048c6:	66 90                	xchg   %ax,%ax
801048c8:	66 90                	xchg   %ax,%ax
801048ca:	66 90                	xchg   %ax,%ax
801048cc:	66 90                	xchg   %ax,%ax
801048ce:	66 90                	xchg   %ax,%ax

801048d0 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
801048d0:	55                   	push   %ebp
801048d1:	89 e5                	mov    %esp,%ebp
801048d3:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
801048d6:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
801048d9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
801048df:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
801048e2:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
801048e9:	5d                   	pop    %ebp
801048ea:	c3                   	ret    
801048eb:	90                   	nop
801048ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801048f0 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
801048f0:	55                   	push   %ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
801048f1:	31 d2                	xor    %edx,%edx
{
801048f3:	89 e5                	mov    %esp,%ebp
801048f5:	53                   	push   %ebx
  ebp = (uint*)v - 2;
801048f6:	8b 45 08             	mov    0x8(%ebp),%eax
{
801048f9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  ebp = (uint*)v - 2;
801048fc:	83 e8 08             	sub    $0x8,%eax
801048ff:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104900:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
80104906:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
8010490c:	77 1a                	ja     80104928 <getcallerpcs+0x38>
      break;
    pcs[i] = ebp[1];     // saved %eip
8010490e:	8b 58 04             	mov    0x4(%eax),%ebx
80104911:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
80104914:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
80104917:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80104919:	83 fa 0a             	cmp    $0xa,%edx
8010491c:	75 e2                	jne    80104900 <getcallerpcs+0x10>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
8010491e:	5b                   	pop    %ebx
8010491f:	5d                   	pop    %ebp
80104920:	c3                   	ret    
80104921:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104928:	8d 04 91             	lea    (%ecx,%edx,4),%eax
8010492b:	83 c1 28             	add    $0x28,%ecx
8010492e:	66 90                	xchg   %ax,%ax
    pcs[i] = 0;
80104930:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104936:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
80104939:	39 c1                	cmp    %eax,%ecx
8010493b:	75 f3                	jne    80104930 <getcallerpcs+0x40>
}
8010493d:	5b                   	pop    %ebx
8010493e:	5d                   	pop    %ebp
8010493f:	c3                   	ret    

80104940 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80104940:	55                   	push   %ebp
80104941:	89 e5                	mov    %esp,%ebp
80104943:	53                   	push   %ebx
80104944:	83 ec 04             	sub    $0x4,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104947:	9c                   	pushf  
80104948:	5b                   	pop    %ebx
  asm volatile("cli");
80104949:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
8010494a:	e8 61 ee ff ff       	call   801037b0 <mycpu>
8010494f:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80104955:	85 c0                	test   %eax,%eax
80104957:	75 11                	jne    8010496a <pushcli+0x2a>
    mycpu()->intena = eflags & FL_IF;
80104959:	81 e3 00 02 00 00    	and    $0x200,%ebx
8010495f:	e8 4c ee ff ff       	call   801037b0 <mycpu>
80104964:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
  mycpu()->ncli += 1;
8010496a:	e8 41 ee ff ff       	call   801037b0 <mycpu>
8010496f:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
80104976:	83 c4 04             	add    $0x4,%esp
80104979:	5b                   	pop    %ebx
8010497a:	5d                   	pop    %ebp
8010497b:	c3                   	ret    
8010497c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104980 <popcli>:

void
popcli(void)
{
80104980:	55                   	push   %ebp
80104981:	89 e5                	mov    %esp,%ebp
80104983:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104986:	9c                   	pushf  
80104987:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104988:	f6 c4 02             	test   $0x2,%ah
8010498b:	75 35                	jne    801049c2 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
8010498d:	e8 1e ee ff ff       	call   801037b0 <mycpu>
80104992:	83 a8 a4 00 00 00 01 	subl   $0x1,0xa4(%eax)
80104999:	78 34                	js     801049cf <popcli+0x4f>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
8010499b:	e8 10 ee ff ff       	call   801037b0 <mycpu>
801049a0:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
801049a6:	85 d2                	test   %edx,%edx
801049a8:	74 06                	je     801049b0 <popcli+0x30>
    sti();
}
801049aa:	c9                   	leave  
801049ab:	c3                   	ret    
801049ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(mycpu()->ncli == 0 && mycpu()->intena)
801049b0:	e8 fb ed ff ff       	call   801037b0 <mycpu>
801049b5:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
801049bb:	85 c0                	test   %eax,%eax
801049bd:	74 eb                	je     801049aa <popcli+0x2a>
  asm volatile("sti");
801049bf:	fb                   	sti    
}
801049c0:	c9                   	leave  
801049c1:	c3                   	ret    
    panic("popcli - interruptible");
801049c2:	83 ec 0c             	sub    $0xc,%esp
801049c5:	68 2b 7d 10 80       	push   $0x80107d2b
801049ca:	e8 c1 b9 ff ff       	call   80100390 <panic>
    panic("popcli");
801049cf:	83 ec 0c             	sub    $0xc,%esp
801049d2:	68 42 7d 10 80       	push   $0x80107d42
801049d7:	e8 b4 b9 ff ff       	call   80100390 <panic>
801049dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801049e0 <holding>:
{
801049e0:	55                   	push   %ebp
801049e1:	89 e5                	mov    %esp,%ebp
801049e3:	56                   	push   %esi
801049e4:	53                   	push   %ebx
801049e5:	8b 75 08             	mov    0x8(%ebp),%esi
801049e8:	31 db                	xor    %ebx,%ebx
  pushcli();
801049ea:	e8 51 ff ff ff       	call   80104940 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
801049ef:	8b 06                	mov    (%esi),%eax
801049f1:	85 c0                	test   %eax,%eax
801049f3:	74 10                	je     80104a05 <holding+0x25>
801049f5:	8b 5e 08             	mov    0x8(%esi),%ebx
801049f8:	e8 b3 ed ff ff       	call   801037b0 <mycpu>
801049fd:	39 c3                	cmp    %eax,%ebx
801049ff:	0f 94 c3             	sete   %bl
80104a02:	0f b6 db             	movzbl %bl,%ebx
  popcli();
80104a05:	e8 76 ff ff ff       	call   80104980 <popcli>
}
80104a0a:	89 d8                	mov    %ebx,%eax
80104a0c:	5b                   	pop    %ebx
80104a0d:	5e                   	pop    %esi
80104a0e:	5d                   	pop    %ebp
80104a0f:	c3                   	ret    

80104a10 <acquire>:
{
80104a10:	55                   	push   %ebp
80104a11:	89 e5                	mov    %esp,%ebp
80104a13:	56                   	push   %esi
80104a14:	53                   	push   %ebx
  pushcli(); // disable interrupts to avoid deadlock.
80104a15:	e8 26 ff ff ff       	call   80104940 <pushcli>
  if(holding(lk))
80104a1a:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104a1d:	83 ec 0c             	sub    $0xc,%esp
80104a20:	53                   	push   %ebx
80104a21:	e8 ba ff ff ff       	call   801049e0 <holding>
80104a26:	83 c4 10             	add    $0x10,%esp
80104a29:	85 c0                	test   %eax,%eax
80104a2b:	0f 85 83 00 00 00    	jne    80104ab4 <acquire+0xa4>
80104a31:	89 c6                	mov    %eax,%esi
  asm volatile("lock; xchgl %0, %1" :
80104a33:	ba 01 00 00 00       	mov    $0x1,%edx
80104a38:	eb 09                	jmp    80104a43 <acquire+0x33>
80104a3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104a40:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104a43:	89 d0                	mov    %edx,%eax
80104a45:	f0 87 03             	lock xchg %eax,(%ebx)
  while(xchg(&lk->locked, 1) != 0)
80104a48:	85 c0                	test   %eax,%eax
80104a4a:	75 f4                	jne    80104a40 <acquire+0x30>
  __sync_synchronize();
80104a4c:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
80104a51:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104a54:	e8 57 ed ff ff       	call   801037b0 <mycpu>
  getcallerpcs(&lk, lk->pcs);
80104a59:	8d 53 0c             	lea    0xc(%ebx),%edx
  lk->cpu = mycpu();
80104a5c:	89 43 08             	mov    %eax,0x8(%ebx)
  ebp = (uint*)v - 2;
80104a5f:	89 e8                	mov    %ebp,%eax
80104a61:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104a68:	8d 88 00 00 00 80    	lea    -0x80000000(%eax),%ecx
80104a6e:	81 f9 fe ff ff 7f    	cmp    $0x7ffffffe,%ecx
80104a74:	77 1a                	ja     80104a90 <acquire+0x80>
    pcs[i] = ebp[1];     // saved %eip
80104a76:	8b 48 04             	mov    0x4(%eax),%ecx
80104a79:	89 0c b2             	mov    %ecx,(%edx,%esi,4)
  for(i = 0; i < 10; i++){
80104a7c:	83 c6 01             	add    $0x1,%esi
    ebp = (uint*)ebp[0]; // saved %ebp
80104a7f:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80104a81:	83 fe 0a             	cmp    $0xa,%esi
80104a84:	75 e2                	jne    80104a68 <acquire+0x58>
}
80104a86:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104a89:	5b                   	pop    %ebx
80104a8a:	5e                   	pop    %esi
80104a8b:	5d                   	pop    %ebp
80104a8c:	c3                   	ret    
80104a8d:	8d 76 00             	lea    0x0(%esi),%esi
80104a90:	8d 04 b2             	lea    (%edx,%esi,4),%eax
80104a93:	83 c2 28             	add    $0x28,%edx
80104a96:	8d 76 00             	lea    0x0(%esi),%esi
80104a99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    pcs[i] = 0;
80104aa0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104aa6:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
80104aa9:	39 d0                	cmp    %edx,%eax
80104aab:	75 f3                	jne    80104aa0 <acquire+0x90>
}
80104aad:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104ab0:	5b                   	pop    %ebx
80104ab1:	5e                   	pop    %esi
80104ab2:	5d                   	pop    %ebp
80104ab3:	c3                   	ret    
    panic("acquire");
80104ab4:	83 ec 0c             	sub    $0xc,%esp
80104ab7:	68 49 7d 10 80       	push   $0x80107d49
80104abc:	e8 cf b8 ff ff       	call   80100390 <panic>
80104ac1:	eb 0d                	jmp    80104ad0 <release>
80104ac3:	90                   	nop
80104ac4:	90                   	nop
80104ac5:	90                   	nop
80104ac6:	90                   	nop
80104ac7:	90                   	nop
80104ac8:	90                   	nop
80104ac9:	90                   	nop
80104aca:	90                   	nop
80104acb:	90                   	nop
80104acc:	90                   	nop
80104acd:	90                   	nop
80104ace:	90                   	nop
80104acf:	90                   	nop

80104ad0 <release>:
{
80104ad0:	55                   	push   %ebp
80104ad1:	89 e5                	mov    %esp,%ebp
80104ad3:	53                   	push   %ebx
80104ad4:	83 ec 10             	sub    $0x10,%esp
80104ad7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holding(lk))
80104ada:	53                   	push   %ebx
80104adb:	e8 00 ff ff ff       	call   801049e0 <holding>
80104ae0:	83 c4 10             	add    $0x10,%esp
80104ae3:	85 c0                	test   %eax,%eax
80104ae5:	74 22                	je     80104b09 <release+0x39>
  lk->pcs[0] = 0;
80104ae7:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
80104aee:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
80104af5:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
80104afa:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
80104b00:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104b03:	c9                   	leave  
  popcli();
80104b04:	e9 77 fe ff ff       	jmp    80104980 <popcli>
    panic("release");
80104b09:	83 ec 0c             	sub    $0xc,%esp
80104b0c:	68 51 7d 10 80       	push   $0x80107d51
80104b11:	e8 7a b8 ff ff       	call   80100390 <panic>
80104b16:	66 90                	xchg   %ax,%ax
80104b18:	66 90                	xchg   %ax,%ax
80104b1a:	66 90                	xchg   %ax,%ax
80104b1c:	66 90                	xchg   %ax,%ax
80104b1e:	66 90                	xchg   %ax,%ax

80104b20 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80104b20:	55                   	push   %ebp
80104b21:	89 e5                	mov    %esp,%ebp
80104b23:	57                   	push   %edi
80104b24:	53                   	push   %ebx
80104b25:	8b 55 08             	mov    0x8(%ebp),%edx
80104b28:	8b 4d 10             	mov    0x10(%ebp),%ecx
  if ((int)dst%4 == 0 && n%4 == 0){
80104b2b:	f6 c2 03             	test   $0x3,%dl
80104b2e:	75 05                	jne    80104b35 <memset+0x15>
80104b30:	f6 c1 03             	test   $0x3,%cl
80104b33:	74 13                	je     80104b48 <memset+0x28>
  asm volatile("cld; rep stosb" :
80104b35:	89 d7                	mov    %edx,%edi
80104b37:	8b 45 0c             	mov    0xc(%ebp),%eax
80104b3a:	fc                   	cld    
80104b3b:	f3 aa                	rep stos %al,%es:(%edi)
    c &= 0xFF;
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
80104b3d:	5b                   	pop    %ebx
80104b3e:	89 d0                	mov    %edx,%eax
80104b40:	5f                   	pop    %edi
80104b41:	5d                   	pop    %ebp
80104b42:	c3                   	ret    
80104b43:	90                   	nop
80104b44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c &= 0xFF;
80104b48:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
80104b4c:	c1 e9 02             	shr    $0x2,%ecx
80104b4f:	89 f8                	mov    %edi,%eax
80104b51:	89 fb                	mov    %edi,%ebx
80104b53:	c1 e0 18             	shl    $0x18,%eax
80104b56:	c1 e3 10             	shl    $0x10,%ebx
80104b59:	09 d8                	or     %ebx,%eax
80104b5b:	09 f8                	or     %edi,%eax
80104b5d:	c1 e7 08             	shl    $0x8,%edi
80104b60:	09 f8                	or     %edi,%eax
  asm volatile("cld; rep stosl" :
80104b62:	89 d7                	mov    %edx,%edi
80104b64:	fc                   	cld    
80104b65:	f3 ab                	rep stos %eax,%es:(%edi)
}
80104b67:	5b                   	pop    %ebx
80104b68:	89 d0                	mov    %edx,%eax
80104b6a:	5f                   	pop    %edi
80104b6b:	5d                   	pop    %ebp
80104b6c:	c3                   	ret    
80104b6d:	8d 76 00             	lea    0x0(%esi),%esi

80104b70 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80104b70:	55                   	push   %ebp
80104b71:	89 e5                	mov    %esp,%ebp
80104b73:	57                   	push   %edi
80104b74:	56                   	push   %esi
80104b75:	53                   	push   %ebx
80104b76:	8b 5d 10             	mov    0x10(%ebp),%ebx
80104b79:	8b 75 08             	mov    0x8(%ebp),%esi
80104b7c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
80104b7f:	85 db                	test   %ebx,%ebx
80104b81:	74 29                	je     80104bac <memcmp+0x3c>
    if(*s1 != *s2)
80104b83:	0f b6 16             	movzbl (%esi),%edx
80104b86:	0f b6 0f             	movzbl (%edi),%ecx
80104b89:	38 d1                	cmp    %dl,%cl
80104b8b:	75 2b                	jne    80104bb8 <memcmp+0x48>
80104b8d:	b8 01 00 00 00       	mov    $0x1,%eax
80104b92:	eb 14                	jmp    80104ba8 <memcmp+0x38>
80104b94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104b98:	0f b6 14 06          	movzbl (%esi,%eax,1),%edx
80104b9c:	83 c0 01             	add    $0x1,%eax
80104b9f:	0f b6 4c 07 ff       	movzbl -0x1(%edi,%eax,1),%ecx
80104ba4:	38 ca                	cmp    %cl,%dl
80104ba6:	75 10                	jne    80104bb8 <memcmp+0x48>
  while(n-- > 0){
80104ba8:	39 d8                	cmp    %ebx,%eax
80104baa:	75 ec                	jne    80104b98 <memcmp+0x28>
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
}
80104bac:	5b                   	pop    %ebx
  return 0;
80104bad:	31 c0                	xor    %eax,%eax
}
80104baf:	5e                   	pop    %esi
80104bb0:	5f                   	pop    %edi
80104bb1:	5d                   	pop    %ebp
80104bb2:	c3                   	ret    
80104bb3:	90                   	nop
80104bb4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      return *s1 - *s2;
80104bb8:	0f b6 c2             	movzbl %dl,%eax
}
80104bbb:	5b                   	pop    %ebx
      return *s1 - *s2;
80104bbc:	29 c8                	sub    %ecx,%eax
}
80104bbe:	5e                   	pop    %esi
80104bbf:	5f                   	pop    %edi
80104bc0:	5d                   	pop    %ebp
80104bc1:	c3                   	ret    
80104bc2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104bc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104bd0 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80104bd0:	55                   	push   %ebp
80104bd1:	89 e5                	mov    %esp,%ebp
80104bd3:	56                   	push   %esi
80104bd4:	53                   	push   %ebx
80104bd5:	8b 45 08             	mov    0x8(%ebp),%eax
80104bd8:	8b 5d 0c             	mov    0xc(%ebp),%ebx
80104bdb:	8b 75 10             	mov    0x10(%ebp),%esi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
80104bde:	39 c3                	cmp    %eax,%ebx
80104be0:	73 26                	jae    80104c08 <memmove+0x38>
80104be2:	8d 0c 33             	lea    (%ebx,%esi,1),%ecx
80104be5:	39 c8                	cmp    %ecx,%eax
80104be7:	73 1f                	jae    80104c08 <memmove+0x38>
    s += n;
    d += n;
    while(n-- > 0)
80104be9:	85 f6                	test   %esi,%esi
80104beb:	8d 56 ff             	lea    -0x1(%esi),%edx
80104bee:	74 0f                	je     80104bff <memmove+0x2f>
      *--d = *--s;
80104bf0:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
80104bf4:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    while(n-- > 0)
80104bf7:	83 ea 01             	sub    $0x1,%edx
80104bfa:	83 fa ff             	cmp    $0xffffffff,%edx
80104bfd:	75 f1                	jne    80104bf0 <memmove+0x20>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
80104bff:	5b                   	pop    %ebx
80104c00:	5e                   	pop    %esi
80104c01:	5d                   	pop    %ebp
80104c02:	c3                   	ret    
80104c03:	90                   	nop
80104c04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    while(n-- > 0)
80104c08:	31 d2                	xor    %edx,%edx
80104c0a:	85 f6                	test   %esi,%esi
80104c0c:	74 f1                	je     80104bff <memmove+0x2f>
80104c0e:	66 90                	xchg   %ax,%ax
      *d++ = *s++;
80104c10:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
80104c14:	88 0c 10             	mov    %cl,(%eax,%edx,1)
80104c17:	83 c2 01             	add    $0x1,%edx
    while(n-- > 0)
80104c1a:	39 d6                	cmp    %edx,%esi
80104c1c:	75 f2                	jne    80104c10 <memmove+0x40>
}
80104c1e:	5b                   	pop    %ebx
80104c1f:	5e                   	pop    %esi
80104c20:	5d                   	pop    %ebp
80104c21:	c3                   	ret    
80104c22:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104c29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104c30 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
80104c30:	55                   	push   %ebp
80104c31:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
}
80104c33:	5d                   	pop    %ebp
  return memmove(dst, src, n);
80104c34:	eb 9a                	jmp    80104bd0 <memmove>
80104c36:	8d 76 00             	lea    0x0(%esi),%esi
80104c39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104c40 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
80104c40:	55                   	push   %ebp
80104c41:	89 e5                	mov    %esp,%ebp
80104c43:	57                   	push   %edi
80104c44:	56                   	push   %esi
80104c45:	8b 7d 10             	mov    0x10(%ebp),%edi
80104c48:	53                   	push   %ebx
80104c49:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104c4c:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(n > 0 && *p && *p == *q)
80104c4f:	85 ff                	test   %edi,%edi
80104c51:	74 2f                	je     80104c82 <strncmp+0x42>
80104c53:	0f b6 01             	movzbl (%ecx),%eax
80104c56:	0f b6 1e             	movzbl (%esi),%ebx
80104c59:	84 c0                	test   %al,%al
80104c5b:	74 37                	je     80104c94 <strncmp+0x54>
80104c5d:	38 c3                	cmp    %al,%bl
80104c5f:	75 33                	jne    80104c94 <strncmp+0x54>
80104c61:	01 f7                	add    %esi,%edi
80104c63:	eb 13                	jmp    80104c78 <strncmp+0x38>
80104c65:	8d 76 00             	lea    0x0(%esi),%esi
80104c68:	0f b6 01             	movzbl (%ecx),%eax
80104c6b:	84 c0                	test   %al,%al
80104c6d:	74 21                	je     80104c90 <strncmp+0x50>
80104c6f:	0f b6 1a             	movzbl (%edx),%ebx
80104c72:	89 d6                	mov    %edx,%esi
80104c74:	38 d8                	cmp    %bl,%al
80104c76:	75 1c                	jne    80104c94 <strncmp+0x54>
    n--, p++, q++;
80104c78:	8d 56 01             	lea    0x1(%esi),%edx
80104c7b:	83 c1 01             	add    $0x1,%ecx
  while(n > 0 && *p && *p == *q)
80104c7e:	39 fa                	cmp    %edi,%edx
80104c80:	75 e6                	jne    80104c68 <strncmp+0x28>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
}
80104c82:	5b                   	pop    %ebx
    return 0;
80104c83:	31 c0                	xor    %eax,%eax
}
80104c85:	5e                   	pop    %esi
80104c86:	5f                   	pop    %edi
80104c87:	5d                   	pop    %ebp
80104c88:	c3                   	ret    
80104c89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104c90:	0f b6 5e 01          	movzbl 0x1(%esi),%ebx
  return (uchar)*p - (uchar)*q;
80104c94:	29 d8                	sub    %ebx,%eax
}
80104c96:	5b                   	pop    %ebx
80104c97:	5e                   	pop    %esi
80104c98:	5f                   	pop    %edi
80104c99:	5d                   	pop    %ebp
80104c9a:	c3                   	ret    
80104c9b:	90                   	nop
80104c9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104ca0 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80104ca0:	55                   	push   %ebp
80104ca1:	89 e5                	mov    %esp,%ebp
80104ca3:	56                   	push   %esi
80104ca4:	53                   	push   %ebx
80104ca5:	8b 45 08             	mov    0x8(%ebp),%eax
80104ca8:	8b 5d 0c             	mov    0xc(%ebp),%ebx
80104cab:	8b 4d 10             	mov    0x10(%ebp),%ecx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
80104cae:	89 c2                	mov    %eax,%edx
80104cb0:	eb 19                	jmp    80104ccb <strncpy+0x2b>
80104cb2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104cb8:	83 c3 01             	add    $0x1,%ebx
80104cbb:	0f b6 4b ff          	movzbl -0x1(%ebx),%ecx
80104cbf:	83 c2 01             	add    $0x1,%edx
80104cc2:	84 c9                	test   %cl,%cl
80104cc4:	88 4a ff             	mov    %cl,-0x1(%edx)
80104cc7:	74 09                	je     80104cd2 <strncpy+0x32>
80104cc9:	89 f1                	mov    %esi,%ecx
80104ccb:	85 c9                	test   %ecx,%ecx
80104ccd:	8d 71 ff             	lea    -0x1(%ecx),%esi
80104cd0:	7f e6                	jg     80104cb8 <strncpy+0x18>
    ;
  while(n-- > 0)
80104cd2:	31 c9                	xor    %ecx,%ecx
80104cd4:	85 f6                	test   %esi,%esi
80104cd6:	7e 17                	jle    80104cef <strncpy+0x4f>
80104cd8:	90                   	nop
80104cd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    *s++ = 0;
80104ce0:	c6 04 0a 00          	movb   $0x0,(%edx,%ecx,1)
80104ce4:	89 f3                	mov    %esi,%ebx
80104ce6:	83 c1 01             	add    $0x1,%ecx
80104ce9:	29 cb                	sub    %ecx,%ebx
  while(n-- > 0)
80104ceb:	85 db                	test   %ebx,%ebx
80104ced:	7f f1                	jg     80104ce0 <strncpy+0x40>
  return os;
}
80104cef:	5b                   	pop    %ebx
80104cf0:	5e                   	pop    %esi
80104cf1:	5d                   	pop    %ebp
80104cf2:	c3                   	ret    
80104cf3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104cf9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104d00 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80104d00:	55                   	push   %ebp
80104d01:	89 e5                	mov    %esp,%ebp
80104d03:	56                   	push   %esi
80104d04:	53                   	push   %ebx
80104d05:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104d08:	8b 45 08             	mov    0x8(%ebp),%eax
80104d0b:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  if(n <= 0)
80104d0e:	85 c9                	test   %ecx,%ecx
80104d10:	7e 26                	jle    80104d38 <safestrcpy+0x38>
80104d12:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
80104d16:	89 c1                	mov    %eax,%ecx
80104d18:	eb 17                	jmp    80104d31 <safestrcpy+0x31>
80104d1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80104d20:	83 c2 01             	add    $0x1,%edx
80104d23:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
80104d27:	83 c1 01             	add    $0x1,%ecx
80104d2a:	84 db                	test   %bl,%bl
80104d2c:	88 59 ff             	mov    %bl,-0x1(%ecx)
80104d2f:	74 04                	je     80104d35 <safestrcpy+0x35>
80104d31:	39 f2                	cmp    %esi,%edx
80104d33:	75 eb                	jne    80104d20 <safestrcpy+0x20>
    ;
  *s = 0;
80104d35:	c6 01 00             	movb   $0x0,(%ecx)
  return os;
}
80104d38:	5b                   	pop    %ebx
80104d39:	5e                   	pop    %esi
80104d3a:	5d                   	pop    %ebp
80104d3b:	c3                   	ret    
80104d3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104d40 <strlen>:

int
strlen(const char *s)
{
80104d40:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80104d41:	31 c0                	xor    %eax,%eax
{
80104d43:	89 e5                	mov    %esp,%ebp
80104d45:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
80104d48:	80 3a 00             	cmpb   $0x0,(%edx)
80104d4b:	74 0c                	je     80104d59 <strlen+0x19>
80104d4d:	8d 76 00             	lea    0x0(%esi),%esi
80104d50:	83 c0 01             	add    $0x1,%eax
80104d53:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80104d57:	75 f7                	jne    80104d50 <strlen+0x10>
    ;
  return n;
}
80104d59:	5d                   	pop    %ebp
80104d5a:	c3                   	ret    

80104d5b <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
80104d5b:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
80104d5f:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-saved registers
  pushl %ebp
80104d63:	55                   	push   %ebp
  pushl %ebx
80104d64:	53                   	push   %ebx
  pushl %esi
80104d65:	56                   	push   %esi
  pushl %edi
80104d66:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80104d67:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
80104d69:	89 d4                	mov    %edx,%esp

  # Load new callee-saved registers
  popl %edi
80104d6b:	5f                   	pop    %edi
  popl %esi
80104d6c:	5e                   	pop    %esi
  popl %ebx
80104d6d:	5b                   	pop    %ebx
  popl %ebp
80104d6e:	5d                   	pop    %ebp
  ret
80104d6f:	c3                   	ret    

80104d70 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80104d70:	55                   	push   %ebp
80104d71:	89 e5                	mov    %esp,%ebp
80104d73:	53                   	push   %ebx
80104d74:	83 ec 04             	sub    $0x4,%esp
80104d77:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
80104d7a:	e8 d1 ea ff ff       	call   80103850 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104d7f:	8b 00                	mov    (%eax),%eax
80104d81:	39 d8                	cmp    %ebx,%eax
80104d83:	76 1b                	jbe    80104da0 <fetchint+0x30>
80104d85:	8d 53 04             	lea    0x4(%ebx),%edx
80104d88:	39 d0                	cmp    %edx,%eax
80104d8a:	72 14                	jb     80104da0 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
80104d8c:	8b 45 0c             	mov    0xc(%ebp),%eax
80104d8f:	8b 13                	mov    (%ebx),%edx
80104d91:	89 10                	mov    %edx,(%eax)
  return 0;
80104d93:	31 c0                	xor    %eax,%eax
}
80104d95:	83 c4 04             	add    $0x4,%esp
80104d98:	5b                   	pop    %ebx
80104d99:	5d                   	pop    %ebp
80104d9a:	c3                   	ret    
80104d9b:	90                   	nop
80104d9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104da0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104da5:	eb ee                	jmp    80104d95 <fetchint+0x25>
80104da7:	89 f6                	mov    %esi,%esi
80104da9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104db0 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80104db0:	55                   	push   %ebp
80104db1:	89 e5                	mov    %esp,%ebp
80104db3:	53                   	push   %ebx
80104db4:	83 ec 04             	sub    $0x4,%esp
80104db7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
80104dba:	e8 91 ea ff ff       	call   80103850 <myproc>

  if(addr >= curproc->sz)
80104dbf:	39 18                	cmp    %ebx,(%eax)
80104dc1:	76 29                	jbe    80104dec <fetchstr+0x3c>
    return -1;
  *pp = (char*)addr;
80104dc3:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80104dc6:	89 da                	mov    %ebx,%edx
80104dc8:	89 19                	mov    %ebx,(%ecx)
  ep = (char*)curproc->sz;
80104dca:	8b 00                	mov    (%eax),%eax
  for(s = *pp; s < ep; s++){
80104dcc:	39 c3                	cmp    %eax,%ebx
80104dce:	73 1c                	jae    80104dec <fetchstr+0x3c>
    if(*s == 0)
80104dd0:	80 3b 00             	cmpb   $0x0,(%ebx)
80104dd3:	75 10                	jne    80104de5 <fetchstr+0x35>
80104dd5:	eb 39                	jmp    80104e10 <fetchstr+0x60>
80104dd7:	89 f6                	mov    %esi,%esi
80104dd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104de0:	80 3a 00             	cmpb   $0x0,(%edx)
80104de3:	74 1b                	je     80104e00 <fetchstr+0x50>
  for(s = *pp; s < ep; s++){
80104de5:	83 c2 01             	add    $0x1,%edx
80104de8:	39 d0                	cmp    %edx,%eax
80104dea:	77 f4                	ja     80104de0 <fetchstr+0x30>
    return -1;
80104dec:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      return s - *pp;
  }
  return -1;
}
80104df1:	83 c4 04             	add    $0x4,%esp
80104df4:	5b                   	pop    %ebx
80104df5:	5d                   	pop    %ebp
80104df6:	c3                   	ret    
80104df7:	89 f6                	mov    %esi,%esi
80104df9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104e00:	83 c4 04             	add    $0x4,%esp
80104e03:	89 d0                	mov    %edx,%eax
80104e05:	29 d8                	sub    %ebx,%eax
80104e07:	5b                   	pop    %ebx
80104e08:	5d                   	pop    %ebp
80104e09:	c3                   	ret    
80104e0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(*s == 0)
80104e10:	31 c0                	xor    %eax,%eax
      return s - *pp;
80104e12:	eb dd                	jmp    80104df1 <fetchstr+0x41>
80104e14:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104e1a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104e20 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80104e20:	55                   	push   %ebp
80104e21:	89 e5                	mov    %esp,%ebp
80104e23:	56                   	push   %esi
80104e24:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104e25:	e8 26 ea ff ff       	call   80103850 <myproc>
80104e2a:	8b 40 18             	mov    0x18(%eax),%eax
80104e2d:	8b 55 08             	mov    0x8(%ebp),%edx
80104e30:	8b 40 44             	mov    0x44(%eax),%eax
80104e33:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80104e36:	e8 15 ea ff ff       	call   80103850 <myproc>
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104e3b:	8b 00                	mov    (%eax),%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104e3d:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104e40:	39 c6                	cmp    %eax,%esi
80104e42:	73 1c                	jae    80104e60 <argint+0x40>
80104e44:	8d 53 08             	lea    0x8(%ebx),%edx
80104e47:	39 d0                	cmp    %edx,%eax
80104e49:	72 15                	jb     80104e60 <argint+0x40>
  *ip = *(int*)(addr);
80104e4b:	8b 45 0c             	mov    0xc(%ebp),%eax
80104e4e:	8b 53 04             	mov    0x4(%ebx),%edx
80104e51:	89 10                	mov    %edx,(%eax)
  return 0;
80104e53:	31 c0                	xor    %eax,%eax
}
80104e55:	5b                   	pop    %ebx
80104e56:	5e                   	pop    %esi
80104e57:	5d                   	pop    %ebp
80104e58:	c3                   	ret    
80104e59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104e60:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104e65:	eb ee                	jmp    80104e55 <argint+0x35>
80104e67:	89 f6                	mov    %esi,%esi
80104e69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104e70 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80104e70:	55                   	push   %ebp
80104e71:	89 e5                	mov    %esp,%ebp
80104e73:	56                   	push   %esi
80104e74:	53                   	push   %ebx
80104e75:	83 ec 10             	sub    $0x10,%esp
80104e78:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int i;
  struct proc *curproc = myproc();
80104e7b:	e8 d0 e9 ff ff       	call   80103850 <myproc>
80104e80:	89 c6                	mov    %eax,%esi
 
  if(argint(n, &i) < 0)
80104e82:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104e85:	83 ec 08             	sub    $0x8,%esp
80104e88:	50                   	push   %eax
80104e89:	ff 75 08             	pushl  0x8(%ebp)
80104e8c:	e8 8f ff ff ff       	call   80104e20 <argint>
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80104e91:	83 c4 10             	add    $0x10,%esp
80104e94:	85 c0                	test   %eax,%eax
80104e96:	78 28                	js     80104ec0 <argptr+0x50>
80104e98:	85 db                	test   %ebx,%ebx
80104e9a:	78 24                	js     80104ec0 <argptr+0x50>
80104e9c:	8b 16                	mov    (%esi),%edx
80104e9e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104ea1:	39 c2                	cmp    %eax,%edx
80104ea3:	76 1b                	jbe    80104ec0 <argptr+0x50>
80104ea5:	01 c3                	add    %eax,%ebx
80104ea7:	39 da                	cmp    %ebx,%edx
80104ea9:	72 15                	jb     80104ec0 <argptr+0x50>
    return -1;
  *pp = (char*)i;
80104eab:	8b 55 0c             	mov    0xc(%ebp),%edx
80104eae:	89 02                	mov    %eax,(%edx)
  return 0;
80104eb0:	31 c0                	xor    %eax,%eax
}
80104eb2:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104eb5:	5b                   	pop    %ebx
80104eb6:	5e                   	pop    %esi
80104eb7:	5d                   	pop    %ebp
80104eb8:	c3                   	ret    
80104eb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104ec0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104ec5:	eb eb                	jmp    80104eb2 <argptr+0x42>
80104ec7:	89 f6                	mov    %esi,%esi
80104ec9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104ed0 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80104ed0:	55                   	push   %ebp
80104ed1:	89 e5                	mov    %esp,%ebp
80104ed3:	83 ec 20             	sub    $0x20,%esp
  int addr;
  if(argint(n, &addr) < 0)
80104ed6:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104ed9:	50                   	push   %eax
80104eda:	ff 75 08             	pushl  0x8(%ebp)
80104edd:	e8 3e ff ff ff       	call   80104e20 <argint>
80104ee2:	83 c4 10             	add    $0x10,%esp
80104ee5:	85 c0                	test   %eax,%eax
80104ee7:	78 17                	js     80104f00 <argstr+0x30>
    return -1;
  return fetchstr(addr, pp);
80104ee9:	83 ec 08             	sub    $0x8,%esp
80104eec:	ff 75 0c             	pushl  0xc(%ebp)
80104eef:	ff 75 f4             	pushl  -0xc(%ebp)
80104ef2:	e8 b9 fe ff ff       	call   80104db0 <fetchstr>
80104ef7:	83 c4 10             	add    $0x10,%esp
}
80104efa:	c9                   	leave  
80104efb:	c3                   	ret    
80104efc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104f00:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104f05:	c9                   	leave  
80104f06:	c3                   	ret    
80104f07:	89 f6                	mov    %esi,%esi
80104f09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104f10 <syscall>:
[SYS_sigret] sys_sigret
};

void
syscall(void)
{
80104f10:	55                   	push   %ebp
80104f11:	89 e5                	mov    %esp,%ebp
80104f13:	53                   	push   %ebx
80104f14:	83 ec 04             	sub    $0x4,%esp
  int num;
  struct proc *curproc = myproc();
80104f17:	e8 34 e9 ff ff       	call   80103850 <myproc>
80104f1c:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
80104f1e:	8b 40 18             	mov    0x18(%eax),%eax
80104f21:	8b 40 1c             	mov    0x1c(%eax),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80104f24:	8d 50 ff             	lea    -0x1(%eax),%edx
80104f27:	83 fa 17             	cmp    $0x17,%edx
80104f2a:	77 1c                	ja     80104f48 <syscall+0x38>
80104f2c:	8b 14 85 80 7d 10 80 	mov    -0x7fef8280(,%eax,4),%edx
80104f33:	85 d2                	test   %edx,%edx
80104f35:	74 11                	je     80104f48 <syscall+0x38>
    curproc->tf->eax = syscalls[num]();
80104f37:	ff d2                	call   *%edx
80104f39:	8b 53 18             	mov    0x18(%ebx),%edx
80104f3c:	89 42 1c             	mov    %eax,0x1c(%edx)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
80104f3f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104f42:	c9                   	leave  
80104f43:	c3                   	ret    
80104f44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("%d %s: unknown sys call %d\n",
80104f48:	50                   	push   %eax
            curproc->pid, curproc->name, num);
80104f49:	8d 43 6c             	lea    0x6c(%ebx),%eax
    cprintf("%d %s: unknown sys call %d\n",
80104f4c:	50                   	push   %eax
80104f4d:	ff 73 10             	pushl  0x10(%ebx)
80104f50:	68 59 7d 10 80       	push   $0x80107d59
80104f55:	e8 06 b7 ff ff       	call   80100660 <cprintf>
    curproc->tf->eax = -1;
80104f5a:	8b 43 18             	mov    0x18(%ebx),%eax
80104f5d:	83 c4 10             	add    $0x10,%esp
80104f60:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
80104f67:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104f6a:	c9                   	leave  
80104f6b:	c3                   	ret    
80104f6c:	66 90                	xchg   %ax,%ax
80104f6e:	66 90                	xchg   %ax,%ax

80104f70 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104f70:	55                   	push   %ebp
80104f71:	89 e5                	mov    %esp,%ebp
80104f73:	57                   	push   %edi
80104f74:	56                   	push   %esi
80104f75:	53                   	push   %ebx
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104f76:	8d 75 da             	lea    -0x26(%ebp),%esi
{
80104f79:	83 ec 34             	sub    $0x34,%esp
80104f7c:	89 4d d0             	mov    %ecx,-0x30(%ebp)
80104f7f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  if((dp = nameiparent(path, name)) == 0)
80104f82:	56                   	push   %esi
80104f83:	50                   	push   %eax
{
80104f84:	89 55 d4             	mov    %edx,-0x2c(%ebp)
80104f87:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  if((dp = nameiparent(path, name)) == 0)
80104f8a:	e8 a1 cf ff ff       	call   80101f30 <nameiparent>
80104f8f:	83 c4 10             	add    $0x10,%esp
80104f92:	85 c0                	test   %eax,%eax
80104f94:	0f 84 46 01 00 00    	je     801050e0 <create+0x170>
    return 0;
  ilock(dp);
80104f9a:	83 ec 0c             	sub    $0xc,%esp
80104f9d:	89 c3                	mov    %eax,%ebx
80104f9f:	50                   	push   %eax
80104fa0:	e8 0b c7 ff ff       	call   801016b0 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
80104fa5:	83 c4 0c             	add    $0xc,%esp
80104fa8:	6a 00                	push   $0x0
80104faa:	56                   	push   %esi
80104fab:	53                   	push   %ebx
80104fac:	e8 2f cc ff ff       	call   80101be0 <dirlookup>
80104fb1:	83 c4 10             	add    $0x10,%esp
80104fb4:	85 c0                	test   %eax,%eax
80104fb6:	89 c7                	mov    %eax,%edi
80104fb8:	74 36                	je     80104ff0 <create+0x80>
    iunlockput(dp);
80104fba:	83 ec 0c             	sub    $0xc,%esp
80104fbd:	53                   	push   %ebx
80104fbe:	e8 7d c9 ff ff       	call   80101940 <iunlockput>
    ilock(ip);
80104fc3:	89 3c 24             	mov    %edi,(%esp)
80104fc6:	e8 e5 c6 ff ff       	call   801016b0 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
80104fcb:	83 c4 10             	add    $0x10,%esp
80104fce:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
80104fd3:	0f 85 97 00 00 00    	jne    80105070 <create+0x100>
80104fd9:	66 83 7f 50 02       	cmpw   $0x2,0x50(%edi)
80104fde:	0f 85 8c 00 00 00    	jne    80105070 <create+0x100>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104fe4:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104fe7:	89 f8                	mov    %edi,%eax
80104fe9:	5b                   	pop    %ebx
80104fea:	5e                   	pop    %esi
80104feb:	5f                   	pop    %edi
80104fec:	5d                   	pop    %ebp
80104fed:	c3                   	ret    
80104fee:	66 90                	xchg   %ax,%ax
  if((ip = ialloc(dp->dev, type)) == 0)
80104ff0:	0f bf 45 d4          	movswl -0x2c(%ebp),%eax
80104ff4:	83 ec 08             	sub    $0x8,%esp
80104ff7:	50                   	push   %eax
80104ff8:	ff 33                	pushl  (%ebx)
80104ffa:	e8 41 c5 ff ff       	call   80101540 <ialloc>
80104fff:	83 c4 10             	add    $0x10,%esp
80105002:	85 c0                	test   %eax,%eax
80105004:	89 c7                	mov    %eax,%edi
80105006:	0f 84 e8 00 00 00    	je     801050f4 <create+0x184>
  ilock(ip);
8010500c:	83 ec 0c             	sub    $0xc,%esp
8010500f:	50                   	push   %eax
80105010:	e8 9b c6 ff ff       	call   801016b0 <ilock>
  ip->major = major;
80105015:	0f b7 45 d0          	movzwl -0x30(%ebp),%eax
80105019:	66 89 47 52          	mov    %ax,0x52(%edi)
  ip->minor = minor;
8010501d:	0f b7 45 cc          	movzwl -0x34(%ebp),%eax
80105021:	66 89 47 54          	mov    %ax,0x54(%edi)
  ip->nlink = 1;
80105025:	b8 01 00 00 00       	mov    $0x1,%eax
8010502a:	66 89 47 56          	mov    %ax,0x56(%edi)
  iupdate(ip);
8010502e:	89 3c 24             	mov    %edi,(%esp)
80105031:	e8 ca c5 ff ff       	call   80101600 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
80105036:	83 c4 10             	add    $0x10,%esp
80105039:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
8010503e:	74 50                	je     80105090 <create+0x120>
  if(dirlink(dp, name, ip->inum) < 0)
80105040:	83 ec 04             	sub    $0x4,%esp
80105043:	ff 77 04             	pushl  0x4(%edi)
80105046:	56                   	push   %esi
80105047:	53                   	push   %ebx
80105048:	e8 03 ce ff ff       	call   80101e50 <dirlink>
8010504d:	83 c4 10             	add    $0x10,%esp
80105050:	85 c0                	test   %eax,%eax
80105052:	0f 88 8f 00 00 00    	js     801050e7 <create+0x177>
  iunlockput(dp);
80105058:	83 ec 0c             	sub    $0xc,%esp
8010505b:	53                   	push   %ebx
8010505c:	e8 df c8 ff ff       	call   80101940 <iunlockput>
  return ip;
80105061:	83 c4 10             	add    $0x10,%esp
}
80105064:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105067:	89 f8                	mov    %edi,%eax
80105069:	5b                   	pop    %ebx
8010506a:	5e                   	pop    %esi
8010506b:	5f                   	pop    %edi
8010506c:	5d                   	pop    %ebp
8010506d:	c3                   	ret    
8010506e:	66 90                	xchg   %ax,%ax
    iunlockput(ip);
80105070:	83 ec 0c             	sub    $0xc,%esp
80105073:	57                   	push   %edi
    return 0;
80105074:	31 ff                	xor    %edi,%edi
    iunlockput(ip);
80105076:	e8 c5 c8 ff ff       	call   80101940 <iunlockput>
    return 0;
8010507b:	83 c4 10             	add    $0x10,%esp
}
8010507e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105081:	89 f8                	mov    %edi,%eax
80105083:	5b                   	pop    %ebx
80105084:	5e                   	pop    %esi
80105085:	5f                   	pop    %edi
80105086:	5d                   	pop    %ebp
80105087:	c3                   	ret    
80105088:	90                   	nop
80105089:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    dp->nlink++;  // for ".."
80105090:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
    iupdate(dp);
80105095:	83 ec 0c             	sub    $0xc,%esp
80105098:	53                   	push   %ebx
80105099:	e8 62 c5 ff ff       	call   80101600 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
8010509e:	83 c4 0c             	add    $0xc,%esp
801050a1:	ff 77 04             	pushl  0x4(%edi)
801050a4:	68 00 7e 10 80       	push   $0x80107e00
801050a9:	57                   	push   %edi
801050aa:	e8 a1 cd ff ff       	call   80101e50 <dirlink>
801050af:	83 c4 10             	add    $0x10,%esp
801050b2:	85 c0                	test   %eax,%eax
801050b4:	78 1c                	js     801050d2 <create+0x162>
801050b6:	83 ec 04             	sub    $0x4,%esp
801050b9:	ff 73 04             	pushl  0x4(%ebx)
801050bc:	68 ff 7d 10 80       	push   $0x80107dff
801050c1:	57                   	push   %edi
801050c2:	e8 89 cd ff ff       	call   80101e50 <dirlink>
801050c7:	83 c4 10             	add    $0x10,%esp
801050ca:	85 c0                	test   %eax,%eax
801050cc:	0f 89 6e ff ff ff    	jns    80105040 <create+0xd0>
      panic("create dots");
801050d2:	83 ec 0c             	sub    $0xc,%esp
801050d5:	68 f3 7d 10 80       	push   $0x80107df3
801050da:	e8 b1 b2 ff ff       	call   80100390 <panic>
801050df:	90                   	nop
    return 0;
801050e0:	31 ff                	xor    %edi,%edi
801050e2:	e9 fd fe ff ff       	jmp    80104fe4 <create+0x74>
    panic("create: dirlink");
801050e7:	83 ec 0c             	sub    $0xc,%esp
801050ea:	68 02 7e 10 80       	push   $0x80107e02
801050ef:	e8 9c b2 ff ff       	call   80100390 <panic>
    panic("create: ialloc");
801050f4:	83 ec 0c             	sub    $0xc,%esp
801050f7:	68 e4 7d 10 80       	push   $0x80107de4
801050fc:	e8 8f b2 ff ff       	call   80100390 <panic>
80105101:	eb 0d                	jmp    80105110 <argfd.constprop.0>
80105103:	90                   	nop
80105104:	90                   	nop
80105105:	90                   	nop
80105106:	90                   	nop
80105107:	90                   	nop
80105108:	90                   	nop
80105109:	90                   	nop
8010510a:	90                   	nop
8010510b:	90                   	nop
8010510c:	90                   	nop
8010510d:	90                   	nop
8010510e:	90                   	nop
8010510f:	90                   	nop

80105110 <argfd.constprop.0>:
argfd(int n, int *pfd, struct file **pf)
80105110:	55                   	push   %ebp
80105111:	89 e5                	mov    %esp,%ebp
80105113:	56                   	push   %esi
80105114:	53                   	push   %ebx
80105115:	89 c3                	mov    %eax,%ebx
  if(argint(n, &fd) < 0)
80105117:	8d 45 f4             	lea    -0xc(%ebp),%eax
argfd(int n, int *pfd, struct file **pf)
8010511a:	89 d6                	mov    %edx,%esi
8010511c:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
8010511f:	50                   	push   %eax
80105120:	6a 00                	push   $0x0
80105122:	e8 f9 fc ff ff       	call   80104e20 <argint>
80105127:	83 c4 10             	add    $0x10,%esp
8010512a:	85 c0                	test   %eax,%eax
8010512c:	78 2a                	js     80105158 <argfd.constprop.0+0x48>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
8010512e:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80105132:	77 24                	ja     80105158 <argfd.constprop.0+0x48>
80105134:	e8 17 e7 ff ff       	call   80103850 <myproc>
80105139:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010513c:	8b 44 90 28          	mov    0x28(%eax,%edx,4),%eax
80105140:	85 c0                	test   %eax,%eax
80105142:	74 14                	je     80105158 <argfd.constprop.0+0x48>
  if(pfd)
80105144:	85 db                	test   %ebx,%ebx
80105146:	74 02                	je     8010514a <argfd.constprop.0+0x3a>
    *pfd = fd;
80105148:	89 13                	mov    %edx,(%ebx)
    *pf = f;
8010514a:	89 06                	mov    %eax,(%esi)
  return 0;
8010514c:	31 c0                	xor    %eax,%eax
}
8010514e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105151:	5b                   	pop    %ebx
80105152:	5e                   	pop    %esi
80105153:	5d                   	pop    %ebp
80105154:	c3                   	ret    
80105155:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80105158:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010515d:	eb ef                	jmp    8010514e <argfd.constprop.0+0x3e>
8010515f:	90                   	nop

80105160 <sys_dup>:
{
80105160:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0)
80105161:	31 c0                	xor    %eax,%eax
{
80105163:	89 e5                	mov    %esp,%ebp
80105165:	56                   	push   %esi
80105166:	53                   	push   %ebx
  if(argfd(0, 0, &f) < 0)
80105167:	8d 55 f4             	lea    -0xc(%ebp),%edx
{
8010516a:	83 ec 10             	sub    $0x10,%esp
  if(argfd(0, 0, &f) < 0)
8010516d:	e8 9e ff ff ff       	call   80105110 <argfd.constprop.0>
80105172:	85 c0                	test   %eax,%eax
80105174:	78 42                	js     801051b8 <sys_dup+0x58>
  if((fd=fdalloc(f)) < 0)
80105176:	8b 75 f4             	mov    -0xc(%ebp),%esi
  for(fd = 0; fd < NOFILE; fd++){
80105179:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
8010517b:	e8 d0 e6 ff ff       	call   80103850 <myproc>
80105180:	eb 0e                	jmp    80105190 <sys_dup+0x30>
80105182:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(fd = 0; fd < NOFILE; fd++){
80105188:	83 c3 01             	add    $0x1,%ebx
8010518b:	83 fb 10             	cmp    $0x10,%ebx
8010518e:	74 28                	je     801051b8 <sys_dup+0x58>
    if(curproc->ofile[fd] == 0){
80105190:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105194:	85 d2                	test   %edx,%edx
80105196:	75 f0                	jne    80105188 <sys_dup+0x28>
      curproc->ofile[fd] = f;
80105198:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
  filedup(f);
8010519c:	83 ec 0c             	sub    $0xc,%esp
8010519f:	ff 75 f4             	pushl  -0xc(%ebp)
801051a2:	e8 79 bc ff ff       	call   80100e20 <filedup>
  return fd;
801051a7:	83 c4 10             	add    $0x10,%esp
}
801051aa:	8d 65 f8             	lea    -0x8(%ebp),%esp
801051ad:	89 d8                	mov    %ebx,%eax
801051af:	5b                   	pop    %ebx
801051b0:	5e                   	pop    %esi
801051b1:	5d                   	pop    %ebp
801051b2:	c3                   	ret    
801051b3:	90                   	nop
801051b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801051b8:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return -1;
801051bb:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
801051c0:	89 d8                	mov    %ebx,%eax
801051c2:	5b                   	pop    %ebx
801051c3:	5e                   	pop    %esi
801051c4:	5d                   	pop    %ebp
801051c5:	c3                   	ret    
801051c6:	8d 76 00             	lea    0x0(%esi),%esi
801051c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801051d0 <sys_read>:
{
801051d0:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801051d1:	31 c0                	xor    %eax,%eax
{
801051d3:	89 e5                	mov    %esp,%ebp
801051d5:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801051d8:	8d 55 ec             	lea    -0x14(%ebp),%edx
801051db:	e8 30 ff ff ff       	call   80105110 <argfd.constprop.0>
801051e0:	85 c0                	test   %eax,%eax
801051e2:	78 4c                	js     80105230 <sys_read+0x60>
801051e4:	8d 45 f0             	lea    -0x10(%ebp),%eax
801051e7:	83 ec 08             	sub    $0x8,%esp
801051ea:	50                   	push   %eax
801051eb:	6a 02                	push   $0x2
801051ed:	e8 2e fc ff ff       	call   80104e20 <argint>
801051f2:	83 c4 10             	add    $0x10,%esp
801051f5:	85 c0                	test   %eax,%eax
801051f7:	78 37                	js     80105230 <sys_read+0x60>
801051f9:	8d 45 f4             	lea    -0xc(%ebp),%eax
801051fc:	83 ec 04             	sub    $0x4,%esp
801051ff:	ff 75 f0             	pushl  -0x10(%ebp)
80105202:	50                   	push   %eax
80105203:	6a 01                	push   $0x1
80105205:	e8 66 fc ff ff       	call   80104e70 <argptr>
8010520a:	83 c4 10             	add    $0x10,%esp
8010520d:	85 c0                	test   %eax,%eax
8010520f:	78 1f                	js     80105230 <sys_read+0x60>
  return fileread(f, p, n);
80105211:	83 ec 04             	sub    $0x4,%esp
80105214:	ff 75 f0             	pushl  -0x10(%ebp)
80105217:	ff 75 f4             	pushl  -0xc(%ebp)
8010521a:	ff 75 ec             	pushl  -0x14(%ebp)
8010521d:	e8 6e bd ff ff       	call   80100f90 <fileread>
80105222:	83 c4 10             	add    $0x10,%esp
}
80105225:	c9                   	leave  
80105226:	c3                   	ret    
80105227:	89 f6                	mov    %esi,%esi
80105229:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80105230:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105235:	c9                   	leave  
80105236:	c3                   	ret    
80105237:	89 f6                	mov    %esi,%esi
80105239:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105240 <sys_write>:
{
80105240:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105241:	31 c0                	xor    %eax,%eax
{
80105243:	89 e5                	mov    %esp,%ebp
80105245:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105248:	8d 55 ec             	lea    -0x14(%ebp),%edx
8010524b:	e8 c0 fe ff ff       	call   80105110 <argfd.constprop.0>
80105250:	85 c0                	test   %eax,%eax
80105252:	78 4c                	js     801052a0 <sys_write+0x60>
80105254:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105257:	83 ec 08             	sub    $0x8,%esp
8010525a:	50                   	push   %eax
8010525b:	6a 02                	push   $0x2
8010525d:	e8 be fb ff ff       	call   80104e20 <argint>
80105262:	83 c4 10             	add    $0x10,%esp
80105265:	85 c0                	test   %eax,%eax
80105267:	78 37                	js     801052a0 <sys_write+0x60>
80105269:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010526c:	83 ec 04             	sub    $0x4,%esp
8010526f:	ff 75 f0             	pushl  -0x10(%ebp)
80105272:	50                   	push   %eax
80105273:	6a 01                	push   $0x1
80105275:	e8 f6 fb ff ff       	call   80104e70 <argptr>
8010527a:	83 c4 10             	add    $0x10,%esp
8010527d:	85 c0                	test   %eax,%eax
8010527f:	78 1f                	js     801052a0 <sys_write+0x60>
  return filewrite(f, p, n);
80105281:	83 ec 04             	sub    $0x4,%esp
80105284:	ff 75 f0             	pushl  -0x10(%ebp)
80105287:	ff 75 f4             	pushl  -0xc(%ebp)
8010528a:	ff 75 ec             	pushl  -0x14(%ebp)
8010528d:	e8 8e bd ff ff       	call   80101020 <filewrite>
80105292:	83 c4 10             	add    $0x10,%esp
}
80105295:	c9                   	leave  
80105296:	c3                   	ret    
80105297:	89 f6                	mov    %esi,%esi
80105299:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
801052a0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801052a5:	c9                   	leave  
801052a6:	c3                   	ret    
801052a7:	89 f6                	mov    %esi,%esi
801052a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801052b0 <sys_close>:
{
801052b0:	55                   	push   %ebp
801052b1:	89 e5                	mov    %esp,%ebp
801052b3:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, &fd, &f) < 0)
801052b6:	8d 55 f4             	lea    -0xc(%ebp),%edx
801052b9:	8d 45 f0             	lea    -0x10(%ebp),%eax
801052bc:	e8 4f fe ff ff       	call   80105110 <argfd.constprop.0>
801052c1:	85 c0                	test   %eax,%eax
801052c3:	78 2b                	js     801052f0 <sys_close+0x40>
  myproc()->ofile[fd] = 0;
801052c5:	e8 86 e5 ff ff       	call   80103850 <myproc>
801052ca:	8b 55 f0             	mov    -0x10(%ebp),%edx
  fileclose(f);
801052cd:	83 ec 0c             	sub    $0xc,%esp
  myproc()->ofile[fd] = 0;
801052d0:	c7 44 90 28 00 00 00 	movl   $0x0,0x28(%eax,%edx,4)
801052d7:	00 
  fileclose(f);
801052d8:	ff 75 f4             	pushl  -0xc(%ebp)
801052db:	e8 90 bb ff ff       	call   80100e70 <fileclose>
  return 0;
801052e0:	83 c4 10             	add    $0x10,%esp
801052e3:	31 c0                	xor    %eax,%eax
}
801052e5:	c9                   	leave  
801052e6:	c3                   	ret    
801052e7:	89 f6                	mov    %esi,%esi
801052e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
801052f0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801052f5:	c9                   	leave  
801052f6:	c3                   	ret    
801052f7:	89 f6                	mov    %esi,%esi
801052f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105300 <sys_fstat>:
{
80105300:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80105301:	31 c0                	xor    %eax,%eax
{
80105303:	89 e5                	mov    %esp,%ebp
80105305:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80105308:	8d 55 f0             	lea    -0x10(%ebp),%edx
8010530b:	e8 00 fe ff ff       	call   80105110 <argfd.constprop.0>
80105310:	85 c0                	test   %eax,%eax
80105312:	78 2c                	js     80105340 <sys_fstat+0x40>
80105314:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105317:	83 ec 04             	sub    $0x4,%esp
8010531a:	6a 14                	push   $0x14
8010531c:	50                   	push   %eax
8010531d:	6a 01                	push   $0x1
8010531f:	e8 4c fb ff ff       	call   80104e70 <argptr>
80105324:	83 c4 10             	add    $0x10,%esp
80105327:	85 c0                	test   %eax,%eax
80105329:	78 15                	js     80105340 <sys_fstat+0x40>
  return filestat(f, st);
8010532b:	83 ec 08             	sub    $0x8,%esp
8010532e:	ff 75 f4             	pushl  -0xc(%ebp)
80105331:	ff 75 f0             	pushl  -0x10(%ebp)
80105334:	e8 07 bc ff ff       	call   80100f40 <filestat>
80105339:	83 c4 10             	add    $0x10,%esp
}
8010533c:	c9                   	leave  
8010533d:	c3                   	ret    
8010533e:	66 90                	xchg   %ax,%ax
    return -1;
80105340:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105345:	c9                   	leave  
80105346:	c3                   	ret    
80105347:	89 f6                	mov    %esi,%esi
80105349:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105350 <sys_link>:
{
80105350:	55                   	push   %ebp
80105351:	89 e5                	mov    %esp,%ebp
80105353:	57                   	push   %edi
80105354:	56                   	push   %esi
80105355:	53                   	push   %ebx
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80105356:	8d 45 d4             	lea    -0x2c(%ebp),%eax
{
80105359:	83 ec 34             	sub    $0x34,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
8010535c:	50                   	push   %eax
8010535d:	6a 00                	push   $0x0
8010535f:	e8 6c fb ff ff       	call   80104ed0 <argstr>
80105364:	83 c4 10             	add    $0x10,%esp
80105367:	85 c0                	test   %eax,%eax
80105369:	0f 88 fb 00 00 00    	js     8010546a <sys_link+0x11a>
8010536f:	8d 45 d0             	lea    -0x30(%ebp),%eax
80105372:	83 ec 08             	sub    $0x8,%esp
80105375:	50                   	push   %eax
80105376:	6a 01                	push   $0x1
80105378:	e8 53 fb ff ff       	call   80104ed0 <argstr>
8010537d:	83 c4 10             	add    $0x10,%esp
80105380:	85 c0                	test   %eax,%eax
80105382:	0f 88 e2 00 00 00    	js     8010546a <sys_link+0x11a>
  begin_op();
80105388:	e8 43 d8 ff ff       	call   80102bd0 <begin_op>
  if((ip = namei(old)) == 0){
8010538d:	83 ec 0c             	sub    $0xc,%esp
80105390:	ff 75 d4             	pushl  -0x2c(%ebp)
80105393:	e8 78 cb ff ff       	call   80101f10 <namei>
80105398:	83 c4 10             	add    $0x10,%esp
8010539b:	85 c0                	test   %eax,%eax
8010539d:	89 c3                	mov    %eax,%ebx
8010539f:	0f 84 ea 00 00 00    	je     8010548f <sys_link+0x13f>
  ilock(ip);
801053a5:	83 ec 0c             	sub    $0xc,%esp
801053a8:	50                   	push   %eax
801053a9:	e8 02 c3 ff ff       	call   801016b0 <ilock>
  if(ip->type == T_DIR){
801053ae:	83 c4 10             	add    $0x10,%esp
801053b1:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801053b6:	0f 84 bb 00 00 00    	je     80105477 <sys_link+0x127>
  ip->nlink++;
801053bc:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  iupdate(ip);
801053c1:	83 ec 0c             	sub    $0xc,%esp
  if((dp = nameiparent(new, name)) == 0)
801053c4:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
801053c7:	53                   	push   %ebx
801053c8:	e8 33 c2 ff ff       	call   80101600 <iupdate>
  iunlock(ip);
801053cd:	89 1c 24             	mov    %ebx,(%esp)
801053d0:	e8 bb c3 ff ff       	call   80101790 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
801053d5:	58                   	pop    %eax
801053d6:	5a                   	pop    %edx
801053d7:	57                   	push   %edi
801053d8:	ff 75 d0             	pushl  -0x30(%ebp)
801053db:	e8 50 cb ff ff       	call   80101f30 <nameiparent>
801053e0:	83 c4 10             	add    $0x10,%esp
801053e3:	85 c0                	test   %eax,%eax
801053e5:	89 c6                	mov    %eax,%esi
801053e7:	74 5b                	je     80105444 <sys_link+0xf4>
  ilock(dp);
801053e9:	83 ec 0c             	sub    $0xc,%esp
801053ec:	50                   	push   %eax
801053ed:	e8 be c2 ff ff       	call   801016b0 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
801053f2:	83 c4 10             	add    $0x10,%esp
801053f5:	8b 03                	mov    (%ebx),%eax
801053f7:	39 06                	cmp    %eax,(%esi)
801053f9:	75 3d                	jne    80105438 <sys_link+0xe8>
801053fb:	83 ec 04             	sub    $0x4,%esp
801053fe:	ff 73 04             	pushl  0x4(%ebx)
80105401:	57                   	push   %edi
80105402:	56                   	push   %esi
80105403:	e8 48 ca ff ff       	call   80101e50 <dirlink>
80105408:	83 c4 10             	add    $0x10,%esp
8010540b:	85 c0                	test   %eax,%eax
8010540d:	78 29                	js     80105438 <sys_link+0xe8>
  iunlockput(dp);
8010540f:	83 ec 0c             	sub    $0xc,%esp
80105412:	56                   	push   %esi
80105413:	e8 28 c5 ff ff       	call   80101940 <iunlockput>
  iput(ip);
80105418:	89 1c 24             	mov    %ebx,(%esp)
8010541b:	e8 c0 c3 ff ff       	call   801017e0 <iput>
  end_op();
80105420:	e8 1b d8 ff ff       	call   80102c40 <end_op>
  return 0;
80105425:	83 c4 10             	add    $0x10,%esp
80105428:	31 c0                	xor    %eax,%eax
}
8010542a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010542d:	5b                   	pop    %ebx
8010542e:	5e                   	pop    %esi
8010542f:	5f                   	pop    %edi
80105430:	5d                   	pop    %ebp
80105431:	c3                   	ret    
80105432:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(dp);
80105438:	83 ec 0c             	sub    $0xc,%esp
8010543b:	56                   	push   %esi
8010543c:	e8 ff c4 ff ff       	call   80101940 <iunlockput>
    goto bad;
80105441:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80105444:	83 ec 0c             	sub    $0xc,%esp
80105447:	53                   	push   %ebx
80105448:	e8 63 c2 ff ff       	call   801016b0 <ilock>
  ip->nlink--;
8010544d:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105452:	89 1c 24             	mov    %ebx,(%esp)
80105455:	e8 a6 c1 ff ff       	call   80101600 <iupdate>
  iunlockput(ip);
8010545a:	89 1c 24             	mov    %ebx,(%esp)
8010545d:	e8 de c4 ff ff       	call   80101940 <iunlockput>
  end_op();
80105462:	e8 d9 d7 ff ff       	call   80102c40 <end_op>
  return -1;
80105467:	83 c4 10             	add    $0x10,%esp
}
8010546a:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
8010546d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105472:	5b                   	pop    %ebx
80105473:	5e                   	pop    %esi
80105474:	5f                   	pop    %edi
80105475:	5d                   	pop    %ebp
80105476:	c3                   	ret    
    iunlockput(ip);
80105477:	83 ec 0c             	sub    $0xc,%esp
8010547a:	53                   	push   %ebx
8010547b:	e8 c0 c4 ff ff       	call   80101940 <iunlockput>
    end_op();
80105480:	e8 bb d7 ff ff       	call   80102c40 <end_op>
    return -1;
80105485:	83 c4 10             	add    $0x10,%esp
80105488:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010548d:	eb 9b                	jmp    8010542a <sys_link+0xda>
    end_op();
8010548f:	e8 ac d7 ff ff       	call   80102c40 <end_op>
    return -1;
80105494:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105499:	eb 8f                	jmp    8010542a <sys_link+0xda>
8010549b:	90                   	nop
8010549c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801054a0 <sys_unlink>:
{
801054a0:	55                   	push   %ebp
801054a1:	89 e5                	mov    %esp,%ebp
801054a3:	57                   	push   %edi
801054a4:	56                   	push   %esi
801054a5:	53                   	push   %ebx
  if(argstr(0, &path) < 0)
801054a6:	8d 45 c0             	lea    -0x40(%ebp),%eax
{
801054a9:	83 ec 44             	sub    $0x44,%esp
  if(argstr(0, &path) < 0)
801054ac:	50                   	push   %eax
801054ad:	6a 00                	push   $0x0
801054af:	e8 1c fa ff ff       	call   80104ed0 <argstr>
801054b4:	83 c4 10             	add    $0x10,%esp
801054b7:	85 c0                	test   %eax,%eax
801054b9:	0f 88 77 01 00 00    	js     80105636 <sys_unlink+0x196>
  if((dp = nameiparent(path, name)) == 0){
801054bf:	8d 5d ca             	lea    -0x36(%ebp),%ebx
  begin_op();
801054c2:	e8 09 d7 ff ff       	call   80102bd0 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
801054c7:	83 ec 08             	sub    $0x8,%esp
801054ca:	53                   	push   %ebx
801054cb:	ff 75 c0             	pushl  -0x40(%ebp)
801054ce:	e8 5d ca ff ff       	call   80101f30 <nameiparent>
801054d3:	83 c4 10             	add    $0x10,%esp
801054d6:	85 c0                	test   %eax,%eax
801054d8:	89 c6                	mov    %eax,%esi
801054da:	0f 84 60 01 00 00    	je     80105640 <sys_unlink+0x1a0>
  ilock(dp);
801054e0:	83 ec 0c             	sub    $0xc,%esp
801054e3:	50                   	push   %eax
801054e4:	e8 c7 c1 ff ff       	call   801016b0 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
801054e9:	58                   	pop    %eax
801054ea:	5a                   	pop    %edx
801054eb:	68 00 7e 10 80       	push   $0x80107e00
801054f0:	53                   	push   %ebx
801054f1:	e8 ca c6 ff ff       	call   80101bc0 <namecmp>
801054f6:	83 c4 10             	add    $0x10,%esp
801054f9:	85 c0                	test   %eax,%eax
801054fb:	0f 84 03 01 00 00    	je     80105604 <sys_unlink+0x164>
80105501:	83 ec 08             	sub    $0x8,%esp
80105504:	68 ff 7d 10 80       	push   $0x80107dff
80105509:	53                   	push   %ebx
8010550a:	e8 b1 c6 ff ff       	call   80101bc0 <namecmp>
8010550f:	83 c4 10             	add    $0x10,%esp
80105512:	85 c0                	test   %eax,%eax
80105514:	0f 84 ea 00 00 00    	je     80105604 <sys_unlink+0x164>
  if((ip = dirlookup(dp, name, &off)) == 0)
8010551a:	8d 45 c4             	lea    -0x3c(%ebp),%eax
8010551d:	83 ec 04             	sub    $0x4,%esp
80105520:	50                   	push   %eax
80105521:	53                   	push   %ebx
80105522:	56                   	push   %esi
80105523:	e8 b8 c6 ff ff       	call   80101be0 <dirlookup>
80105528:	83 c4 10             	add    $0x10,%esp
8010552b:	85 c0                	test   %eax,%eax
8010552d:	89 c3                	mov    %eax,%ebx
8010552f:	0f 84 cf 00 00 00    	je     80105604 <sys_unlink+0x164>
  ilock(ip);
80105535:	83 ec 0c             	sub    $0xc,%esp
80105538:	50                   	push   %eax
80105539:	e8 72 c1 ff ff       	call   801016b0 <ilock>
  if(ip->nlink < 1)
8010553e:	83 c4 10             	add    $0x10,%esp
80105541:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80105546:	0f 8e 10 01 00 00    	jle    8010565c <sys_unlink+0x1bc>
  if(ip->type == T_DIR && !isdirempty(ip)){
8010554c:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105551:	74 6d                	je     801055c0 <sys_unlink+0x120>
  memset(&de, 0, sizeof(de));
80105553:	8d 45 d8             	lea    -0x28(%ebp),%eax
80105556:	83 ec 04             	sub    $0x4,%esp
80105559:	6a 10                	push   $0x10
8010555b:	6a 00                	push   $0x0
8010555d:	50                   	push   %eax
8010555e:	e8 bd f5 ff ff       	call   80104b20 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105563:	8d 45 d8             	lea    -0x28(%ebp),%eax
80105566:	6a 10                	push   $0x10
80105568:	ff 75 c4             	pushl  -0x3c(%ebp)
8010556b:	50                   	push   %eax
8010556c:	56                   	push   %esi
8010556d:	e8 1e c5 ff ff       	call   80101a90 <writei>
80105572:	83 c4 20             	add    $0x20,%esp
80105575:	83 f8 10             	cmp    $0x10,%eax
80105578:	0f 85 eb 00 00 00    	jne    80105669 <sys_unlink+0x1c9>
  if(ip->type == T_DIR){
8010557e:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105583:	0f 84 97 00 00 00    	je     80105620 <sys_unlink+0x180>
  iunlockput(dp);
80105589:	83 ec 0c             	sub    $0xc,%esp
8010558c:	56                   	push   %esi
8010558d:	e8 ae c3 ff ff       	call   80101940 <iunlockput>
  ip->nlink--;
80105592:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105597:	89 1c 24             	mov    %ebx,(%esp)
8010559a:	e8 61 c0 ff ff       	call   80101600 <iupdate>
  iunlockput(ip);
8010559f:	89 1c 24             	mov    %ebx,(%esp)
801055a2:	e8 99 c3 ff ff       	call   80101940 <iunlockput>
  end_op();
801055a7:	e8 94 d6 ff ff       	call   80102c40 <end_op>
  return 0;
801055ac:	83 c4 10             	add    $0x10,%esp
801055af:	31 c0                	xor    %eax,%eax
}
801055b1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801055b4:	5b                   	pop    %ebx
801055b5:	5e                   	pop    %esi
801055b6:	5f                   	pop    %edi
801055b7:	5d                   	pop    %ebp
801055b8:	c3                   	ret    
801055b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
801055c0:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
801055c4:	76 8d                	jbe    80105553 <sys_unlink+0xb3>
801055c6:	bf 20 00 00 00       	mov    $0x20,%edi
801055cb:	eb 0f                	jmp    801055dc <sys_unlink+0x13c>
801055cd:	8d 76 00             	lea    0x0(%esi),%esi
801055d0:	83 c7 10             	add    $0x10,%edi
801055d3:	3b 7b 58             	cmp    0x58(%ebx),%edi
801055d6:	0f 83 77 ff ff ff    	jae    80105553 <sys_unlink+0xb3>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801055dc:	8d 45 d8             	lea    -0x28(%ebp),%eax
801055df:	6a 10                	push   $0x10
801055e1:	57                   	push   %edi
801055e2:	50                   	push   %eax
801055e3:	53                   	push   %ebx
801055e4:	e8 a7 c3 ff ff       	call   80101990 <readi>
801055e9:	83 c4 10             	add    $0x10,%esp
801055ec:	83 f8 10             	cmp    $0x10,%eax
801055ef:	75 5e                	jne    8010564f <sys_unlink+0x1af>
    if(de.inum != 0)
801055f1:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
801055f6:	74 d8                	je     801055d0 <sys_unlink+0x130>
    iunlockput(ip);
801055f8:	83 ec 0c             	sub    $0xc,%esp
801055fb:	53                   	push   %ebx
801055fc:	e8 3f c3 ff ff       	call   80101940 <iunlockput>
    goto bad;
80105601:	83 c4 10             	add    $0x10,%esp
  iunlockput(dp);
80105604:	83 ec 0c             	sub    $0xc,%esp
80105607:	56                   	push   %esi
80105608:	e8 33 c3 ff ff       	call   80101940 <iunlockput>
  end_op();
8010560d:	e8 2e d6 ff ff       	call   80102c40 <end_op>
  return -1;
80105612:	83 c4 10             	add    $0x10,%esp
80105615:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010561a:	eb 95                	jmp    801055b1 <sys_unlink+0x111>
8010561c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    dp->nlink--;
80105620:	66 83 6e 56 01       	subw   $0x1,0x56(%esi)
    iupdate(dp);
80105625:	83 ec 0c             	sub    $0xc,%esp
80105628:	56                   	push   %esi
80105629:	e8 d2 bf ff ff       	call   80101600 <iupdate>
8010562e:	83 c4 10             	add    $0x10,%esp
80105631:	e9 53 ff ff ff       	jmp    80105589 <sys_unlink+0xe9>
    return -1;
80105636:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010563b:	e9 71 ff ff ff       	jmp    801055b1 <sys_unlink+0x111>
    end_op();
80105640:	e8 fb d5 ff ff       	call   80102c40 <end_op>
    return -1;
80105645:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010564a:	e9 62 ff ff ff       	jmp    801055b1 <sys_unlink+0x111>
      panic("isdirempty: readi");
8010564f:	83 ec 0c             	sub    $0xc,%esp
80105652:	68 24 7e 10 80       	push   $0x80107e24
80105657:	e8 34 ad ff ff       	call   80100390 <panic>
    panic("unlink: nlink < 1");
8010565c:	83 ec 0c             	sub    $0xc,%esp
8010565f:	68 12 7e 10 80       	push   $0x80107e12
80105664:	e8 27 ad ff ff       	call   80100390 <panic>
    panic("unlink: writei");
80105669:	83 ec 0c             	sub    $0xc,%esp
8010566c:	68 36 7e 10 80       	push   $0x80107e36
80105671:	e8 1a ad ff ff       	call   80100390 <panic>
80105676:	8d 76 00             	lea    0x0(%esi),%esi
80105679:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105680 <sys_open>:

int
sys_open(void)
{
80105680:	55                   	push   %ebp
80105681:	89 e5                	mov    %esp,%ebp
80105683:	57                   	push   %edi
80105684:	56                   	push   %esi
80105685:	53                   	push   %ebx
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105686:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
80105689:	83 ec 24             	sub    $0x24,%esp
  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
8010568c:	50                   	push   %eax
8010568d:	6a 00                	push   $0x0
8010568f:	e8 3c f8 ff ff       	call   80104ed0 <argstr>
80105694:	83 c4 10             	add    $0x10,%esp
80105697:	85 c0                	test   %eax,%eax
80105699:	0f 88 1d 01 00 00    	js     801057bc <sys_open+0x13c>
8010569f:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801056a2:	83 ec 08             	sub    $0x8,%esp
801056a5:	50                   	push   %eax
801056a6:	6a 01                	push   $0x1
801056a8:	e8 73 f7 ff ff       	call   80104e20 <argint>
801056ad:	83 c4 10             	add    $0x10,%esp
801056b0:	85 c0                	test   %eax,%eax
801056b2:	0f 88 04 01 00 00    	js     801057bc <sys_open+0x13c>
    return -1;

  begin_op();
801056b8:	e8 13 d5 ff ff       	call   80102bd0 <begin_op>

  if(omode & O_CREATE){
801056bd:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
801056c1:	0f 85 a9 00 00 00    	jne    80105770 <sys_open+0xf0>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
801056c7:	83 ec 0c             	sub    $0xc,%esp
801056ca:	ff 75 e0             	pushl  -0x20(%ebp)
801056cd:	e8 3e c8 ff ff       	call   80101f10 <namei>
801056d2:	83 c4 10             	add    $0x10,%esp
801056d5:	85 c0                	test   %eax,%eax
801056d7:	89 c6                	mov    %eax,%esi
801056d9:	0f 84 b2 00 00 00    	je     80105791 <sys_open+0x111>
      end_op();
      return -1;
    }
    ilock(ip);
801056df:	83 ec 0c             	sub    $0xc,%esp
801056e2:	50                   	push   %eax
801056e3:	e8 c8 bf ff ff       	call   801016b0 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
801056e8:	83 c4 10             	add    $0x10,%esp
801056eb:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
801056f0:	0f 84 aa 00 00 00    	je     801057a0 <sys_open+0x120>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
801056f6:	e8 b5 b6 ff ff       	call   80100db0 <filealloc>
801056fb:	85 c0                	test   %eax,%eax
801056fd:	89 c7                	mov    %eax,%edi
801056ff:	0f 84 a6 00 00 00    	je     801057ab <sys_open+0x12b>
  struct proc *curproc = myproc();
80105705:	e8 46 e1 ff ff       	call   80103850 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
8010570a:	31 db                	xor    %ebx,%ebx
8010570c:	eb 0e                	jmp    8010571c <sys_open+0x9c>
8010570e:	66 90                	xchg   %ax,%ax
80105710:	83 c3 01             	add    $0x1,%ebx
80105713:	83 fb 10             	cmp    $0x10,%ebx
80105716:	0f 84 ac 00 00 00    	je     801057c8 <sys_open+0x148>
    if(curproc->ofile[fd] == 0){
8010571c:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105720:	85 d2                	test   %edx,%edx
80105722:	75 ec                	jne    80105710 <sys_open+0x90>
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105724:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
80105727:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
  iunlock(ip);
8010572b:	56                   	push   %esi
8010572c:	e8 5f c0 ff ff       	call   80101790 <iunlock>
  end_op();
80105731:	e8 0a d5 ff ff       	call   80102c40 <end_op>

  f->type = FD_INODE;
80105736:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
8010573c:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
8010573f:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
80105742:	89 77 10             	mov    %esi,0x10(%edi)
  f->off = 0;
80105745:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
8010574c:	89 d0                	mov    %edx,%eax
8010574e:	f7 d0                	not    %eax
80105750:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105753:	83 e2 03             	and    $0x3,%edx
  f->readable = !(omode & O_WRONLY);
80105756:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105759:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
8010575d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105760:	89 d8                	mov    %ebx,%eax
80105762:	5b                   	pop    %ebx
80105763:	5e                   	pop    %esi
80105764:	5f                   	pop    %edi
80105765:	5d                   	pop    %ebp
80105766:	c3                   	ret    
80105767:	89 f6                	mov    %esi,%esi
80105769:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    ip = create(path, T_FILE, 0, 0);
80105770:	83 ec 0c             	sub    $0xc,%esp
80105773:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105776:	31 c9                	xor    %ecx,%ecx
80105778:	6a 00                	push   $0x0
8010577a:	ba 02 00 00 00       	mov    $0x2,%edx
8010577f:	e8 ec f7 ff ff       	call   80104f70 <create>
    if(ip == 0){
80105784:	83 c4 10             	add    $0x10,%esp
80105787:	85 c0                	test   %eax,%eax
    ip = create(path, T_FILE, 0, 0);
80105789:	89 c6                	mov    %eax,%esi
    if(ip == 0){
8010578b:	0f 85 65 ff ff ff    	jne    801056f6 <sys_open+0x76>
      end_op();
80105791:	e8 aa d4 ff ff       	call   80102c40 <end_op>
      return -1;
80105796:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
8010579b:	eb c0                	jmp    8010575d <sys_open+0xdd>
8010579d:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->type == T_DIR && omode != O_RDONLY){
801057a0:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801057a3:	85 c9                	test   %ecx,%ecx
801057a5:	0f 84 4b ff ff ff    	je     801056f6 <sys_open+0x76>
    iunlockput(ip);
801057ab:	83 ec 0c             	sub    $0xc,%esp
801057ae:	56                   	push   %esi
801057af:	e8 8c c1 ff ff       	call   80101940 <iunlockput>
    end_op();
801057b4:	e8 87 d4 ff ff       	call   80102c40 <end_op>
    return -1;
801057b9:	83 c4 10             	add    $0x10,%esp
801057bc:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801057c1:	eb 9a                	jmp    8010575d <sys_open+0xdd>
801057c3:	90                   	nop
801057c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      fileclose(f);
801057c8:	83 ec 0c             	sub    $0xc,%esp
801057cb:	57                   	push   %edi
801057cc:	e8 9f b6 ff ff       	call   80100e70 <fileclose>
801057d1:	83 c4 10             	add    $0x10,%esp
801057d4:	eb d5                	jmp    801057ab <sys_open+0x12b>
801057d6:	8d 76 00             	lea    0x0(%esi),%esi
801057d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801057e0 <sys_mkdir>:

int
sys_mkdir(void)
{
801057e0:	55                   	push   %ebp
801057e1:	89 e5                	mov    %esp,%ebp
801057e3:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
801057e6:	e8 e5 d3 ff ff       	call   80102bd0 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
801057eb:	8d 45 f4             	lea    -0xc(%ebp),%eax
801057ee:	83 ec 08             	sub    $0x8,%esp
801057f1:	50                   	push   %eax
801057f2:	6a 00                	push   $0x0
801057f4:	e8 d7 f6 ff ff       	call   80104ed0 <argstr>
801057f9:	83 c4 10             	add    $0x10,%esp
801057fc:	85 c0                	test   %eax,%eax
801057fe:	78 30                	js     80105830 <sys_mkdir+0x50>
80105800:	83 ec 0c             	sub    $0xc,%esp
80105803:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105806:	31 c9                	xor    %ecx,%ecx
80105808:	6a 00                	push   $0x0
8010580a:	ba 01 00 00 00       	mov    $0x1,%edx
8010580f:	e8 5c f7 ff ff       	call   80104f70 <create>
80105814:	83 c4 10             	add    $0x10,%esp
80105817:	85 c0                	test   %eax,%eax
80105819:	74 15                	je     80105830 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010581b:	83 ec 0c             	sub    $0xc,%esp
8010581e:	50                   	push   %eax
8010581f:	e8 1c c1 ff ff       	call   80101940 <iunlockput>
  end_op();
80105824:	e8 17 d4 ff ff       	call   80102c40 <end_op>
  return 0;
80105829:	83 c4 10             	add    $0x10,%esp
8010582c:	31 c0                	xor    %eax,%eax
}
8010582e:	c9                   	leave  
8010582f:	c3                   	ret    
    end_op();
80105830:	e8 0b d4 ff ff       	call   80102c40 <end_op>
    return -1;
80105835:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010583a:	c9                   	leave  
8010583b:	c3                   	ret    
8010583c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105840 <sys_mknod>:

int
sys_mknod(void)
{
80105840:	55                   	push   %ebp
80105841:	89 e5                	mov    %esp,%ebp
80105843:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80105846:	e8 85 d3 ff ff       	call   80102bd0 <begin_op>
  if((argstr(0, &path)) < 0 ||
8010584b:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010584e:	83 ec 08             	sub    $0x8,%esp
80105851:	50                   	push   %eax
80105852:	6a 00                	push   $0x0
80105854:	e8 77 f6 ff ff       	call   80104ed0 <argstr>
80105859:	83 c4 10             	add    $0x10,%esp
8010585c:	85 c0                	test   %eax,%eax
8010585e:	78 60                	js     801058c0 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
80105860:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105863:	83 ec 08             	sub    $0x8,%esp
80105866:	50                   	push   %eax
80105867:	6a 01                	push   $0x1
80105869:	e8 b2 f5 ff ff       	call   80104e20 <argint>
  if((argstr(0, &path)) < 0 ||
8010586e:	83 c4 10             	add    $0x10,%esp
80105871:	85 c0                	test   %eax,%eax
80105873:	78 4b                	js     801058c0 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
80105875:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105878:	83 ec 08             	sub    $0x8,%esp
8010587b:	50                   	push   %eax
8010587c:	6a 02                	push   $0x2
8010587e:	e8 9d f5 ff ff       	call   80104e20 <argint>
     argint(1, &major) < 0 ||
80105883:	83 c4 10             	add    $0x10,%esp
80105886:	85 c0                	test   %eax,%eax
80105888:	78 36                	js     801058c0 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
8010588a:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
     argint(2, &minor) < 0 ||
8010588e:	83 ec 0c             	sub    $0xc,%esp
     (ip = create(path, T_DEV, major, minor)) == 0){
80105891:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
     argint(2, &minor) < 0 ||
80105895:	ba 03 00 00 00       	mov    $0x3,%edx
8010589a:	50                   	push   %eax
8010589b:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010589e:	e8 cd f6 ff ff       	call   80104f70 <create>
801058a3:	83 c4 10             	add    $0x10,%esp
801058a6:	85 c0                	test   %eax,%eax
801058a8:	74 16                	je     801058c0 <sys_mknod+0x80>
    end_op();
    return -1;
  }
  iunlockput(ip);
801058aa:	83 ec 0c             	sub    $0xc,%esp
801058ad:	50                   	push   %eax
801058ae:	e8 8d c0 ff ff       	call   80101940 <iunlockput>
  end_op();
801058b3:	e8 88 d3 ff ff       	call   80102c40 <end_op>
  return 0;
801058b8:	83 c4 10             	add    $0x10,%esp
801058bb:	31 c0                	xor    %eax,%eax
}
801058bd:	c9                   	leave  
801058be:	c3                   	ret    
801058bf:	90                   	nop
    end_op();
801058c0:	e8 7b d3 ff ff       	call   80102c40 <end_op>
    return -1;
801058c5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801058ca:	c9                   	leave  
801058cb:	c3                   	ret    
801058cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801058d0 <sys_chdir>:

int
sys_chdir(void)
{
801058d0:	55                   	push   %ebp
801058d1:	89 e5                	mov    %esp,%ebp
801058d3:	56                   	push   %esi
801058d4:	53                   	push   %ebx
801058d5:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
801058d8:	e8 73 df ff ff       	call   80103850 <myproc>
801058dd:	89 c6                	mov    %eax,%esi
  
  begin_op();
801058df:	e8 ec d2 ff ff       	call   80102bd0 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
801058e4:	8d 45 f4             	lea    -0xc(%ebp),%eax
801058e7:	83 ec 08             	sub    $0x8,%esp
801058ea:	50                   	push   %eax
801058eb:	6a 00                	push   $0x0
801058ed:	e8 de f5 ff ff       	call   80104ed0 <argstr>
801058f2:	83 c4 10             	add    $0x10,%esp
801058f5:	85 c0                	test   %eax,%eax
801058f7:	78 77                	js     80105970 <sys_chdir+0xa0>
801058f9:	83 ec 0c             	sub    $0xc,%esp
801058fc:	ff 75 f4             	pushl  -0xc(%ebp)
801058ff:	e8 0c c6 ff ff       	call   80101f10 <namei>
80105904:	83 c4 10             	add    $0x10,%esp
80105907:	85 c0                	test   %eax,%eax
80105909:	89 c3                	mov    %eax,%ebx
8010590b:	74 63                	je     80105970 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
8010590d:	83 ec 0c             	sub    $0xc,%esp
80105910:	50                   	push   %eax
80105911:	e8 9a bd ff ff       	call   801016b0 <ilock>
  if(ip->type != T_DIR){
80105916:	83 c4 10             	add    $0x10,%esp
80105919:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
8010591e:	75 30                	jne    80105950 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105920:	83 ec 0c             	sub    $0xc,%esp
80105923:	53                   	push   %ebx
80105924:	e8 67 be ff ff       	call   80101790 <iunlock>
  iput(curproc->cwd);
80105929:	58                   	pop    %eax
8010592a:	ff 76 68             	pushl  0x68(%esi)
8010592d:	e8 ae be ff ff       	call   801017e0 <iput>
  end_op();
80105932:	e8 09 d3 ff ff       	call   80102c40 <end_op>
  curproc->cwd = ip;
80105937:	89 5e 68             	mov    %ebx,0x68(%esi)
  return 0;
8010593a:	83 c4 10             	add    $0x10,%esp
8010593d:	31 c0                	xor    %eax,%eax
}
8010593f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105942:	5b                   	pop    %ebx
80105943:	5e                   	pop    %esi
80105944:	5d                   	pop    %ebp
80105945:	c3                   	ret    
80105946:	8d 76 00             	lea    0x0(%esi),%esi
80105949:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    iunlockput(ip);
80105950:	83 ec 0c             	sub    $0xc,%esp
80105953:	53                   	push   %ebx
80105954:	e8 e7 bf ff ff       	call   80101940 <iunlockput>
    end_op();
80105959:	e8 e2 d2 ff ff       	call   80102c40 <end_op>
    return -1;
8010595e:	83 c4 10             	add    $0x10,%esp
80105961:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105966:	eb d7                	jmp    8010593f <sys_chdir+0x6f>
80105968:	90                   	nop
80105969:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    end_op();
80105970:	e8 cb d2 ff ff       	call   80102c40 <end_op>
    return -1;
80105975:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010597a:	eb c3                	jmp    8010593f <sys_chdir+0x6f>
8010597c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105980 <sys_exec>:

int
sys_exec(void)
{
80105980:	55                   	push   %ebp
80105981:	89 e5                	mov    %esp,%ebp
80105983:	57                   	push   %edi
80105984:	56                   	push   %esi
80105985:	53                   	push   %ebx
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105986:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
{
8010598c:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105992:	50                   	push   %eax
80105993:	6a 00                	push   $0x0
80105995:	e8 36 f5 ff ff       	call   80104ed0 <argstr>
8010599a:	83 c4 10             	add    $0x10,%esp
8010599d:	85 c0                	test   %eax,%eax
8010599f:	0f 88 87 00 00 00    	js     80105a2c <sys_exec+0xac>
801059a5:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
801059ab:	83 ec 08             	sub    $0x8,%esp
801059ae:	50                   	push   %eax
801059af:	6a 01                	push   $0x1
801059b1:	e8 6a f4 ff ff       	call   80104e20 <argint>
801059b6:	83 c4 10             	add    $0x10,%esp
801059b9:	85 c0                	test   %eax,%eax
801059bb:	78 6f                	js     80105a2c <sys_exec+0xac>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
801059bd:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
801059c3:	83 ec 04             	sub    $0x4,%esp
  for(i=0;; i++){
801059c6:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
801059c8:	68 80 00 00 00       	push   $0x80
801059cd:	6a 00                	push   $0x0
801059cf:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
801059d5:	50                   	push   %eax
801059d6:	e8 45 f1 ff ff       	call   80104b20 <memset>
801059db:	83 c4 10             	add    $0x10,%esp
801059de:	eb 2c                	jmp    80105a0c <sys_exec+0x8c>
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
      return -1;
    if(uarg == 0){
801059e0:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
801059e6:	85 c0                	test   %eax,%eax
801059e8:	74 56                	je     80105a40 <sys_exec+0xc0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
801059ea:	8d 8d 68 ff ff ff    	lea    -0x98(%ebp),%ecx
801059f0:	83 ec 08             	sub    $0x8,%esp
801059f3:	8d 14 31             	lea    (%ecx,%esi,1),%edx
801059f6:	52                   	push   %edx
801059f7:	50                   	push   %eax
801059f8:	e8 b3 f3 ff ff       	call   80104db0 <fetchstr>
801059fd:	83 c4 10             	add    $0x10,%esp
80105a00:	85 c0                	test   %eax,%eax
80105a02:	78 28                	js     80105a2c <sys_exec+0xac>
  for(i=0;; i++){
80105a04:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
80105a07:	83 fb 20             	cmp    $0x20,%ebx
80105a0a:	74 20                	je     80105a2c <sys_exec+0xac>
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
80105a0c:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80105a12:	8d 34 9d 00 00 00 00 	lea    0x0(,%ebx,4),%esi
80105a19:	83 ec 08             	sub    $0x8,%esp
80105a1c:	57                   	push   %edi
80105a1d:	01 f0                	add    %esi,%eax
80105a1f:	50                   	push   %eax
80105a20:	e8 4b f3 ff ff       	call   80104d70 <fetchint>
80105a25:	83 c4 10             	add    $0x10,%esp
80105a28:	85 c0                	test   %eax,%eax
80105a2a:	79 b4                	jns    801059e0 <sys_exec+0x60>
      return -1;
  }
  return exec(path, argv);
}
80105a2c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
80105a2f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105a34:	5b                   	pop    %ebx
80105a35:	5e                   	pop    %esi
80105a36:	5f                   	pop    %edi
80105a37:	5d                   	pop    %ebp
80105a38:	c3                   	ret    
80105a39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return exec(path, argv);
80105a40:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80105a46:	83 ec 08             	sub    $0x8,%esp
      argv[i] = 0;
80105a49:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
80105a50:	00 00 00 00 
  return exec(path, argv);
80105a54:	50                   	push   %eax
80105a55:	ff b5 5c ff ff ff    	pushl  -0xa4(%ebp)
80105a5b:	e8 b0 af ff ff       	call   80100a10 <exec>
80105a60:	83 c4 10             	add    $0x10,%esp
}
80105a63:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105a66:	5b                   	pop    %ebx
80105a67:	5e                   	pop    %esi
80105a68:	5f                   	pop    %edi
80105a69:	5d                   	pop    %ebp
80105a6a:	c3                   	ret    
80105a6b:	90                   	nop
80105a6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105a70 <sys_pipe>:

int
sys_pipe(void)
{
80105a70:	55                   	push   %ebp
80105a71:	89 e5                	mov    %esp,%ebp
80105a73:	57                   	push   %edi
80105a74:	56                   	push   %esi
80105a75:	53                   	push   %ebx
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105a76:	8d 45 dc             	lea    -0x24(%ebp),%eax
{
80105a79:	83 ec 20             	sub    $0x20,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105a7c:	6a 08                	push   $0x8
80105a7e:	50                   	push   %eax
80105a7f:	6a 00                	push   $0x0
80105a81:	e8 ea f3 ff ff       	call   80104e70 <argptr>
80105a86:	83 c4 10             	add    $0x10,%esp
80105a89:	85 c0                	test   %eax,%eax
80105a8b:	0f 88 ae 00 00 00    	js     80105b3f <sys_pipe+0xcf>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
80105a91:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105a94:	83 ec 08             	sub    $0x8,%esp
80105a97:	50                   	push   %eax
80105a98:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105a9b:	50                   	push   %eax
80105a9c:	e8 cf d7 ff ff       	call   80103270 <pipealloc>
80105aa1:	83 c4 10             	add    $0x10,%esp
80105aa4:	85 c0                	test   %eax,%eax
80105aa6:	0f 88 93 00 00 00    	js     80105b3f <sys_pipe+0xcf>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105aac:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
80105aaf:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
80105ab1:	e8 9a dd ff ff       	call   80103850 <myproc>
80105ab6:	eb 10                	jmp    80105ac8 <sys_pipe+0x58>
80105ab8:	90                   	nop
80105ab9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(fd = 0; fd < NOFILE; fd++){
80105ac0:	83 c3 01             	add    $0x1,%ebx
80105ac3:	83 fb 10             	cmp    $0x10,%ebx
80105ac6:	74 60                	je     80105b28 <sys_pipe+0xb8>
    if(curproc->ofile[fd] == 0){
80105ac8:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
80105acc:	85 f6                	test   %esi,%esi
80105ace:	75 f0                	jne    80105ac0 <sys_pipe+0x50>
      curproc->ofile[fd] = f;
80105ad0:	8d 73 08             	lea    0x8(%ebx),%esi
80105ad3:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105ad7:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
80105ada:	e8 71 dd ff ff       	call   80103850 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80105adf:	31 d2                	xor    %edx,%edx
80105ae1:	eb 0d                	jmp    80105af0 <sys_pipe+0x80>
80105ae3:	90                   	nop
80105ae4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105ae8:	83 c2 01             	add    $0x1,%edx
80105aeb:	83 fa 10             	cmp    $0x10,%edx
80105aee:	74 28                	je     80105b18 <sys_pipe+0xa8>
    if(curproc->ofile[fd] == 0){
80105af0:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
80105af4:	85 c9                	test   %ecx,%ecx
80105af6:	75 f0                	jne    80105ae8 <sys_pipe+0x78>
      curproc->ofile[fd] = f;
80105af8:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
80105afc:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105aff:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
80105b01:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105b04:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
80105b07:	31 c0                	xor    %eax,%eax
}
80105b09:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105b0c:	5b                   	pop    %ebx
80105b0d:	5e                   	pop    %esi
80105b0e:	5f                   	pop    %edi
80105b0f:	5d                   	pop    %ebp
80105b10:	c3                   	ret    
80105b11:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      myproc()->ofile[fd0] = 0;
80105b18:	e8 33 dd ff ff       	call   80103850 <myproc>
80105b1d:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
80105b24:	00 
80105b25:	8d 76 00             	lea    0x0(%esi),%esi
    fileclose(rf);
80105b28:	83 ec 0c             	sub    $0xc,%esp
80105b2b:	ff 75 e0             	pushl  -0x20(%ebp)
80105b2e:	e8 3d b3 ff ff       	call   80100e70 <fileclose>
    fileclose(wf);
80105b33:	58                   	pop    %eax
80105b34:	ff 75 e4             	pushl  -0x1c(%ebp)
80105b37:	e8 34 b3 ff ff       	call   80100e70 <fileclose>
    return -1;
80105b3c:	83 c4 10             	add    $0x10,%esp
80105b3f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105b44:	eb c3                	jmp    80105b09 <sys_pipe+0x99>
80105b46:	66 90                	xchg   %ax,%ax
80105b48:	66 90                	xchg   %ax,%ax
80105b4a:	66 90                	xchg   %ax,%ax
80105b4c:	66 90                	xchg   %ax,%ax
80105b4e:	66 90                	xchg   %ax,%ax

80105b50 <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
80105b50:	55                   	push   %ebp
80105b51:	89 e5                	mov    %esp,%ebp
  return fork();
}
80105b53:	5d                   	pop    %ebp
  return fork();
80105b54:	e9 07 e0 ff ff       	jmp    80103b60 <fork>
80105b59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105b60 <sys_exit>:

int
sys_exit(void)
{
80105b60:	55                   	push   %ebp
80105b61:	89 e5                	mov    %esp,%ebp
80105b63:	83 ec 08             	sub    $0x8,%esp
  exit();
80105b66:	e8 d5 e2 ff ff       	call   80103e40 <exit>
  return 0;  // not reached
}
80105b6b:	31 c0                	xor    %eax,%eax
80105b6d:	c9                   	leave  
80105b6e:	c3                   	ret    
80105b6f:	90                   	nop

80105b70 <sys_wait>:

int
sys_wait(void)
{
80105b70:	55                   	push   %ebp
80105b71:	89 e5                	mov    %esp,%ebp
  return wait();
}
80105b73:	5d                   	pop    %ebp
  return wait();
80105b74:	e9 17 e5 ff ff       	jmp    80104090 <wait>
80105b79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105b80 <sys_kill>:

int
sys_kill(void)
{
80105b80:	55                   	push   %ebp
80105b81:	89 e5                	mov    %esp,%ebp
80105b83:	83 ec 20             	sub    $0x20,%esp
  int pid;
  int signum;

  if(argint(0, &pid) < 0)
80105b86:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105b89:	50                   	push   %eax
80105b8a:	6a 00                	push   $0x0
80105b8c:	e8 8f f2 ff ff       	call   80104e20 <argint>
80105b91:	83 c4 10             	add    $0x10,%esp
80105b94:	85 c0                	test   %eax,%eax
80105b96:	78 28                	js     80105bc0 <sys_kill+0x40>
    return -1;
  if(argint(1, &signum) < 0)
80105b98:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105b9b:	83 ec 08             	sub    $0x8,%esp
80105b9e:	50                   	push   %eax
80105b9f:	6a 01                	push   $0x1
80105ba1:	e8 7a f2 ff ff       	call   80104e20 <argint>
80105ba6:	83 c4 10             	add    $0x10,%esp
80105ba9:	85 c0                	test   %eax,%eax
80105bab:	78 13                	js     80105bc0 <sys_kill+0x40>
    return -1;
  return kill(pid, signum);
80105bad:	83 ec 08             	sub    $0x8,%esp
80105bb0:	ff 75 f4             	pushl  -0xc(%ebp)
80105bb3:	ff 75 f0             	pushl  -0x10(%ebp)
80105bb6:	e8 35 e6 ff ff       	call   801041f0 <kill>
80105bbb:	83 c4 10             	add    $0x10,%esp
}
80105bbe:	c9                   	leave  
80105bbf:	c3                   	ret    
    return -1;
80105bc0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105bc5:	c9                   	leave  
80105bc6:	c3                   	ret    
80105bc7:	89 f6                	mov    %esi,%esi
80105bc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105bd0 <sys_getpid>:

int
sys_getpid(void)
{
80105bd0:	55                   	push   %ebp
80105bd1:	89 e5                	mov    %esp,%ebp
80105bd3:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
80105bd6:	e8 75 dc ff ff       	call   80103850 <myproc>
80105bdb:	8b 40 10             	mov    0x10(%eax),%eax
}
80105bde:	c9                   	leave  
80105bdf:	c3                   	ret    

80105be0 <sys_sbrk>:

int
sys_sbrk(void)
{
80105be0:	55                   	push   %ebp
80105be1:	89 e5                	mov    %esp,%ebp
80105be3:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
80105be4:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105be7:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
80105bea:	50                   	push   %eax
80105beb:	6a 00                	push   $0x0
80105bed:	e8 2e f2 ff ff       	call   80104e20 <argint>
80105bf2:	83 c4 10             	add    $0x10,%esp
80105bf5:	85 c0                	test   %eax,%eax
80105bf7:	78 27                	js     80105c20 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
80105bf9:	e8 52 dc ff ff       	call   80103850 <myproc>
  if(growproc(n) < 0)
80105bfe:	83 ec 0c             	sub    $0xc,%esp
  addr = myproc()->sz;
80105c01:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80105c03:	ff 75 f4             	pushl  -0xc(%ebp)
80105c06:	e8 d5 de ff ff       	call   80103ae0 <growproc>
80105c0b:	83 c4 10             	add    $0x10,%esp
80105c0e:	85 c0                	test   %eax,%eax
80105c10:	78 0e                	js     80105c20 <sys_sbrk+0x40>
    return -1;
  return addr;
}
80105c12:	89 d8                	mov    %ebx,%eax
80105c14:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105c17:	c9                   	leave  
80105c18:	c3                   	ret    
80105c19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105c20:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105c25:	eb eb                	jmp    80105c12 <sys_sbrk+0x32>
80105c27:	89 f6                	mov    %esi,%esi
80105c29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105c30 <sys_sleep>:

int
sys_sleep(void)
{
80105c30:	55                   	push   %ebp
80105c31:	89 e5                	mov    %esp,%ebp
80105c33:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80105c34:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105c37:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
80105c3a:	50                   	push   %eax
80105c3b:	6a 00                	push   $0x0
80105c3d:	e8 de f1 ff ff       	call   80104e20 <argint>
80105c42:	83 c4 10             	add    $0x10,%esp
80105c45:	85 c0                	test   %eax,%eax
80105c47:	0f 88 8a 00 00 00    	js     80105cd7 <sys_sleep+0xa7>
    return -1;
  acquire(&tickslock);
80105c4d:	83 ec 0c             	sub    $0xc,%esp
80105c50:	68 60 a4 11 80       	push   $0x8011a460
80105c55:	e8 b6 ed ff ff       	call   80104a10 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
80105c5a:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105c5d:	83 c4 10             	add    $0x10,%esp
  ticks0 = ticks;
80105c60:	8b 1d a0 ac 11 80    	mov    0x8011aca0,%ebx
  while(ticks - ticks0 < n){
80105c66:	85 d2                	test   %edx,%edx
80105c68:	75 27                	jne    80105c91 <sys_sleep+0x61>
80105c6a:	eb 54                	jmp    80105cc0 <sys_sleep+0x90>
80105c6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80105c70:	83 ec 08             	sub    $0x8,%esp
80105c73:	68 60 a4 11 80       	push   $0x8011a460
80105c78:	68 a0 ac 11 80       	push   $0x8011aca0
80105c7d:	e8 4e e3 ff ff       	call   80103fd0 <sleep>
  while(ticks - ticks0 < n){
80105c82:	a1 a0 ac 11 80       	mov    0x8011aca0,%eax
80105c87:	83 c4 10             	add    $0x10,%esp
80105c8a:	29 d8                	sub    %ebx,%eax
80105c8c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80105c8f:	73 2f                	jae    80105cc0 <sys_sleep+0x90>
    if(myproc()->killed){
80105c91:	e8 ba db ff ff       	call   80103850 <myproc>
80105c96:	8b 40 24             	mov    0x24(%eax),%eax
80105c99:	85 c0                	test   %eax,%eax
80105c9b:	74 d3                	je     80105c70 <sys_sleep+0x40>
      release(&tickslock);
80105c9d:	83 ec 0c             	sub    $0xc,%esp
80105ca0:	68 60 a4 11 80       	push   $0x8011a460
80105ca5:	e8 26 ee ff ff       	call   80104ad0 <release>
      return -1;
80105caa:	83 c4 10             	add    $0x10,%esp
80105cad:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  release(&tickslock);
  return 0;
}
80105cb2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105cb5:	c9                   	leave  
80105cb6:	c3                   	ret    
80105cb7:	89 f6                	mov    %esi,%esi
80105cb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  release(&tickslock);
80105cc0:	83 ec 0c             	sub    $0xc,%esp
80105cc3:	68 60 a4 11 80       	push   $0x8011a460
80105cc8:	e8 03 ee ff ff       	call   80104ad0 <release>
  return 0;
80105ccd:	83 c4 10             	add    $0x10,%esp
80105cd0:	31 c0                	xor    %eax,%eax
}
80105cd2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105cd5:	c9                   	leave  
80105cd6:	c3                   	ret    
    return -1;
80105cd7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105cdc:	eb f4                	jmp    80105cd2 <sys_sleep+0xa2>
80105cde:	66 90                	xchg   %ax,%ax

80105ce0 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80105ce0:	55                   	push   %ebp
80105ce1:	89 e5                	mov    %esp,%ebp
80105ce3:	53                   	push   %ebx
80105ce4:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
80105ce7:	68 60 a4 11 80       	push   $0x8011a460
80105cec:	e8 1f ed ff ff       	call   80104a10 <acquire>
  xticks = ticks;
80105cf1:	8b 1d a0 ac 11 80    	mov    0x8011aca0,%ebx
  release(&tickslock);
80105cf7:	c7 04 24 60 a4 11 80 	movl   $0x8011a460,(%esp)
80105cfe:	e8 cd ed ff ff       	call   80104ad0 <release>
  return xticks;
}
80105d03:	89 d8                	mov    %ebx,%eax
80105d05:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105d08:	c9                   	leave  
80105d09:	c3                   	ret    
80105d0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105d10 <sys_sigprocmask>:

int 
 sys_sigprocmask(void){
80105d10:	55                   	push   %ebp
80105d11:	89 e5                	mov    %esp,%ebp
80105d13:	83 ec 20             	sub    $0x20,%esp
  uint mask;

  if(argint(0, (int *)&mask) < 0)
80105d16:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105d19:	50                   	push   %eax
80105d1a:	6a 00                	push   $0x0
80105d1c:	e8 ff f0 ff ff       	call   80104e20 <argint>
80105d21:	83 c4 10             	add    $0x10,%esp
80105d24:	85 c0                	test   %eax,%eax
80105d26:	78 18                	js     80105d40 <sys_sigprocmask+0x30>
    return -1;
  
  return sigprocmask(mask);
80105d28:	83 ec 0c             	sub    $0xc,%esp
80105d2b:	ff 75 f4             	pushl  -0xc(%ebp)
80105d2e:	e8 8d e6 ff ff       	call   801043c0 <sigprocmask>
80105d33:	83 c4 10             	add    $0x10,%esp
 }
80105d36:	c9                   	leave  
80105d37:	c3                   	ret    
80105d38:	90                   	nop
80105d39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105d40:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 }
80105d45:	c9                   	leave  
80105d46:	c3                   	ret    
80105d47:	89 f6                	mov    %esi,%esi
80105d49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105d50 <sys_sigaction>:

 int
 sys_sigaction(void){
80105d50:	55                   	push   %ebp
80105d51:	89 e5                	mov    %esp,%ebp
80105d53:	83 ec 20             	sub    $0x20,%esp
   int signum;
   char *act;
   char *oldact;

  if(argint(0, &signum) < 0)
80105d56:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105d59:	50                   	push   %eax
80105d5a:	6a 00                	push   $0x0
80105d5c:	e8 bf f0 ff ff       	call   80104e20 <argint>
80105d61:	83 c4 10             	add    $0x10,%esp
80105d64:	85 c0                	test   %eax,%eax
80105d66:	78 48                	js     80105db0 <sys_sigaction+0x60>
    return -1;
  if(argptr(1, &act, sizeof(struct sigaction)) < 0)
80105d68:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105d6b:	83 ec 04             	sub    $0x4,%esp
80105d6e:	6a 08                	push   $0x8
80105d70:	50                   	push   %eax
80105d71:	6a 01                	push   $0x1
80105d73:	e8 f8 f0 ff ff       	call   80104e70 <argptr>
80105d78:	83 c4 10             	add    $0x10,%esp
80105d7b:	85 c0                	test   %eax,%eax
80105d7d:	78 31                	js     80105db0 <sys_sigaction+0x60>
    return -1;
  
  if(argptr(2, &oldact, sizeof(struct sigaction)) < 0)
80105d7f:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105d82:	83 ec 04             	sub    $0x4,%esp
80105d85:	6a 08                	push   $0x8
80105d87:	50                   	push   %eax
80105d88:	6a 02                	push   $0x2
80105d8a:	e8 e1 f0 ff ff       	call   80104e70 <argptr>
80105d8f:	83 c4 10             	add    $0x10,%esp
80105d92:	85 c0                	test   %eax,%eax
80105d94:	78 1a                	js     80105db0 <sys_sigaction+0x60>
    return -1;
  
  return sigaction(signum,(struct sigaction *)act, (struct sigaction *)oldact);
80105d96:	83 ec 04             	sub    $0x4,%esp
80105d99:	ff 75 f4             	pushl  -0xc(%ebp)
80105d9c:	ff 75 f0             	pushl  -0x10(%ebp)
80105d9f:	ff 75 ec             	pushl  -0x14(%ebp)
80105da2:	e8 59 e6 ff ff       	call   80104400 <sigaction>
80105da7:	83 c4 10             	add    $0x10,%esp
 }
80105daa:	c9                   	leave  
80105dab:	c3                   	ret    
80105dac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105db0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 }
80105db5:	c9                   	leave  
80105db6:	c3                   	ret    
80105db7:	89 f6                	mov    %esi,%esi
80105db9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105dc0 <sys_sigret>:

 int
 sys_sigret(void){
80105dc0:	55                   	push   %ebp
80105dc1:	89 e5                	mov    %esp,%ebp
80105dc3:	83 ec 08             	sub    $0x8,%esp
   sigret();
80105dc6:	e8 b5 e6 ff ff       	call   80104480 <sigret>
   return 0;
 }
80105dcb:	31 c0                	xor    %eax,%eax
80105dcd:	c9                   	leave  
80105dce:	c3                   	ret    

80105dcf <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
80105dcf:	1e                   	push   %ds
  pushl %es
80105dd0:	06                   	push   %es
  pushl %fs
80105dd1:	0f a0                	push   %fs
  pushl %gs
80105dd3:	0f a8                	push   %gs
  pushal
80105dd5:	60                   	pusha  
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
80105dd6:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80105dda:	8e d8                	mov    %eax,%ds
  movw %ax, %es
80105ddc:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
80105dde:	54                   	push   %esp
  call trap
80105ddf:	e8 dc 00 00 00       	call   80105ec0 <trap>
  addl $4, %esp
80105de4:	83 c4 04             	add    $0x4,%esp

80105de7 <trapret>:
  # Return falls through to trapret...
.globl trapret
.globl trapret_handler

trapret:
  call check_for_signals
80105de7:	e8 84 e8 ff ff       	call   80104670 <check_for_signals>
  popal
80105dec:	61                   	popa   
  popl %gs
80105ded:	0f a9                	pop    %gs
  popl %fs
80105def:	0f a1                	pop    %fs
  popl %es
80105df1:	07                   	pop    %es
  popl %ds
80105df2:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80105df3:	83 c4 08             	add    $0x8,%esp
  iret
80105df6:	cf                   	iret   

80105df7 <trapret_handler>:

trapret_handler:
  popl %eax  #return address of call trapret_handler 
80105df7:	58                   	pop    %eax
  popl %esp  #trapframe
80105df8:	5c                   	pop    %esp
  popal
80105df9:	61                   	popa   
  popl %gs
80105dfa:	0f a9                	pop    %gs
  popl %fs
80105dfc:	0f a1                	pop    %fs
  popl %es
80105dfe:	07                   	pop    %es
  popl %ds
80105dff:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80105e00:	83 c4 08             	add    $0x8,%esp
  iret
80105e03:	cf                   	iret   
80105e04:	66 90                	xchg   %ax,%ax
80105e06:	66 90                	xchg   %ax,%ax
80105e08:	66 90                	xchg   %ax,%ax
80105e0a:	66 90                	xchg   %ax,%ax
80105e0c:	66 90                	xchg   %ax,%ax
80105e0e:	66 90                	xchg   %ax,%ax

80105e10 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80105e10:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
80105e11:	31 c0                	xor    %eax,%eax
{
80105e13:	89 e5                	mov    %esp,%ebp
80105e15:	83 ec 08             	sub    $0x8,%esp
80105e18:	90                   	nop
80105e19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80105e20:	8b 14 85 08 b0 10 80 	mov    -0x7fef4ff8(,%eax,4),%edx
80105e27:	c7 04 c5 a2 a4 11 80 	movl   $0x8e000008,-0x7fee5b5e(,%eax,8)
80105e2e:	08 00 00 8e 
80105e32:	66 89 14 c5 a0 a4 11 	mov    %dx,-0x7fee5b60(,%eax,8)
80105e39:	80 
80105e3a:	c1 ea 10             	shr    $0x10,%edx
80105e3d:	66 89 14 c5 a6 a4 11 	mov    %dx,-0x7fee5b5a(,%eax,8)
80105e44:	80 
  for(i = 0; i < 256; i++)
80105e45:	83 c0 01             	add    $0x1,%eax
80105e48:	3d 00 01 00 00       	cmp    $0x100,%eax
80105e4d:	75 d1                	jne    80105e20 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105e4f:	a1 08 b1 10 80       	mov    0x8010b108,%eax

  initlock(&tickslock, "time");
80105e54:	83 ec 08             	sub    $0x8,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105e57:	c7 05 a2 a6 11 80 08 	movl   $0xef000008,0x8011a6a2
80105e5e:	00 00 ef 
  initlock(&tickslock, "time");
80105e61:	68 45 7e 10 80       	push   $0x80107e45
80105e66:	68 60 a4 11 80       	push   $0x8011a460
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105e6b:	66 a3 a0 a6 11 80    	mov    %ax,0x8011a6a0
80105e71:	c1 e8 10             	shr    $0x10,%eax
80105e74:	66 a3 a6 a6 11 80    	mov    %ax,0x8011a6a6
  initlock(&tickslock, "time");
80105e7a:	e8 51 ea ff ff       	call   801048d0 <initlock>
}
80105e7f:	83 c4 10             	add    $0x10,%esp
80105e82:	c9                   	leave  
80105e83:	c3                   	ret    
80105e84:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105e8a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80105e90 <idtinit>:

void
idtinit(void)
{
80105e90:	55                   	push   %ebp
  pd[0] = size-1;
80105e91:	b8 ff 07 00 00       	mov    $0x7ff,%eax
80105e96:	89 e5                	mov    %esp,%ebp
80105e98:	83 ec 10             	sub    $0x10,%esp
80105e9b:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
80105e9f:	b8 a0 a4 11 80       	mov    $0x8011a4a0,%eax
80105ea4:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80105ea8:	c1 e8 10             	shr    $0x10,%eax
80105eab:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
80105eaf:	8d 45 fa             	lea    -0x6(%ebp),%eax
80105eb2:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80105eb5:	c9                   	leave  
80105eb6:	c3                   	ret    
80105eb7:	89 f6                	mov    %esi,%esi
80105eb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105ec0 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80105ec0:	55                   	push   %ebp
80105ec1:	89 e5                	mov    %esp,%ebp
80105ec3:	57                   	push   %edi
80105ec4:	56                   	push   %esi
80105ec5:	53                   	push   %ebx
80105ec6:	83 ec 1c             	sub    $0x1c,%esp
80105ec9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  
  if(tf->trapno == T_SYSCALL){
80105ecc:	8b 43 30             	mov    0x30(%ebx),%eax
80105ecf:	83 f8 40             	cmp    $0x40,%eax
80105ed2:	0f 84 f8 00 00 00    	je     80105fd0 <trap+0x110>
      exit();
    *tf = *(myproc()->tf); 
    return;
  }

  switch(tf->trapno){
80105ed8:	83 e8 20             	sub    $0x20,%eax
80105edb:	83 f8 1f             	cmp    $0x1f,%eax
80105ede:	77 10                	ja     80105ef0 <trap+0x30>
80105ee0:	ff 24 85 ec 7e 10 80 	jmp    *-0x7fef8114(,%eax,4)
80105ee7:	89 f6                	mov    %esi,%esi
80105ee9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    lapiceoi();
    break;

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
80105ef0:	e8 5b d9 ff ff       	call   80103850 <myproc>
80105ef5:	85 c0                	test   %eax,%eax
80105ef7:	8b 7b 38             	mov    0x38(%ebx),%edi
80105efa:	0f 84 5c 02 00 00    	je     8010615c <trap+0x29c>
80105f00:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
80105f04:	0f 84 52 02 00 00    	je     8010615c <trap+0x29c>
  asm volatile("movl %%cr2,%0" : "=r" (val));
80105f0a:	0f 20 d1             	mov    %cr2,%ecx
80105f0d:	89 4d d8             	mov    %ecx,-0x28(%ebp)
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105f10:	e8 1b d9 ff ff       	call   80103830 <cpuid>
80105f15:	89 45 dc             	mov    %eax,-0x24(%ebp)
80105f18:	8b 43 34             	mov    0x34(%ebx),%eax
80105f1b:	8b 73 30             	mov    0x30(%ebx),%esi
80105f1e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80105f21:	e8 2a d9 ff ff       	call   80103850 <myproc>
80105f26:	89 45 e0             	mov    %eax,-0x20(%ebp)
80105f29:	e8 22 d9 ff ff       	call   80103850 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105f2e:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80105f31:	8b 55 dc             	mov    -0x24(%ebp),%edx
80105f34:	51                   	push   %ecx
80105f35:	57                   	push   %edi
80105f36:	52                   	push   %edx
            myproc()->pid, myproc()->name, tf->trapno,
80105f37:	8b 55 e0             	mov    -0x20(%ebp),%edx
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105f3a:	ff 75 e4             	pushl  -0x1c(%ebp)
80105f3d:	56                   	push   %esi
            myproc()->pid, myproc()->name, tf->trapno,
80105f3e:	83 c2 6c             	add    $0x6c,%edx
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105f41:	52                   	push   %edx
80105f42:	ff 70 10             	pushl  0x10(%eax)
80105f45:	68 a8 7e 10 80       	push   $0x80107ea8
80105f4a:	e8 11 a7 ff ff       	call   80100660 <cprintf>
            tf->err, cpuid(), tf->eip, rcr2());
    myproc()->killed = 1;
80105f4f:	83 c4 20             	add    $0x20,%esp
80105f52:	e8 f9 d8 ff ff       	call   80103850 <myproc>
80105f57:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105f5e:	e8 ed d8 ff ff       	call   80103850 <myproc>
80105f63:	85 c0                	test   %eax,%eax
80105f65:	74 1d                	je     80105f84 <trap+0xc4>
80105f67:	e8 e4 d8 ff ff       	call   80103850 <myproc>
80105f6c:	8b 50 24             	mov    0x24(%eax),%edx
80105f6f:	85 d2                	test   %edx,%edx
80105f71:	74 11                	je     80105f84 <trap+0xc4>
80105f73:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80105f77:	83 e0 03             	and    $0x3,%eax
80105f7a:	66 83 f8 03          	cmp    $0x3,%ax
80105f7e:	0f 84 94 01 00 00    	je     80106118 <trap+0x258>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80105f84:	e8 c7 d8 ff ff       	call   80103850 <myproc>
80105f89:	85 c0                	test   %eax,%eax
80105f8b:	74 0f                	je     80105f9c <trap+0xdc>
80105f8d:	e8 be d8 ff ff       	call   80103850 <myproc>
80105f92:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80105f96:	0f 84 84 00 00 00    	je     80106020 <trap+0x160>
    yield();
    //check_for_signals();
   }

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105f9c:	e8 af d8 ff ff       	call   80103850 <myproc>
80105fa1:	85 c0                	test   %eax,%eax
80105fa3:	74 1d                	je     80105fc2 <trap+0x102>
80105fa5:	e8 a6 d8 ff ff       	call   80103850 <myproc>
80105faa:	8b 40 24             	mov    0x24(%eax),%eax
80105fad:	85 c0                	test   %eax,%eax
80105faf:	74 11                	je     80105fc2 <trap+0x102>
80105fb1:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80105fb5:	83 e0 03             	and    $0x3,%eax
80105fb8:	66 83 f8 03          	cmp    $0x3,%ax
80105fbc:	0f 84 46 01 00 00    	je     80106108 <trap+0x248>
    exit();
}
80105fc2:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105fc5:	5b                   	pop    %ebx
80105fc6:	5e                   	pop    %esi
80105fc7:	5f                   	pop    %edi
80105fc8:	5d                   	pop    %ebp
80105fc9:	c3                   	ret    
80105fca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(myproc()->killed)
80105fd0:	e8 7b d8 ff ff       	call   80103850 <myproc>
80105fd5:	8b 70 24             	mov    0x24(%eax),%esi
80105fd8:	85 f6                	test   %esi,%esi
80105fda:	0f 85 18 01 00 00    	jne    801060f8 <trap+0x238>
    myproc()->tf = tf;
80105fe0:	e8 6b d8 ff ff       	call   80103850 <myproc>
80105fe5:	89 58 18             	mov    %ebx,0x18(%eax)
    syscall();
80105fe8:	e8 23 ef ff ff       	call   80104f10 <syscall>
    if(myproc()->killed)
80105fed:	e8 5e d8 ff ff       	call   80103850 <myproc>
80105ff2:	8b 48 24             	mov    0x24(%eax),%ecx
80105ff5:	85 c9                	test   %ecx,%ecx
80105ff7:	0f 85 eb 00 00 00    	jne    801060e8 <trap+0x228>
    *tf = *(myproc()->tf); 
80105ffd:	e8 4e d8 ff ff       	call   80103850 <myproc>
80106002:	89 df                	mov    %ebx,%edi
80106004:	8b 70 18             	mov    0x18(%eax),%esi
80106007:	b9 13 00 00 00       	mov    $0x13,%ecx
8010600c:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
}
8010600e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106011:	5b                   	pop    %ebx
80106012:	5e                   	pop    %esi
80106013:	5f                   	pop    %edi
80106014:	5d                   	pop    %ebp
80106015:	c3                   	ret    
80106016:	8d 76 00             	lea    0x0(%esi),%esi
80106019:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  if(myproc() && myproc()->state == RUNNING &&
80106020:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
80106024:	0f 85 72 ff ff ff    	jne    80105f9c <trap+0xdc>
    yield();
8010602a:	e8 51 df ff ff       	call   80103f80 <yield>
8010602f:	e9 68 ff ff ff       	jmp    80105f9c <trap+0xdc>
80106034:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(cpuid() == 0){
80106038:	e8 f3 d7 ff ff       	call   80103830 <cpuid>
8010603d:	85 c0                	test   %eax,%eax
8010603f:	0f 84 e3 00 00 00    	je     80106128 <trap+0x268>
    lapiceoi();
80106045:	e8 36 c7 ff ff       	call   80102780 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010604a:	e8 01 d8 ff ff       	call   80103850 <myproc>
8010604f:	85 c0                	test   %eax,%eax
80106051:	0f 85 10 ff ff ff    	jne    80105f67 <trap+0xa7>
80106057:	e9 28 ff ff ff       	jmp    80105f84 <trap+0xc4>
8010605c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    kbdintr();
80106060:	e8 db c5 ff ff       	call   80102640 <kbdintr>
    lapiceoi();
80106065:	e8 16 c7 ff ff       	call   80102780 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010606a:	e8 e1 d7 ff ff       	call   80103850 <myproc>
8010606f:	85 c0                	test   %eax,%eax
80106071:	0f 85 f0 fe ff ff    	jne    80105f67 <trap+0xa7>
80106077:	e9 08 ff ff ff       	jmp    80105f84 <trap+0xc4>
8010607c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    uartintr();
80106080:	e8 7b 02 00 00       	call   80106300 <uartintr>
    lapiceoi();
80106085:	e8 f6 c6 ff ff       	call   80102780 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010608a:	e8 c1 d7 ff ff       	call   80103850 <myproc>
8010608f:	85 c0                	test   %eax,%eax
80106091:	0f 85 d0 fe ff ff    	jne    80105f67 <trap+0xa7>
80106097:	e9 e8 fe ff ff       	jmp    80105f84 <trap+0xc4>
8010609c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
801060a0:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
801060a4:	8b 7b 38             	mov    0x38(%ebx),%edi
801060a7:	e8 84 d7 ff ff       	call   80103830 <cpuid>
801060ac:	57                   	push   %edi
801060ad:	56                   	push   %esi
801060ae:	50                   	push   %eax
801060af:	68 50 7e 10 80       	push   $0x80107e50
801060b4:	e8 a7 a5 ff ff       	call   80100660 <cprintf>
    lapiceoi();
801060b9:	e8 c2 c6 ff ff       	call   80102780 <lapiceoi>
    break;
801060be:	83 c4 10             	add    $0x10,%esp
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801060c1:	e8 8a d7 ff ff       	call   80103850 <myproc>
801060c6:	85 c0                	test   %eax,%eax
801060c8:	0f 85 99 fe ff ff    	jne    80105f67 <trap+0xa7>
801060ce:	e9 b1 fe ff ff       	jmp    80105f84 <trap+0xc4>
801060d3:	90                   	nop
801060d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ideintr();
801060d8:	e8 d3 bf ff ff       	call   801020b0 <ideintr>
801060dd:	e9 63 ff ff ff       	jmp    80106045 <trap+0x185>
801060e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit();
801060e8:	e8 53 dd ff ff       	call   80103e40 <exit>
801060ed:	e9 0b ff ff ff       	jmp    80105ffd <trap+0x13d>
801060f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit();
801060f8:	e8 43 dd ff ff       	call   80103e40 <exit>
801060fd:	e9 de fe ff ff       	jmp    80105fe0 <trap+0x120>
80106102:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
}
80106108:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010610b:	5b                   	pop    %ebx
8010610c:	5e                   	pop    %esi
8010610d:	5f                   	pop    %edi
8010610e:	5d                   	pop    %ebp
    exit();
8010610f:	e9 2c dd ff ff       	jmp    80103e40 <exit>
80106114:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    exit();
80106118:	e8 23 dd ff ff       	call   80103e40 <exit>
8010611d:	e9 62 fe ff ff       	jmp    80105f84 <trap+0xc4>
80106122:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      acquire(&tickslock);
80106128:	83 ec 0c             	sub    $0xc,%esp
8010612b:	68 60 a4 11 80       	push   $0x8011a460
80106130:	e8 db e8 ff ff       	call   80104a10 <acquire>
      wakeup(&ticks);
80106135:	c7 04 24 a0 ac 11 80 	movl   $0x8011aca0,(%esp)
      ticks++;
8010613c:	83 05 a0 ac 11 80 01 	addl   $0x1,0x8011aca0
      wakeup(&ticks);
80106143:	e8 88 e0 ff ff       	call   801041d0 <wakeup>
      release(&tickslock);
80106148:	c7 04 24 60 a4 11 80 	movl   $0x8011a460,(%esp)
8010614f:	e8 7c e9 ff ff       	call   80104ad0 <release>
80106154:	83 c4 10             	add    $0x10,%esp
80106157:	e9 e9 fe ff ff       	jmp    80106045 <trap+0x185>
8010615c:	0f 20 d6             	mov    %cr2,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
8010615f:	e8 cc d6 ff ff       	call   80103830 <cpuid>
80106164:	83 ec 0c             	sub    $0xc,%esp
80106167:	56                   	push   %esi
80106168:	57                   	push   %edi
80106169:	50                   	push   %eax
8010616a:	ff 73 30             	pushl  0x30(%ebx)
8010616d:	68 74 7e 10 80       	push   $0x80107e74
80106172:	e8 e9 a4 ff ff       	call   80100660 <cprintf>
      panic("trap");
80106177:	83 c4 14             	add    $0x14,%esp
8010617a:	68 4a 7e 10 80       	push   $0x80107e4a
8010617f:	e8 0c a2 ff ff       	call   80100390 <panic>
80106184:	66 90                	xchg   %ax,%ax
80106186:	66 90                	xchg   %ax,%ax
80106188:	66 90                	xchg   %ax,%ax
8010618a:	66 90                	xchg   %ax,%ax
8010618c:	66 90                	xchg   %ax,%ax
8010618e:	66 90                	xchg   %ax,%ax

80106190 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80106190:	a1 bc b5 10 80       	mov    0x8010b5bc,%eax
{
80106195:	55                   	push   %ebp
80106196:	89 e5                	mov    %esp,%ebp
  if(!uart)
80106198:	85 c0                	test   %eax,%eax
8010619a:	74 1c                	je     801061b8 <uartgetc+0x28>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010619c:	ba fd 03 00 00       	mov    $0x3fd,%edx
801061a1:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
801061a2:	a8 01                	test   $0x1,%al
801061a4:	74 12                	je     801061b8 <uartgetc+0x28>
801061a6:	ba f8 03 00 00       	mov    $0x3f8,%edx
801061ab:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
801061ac:	0f b6 c0             	movzbl %al,%eax
}
801061af:	5d                   	pop    %ebp
801061b0:	c3                   	ret    
801061b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801061b8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801061bd:	5d                   	pop    %ebp
801061be:	c3                   	ret    
801061bf:	90                   	nop

801061c0 <uartputc.part.0>:
uartputc(int c)
801061c0:	55                   	push   %ebp
801061c1:	89 e5                	mov    %esp,%ebp
801061c3:	57                   	push   %edi
801061c4:	56                   	push   %esi
801061c5:	53                   	push   %ebx
801061c6:	89 c7                	mov    %eax,%edi
801061c8:	bb 80 00 00 00       	mov    $0x80,%ebx
801061cd:	be fd 03 00 00       	mov    $0x3fd,%esi
801061d2:	83 ec 0c             	sub    $0xc,%esp
801061d5:	eb 1b                	jmp    801061f2 <uartputc.part.0+0x32>
801061d7:	89 f6                	mov    %esi,%esi
801061d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    microdelay(10);
801061e0:	83 ec 0c             	sub    $0xc,%esp
801061e3:	6a 0a                	push   $0xa
801061e5:	e8 b6 c5 ff ff       	call   801027a0 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
801061ea:	83 c4 10             	add    $0x10,%esp
801061ed:	83 eb 01             	sub    $0x1,%ebx
801061f0:	74 07                	je     801061f9 <uartputc.part.0+0x39>
801061f2:	89 f2                	mov    %esi,%edx
801061f4:	ec                   	in     (%dx),%al
801061f5:	a8 20                	test   $0x20,%al
801061f7:	74 e7                	je     801061e0 <uartputc.part.0+0x20>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801061f9:	ba f8 03 00 00       	mov    $0x3f8,%edx
801061fe:	89 f8                	mov    %edi,%eax
80106200:	ee                   	out    %al,(%dx)
}
80106201:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106204:	5b                   	pop    %ebx
80106205:	5e                   	pop    %esi
80106206:	5f                   	pop    %edi
80106207:	5d                   	pop    %ebp
80106208:	c3                   	ret    
80106209:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106210 <uartinit>:
{
80106210:	55                   	push   %ebp
80106211:	31 c9                	xor    %ecx,%ecx
80106213:	89 c8                	mov    %ecx,%eax
80106215:	89 e5                	mov    %esp,%ebp
80106217:	57                   	push   %edi
80106218:	56                   	push   %esi
80106219:	53                   	push   %ebx
8010621a:	bb fa 03 00 00       	mov    $0x3fa,%ebx
8010621f:	89 da                	mov    %ebx,%edx
80106221:	83 ec 0c             	sub    $0xc,%esp
80106224:	ee                   	out    %al,(%dx)
80106225:	bf fb 03 00 00       	mov    $0x3fb,%edi
8010622a:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
8010622f:	89 fa                	mov    %edi,%edx
80106231:	ee                   	out    %al,(%dx)
80106232:	b8 0c 00 00 00       	mov    $0xc,%eax
80106237:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010623c:	ee                   	out    %al,(%dx)
8010623d:	be f9 03 00 00       	mov    $0x3f9,%esi
80106242:	89 c8                	mov    %ecx,%eax
80106244:	89 f2                	mov    %esi,%edx
80106246:	ee                   	out    %al,(%dx)
80106247:	b8 03 00 00 00       	mov    $0x3,%eax
8010624c:	89 fa                	mov    %edi,%edx
8010624e:	ee                   	out    %al,(%dx)
8010624f:	ba fc 03 00 00       	mov    $0x3fc,%edx
80106254:	89 c8                	mov    %ecx,%eax
80106256:	ee                   	out    %al,(%dx)
80106257:	b8 01 00 00 00       	mov    $0x1,%eax
8010625c:	89 f2                	mov    %esi,%edx
8010625e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010625f:	ba fd 03 00 00       	mov    $0x3fd,%edx
80106264:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
80106265:	3c ff                	cmp    $0xff,%al
80106267:	74 5a                	je     801062c3 <uartinit+0xb3>
  uart = 1;
80106269:	c7 05 bc b5 10 80 01 	movl   $0x1,0x8010b5bc
80106270:	00 00 00 
80106273:	89 da                	mov    %ebx,%edx
80106275:	ec                   	in     (%dx),%al
80106276:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010627b:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
8010627c:	83 ec 08             	sub    $0x8,%esp
  for(p="xv6...\n"; *p; p++)
8010627f:	bb 6c 7f 10 80       	mov    $0x80107f6c,%ebx
  ioapicenable(IRQ_COM1, 0);
80106284:	6a 00                	push   $0x0
80106286:	6a 04                	push   $0x4
80106288:	e8 73 c0 ff ff       	call   80102300 <ioapicenable>
8010628d:	83 c4 10             	add    $0x10,%esp
  for(p="xv6...\n"; *p; p++)
80106290:	b8 78 00 00 00       	mov    $0x78,%eax
80106295:	eb 13                	jmp    801062aa <uartinit+0x9a>
80106297:	89 f6                	mov    %esi,%esi
80106299:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801062a0:	83 c3 01             	add    $0x1,%ebx
801062a3:	0f be 03             	movsbl (%ebx),%eax
801062a6:	84 c0                	test   %al,%al
801062a8:	74 19                	je     801062c3 <uartinit+0xb3>
  if(!uart)
801062aa:	8b 15 bc b5 10 80    	mov    0x8010b5bc,%edx
801062b0:	85 d2                	test   %edx,%edx
801062b2:	74 ec                	je     801062a0 <uartinit+0x90>
  for(p="xv6...\n"; *p; p++)
801062b4:	83 c3 01             	add    $0x1,%ebx
801062b7:	e8 04 ff ff ff       	call   801061c0 <uartputc.part.0>
801062bc:	0f be 03             	movsbl (%ebx),%eax
801062bf:	84 c0                	test   %al,%al
801062c1:	75 e7                	jne    801062aa <uartinit+0x9a>
}
801062c3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801062c6:	5b                   	pop    %ebx
801062c7:	5e                   	pop    %esi
801062c8:	5f                   	pop    %edi
801062c9:	5d                   	pop    %ebp
801062ca:	c3                   	ret    
801062cb:	90                   	nop
801062cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801062d0 <uartputc>:
  if(!uart)
801062d0:	8b 15 bc b5 10 80    	mov    0x8010b5bc,%edx
{
801062d6:	55                   	push   %ebp
801062d7:	89 e5                	mov    %esp,%ebp
  if(!uart)
801062d9:	85 d2                	test   %edx,%edx
{
801062db:	8b 45 08             	mov    0x8(%ebp),%eax
  if(!uart)
801062de:	74 10                	je     801062f0 <uartputc+0x20>
}
801062e0:	5d                   	pop    %ebp
801062e1:	e9 da fe ff ff       	jmp    801061c0 <uartputc.part.0>
801062e6:	8d 76 00             	lea    0x0(%esi),%esi
801062e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801062f0:	5d                   	pop    %ebp
801062f1:	c3                   	ret    
801062f2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801062f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106300 <uartintr>:

void
uartintr(void)
{
80106300:	55                   	push   %ebp
80106301:	89 e5                	mov    %esp,%ebp
80106303:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
80106306:	68 90 61 10 80       	push   $0x80106190
8010630b:	e8 00 a5 ff ff       	call   80100810 <consoleintr>
}
80106310:	83 c4 10             	add    $0x10,%esp
80106313:	c9                   	leave  
80106314:	c3                   	ret    

80106315 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80106315:	6a 00                	push   $0x0
  pushl $0
80106317:	6a 00                	push   $0x0
  jmp alltraps
80106319:	e9 b1 fa ff ff       	jmp    80105dcf <alltraps>

8010631e <vector1>:
.globl vector1
vector1:
  pushl $0
8010631e:	6a 00                	push   $0x0
  pushl $1
80106320:	6a 01                	push   $0x1
  jmp alltraps
80106322:	e9 a8 fa ff ff       	jmp    80105dcf <alltraps>

80106327 <vector2>:
.globl vector2
vector2:
  pushl $0
80106327:	6a 00                	push   $0x0
  pushl $2
80106329:	6a 02                	push   $0x2
  jmp alltraps
8010632b:	e9 9f fa ff ff       	jmp    80105dcf <alltraps>

80106330 <vector3>:
.globl vector3
vector3:
  pushl $0
80106330:	6a 00                	push   $0x0
  pushl $3
80106332:	6a 03                	push   $0x3
  jmp alltraps
80106334:	e9 96 fa ff ff       	jmp    80105dcf <alltraps>

80106339 <vector4>:
.globl vector4
vector4:
  pushl $0
80106339:	6a 00                	push   $0x0
  pushl $4
8010633b:	6a 04                	push   $0x4
  jmp alltraps
8010633d:	e9 8d fa ff ff       	jmp    80105dcf <alltraps>

80106342 <vector5>:
.globl vector5
vector5:
  pushl $0
80106342:	6a 00                	push   $0x0
  pushl $5
80106344:	6a 05                	push   $0x5
  jmp alltraps
80106346:	e9 84 fa ff ff       	jmp    80105dcf <alltraps>

8010634b <vector6>:
.globl vector6
vector6:
  pushl $0
8010634b:	6a 00                	push   $0x0
  pushl $6
8010634d:	6a 06                	push   $0x6
  jmp alltraps
8010634f:	e9 7b fa ff ff       	jmp    80105dcf <alltraps>

80106354 <vector7>:
.globl vector7
vector7:
  pushl $0
80106354:	6a 00                	push   $0x0
  pushl $7
80106356:	6a 07                	push   $0x7
  jmp alltraps
80106358:	e9 72 fa ff ff       	jmp    80105dcf <alltraps>

8010635d <vector8>:
.globl vector8
vector8:
  pushl $8
8010635d:	6a 08                	push   $0x8
  jmp alltraps
8010635f:	e9 6b fa ff ff       	jmp    80105dcf <alltraps>

80106364 <vector9>:
.globl vector9
vector9:
  pushl $0
80106364:	6a 00                	push   $0x0
  pushl $9
80106366:	6a 09                	push   $0x9
  jmp alltraps
80106368:	e9 62 fa ff ff       	jmp    80105dcf <alltraps>

8010636d <vector10>:
.globl vector10
vector10:
  pushl $10
8010636d:	6a 0a                	push   $0xa
  jmp alltraps
8010636f:	e9 5b fa ff ff       	jmp    80105dcf <alltraps>

80106374 <vector11>:
.globl vector11
vector11:
  pushl $11
80106374:	6a 0b                	push   $0xb
  jmp alltraps
80106376:	e9 54 fa ff ff       	jmp    80105dcf <alltraps>

8010637b <vector12>:
.globl vector12
vector12:
  pushl $12
8010637b:	6a 0c                	push   $0xc
  jmp alltraps
8010637d:	e9 4d fa ff ff       	jmp    80105dcf <alltraps>

80106382 <vector13>:
.globl vector13
vector13:
  pushl $13
80106382:	6a 0d                	push   $0xd
  jmp alltraps
80106384:	e9 46 fa ff ff       	jmp    80105dcf <alltraps>

80106389 <vector14>:
.globl vector14
vector14:
  pushl $14
80106389:	6a 0e                	push   $0xe
  jmp alltraps
8010638b:	e9 3f fa ff ff       	jmp    80105dcf <alltraps>

80106390 <vector15>:
.globl vector15
vector15:
  pushl $0
80106390:	6a 00                	push   $0x0
  pushl $15
80106392:	6a 0f                	push   $0xf
  jmp alltraps
80106394:	e9 36 fa ff ff       	jmp    80105dcf <alltraps>

80106399 <vector16>:
.globl vector16
vector16:
  pushl $0
80106399:	6a 00                	push   $0x0
  pushl $16
8010639b:	6a 10                	push   $0x10
  jmp alltraps
8010639d:	e9 2d fa ff ff       	jmp    80105dcf <alltraps>

801063a2 <vector17>:
.globl vector17
vector17:
  pushl $17
801063a2:	6a 11                	push   $0x11
  jmp alltraps
801063a4:	e9 26 fa ff ff       	jmp    80105dcf <alltraps>

801063a9 <vector18>:
.globl vector18
vector18:
  pushl $0
801063a9:	6a 00                	push   $0x0
  pushl $18
801063ab:	6a 12                	push   $0x12
  jmp alltraps
801063ad:	e9 1d fa ff ff       	jmp    80105dcf <alltraps>

801063b2 <vector19>:
.globl vector19
vector19:
  pushl $0
801063b2:	6a 00                	push   $0x0
  pushl $19
801063b4:	6a 13                	push   $0x13
  jmp alltraps
801063b6:	e9 14 fa ff ff       	jmp    80105dcf <alltraps>

801063bb <vector20>:
.globl vector20
vector20:
  pushl $0
801063bb:	6a 00                	push   $0x0
  pushl $20
801063bd:	6a 14                	push   $0x14
  jmp alltraps
801063bf:	e9 0b fa ff ff       	jmp    80105dcf <alltraps>

801063c4 <vector21>:
.globl vector21
vector21:
  pushl $0
801063c4:	6a 00                	push   $0x0
  pushl $21
801063c6:	6a 15                	push   $0x15
  jmp alltraps
801063c8:	e9 02 fa ff ff       	jmp    80105dcf <alltraps>

801063cd <vector22>:
.globl vector22
vector22:
  pushl $0
801063cd:	6a 00                	push   $0x0
  pushl $22
801063cf:	6a 16                	push   $0x16
  jmp alltraps
801063d1:	e9 f9 f9 ff ff       	jmp    80105dcf <alltraps>

801063d6 <vector23>:
.globl vector23
vector23:
  pushl $0
801063d6:	6a 00                	push   $0x0
  pushl $23
801063d8:	6a 17                	push   $0x17
  jmp alltraps
801063da:	e9 f0 f9 ff ff       	jmp    80105dcf <alltraps>

801063df <vector24>:
.globl vector24
vector24:
  pushl $0
801063df:	6a 00                	push   $0x0
  pushl $24
801063e1:	6a 18                	push   $0x18
  jmp alltraps
801063e3:	e9 e7 f9 ff ff       	jmp    80105dcf <alltraps>

801063e8 <vector25>:
.globl vector25
vector25:
  pushl $0
801063e8:	6a 00                	push   $0x0
  pushl $25
801063ea:	6a 19                	push   $0x19
  jmp alltraps
801063ec:	e9 de f9 ff ff       	jmp    80105dcf <alltraps>

801063f1 <vector26>:
.globl vector26
vector26:
  pushl $0
801063f1:	6a 00                	push   $0x0
  pushl $26
801063f3:	6a 1a                	push   $0x1a
  jmp alltraps
801063f5:	e9 d5 f9 ff ff       	jmp    80105dcf <alltraps>

801063fa <vector27>:
.globl vector27
vector27:
  pushl $0
801063fa:	6a 00                	push   $0x0
  pushl $27
801063fc:	6a 1b                	push   $0x1b
  jmp alltraps
801063fe:	e9 cc f9 ff ff       	jmp    80105dcf <alltraps>

80106403 <vector28>:
.globl vector28
vector28:
  pushl $0
80106403:	6a 00                	push   $0x0
  pushl $28
80106405:	6a 1c                	push   $0x1c
  jmp alltraps
80106407:	e9 c3 f9 ff ff       	jmp    80105dcf <alltraps>

8010640c <vector29>:
.globl vector29
vector29:
  pushl $0
8010640c:	6a 00                	push   $0x0
  pushl $29
8010640e:	6a 1d                	push   $0x1d
  jmp alltraps
80106410:	e9 ba f9 ff ff       	jmp    80105dcf <alltraps>

80106415 <vector30>:
.globl vector30
vector30:
  pushl $0
80106415:	6a 00                	push   $0x0
  pushl $30
80106417:	6a 1e                	push   $0x1e
  jmp alltraps
80106419:	e9 b1 f9 ff ff       	jmp    80105dcf <alltraps>

8010641e <vector31>:
.globl vector31
vector31:
  pushl $0
8010641e:	6a 00                	push   $0x0
  pushl $31
80106420:	6a 1f                	push   $0x1f
  jmp alltraps
80106422:	e9 a8 f9 ff ff       	jmp    80105dcf <alltraps>

80106427 <vector32>:
.globl vector32
vector32:
  pushl $0
80106427:	6a 00                	push   $0x0
  pushl $32
80106429:	6a 20                	push   $0x20
  jmp alltraps
8010642b:	e9 9f f9 ff ff       	jmp    80105dcf <alltraps>

80106430 <vector33>:
.globl vector33
vector33:
  pushl $0
80106430:	6a 00                	push   $0x0
  pushl $33
80106432:	6a 21                	push   $0x21
  jmp alltraps
80106434:	e9 96 f9 ff ff       	jmp    80105dcf <alltraps>

80106439 <vector34>:
.globl vector34
vector34:
  pushl $0
80106439:	6a 00                	push   $0x0
  pushl $34
8010643b:	6a 22                	push   $0x22
  jmp alltraps
8010643d:	e9 8d f9 ff ff       	jmp    80105dcf <alltraps>

80106442 <vector35>:
.globl vector35
vector35:
  pushl $0
80106442:	6a 00                	push   $0x0
  pushl $35
80106444:	6a 23                	push   $0x23
  jmp alltraps
80106446:	e9 84 f9 ff ff       	jmp    80105dcf <alltraps>

8010644b <vector36>:
.globl vector36
vector36:
  pushl $0
8010644b:	6a 00                	push   $0x0
  pushl $36
8010644d:	6a 24                	push   $0x24
  jmp alltraps
8010644f:	e9 7b f9 ff ff       	jmp    80105dcf <alltraps>

80106454 <vector37>:
.globl vector37
vector37:
  pushl $0
80106454:	6a 00                	push   $0x0
  pushl $37
80106456:	6a 25                	push   $0x25
  jmp alltraps
80106458:	e9 72 f9 ff ff       	jmp    80105dcf <alltraps>

8010645d <vector38>:
.globl vector38
vector38:
  pushl $0
8010645d:	6a 00                	push   $0x0
  pushl $38
8010645f:	6a 26                	push   $0x26
  jmp alltraps
80106461:	e9 69 f9 ff ff       	jmp    80105dcf <alltraps>

80106466 <vector39>:
.globl vector39
vector39:
  pushl $0
80106466:	6a 00                	push   $0x0
  pushl $39
80106468:	6a 27                	push   $0x27
  jmp alltraps
8010646a:	e9 60 f9 ff ff       	jmp    80105dcf <alltraps>

8010646f <vector40>:
.globl vector40
vector40:
  pushl $0
8010646f:	6a 00                	push   $0x0
  pushl $40
80106471:	6a 28                	push   $0x28
  jmp alltraps
80106473:	e9 57 f9 ff ff       	jmp    80105dcf <alltraps>

80106478 <vector41>:
.globl vector41
vector41:
  pushl $0
80106478:	6a 00                	push   $0x0
  pushl $41
8010647a:	6a 29                	push   $0x29
  jmp alltraps
8010647c:	e9 4e f9 ff ff       	jmp    80105dcf <alltraps>

80106481 <vector42>:
.globl vector42
vector42:
  pushl $0
80106481:	6a 00                	push   $0x0
  pushl $42
80106483:	6a 2a                	push   $0x2a
  jmp alltraps
80106485:	e9 45 f9 ff ff       	jmp    80105dcf <alltraps>

8010648a <vector43>:
.globl vector43
vector43:
  pushl $0
8010648a:	6a 00                	push   $0x0
  pushl $43
8010648c:	6a 2b                	push   $0x2b
  jmp alltraps
8010648e:	e9 3c f9 ff ff       	jmp    80105dcf <alltraps>

80106493 <vector44>:
.globl vector44
vector44:
  pushl $0
80106493:	6a 00                	push   $0x0
  pushl $44
80106495:	6a 2c                	push   $0x2c
  jmp alltraps
80106497:	e9 33 f9 ff ff       	jmp    80105dcf <alltraps>

8010649c <vector45>:
.globl vector45
vector45:
  pushl $0
8010649c:	6a 00                	push   $0x0
  pushl $45
8010649e:	6a 2d                	push   $0x2d
  jmp alltraps
801064a0:	e9 2a f9 ff ff       	jmp    80105dcf <alltraps>

801064a5 <vector46>:
.globl vector46
vector46:
  pushl $0
801064a5:	6a 00                	push   $0x0
  pushl $46
801064a7:	6a 2e                	push   $0x2e
  jmp alltraps
801064a9:	e9 21 f9 ff ff       	jmp    80105dcf <alltraps>

801064ae <vector47>:
.globl vector47
vector47:
  pushl $0
801064ae:	6a 00                	push   $0x0
  pushl $47
801064b0:	6a 2f                	push   $0x2f
  jmp alltraps
801064b2:	e9 18 f9 ff ff       	jmp    80105dcf <alltraps>

801064b7 <vector48>:
.globl vector48
vector48:
  pushl $0
801064b7:	6a 00                	push   $0x0
  pushl $48
801064b9:	6a 30                	push   $0x30
  jmp alltraps
801064bb:	e9 0f f9 ff ff       	jmp    80105dcf <alltraps>

801064c0 <vector49>:
.globl vector49
vector49:
  pushl $0
801064c0:	6a 00                	push   $0x0
  pushl $49
801064c2:	6a 31                	push   $0x31
  jmp alltraps
801064c4:	e9 06 f9 ff ff       	jmp    80105dcf <alltraps>

801064c9 <vector50>:
.globl vector50
vector50:
  pushl $0
801064c9:	6a 00                	push   $0x0
  pushl $50
801064cb:	6a 32                	push   $0x32
  jmp alltraps
801064cd:	e9 fd f8 ff ff       	jmp    80105dcf <alltraps>

801064d2 <vector51>:
.globl vector51
vector51:
  pushl $0
801064d2:	6a 00                	push   $0x0
  pushl $51
801064d4:	6a 33                	push   $0x33
  jmp alltraps
801064d6:	e9 f4 f8 ff ff       	jmp    80105dcf <alltraps>

801064db <vector52>:
.globl vector52
vector52:
  pushl $0
801064db:	6a 00                	push   $0x0
  pushl $52
801064dd:	6a 34                	push   $0x34
  jmp alltraps
801064df:	e9 eb f8 ff ff       	jmp    80105dcf <alltraps>

801064e4 <vector53>:
.globl vector53
vector53:
  pushl $0
801064e4:	6a 00                	push   $0x0
  pushl $53
801064e6:	6a 35                	push   $0x35
  jmp alltraps
801064e8:	e9 e2 f8 ff ff       	jmp    80105dcf <alltraps>

801064ed <vector54>:
.globl vector54
vector54:
  pushl $0
801064ed:	6a 00                	push   $0x0
  pushl $54
801064ef:	6a 36                	push   $0x36
  jmp alltraps
801064f1:	e9 d9 f8 ff ff       	jmp    80105dcf <alltraps>

801064f6 <vector55>:
.globl vector55
vector55:
  pushl $0
801064f6:	6a 00                	push   $0x0
  pushl $55
801064f8:	6a 37                	push   $0x37
  jmp alltraps
801064fa:	e9 d0 f8 ff ff       	jmp    80105dcf <alltraps>

801064ff <vector56>:
.globl vector56
vector56:
  pushl $0
801064ff:	6a 00                	push   $0x0
  pushl $56
80106501:	6a 38                	push   $0x38
  jmp alltraps
80106503:	e9 c7 f8 ff ff       	jmp    80105dcf <alltraps>

80106508 <vector57>:
.globl vector57
vector57:
  pushl $0
80106508:	6a 00                	push   $0x0
  pushl $57
8010650a:	6a 39                	push   $0x39
  jmp alltraps
8010650c:	e9 be f8 ff ff       	jmp    80105dcf <alltraps>

80106511 <vector58>:
.globl vector58
vector58:
  pushl $0
80106511:	6a 00                	push   $0x0
  pushl $58
80106513:	6a 3a                	push   $0x3a
  jmp alltraps
80106515:	e9 b5 f8 ff ff       	jmp    80105dcf <alltraps>

8010651a <vector59>:
.globl vector59
vector59:
  pushl $0
8010651a:	6a 00                	push   $0x0
  pushl $59
8010651c:	6a 3b                	push   $0x3b
  jmp alltraps
8010651e:	e9 ac f8 ff ff       	jmp    80105dcf <alltraps>

80106523 <vector60>:
.globl vector60
vector60:
  pushl $0
80106523:	6a 00                	push   $0x0
  pushl $60
80106525:	6a 3c                	push   $0x3c
  jmp alltraps
80106527:	e9 a3 f8 ff ff       	jmp    80105dcf <alltraps>

8010652c <vector61>:
.globl vector61
vector61:
  pushl $0
8010652c:	6a 00                	push   $0x0
  pushl $61
8010652e:	6a 3d                	push   $0x3d
  jmp alltraps
80106530:	e9 9a f8 ff ff       	jmp    80105dcf <alltraps>

80106535 <vector62>:
.globl vector62
vector62:
  pushl $0
80106535:	6a 00                	push   $0x0
  pushl $62
80106537:	6a 3e                	push   $0x3e
  jmp alltraps
80106539:	e9 91 f8 ff ff       	jmp    80105dcf <alltraps>

8010653e <vector63>:
.globl vector63
vector63:
  pushl $0
8010653e:	6a 00                	push   $0x0
  pushl $63
80106540:	6a 3f                	push   $0x3f
  jmp alltraps
80106542:	e9 88 f8 ff ff       	jmp    80105dcf <alltraps>

80106547 <vector64>:
.globl vector64
vector64:
  pushl $0
80106547:	6a 00                	push   $0x0
  pushl $64
80106549:	6a 40                	push   $0x40
  jmp alltraps
8010654b:	e9 7f f8 ff ff       	jmp    80105dcf <alltraps>

80106550 <vector65>:
.globl vector65
vector65:
  pushl $0
80106550:	6a 00                	push   $0x0
  pushl $65
80106552:	6a 41                	push   $0x41
  jmp alltraps
80106554:	e9 76 f8 ff ff       	jmp    80105dcf <alltraps>

80106559 <vector66>:
.globl vector66
vector66:
  pushl $0
80106559:	6a 00                	push   $0x0
  pushl $66
8010655b:	6a 42                	push   $0x42
  jmp alltraps
8010655d:	e9 6d f8 ff ff       	jmp    80105dcf <alltraps>

80106562 <vector67>:
.globl vector67
vector67:
  pushl $0
80106562:	6a 00                	push   $0x0
  pushl $67
80106564:	6a 43                	push   $0x43
  jmp alltraps
80106566:	e9 64 f8 ff ff       	jmp    80105dcf <alltraps>

8010656b <vector68>:
.globl vector68
vector68:
  pushl $0
8010656b:	6a 00                	push   $0x0
  pushl $68
8010656d:	6a 44                	push   $0x44
  jmp alltraps
8010656f:	e9 5b f8 ff ff       	jmp    80105dcf <alltraps>

80106574 <vector69>:
.globl vector69
vector69:
  pushl $0
80106574:	6a 00                	push   $0x0
  pushl $69
80106576:	6a 45                	push   $0x45
  jmp alltraps
80106578:	e9 52 f8 ff ff       	jmp    80105dcf <alltraps>

8010657d <vector70>:
.globl vector70
vector70:
  pushl $0
8010657d:	6a 00                	push   $0x0
  pushl $70
8010657f:	6a 46                	push   $0x46
  jmp alltraps
80106581:	e9 49 f8 ff ff       	jmp    80105dcf <alltraps>

80106586 <vector71>:
.globl vector71
vector71:
  pushl $0
80106586:	6a 00                	push   $0x0
  pushl $71
80106588:	6a 47                	push   $0x47
  jmp alltraps
8010658a:	e9 40 f8 ff ff       	jmp    80105dcf <alltraps>

8010658f <vector72>:
.globl vector72
vector72:
  pushl $0
8010658f:	6a 00                	push   $0x0
  pushl $72
80106591:	6a 48                	push   $0x48
  jmp alltraps
80106593:	e9 37 f8 ff ff       	jmp    80105dcf <alltraps>

80106598 <vector73>:
.globl vector73
vector73:
  pushl $0
80106598:	6a 00                	push   $0x0
  pushl $73
8010659a:	6a 49                	push   $0x49
  jmp alltraps
8010659c:	e9 2e f8 ff ff       	jmp    80105dcf <alltraps>

801065a1 <vector74>:
.globl vector74
vector74:
  pushl $0
801065a1:	6a 00                	push   $0x0
  pushl $74
801065a3:	6a 4a                	push   $0x4a
  jmp alltraps
801065a5:	e9 25 f8 ff ff       	jmp    80105dcf <alltraps>

801065aa <vector75>:
.globl vector75
vector75:
  pushl $0
801065aa:	6a 00                	push   $0x0
  pushl $75
801065ac:	6a 4b                	push   $0x4b
  jmp alltraps
801065ae:	e9 1c f8 ff ff       	jmp    80105dcf <alltraps>

801065b3 <vector76>:
.globl vector76
vector76:
  pushl $0
801065b3:	6a 00                	push   $0x0
  pushl $76
801065b5:	6a 4c                	push   $0x4c
  jmp alltraps
801065b7:	e9 13 f8 ff ff       	jmp    80105dcf <alltraps>

801065bc <vector77>:
.globl vector77
vector77:
  pushl $0
801065bc:	6a 00                	push   $0x0
  pushl $77
801065be:	6a 4d                	push   $0x4d
  jmp alltraps
801065c0:	e9 0a f8 ff ff       	jmp    80105dcf <alltraps>

801065c5 <vector78>:
.globl vector78
vector78:
  pushl $0
801065c5:	6a 00                	push   $0x0
  pushl $78
801065c7:	6a 4e                	push   $0x4e
  jmp alltraps
801065c9:	e9 01 f8 ff ff       	jmp    80105dcf <alltraps>

801065ce <vector79>:
.globl vector79
vector79:
  pushl $0
801065ce:	6a 00                	push   $0x0
  pushl $79
801065d0:	6a 4f                	push   $0x4f
  jmp alltraps
801065d2:	e9 f8 f7 ff ff       	jmp    80105dcf <alltraps>

801065d7 <vector80>:
.globl vector80
vector80:
  pushl $0
801065d7:	6a 00                	push   $0x0
  pushl $80
801065d9:	6a 50                	push   $0x50
  jmp alltraps
801065db:	e9 ef f7 ff ff       	jmp    80105dcf <alltraps>

801065e0 <vector81>:
.globl vector81
vector81:
  pushl $0
801065e0:	6a 00                	push   $0x0
  pushl $81
801065e2:	6a 51                	push   $0x51
  jmp alltraps
801065e4:	e9 e6 f7 ff ff       	jmp    80105dcf <alltraps>

801065e9 <vector82>:
.globl vector82
vector82:
  pushl $0
801065e9:	6a 00                	push   $0x0
  pushl $82
801065eb:	6a 52                	push   $0x52
  jmp alltraps
801065ed:	e9 dd f7 ff ff       	jmp    80105dcf <alltraps>

801065f2 <vector83>:
.globl vector83
vector83:
  pushl $0
801065f2:	6a 00                	push   $0x0
  pushl $83
801065f4:	6a 53                	push   $0x53
  jmp alltraps
801065f6:	e9 d4 f7 ff ff       	jmp    80105dcf <alltraps>

801065fb <vector84>:
.globl vector84
vector84:
  pushl $0
801065fb:	6a 00                	push   $0x0
  pushl $84
801065fd:	6a 54                	push   $0x54
  jmp alltraps
801065ff:	e9 cb f7 ff ff       	jmp    80105dcf <alltraps>

80106604 <vector85>:
.globl vector85
vector85:
  pushl $0
80106604:	6a 00                	push   $0x0
  pushl $85
80106606:	6a 55                	push   $0x55
  jmp alltraps
80106608:	e9 c2 f7 ff ff       	jmp    80105dcf <alltraps>

8010660d <vector86>:
.globl vector86
vector86:
  pushl $0
8010660d:	6a 00                	push   $0x0
  pushl $86
8010660f:	6a 56                	push   $0x56
  jmp alltraps
80106611:	e9 b9 f7 ff ff       	jmp    80105dcf <alltraps>

80106616 <vector87>:
.globl vector87
vector87:
  pushl $0
80106616:	6a 00                	push   $0x0
  pushl $87
80106618:	6a 57                	push   $0x57
  jmp alltraps
8010661a:	e9 b0 f7 ff ff       	jmp    80105dcf <alltraps>

8010661f <vector88>:
.globl vector88
vector88:
  pushl $0
8010661f:	6a 00                	push   $0x0
  pushl $88
80106621:	6a 58                	push   $0x58
  jmp alltraps
80106623:	e9 a7 f7 ff ff       	jmp    80105dcf <alltraps>

80106628 <vector89>:
.globl vector89
vector89:
  pushl $0
80106628:	6a 00                	push   $0x0
  pushl $89
8010662a:	6a 59                	push   $0x59
  jmp alltraps
8010662c:	e9 9e f7 ff ff       	jmp    80105dcf <alltraps>

80106631 <vector90>:
.globl vector90
vector90:
  pushl $0
80106631:	6a 00                	push   $0x0
  pushl $90
80106633:	6a 5a                	push   $0x5a
  jmp alltraps
80106635:	e9 95 f7 ff ff       	jmp    80105dcf <alltraps>

8010663a <vector91>:
.globl vector91
vector91:
  pushl $0
8010663a:	6a 00                	push   $0x0
  pushl $91
8010663c:	6a 5b                	push   $0x5b
  jmp alltraps
8010663e:	e9 8c f7 ff ff       	jmp    80105dcf <alltraps>

80106643 <vector92>:
.globl vector92
vector92:
  pushl $0
80106643:	6a 00                	push   $0x0
  pushl $92
80106645:	6a 5c                	push   $0x5c
  jmp alltraps
80106647:	e9 83 f7 ff ff       	jmp    80105dcf <alltraps>

8010664c <vector93>:
.globl vector93
vector93:
  pushl $0
8010664c:	6a 00                	push   $0x0
  pushl $93
8010664e:	6a 5d                	push   $0x5d
  jmp alltraps
80106650:	e9 7a f7 ff ff       	jmp    80105dcf <alltraps>

80106655 <vector94>:
.globl vector94
vector94:
  pushl $0
80106655:	6a 00                	push   $0x0
  pushl $94
80106657:	6a 5e                	push   $0x5e
  jmp alltraps
80106659:	e9 71 f7 ff ff       	jmp    80105dcf <alltraps>

8010665e <vector95>:
.globl vector95
vector95:
  pushl $0
8010665e:	6a 00                	push   $0x0
  pushl $95
80106660:	6a 5f                	push   $0x5f
  jmp alltraps
80106662:	e9 68 f7 ff ff       	jmp    80105dcf <alltraps>

80106667 <vector96>:
.globl vector96
vector96:
  pushl $0
80106667:	6a 00                	push   $0x0
  pushl $96
80106669:	6a 60                	push   $0x60
  jmp alltraps
8010666b:	e9 5f f7 ff ff       	jmp    80105dcf <alltraps>

80106670 <vector97>:
.globl vector97
vector97:
  pushl $0
80106670:	6a 00                	push   $0x0
  pushl $97
80106672:	6a 61                	push   $0x61
  jmp alltraps
80106674:	e9 56 f7 ff ff       	jmp    80105dcf <alltraps>

80106679 <vector98>:
.globl vector98
vector98:
  pushl $0
80106679:	6a 00                	push   $0x0
  pushl $98
8010667b:	6a 62                	push   $0x62
  jmp alltraps
8010667d:	e9 4d f7 ff ff       	jmp    80105dcf <alltraps>

80106682 <vector99>:
.globl vector99
vector99:
  pushl $0
80106682:	6a 00                	push   $0x0
  pushl $99
80106684:	6a 63                	push   $0x63
  jmp alltraps
80106686:	e9 44 f7 ff ff       	jmp    80105dcf <alltraps>

8010668b <vector100>:
.globl vector100
vector100:
  pushl $0
8010668b:	6a 00                	push   $0x0
  pushl $100
8010668d:	6a 64                	push   $0x64
  jmp alltraps
8010668f:	e9 3b f7 ff ff       	jmp    80105dcf <alltraps>

80106694 <vector101>:
.globl vector101
vector101:
  pushl $0
80106694:	6a 00                	push   $0x0
  pushl $101
80106696:	6a 65                	push   $0x65
  jmp alltraps
80106698:	e9 32 f7 ff ff       	jmp    80105dcf <alltraps>

8010669d <vector102>:
.globl vector102
vector102:
  pushl $0
8010669d:	6a 00                	push   $0x0
  pushl $102
8010669f:	6a 66                	push   $0x66
  jmp alltraps
801066a1:	e9 29 f7 ff ff       	jmp    80105dcf <alltraps>

801066a6 <vector103>:
.globl vector103
vector103:
  pushl $0
801066a6:	6a 00                	push   $0x0
  pushl $103
801066a8:	6a 67                	push   $0x67
  jmp alltraps
801066aa:	e9 20 f7 ff ff       	jmp    80105dcf <alltraps>

801066af <vector104>:
.globl vector104
vector104:
  pushl $0
801066af:	6a 00                	push   $0x0
  pushl $104
801066b1:	6a 68                	push   $0x68
  jmp alltraps
801066b3:	e9 17 f7 ff ff       	jmp    80105dcf <alltraps>

801066b8 <vector105>:
.globl vector105
vector105:
  pushl $0
801066b8:	6a 00                	push   $0x0
  pushl $105
801066ba:	6a 69                	push   $0x69
  jmp alltraps
801066bc:	e9 0e f7 ff ff       	jmp    80105dcf <alltraps>

801066c1 <vector106>:
.globl vector106
vector106:
  pushl $0
801066c1:	6a 00                	push   $0x0
  pushl $106
801066c3:	6a 6a                	push   $0x6a
  jmp alltraps
801066c5:	e9 05 f7 ff ff       	jmp    80105dcf <alltraps>

801066ca <vector107>:
.globl vector107
vector107:
  pushl $0
801066ca:	6a 00                	push   $0x0
  pushl $107
801066cc:	6a 6b                	push   $0x6b
  jmp alltraps
801066ce:	e9 fc f6 ff ff       	jmp    80105dcf <alltraps>

801066d3 <vector108>:
.globl vector108
vector108:
  pushl $0
801066d3:	6a 00                	push   $0x0
  pushl $108
801066d5:	6a 6c                	push   $0x6c
  jmp alltraps
801066d7:	e9 f3 f6 ff ff       	jmp    80105dcf <alltraps>

801066dc <vector109>:
.globl vector109
vector109:
  pushl $0
801066dc:	6a 00                	push   $0x0
  pushl $109
801066de:	6a 6d                	push   $0x6d
  jmp alltraps
801066e0:	e9 ea f6 ff ff       	jmp    80105dcf <alltraps>

801066e5 <vector110>:
.globl vector110
vector110:
  pushl $0
801066e5:	6a 00                	push   $0x0
  pushl $110
801066e7:	6a 6e                	push   $0x6e
  jmp alltraps
801066e9:	e9 e1 f6 ff ff       	jmp    80105dcf <alltraps>

801066ee <vector111>:
.globl vector111
vector111:
  pushl $0
801066ee:	6a 00                	push   $0x0
  pushl $111
801066f0:	6a 6f                	push   $0x6f
  jmp alltraps
801066f2:	e9 d8 f6 ff ff       	jmp    80105dcf <alltraps>

801066f7 <vector112>:
.globl vector112
vector112:
  pushl $0
801066f7:	6a 00                	push   $0x0
  pushl $112
801066f9:	6a 70                	push   $0x70
  jmp alltraps
801066fb:	e9 cf f6 ff ff       	jmp    80105dcf <alltraps>

80106700 <vector113>:
.globl vector113
vector113:
  pushl $0
80106700:	6a 00                	push   $0x0
  pushl $113
80106702:	6a 71                	push   $0x71
  jmp alltraps
80106704:	e9 c6 f6 ff ff       	jmp    80105dcf <alltraps>

80106709 <vector114>:
.globl vector114
vector114:
  pushl $0
80106709:	6a 00                	push   $0x0
  pushl $114
8010670b:	6a 72                	push   $0x72
  jmp alltraps
8010670d:	e9 bd f6 ff ff       	jmp    80105dcf <alltraps>

80106712 <vector115>:
.globl vector115
vector115:
  pushl $0
80106712:	6a 00                	push   $0x0
  pushl $115
80106714:	6a 73                	push   $0x73
  jmp alltraps
80106716:	e9 b4 f6 ff ff       	jmp    80105dcf <alltraps>

8010671b <vector116>:
.globl vector116
vector116:
  pushl $0
8010671b:	6a 00                	push   $0x0
  pushl $116
8010671d:	6a 74                	push   $0x74
  jmp alltraps
8010671f:	e9 ab f6 ff ff       	jmp    80105dcf <alltraps>

80106724 <vector117>:
.globl vector117
vector117:
  pushl $0
80106724:	6a 00                	push   $0x0
  pushl $117
80106726:	6a 75                	push   $0x75
  jmp alltraps
80106728:	e9 a2 f6 ff ff       	jmp    80105dcf <alltraps>

8010672d <vector118>:
.globl vector118
vector118:
  pushl $0
8010672d:	6a 00                	push   $0x0
  pushl $118
8010672f:	6a 76                	push   $0x76
  jmp alltraps
80106731:	e9 99 f6 ff ff       	jmp    80105dcf <alltraps>

80106736 <vector119>:
.globl vector119
vector119:
  pushl $0
80106736:	6a 00                	push   $0x0
  pushl $119
80106738:	6a 77                	push   $0x77
  jmp alltraps
8010673a:	e9 90 f6 ff ff       	jmp    80105dcf <alltraps>

8010673f <vector120>:
.globl vector120
vector120:
  pushl $0
8010673f:	6a 00                	push   $0x0
  pushl $120
80106741:	6a 78                	push   $0x78
  jmp alltraps
80106743:	e9 87 f6 ff ff       	jmp    80105dcf <alltraps>

80106748 <vector121>:
.globl vector121
vector121:
  pushl $0
80106748:	6a 00                	push   $0x0
  pushl $121
8010674a:	6a 79                	push   $0x79
  jmp alltraps
8010674c:	e9 7e f6 ff ff       	jmp    80105dcf <alltraps>

80106751 <vector122>:
.globl vector122
vector122:
  pushl $0
80106751:	6a 00                	push   $0x0
  pushl $122
80106753:	6a 7a                	push   $0x7a
  jmp alltraps
80106755:	e9 75 f6 ff ff       	jmp    80105dcf <alltraps>

8010675a <vector123>:
.globl vector123
vector123:
  pushl $0
8010675a:	6a 00                	push   $0x0
  pushl $123
8010675c:	6a 7b                	push   $0x7b
  jmp alltraps
8010675e:	e9 6c f6 ff ff       	jmp    80105dcf <alltraps>

80106763 <vector124>:
.globl vector124
vector124:
  pushl $0
80106763:	6a 00                	push   $0x0
  pushl $124
80106765:	6a 7c                	push   $0x7c
  jmp alltraps
80106767:	e9 63 f6 ff ff       	jmp    80105dcf <alltraps>

8010676c <vector125>:
.globl vector125
vector125:
  pushl $0
8010676c:	6a 00                	push   $0x0
  pushl $125
8010676e:	6a 7d                	push   $0x7d
  jmp alltraps
80106770:	e9 5a f6 ff ff       	jmp    80105dcf <alltraps>

80106775 <vector126>:
.globl vector126
vector126:
  pushl $0
80106775:	6a 00                	push   $0x0
  pushl $126
80106777:	6a 7e                	push   $0x7e
  jmp alltraps
80106779:	e9 51 f6 ff ff       	jmp    80105dcf <alltraps>

8010677e <vector127>:
.globl vector127
vector127:
  pushl $0
8010677e:	6a 00                	push   $0x0
  pushl $127
80106780:	6a 7f                	push   $0x7f
  jmp alltraps
80106782:	e9 48 f6 ff ff       	jmp    80105dcf <alltraps>

80106787 <vector128>:
.globl vector128
vector128:
  pushl $0
80106787:	6a 00                	push   $0x0
  pushl $128
80106789:	68 80 00 00 00       	push   $0x80
  jmp alltraps
8010678e:	e9 3c f6 ff ff       	jmp    80105dcf <alltraps>

80106793 <vector129>:
.globl vector129
vector129:
  pushl $0
80106793:	6a 00                	push   $0x0
  pushl $129
80106795:	68 81 00 00 00       	push   $0x81
  jmp alltraps
8010679a:	e9 30 f6 ff ff       	jmp    80105dcf <alltraps>

8010679f <vector130>:
.globl vector130
vector130:
  pushl $0
8010679f:	6a 00                	push   $0x0
  pushl $130
801067a1:	68 82 00 00 00       	push   $0x82
  jmp alltraps
801067a6:	e9 24 f6 ff ff       	jmp    80105dcf <alltraps>

801067ab <vector131>:
.globl vector131
vector131:
  pushl $0
801067ab:	6a 00                	push   $0x0
  pushl $131
801067ad:	68 83 00 00 00       	push   $0x83
  jmp alltraps
801067b2:	e9 18 f6 ff ff       	jmp    80105dcf <alltraps>

801067b7 <vector132>:
.globl vector132
vector132:
  pushl $0
801067b7:	6a 00                	push   $0x0
  pushl $132
801067b9:	68 84 00 00 00       	push   $0x84
  jmp alltraps
801067be:	e9 0c f6 ff ff       	jmp    80105dcf <alltraps>

801067c3 <vector133>:
.globl vector133
vector133:
  pushl $0
801067c3:	6a 00                	push   $0x0
  pushl $133
801067c5:	68 85 00 00 00       	push   $0x85
  jmp alltraps
801067ca:	e9 00 f6 ff ff       	jmp    80105dcf <alltraps>

801067cf <vector134>:
.globl vector134
vector134:
  pushl $0
801067cf:	6a 00                	push   $0x0
  pushl $134
801067d1:	68 86 00 00 00       	push   $0x86
  jmp alltraps
801067d6:	e9 f4 f5 ff ff       	jmp    80105dcf <alltraps>

801067db <vector135>:
.globl vector135
vector135:
  pushl $0
801067db:	6a 00                	push   $0x0
  pushl $135
801067dd:	68 87 00 00 00       	push   $0x87
  jmp alltraps
801067e2:	e9 e8 f5 ff ff       	jmp    80105dcf <alltraps>

801067e7 <vector136>:
.globl vector136
vector136:
  pushl $0
801067e7:	6a 00                	push   $0x0
  pushl $136
801067e9:	68 88 00 00 00       	push   $0x88
  jmp alltraps
801067ee:	e9 dc f5 ff ff       	jmp    80105dcf <alltraps>

801067f3 <vector137>:
.globl vector137
vector137:
  pushl $0
801067f3:	6a 00                	push   $0x0
  pushl $137
801067f5:	68 89 00 00 00       	push   $0x89
  jmp alltraps
801067fa:	e9 d0 f5 ff ff       	jmp    80105dcf <alltraps>

801067ff <vector138>:
.globl vector138
vector138:
  pushl $0
801067ff:	6a 00                	push   $0x0
  pushl $138
80106801:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
80106806:	e9 c4 f5 ff ff       	jmp    80105dcf <alltraps>

8010680b <vector139>:
.globl vector139
vector139:
  pushl $0
8010680b:	6a 00                	push   $0x0
  pushl $139
8010680d:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
80106812:	e9 b8 f5 ff ff       	jmp    80105dcf <alltraps>

80106817 <vector140>:
.globl vector140
vector140:
  pushl $0
80106817:	6a 00                	push   $0x0
  pushl $140
80106819:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
8010681e:	e9 ac f5 ff ff       	jmp    80105dcf <alltraps>

80106823 <vector141>:
.globl vector141
vector141:
  pushl $0
80106823:	6a 00                	push   $0x0
  pushl $141
80106825:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
8010682a:	e9 a0 f5 ff ff       	jmp    80105dcf <alltraps>

8010682f <vector142>:
.globl vector142
vector142:
  pushl $0
8010682f:	6a 00                	push   $0x0
  pushl $142
80106831:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80106836:	e9 94 f5 ff ff       	jmp    80105dcf <alltraps>

8010683b <vector143>:
.globl vector143
vector143:
  pushl $0
8010683b:	6a 00                	push   $0x0
  pushl $143
8010683d:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80106842:	e9 88 f5 ff ff       	jmp    80105dcf <alltraps>

80106847 <vector144>:
.globl vector144
vector144:
  pushl $0
80106847:	6a 00                	push   $0x0
  pushl $144
80106849:	68 90 00 00 00       	push   $0x90
  jmp alltraps
8010684e:	e9 7c f5 ff ff       	jmp    80105dcf <alltraps>

80106853 <vector145>:
.globl vector145
vector145:
  pushl $0
80106853:	6a 00                	push   $0x0
  pushl $145
80106855:	68 91 00 00 00       	push   $0x91
  jmp alltraps
8010685a:	e9 70 f5 ff ff       	jmp    80105dcf <alltraps>

8010685f <vector146>:
.globl vector146
vector146:
  pushl $0
8010685f:	6a 00                	push   $0x0
  pushl $146
80106861:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80106866:	e9 64 f5 ff ff       	jmp    80105dcf <alltraps>

8010686b <vector147>:
.globl vector147
vector147:
  pushl $0
8010686b:	6a 00                	push   $0x0
  pushl $147
8010686d:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80106872:	e9 58 f5 ff ff       	jmp    80105dcf <alltraps>

80106877 <vector148>:
.globl vector148
vector148:
  pushl $0
80106877:	6a 00                	push   $0x0
  pushl $148
80106879:	68 94 00 00 00       	push   $0x94
  jmp alltraps
8010687e:	e9 4c f5 ff ff       	jmp    80105dcf <alltraps>

80106883 <vector149>:
.globl vector149
vector149:
  pushl $0
80106883:	6a 00                	push   $0x0
  pushl $149
80106885:	68 95 00 00 00       	push   $0x95
  jmp alltraps
8010688a:	e9 40 f5 ff ff       	jmp    80105dcf <alltraps>

8010688f <vector150>:
.globl vector150
vector150:
  pushl $0
8010688f:	6a 00                	push   $0x0
  pushl $150
80106891:	68 96 00 00 00       	push   $0x96
  jmp alltraps
80106896:	e9 34 f5 ff ff       	jmp    80105dcf <alltraps>

8010689b <vector151>:
.globl vector151
vector151:
  pushl $0
8010689b:	6a 00                	push   $0x0
  pushl $151
8010689d:	68 97 00 00 00       	push   $0x97
  jmp alltraps
801068a2:	e9 28 f5 ff ff       	jmp    80105dcf <alltraps>

801068a7 <vector152>:
.globl vector152
vector152:
  pushl $0
801068a7:	6a 00                	push   $0x0
  pushl $152
801068a9:	68 98 00 00 00       	push   $0x98
  jmp alltraps
801068ae:	e9 1c f5 ff ff       	jmp    80105dcf <alltraps>

801068b3 <vector153>:
.globl vector153
vector153:
  pushl $0
801068b3:	6a 00                	push   $0x0
  pushl $153
801068b5:	68 99 00 00 00       	push   $0x99
  jmp alltraps
801068ba:	e9 10 f5 ff ff       	jmp    80105dcf <alltraps>

801068bf <vector154>:
.globl vector154
vector154:
  pushl $0
801068bf:	6a 00                	push   $0x0
  pushl $154
801068c1:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
801068c6:	e9 04 f5 ff ff       	jmp    80105dcf <alltraps>

801068cb <vector155>:
.globl vector155
vector155:
  pushl $0
801068cb:	6a 00                	push   $0x0
  pushl $155
801068cd:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
801068d2:	e9 f8 f4 ff ff       	jmp    80105dcf <alltraps>

801068d7 <vector156>:
.globl vector156
vector156:
  pushl $0
801068d7:	6a 00                	push   $0x0
  pushl $156
801068d9:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
801068de:	e9 ec f4 ff ff       	jmp    80105dcf <alltraps>

801068e3 <vector157>:
.globl vector157
vector157:
  pushl $0
801068e3:	6a 00                	push   $0x0
  pushl $157
801068e5:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
801068ea:	e9 e0 f4 ff ff       	jmp    80105dcf <alltraps>

801068ef <vector158>:
.globl vector158
vector158:
  pushl $0
801068ef:	6a 00                	push   $0x0
  pushl $158
801068f1:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
801068f6:	e9 d4 f4 ff ff       	jmp    80105dcf <alltraps>

801068fb <vector159>:
.globl vector159
vector159:
  pushl $0
801068fb:	6a 00                	push   $0x0
  pushl $159
801068fd:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
80106902:	e9 c8 f4 ff ff       	jmp    80105dcf <alltraps>

80106907 <vector160>:
.globl vector160
vector160:
  pushl $0
80106907:	6a 00                	push   $0x0
  pushl $160
80106909:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
8010690e:	e9 bc f4 ff ff       	jmp    80105dcf <alltraps>

80106913 <vector161>:
.globl vector161
vector161:
  pushl $0
80106913:	6a 00                	push   $0x0
  pushl $161
80106915:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
8010691a:	e9 b0 f4 ff ff       	jmp    80105dcf <alltraps>

8010691f <vector162>:
.globl vector162
vector162:
  pushl $0
8010691f:	6a 00                	push   $0x0
  pushl $162
80106921:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
80106926:	e9 a4 f4 ff ff       	jmp    80105dcf <alltraps>

8010692b <vector163>:
.globl vector163
vector163:
  pushl $0
8010692b:	6a 00                	push   $0x0
  pushl $163
8010692d:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
80106932:	e9 98 f4 ff ff       	jmp    80105dcf <alltraps>

80106937 <vector164>:
.globl vector164
vector164:
  pushl $0
80106937:	6a 00                	push   $0x0
  pushl $164
80106939:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
8010693e:	e9 8c f4 ff ff       	jmp    80105dcf <alltraps>

80106943 <vector165>:
.globl vector165
vector165:
  pushl $0
80106943:	6a 00                	push   $0x0
  pushl $165
80106945:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
8010694a:	e9 80 f4 ff ff       	jmp    80105dcf <alltraps>

8010694f <vector166>:
.globl vector166
vector166:
  pushl $0
8010694f:	6a 00                	push   $0x0
  pushl $166
80106951:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80106956:	e9 74 f4 ff ff       	jmp    80105dcf <alltraps>

8010695b <vector167>:
.globl vector167
vector167:
  pushl $0
8010695b:	6a 00                	push   $0x0
  pushl $167
8010695d:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80106962:	e9 68 f4 ff ff       	jmp    80105dcf <alltraps>

80106967 <vector168>:
.globl vector168
vector168:
  pushl $0
80106967:	6a 00                	push   $0x0
  pushl $168
80106969:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
8010696e:	e9 5c f4 ff ff       	jmp    80105dcf <alltraps>

80106973 <vector169>:
.globl vector169
vector169:
  pushl $0
80106973:	6a 00                	push   $0x0
  pushl $169
80106975:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
8010697a:	e9 50 f4 ff ff       	jmp    80105dcf <alltraps>

8010697f <vector170>:
.globl vector170
vector170:
  pushl $0
8010697f:	6a 00                	push   $0x0
  pushl $170
80106981:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80106986:	e9 44 f4 ff ff       	jmp    80105dcf <alltraps>

8010698b <vector171>:
.globl vector171
vector171:
  pushl $0
8010698b:	6a 00                	push   $0x0
  pushl $171
8010698d:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80106992:	e9 38 f4 ff ff       	jmp    80105dcf <alltraps>

80106997 <vector172>:
.globl vector172
vector172:
  pushl $0
80106997:	6a 00                	push   $0x0
  pushl $172
80106999:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
8010699e:	e9 2c f4 ff ff       	jmp    80105dcf <alltraps>

801069a3 <vector173>:
.globl vector173
vector173:
  pushl $0
801069a3:	6a 00                	push   $0x0
  pushl $173
801069a5:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
801069aa:	e9 20 f4 ff ff       	jmp    80105dcf <alltraps>

801069af <vector174>:
.globl vector174
vector174:
  pushl $0
801069af:	6a 00                	push   $0x0
  pushl $174
801069b1:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
801069b6:	e9 14 f4 ff ff       	jmp    80105dcf <alltraps>

801069bb <vector175>:
.globl vector175
vector175:
  pushl $0
801069bb:	6a 00                	push   $0x0
  pushl $175
801069bd:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
801069c2:	e9 08 f4 ff ff       	jmp    80105dcf <alltraps>

801069c7 <vector176>:
.globl vector176
vector176:
  pushl $0
801069c7:	6a 00                	push   $0x0
  pushl $176
801069c9:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
801069ce:	e9 fc f3 ff ff       	jmp    80105dcf <alltraps>

801069d3 <vector177>:
.globl vector177
vector177:
  pushl $0
801069d3:	6a 00                	push   $0x0
  pushl $177
801069d5:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
801069da:	e9 f0 f3 ff ff       	jmp    80105dcf <alltraps>

801069df <vector178>:
.globl vector178
vector178:
  pushl $0
801069df:	6a 00                	push   $0x0
  pushl $178
801069e1:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
801069e6:	e9 e4 f3 ff ff       	jmp    80105dcf <alltraps>

801069eb <vector179>:
.globl vector179
vector179:
  pushl $0
801069eb:	6a 00                	push   $0x0
  pushl $179
801069ed:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
801069f2:	e9 d8 f3 ff ff       	jmp    80105dcf <alltraps>

801069f7 <vector180>:
.globl vector180
vector180:
  pushl $0
801069f7:	6a 00                	push   $0x0
  pushl $180
801069f9:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
801069fe:	e9 cc f3 ff ff       	jmp    80105dcf <alltraps>

80106a03 <vector181>:
.globl vector181
vector181:
  pushl $0
80106a03:	6a 00                	push   $0x0
  pushl $181
80106a05:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
80106a0a:	e9 c0 f3 ff ff       	jmp    80105dcf <alltraps>

80106a0f <vector182>:
.globl vector182
vector182:
  pushl $0
80106a0f:	6a 00                	push   $0x0
  pushl $182
80106a11:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
80106a16:	e9 b4 f3 ff ff       	jmp    80105dcf <alltraps>

80106a1b <vector183>:
.globl vector183
vector183:
  pushl $0
80106a1b:	6a 00                	push   $0x0
  pushl $183
80106a1d:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
80106a22:	e9 a8 f3 ff ff       	jmp    80105dcf <alltraps>

80106a27 <vector184>:
.globl vector184
vector184:
  pushl $0
80106a27:	6a 00                	push   $0x0
  pushl $184
80106a29:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
80106a2e:	e9 9c f3 ff ff       	jmp    80105dcf <alltraps>

80106a33 <vector185>:
.globl vector185
vector185:
  pushl $0
80106a33:	6a 00                	push   $0x0
  pushl $185
80106a35:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
80106a3a:	e9 90 f3 ff ff       	jmp    80105dcf <alltraps>

80106a3f <vector186>:
.globl vector186
vector186:
  pushl $0
80106a3f:	6a 00                	push   $0x0
  pushl $186
80106a41:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
80106a46:	e9 84 f3 ff ff       	jmp    80105dcf <alltraps>

80106a4b <vector187>:
.globl vector187
vector187:
  pushl $0
80106a4b:	6a 00                	push   $0x0
  pushl $187
80106a4d:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80106a52:	e9 78 f3 ff ff       	jmp    80105dcf <alltraps>

80106a57 <vector188>:
.globl vector188
vector188:
  pushl $0
80106a57:	6a 00                	push   $0x0
  pushl $188
80106a59:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
80106a5e:	e9 6c f3 ff ff       	jmp    80105dcf <alltraps>

80106a63 <vector189>:
.globl vector189
vector189:
  pushl $0
80106a63:	6a 00                	push   $0x0
  pushl $189
80106a65:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
80106a6a:	e9 60 f3 ff ff       	jmp    80105dcf <alltraps>

80106a6f <vector190>:
.globl vector190
vector190:
  pushl $0
80106a6f:	6a 00                	push   $0x0
  pushl $190
80106a71:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80106a76:	e9 54 f3 ff ff       	jmp    80105dcf <alltraps>

80106a7b <vector191>:
.globl vector191
vector191:
  pushl $0
80106a7b:	6a 00                	push   $0x0
  pushl $191
80106a7d:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80106a82:	e9 48 f3 ff ff       	jmp    80105dcf <alltraps>

80106a87 <vector192>:
.globl vector192
vector192:
  pushl $0
80106a87:	6a 00                	push   $0x0
  pushl $192
80106a89:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
80106a8e:	e9 3c f3 ff ff       	jmp    80105dcf <alltraps>

80106a93 <vector193>:
.globl vector193
vector193:
  pushl $0
80106a93:	6a 00                	push   $0x0
  pushl $193
80106a95:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
80106a9a:	e9 30 f3 ff ff       	jmp    80105dcf <alltraps>

80106a9f <vector194>:
.globl vector194
vector194:
  pushl $0
80106a9f:	6a 00                	push   $0x0
  pushl $194
80106aa1:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
80106aa6:	e9 24 f3 ff ff       	jmp    80105dcf <alltraps>

80106aab <vector195>:
.globl vector195
vector195:
  pushl $0
80106aab:	6a 00                	push   $0x0
  pushl $195
80106aad:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
80106ab2:	e9 18 f3 ff ff       	jmp    80105dcf <alltraps>

80106ab7 <vector196>:
.globl vector196
vector196:
  pushl $0
80106ab7:	6a 00                	push   $0x0
  pushl $196
80106ab9:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
80106abe:	e9 0c f3 ff ff       	jmp    80105dcf <alltraps>

80106ac3 <vector197>:
.globl vector197
vector197:
  pushl $0
80106ac3:	6a 00                	push   $0x0
  pushl $197
80106ac5:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
80106aca:	e9 00 f3 ff ff       	jmp    80105dcf <alltraps>

80106acf <vector198>:
.globl vector198
vector198:
  pushl $0
80106acf:	6a 00                	push   $0x0
  pushl $198
80106ad1:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
80106ad6:	e9 f4 f2 ff ff       	jmp    80105dcf <alltraps>

80106adb <vector199>:
.globl vector199
vector199:
  pushl $0
80106adb:	6a 00                	push   $0x0
  pushl $199
80106add:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
80106ae2:	e9 e8 f2 ff ff       	jmp    80105dcf <alltraps>

80106ae7 <vector200>:
.globl vector200
vector200:
  pushl $0
80106ae7:	6a 00                	push   $0x0
  pushl $200
80106ae9:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
80106aee:	e9 dc f2 ff ff       	jmp    80105dcf <alltraps>

80106af3 <vector201>:
.globl vector201
vector201:
  pushl $0
80106af3:	6a 00                	push   $0x0
  pushl $201
80106af5:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
80106afa:	e9 d0 f2 ff ff       	jmp    80105dcf <alltraps>

80106aff <vector202>:
.globl vector202
vector202:
  pushl $0
80106aff:	6a 00                	push   $0x0
  pushl $202
80106b01:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
80106b06:	e9 c4 f2 ff ff       	jmp    80105dcf <alltraps>

80106b0b <vector203>:
.globl vector203
vector203:
  pushl $0
80106b0b:	6a 00                	push   $0x0
  pushl $203
80106b0d:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
80106b12:	e9 b8 f2 ff ff       	jmp    80105dcf <alltraps>

80106b17 <vector204>:
.globl vector204
vector204:
  pushl $0
80106b17:	6a 00                	push   $0x0
  pushl $204
80106b19:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
80106b1e:	e9 ac f2 ff ff       	jmp    80105dcf <alltraps>

80106b23 <vector205>:
.globl vector205
vector205:
  pushl $0
80106b23:	6a 00                	push   $0x0
  pushl $205
80106b25:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
80106b2a:	e9 a0 f2 ff ff       	jmp    80105dcf <alltraps>

80106b2f <vector206>:
.globl vector206
vector206:
  pushl $0
80106b2f:	6a 00                	push   $0x0
  pushl $206
80106b31:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
80106b36:	e9 94 f2 ff ff       	jmp    80105dcf <alltraps>

80106b3b <vector207>:
.globl vector207
vector207:
  pushl $0
80106b3b:	6a 00                	push   $0x0
  pushl $207
80106b3d:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80106b42:	e9 88 f2 ff ff       	jmp    80105dcf <alltraps>

80106b47 <vector208>:
.globl vector208
vector208:
  pushl $0
80106b47:	6a 00                	push   $0x0
  pushl $208
80106b49:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
80106b4e:	e9 7c f2 ff ff       	jmp    80105dcf <alltraps>

80106b53 <vector209>:
.globl vector209
vector209:
  pushl $0
80106b53:	6a 00                	push   $0x0
  pushl $209
80106b55:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
80106b5a:	e9 70 f2 ff ff       	jmp    80105dcf <alltraps>

80106b5f <vector210>:
.globl vector210
vector210:
  pushl $0
80106b5f:	6a 00                	push   $0x0
  pushl $210
80106b61:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80106b66:	e9 64 f2 ff ff       	jmp    80105dcf <alltraps>

80106b6b <vector211>:
.globl vector211
vector211:
  pushl $0
80106b6b:	6a 00                	push   $0x0
  pushl $211
80106b6d:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80106b72:	e9 58 f2 ff ff       	jmp    80105dcf <alltraps>

80106b77 <vector212>:
.globl vector212
vector212:
  pushl $0
80106b77:	6a 00                	push   $0x0
  pushl $212
80106b79:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
80106b7e:	e9 4c f2 ff ff       	jmp    80105dcf <alltraps>

80106b83 <vector213>:
.globl vector213
vector213:
  pushl $0
80106b83:	6a 00                	push   $0x0
  pushl $213
80106b85:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
80106b8a:	e9 40 f2 ff ff       	jmp    80105dcf <alltraps>

80106b8f <vector214>:
.globl vector214
vector214:
  pushl $0
80106b8f:	6a 00                	push   $0x0
  pushl $214
80106b91:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80106b96:	e9 34 f2 ff ff       	jmp    80105dcf <alltraps>

80106b9b <vector215>:
.globl vector215
vector215:
  pushl $0
80106b9b:	6a 00                	push   $0x0
  pushl $215
80106b9d:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80106ba2:	e9 28 f2 ff ff       	jmp    80105dcf <alltraps>

80106ba7 <vector216>:
.globl vector216
vector216:
  pushl $0
80106ba7:	6a 00                	push   $0x0
  pushl $216
80106ba9:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
80106bae:	e9 1c f2 ff ff       	jmp    80105dcf <alltraps>

80106bb3 <vector217>:
.globl vector217
vector217:
  pushl $0
80106bb3:	6a 00                	push   $0x0
  pushl $217
80106bb5:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
80106bba:	e9 10 f2 ff ff       	jmp    80105dcf <alltraps>

80106bbf <vector218>:
.globl vector218
vector218:
  pushl $0
80106bbf:	6a 00                	push   $0x0
  pushl $218
80106bc1:	68 da 00 00 00       	push   $0xda
  jmp alltraps
80106bc6:	e9 04 f2 ff ff       	jmp    80105dcf <alltraps>

80106bcb <vector219>:
.globl vector219
vector219:
  pushl $0
80106bcb:	6a 00                	push   $0x0
  pushl $219
80106bcd:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80106bd2:	e9 f8 f1 ff ff       	jmp    80105dcf <alltraps>

80106bd7 <vector220>:
.globl vector220
vector220:
  pushl $0
80106bd7:	6a 00                	push   $0x0
  pushl $220
80106bd9:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
80106bde:	e9 ec f1 ff ff       	jmp    80105dcf <alltraps>

80106be3 <vector221>:
.globl vector221
vector221:
  pushl $0
80106be3:	6a 00                	push   $0x0
  pushl $221
80106be5:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
80106bea:	e9 e0 f1 ff ff       	jmp    80105dcf <alltraps>

80106bef <vector222>:
.globl vector222
vector222:
  pushl $0
80106bef:	6a 00                	push   $0x0
  pushl $222
80106bf1:	68 de 00 00 00       	push   $0xde
  jmp alltraps
80106bf6:	e9 d4 f1 ff ff       	jmp    80105dcf <alltraps>

80106bfb <vector223>:
.globl vector223
vector223:
  pushl $0
80106bfb:	6a 00                	push   $0x0
  pushl $223
80106bfd:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
80106c02:	e9 c8 f1 ff ff       	jmp    80105dcf <alltraps>

80106c07 <vector224>:
.globl vector224
vector224:
  pushl $0
80106c07:	6a 00                	push   $0x0
  pushl $224
80106c09:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
80106c0e:	e9 bc f1 ff ff       	jmp    80105dcf <alltraps>

80106c13 <vector225>:
.globl vector225
vector225:
  pushl $0
80106c13:	6a 00                	push   $0x0
  pushl $225
80106c15:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
80106c1a:	e9 b0 f1 ff ff       	jmp    80105dcf <alltraps>

80106c1f <vector226>:
.globl vector226
vector226:
  pushl $0
80106c1f:	6a 00                	push   $0x0
  pushl $226
80106c21:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80106c26:	e9 a4 f1 ff ff       	jmp    80105dcf <alltraps>

80106c2b <vector227>:
.globl vector227
vector227:
  pushl $0
80106c2b:	6a 00                	push   $0x0
  pushl $227
80106c2d:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80106c32:	e9 98 f1 ff ff       	jmp    80105dcf <alltraps>

80106c37 <vector228>:
.globl vector228
vector228:
  pushl $0
80106c37:	6a 00                	push   $0x0
  pushl $228
80106c39:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
80106c3e:	e9 8c f1 ff ff       	jmp    80105dcf <alltraps>

80106c43 <vector229>:
.globl vector229
vector229:
  pushl $0
80106c43:	6a 00                	push   $0x0
  pushl $229
80106c45:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
80106c4a:	e9 80 f1 ff ff       	jmp    80105dcf <alltraps>

80106c4f <vector230>:
.globl vector230
vector230:
  pushl $0
80106c4f:	6a 00                	push   $0x0
  pushl $230
80106c51:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80106c56:	e9 74 f1 ff ff       	jmp    80105dcf <alltraps>

80106c5b <vector231>:
.globl vector231
vector231:
  pushl $0
80106c5b:	6a 00                	push   $0x0
  pushl $231
80106c5d:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80106c62:	e9 68 f1 ff ff       	jmp    80105dcf <alltraps>

80106c67 <vector232>:
.globl vector232
vector232:
  pushl $0
80106c67:	6a 00                	push   $0x0
  pushl $232
80106c69:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
80106c6e:	e9 5c f1 ff ff       	jmp    80105dcf <alltraps>

80106c73 <vector233>:
.globl vector233
vector233:
  pushl $0
80106c73:	6a 00                	push   $0x0
  pushl $233
80106c75:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
80106c7a:	e9 50 f1 ff ff       	jmp    80105dcf <alltraps>

80106c7f <vector234>:
.globl vector234
vector234:
  pushl $0
80106c7f:	6a 00                	push   $0x0
  pushl $234
80106c81:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80106c86:	e9 44 f1 ff ff       	jmp    80105dcf <alltraps>

80106c8b <vector235>:
.globl vector235
vector235:
  pushl $0
80106c8b:	6a 00                	push   $0x0
  pushl $235
80106c8d:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80106c92:	e9 38 f1 ff ff       	jmp    80105dcf <alltraps>

80106c97 <vector236>:
.globl vector236
vector236:
  pushl $0
80106c97:	6a 00                	push   $0x0
  pushl $236
80106c99:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
80106c9e:	e9 2c f1 ff ff       	jmp    80105dcf <alltraps>

80106ca3 <vector237>:
.globl vector237
vector237:
  pushl $0
80106ca3:	6a 00                	push   $0x0
  pushl $237
80106ca5:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
80106caa:	e9 20 f1 ff ff       	jmp    80105dcf <alltraps>

80106caf <vector238>:
.globl vector238
vector238:
  pushl $0
80106caf:	6a 00                	push   $0x0
  pushl $238
80106cb1:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80106cb6:	e9 14 f1 ff ff       	jmp    80105dcf <alltraps>

80106cbb <vector239>:
.globl vector239
vector239:
  pushl $0
80106cbb:	6a 00                	push   $0x0
  pushl $239
80106cbd:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80106cc2:	e9 08 f1 ff ff       	jmp    80105dcf <alltraps>

80106cc7 <vector240>:
.globl vector240
vector240:
  pushl $0
80106cc7:	6a 00                	push   $0x0
  pushl $240
80106cc9:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
80106cce:	e9 fc f0 ff ff       	jmp    80105dcf <alltraps>

80106cd3 <vector241>:
.globl vector241
vector241:
  pushl $0
80106cd3:	6a 00                	push   $0x0
  pushl $241
80106cd5:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
80106cda:	e9 f0 f0 ff ff       	jmp    80105dcf <alltraps>

80106cdf <vector242>:
.globl vector242
vector242:
  pushl $0
80106cdf:	6a 00                	push   $0x0
  pushl $242
80106ce1:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80106ce6:	e9 e4 f0 ff ff       	jmp    80105dcf <alltraps>

80106ceb <vector243>:
.globl vector243
vector243:
  pushl $0
80106ceb:	6a 00                	push   $0x0
  pushl $243
80106ced:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
80106cf2:	e9 d8 f0 ff ff       	jmp    80105dcf <alltraps>

80106cf7 <vector244>:
.globl vector244
vector244:
  pushl $0
80106cf7:	6a 00                	push   $0x0
  pushl $244
80106cf9:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
80106cfe:	e9 cc f0 ff ff       	jmp    80105dcf <alltraps>

80106d03 <vector245>:
.globl vector245
vector245:
  pushl $0
80106d03:	6a 00                	push   $0x0
  pushl $245
80106d05:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
80106d0a:	e9 c0 f0 ff ff       	jmp    80105dcf <alltraps>

80106d0f <vector246>:
.globl vector246
vector246:
  pushl $0
80106d0f:	6a 00                	push   $0x0
  pushl $246
80106d11:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80106d16:	e9 b4 f0 ff ff       	jmp    80105dcf <alltraps>

80106d1b <vector247>:
.globl vector247
vector247:
  pushl $0
80106d1b:	6a 00                	push   $0x0
  pushl $247
80106d1d:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80106d22:	e9 a8 f0 ff ff       	jmp    80105dcf <alltraps>

80106d27 <vector248>:
.globl vector248
vector248:
  pushl $0
80106d27:	6a 00                	push   $0x0
  pushl $248
80106d29:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
80106d2e:	e9 9c f0 ff ff       	jmp    80105dcf <alltraps>

80106d33 <vector249>:
.globl vector249
vector249:
  pushl $0
80106d33:	6a 00                	push   $0x0
  pushl $249
80106d35:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
80106d3a:	e9 90 f0 ff ff       	jmp    80105dcf <alltraps>

80106d3f <vector250>:
.globl vector250
vector250:
  pushl $0
80106d3f:	6a 00                	push   $0x0
  pushl $250
80106d41:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80106d46:	e9 84 f0 ff ff       	jmp    80105dcf <alltraps>

80106d4b <vector251>:
.globl vector251
vector251:
  pushl $0
80106d4b:	6a 00                	push   $0x0
  pushl $251
80106d4d:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80106d52:	e9 78 f0 ff ff       	jmp    80105dcf <alltraps>

80106d57 <vector252>:
.globl vector252
vector252:
  pushl $0
80106d57:	6a 00                	push   $0x0
  pushl $252
80106d59:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
80106d5e:	e9 6c f0 ff ff       	jmp    80105dcf <alltraps>

80106d63 <vector253>:
.globl vector253
vector253:
  pushl $0
80106d63:	6a 00                	push   $0x0
  pushl $253
80106d65:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
80106d6a:	e9 60 f0 ff ff       	jmp    80105dcf <alltraps>

80106d6f <vector254>:
.globl vector254
vector254:
  pushl $0
80106d6f:	6a 00                	push   $0x0
  pushl $254
80106d71:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80106d76:	e9 54 f0 ff ff       	jmp    80105dcf <alltraps>

80106d7b <vector255>:
.globl vector255
vector255:
  pushl $0
80106d7b:	6a 00                	push   $0x0
  pushl $255
80106d7d:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80106d82:	e9 48 f0 ff ff       	jmp    80105dcf <alltraps>
80106d87:	66 90                	xchg   %ax,%ax
80106d89:	66 90                	xchg   %ax,%ax
80106d8b:	66 90                	xchg   %ax,%ax
80106d8d:	66 90                	xchg   %ax,%ax
80106d8f:	90                   	nop

80106d90 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80106d90:	55                   	push   %ebp
80106d91:	89 e5                	mov    %esp,%ebp
80106d93:	57                   	push   %edi
80106d94:	56                   	push   %esi
80106d95:	53                   	push   %ebx
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80106d96:	89 d3                	mov    %edx,%ebx
{
80106d98:	89 d7                	mov    %edx,%edi
  pde = &pgdir[PDX(va)];
80106d9a:	c1 eb 16             	shr    $0x16,%ebx
80106d9d:	8d 34 98             	lea    (%eax,%ebx,4),%esi
{
80106da0:	83 ec 0c             	sub    $0xc,%esp
  if(*pde & PTE_P){
80106da3:	8b 06                	mov    (%esi),%eax
80106da5:	a8 01                	test   $0x1,%al
80106da7:	74 27                	je     80106dd0 <walkpgdir+0x40>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106da9:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106dae:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
80106db4:	c1 ef 0a             	shr    $0xa,%edi
}
80106db7:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return &pgtab[PTX(va)];
80106dba:	89 fa                	mov    %edi,%edx
80106dbc:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80106dc2:	8d 04 13             	lea    (%ebx,%edx,1),%eax
}
80106dc5:	5b                   	pop    %ebx
80106dc6:	5e                   	pop    %esi
80106dc7:	5f                   	pop    %edi
80106dc8:	5d                   	pop    %ebp
80106dc9:	c3                   	ret    
80106dca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80106dd0:	85 c9                	test   %ecx,%ecx
80106dd2:	74 2c                	je     80106e00 <walkpgdir+0x70>
80106dd4:	e8 17 b7 ff ff       	call   801024f0 <kalloc>
80106dd9:	85 c0                	test   %eax,%eax
80106ddb:	89 c3                	mov    %eax,%ebx
80106ddd:	74 21                	je     80106e00 <walkpgdir+0x70>
    memset(pgtab, 0, PGSIZE);
80106ddf:	83 ec 04             	sub    $0x4,%esp
80106de2:	68 00 10 00 00       	push   $0x1000
80106de7:	6a 00                	push   $0x0
80106de9:	50                   	push   %eax
80106dea:	e8 31 dd ff ff       	call   80104b20 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80106def:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106df5:	83 c4 10             	add    $0x10,%esp
80106df8:	83 c8 07             	or     $0x7,%eax
80106dfb:	89 06                	mov    %eax,(%esi)
80106dfd:	eb b5                	jmp    80106db4 <walkpgdir+0x24>
80106dff:	90                   	nop
}
80106e00:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 0;
80106e03:	31 c0                	xor    %eax,%eax
}
80106e05:	5b                   	pop    %ebx
80106e06:	5e                   	pop    %esi
80106e07:	5f                   	pop    %edi
80106e08:	5d                   	pop    %ebp
80106e09:	c3                   	ret    
80106e0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106e10 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80106e10:	55                   	push   %ebp
80106e11:	89 e5                	mov    %esp,%ebp
80106e13:	57                   	push   %edi
80106e14:	56                   	push   %esi
80106e15:	53                   	push   %ebx
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
80106e16:	89 d3                	mov    %edx,%ebx
80106e18:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
{
80106e1e:	83 ec 1c             	sub    $0x1c,%esp
80106e21:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80106e24:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
80106e28:	8b 7d 08             	mov    0x8(%ebp),%edi
80106e2b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106e30:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
80106e33:	8b 45 0c             	mov    0xc(%ebp),%eax
80106e36:	29 df                	sub    %ebx,%edi
80106e38:	83 c8 01             	or     $0x1,%eax
80106e3b:	89 45 dc             	mov    %eax,-0x24(%ebp)
80106e3e:	eb 15                	jmp    80106e55 <mappages+0x45>
    if(*pte & PTE_P)
80106e40:	f6 00 01             	testb  $0x1,(%eax)
80106e43:	75 45                	jne    80106e8a <mappages+0x7a>
    *pte = pa | perm | PTE_P;
80106e45:	0b 75 dc             	or     -0x24(%ebp),%esi
    if(a == last)
80106e48:	3b 5d e0             	cmp    -0x20(%ebp),%ebx
    *pte = pa | perm | PTE_P;
80106e4b:	89 30                	mov    %esi,(%eax)
    if(a == last)
80106e4d:	74 31                	je     80106e80 <mappages+0x70>
      break;
    a += PGSIZE;
80106e4f:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80106e55:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106e58:	b9 01 00 00 00       	mov    $0x1,%ecx
80106e5d:	89 da                	mov    %ebx,%edx
80106e5f:	8d 34 3b             	lea    (%ebx,%edi,1),%esi
80106e62:	e8 29 ff ff ff       	call   80106d90 <walkpgdir>
80106e67:	85 c0                	test   %eax,%eax
80106e69:	75 d5                	jne    80106e40 <mappages+0x30>
    pa += PGSIZE;
  }
  return 0;
}
80106e6b:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80106e6e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106e73:	5b                   	pop    %ebx
80106e74:	5e                   	pop    %esi
80106e75:	5f                   	pop    %edi
80106e76:	5d                   	pop    %ebp
80106e77:	c3                   	ret    
80106e78:	90                   	nop
80106e79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106e80:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80106e83:	31 c0                	xor    %eax,%eax
}
80106e85:	5b                   	pop    %ebx
80106e86:	5e                   	pop    %esi
80106e87:	5f                   	pop    %edi
80106e88:	5d                   	pop    %ebp
80106e89:	c3                   	ret    
      panic("remap");
80106e8a:	83 ec 0c             	sub    $0xc,%esp
80106e8d:	68 74 7f 10 80       	push   $0x80107f74
80106e92:	e8 f9 94 ff ff       	call   80100390 <panic>
80106e97:	89 f6                	mov    %esi,%esi
80106e99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106ea0 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106ea0:	55                   	push   %ebp
80106ea1:	89 e5                	mov    %esp,%ebp
80106ea3:	57                   	push   %edi
80106ea4:	56                   	push   %esi
80106ea5:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80106ea6:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106eac:	89 c7                	mov    %eax,%edi
  a = PGROUNDUP(newsz);
80106eae:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106eb4:	83 ec 1c             	sub    $0x1c,%esp
80106eb7:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  for(; a  < oldsz; a += PGSIZE){
80106eba:	39 d3                	cmp    %edx,%ebx
80106ebc:	73 66                	jae    80106f24 <deallocuvm.part.0+0x84>
80106ebe:	89 d6                	mov    %edx,%esi
80106ec0:	eb 3d                	jmp    80106eff <deallocuvm.part.0+0x5f>
80106ec2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
80106ec8:	8b 10                	mov    (%eax),%edx
80106eca:	f6 c2 01             	test   $0x1,%dl
80106ecd:	74 26                	je     80106ef5 <deallocuvm.part.0+0x55>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
80106ecf:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80106ed5:	74 58                	je     80106f2f <deallocuvm.part.0+0x8f>
        panic("kfree");
      char *v = P2V(pa);
      kfree(v);
80106ed7:	83 ec 0c             	sub    $0xc,%esp
      char *v = P2V(pa);
80106eda:	81 c2 00 00 00 80    	add    $0x80000000,%edx
80106ee0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      kfree(v);
80106ee3:	52                   	push   %edx
80106ee4:	e8 57 b4 ff ff       	call   80102340 <kfree>
      *pte = 0;
80106ee9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106eec:	83 c4 10             	add    $0x10,%esp
80106eef:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; a  < oldsz; a += PGSIZE){
80106ef5:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106efb:	39 f3                	cmp    %esi,%ebx
80106efd:	73 25                	jae    80106f24 <deallocuvm.part.0+0x84>
    pte = walkpgdir(pgdir, (char*)a, 0);
80106eff:	31 c9                	xor    %ecx,%ecx
80106f01:	89 da                	mov    %ebx,%edx
80106f03:	89 f8                	mov    %edi,%eax
80106f05:	e8 86 fe ff ff       	call   80106d90 <walkpgdir>
    if(!pte)
80106f0a:	85 c0                	test   %eax,%eax
80106f0c:	75 ba                	jne    80106ec8 <deallocuvm.part.0+0x28>
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
80106f0e:	81 e3 00 00 c0 ff    	and    $0xffc00000,%ebx
80106f14:	81 c3 00 f0 3f 00    	add    $0x3ff000,%ebx
  for(; a  < oldsz; a += PGSIZE){
80106f1a:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106f20:	39 f3                	cmp    %esi,%ebx
80106f22:	72 db                	jb     80106eff <deallocuvm.part.0+0x5f>
    }
  }
  return newsz;
}
80106f24:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106f27:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106f2a:	5b                   	pop    %ebx
80106f2b:	5e                   	pop    %esi
80106f2c:	5f                   	pop    %edi
80106f2d:	5d                   	pop    %ebp
80106f2e:	c3                   	ret    
        panic("kfree");
80106f2f:	83 ec 0c             	sub    $0xc,%esp
80106f32:	68 26 79 10 80       	push   $0x80107926
80106f37:	e8 54 94 ff ff       	call   80100390 <panic>
80106f3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106f40 <seginit>:
{
80106f40:	55                   	push   %ebp
80106f41:	89 e5                	mov    %esp,%ebp
80106f43:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
80106f46:	e8 e5 c8 ff ff       	call   80103830 <cpuid>
80106f4b:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
  pd[0] = size-1;
80106f51:	ba 2f 00 00 00       	mov    $0x2f,%edx
80106f56:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80106f5a:	c7 80 f8 37 11 80 ff 	movl   $0xffff,-0x7feec808(%eax)
80106f61:	ff 00 00 
80106f64:	c7 80 fc 37 11 80 00 	movl   $0xcf9a00,-0x7feec804(%eax)
80106f6b:	9a cf 00 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106f6e:	c7 80 00 38 11 80 ff 	movl   $0xffff,-0x7feec800(%eax)
80106f75:	ff 00 00 
80106f78:	c7 80 04 38 11 80 00 	movl   $0xcf9200,-0x7feec7fc(%eax)
80106f7f:	92 cf 00 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106f82:	c7 80 08 38 11 80 ff 	movl   $0xffff,-0x7feec7f8(%eax)
80106f89:	ff 00 00 
80106f8c:	c7 80 0c 38 11 80 00 	movl   $0xcffa00,-0x7feec7f4(%eax)
80106f93:	fa cf 00 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106f96:	c7 80 10 38 11 80 ff 	movl   $0xffff,-0x7feec7f0(%eax)
80106f9d:	ff 00 00 
80106fa0:	c7 80 14 38 11 80 00 	movl   $0xcff200,-0x7feec7ec(%eax)
80106fa7:	f2 cf 00 
  lgdt(c->gdt, sizeof(c->gdt));
80106faa:	05 f0 37 11 80       	add    $0x801137f0,%eax
  pd[1] = (uint)p;
80106faf:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80106fb3:	c1 e8 10             	shr    $0x10,%eax
80106fb6:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
80106fba:	8d 45 f2             	lea    -0xe(%ebp),%eax
80106fbd:	0f 01 10             	lgdtl  (%eax)
}
80106fc0:	c9                   	leave  
80106fc1:	c3                   	ret    
80106fc2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106fc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106fd0 <switchkvm>:
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106fd0:	a1 a4 ac 11 80       	mov    0x8011aca4,%eax
{
80106fd5:	55                   	push   %ebp
80106fd6:	89 e5                	mov    %esp,%ebp
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106fd8:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106fdd:	0f 22 d8             	mov    %eax,%cr3
}
80106fe0:	5d                   	pop    %ebp
80106fe1:	c3                   	ret    
80106fe2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106fe9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106ff0 <switchuvm>:
{
80106ff0:	55                   	push   %ebp
80106ff1:	89 e5                	mov    %esp,%ebp
80106ff3:	57                   	push   %edi
80106ff4:	56                   	push   %esi
80106ff5:	53                   	push   %ebx
80106ff6:	83 ec 1c             	sub    $0x1c,%esp
80106ff9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(p == 0)
80106ffc:	85 db                	test   %ebx,%ebx
80106ffe:	0f 84 cb 00 00 00    	je     801070cf <switchuvm+0xdf>
  if(p->kstack == 0)
80107004:	8b 43 08             	mov    0x8(%ebx),%eax
80107007:	85 c0                	test   %eax,%eax
80107009:	0f 84 da 00 00 00    	je     801070e9 <switchuvm+0xf9>
  if(p->pgdir == 0)
8010700f:	8b 43 04             	mov    0x4(%ebx),%eax
80107012:	85 c0                	test   %eax,%eax
80107014:	0f 84 c2 00 00 00    	je     801070dc <switchuvm+0xec>
  pushcli();
8010701a:	e8 21 d9 ff ff       	call   80104940 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
8010701f:	e8 8c c7 ff ff       	call   801037b0 <mycpu>
80107024:	89 c6                	mov    %eax,%esi
80107026:	e8 85 c7 ff ff       	call   801037b0 <mycpu>
8010702b:	89 c7                	mov    %eax,%edi
8010702d:	e8 7e c7 ff ff       	call   801037b0 <mycpu>
80107032:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107035:	83 c7 08             	add    $0x8,%edi
80107038:	e8 73 c7 ff ff       	call   801037b0 <mycpu>
8010703d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80107040:	83 c0 08             	add    $0x8,%eax
80107043:	ba 67 00 00 00       	mov    $0x67,%edx
80107048:	c1 e8 18             	shr    $0x18,%eax
8010704b:	66 89 96 98 00 00 00 	mov    %dx,0x98(%esi)
80107052:	66 89 be 9a 00 00 00 	mov    %di,0x9a(%esi)
80107059:	88 86 9f 00 00 00    	mov    %al,0x9f(%esi)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
8010705f:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80107064:	83 c1 08             	add    $0x8,%ecx
80107067:	c1 e9 10             	shr    $0x10,%ecx
8010706a:	88 8e 9c 00 00 00    	mov    %cl,0x9c(%esi)
80107070:	b9 99 40 00 00       	mov    $0x4099,%ecx
80107075:	66 89 8e 9d 00 00 00 	mov    %cx,0x9d(%esi)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
8010707c:	be 10 00 00 00       	mov    $0x10,%esi
  mycpu()->gdt[SEG_TSS].s = 0;
80107081:	e8 2a c7 ff ff       	call   801037b0 <mycpu>
80107086:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
8010708d:	e8 1e c7 ff ff       	call   801037b0 <mycpu>
80107092:	66 89 70 10          	mov    %si,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80107096:	8b 73 08             	mov    0x8(%ebx),%esi
80107099:	e8 12 c7 ff ff       	call   801037b0 <mycpu>
8010709e:	81 c6 00 10 00 00    	add    $0x1000,%esi
801070a4:	89 70 0c             	mov    %esi,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
801070a7:	e8 04 c7 ff ff       	call   801037b0 <mycpu>
801070ac:	66 89 78 6e          	mov    %di,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
801070b0:	b8 28 00 00 00       	mov    $0x28,%eax
801070b5:	0f 00 d8             	ltr    %ax
  lcr3(V2P(p->pgdir));  // switch to process's address space
801070b8:	8b 43 04             	mov    0x4(%ebx),%eax
801070bb:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
801070c0:	0f 22 d8             	mov    %eax,%cr3
}
801070c3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801070c6:	5b                   	pop    %ebx
801070c7:	5e                   	pop    %esi
801070c8:	5f                   	pop    %edi
801070c9:	5d                   	pop    %ebp
  popcli();
801070ca:	e9 b1 d8 ff ff       	jmp    80104980 <popcli>
    panic("switchuvm: no process");
801070cf:	83 ec 0c             	sub    $0xc,%esp
801070d2:	68 7a 7f 10 80       	push   $0x80107f7a
801070d7:	e8 b4 92 ff ff       	call   80100390 <panic>
    panic("switchuvm: no pgdir");
801070dc:	83 ec 0c             	sub    $0xc,%esp
801070df:	68 a5 7f 10 80       	push   $0x80107fa5
801070e4:	e8 a7 92 ff ff       	call   80100390 <panic>
    panic("switchuvm: no kstack");
801070e9:	83 ec 0c             	sub    $0xc,%esp
801070ec:	68 90 7f 10 80       	push   $0x80107f90
801070f1:	e8 9a 92 ff ff       	call   80100390 <panic>
801070f6:	8d 76 00             	lea    0x0(%esi),%esi
801070f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107100 <inituvm>:
{
80107100:	55                   	push   %ebp
80107101:	89 e5                	mov    %esp,%ebp
80107103:	57                   	push   %edi
80107104:	56                   	push   %esi
80107105:	53                   	push   %ebx
80107106:	83 ec 1c             	sub    $0x1c,%esp
80107109:	8b 75 10             	mov    0x10(%ebp),%esi
8010710c:	8b 45 08             	mov    0x8(%ebp),%eax
8010710f:	8b 7d 0c             	mov    0xc(%ebp),%edi
  if(sz >= PGSIZE)
80107112:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
{
80107118:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
8010711b:	77 49                	ja     80107166 <inituvm+0x66>
  mem = kalloc();
8010711d:	e8 ce b3 ff ff       	call   801024f0 <kalloc>
  memset(mem, 0, PGSIZE);
80107122:	83 ec 04             	sub    $0x4,%esp
  mem = kalloc();
80107125:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80107127:	68 00 10 00 00       	push   $0x1000
8010712c:	6a 00                	push   $0x0
8010712e:	50                   	push   %eax
8010712f:	e8 ec d9 ff ff       	call   80104b20 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80107134:	58                   	pop    %eax
80107135:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
8010713b:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107140:	5a                   	pop    %edx
80107141:	6a 06                	push   $0x6
80107143:	50                   	push   %eax
80107144:	31 d2                	xor    %edx,%edx
80107146:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107149:	e8 c2 fc ff ff       	call   80106e10 <mappages>
  memmove(mem, init, sz);
8010714e:	89 75 10             	mov    %esi,0x10(%ebp)
80107151:	89 7d 0c             	mov    %edi,0xc(%ebp)
80107154:	83 c4 10             	add    $0x10,%esp
80107157:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010715a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010715d:	5b                   	pop    %ebx
8010715e:	5e                   	pop    %esi
8010715f:	5f                   	pop    %edi
80107160:	5d                   	pop    %ebp
  memmove(mem, init, sz);
80107161:	e9 6a da ff ff       	jmp    80104bd0 <memmove>
    panic("inituvm: more than a page");
80107166:	83 ec 0c             	sub    $0xc,%esp
80107169:	68 b9 7f 10 80       	push   $0x80107fb9
8010716e:	e8 1d 92 ff ff       	call   80100390 <panic>
80107173:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107179:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107180 <loaduvm>:
{
80107180:	55                   	push   %ebp
80107181:	89 e5                	mov    %esp,%ebp
80107183:	57                   	push   %edi
80107184:	56                   	push   %esi
80107185:	53                   	push   %ebx
80107186:	83 ec 0c             	sub    $0xc,%esp
  if((uint) addr % PGSIZE != 0)
80107189:	f7 45 0c ff 0f 00 00 	testl  $0xfff,0xc(%ebp)
80107190:	0f 85 91 00 00 00    	jne    80107227 <loaduvm+0xa7>
  for(i = 0; i < sz; i += PGSIZE){
80107196:	8b 75 18             	mov    0x18(%ebp),%esi
80107199:	31 db                	xor    %ebx,%ebx
8010719b:	85 f6                	test   %esi,%esi
8010719d:	75 1a                	jne    801071b9 <loaduvm+0x39>
8010719f:	eb 6f                	jmp    80107210 <loaduvm+0x90>
801071a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801071a8:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801071ae:	81 ee 00 10 00 00    	sub    $0x1000,%esi
801071b4:	39 5d 18             	cmp    %ebx,0x18(%ebp)
801071b7:	76 57                	jbe    80107210 <loaduvm+0x90>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
801071b9:	8b 55 0c             	mov    0xc(%ebp),%edx
801071bc:	8b 45 08             	mov    0x8(%ebp),%eax
801071bf:	31 c9                	xor    %ecx,%ecx
801071c1:	01 da                	add    %ebx,%edx
801071c3:	e8 c8 fb ff ff       	call   80106d90 <walkpgdir>
801071c8:	85 c0                	test   %eax,%eax
801071ca:	74 4e                	je     8010721a <loaduvm+0x9a>
    pa = PTE_ADDR(*pte);
801071cc:	8b 00                	mov    (%eax),%eax
    if(readi(ip, P2V(pa), offset+i, n) != n)
801071ce:	8b 4d 14             	mov    0x14(%ebp),%ecx
    if(sz - i < PGSIZE)
801071d1:	bf 00 10 00 00       	mov    $0x1000,%edi
    pa = PTE_ADDR(*pte);
801071d6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
801071db:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
801071e1:	0f 46 fe             	cmovbe %esi,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
801071e4:	01 d9                	add    %ebx,%ecx
801071e6:	05 00 00 00 80       	add    $0x80000000,%eax
801071eb:	57                   	push   %edi
801071ec:	51                   	push   %ecx
801071ed:	50                   	push   %eax
801071ee:	ff 75 10             	pushl  0x10(%ebp)
801071f1:	e8 9a a7 ff ff       	call   80101990 <readi>
801071f6:	83 c4 10             	add    $0x10,%esp
801071f9:	39 f8                	cmp    %edi,%eax
801071fb:	74 ab                	je     801071a8 <loaduvm+0x28>
}
801071fd:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80107200:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107205:	5b                   	pop    %ebx
80107206:	5e                   	pop    %esi
80107207:	5f                   	pop    %edi
80107208:	5d                   	pop    %ebp
80107209:	c3                   	ret    
8010720a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107210:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80107213:	31 c0                	xor    %eax,%eax
}
80107215:	5b                   	pop    %ebx
80107216:	5e                   	pop    %esi
80107217:	5f                   	pop    %edi
80107218:	5d                   	pop    %ebp
80107219:	c3                   	ret    
      panic("loaduvm: address should exist");
8010721a:	83 ec 0c             	sub    $0xc,%esp
8010721d:	68 d3 7f 10 80       	push   $0x80107fd3
80107222:	e8 69 91 ff ff       	call   80100390 <panic>
    panic("loaduvm: addr must be page aligned");
80107227:	83 ec 0c             	sub    $0xc,%esp
8010722a:	68 74 80 10 80       	push   $0x80108074
8010722f:	e8 5c 91 ff ff       	call   80100390 <panic>
80107234:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010723a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80107240 <allocuvm>:
{
80107240:	55                   	push   %ebp
80107241:	89 e5                	mov    %esp,%ebp
80107243:	57                   	push   %edi
80107244:	56                   	push   %esi
80107245:	53                   	push   %ebx
80107246:	83 ec 1c             	sub    $0x1c,%esp
  if(newsz >= KERNBASE)
80107249:	8b 7d 10             	mov    0x10(%ebp),%edi
8010724c:	85 ff                	test   %edi,%edi
8010724e:	0f 88 8e 00 00 00    	js     801072e2 <allocuvm+0xa2>
  if(newsz < oldsz)
80107254:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80107257:	0f 82 93 00 00 00    	jb     801072f0 <allocuvm+0xb0>
  a = PGROUNDUP(oldsz);
8010725d:	8b 45 0c             	mov    0xc(%ebp),%eax
80107260:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80107266:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a < newsz; a += PGSIZE){
8010726c:	39 5d 10             	cmp    %ebx,0x10(%ebp)
8010726f:	0f 86 7e 00 00 00    	jbe    801072f3 <allocuvm+0xb3>
80107275:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80107278:	8b 7d 08             	mov    0x8(%ebp),%edi
8010727b:	eb 42                	jmp    801072bf <allocuvm+0x7f>
8010727d:	8d 76 00             	lea    0x0(%esi),%esi
    memset(mem, 0, PGSIZE);
80107280:	83 ec 04             	sub    $0x4,%esp
80107283:	68 00 10 00 00       	push   $0x1000
80107288:	6a 00                	push   $0x0
8010728a:	50                   	push   %eax
8010728b:	e8 90 d8 ff ff       	call   80104b20 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80107290:	58                   	pop    %eax
80107291:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80107297:	b9 00 10 00 00       	mov    $0x1000,%ecx
8010729c:	5a                   	pop    %edx
8010729d:	6a 06                	push   $0x6
8010729f:	50                   	push   %eax
801072a0:	89 da                	mov    %ebx,%edx
801072a2:	89 f8                	mov    %edi,%eax
801072a4:	e8 67 fb ff ff       	call   80106e10 <mappages>
801072a9:	83 c4 10             	add    $0x10,%esp
801072ac:	85 c0                	test   %eax,%eax
801072ae:	78 50                	js     80107300 <allocuvm+0xc0>
  for(; a < newsz; a += PGSIZE){
801072b0:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801072b6:	39 5d 10             	cmp    %ebx,0x10(%ebp)
801072b9:	0f 86 81 00 00 00    	jbe    80107340 <allocuvm+0x100>
    mem = kalloc();
801072bf:	e8 2c b2 ff ff       	call   801024f0 <kalloc>
    if(mem == 0){
801072c4:	85 c0                	test   %eax,%eax
    mem = kalloc();
801072c6:	89 c6                	mov    %eax,%esi
    if(mem == 0){
801072c8:	75 b6                	jne    80107280 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
801072ca:	83 ec 0c             	sub    $0xc,%esp
801072cd:	68 f1 7f 10 80       	push   $0x80107ff1
801072d2:	e8 89 93 ff ff       	call   80100660 <cprintf>
  if(newsz >= oldsz)
801072d7:	83 c4 10             	add    $0x10,%esp
801072da:	8b 45 0c             	mov    0xc(%ebp),%eax
801072dd:	39 45 10             	cmp    %eax,0x10(%ebp)
801072e0:	77 6e                	ja     80107350 <allocuvm+0x110>
}
801072e2:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
801072e5:	31 ff                	xor    %edi,%edi
}
801072e7:	89 f8                	mov    %edi,%eax
801072e9:	5b                   	pop    %ebx
801072ea:	5e                   	pop    %esi
801072eb:	5f                   	pop    %edi
801072ec:	5d                   	pop    %ebp
801072ed:	c3                   	ret    
801072ee:	66 90                	xchg   %ax,%ax
    return oldsz;
801072f0:	8b 7d 0c             	mov    0xc(%ebp),%edi
}
801072f3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801072f6:	89 f8                	mov    %edi,%eax
801072f8:	5b                   	pop    %ebx
801072f9:	5e                   	pop    %esi
801072fa:	5f                   	pop    %edi
801072fb:	5d                   	pop    %ebp
801072fc:	c3                   	ret    
801072fd:	8d 76 00             	lea    0x0(%esi),%esi
      cprintf("allocuvm out of memory (2)\n");
80107300:	83 ec 0c             	sub    $0xc,%esp
80107303:	68 09 80 10 80       	push   $0x80108009
80107308:	e8 53 93 ff ff       	call   80100660 <cprintf>
  if(newsz >= oldsz)
8010730d:	83 c4 10             	add    $0x10,%esp
80107310:	8b 45 0c             	mov    0xc(%ebp),%eax
80107313:	39 45 10             	cmp    %eax,0x10(%ebp)
80107316:	76 0d                	jbe    80107325 <allocuvm+0xe5>
80107318:	89 c1                	mov    %eax,%ecx
8010731a:	8b 55 10             	mov    0x10(%ebp),%edx
8010731d:	8b 45 08             	mov    0x8(%ebp),%eax
80107320:	e8 7b fb ff ff       	call   80106ea0 <deallocuvm.part.0>
      kfree(mem);
80107325:	83 ec 0c             	sub    $0xc,%esp
      return 0;
80107328:	31 ff                	xor    %edi,%edi
      kfree(mem);
8010732a:	56                   	push   %esi
8010732b:	e8 10 b0 ff ff       	call   80102340 <kfree>
      return 0;
80107330:	83 c4 10             	add    $0x10,%esp
}
80107333:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107336:	89 f8                	mov    %edi,%eax
80107338:	5b                   	pop    %ebx
80107339:	5e                   	pop    %esi
8010733a:	5f                   	pop    %edi
8010733b:	5d                   	pop    %ebp
8010733c:	c3                   	ret    
8010733d:	8d 76 00             	lea    0x0(%esi),%esi
80107340:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80107343:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107346:	5b                   	pop    %ebx
80107347:	89 f8                	mov    %edi,%eax
80107349:	5e                   	pop    %esi
8010734a:	5f                   	pop    %edi
8010734b:	5d                   	pop    %ebp
8010734c:	c3                   	ret    
8010734d:	8d 76 00             	lea    0x0(%esi),%esi
80107350:	89 c1                	mov    %eax,%ecx
80107352:	8b 55 10             	mov    0x10(%ebp),%edx
80107355:	8b 45 08             	mov    0x8(%ebp),%eax
      return 0;
80107358:	31 ff                	xor    %edi,%edi
8010735a:	e8 41 fb ff ff       	call   80106ea0 <deallocuvm.part.0>
8010735f:	eb 92                	jmp    801072f3 <allocuvm+0xb3>
80107361:	eb 0d                	jmp    80107370 <deallocuvm>
80107363:	90                   	nop
80107364:	90                   	nop
80107365:	90                   	nop
80107366:	90                   	nop
80107367:	90                   	nop
80107368:	90                   	nop
80107369:	90                   	nop
8010736a:	90                   	nop
8010736b:	90                   	nop
8010736c:	90                   	nop
8010736d:	90                   	nop
8010736e:	90                   	nop
8010736f:	90                   	nop

80107370 <deallocuvm>:
{
80107370:	55                   	push   %ebp
80107371:	89 e5                	mov    %esp,%ebp
80107373:	8b 55 0c             	mov    0xc(%ebp),%edx
80107376:	8b 4d 10             	mov    0x10(%ebp),%ecx
80107379:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
8010737c:	39 d1                	cmp    %edx,%ecx
8010737e:	73 10                	jae    80107390 <deallocuvm+0x20>
}
80107380:	5d                   	pop    %ebp
80107381:	e9 1a fb ff ff       	jmp    80106ea0 <deallocuvm.part.0>
80107386:	8d 76 00             	lea    0x0(%esi),%esi
80107389:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80107390:	89 d0                	mov    %edx,%eax
80107392:	5d                   	pop    %ebp
80107393:	c3                   	ret    
80107394:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010739a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801073a0 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
801073a0:	55                   	push   %ebp
801073a1:	89 e5                	mov    %esp,%ebp
801073a3:	57                   	push   %edi
801073a4:	56                   	push   %esi
801073a5:	53                   	push   %ebx
801073a6:	83 ec 0c             	sub    $0xc,%esp
801073a9:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
801073ac:	85 f6                	test   %esi,%esi
801073ae:	74 59                	je     80107409 <freevm+0x69>
801073b0:	31 c9                	xor    %ecx,%ecx
801073b2:	ba 00 00 00 80       	mov    $0x80000000,%edx
801073b7:	89 f0                	mov    %esi,%eax
801073b9:	e8 e2 fa ff ff       	call   80106ea0 <deallocuvm.part.0>
801073be:	89 f3                	mov    %esi,%ebx
801073c0:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
801073c6:	eb 0f                	jmp    801073d7 <freevm+0x37>
801073c8:	90                   	nop
801073c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801073d0:	83 c3 04             	add    $0x4,%ebx
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
801073d3:	39 fb                	cmp    %edi,%ebx
801073d5:	74 23                	je     801073fa <freevm+0x5a>
    if(pgdir[i] & PTE_P){
801073d7:	8b 03                	mov    (%ebx),%eax
801073d9:	a8 01                	test   $0x1,%al
801073db:	74 f3                	je     801073d0 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
801073dd:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      kfree(v);
801073e2:	83 ec 0c             	sub    $0xc,%esp
801073e5:	83 c3 04             	add    $0x4,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
801073e8:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
801073ed:	50                   	push   %eax
801073ee:	e8 4d af ff ff       	call   80102340 <kfree>
801073f3:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
801073f6:	39 fb                	cmp    %edi,%ebx
801073f8:	75 dd                	jne    801073d7 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
801073fa:	89 75 08             	mov    %esi,0x8(%ebp)
}
801073fd:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107400:	5b                   	pop    %ebx
80107401:	5e                   	pop    %esi
80107402:	5f                   	pop    %edi
80107403:	5d                   	pop    %ebp
  kfree((char*)pgdir);
80107404:	e9 37 af ff ff       	jmp    80102340 <kfree>
    panic("freevm: no pgdir");
80107409:	83 ec 0c             	sub    $0xc,%esp
8010740c:	68 25 80 10 80       	push   $0x80108025
80107411:	e8 7a 8f ff ff       	call   80100390 <panic>
80107416:	8d 76 00             	lea    0x0(%esi),%esi
80107419:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107420 <setupkvm>:
{
80107420:	55                   	push   %ebp
80107421:	89 e5                	mov    %esp,%ebp
80107423:	56                   	push   %esi
80107424:	53                   	push   %ebx
  if((pgdir = (pde_t*)kalloc()) == 0)
80107425:	e8 c6 b0 ff ff       	call   801024f0 <kalloc>
8010742a:	85 c0                	test   %eax,%eax
8010742c:	89 c6                	mov    %eax,%esi
8010742e:	74 42                	je     80107472 <setupkvm+0x52>
  memset(pgdir, 0, PGSIZE);
80107430:	83 ec 04             	sub    $0x4,%esp
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107433:	bb 20 b4 10 80       	mov    $0x8010b420,%ebx
  memset(pgdir, 0, PGSIZE);
80107438:	68 00 10 00 00       	push   $0x1000
8010743d:	6a 00                	push   $0x0
8010743f:	50                   	push   %eax
80107440:	e8 db d6 ff ff       	call   80104b20 <memset>
80107445:	83 c4 10             	add    $0x10,%esp
                (uint)k->phys_start, k->perm) < 0) {
80107448:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
8010744b:	8b 4b 08             	mov    0x8(%ebx),%ecx
8010744e:	83 ec 08             	sub    $0x8,%esp
80107451:	8b 13                	mov    (%ebx),%edx
80107453:	ff 73 0c             	pushl  0xc(%ebx)
80107456:	50                   	push   %eax
80107457:	29 c1                	sub    %eax,%ecx
80107459:	89 f0                	mov    %esi,%eax
8010745b:	e8 b0 f9 ff ff       	call   80106e10 <mappages>
80107460:	83 c4 10             	add    $0x10,%esp
80107463:	85 c0                	test   %eax,%eax
80107465:	78 19                	js     80107480 <setupkvm+0x60>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107467:	83 c3 10             	add    $0x10,%ebx
8010746a:	81 fb 60 b4 10 80    	cmp    $0x8010b460,%ebx
80107470:	75 d6                	jne    80107448 <setupkvm+0x28>
}
80107472:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107475:	89 f0                	mov    %esi,%eax
80107477:	5b                   	pop    %ebx
80107478:	5e                   	pop    %esi
80107479:	5d                   	pop    %ebp
8010747a:	c3                   	ret    
8010747b:	90                   	nop
8010747c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      freevm(pgdir);
80107480:	83 ec 0c             	sub    $0xc,%esp
80107483:	56                   	push   %esi
      return 0;
80107484:	31 f6                	xor    %esi,%esi
      freevm(pgdir);
80107486:	e8 15 ff ff ff       	call   801073a0 <freevm>
      return 0;
8010748b:	83 c4 10             	add    $0x10,%esp
}
8010748e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107491:	89 f0                	mov    %esi,%eax
80107493:	5b                   	pop    %ebx
80107494:	5e                   	pop    %esi
80107495:	5d                   	pop    %ebp
80107496:	c3                   	ret    
80107497:	89 f6                	mov    %esi,%esi
80107499:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801074a0 <kvmalloc>:
{
801074a0:	55                   	push   %ebp
801074a1:	89 e5                	mov    %esp,%ebp
801074a3:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
801074a6:	e8 75 ff ff ff       	call   80107420 <setupkvm>
801074ab:	a3 a4 ac 11 80       	mov    %eax,0x8011aca4
  lcr3(V2P(kpgdir));   // switch to the kernel page table
801074b0:	05 00 00 00 80       	add    $0x80000000,%eax
801074b5:	0f 22 d8             	mov    %eax,%cr3
}
801074b8:	c9                   	leave  
801074b9:	c3                   	ret    
801074ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801074c0 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
801074c0:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
801074c1:	31 c9                	xor    %ecx,%ecx
{
801074c3:	89 e5                	mov    %esp,%ebp
801074c5:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
801074c8:	8b 55 0c             	mov    0xc(%ebp),%edx
801074cb:	8b 45 08             	mov    0x8(%ebp),%eax
801074ce:	e8 bd f8 ff ff       	call   80106d90 <walkpgdir>
  if(pte == 0)
801074d3:	85 c0                	test   %eax,%eax
801074d5:	74 05                	je     801074dc <clearpteu+0x1c>
    panic("clearpteu");
  *pte &= ~PTE_U;
801074d7:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
801074da:	c9                   	leave  
801074db:	c3                   	ret    
    panic("clearpteu");
801074dc:	83 ec 0c             	sub    $0xc,%esp
801074df:	68 36 80 10 80       	push   $0x80108036
801074e4:	e8 a7 8e ff ff       	call   80100390 <panic>
801074e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801074f0 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
801074f0:	55                   	push   %ebp
801074f1:	89 e5                	mov    %esp,%ebp
801074f3:	57                   	push   %edi
801074f4:	56                   	push   %esi
801074f5:	53                   	push   %ebx
801074f6:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
801074f9:	e8 22 ff ff ff       	call   80107420 <setupkvm>
801074fe:	85 c0                	test   %eax,%eax
80107500:	89 45 e0             	mov    %eax,-0x20(%ebp)
80107503:	0f 84 9f 00 00 00    	je     801075a8 <copyuvm+0xb8>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80107509:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010750c:	85 c9                	test   %ecx,%ecx
8010750e:	0f 84 94 00 00 00    	je     801075a8 <copyuvm+0xb8>
80107514:	31 ff                	xor    %edi,%edi
80107516:	eb 4a                	jmp    80107562 <copyuvm+0x72>
80107518:	90                   	nop
80107519:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80107520:	83 ec 04             	sub    $0x4,%esp
80107523:	81 c3 00 00 00 80    	add    $0x80000000,%ebx
80107529:	68 00 10 00 00       	push   $0x1000
8010752e:	53                   	push   %ebx
8010752f:	50                   	push   %eax
80107530:	e8 9b d6 ff ff       	call   80104bd0 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
80107535:	58                   	pop    %eax
80107536:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
8010753c:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107541:	5a                   	pop    %edx
80107542:	ff 75 e4             	pushl  -0x1c(%ebp)
80107545:	50                   	push   %eax
80107546:	89 fa                	mov    %edi,%edx
80107548:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010754b:	e8 c0 f8 ff ff       	call   80106e10 <mappages>
80107550:	83 c4 10             	add    $0x10,%esp
80107553:	85 c0                	test   %eax,%eax
80107555:	78 61                	js     801075b8 <copyuvm+0xc8>
  for(i = 0; i < sz; i += PGSIZE){
80107557:	81 c7 00 10 00 00    	add    $0x1000,%edi
8010755d:	39 7d 0c             	cmp    %edi,0xc(%ebp)
80107560:	76 46                	jbe    801075a8 <copyuvm+0xb8>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80107562:	8b 45 08             	mov    0x8(%ebp),%eax
80107565:	31 c9                	xor    %ecx,%ecx
80107567:	89 fa                	mov    %edi,%edx
80107569:	e8 22 f8 ff ff       	call   80106d90 <walkpgdir>
8010756e:	85 c0                	test   %eax,%eax
80107570:	74 61                	je     801075d3 <copyuvm+0xe3>
    if(!(*pte & PTE_P))
80107572:	8b 00                	mov    (%eax),%eax
80107574:	a8 01                	test   $0x1,%al
80107576:	74 4e                	je     801075c6 <copyuvm+0xd6>
    pa = PTE_ADDR(*pte);
80107578:	89 c3                	mov    %eax,%ebx
    flags = PTE_FLAGS(*pte);
8010757a:	25 ff 0f 00 00       	and    $0xfff,%eax
    pa = PTE_ADDR(*pte);
8010757f:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
    flags = PTE_FLAGS(*pte);
80107585:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if((mem = kalloc()) == 0)
80107588:	e8 63 af ff ff       	call   801024f0 <kalloc>
8010758d:	85 c0                	test   %eax,%eax
8010758f:	89 c6                	mov    %eax,%esi
80107591:	75 8d                	jne    80107520 <copyuvm+0x30>
    }
  }
  return d;

bad:
  freevm(d);
80107593:	83 ec 0c             	sub    $0xc,%esp
80107596:	ff 75 e0             	pushl  -0x20(%ebp)
80107599:	e8 02 fe ff ff       	call   801073a0 <freevm>
  return 0;
8010759e:	83 c4 10             	add    $0x10,%esp
801075a1:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
}
801075a8:	8b 45 e0             	mov    -0x20(%ebp),%eax
801075ab:	8d 65 f4             	lea    -0xc(%ebp),%esp
801075ae:	5b                   	pop    %ebx
801075af:	5e                   	pop    %esi
801075b0:	5f                   	pop    %edi
801075b1:	5d                   	pop    %ebp
801075b2:	c3                   	ret    
801075b3:	90                   	nop
801075b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      kfree(mem);
801075b8:	83 ec 0c             	sub    $0xc,%esp
801075bb:	56                   	push   %esi
801075bc:	e8 7f ad ff ff       	call   80102340 <kfree>
      goto bad;
801075c1:	83 c4 10             	add    $0x10,%esp
801075c4:	eb cd                	jmp    80107593 <copyuvm+0xa3>
      panic("copyuvm: page not present");
801075c6:	83 ec 0c             	sub    $0xc,%esp
801075c9:	68 5a 80 10 80       	push   $0x8010805a
801075ce:	e8 bd 8d ff ff       	call   80100390 <panic>
      panic("copyuvm: pte should exist");
801075d3:	83 ec 0c             	sub    $0xc,%esp
801075d6:	68 40 80 10 80       	push   $0x80108040
801075db:	e8 b0 8d ff ff       	call   80100390 <panic>

801075e0 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
801075e0:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
801075e1:	31 c9                	xor    %ecx,%ecx
{
801075e3:	89 e5                	mov    %esp,%ebp
801075e5:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
801075e8:	8b 55 0c             	mov    0xc(%ebp),%edx
801075eb:	8b 45 08             	mov    0x8(%ebp),%eax
801075ee:	e8 9d f7 ff ff       	call   80106d90 <walkpgdir>
  if((*pte & PTE_P) == 0)
801075f3:	8b 00                	mov    (%eax),%eax
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
801075f5:	c9                   	leave  
  if((*pte & PTE_U) == 0)
801075f6:	89 c2                	mov    %eax,%edx
  return (char*)P2V(PTE_ADDR(*pte));
801075f8:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((*pte & PTE_U) == 0)
801075fd:	83 e2 05             	and    $0x5,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80107600:	05 00 00 00 80       	add    $0x80000000,%eax
80107605:	83 fa 05             	cmp    $0x5,%edx
80107608:	ba 00 00 00 00       	mov    $0x0,%edx
8010760d:	0f 45 c2             	cmovne %edx,%eax
}
80107610:	c3                   	ret    
80107611:	eb 0d                	jmp    80107620 <copyout>
80107613:	90                   	nop
80107614:	90                   	nop
80107615:	90                   	nop
80107616:	90                   	nop
80107617:	90                   	nop
80107618:	90                   	nop
80107619:	90                   	nop
8010761a:	90                   	nop
8010761b:	90                   	nop
8010761c:	90                   	nop
8010761d:	90                   	nop
8010761e:	90                   	nop
8010761f:	90                   	nop

80107620 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80107620:	55                   	push   %ebp
80107621:	89 e5                	mov    %esp,%ebp
80107623:	57                   	push   %edi
80107624:	56                   	push   %esi
80107625:	53                   	push   %ebx
80107626:	83 ec 1c             	sub    $0x1c,%esp
80107629:	8b 5d 14             	mov    0x14(%ebp),%ebx
8010762c:	8b 55 0c             	mov    0xc(%ebp),%edx
8010762f:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80107632:	85 db                	test   %ebx,%ebx
80107634:	75 40                	jne    80107676 <copyout+0x56>
80107636:	eb 70                	jmp    801076a8 <copyout+0x88>
80107638:	90                   	nop
80107639:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
80107640:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80107643:	89 f1                	mov    %esi,%ecx
80107645:	29 d1                	sub    %edx,%ecx
80107647:	81 c1 00 10 00 00    	add    $0x1000,%ecx
8010764d:	39 d9                	cmp    %ebx,%ecx
8010764f:	0f 47 cb             	cmova  %ebx,%ecx
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80107652:	29 f2                	sub    %esi,%edx
80107654:	83 ec 04             	sub    $0x4,%esp
80107657:	01 d0                	add    %edx,%eax
80107659:	51                   	push   %ecx
8010765a:	57                   	push   %edi
8010765b:	50                   	push   %eax
8010765c:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
8010765f:	e8 6c d5 ff ff       	call   80104bd0 <memmove>
    len -= n;
    buf += n;
80107664:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
  while(len > 0){
80107667:	83 c4 10             	add    $0x10,%esp
    va = va0 + PGSIZE;
8010766a:	8d 96 00 10 00 00    	lea    0x1000(%esi),%edx
    buf += n;
80107670:	01 cf                	add    %ecx,%edi
  while(len > 0){
80107672:	29 cb                	sub    %ecx,%ebx
80107674:	74 32                	je     801076a8 <copyout+0x88>
    va0 = (uint)PGROUNDDOWN(va);
80107676:	89 d6                	mov    %edx,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80107678:	83 ec 08             	sub    $0x8,%esp
    va0 = (uint)PGROUNDDOWN(va);
8010767b:	89 55 e4             	mov    %edx,-0x1c(%ebp)
8010767e:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80107684:	56                   	push   %esi
80107685:	ff 75 08             	pushl  0x8(%ebp)
80107688:	e8 53 ff ff ff       	call   801075e0 <uva2ka>
    if(pa0 == 0)
8010768d:	83 c4 10             	add    $0x10,%esp
80107690:	85 c0                	test   %eax,%eax
80107692:	75 ac                	jne    80107640 <copyout+0x20>
  }
  return 0;
}
80107694:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80107697:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010769c:	5b                   	pop    %ebx
8010769d:	5e                   	pop    %esi
8010769e:	5f                   	pop    %edi
8010769f:	5d                   	pop    %ebp
801076a0:	c3                   	ret    
801076a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801076a8:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801076ab:	31 c0                	xor    %eax,%eax
}
801076ad:	5b                   	pop    %ebx
801076ae:	5e                   	pop    %esi
801076af:	5f                   	pop    %edi
801076b0:	5d                   	pop    %ebp
801076b1:	c3                   	ret    
