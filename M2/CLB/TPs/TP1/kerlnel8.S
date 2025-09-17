
build/kernel8.elf:     file format elf64-littleaarch64


Disassembly of section .text.boot:

0000000000080000 <_start>:
   80000:	18000281 	ldr	w1, 80050 <master+0x1c>
   80004:	11008021 	add	w1, w1, #0x20
   80008:	d2801c00 	mov	x0, #0xe0                  	// #224
   8000c:	b9000001 	str	w1, [x0]
   80010:	d2801d00 	mov	x0, #0xe8                  	// #232
   80014:	b9000001 	str	w1, [x0]
   80018:	d2801e00 	mov	x0, #0xf0                  	// #240
   8001c:	b9000001 	str	w1, [x0]
   80020:	d53800a0 	mrs	x0, mpidr_el1
   80024:	92401c00 	and	x0, x0, #0xff
   80028:	b4000060 	cbz	x0, 80034 <master>
   8002c:	14000001 	b	80030 <proc_hang>

0000000000080030 <proc_hang>:
   80030:	14000000 	b	80030 <proc_hang>

0000000000080034 <master>:
   80034:	100019a0 	adr	x0, 80368 <bss_begin>
   80038:	10001981 	adr	x1, 80368 <bss_begin>
   8003c:	cb000021 	sub	x1, x1, x0
   80040:	9400008e 	bl	80278 <memzero>
   80044:	b26a03ff 	mov	sp, #0x400000              	// #4194304
   80048:	94000003 	bl	80054 <kernel_main>
   8004c:	17fffff9 	b	80030 <proc_hang>
   80050:	00080000 	.inst	0x00080000 ; undefined

Disassembly of section .text:

0000000000080054 <kernel_main>:
   80054:	a9bf7bfd 	stp	x29, x30, [sp, #-16]!
   80058:	910003fd 	mov	x29, sp
   8005c:	94000042 	bl	80164 <uart_init>
   80060:	90000000 	adrp	x0, 80000 <_start>
   80064:	910aa000 	add	x0, x0, #0x2a8
   80068:	94000028 	bl	80108 <uart_send_string>
   8006c:	94000017 	bl	800c8 <uart_recv>
   80070:	12001c00 	and	w0, w0, #0xff
   80074:	94000002 	bl	8007c <uart_send>
   80078:	17fffffd 	b	8006c <kernel_main+0x18>

000000000008007c <uart_send>:
   8007c:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
   80080:	910003fd 	mov	x29, sp
   80084:	39007fe0 	strb	w0, [sp, #31]
   80088:	d28a0a80 	mov	x0, #0x5054                	// #20564
   8008c:	f2a7e420 	movk	x0, #0x3f21, lsl #16
   80090:	94000080 	bl	80290 <get32>
   80094:	121b0000 	and	w0, w0, #0x20
   80098:	7100001f 	cmp	w0, #0x0
   8009c:	54000041 	b.ne	800a4 <uart_send+0x28>  // b.any
   800a0:	17fffffa 	b	80088 <uart_send+0xc>
   800a4:	d503201f 	nop
   800a8:	39407fe0 	ldrb	w0, [sp, #31]
   800ac:	2a0003e1 	mov	w1, w0
   800b0:	d28a0800 	mov	x0, #0x5040                	// #20544
   800b4:	f2a7e420 	movk	x0, #0x3f21, lsl #16
   800b8:	94000074 	bl	80288 <put32>
   800bc:	d503201f 	nop
   800c0:	a8c27bfd 	ldp	x29, x30, [sp], #32
   800c4:	d65f03c0 	ret

00000000000800c8 <uart_recv>:
   800c8:	a9bf7bfd 	stp	x29, x30, [sp, #-16]!
   800cc:	910003fd 	mov	x29, sp
   800d0:	d28a0a80 	mov	x0, #0x5054                	// #20564
   800d4:	f2a7e420 	movk	x0, #0x3f21, lsl #16
   800d8:	9400006e 	bl	80290 <get32>
   800dc:	12000000 	and	w0, w0, #0x1
   800e0:	7100001f 	cmp	w0, #0x0
   800e4:	54000041 	b.ne	800ec <uart_recv+0x24>  // b.any
   800e8:	17fffffa 	b	800d0 <uart_recv+0x8>
   800ec:	d503201f 	nop
   800f0:	d28a0800 	mov	x0, #0x5040                	// #20544
   800f4:	f2a7e420 	movk	x0, #0x3f21, lsl #16
   800f8:	94000066 	bl	80290 <get32>
   800fc:	12001c00 	and	w0, w0, #0xff
   80100:	a8c17bfd 	ldp	x29, x30, [sp], #16
   80104:	d65f03c0 	ret

0000000000080108 <uart_send_string>:
   80108:	a9bd7bfd 	stp	x29, x30, [sp, #-48]!
   8010c:	910003fd 	mov	x29, sp
   80110:	f9000fe0 	str	x0, [sp, #24]
   80114:	b9002fff 	str	wzr, [sp, #44]
   80118:	14000009 	b	8013c <uart_send_string+0x34>
   8011c:	b9802fe0 	ldrsw	x0, [sp, #44]
   80120:	f9400fe1 	ldr	x1, [sp, #24]
   80124:	8b000020 	add	x0, x1, x0
   80128:	39400000 	ldrb	w0, [x0]
   8012c:	97ffffd4 	bl	8007c <uart_send>
   80130:	b9402fe0 	ldr	w0, [sp, #44]
   80134:	11000400 	add	w0, w0, #0x1
   80138:	b9002fe0 	str	w0, [sp, #44]
   8013c:	b9802fe0 	ldrsw	x0, [sp, #44]
   80140:	f9400fe1 	ldr	x1, [sp, #24]
   80144:	8b000020 	add	x0, x1, x0
   80148:	39400000 	ldrb	w0, [x0]
   8014c:	7100001f 	cmp	w0, #0x0
   80150:	54fffe61 	b.ne	8011c <uart_send_string+0x14>  // b.any
   80154:	d503201f 	nop
   80158:	d503201f 	nop
   8015c:	a8c37bfd 	ldp	x29, x30, [sp], #48
   80160:	d65f03c0 	ret

0000000000080164 <uart_init>:
   80164:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
   80168:	910003fd 	mov	x29, sp
   8016c:	d2800080 	mov	x0, #0x4                   	// #4
   80170:	f2a7e400 	movk	x0, #0x3f20, lsl #16
   80174:	94000047 	bl	80290 <get32>
   80178:	b9001fe0 	str	w0, [sp, #28]
   8017c:	b9401fe0 	ldr	w0, [sp, #28]
   80180:	12117000 	and	w0, w0, #0xffff8fff
   80184:	b9001fe0 	str	w0, [sp, #28]
   80188:	b9401fe0 	ldr	w0, [sp, #28]
   8018c:	32130000 	orr	w0, w0, #0x2000
   80190:	b9001fe0 	str	w0, [sp, #28]
   80194:	b9401fe0 	ldr	w0, [sp, #28]
   80198:	120e7000 	and	w0, w0, #0xfffc7fff
   8019c:	b9001fe0 	str	w0, [sp, #28]
   801a0:	b9401fe0 	ldr	w0, [sp, #28]
   801a4:	32100000 	orr	w0, w0, #0x10000
   801a8:	b9001fe0 	str	w0, [sp, #28]
   801ac:	b9401fe1 	ldr	w1, [sp, #28]
   801b0:	d2800080 	mov	x0, #0x4                   	// #4
   801b4:	f2a7e400 	movk	x0, #0x3f20, lsl #16
   801b8:	94000034 	bl	80288 <put32>
   801bc:	52800001 	mov	w1, #0x0                   	// #0
   801c0:	d2801280 	mov	x0, #0x94                  	// #148
   801c4:	f2a7e400 	movk	x0, #0x3f20, lsl #16
   801c8:	94000030 	bl	80288 <put32>
   801cc:	d28012c0 	mov	x0, #0x96                  	// #150
   801d0:	94000032 	bl	80298 <delay>
   801d4:	52980001 	mov	w1, #0xc000                	// #49152
   801d8:	d2801300 	mov	x0, #0x98                  	// #152
   801dc:	f2a7e400 	movk	x0, #0x3f20, lsl #16
   801e0:	9400002a 	bl	80288 <put32>
   801e4:	d28012c0 	mov	x0, #0x96                  	// #150
   801e8:	9400002c 	bl	80298 <delay>
   801ec:	52800001 	mov	w1, #0x0                   	// #0
   801f0:	d2801300 	mov	x0, #0x98                  	// #152
   801f4:	f2a7e400 	movk	x0, #0x3f20, lsl #16
   801f8:	94000024 	bl	80288 <put32>
   801fc:	52800021 	mov	w1, #0x1                   	// #1
   80200:	d28a0080 	mov	x0, #0x5004                	// #20484
   80204:	f2a7e420 	movk	x0, #0x3f21, lsl #16
   80208:	94000020 	bl	80288 <put32>
   8020c:	52800001 	mov	w1, #0x0                   	// #0
   80210:	d28a0c00 	mov	x0, #0x5060                	// #20576
   80214:	f2a7e420 	movk	x0, #0x3f21, lsl #16
   80218:	9400001c 	bl	80288 <put32>
   8021c:	52800001 	mov	w1, #0x0                   	// #0
   80220:	d28a0880 	mov	x0, #0x5044                	// #20548
   80224:	f2a7e420 	movk	x0, #0x3f21, lsl #16
   80228:	94000018 	bl	80288 <put32>
   8022c:	52800061 	mov	w1, #0x3                   	// #3
   80230:	d28a0980 	mov	x0, #0x504c                	// #20556
   80234:	f2a7e420 	movk	x0, #0x3f21, lsl #16
   80238:	94000014 	bl	80288 <put32>
   8023c:	52800001 	mov	w1, #0x0                   	// #0
   80240:	d28a0a00 	mov	x0, #0x5050                	// #20560
   80244:	f2a7e420 	movk	x0, #0x3f21, lsl #16
   80248:	94000010 	bl	80288 <put32>
   8024c:	528021c1 	mov	w1, #0x10e                 	// #270
   80250:	d28a0d00 	mov	x0, #0x5068                	// #20584
   80254:	f2a7e420 	movk	x0, #0x3f21, lsl #16
   80258:	9400000c 	bl	80288 <put32>
   8025c:	52800061 	mov	w1, #0x3                   	// #3
   80260:	d28a0c00 	mov	x0, #0x5060                	// #20576
   80264:	f2a7e420 	movk	x0, #0x3f21, lsl #16
   80268:	94000008 	bl	80288 <put32>
   8026c:	d503201f 	nop
   80270:	a8c27bfd 	ldp	x29, x30, [sp], #32
   80274:	d65f03c0 	ret

0000000000080278 <memzero>:
   80278:	f800841f 	str	xzr, [x0], #8
   8027c:	f1002021 	subs	x1, x1, #0x8
   80280:	54ffffcc 	b.gt	80278 <memzero>
   80284:	d65f03c0 	ret

0000000000080288 <put32>:
   80288:	b9000001 	str	w1, [x0]
   8028c:	d65f03c0 	ret

0000000000080290 <get32>:
   80290:	b9400000 	ldr	w0, [x0]
   80294:	d65f03c0 	ret

0000000000080298 <delay>:
   80298:	f1000400 	subs	x0, x0, #0x1
   8029c:	54ffffe1 	b.ne	80298 <delay>  // b.any
   802a0:	d65f03c0 	ret

Disassembly of section .rodata:

00000000000802a8 <.rodata>:
   802a8:	6c6c6548 	ldnp	d8, d25, [x10, #-320]
   802ac:	77202c6f 	.inst	0x77202c6f ; undefined
   802b0:	646c726f 	.inst	0x646c726f ; undefined
   802b4:	000a0d21 	.inst	0x000a0d21 ; undefined

Disassembly of section .eh_frame:

00000000000802b8 <bss_begin-0xb0>:
   802b8:	00000010 	udf	#16
   802bc:	00000000 	udf	#0
   802c0:	00527a01 	.inst	0x00527a01 ; undefined
   802c4:	011e7804 	.inst	0x011e7804 ; undefined
   802c8:	001f0c1b 	.inst	0x001f0c1b ; undefined
   802cc:	00000018 	udf	#24
   802d0:	00000018 	udf	#24
   802d4:	fffffd80 	.inst	0xfffffd80 ; undefined
   802d8:	00000028 	udf	#40
   802dc:	100e4100 	adr	x0, 9cafc <bss_begin+0x1c794>
   802e0:	019e029d 	.inst	0x019e029d ; undefined
   802e4:	00000000 	udf	#0
   802e8:	0000001c 	udf	#28
   802ec:	00000034 	udf	#52
   802f0:	fffffd8c 	.inst	0xfffffd8c ; undefined
   802f4:	0000004c 	udf	#76
   802f8:	200e4100 	.inst	0x200e4100 ; undefined
   802fc:	039e049d 	.inst	0x039e049d ; undefined
   80300:	0eddde51 	.inst	0x0eddde51 ; undefined
   80304:	00000000 	udf	#0
   80308:	0000001c 	udf	#28
   8030c:	00000054 	udf	#84
   80310:	fffffdb8 	.inst	0xfffffdb8 ; undefined
   80314:	00000040 	udf	#64
   80318:	100e4100 	adr	x0, 9cb38 <bss_begin+0x1c7d0>
   8031c:	019e029d 	.inst	0x019e029d ; undefined
   80320:	0eddde4e 	.inst	0x0eddde4e ; undefined
   80324:	00000000 	udf	#0
   80328:	0000001c 	udf	#28
   8032c:	00000074 	udf	#116
   80330:	fffffdd8 	.inst	0xfffffdd8 ; undefined
   80334:	0000005c 	udf	#92
   80338:	300e4100 	adr	x0, 9cb59 <bss_begin+0x1c7f1>
   8033c:	059e069d 	mov	z29.s, p14/z, #52
   80340:	0eddde55 	.inst	0x0eddde55 ; undefined
   80344:	00000000 	udf	#0
   80348:	0000001c 	udf	#28
   8034c:	00000094 	udf	#148
   80350:	fffffe14 	.inst	0xfffffe14 ; undefined
   80354:	00000114 	udf	#276
   80358:	200e4100 	.inst	0x200e4100 ; undefined
   8035c:	039e049d 	.inst	0x039e049d ; undefined
   80360:	ddde4302 	.inst	0xddde4302 ; undefined
   80364:	0000000e 	udf	#14

Disassembly of section .debug_info:

0000000000000000 <.debug_info>:
   0:	0000008b 	udf	#139
   4:	08010005 	stxrb	w1, w5, [x0]
   8:	00000000 	udf	#0
   c:	00002003 	udf	#8195
  10:	47031d00 	.inst	0x47031d00 ; undefined
  14:	1f000316 	fmadd	s22, s24, s0, s0
  18:	00000000 	udf	#0
  1c:	54000000 	b.eq	1c <_start-0x7ffe4>  // b.none
  20:	00000800 	udf	#2048
  24:	28000000 	stnp	w0, w0, [x0]
	...
  30:	01000000 	.inst	0x01000000 ; undefined
  34:	0000000c 	udf	#12
  38:	00004306 	udf	#17158
  3c:	00430200 	.inst	0x00430200 ; undefined
  40:	04000000 	add	z0.b, p0/m, z0.b, z0.b
  44:	00a40801 	.inst	0x00a40801 ; undefined
  48:	16050000 	b	fffffffff8140048 <bss_begin+0xfffffffff80bfce0>
  4c:	02000000 	.inst	0x02000000 ; undefined
  50:	00430605 	.inst	0x00430605 ; undefined
  54:	93010000 	.inst	0x93010000 ; undefined
  58:	07000000 	.inst	0x07000000 ; undefined
  5c:	00000066 	udf	#102
  60:	00006602 	udf	#26114
  64:	08060000 	stxrb	w6, w0, [x0]
  68:	00000043 	udf	#67
  6c:	00008907 	udf	#35079
  70:	06040200 	.inst	0x06040200 ; undefined
  74:	00000008 	udf	#8
  78:	06030100 	.inst	0x06030100 ; undefined
  7c:	00080054 	.inst	0x00080054 ; undefined
  80:	00000000 	udf	#0
  84:	00000028 	udf	#40
  88:	00000000 	udf	#0
  8c:	48009c01 	stlxrh	w0, w1, [x0]
  90:	05000001 	orr	z1.s, z1.s, #0x1
  94:	8d080100 	.inst	0x8d080100 ; undefined
  98:	06000000 	.inst	0x06000000 ; undefined
  9c:	00000020 	udf	#32
  a0:	1647031d 	b	fffffffff91c0d14 <bss_begin+0xfffffffff91409ac>
  a4:	00440003 	.inst	0x00440003 ; undefined
  a8:	00000000 	udf	#0
  ac:	007c0000 	.inst	0x007c0000 ; undefined
  b0:	00000008 	udf	#8
  b4:	01fc0000 	.inst	0x01fc0000 ; undefined
  b8:	00000000 	udf	#0
  bc:	00610000 	.inst	0x00610000 ; undefined
  c0:	bb030000 	.inst	0xbb030000 ; undefined
  c4:	04000000 	add	z0.b, p0/m, z0.b, z0.b
  c8:	00000043 	udf	#67
  cc:	00004301 	udf	#17153
  d0:	08020000 	stxrb	w2, w0, [x0]
  d4:	0000a907 	udf	#43271
  d8:	00ca0300 	.inst	0x00ca0300 ; undefined
  dc:	5f050000 	.inst	0x5f050000 ; undefined
  e0:	01000000 	.inst	0x01000000 ; undefined
  e4:	00000043 	udf	#67
  e8:	00005f01 	udf	#24321
  ec:	04020000 	.inst	0x04020000 ; undefined
  f0:	0000ae07 	udf	#44551
  f4:	00d00700 	.inst	0x00d00700 ; undefined
  f8:	06020000 	.inst	0x06020000 ; undefined
  fc:	00005f15 	udf	#24341
 100:	00007c00 	udf	#31744
 104:	00430100 	.inst	0x00430100 ; undefined
 108:	04000000 	add	z0.b, p0/m, z0.b, z0.b
 10c:	00000089 	udf	#137
 110:	0801641e 	stxrb	w1, w30, [x0]
 114:	00000000 	udf	#0
 118:	00011400 	.inst	0x00011400 ; undefined
 11c:	00000000 	udf	#0
 120:	a89c0100 	stp	x0, x0, [x8], #448
 124:	08000000 	stxrb	w0, w0, [x0]
 128:	000000c1 	udf	#193
 12c:	5f0f2001 	.inst	0x5f0f2001 ; undefined
 130:	02000000 	.inst	0x02000000 ; undefined
 134:	04007c91 	mls	z17.b, p7/m, z4.b, z0.b
 138:	00000093 	udf	#147
 13c:	08010817 	stxrb	w1, w23, [x0]
 140:	00000000 	udf	#0
 144:	00005c00 	udf	#23552
 148:	00000000 	udf	#0
 14c:	f29c0100 	movk	x0, #0xe008
 150:	05000000 	orr	z0.s, z0.s, #0x1
 154:	00727473 	.inst	0x00727473 ; undefined
 158:	00f21d17 	.inst	0x00f21d17 ; undefined
 15c:	91020000 	add	x0, x0, #0x80
 160:	01140968 	.inst	0x01140968 ; undefined
 164:	00000008 	udf	#8
 168:	00400000 	.inst	0x00400000 ; undefined
 16c:	00000000 	udf	#0
 170:	690a0000 	stgp	x0, x0, [x0, #320]
 174:	0b190100 	add	w0, w8, w25
 178:	000000ff 	udf	#255
 17c:	007c9102 	.inst	0x007c9102 ; undefined
 180:	f8080b00 	sttr	x0, [x24, #128]
 184:	02000000 	.inst	0x02000000 ; undefined
 188:	00a40801 	.inst	0x00a40801 ; undefined
 18c:	040c0000 	sabd	z0.b, p0/m, z0.b, z0.b
 190:	746e6905 	.inst	0x746e6905 ; undefined
 194:	00160d00 	.inst	0x00160d00 ; undefined
 198:	0e010000 	tbl	v0.8b, {v0.16b}, v1.8b
 19c:	0000f806 	udf	#63494
 1a0:	0800c800 	stlxrb	w0, w0, [x0]
 1a4:	00000000 	udf	#0
 1a8:	00004000 	udf	#16384
 1ac:	00000000 	udf	#0
 1b0:	0e9c0100 	.inst	0x0e9c0100 ; undefined
 1b4:	0000000c 	udf	#12
 1b8:	7c060501 	str	h1, [x8], #96
 1bc:	00000800 	udf	#2048
 1c0:	4c000000 	st4	{v0.16b-v3.16b}, [x0]
 1c4:	00000000 	udf	#0
 1c8:	01000000 	.inst	0x01000000 ; undefined
 1cc:	0063059c 	.inst	0x0063059c ; undefined
 1d0:	00f81705 	.inst	0x00f81705 ; undefined
 1d4:	91020000 	add	x0, x0, #0x80
 1d8:	2400007f 	cmphi	p15.b, p0/z, z3.b, z0.b
 1dc:	05000000 	orr	z0.s, z0.s, #0x1
 1e0:	89080100 	.inst	0x89080100 ; undefined
 1e4:	01000001 	.inst	0x01000001 ; undefined
 1e8:	0000013a 	udf	#314
 1ec:	00080000 	.inst	0x00080000 ; undefined
 1f0:	00000000 	udf	#0
 1f4:	0000d654 	udf	#54868
 1f8:	0000e100 	udf	#57600
 1fc:	00010000 	.inst	0x00010000 ; undefined
 200:	24800100 	cmphs	p0.s, p0/z, z8.s, z0.s
 204:	05000000 	orr	z0.s, z0.s, #0x1
 208:	9d080100 	.inst	0x9d080100 ; undefined
 20c:	01000001 	.inst	0x01000001 ; undefined
 210:	00000198 	udf	#408
 214:	00080278 	.inst	0x00080278 ; undefined
 218:	00000000 	udf	#0
 21c:	00010c10 	.inst	0x00010c10 ; undefined
 220:	0000e100 	udf	#57600
 224:	00010000 	.inst	0x00010000 ; undefined
 228:	24800100 	cmphs	p0.s, p0/z, z8.s, z0.s
 22c:	05000000 	orr	z0.s, z0.s, #0x1
 230:	b1080100 	adds	x0, x8, #0x200
 234:	01000001 	.inst	0x01000001 ; undefined
 238:	000001e6 	udf	#486
 23c:	00080288 	.inst	0x00080288 ; undefined
 240:	00000000 	udf	#0
 244:	0001151c 	.inst	0x0001151c ; undefined
 248:	0000e100 	udf	#57600
 24c:	00010000 	.inst	0x00010000 ; undefined
 250:	Address 0x250 is out of bounds.


Disassembly of section .debug_abbrev:

0000000000000000 <.debug_abbrev>:
   0:	3f012e01 	.inst	0x3f012e01 ; undefined
   4:	3a0e0319 	adcs	w25, w24, w14
   8:	0b3b0221 	add	w1, w17, w27, uxtb
   c:	27062139 	.inst	0x27062139 ; undefined
  10:	01193c19 	.inst	0x01193c19 ; undefined
  14:	02000013 	.inst	0x02000013 ; undefined
  18:	13490005 	.inst	0x13490005 ; undefined
  1c:	11030000 	add	w0, w0, #0xc0
  20:	130e2501 	sbfiz	w1, w8, #18, #10
  24:	0b01900b 	.inst	0x0b01900b ; undefined
  28:	03060191 	.inst	0x03060191 ; undefined
  2c:	111f1b1f 	add	wsp, w24, #0x7c6
  30:	10071201 	adr	x1, e270 <_start-0x71d90>
  34:	04000017 	add	z23.b, p0/m, z23.b, z0.b
  38:	0b0b0024 	add	w4, w1, w11
  3c:	0e030b3e 	.inst	0x0e030b3e ; undefined
  40:	2e050000 	ext	v0.8b, v0.8b, v5.8b, #0
  44:	03193f00 	.inst	0x03193f00 ; undefined
  48:	3b0b3a0e 	.inst	0x3b0b3a0e ; undefined
  4c:	270b390b 	.inst	0x270b390b ; undefined
  50:	3c134919 	.inst	0x3c134919 ; undefined
  54:	06000019 	.inst	0x06000019 ; undefined
  58:	0b0b000f 	add	w15, w0, w11
  5c:	00001349 	udf	#4937
  60:	3f002e07 	.inst	0x3f002e07 ; undefined
  64:	3a0e0319 	adcs	w25, w24, w14
  68:	390b3b0b 	strb	w11, [x24, #718]
  6c:	3c19270b 	str	b11, [x24], #-110
  70:	08000019 	stxrb	w0, w25, [x0]
  74:	193f002e 	.inst	0x193f002e ; undefined
  78:	0b3a0e03 	add	w3, w16, w26, uxtb #3
  7c:	0b390b3b 	add	w27, w25, w25, uxtb #2
  80:	01111927 	.inst	0x01111927 ; undefined
  84:	18400712 	ldr	w18, 80164 <uart_init>
  88:	0000197c 	udf	#6524
  8c:	00050100 	.inst	0x00050100 ; undefined
  90:	00001349 	udf	#4937
  94:	0b002402 	add	w2, w0, w0, lsl #9
  98:	030b3e0b 	.inst	0x030b3e0b ; undefined
  9c:	0300000e 	.inst	0x0300000e ; undefined
  a0:	193f012e 	.inst	0x193f012e ; undefined
  a4:	213a0e03 	.inst	0x213a0e03 ; undefined
  a8:	390b3b02 	strb	w2, [x24, #718]
  ac:	19270d21 	.inst	0x19270d21 ; undefined
  b0:	1301193c 	sbfx	w28, w9, #1, #6
  b4:	2e040000 	ext	v0.8b, v0.8b, v4.8b, #0
  b8:	03193f01 	.inst	0x03193f01 ; undefined
  bc:	01213a0e 	.inst	0x01213a0e ; undefined
  c0:	21390b3b 	.inst	0x21390b3b ; undefined
  c4:	11192706 	add	w6, w24, #0x649
  c8:	40071201 	.inst	0x40071201 ; undefined
  cc:	01197c18 	.inst	0x01197c18 ; undefined
  d0:	05000013 	orr	z19.s, z19.s, #0x1
  d4:	08030005 	stxrb	w3, w5, [x0]
  d8:	3b01213a 	.inst	0x3b01213a ; undefined
  dc:	490b390b 	.inst	0x490b390b ; undefined
  e0:	00180213 	.inst	0x00180213 ; undefined
  e4:	01110600 	.inst	0x01110600 ; undefined
  e8:	0b130e25 	add	w5, w17, w19, lsl #3
  ec:	910b0190 	add	x16, x12, #0x2c0
  f0:	1f030601 	fmadd	s1, s16, s3, s1
  f4:	01111f1b 	.inst	0x01111f1b ; undefined
  f8:	17100712 	b	fffffffffc401d40 <bss_begin+0xfffffffffc3819d8>
  fc:	2e070000 	ext	v0.8b, v0.8b, v7.8b, #0
 100:	03193f01 	.inst	0x03193f01 ; undefined
 104:	3b0b3a0e 	.inst	0x3b0b3a0e ; undefined
 108:	270b390b 	.inst	0x270b390b ; undefined
 10c:	3c134919 	.inst	0x3c134919 ; undefined
 110:	00130119 	.inst	0x00130119 ; undefined
 114:	00340800 	.inst	0x00340800 ; NYI
 118:	0b3a0e03 	add	w3, w16, w26, uxtb #3
 11c:	0b390b3b 	add	w27, w25, w25, uxtb #2
 120:	18021349 	ldr	w9, 4388 <_start-0x7bc78>
 124:	0b090000 	add	w0, w0, w9
 128:	12011101 	and	w1, w8, #0x8000000f
 12c:	0a000007 	and	w7, w0, w0
 130:	08030034 	stxrb	w3, w20, [x1]
 134:	0b3b0b3a 	add	w26, w25, w27, uxtb #2
 138:	13490b39 	.inst	0x13490b39 ; undefined
 13c:	00001802 	udf	#6146
 140:	0b000f0b 	add	w11, w24, w0, lsl #3
 144:	0013490b 	.inst	0x0013490b ; undefined
 148:	00240c00 	.inst	0x00240c00 ; NYI
 14c:	0b3e0b0b 	add	w11, w24, w30, uxtb #2
 150:	00000803 	udf	#2051
 154:	3f002e0d 	.inst	0x3f002e0d ; undefined
 158:	3a0e0319 	adcs	w25, w24, w14
 15c:	390b3b0b 	strb	w11, [x24, #718]
 160:	4919270b 	.inst	0x4919270b ; undefined
 164:	12011113 	and	w19, w8, #0x8000000f
 168:	7c184007 	stur	h7, [x0, #-124]
 16c:	0e000019 	tbl	v25.8b, {v0.16b}, v0.8b
 170:	193f012e 	.inst	0x193f012e ; undefined
 174:	0b3a0e03 	add	w3, w16, w26, uxtb #3
 178:	0b390b3b 	add	w27, w25, w25, uxtb #2
 17c:	01111927 	.inst	0x01111927 ; undefined
 180:	18400712 	ldr	w18, 80260 <uart_init+0xfc>
 184:	0000197c 	udf	#6524
 188:	00110100 	.inst	0x00110100 ; undefined
 18c:	01111710 	.inst	0x01111710 ; undefined
 190:	0e030f12 	dup	v18.8b, w24
 194:	0e250e1b 	sqadd	v27.8b, v16.8b, v5.8b
 198:	00000513 	udf	#1299
 19c:	00110100 	.inst	0x00110100 ; undefined
 1a0:	01111710 	.inst	0x01111710 ; undefined
 1a4:	0e030f12 	dup	v18.8b, w24
 1a8:	0e250e1b 	sqadd	v27.8b, v16.8b, v5.8b
 1ac:	00000513 	udf	#1299
 1b0:	00110100 	.inst	0x00110100 ; undefined
 1b4:	01111710 	.inst	0x01111710 ; undefined
 1b8:	0e030f12 	dup	v18.8b, w24
 1bc:	0e250e1b 	sqadd	v27.8b, v16.8b, v5.8b
 1c0:	00000513 	udf	#1299
	...

Disassembly of section .debug_aranges:

0000000000000000 <.debug_aranges>:
   0:	0000002c 	udf	#44
   4:	00000002 	udf	#2
   8:	00080000 	.inst	0x00080000 ; undefined
   c:	00000000 	udf	#0
  10:	00080054 	.inst	0x00080054 ; undefined
  14:	00000000 	udf	#0
  18:	00000028 	udf	#40
	...
  30:	0000002c 	udf	#44
  34:	008f0002 	.inst	0x008f0002 ; undefined
  38:	00080000 	.inst	0x00080000 ; undefined
  3c:	00000000 	udf	#0
  40:	0008007c 	.inst	0x0008007c ; undefined
  44:	00000000 	udf	#0
  48:	000001fc 	udf	#508
	...
  60:	0000002c 	udf	#44
  64:	01db0002 	.inst	0x01db0002 ; undefined
  68:	00080000 	.inst	0x00080000 ; undefined
  6c:	00000000 	udf	#0
  70:	00080000 	.inst	0x00080000 ; undefined
  74:	00000000 	udf	#0
  78:	00000054 	udf	#84
	...
  90:	0000002c 	udf	#44
  94:	02030002 	.inst	0x02030002 ; undefined
  98:	00080000 	.inst	0x00080000 ; undefined
  9c:	00000000 	udf	#0
  a0:	00080278 	.inst	0x00080278 ; undefined
  a4:	00000000 	udf	#0
  a8:	00000010 	udf	#16
	...
  c0:	0000002c 	udf	#44
  c4:	022b0002 	.inst	0x022b0002 ; undefined
  c8:	00080000 	.inst	0x00080000 ; undefined
  cc:	00000000 	udf	#0
  d0:	00080288 	.inst	0x00080288 ; undefined
  d4:	00000000 	udf	#0
  d8:	0000001c 	udf	#28
	...

Disassembly of section .debug_line:

0000000000000000 <.debug_line>:
   0:	0000005d 	udf	#93
   4:	00080005 	.inst	0x00080005 ; undefined
   8:	00000037 	udf	#55
   c:	fb010104 	.inst	0xfb010104 ; undefined
  10:	01000d0e 	.inst	0x01000d0e ; undefined
  14:	00010101 	.inst	0x00010101 ; undefined
  18:	00010000 	.inst	0x00010000 ; undefined
  1c:	01010100 	.inst	0x01010100 ; undefined
  20:	0000031f 	udf	#799
  24:	002c0000 	.inst	0x002c0000 ; NYI
  28:	00300000 	.inst	0x00300000 ; NYI
  2c:	01020000 	.inst	0x01020000 ; undefined
  30:	030f021f 	.inst	0x030f021f ; undefined
  34:	00000023 	udf	#35
  38:	00002301 	udf	#8961
  3c:	00380100 	.inst	0x00380100 ; NYI
  40:	05020000 	orr	z0.d, z0.d, #0x1
  44:	02090001 	.inst	0x02090001 ; undefined
  48:	00080054 	.inst	0x00080054 ; undefined
  4c:	00000000 	udf	#0
  50:	2f020515 	mvni	v21.2s, #0x48
  54:	00030521 	.inst	0x00030521 ; undefined
  58:	3f030402 	.inst	0x3f030402 ; undefined
  5c:	01000402 	.inst	0x01000402 ; undefined
  60:	0000d501 	udf	#54529
  64:	08000500 	stxrb	w0, w0, [x8]
  68:	00003700 	udf	#14080
  6c:	01010400 	.inst	0x01010400 ; undefined
  70:	000d0efb 	.inst	0x000d0efb ; undefined
  74:	01010101 	.inst	0x01010101 ; undefined
  78:	01000000 	.inst	0x01000000 ; undefined
  7c:	01010000 	.inst	0x01010000 ; undefined
  80:	00031f01 	.inst	0x00031f01 ; undefined
  84:	2c000000 	stnp	s0, s0, [x0]
  88:	30000000 	adr	x0, 89 <_start-0x7ff77>
  8c:	02000000 	.inst	0x02000000 ; undefined
  90:	0f021f01 	.inst	0x0f021f01 ; undefined
  94:	00004803 	udf	#18435
  98:	00480100 	.inst	0x00480100 ; undefined
  9c:	54010000 	b.eq	209c <_start-0x7df64>  // b.none
  a0:	02000000 	.inst	0x02000000 ; undefined
  a4:	09000105 	.inst	0x09000105 ; undefined
  a8:	08007c02 	stxrb	w0, w2, [x0]
  ac:	00000000 	udf	#0
  b0:	06051700 	.inst	0x06051700 ; undefined
  b4:	001b053e 	.inst	0x001b053e ; undefined
  b8:	3c010402 	str	b2, [x0], #16
  bc:	02000505 	.inst	0x02000505 ; undefined
  c0:	06200104 	.inst	0x06200104 ; undefined
  c4:	0604052e 	.inst	0x0604052e ; undefined
  c8:	22020521 	.inst	0x22020521 ; undefined
  cc:	3f590105 	.inst	0x3f590105 ; undefined
  d0:	05300605 	ext	z5.b, z5.b, z16.b, #129
  d4:	0402001b 	.inst	0x0402001b ; undefined
  d8:	05053c01 	.inst	0x05053c01 ; undefined
  dc:	01040200 	.inst	0x01040200 ; undefined
  e0:	052e0620 	ext	z0.b, z0.b, z17.b, #113
  e4:	05210604 	ext	z4.b, z4.b, z16.b, #9
  e8:	1d052209 	.inst	0x1d052209 ; undefined
  ec:	01040200 	.inst	0x01040200 ; undefined
  f0:	2101053c 	.inst	0x2101053c ; undefined
  f4:	3d0b0531 	str	b17, [x9, #705]
  f8:	05200205 	ext	z5.b, z5.b, z16.b, #0
  fc:	03052116 	.inst	0x03052116 ; undefined
 100:	0024053c 	.inst	0x0024053c ; NYI
 104:	2d030402 	stp	s2, s1, [x0, #24]
 108:	02001505 	.inst	0x02001505 ; undefined
 10c:	053c0104 	ext	z4.b, z4.b, z8.b, #224
 110:	04020019 	.inst	0x04020019 ; undefined
 114:	01054a01 	.inst	0x01054a01 ; undefined
 118:	0d054d31 	.inst	0x0d054d31 ; undefined
 11c:	4b0b0531 	sub	w17, w9, w11, lsl #1
 120:	053d3d3d 	.inst	0x053d3d3d ; undefined
 124:	4b4c3d02 	sub	w2, w8, w12, lsr #15
 128:	4c2f4b2f 	.inst	0x4c2f4b2f ; undefined
 12c:	4b4b4b4b 	sub	w11, w26, w11, lsr #18
 130:	01054c4b 	.inst	0x01054c4b ; undefined
 134:	0003024b 	.inst	0x0003024b ; undefined
 138:	005a0101 	.inst	0x005a0101 ; undefined
 13c:	00050000 	.inst	0x00050000 ; undefined
 140:	002e0008 	.inst	0x002e0008 ; NYI
 144:	01040000 	.inst	0x01040000 ; undefined
 148:	0d0efb01 	.inst	0x0d0efb01 ; undefined
 14c:	01010100 	.inst	0x01010100 ; undefined
 150:	00000001 	udf	#1
 154:	01000001 	.inst	0x01000001 ; undefined
 158:	021f0101 	.inst	0x021f0101 ; undefined
 15c:	00000000 	udf	#0
 160:	0000002c 	udf	#44
 164:	021f0102 	.inst	0x021f0102 ; undefined
 168:	005c020f 	.inst	0x005c020f ; undefined
 16c:	5c010000 	ldr	d0, 216c <_start-0x7de94>
 170:	01000000 	.inst	0x01000000 ; undefined
 174:	00020900 	.inst	0x00020900 ; undefined
 178:	00000800 	udf	#2048
 17c:	19000000 	stlurb	w0, [x0]
 180:	21212221 	.inst	0x21212221 ; undefined
 184:	22212121 	.inst	0x22212121 ; undefined
 188:	23212121 	.inst	0x23212121 ; undefined
 18c:	21212124 	.inst	0x21212124 ; undefined
 190:	02212122 	.inst	0x02212122 ; undefined
 194:	01010002 	.inst	0x01010002 ; undefined
 198:	0000004a 	udf	#74
 19c:	00080005 	.inst	0x00080005 ; undefined
 1a0:	0000002e 	udf	#46
 1a4:	fb010104 	.inst	0xfb010104 ; undefined
 1a8:	01000d0e 	.inst	0x01000d0e ; undefined
 1ac:	00010101 	.inst	0x00010101 ; undefined
 1b0:	00010000 	.inst	0x00010000 ; undefined
 1b4:	01010100 	.inst	0x01010100 ; undefined
 1b8:	0000021f 	udf	#543
 1bc:	002c0000 	.inst	0x002c0000 ; NYI
 1c0:	01020000 	.inst	0x01020000 ; undefined
 1c4:	020f021f 	.inst	0x020f021f ; undefined
 1c8:	00000063 	udf	#99
 1cc:	00006301 	udf	#25345
 1d0:	09000100 	.inst	0x09000100 ; undefined
 1d4:	08027802 	stxrb	w2, w2, [x0]
 1d8:	00000000 	udf	#0
 1dc:	21211400 	.inst	0x21211400 ; undefined
 1e0:	00010221 	.inst	0x00010221 ; undefined
 1e4:	004d0101 	.inst	0x004d0101 ; undefined
 1e8:	00050000 	.inst	0x00050000 ; undefined
 1ec:	002e0008 	.inst	0x002e0008 ; NYI
 1f0:	01040000 	.inst	0x01040000 ; undefined
 1f4:	0d0efb01 	.inst	0x0d0efb01 ; undefined
 1f8:	01010100 	.inst	0x01010100 ; undefined
 1fc:	00000001 	udf	#1
 200:	01000001 	.inst	0x01000001 ; undefined
 204:	021f0101 	.inst	0x021f0101 ; undefined
 208:	00000000 	udf	#0
 20c:	0000002c 	udf	#44
 210:	021f0102 	.inst	0x021f0102 ; undefined
 214:	0068020f 	.inst	0x0068020f ; undefined
 218:	68010000 	.inst	0x68010000 ; undefined
 21c:	01000000 	.inst	0x01000000 ; undefined
 220:	88020900 	stxr	w2, w0, [x8]
 224:	00000802 	udf	#2050
 228:	14000000 	b	228 <_start-0x7fdd8>
 22c:	24212421 	cmplo	p1.b, p1/z, z1.b, #4
 230:	01022121 	.inst	0x01022121 ; undefined
 234:	Address 0x234 is out of bounds.


Disassembly of section .debug_str:

0000000000000000 <.debug_str>:
   0:	6e72656b 	umax	v11.8h, v11.8h, v18.8h
   4:	6d5f6c65 	ldp	d5, d27, [x3, #496]
   8:	006e6961 	.inst	0x006e6961 ; undefined
   c:	74726175 	.inst	0x74726175 ; undefined
  10:	6e65735f 	uabdl2	v31.4s, v26.8h, v5.8h
  14:	61750064 	.inst	0x61750064 ; undefined
  18:	725f7472 	.inst	0x725f7472 ; undefined
  1c:	00766365 	.inst	0x00766365 ; undefined
  20:	20554e47 	.inst	0x20554e47 ; undefined
  24:	20333243 	.inst	0x20333243 ; undefined
  28:	312e3531 	adds	w17, w9, #0xb8d
  2c:	2d20302e 	stp	s14, s12, [x1, #-256]
  30:	6e65676d 	umax	v13.8h, v27.8h, v5.8h
  34:	6c617265 	ldnp	d5, d28, [x19, #-496]
  38:	6765722d 	.inst	0x6765722d ; undefined
  3c:	6e6f2d73 	uqsub	v19.8h, v11.8h, v15.8h
  40:	2d20796c 	stp	s12, s30, [x11, #-256]
  44:	74696c6d 	.inst	0x74696c6d ; undefined
  48:	2d656c74 	ldp	s20, s27, [x3, #-216]
  4c:	69646e65 	ldpsw	x5, x27, [x19, #-224]
  50:	2d206e61 	stp	s1, s27, [x19, #-256]
  54:	6962616d 	ldpsw	x13, x24, [x11, #-240]
  58:	36706c3d 	tbz	w29, #14, ddc <_start-0x7f224>
  5c:	672d2034 	.inst	0x672d2034 ; undefined
  60:	304f2d20 	adr	x0, 9e605 <bss_begin+0x1e29d>
  64:	6e662d20 	uqsub	v0.8h, v9.8h, v6.8h
  68:	74732d6f 	.inst	0x74732d6f ; undefined
  6c:	2d6b6361 	ldp	s1, s24, [x27, #-168]
  70:	746f7270 	.inst	0x746f7270 ; undefined
  74:	6f746365 	umlsl2	v5.4s, v27.8h, v4.h[3]
  78:	662d2072 	.inst	0x662d2072 ; undefined
  7c:	65657266 	fnmls	z6.h, p4/m, z19.h, z5.h
  80:	6e617473 	uabd	v19.8h, v3.8h, v1.8h
  84:	676e6964 	.inst	0x676e6964 ; undefined
  88:	72617500 	.inst	0x72617500 ; undefined
  8c:	6e695f74 	uqrshl	v20.8h, v27.8h, v9.8h
  90:	75007469 	.inst	0x75007469 ; undefined
  94:	5f747261 	sqdmlsl	s1, h19, v4.h[3]
  98:	646e6573 	.inst	0x646e6573 ; undefined
  9c:	7274735f 	.inst	0x7274735f ; undefined
  a0:	00676e69 	.inst	0x00676e69 ; undefined
  a4:	72616863 	.inst	0x72616863 ; undefined
  a8:	6e6f6c00 	umin	v0.8h, v0.8h, v15.8h
  ac:	6e752067 	usubl2	v7.4s, v3.8h, v21.8h
  b0:	6e676973 	.inst	0x6e676973 ; undefined
  b4:	69206465 	stgp	x5, x25, [x3, #-1024]
  b8:	6400746e 	.inst	0x6400746e ; undefined
  bc:	79616c65 	ldrh	w5, [x3, #4278]
  c0:	6c657300 	ldnp	d0, d28, [x24, #-432]
  c4:	6f746365 	umlsl2	v5.4s, v27.8h, v4.h[3]
  c8:	75700072 	.inst	0x75700072 ; undefined
  cc:	00323374 	.inst	0x00323374 ; NYI
  d0:	33746567 	.inst	0x33746567 ; undefined
  d4:	72730032 	.inst	0x72730032 ; undefined
  d8:	6f622f63 	.inst	0x6f622f63 ; undefined
  dc:	532e746f 	.inst	0x532e746f ; undefined
  e0:	6f682f00 	.inst	0x6f682f00 ; undefined
  e4:	522f656d 	eor	w13, w11, #0xfffe07ff
  e8:	69616d6f 	ldpsw	x15, x27, [x11, #-248]
  ec:	6f432f6e 	.inst	0x6f432f6e ; undefined
  f0:	2f737275 	fcmla	v21.4h, v19.4h, v19.h[1], #270
  f4:	2f424c43 	.inst	0x2f424c43 ; undefined
  f8:	2f735054 	fcmla	v20.4h, v2.4h, v19.h[1], #180
  fc:	00315054 	.inst	0x00315054 ; NYI
 100:	20554e47 	.inst	0x20554e47 ; undefined
 104:	32205341 	orr	w1, w26, #0x1fffff
 108:	0034342e 	.inst	0x0034342e ; NYI
 10c:	2f637273 	fcmla	v19.4h, v19.4h, v3.h[1], #270
 110:	532e6d6d 	.inst	0x532e6d6d ; undefined
 114:	63727300 	.inst	0x63727300 ; undefined
 118:	6974752f 	ldpsw	x15, x29, [x9, #-96]
 11c:	532e736c 	.inst	0x532e736c ; undefined
	...

Disassembly of section .debug_line_str:

0000000000000000 <.debug_line_str>:
   0:	6d6f682f 	ldp	d15, d26, [x1, #-272]
   4:	6f522f65 	.inst	0x6f522f65 ; undefined
   8:	6e69616d 	rsubhn2	v13.8h, v11.4s, v9.4s
   c:	756f432f 	.inst	0x756f432f ; undefined
  10:	432f7372 	.inst	0x432f7372 ; undefined
  14:	542f424c 	b.gt	5e85c <_start-0x217a4>
  18:	542f7350 	bc.eq	5ee80 <_start-0x21180>  // bc.none
  1c:	73003150 	.inst	0x73003150 ; undefined
  20:	6b2f6372 	subs	w18, w27, w15, uxtx
  24:	656e7265 	fnmls	z5.h, p4/m, z19.h, z14.h
  28:	00632e6c 	.inst	0x00632e6c ; undefined
  2c:	00637273 	.inst	0x00637273 ; undefined
  30:	6c636e69 	ldnp	d9, d27, [x19, #-464]
  34:	00656475 	.inst	0x00656475 ; undefined
  38:	696e696d 	ldpsw	x13, x26, [x11, #-144]
  3c:	7261755f 	.inst	0x7261755f ; undefined
  40:	00682e74 	.inst	0x00682e74 ; undefined
  44:	2f637273 	fcmla	v19.4h, v19.4h, v3.h[1], #270
  48:	696e696d 	ldpsw	x13, x26, [x11, #-144]
  4c:	7261755f 	.inst	0x7261755f ; undefined
  50:	00632e74 	.inst	0x00632e74 ; undefined
  54:	6c697475 	ldnp	d21, d29, [x3, #-368]
  58:	00682e73 	.inst	0x00682e73 ; undefined
  5c:	746f6f62 	.inst	0x746f6f62 ; undefined
  60:	6d00532e 	stp	d14, d20, [x25]
  64:	00532e6d 	.inst	0x00532e6d ; undefined
  68:	6c697475 	ldnp	d21, d29, [x3, #-368]
  6c:	00532e73 	.inst	0x00532e73 ; undefined

Disassembly of section .comment:

0000000000000000 <.comment>:
   0:	3a434347 	ccmn	w26, w3, #0x7, mi	// mi = first
   4:	4e472820 	trn1	v0.8h, v1.8h, v7.8h
   8:	31202955 	adds	w21, w10, #0x80a
   c:	2e312e35 	uqsub	v21.8b, v17.8b, v17.8b
  10:	Address 0x10 is out of bounds.

