
control.elf:     file format elf32-littlearm


Disassembly of section .text:

00000400 <_start>:
 400:	e92d4800 	push	{fp, lr}
 404:	e28db004 	add	fp, sp, #4
 408:	e24dd008 	sub	sp, sp, #8
 40c:	e3a01000 	mov	r1, #0
 410:	e3a00000 	mov	r0, #0
 414:	eb000010 	bl	45c <main>
 418:	e50b0008 	str	r0, [fp, #-8]
 41c:	e51b0008 	ldr	r0, [fp, #-8]
 420:	eb00002a 	bl	4d0 <_exit>

00000424 <one>:
 424:	e52db004 	push	{fp}		@ (str fp, [sp, #-4]!)
 428:	e28db000 	add	fp, sp, #0
 42c:	e3a03001 	mov	r3, #1
 430:	e1a00003 	mov	r0, r3
 434:	e28bd000 	add	sp, fp, #0
 438:	e49db004 	pop	{fp}		@ (ldr fp, [sp], #4)
 43c:	e12fff1e 	bx	lr

00000440 <zero>:
 440:	e52db004 	push	{fp}		@ (str fp, [sp, #-4]!)
 444:	e28db000 	add	fp, sp, #0
 448:	e3a03000 	mov	r3, #0
 44c:	e1a00003 	mov	r0, r3
 450:	e28bd000 	add	sp, fp, #0
 454:	e49db004 	pop	{fp}		@ (ldr fp, [sp], #4)
 458:	e12fff1e 	bx	lr

0000045c <main>:
 45c:	e92d4800 	push	{fp, lr}
 460:	e28db004 	add	fp, sp, #4
 464:	e24dd010 	sub	sp, sp, #16
 468:	e50b0010 	str	r0, [fp, #-16]
 46c:	e50b1014 	str	r1, [fp, #-20]	@ 0xffffffec
 470:	e51b3010 	ldr	r3, [fp, #-16]
 474:	e3530000 	cmp	r3, #0
 478:	1a000001 	bne	484 <main+0x28>
 47c:	e3a00001 	mov	r0, #1
 480:	eb000012 	bl	4d0 <_exit>
 484:	e51b3010 	ldr	r3, [fp, #-16]
 488:	e3530001 	cmp	r3, #1
 48c:	ca000002 	bgt	49c <main+0x40>
 490:	e59f3030 	ldr	r3, [pc, #48]	@ 4c8 <main+0x6c>
 494:	e50b3008 	str	r3, [fp, #-8]
 498:	ea000001 	b	4a4 <main+0x48>
 49c:	e59f3028 	ldr	r3, [pc, #40]	@ 4cc <main+0x70>
 4a0:	e50b3008 	str	r3, [fp, #-8]
 4a4:	e51b3008 	ldr	r3, [fp, #-8]
 4a8:	e1a0e00f 	mov	lr, pc
 4ac:	e12fff13 	bx	r3
 4b0:	e50b000c 	str	r0, [fp, #-12]
 4b4:	e51b300c 	ldr	r3, [fp, #-12]
 4b8:	e1a00003 	mov	r0, r3
 4bc:	e24bd004 	sub	sp, fp, #4
 4c0:	e8bd4800 	pop	{fp, lr}
 4c4:	e12fff1e 	bx	lr
 4c8:	00000424 	andeq	r0, r0, r4, lsr #8
 4cc:	00000440 	andeq	r0, r0, r0, asr #8

000004d0 <_exit>:
 4d0:	e52db004 	push	{fp}		@ (str fp, [sp, #-4]!)
 4d4:	e28db000 	add	fp, sp, #0
 4d8:	e24dd00c 	sub	sp, sp, #12
 4dc:	e50b0008 	str	r0, [fp, #-8]
 4e0:	ef00007b 	svc	0x0000007b
 4e4:	e7f000f0 	udf	#0

Disassembly of section .debug_info:

00000000 <.debug_info>:
   0:	0000010a 	andeq	r0, r0, sl, lsl #2
   4:	04010005 	streq	r0, [r1], #-5
   8:	00000000 	andeq	r0, r0, r0
   c:	00252504 	eoreq	r2, r5, r4, lsl #10
  10:	47031d00 	strmi	r1, [r3, -r0, lsl #26]
  14:	99000316 	stmdbls	r0, {r1, r2, r4, r8, r9}
  18:	09000004 	stmdbeq	r0, {r2}
  1c:	00000001 	andeq	r0, r0, r1
  20:	e8000004 	stmda	r0, {r2}
	...
  2c:	05000000 	streq	r0, [r0, #-0]
  30:	000020dd 			@ <UNDEFINED> instruction: 0x000020dd
  34:	d0062401 	andle	r2, r6, r1, lsl #8
  38:	18000004 	stmdane	r0, {r2}
  3c:	01000000 	mrseq	r0, (UNDEF: 0)
  40:	0000539c 	muleq	r0, ip, r3
  44:	00720600 	rsbseq	r0, r2, r0, lsl #12
  48:	53102401 	tstpl	r0, #16777216	@ 0x1000000
  4c:	02000000 	andeq	r0, r0, #0
  50:	07007491 			@ <UNDEFINED> instruction: 0x07007491
  54:	6e690504 	cdpvs	5, 6, cr0, cr9, cr4, {0}
  58:	a0080074 	andge	r0, r8, r4, ror r0
  5c:	0100002a 	tsteq	r0, sl, lsr #32
  60:	00530513 	subseq	r0, r3, r3, lsl r5
  64:	045c0000 	ldrbeq	r0, [ip], #-0
  68:	00740000 	rsbseq	r0, r4, r0
  6c:	9c010000 	stcls	0, cr0, [r1], {-0}
  70:	000000a7 	andeq	r0, r0, r7, lsr #1
  74:	001c1f03 	andseq	r1, ip, r3, lsl #30
  78:	00530e00 	subseq	r0, r3, r0, lsl #28
  7c:	91020000 	mrsls	r0, (UNDEF: 2)
  80:	1285036c 	addne	r0, r5, #108, 6	@ 0xb0000001
  84:	a71b0000 	ldrge	r0, [fp, -r0]
  88:	02000000 	andeq	r0, r0, #0
  8c:	72016891 	andvc	r6, r1, #9502720	@ 0x910000
  90:	53061400 	tstpl	r6, #0, 8
  94:	02000000 	andeq	r0, r0, #0
  98:	66017091 			@ <UNDEFINED> instruction: 0x66017091
  9c:	bd081500 	stclt	5, cr1, [r8, #-0]
  a0:	02000000 	andeq	r0, r0, #0
  a4:	02007491 	andeq	r7, r0, #-1862270976	@ 0x91000000
  a8:	000000ac 	andeq	r0, r0, ip, lsr #1
  ac:	0000b102 	andeq	fp, r0, r2, lsl #2
  b0:	08010900 	stmdaeq	r1, {r8, fp}
  b4:	000020a2 	andeq	r2, r0, r2, lsr #1
  b8:	0000530a 	andeq	r5, r0, sl, lsl #6
  bc:	00b80200 	adcseq	r0, r8, r0, lsl #4
  c0:	f50b0000 			@ <UNDEFINED> instruction: 0xf50b0000
  c4:	01000016 	tsteq	r0, r6, lsl r0
  c8:	0053050f 	subseq	r0, r3, pc, lsl #10
  cc:	04400000 	strbeq	r0, [r0], #-0
  d0:	001c0000 	andseq	r0, ip, r0
  d4:	9c010000 	stcls	0, cr0, [r1], {-0}
  d8:	656e6f0c 	strbvs	r6, [lr, #-3852]!	@ 0xfffff0f4
  dc:	050b0100 	streq	r0, [fp, #-256]	@ 0xffffff00
  e0:	00000053 	andeq	r0, r0, r3, asr r0
  e4:	00000424 	andeq	r0, r0, r4, lsr #8
  e8:	0000001c 	andeq	r0, r0, ip, lsl r0
  ec:	cb0d9c01 	blgt	3670f8 <_exit+0x366c28>
  f0:	0100000e 	tsteq	r0, lr
  f4:	04000605 	streq	r0, [r0], #-1541	@ 0xfffff9fb
  f8:	00240000 	eoreq	r0, r4, r0
  fc:	9c010000 	stcls	0, cr0, [r1], {-0}
 100:	06007201 	streq	r7, [r0], -r1, lsl #4
 104:	00005306 	andeq	r5, r0, r6, lsl #6
 108:	74910200 	ldrvc	r0, [r1], #512	@ 0x200
	...

Disassembly of section .debug_abbrev:

00000000 <.debug_abbrev>:
   0:	03003401 	tsteq	r0, #16777216	@ 0x1000000
   4:	01213a08 			@ <UNDEFINED> instruction: 0x01213a08
   8:	0b390b3b 	bleq	e42cfc <_exit+0xe4282c>
   c:	18021349 	stmdane	r2, {r0, r3, r6, r8, r9, ip}
  10:	0f020000 	svceq	0x00020000
  14:	04210b00 	strteq	r0, [r1], #-2816	@ 0xfffff500
  18:	00001349 	andeq	r1, r0, r9, asr #6
  1c:	03000503 	tsteq	r0, #12582912	@ 0xc00000
  20:	01213a0e 			@ <UNDEFINED> instruction: 0x01213a0e
  24:	3913213b 	ldmdbcc	r3, {r0, r1, r3, r4, r5, r8, sp}
  28:	0213490b 	andseq	r4, r3, #180224	@ 0x2c000
  2c:	04000018 	streq	r0, [r0], #-24	@ 0xffffffe8
  30:	0e250111 	mcreq	1, 1, r0, cr5, cr1, {0}
  34:	01900b13 	orrseq	r0, r0, r3, lsl fp
  38:	0601910b 	streq	r9, [r1], -fp, lsl #2
  3c:	0e1b0e03 	cdpeq	14, 1, cr0, cr11, cr3, {0}
  40:	06120111 			@ <UNDEFINED> instruction: 0x06120111
  44:	17791710 			@ <UNDEFINED> instruction: 0x17791710
  48:	2e050000 	cdpcs	0, 0, cr0, cr5, cr0, {0}
  4c:	03193f01 	tsteq	r9, #1, 30
  50:	3b0b3a0e 	blcc	2ce890 <_exit+0x2ce3c0>
  54:	270b390b 	strcs	r3, [fp, -fp, lsl #18]
  58:	19018719 	stmdbne	r1, {r0, r3, r4, r8, r9, sl, pc}
  5c:	06120111 			@ <UNDEFINED> instruction: 0x06120111
  60:	197a1840 	ldmdbne	sl!, {r6, fp, ip}^
  64:	00001301 	andeq	r1, r0, r1, lsl #6
  68:	03000506 	tsteq	r0, #25165824	@ 0x1800000
  6c:	3b0b3a08 	blcc	2ce894 <_exit+0x2ce3c4>
  70:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
  74:	00180213 	andseq	r0, r8, r3, lsl r2
  78:	00240700 	eoreq	r0, r4, r0, lsl #14
  7c:	0b3e0b0b 	bleq	f82cb0 <_exit+0xf827e0>
  80:	00000803 	andeq	r0, r0, r3, lsl #16
  84:	3f012e08 	svccc	0x00012e08
  88:	3a0e0319 	bcc	380cf4 <_exit+0x380824>
  8c:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
  90:	4919270b 	ldmdbmi	r9, {r0, r1, r3, r8, r9, sl, sp}
  94:	12011113 	andne	r1, r1, #-1073741820	@ 0xc0000004
  98:	7c184006 	ldcvc	0, cr4, [r8], {6}
  9c:	00130119 	andseq	r0, r3, r9, lsl r1
  a0:	00240900 	eoreq	r0, r4, r0, lsl #18
  a4:	0b3e0b0b 	bleq	f82cd8 <_exit+0xf82808>
  a8:	00000e03 	andeq	r0, r0, r3, lsl #28
  ac:	2700150a 	strcs	r1, [r0, -sl, lsl #10]
  b0:	00134919 	andseq	r4, r3, r9, lsl r9
  b4:	002e0b00 	eoreq	r0, lr, r0, lsl #22
  b8:	0e03193f 			@ <UNDEFINED> instruction: 0x0e03193f
  bc:	0b3b0b3a 	bleq	ec2dac <_exit+0xec28dc>
  c0:	19270b39 	stmdbne	r7!, {r0, r3, r4, r5, r8, r9, fp}
  c4:	01111349 	tsteq	r1, r9, asr #6
  c8:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
  cc:	0000197a 	andeq	r1, r0, sl, ror r9
  d0:	3f002e0c 	svccc	0x00002e0c
  d4:	3a080319 	bcc	200d40 <_exit+0x200870>
  d8:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
  dc:	4919270b 	ldmdbmi	r9, {r0, r1, r3, r8, r9, sl, sp}
  e0:	12011113 	andne	r1, r1, #-1073741820	@ 0xc0000004
  e4:	7a184006 	bvc	610104 <_exit+0x60fc34>
  e8:	0d000019 	stceq	0, cr0, [r0, #-100]	@ 0xffffff9c
  ec:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	@ <UNPREDICTABLE>
  f0:	0b3a0e03 	bleq	e83904 <_exit+0xe83434>
  f4:	0b390b3b 	bleq	e42de8 <_exit+0xe42918>
  f8:	01111927 	tsteq	r1, r7, lsr #18
  fc:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
 100:	0000197c 	andeq	r1, r0, ip, ror r9
	...

Disassembly of section .debug_aranges:

00000000 <.debug_aranges>:
   0:	0000001c 	andeq	r0, r0, ip, lsl r0
   4:	00000002 	andeq	r0, r0, r2
   8:	00040000 	andeq	r0, r4, r0
   c:	00000000 	andeq	r0, r0, r0
  10:	00000400 	andeq	r0, r0, r0, lsl #8
  14:	000000e8 	andeq	r0, r0, r8, ror #1
	...

Disassembly of section .debug_macro:

00000000 <.debug_macro>:
   0:	00020005 	andeq	r0, r2, r5
   4:	07000000 	streq	r0, [r0, -r0]
   8:	00000011 	andeq	r0, r0, r1, lsl r0
   c:	04010003 	streq	r0, [r1], #-3
  10:	00000500 	andeq	r0, r0, r0, lsl #10
  14:	191c0005 	ldmdbne	ip, {r0, r2}
  18:	00050000 	andeq	r0, r5, r0
  1c:	00000923 	andeq	r0, r0, r3, lsr #18
  20:	1b1f0005 	blne	7c003c <_exit+0x7bfb6c>
  24:	00050000 	andeq	r0, r5, r0
  28:	000006ad 	andeq	r0, r0, sp, lsr #13
  2c:	25810005 	strcs	r0, [r1, #5]
  30:	00050000 	andeq	r0, r5, r0
  34:	00002244 	andeq	r2, r0, r4, asr #4
  38:	16210005 	strtne	r0, [r1], -r5
  3c:	00050000 	andeq	r0, r5, r0
  40:	00002a6c 	andeq	r2, r0, ip, ror #20
  44:	0baf0005 	bleq	febc0060 <_exit+0xfebbfb90>
  48:	00050000 	andeq	r0, r5, r0
  4c:	000002fe 			@ <UNDEFINED> instruction: 0x000002fe
  50:	1a3b0005 	bne	ec006c <_exit+0xebfb9c>
  54:	00050000 	andeq	r0, r5, r0
  58:	000014ac 	andeq	r1, r0, ip, lsr #9
  5c:	075d0005 	ldrbeq	r0, [sp, -r5]
  60:	00050000 	andeq	r0, r5, r0
  64:	000005de 			@ <UNDEFINED> instruction: 0x000005de
  68:	19090005 	stmdbne	r9, {r0, r2}
  6c:	00050000 	andeq	r0, r5, r0
  70:	000001ba 			@ <UNDEFINED> instruction: 0x000001ba
  74:	264d0005 	strbcs	r0, [sp], -r5
  78:	00050000 	andeq	r0, r5, r0
  7c:	0000194e 	andeq	r1, r0, lr, asr #18
  80:	17910005 	ldrne	r0, [r1, r5]
  84:	00050000 	andeq	r0, r5, r0
  88:	00002941 	andeq	r2, r0, r1, asr #18
  8c:	19270005 	stmdbne	r7!, {r0, r2}
  90:	00050000 	andeq	r0, r5, r0
  94:	000021ca 	andeq	r2, r0, sl, asr #3
  98:	03950005 	orrseq	r0, r5, #5
  9c:	00050000 	andeq	r0, r5, r0
  a0:	00000f6f 	andeq	r0, r0, pc, ror #30
  a4:	1a270005 	bne	9c00c0 <_exit+0x9bfbf0>
  a8:	00050000 	andeq	r0, r5, r0
  ac:	000003cb 	andeq	r0, r0, fp, asr #7
  b0:	25110005 	ldrcs	r0, [r1, #-5]
  b4:	00050000 	andeq	r0, r5, r0
  b8:	000016e6 	andeq	r1, r0, r6, ror #13
  bc:	0ffe0005 	svceq	0x00fe0005
  c0:	00050000 	andeq	r0, r5, r0
  c4:	00001077 	andeq	r1, r0, r7, ror r0
  c8:	04380005 	ldrteq	r0, [r8], #-5
  cc:	00050000 	andeq	r0, r5, r0
  d0:	00001e35 	andeq	r1, r0, r5, lsr lr
  d4:	064c0005 	strbeq	r0, [ip], -r5
  d8:	00050000 	andeq	r0, r5, r0
  dc:	00001c24 	andeq	r1, r0, r4, lsr #24
  e0:	23040005 	tstcs	r4, #5
  e4:	00050000 	andeq	r0, r5, r0
  e8:	00002b8f 	andeq	r2, r0, pc, lsl #23
  ec:	278c0005 	strcs	r0, [ip, r5]
  f0:	00050000 	andeq	r0, r5, r0
  f4:	00002814 	andeq	r2, r0, r4, lsl r8
  f8:	053c0005 	ldreq	r0, [ip, #-5]!
  fc:	00050000 	andeq	r0, r5, r0
 100:	00000db1 			@ <UNDEFINED> instruction: 0x00000db1
 104:	19970005 	ldmibne	r7, {r0, r2}
 108:	00050000 	andeq	r0, r5, r0
 10c:	00002952 	andeq	r2, r0, r2, asr r9
 110:	268c0005 	strcs	r0, [ip], r5
 114:	00050000 	andeq	r0, r5, r0
 118:	000020c0 	andeq	r2, r0, r0, asr #1
 11c:	03a80005 			@ <UNDEFINED> instruction: 0x03a80005
 120:	00050000 	andeq	r0, r5, r0
 124:	00001d03 	andeq	r1, r0, r3, lsl #26
 128:	2c6f0005 	stclcs	0, cr0, [pc], #-20	@ 11c <_start-0x2e4>
 12c:	00050000 	andeq	r0, r5, r0
 130:	0000208d 	andeq	r2, r0, sp, lsl #1
 134:	05620005 	strbeq	r0, [r2, #-5]!
 138:	00050000 	andeq	r0, r5, r0
 13c:	00001f20 	andeq	r1, r0, r0, lsr #30
 140:	1aa20005 	bne	fe88015c <_exit+0xfe87fc8c>
 144:	00050000 	andeq	r0, r5, r0
 148:	000021fa 			@ <UNDEFINED> instruction: 0x000021fa
 14c:	11860005 	orrne	r0, r6, r5
 150:	00050000 	andeq	r0, r5, r0
 154:	000022c7 	andeq	r2, r0, r7, asr #5
 158:	29ca0005 	stmibcs	sl, {r0, r2}^
 15c:	00050000 	andeq	r0, r5, r0
 160:	00001714 	andeq	r1, r0, r4, lsl r7
 164:	15960005 	ldrne	r0, [r6, #5]
 168:	00050000 	andeq	r0, r5, r0
 16c:	00000c28 	andeq	r0, r0, r8, lsr #24
 170:	22860005 	addcs	r0, r6, #5
 174:	00050000 	andeq	r0, r5, r0
 178:	00001748 	andeq	r1, r0, r8, asr #14
 17c:	121c0005 	andsne	r0, ip, #5
 180:	00050000 	andeq	r0, r5, r0
 184:	00001d8e 	andeq	r1, r0, lr, lsl #27
 188:	04e10005 	strbteq	r0, [r1], #5
 18c:	00050000 	andeq	r0, r5, r0
 190:	00000d3d 	andeq	r0, r0, sp, lsr sp
 194:	11560005 	cmpne	r6, r5
 198:	00050000 	andeq	r0, r5, r0
 19c:	00002911 	andeq	r2, r0, r1, lsl r9
 1a0:	08990005 	ldmeq	r9, {r0, r2}
 1a4:	00050000 	andeq	r0, r5, r0
 1a8:	0000007d 	andeq	r0, r0, sp, ror r0
 1ac:	13690005 	cmnne	r9, #5
 1b0:	00050000 	andeq	r0, r5, r0
 1b4:	00001f7a 	andeq	r1, r0, sl, ror pc
 1b8:	26600005 	strbtcs	r0, [r0], -r5
 1bc:	00050000 	andeq	r0, r5, r0
 1c0:	0000270d 	andeq	r2, r0, sp, lsl #14
 1c4:	09700005 	ldmdbeq	r0!, {r0, r2}^
 1c8:	00050000 	andeq	r0, r5, r0
 1cc:	0000057b 	andeq	r0, r0, fp, ror r5
 1d0:	06da0005 	ldrbeq	r0, [sl], r5
 1d4:	00050000 	andeq	r0, r5, r0
 1d8:	00001e11 	andeq	r1, r0, r1, lsl lr
 1dc:	050e0005 	streq	r0, [lr, #-5]
 1e0:	00050000 	andeq	r0, r5, r0
 1e4:	000019b2 			@ <UNDEFINED> instruction: 0x000019b2
 1e8:	11f50005 	mvnsne	r0, r5
 1ec:	00050000 	andeq	r0, r5, r0
 1f0:	000021b0 			@ <UNDEFINED> instruction: 0x000021b0
 1f4:	28e90005 	stmiacs	r9!, {r0, r2}^
 1f8:	00050000 	andeq	r0, r5, r0
 1fc:	000020a7 	andeq	r2, r0, r7, lsr #1
 200:	02ee0005 	rsceq	r0, lr, #5
 204:	00050000 	andeq	r0, r5, r0
 208:	00000b08 	andeq	r0, r0, r8, lsl #22
 20c:	07870005 	streq	r0, [r7, r5]
 210:	00050000 	andeq	r0, r5, r0
 214:	000019f4 			@ <UNDEFINED> instruction: 0x000019f4
 218:	22170005 	andscs	r0, r7, #5
 21c:	00050000 	andeq	r0, r5, r0
 220:	000023dc 			@ <UNDEFINED> instruction: 0x000023dc
 224:	1cdf0005 	ldclne	0, cr0, [pc], {5}
 228:	00050000 	andeq	r0, r5, r0
 22c:	000001ff 			@ <UNDEFINED> instruction: 0x000001ff
 230:	11a90005 			@ <UNDEFINED> instruction: 0x11a90005
 234:	00050000 	andeq	r0, r5, r0
 238:	00001eba 			@ <UNDEFINED> instruction: 0x00001eba
 23c:	23760005 	cmncs	r6, #5
 240:	00050000 	andeq	r0, r5, r0
 244:	00001c6f 	andeq	r1, r0, pc, ror #24
 248:	0e780005 	cdpeq	0, 7, cr0, cr8, cr5, {0}
 24c:	00050000 	andeq	r0, r5, r0
 250:	00002970 	andeq	r2, r0, r0, ror r9
 254:	2c490005 	stclcs	0, cr0, [r9], {5}
 258:	00050000 	andeq	r0, r5, r0
 25c:	00000634 	andeq	r0, r0, r4, lsr r6
 260:	155d0005 	ldrbne	r0, [sp, #-5]
 264:	00050000 	andeq	r0, r5, r0
 268:	00000025 	andeq	r0, r0, r5, lsr #32
 26c:	1c930005 	ldcne	0, cr0, [r3], {5}
 270:	00050000 	andeq	r0, r5, r0
 274:	00001dd4 			@ <UNDEFINED> instruction: 0x00001dd4
 278:	0bf70005 	bleq	ffdc0294 <_exit+0xffdbfdc4>
 27c:	00050000 	andeq	r0, r5, r0
 280:	000019cb 	andeq	r1, r0, fp, asr #19
 284:	1ea00005 	cdpne	0, 10, cr0, cr0, cr5, {0}
 288:	00050000 	andeq	r0, r5, r0
 28c:	00000bd4 			@ <UNDEFINED> instruction: 0x00000bd4
 290:	14fc0005 	ldrbtne	r0, [ip], #5
 294:	00050000 	andeq	r0, r5, r0
 298:	00001522 	andeq	r1, r0, r2, lsr #10
 29c:	1bab0005 	blne	feac02b8 <_exit+0xfeabfde8>
 2a0:	00050000 	andeq	r0, r5, r0
 2a4:	00001880 	andeq	r1, r0, r0, lsl #17
 2a8:	05f10005 	ldrbeq	r0, [r1, #5]!
 2ac:	00050000 	andeq	r0, r5, r0
 2b0:	000008bb 			@ <UNDEFINED> instruction: 0x000008bb
 2b4:	14d50005 	ldrbne	r0, [r5], #5
 2b8:	00050000 	andeq	r0, r5, r0
 2bc:	000006bf 			@ <UNDEFINED> instruction: 0x000006bf
 2c0:	18550005 	ldmdane	r5, {r0, r2}^
 2c4:	00050000 	andeq	r0, r5, r0
 2c8:	000008d3 			@ <UNDEFINED> instruction: 0x000008d3
 2cc:	2c0b0005 	stccs	0, cr0, [fp], {5}
 2d0:	00050000 	andeq	r0, r5, r0
 2d4:	00002b04 	andeq	r2, r0, r4, lsl #22
 2d8:	27610005 	strbcs	r0, [r1, -r5]!
 2dc:	00050000 	andeq	r0, r5, r0
 2e0:	00001450 	andeq	r1, r0, r0, asr r4
 2e4:	218c0005 	orrcs	r0, ip, r5
 2e8:	00050000 	andeq	r0, r5, r0
 2ec:	00001f07 	andeq	r1, r0, r7, lsl #30
 2f0:	0bbb0005 	bleq	feec030c <_exit+0xfeebfe3c>
 2f4:	00050000 	andeq	r0, r5, r0
 2f8:	0000016d 	andeq	r0, r0, sp, ror #2
 2fc:	2cdf0005 	ldclcs	0, cr0, [pc], {5}
 300:	00050000 	andeq	r0, r5, r0
 304:	00000385 	andeq	r0, r0, r5, lsl #7
 308:	202e0005 	eorcs	r0, lr, r5
 30c:	00050000 	andeq	r0, r5, r0
 310:	00000f9f 	muleq	r0, pc, pc	@ <UNPREDICTABLE>
 314:	0c8c0005 	stceq	0, cr0, [ip], {5}
 318:	00050000 	andeq	r0, r5, r0
 31c:	0000240e 	andeq	r2, r0, lr, lsl #8
 320:	041b0005 	ldreq	r0, [fp], #-5
 324:	00050000 	andeq	r0, r5, r0
 328:	00002aa5 	andeq	r2, r0, r5, lsr #21
 32c:	22a90005 	adccs	r0, r9, #5
 330:	00050000 	andeq	r0, r5, r0
 334:	000000cd 	andeq	r0, r0, sp, asr #1
 338:	18cd0005 	stmiane	sp, {r0, r2}^
 33c:	00050000 	andeq	r0, r5, r0
 340:	00001961 	andeq	r1, r0, r1, ror #18
 344:	0a0e0005 	beq	380360 <_exit+0x37fe90>
 348:	00050000 	andeq	r0, r5, r0
 34c:	00002d83 	andeq	r2, r0, r3, lsl #27
 350:	10580005 	subsne	r0, r8, r5
 354:	00050000 	andeq	r0, r5, r0
 358:	00001349 	andeq	r1, r0, r9, asr #6
 35c:	21590005 	cmpcs	r9, r5
 360:	00050000 	andeq	r0, r5, r0
 364:	0000212f 	andeq	r2, r0, pc, lsr #2
 368:	25930005 	ldrcs	r0, [r3, #5]
 36c:	00050000 	andeq	r0, r5, r0
 370:	00001734 	andeq	r1, r0, r4, lsr r7
 374:	2b5e0005 	blcs	1780390 <_exit+0x177fec0>
 378:	00050000 	andeq	r0, r5, r0
 37c:	00000ada 			@ <UNDEFINED> instruction: 0x00000ada
 380:	1b930005 	blne	fe4c039c <_exit+0xfe4bfecc>
 384:	00050000 	andeq	r0, r5, r0
 388:	0000140b 	andeq	r1, r0, fp, lsl #8
 38c:	0fdd0005 	svceq	0x00dd0005
 390:	00050000 	andeq	r0, r5, r0
 394:	00002721 	andeq	r2, r0, r1, lsr #14
 398:	0cb70005 	ldceq	0, cr0, [r7], #20
 39c:	00050000 	andeq	r0, r5, r0
 3a0:	000012e5 	andeq	r1, r0, r5, ror #5
 3a4:	0a5b0005 	beq	16c03c0 <_exit+0x16bfef0>
 3a8:	00050000 	andeq	r0, r5, r0
 3ac:	00002abc 			@ <UNDEFINED> instruction: 0x00002abc
 3b0:	28880005 	stmcs	r8, {r0, r2}
 3b4:	00050000 	andeq	r0, r5, r0
 3b8:	00002639 	andeq	r2, r0, r9, lsr r6
 3bc:	12450005 	subne	r0, r5, #5
 3c0:	00050000 	andeq	r0, r5, r0
 3c4:	00001e8a 	andeq	r1, r0, sl, lsl #29
 3c8:	27c80005 	strbcs	r0, [r8, r5]
 3cc:	00050000 	andeq	r0, r5, r0
 3d0:	00001ad3 			@ <UNDEFINED> instruction: 0x00001ad3
 3d4:	16380005 	ldrtne	r0, [r8], -r5
 3d8:	00050000 	andeq	r0, r5, r0
 3dc:	0000225f 	andeq	r2, r0, pc, asr r2
 3e0:	1d630005 	stclne	0, cr0, [r3, #-20]!	@ 0xffffffec
 3e4:	00050000 	andeq	r0, r5, r0
 3e8:	00002d6e 	andeq	r2, r0, lr, ror #26
 3ec:	08210005 	stmdaeq	r1!, {r0, r2}
 3f0:	00050000 	andeq	r0, r5, r0
 3f4:	00002929 	andeq	r2, r0, r9, lsr #18
 3f8:	05250005 	streq	r0, [r5, #-5]!
 3fc:	00050000 	andeq	r0, r5, r0
 400:	000004cd 	andeq	r0, r0, sp, asr #9
 404:	15cf0005 	strbne	r0, [pc, #5]	@ 411 <_start+0x11>
 408:	00050000 	andeq	r0, r5, r0
 40c:	000001e7 	andeq	r0, r0, r7, ror #3
 410:	13a10005 			@ <UNDEFINED> instruction: 0x13a10005
 414:	00050000 	andeq	r0, r5, r0
 418:	00001939 	andeq	r1, r0, r9, lsr r9
 41c:	2a0c0005 	bcs	300438 <_exit+0x2fff68>
 420:	00050000 	andeq	r0, r5, r0
 424:	00002d9b 	muleq	r0, fp, sp
 428:	02a80005 	adceq	r0, r8, #5
 42c:	00050000 	andeq	r0, r5, r0
 430:	00000338 	andeq	r0, r0, r8, lsr r3
 434:	0de80005 	stcleq	0, cr0, [r8, #20]!
 438:	00050000 	andeq	r0, r5, r0
 43c:	00000a69 	andeq	r0, r0, r9, ror #20
 440:	29940005 	ldmibcs	r4, {r0, r2}
 444:	00050000 	andeq	r0, r5, r0
 448:	00002b7a 	andeq	r2, r0, sl, ror fp
 44c:	28fa0005 	ldmcs	sl!, {r0, r2}^
 450:	00050000 	andeq	r0, r5, r0
 454:	00000ce0 	andeq	r0, r0, r0, ror #25
 458:	28440005 	stmdacs	r4, {r0, r2}^
 45c:	00050000 	andeq	r0, r5, r0
 460:	000017cd 	andeq	r1, r0, sp, asr #15
 464:	05920005 	ldreq	r0, [r2, #5]
 468:	00050000 	andeq	r0, r5, r0
 46c:	00001bc7 	andeq	r1, r0, r7, asr #23
 470:	22e90005 	rsccs	r0, r9, #5
 474:	00050000 	andeq	r0, r5, r0
 478:	00001fa7 	andeq	r1, r0, r7, lsr #31
 47c:	2b2c0005 	blcs	b00498 <_exit+0xafffc8>
 480:	00050000 	andeq	r0, r5, r0
 484:	00002af1 			@ <UNDEFINED> instruction: 0x00002af1
 488:	21030005 	tstcs	r3, r5
 48c:	00050000 	andeq	r0, r5, r0
 490:	0000176b 	andeq	r1, r0, fp, ror #14
 494:	2d0f0005 	stccs	0, cr0, [pc, #-20]	@ 488 <main+0x2c>
 498:	00050000 	andeq	r0, r5, r0
 49c:	00001b55 	andeq	r1, r0, r5, asr fp
 4a0:	26e40005 	strbtcs	r0, [r4], r5
 4a4:	00050000 	andeq	r0, r5, r0
 4a8:	00000ed2 			@ <UNDEFINED> instruction: 0x00000ed2
 4ac:	2cc90005 	stclcs	0, cr0, [r9], {5}
 4b0:	00050000 	andeq	r0, r5, r0
 4b4:	00001b7b 	andeq	r1, r0, fp, ror fp
 4b8:	20740005 	rsbscs	r0, r4, r5
 4bc:	00050000 	andeq	r0, r5, r0
 4c0:	00000403 	andeq	r0, r0, r3, lsl #8
 4c4:	01570005 	cmpeq	r7, r5
 4c8:	00050000 	andeq	r0, r5, r0
 4cc:	000013e4 	andeq	r1, r0, r4, ror #7
 4d0:	131d0005 	tstne	sp, #5
 4d4:	00050000 	andeq	r0, r5, r0
 4d8:	00000673 	andeq	r0, r0, r3, ror r6
 4dc:	138b0005 	orrne	r0, fp, #5
 4e0:	00050000 	andeq	r0, r5, r0
 4e4:	000025d6 			@ <UNDEFINED> instruction: 0x000025d6
 4e8:	116e0005 	cmnne	lr, r5
 4ec:	00050000 	andeq	r0, r5, r0
 4f0:	000005a2 	andeq	r0, r0, r2, lsr #11
 4f4:	1e5d0005 	cdpne	0, 5, cr0, cr13, cr5, {0}
 4f8:	00050000 	andeq	r0, r5, r0
 4fc:	000027ec 	andeq	r2, r0, ip, ror #15
 500:	084c0005 	stmdaeq	ip, {r0, r2}^
 504:	00050000 	andeq	r0, r5, r0
 508:	0000238b 	andeq	r2, r0, fp, lsl #7
 50c:	098e0005 	stmibeq	lr, {r0, r2}
 510:	00050000 	andeq	r0, r5, r0
 514:	00000064 	andeq	r0, r0, r4, rrx
 518:	0b230005 	bleq	8c0534 <_exit+0x8c0064>
 51c:	00050000 	andeq	r0, r5, r0
 520:	0000036c 	andeq	r0, r0, ip, ror #6
 524:	061e0005 	ldreq	r0, [lr], -r5
 528:	00050000 	andeq	r0, r5, r0
 52c:	0000074c 	andeq	r0, r0, ip, asr #14
 530:	28a10005 	stmiacs	r1!, {r0, r2}
 534:	00050000 	andeq	r0, r5, r0
 538:	000010ea 	andeq	r1, r0, sl, ror #1
 53c:	009e0005 	addseq	r0, lr, r5
 540:	00050000 	andeq	r0, r5, r0
 544:	00000eff 			@ <UNDEFINED> instruction: 0x00000eff
 548:	13040005 	tstne	r4, #5
 54c:	00050000 	andeq	r0, r5, r0
 550:	00002005 	andeq	r2, r0, r5
 554:	06ed0005 	strbteq	r0, [sp], r5
 558:	00050000 	andeq	r0, r5, r0
 55c:	00000e17 	andeq	r0, r0, r7, lsl lr
 560:	25ee0005 	strbcs	r0, [lr, #5]!
 564:	00050000 	andeq	r0, r5, r0
 568:	000009a5 	andeq	r0, r0, r5, lsr #19
 56c:	13f40005 	mvnsne	r0, #5
 570:	00050000 	andeq	r0, r5, r0
 574:	00000d54 	andeq	r0, r0, r4, asr sp
 578:	15b50005 	ldrne	r0, [r5, #5]!
 57c:	00050000 	andeq	r0, r5, r0
 580:	000021e1 	andeq	r2, r0, r1, ror #3
 584:	16990005 	ldrne	r0, [r9], r5
 588:	00050000 	andeq	r0, r5, r0
 58c:	0000165c 	andeq	r1, r0, ip, asr r6
 590:	1fea0005 	svcne	0x00ea0005
 594:	00050000 	andeq	r0, r5, r0
 598:	00001f38 	andeq	r1, r0, r8, lsr pc
 59c:	00b50005 	adcseq	r0, r5, r5
 5a0:	00050000 	andeq	r0, r5, r0
 5a4:	00002b44 	andeq	r2, r0, r4, asr #22
 5a8:	01cd0005 	biceq	r0, sp, r5
 5ac:	00050000 	andeq	r0, r5, r0
 5b0:	0000246d 	andeq	r2, r0, sp, ror #8
 5b4:	26b40005 	ldrtcs	r0, [r4], r5
 5b8:	00050000 	andeq	r0, r5, r0
 5bc:	00002a23 	andeq	r2, r0, r3, lsr #20
 5c0:	28bb0005 	ldmcs	fp!, {r0, r2}
 5c4:	00050000 	andeq	r0, r5, r0
 5c8:	00000d6d 	andeq	r0, r0, sp, ror #26
 5cc:	14210005 	strtne	r0, [r1], #-5
 5d0:	00050000 	andeq	r0, r5, r0
 5d4:	00000807 	andeq	r0, r0, r7, lsl #16
 5d8:	29f10005 	ldmibcs	r1!, {r0, r2}^
 5dc:	00050000 	andeq	r0, r5, r0
 5e0:	000016fa 			@ <UNDEFINED> instruction: 0x000016fa
 5e4:	1cf10005 	ldclne	0, cr0, [r1], #20
 5e8:	00050000 	andeq	r0, r5, r0
 5ec:	00001d25 	andeq	r1, r0, r5, lsr #26
 5f0:	0f410005 	svceq	0x00410005
 5f4:	00050000 	andeq	r0, r5, r0
 5f8:	00000b83 	andeq	r0, r0, r3, lsl #23
 5fc:	24420005 	strbcs	r0, [r2], #-5
 600:	00050000 	andeq	r0, r5, r0
 604:	00002179 	andeq	r2, r0, r9, ror r1
 608:	274e0005 	strbcs	r0, [lr, -r5]
 60c:	00050000 	andeq	r0, r5, r0
 610:	000002d7 			@ <UNDEFINED> instruction: 0x000002d7
 614:	103d0005 	eorsne	r0, sp, r5
 618:	00050000 	andeq	r0, r5, r0
 61c:	000018eb 	andeq	r1, r0, fp, ror #17
 620:	285b0005 	ldmdacs	fp, {r0, r2}^
 624:	00050000 	andeq	r0, r5, r0
 628:	00000551 	andeq	r0, r0, r1, asr r5
 62c:	0e400005 	cdpeq	0, 4, cr0, cr0, cr5, {0}
 630:	00050000 	andeq	r0, r5, r0
 634:	00001a88 	andeq	r1, r0, r8, lsl #21
 638:	286d0005 	stmdacs	sp!, {r0, r2}^
 63c:	00050000 	andeq	r0, r5, r0
 640:	000011e2 	andeq	r1, r0, r2, ror #3
 644:	00520005 	subseq	r0, r2, r5
 648:	00050000 	andeq	r0, r5, r0
 64c:	00001afc 			@ <UNDEFINED> instruction: 0x00001afc
 650:	0b670005 	bleq	19c066c <_exit+0x19c019c>
 654:	00050000 	andeq	r0, r5, r0
 658:	00001eea 	andeq	r1, r0, sl, ror #29
 65c:	15830005 	strne	r0, [r3, #5]
 660:	00050000 	andeq	r0, r5, r0
 664:	0000068e 	andeq	r0, r0, lr, lsl #13
 668:	1fcc0005 	svcne	0x00cc0005
 66c:	00050000 	andeq	r0, r5, r0
 670:	00002beb 	andeq	r2, r0, fp, ror #23
 674:	0d200005 	stceq	0, cr0, [r0, #-20]!	@ 0xffffffec
 678:	00050000 	andeq	r0, r5, r0
 67c:	000019e0 	andeq	r1, r0, r0, ror #19
 680:	0c460005 	stcleq	0, cr0, [r6], {5}
 684:	00050000 	andeq	r0, r5, r0
 688:	000012ce 	andeq	r1, r0, lr, asr #5
 68c:	23460005 	cmpcs	r6, #5
 690:	00050000 	andeq	r0, r5, r0
 694:	00000c09 	andeq	r0, r0, r9, lsl #24
 698:	14c10005 	strbne	r0, [r1], #5
 69c:	00050000 	andeq	r0, r5, r0
 6a0:	00000295 	muleq	r0, r5, r2
 6a4:	2c870005 	stccs	0, cr0, [r7], {5}
 6a8:	00050000 	andeq	r0, r5, r0
 6ac:	000009e4 	andeq	r0, r0, r4, ror #19
 6b0:	1cc00005 	stclne	0, cr0, [r0], {5}
 6b4:	00050000 	andeq	r0, r5, r0
 6b8:	00001be0 	andeq	r1, r0, r0, ror #23
 6bc:	07380005 	ldreq	r0, [r8, -r5]!
 6c0:	00050000 	andeq	r0, r5, r0
 6c4:	00000cc7 	andeq	r0, r0, r7, asr #25
 6c8:	04520005 	ldrbeq	r0, [r2], #-5
 6cc:	00050000 	andeq	r0, r5, r0
 6d0:	00002ca8 	andeq	r2, r0, r8, lsr #25
 6d4:	0d9f0005 	ldceq	0, cr0, [pc, #20]	@ 6f0 <_exit+0x220>
 6d8:	00050000 	andeq	r0, r5, r0
 6dc:	00000f18 	andeq	r0, r0, r8, lsl pc
 6e0:	23ba0005 			@ <UNDEFINED> instruction: 0x23ba0005
 6e4:	00050000 	andeq	r0, r5, r0
 6e8:	000017a8 	andeq	r1, r0, r8, lsr #15
 6ec:	11200005 			@ <UNDEFINED> instruction: 0x11200005
 6f0:	00050000 	andeq	r0, r5, r0
 6f4:	00002d5b 	andeq	r2, r0, fp, asr sp
 6f8:	13bb0005 			@ <UNDEFINED> instruction: 0x13bb0005
 6fc:	00050000 	andeq	r0, r5, r0
 700:	00002737 	andeq	r2, r0, r7, lsr r7
 704:	0f820005 	svceq	0x00820005
 708:	00050000 	andeq	r0, r5, r0
 70c:	00000aea 	andeq	r0, r0, sl, ror #21
 710:	14790005 	ldrbtne	r0, [r9], #-5
 714:	00050000 	andeq	r0, r5, r0
 718:	00000eb9 			@ <UNDEFINED> instruction: 0x00000eb9
 71c:	1a060005 	bne	180738 <_exit+0x180268>
 720:	00050000 	andeq	r0, r5, r0
 724:	00001c51 	andeq	r1, r0, r1, asr ip
 728:	166e0005 	strbtne	r0, [lr], -r5
 72c:	00050000 	andeq	r0, r5, r0
 730:	0000154a 	andeq	r1, r0, sl, asr #10
 734:	13360005 	teqne	r6, #5
 738:	00050000 	andeq	r0, r5, r0
 73c:	00000cf8 			@ <UNDEFINED> instruction: 0x00000cf8
 740:	23190005 	tstcs	r9, #5
 744:	00050000 	andeq	r0, r5, r0
 748:	00000e9c 	muleq	r0, ip, lr
 74c:	15ff0005 	ldrbne	r0, [pc, #5]!	@ 759 <_exit+0x289>
 750:	00050000 	andeq	r0, r5, r0
 754:	00001016 	andeq	r1, r0, r6, lsl r0
 758:	07a00005 	streq	r0, [r0, r5]!
 75c:	00050000 	andeq	r0, r5, r0
 760:	000018a5 	andeq	r1, r0, r5, lsr #17
 764:	24250005 	strtcs	r0, [r5], #-5
 768:	00050000 	andeq	r0, r5, r0
 76c:	00001abf 			@ <UNDEFINED> instruction: 0x00001abf
 770:	10290005 	eorne	r0, r9, r5
 774:	00050000 	andeq	r0, r5, r0
 778:	000007f0 			@ <UNDEFINED> instruction: 0x000007f0
 77c:	0b3d0005 	bleq	f40798 <_exit+0xf402c8>
 780:	00050000 	andeq	r0, r5, r0
 784:	00000c6d 	andeq	r0, r0, sp, ror #24
 788:	0c590005 	ldcleq	0, cr0, [r9], {5}
 78c:	00050000 	andeq	r0, r5, r0
 790:	000005ca 	andeq	r0, r0, sl, asr #11
 794:	10b40005 	adcsne	r0, r4, r5
 798:	00050000 	andeq	r0, r5, r0
 79c:	0000125b 	andeq	r1, r0, fp, asr r2
 7a0:	128a0005 	addne	r0, sl, #5
 7a4:	00050000 	andeq	r0, r5, r0
 7a8:	0000282f 	andeq	r2, r0, pc, lsr #16
 7ac:	1b310005 	blne	c407c8 <_exit+0xc402f8>
 7b0:	00050000 	andeq	r0, r5, r0
 7b4:	0000090a 	andeq	r0, r0, sl, lsl #18
 7b8:	07c40005 	strbeq	r0, [r4, r5]
 7bc:	00050000 	andeq	r0, r5, r0
 7c0:	00002d3a 	andeq	r2, r0, sl, lsr sp
 7c4:	2a920005 	bcs	fe4807e0 <_exit+0xfe480310>
 7c8:	00050000 	andeq	r0, r5, r0
 7cc:	0000019d 	muleq	r0, sp, r1
 7d0:	21a10005 			@ <UNDEFINED> instruction: 0x21a10005
 7d4:	00050000 	andeq	r0, r5, r0
 7d8:	00001d55 	andeq	r1, r0, r5, asr sp
 7dc:	1fbd0005 	svcne	0x00bd0005
 7e0:	00050000 	andeq	r0, r5, r0
 7e4:	00001e4f 	andeq	r1, r0, pc, asr #28
 7e8:	1db60005 	ldcne	0, cr0, [r6, #20]!
 7ec:	00050000 	andeq	r0, r5, r0
 7f0:	000027ba 			@ <UNDEFINED> instruction: 0x000027ba
 7f4:	20e30005 	rsccs	r0, r3, r5
 7f8:	00050000 	andeq	r0, r5, r0
 7fc:	000017e2 	andeq	r1, r0, r2, ror #15
 800:	1ecc0005 	cdpne	0, 12, cr0, cr12, cr5, {0}
 804:	00050000 	andeq	r0, r5, r0
 808:	0000245e 	andeq	r2, r0, lr, asr r4
 80c:	20f30005 	rscscs	r0, r3, r5
 810:	00050000 	andeq	r0, r5, r0
 814:	000011d3 			@ <UNDEFINED> instruction: 0x000011d3
 818:	24980005 	ldrcs	r0, [r8], #5
 81c:	00050000 	andeq	r0, r5, r0
 820:	00001edb 			@ <UNDEFINED> instruction: 0x00001edb
 824:	16890005 	strne	r0, [r9], r5
 828:	00050000 	andeq	r0, r5, r0
 82c:	000001ab 	andeq	r0, r0, fp, lsr #3
 830:	16d50005 	ldrbne	r0, [r5], r5
 834:	00050000 	andeq	r0, r5, r0
 838:	00001612 	andeq	r1, r0, r2, lsl r6
 83c:	23680005 	cmncs	r8, #5
 840:	00050000 	andeq	r0, r5, r0
 844:	000016b0 			@ <UNDEFINED> instruction: 0x000016b0
 848:	10db0005 	sbcsne	r0, fp, r5
 84c:	00050000 	andeq	r0, r5, r0
 850:	000009d5 			@ <UNDEFINED> instruction: 0x000009d5
 854:	0a9b0005 	beq	fe6c0870 <_exit+0xfe6c03a0>
 858:	00050000 	andeq	r0, r5, r0
 85c:	00001b46 	andeq	r1, r0, r6, asr #22
 860:	00430005 	subeq	r0, r3, r5
 864:	00050000 	andeq	r0, r5, r0
 868:	00002a83 	andeq	r2, r0, r3, lsl #21
 86c:	17f00005 	ldrbne	r0, [r0, r5]!
 870:	00050000 	andeq	r0, r5, r0
 874:	00001dc5 	andeq	r1, r0, r5, asr #27
 878:	14ec0005 	strbtne	r0, [ip], #5
 87c:	00050000 	andeq	r0, r5, r0
 880:	00000f5f 	andeq	r0, r0, pc, asr pc
 884:	0fb50005 	svceq	0x00b50005
 888:	00050000 	andeq	r0, r5, r0
 88c:	00000877 	andeq	r0, r0, r7, ror r8
 890:	04bd0005 	ldrteq	r0, [sp], #5
 894:	00050000 	andeq	r0, r5, r0
 898:	00002bc9 	andeq	r2, r0, r9, asr #23
 89c:	06090005 	streq	r0, [r9], -r5
 8a0:	00050000 	andeq	r0, r5, r0
 8a4:	000024a8 	andeq	r2, r0, r8, lsr #9
 8a8:	11bc0005 			@ <UNDEFINED> instruction: 0x11bc0005
 8ac:	00050000 	andeq	r0, r5, r0
 8b0:	000012be 			@ <UNDEFINED> instruction: 0x000012be
 8b4:	211b0005 	tstcs	fp, r5
 8b8:	00050000 	andeq	r0, r5, r0
 8bc:	00002ad3 			@ <UNDEFINED> instruction: 0x00002ad3
 8c0:	2a4e0005 	bcs	13808dc <_exit+0x138040c>
 8c4:	00050000 	andeq	r0, r5, r0
 8c8:	000024f0 			@ <UNDEFINED> instruction: 0x000024f0
 8cc:	02160005 	andseq	r0, r6, #5
 8d0:	00050000 	andeq	r0, r5, r0
 8d4:	000024ce 	andeq	r2, r0, lr, asr #9
 8d8:	148b0005 	strne	r0, [fp], #5
 8dc:	00050000 	andeq	r0, r5, r0
 8e0:	000003e4 	andeq	r0, r0, r4, ror #7
 8e4:	0e5b0005 	cdpeq	0, 5, cr0, cr11, cr5, {0}
 8e8:	00050000 	andeq	r0, r5, r0
 8ec:	00002c2b 	andeq	r2, r0, fp, lsr #24
 8f0:	261a0005 	ldrcs	r0, [sl], -r5
 8f4:	00050000 	andeq	r0, r5, r0
 8f8:	000000e5 	andeq	r0, r0, r5, ror #1
 8fc:	20500005 	subscs	r0, r0, r5
 900:	00050000 	andeq	r0, r5, r0
 904:	0000047e 	andeq	r0, r0, lr, ror r4
 908:	23ed0005 	mvncs	r0, #5
 90c:	00050000 	andeq	r0, r5, r0
 910:	00001094 	muleq	r0, r4, r0
 914:	18640005 	stmdane	r4!, {r0, r2}^
 918:	00050000 	andeq	r0, r5, r0
 91c:	000025ad 	andeq	r2, r0, sp, lsr #11
 920:	1bf50005 	blne	ffd4093c <_exit+0xffd4046c>
 924:	00050000 	andeq	r0, r5, r0
 928:	00000189 	andeq	r0, r0, r9, lsl #3
 92c:	0f2a0005 	svceq	0x002a0005
 930:	00060000 	andeq	r0, r6, r0
 934:	0000277a 	andeq	r2, r0, sl, ror r7
 938:	0d0d0006 	stceq	0, cr0, [sp, #-24]	@ 0xffffffe8
 93c:	00060000 	andeq	r0, r6, r0
 940:	00001d37 	andeq	r1, r0, r7, lsr sp
 944:	03230006 			@ <UNDEFINED> instruction: 0x03230006
 948:	00060000 	andeq	r0, r6, r0
 94c:	00002232 	andeq	r2, r0, r2, lsr r2
 950:	0b9c0006 	bleq	fe700970 <_exit+0xfe7004a0>
 954:	00060000 	andeq	r0, r6, r0
 958:	00000fc5 	andeq	r0, r0, r5, asr #31
 95c:	08380006 	ldmdaeq	r8!, {r1, r2}
 960:	00060000 	andeq	r0, r6, r0
 964:	00002bb5 			@ <UNDEFINED> instruction: 0x00002bb5
 968:	093c0006 	ldmdbeq	ip!, {r1, r2}
 96c:	00060000 	andeq	r0, r6, r0
 970:	0000027f 	andeq	r0, r0, pc, ror r2
 974:	030f0005 	tsteq	pc, #5
 978:	00060000 	andeq	r0, r6, r0
 97c:	00002b18 	andeq	r2, r0, r8, lsl fp
 980:	08870006 	stmeq	r7, {r1, r2}
 984:	00060000 	andeq	r0, r6, r0
 988:	00001106 	andeq	r1, r0, r6, lsl #2
 98c:	113c0006 	teqne	ip, r6
 990:	00060000 	andeq	r0, r6, r0
 994:	00001c81 	andeq	r1, r0, r1, lsl #25
 998:	095d0006 	ldmdbeq	sp, {r1, r2}^
 99c:	00060000 	andeq	r0, r6, r0
 9a0:	00002cfb 			@ <UNDEFINED> instruction: 0x00002cfb
 9a4:	2bd90006 	blcs	ff6409c4 <_exit+0xff6404f4>
 9a8:	00060000 	andeq	r0, r6, r0
 9ac:	0000071b 	andeq	r0, r0, fp, lsl r7
 9b0:	01420006 	cmpeq	r2, r6
 9b4:	00050000 	andeq	r0, r5, r0
 9b8:	00000aaa 	andeq	r0, r0, sl, lsr #21
 9bc:	02510005 	subseq	r0, r1, #5
 9c0:	00060000 	andeq	r0, r6, r0
 9c4:	00001836 	andeq	r1, r0, r6, lsr r8
 9c8:	17c30005 	strbne	r0, [r3, r5]
 9cc:	00060000 	andeq	r0, r6, r0
 9d0:	000012f9 			@ <UNDEFINED> instruction: 0x000012f9
 9d4:	06a00005 	strteq	r0, [r0], r5
 9d8:	00050000 	andeq	r0, r5, r0
 9dc:	00001c0a 	andeq	r1, r0, sl, lsl #24
 9e0:	29860005 	stmibcs	r6, {r0, r2}
 9e4:	00050000 	andeq	r0, r5, r0
 9e8:	000017ff 			@ <UNDEFINED> instruction: 0x000017ff
 9ec:	206a0006 	rsbcs	r0, sl, r6
 9f0:	00060000 	andeq	r0, r6, r0
 9f4:	00001f9c 	muleq	r0, ip, pc	@ <UNPREDICTABLE>
 9f8:	18490006 	stmdane	r9, {r1, r2}^
 9fc:	00060000 	andeq	r0, r6, r0
 a00:	000015ea 	andeq	r1, r0, sl, ror #11
 a04:	16be0005 	ldrtne	r0, [lr], r5
 a08:	00050000 	andeq	r0, r5, r0
 a0c:	000015de 			@ <UNDEFINED> instruction: 0x000015de
 a10:	25c90005 	strbcs	r0, [r9, #5]
 a14:	00050000 	andeq	r0, r5, r0
 a18:	00002339 	andeq	r2, r0, r9, lsr r3
 a1c:	22290006 	eorcs	r0, r9, #6
 a20:	00060000 	andeq	r0, r6, r0
 a24:	00000268 	andeq	r0, r0, r8, ror #4
 a28:	08ec0006 	stmiaeq	ip!, {r1, r2}^
 a2c:	00060000 	andeq	r0, r6, r0
 a30:	00001e25 	andeq	r1, r0, r5, lsr #28
 a34:	0a360006 	beq	d80a54 <_exit+0xd80584>
 a38:	00060000 	andeq	r0, r6, r0
 a3c:	00000000 	andeq	r0, r0, r0
 a40:	07700006 	ldrbeq	r0, [r0, -r6]!
 a44:	00060000 	andeq	r0, r6, r0
 a48:	00001538 	andeq	r1, r0, r8, lsr r5
 a4c:	017c0006 	cmneq	ip, r6
 a50:	00060000 	andeq	r0, r6, r0
 a54:	00000952 	andeq	r0, r0, r2, asr r9
 a58:	1b110006 	blne	440a78 <_exit+0x4405a8>
 a5c:	00050000 	andeq	r0, r5, r0
 a60:	000013ce 	andeq	r1, r0, lr, asr #7
 a64:	181a0005 	ldmdane	sl, {r0, r2}
 a68:	00050000 	andeq	r0, r5, r0
 a6c:	00001d49 	andeq	r1, r0, r9, asr #26
 a70:	24bf0005 	ldrtcs	r0, [pc], #5	@ a78 <_exit+0x5a8>
 a74:	00060000 	andeq	r0, r6, r0
 a78:	000008c9 	andeq	r0, r0, r9, asr #17
 a7c:	1a720006 	bne	1c80a9c <_exit+0x1c805cc>
 a80:	00060000 	andeq	r0, r6, r0
 a84:	0000150f 	andeq	r1, r0, pc, lsl #10
 a88:	0dcd0006 	stcleq	0, cr0, [sp, #24]
 a8c:	00060000 	andeq	r0, r6, r0
 a90:	000012a9 	andeq	r1, r0, r9, lsr #5
 a94:	14390005 	ldrtne	r0, [r9], #-5
 a98:	00060000 	andeq	r0, r6, r0
 a9c:	00001571 	andeq	r1, r0, r1, ror r5
 aa0:	02380006 	eorseq	r0, r8, #6
 aa4:	00060000 	andeq	r0, r6, r0
 aa8:	000004a3 	andeq	r0, r0, r3, lsr #9
 aac:	1f550006 	svcne	0x00550006
 ab0:	00060000 	andeq	r0, r6, r0
 ab4:	00001dec 	andeq	r1, r0, ip, ror #27
 ab8:	19790006 	ldmdbne	r9!, {r1, r2}^
 abc:	00050000 	andeq	r0, r5, r0
 ac0:	00001a51 	andeq	r1, r0, r1, asr sl
 ac4:	182c0005 	stmdane	ip!, {r0, r2}
 ac8:	00050000 	andeq	r0, r5, r0
 acc:	00000ac6 	andeq	r0, r0, r6, asr #21
	...

Disassembly of section .debug_line:

00000000 <.debug_line>:
   0:	0000006f 	andeq	r0, r0, pc, rrx
   4:	00200003 	eoreq	r0, r0, r3
   8:	01020000 	mrseq	r0, (UNDEF: 2)
   c:	000d0efb 			@ <UNDEFINED> instruction: 0x000d0efb
  10:	01010101 	tsteq	r1, r1, lsl #2
  14:	01000000 	mrseq	r0, (UNDEF: 0)
  18:	00010000 	andeq	r0, r1, r0
  1c:	746e6f63 	strbtvc	r6, [lr], #-3939	@ 0xfffff09d
  20:	2e6c6f72 	mcrcs	15, 3, r6, cr12, cr2, {3}
  24:	00000063 	andeq	r0, r0, r3, rrx
  28:	13050000 	tstne	r5, #0
  2c:	00020500 	andeq	r0, r2, r0, lsl #10
  30:	16000004 	strne	r0, [r0], -r4
  34:	05670a05 	strbeq	r0, [r7, #-2565]!	@ 0xfffff5fb
  38:	0f058302 	svceq	0x00058302
  3c:	4b09054e 	blmi	24157c <_exit+0x2410ac>
  40:	052f0105 	streq	r0, [pc, #-261]!	@ ffffff43 <_exit+0xfffffa73>
  44:	09058410 	stmdbeq	r5, {r4, sl, pc}
  48:	2f01054b 	svccs	0x0001054b
  4c:	05842105 	streq	r2, [r4, #261]	@ 0x105
  50:	0305a304 	tsteq	r5, #4, 6	@ 0x10000000
  54:	4d040567 	stcmi	5, cr0, [r4, #-412]	@ 0xfffffe64
  58:	68670505 	stmdavs	r7!, {r0, r2, r8, sl}^
  5c:	054b0605 	strbeq	r0, [fp, #-1541]	@ 0xfffff9fb
  60:	01058309 	tsteq	r5, r9, lsl #6
  64:	bc13052f 	ldclt	5, cr0, [r3], {47}	@ 0x2f
  68:	05830205 	streq	r0, [r3, #517]	@ 0x205
  6c:	02022f01 	andeq	r2, r2, #1, 30
  70:	Address 0x70 is out of bounds.


Disassembly of section .debug_str:

00000000 <.debug_str>:
       0:	52415f5f 	subpl	r5, r1, #380	@ 0x17c
       4:	45465f4d 	strbmi	r5, [r6, #-3917]	@ 0xfffff0b3
       8:	52555441 	subspl	r5, r5, #1090519040	@ 0x41000000
       c:	50465f45 	subpl	r5, r6, r5, asr #30
      10:	565f3631 			@ <UNDEFINED> instruction: 0x565f3631
      14:	4f544345 	svcmi	0x00544345
      18:	52415f52 	subpl	r5, r1, #328	@ 0x148
      1c:	4d485449 	stclmi	4, cr5, [r8, #-292]	@ 0xfffffedc
      20:	43495445 	cmpmi	r9, #1157627904	@ 0x45000000
      24:	535f5f00 	cmppl	pc, #0, 30
      28:	415f4749 	cmpmi	pc, r9, asr #14
      2c:	494d4f54 	stmdbmi	sp, {r2, r4, r6, r8, r9, sl, fp, lr}^
      30:	414d5f43 	cmpmi	sp, r3, asr #30
      34:	205f5f58 	subscs	r5, pc, r8, asr pc	@ <UNPREDICTABLE>
      38:	66377830 			@ <UNDEFINED> instruction: 0x66377830
      3c:	66666666 	strbtvs	r6, [r6], -r6, ror #12
      40:	5f006666 	svcpl	0x00006666
      44:	5f41545f 	svcpl	0x0041545f
      48:	54494246 	strbpl	r4, [r9], #-582	@ 0xfffffdba
      4c:	36205f5f 			@ <UNDEFINED> instruction: 0x36205f5f
      50:	5f5f0033 	svcpl	0x005f0033
      54:	41524655 	cmpmi	r2, r5, asr r6
      58:	495f5443 	ldmdbmi	pc, {r0, r1, r6, sl, ip, lr}^	@ <UNPREDICTABLE>
      5c:	5f544942 	svcpl	0x00544942
      60:	0030205f 	eorseq	r2, r0, pc, asr r0
      64:	4c465f5f 	stclmi	15, cr5, [r6], {95}	@ 0x5f
      68:	5f323354 	svcpl	0x00323354
      6c:	5f534148 	svcpl	0x00534148
      70:	49464e49 	stmdbmi	r6, {r0, r3, r6, r9, sl, fp, lr}^
      74:	5954494e 	ldmdbpl	r4, {r1, r2, r3, r6, r8, fp, lr}^
      78:	31205f5f 			@ <UNDEFINED> instruction: 0x31205f5f
      7c:	555f5f00 	ldrbpl	r5, [pc, #-3840]	@ fffff184 <_exit+0xffffecb4>
      80:	5f544e49 	svcpl	0x00544e49
      84:	54534146 	ldrbpl	r4, [r3], #-326	@ 0xfffffeba
      88:	59545f38 	ldmdbpl	r4, {r3, r4, r5, r8, r9, sl, fp, ip, lr}^
      8c:	5f5f4550 	svcpl	0x005f4550
      90:	736e7520 	cmnvc	lr, #32, 10	@ 0x8000000
      94:	656e6769 	strbvs	r6, [lr, #-1897]!	@ 0xfffff897
      98:	6e692064 	cdpvs	0, 6, cr2, cr9, cr4, {3}
      9c:	5f5f0074 	svcpl	0x005f0074
      a0:	36544c46 	ldrbcc	r4, [r4], -r6, asr #24
      a4:	414d5f34 	cmpmi	sp, r4, lsr pc
      a8:	58455f58 	stmdapl	r5, {r3, r4, r6, r8, r9, sl, fp, ip, lr}^
      ac:	205f5f50 	subscs	r5, pc, r0, asr pc	@ <UNPREDICTABLE>
      b0:	34323031 	ldrtcc	r3, [r2], #-49	@ 0xffffffcf
      b4:	465f5f00 	ldrbmi	r5, [pc], -r0, lsl #30
      b8:	3233544c 	eorscc	r5, r3, #76, 8	@ 0x4c000000
      bc:	414d5f58 	cmpmi	sp, r8, asr pc
      c0:	58455f58 	stmdapl	r5, {r3, r4, r6, r8, r9, sl, fp, ip, lr}^
      c4:	205f5f50 	subscs	r5, pc, r0, asr pc	@ <UNPREDICTABLE>
      c8:	34323031 	ldrtcc	r3, [r2], #-49	@ 0xffffffcf
      cc:	495f5f00 	ldmdbmi	pc, {r8, r9, sl, fp, ip, lr}^	@ <UNPREDICTABLE>
      d0:	465f544e 	ldrbmi	r5, [pc], -lr, asr #8
      d4:	31545341 	cmpcc	r4, r1, asr #6
      d8:	49575f36 	ldmdbmi	r7, {r1, r2, r4, r5, r8, r9, sl, fp, ip, lr}^
      dc:	5f485444 	svcpl	0x00485444
      e0:	3233205f 	eorscc	r2, r3, #95	@ 0x5f
      e4:	475f5f00 	ldrbmi	r5, [pc, -r0, lsl #30]
      e8:	415f4343 	cmpmi	pc, r3, asr #6
      ec:	494d4f54 	stmdbmi	sp, {r2, r4, r6, r8, r9, sl, fp, lr}^
      f0:	45545f43 	ldrbmi	r5, [r4, #-3907]	@ 0xfffff0bd
      f4:	415f5453 	cmpmi	pc, r3, asr r4	@ <UNPREDICTABLE>
      f8:	535f444e 	cmppl	pc, #1308622848	@ 0x4e000000
      fc:	545f5445 	ldrbpl	r5, [pc], #-1093	@ 104 <_start-0x2fc>
     100:	56455552 			@ <UNDEFINED> instruction: 0x56455552
     104:	31204c41 			@ <UNDEFINED> instruction: 0x31204c41
     108:	666e2f00 	strbtvs	r2, [lr], -r0, lsl #30
     10c:	6f682f73 	svcvs	0x00682f73
     110:	632f656d 			@ <UNDEFINED> instruction: 0x632f656d
     114:	69736d61 	ldmdbvs	r3!, {r0, r5, r6, r8, sl, fp, sp, lr}^
     118:	6f432f34 	svcvs	0x00432f34
     11c:	2f737275 	svccs	0x00737275
     120:	472f324d 	strmi	r3, [pc, -sp, asr #4]!
     124:	2f534143 	svccs	0x00534143
     128:	2f735054 	svccs	0x00735054
     12c:	54454357 	strbpl	r4, [r5], #-855	@ 0xfffffca9
     130:	62616c2f 	rsbvs	r6, r1, #12032	@ 0x2f00
     134:	6b726f77 	blvs	1c9bf18 <_exit+0x1c9ba48>
     138:	6f632f31 	svcvs	0x00632f31
     13c:	6f72746e 	svcvs	0x0072746e
     140:	5f5f006c 	svcpl	0x005f006c
     144:	5f4d5241 	svcpl	0x004d5241
     148:	54414546 	strbpl	r4, [r1], #-1350	@ 0xfffffaba
     14c:	5f455255 	svcpl	0x00455255
     150:	444d4953 	strbmi	r4, [sp], #-2387	@ 0xfffff6ad
     154:	5f003233 	svcpl	0x00003233
     158:	544c465f 	strbpl	r4, [ip], #-1631	@ 0xfffff9a1
     15c:	4d5f3233 	ldclmi	2, cr3, [pc, #-204]	@ 98 <_start-0x368>
     160:	5f544e41 	svcpl	0x00544e41
     164:	5f474944 	svcpl	0x00474944
     168:	3432205f 	ldrtcc	r2, [r2], #-95	@ 0xffffffa1
     16c:	555f5f00 	ldrbpl	r5, [pc, #-3840]	@ fffff274 <_exit+0xffffeda4>
     170:	38544e49 	ldmdacc	r4, {r0, r3, r6, r9, sl, fp, lr}^
     174:	6328435f 			@ <UNDEFINED> instruction: 0x6328435f
     178:	00632029 	rsbeq	r2, r3, r9, lsr #32
     17c:	52415f5f 	subpl	r5, r1, #380	@ 0x17c
     180:	454e5f4d 	strbmi	r5, [lr, #-3917]	@ 0xfffff0b3
     184:	5f5f4e4f 	svcpl	0x005f4e4f
     188:	535f5f00 	cmppl	pc, #0, 30
     18c:	4f455a49 	svcmi	0x00455a49
     190:	49575f46 	ldmdbmi	r7, {r1, r2, r6, r8, r9, sl, fp, ip, lr}^
     194:	545f544e 	ldrbpl	r5, [pc], #-1102	@ 19c <_start-0x264>
     198:	34205f5f 	strtcc	r5, [r0], #-3935	@ 0xfffff0a1
     19c:	515f5f00 	cmppl	pc, r0, lsl #30
     1a0:	42495f51 	submi	r5, r9, #324	@ 0x144
     1a4:	5f5f5449 	svcpl	0x005f5449
     1a8:	5f003020 	svcpl	0x00003020
     1ac:	5144555f 	cmppl	r4, pc, asr r5
     1b0:	4942495f 	stmdbmi	r2, {r0, r1, r2, r3, r4, r6, r8, fp, lr}^
     1b4:	205f5f54 	subscs	r5, pc, r4, asr pc	@ <UNPREDICTABLE>
     1b8:	5f5f0030 	svcpl	0x005f0030
     1bc:	4d4f5441 	stclmi	4, cr5, [pc, #-260]	@ c0 <_start-0x340>
     1c0:	525f4349 	subspl	r4, pc, #603979777	@ 0x24000001
     1c4:	41454c45 	cmpmi	r5, r5, asr #24
     1c8:	33204553 			@ <UNDEFINED> instruction: 0x33204553
     1cc:	465f5f00 	ldrbmi	r5, [pc], -r0, lsl #30
     1d0:	3233544c 	eorscc	r5, r3, #76, 8	@ 0x4c000000
     1d4:	45445f58 	strbmi	r5, [r4, #-3928]	@ 0xfffff0a8
     1d8:	414d4943 	cmpmi	sp, r3, asr #18
     1dc:	49445f4c 	stmdbmi	r4, {r2, r3, r6, r8, r9, sl, fp, ip, lr}^
     1e0:	205f5f47 	subscs	r5, pc, r7, asr #30
     1e4:	5f003731 	svcpl	0x00003731
     1e8:	4c42445f 	stclmi	4, cr4, [r2], {95}	@ 0x5f
     1ec:	4e494d5f 	mcrmi	13, 2, r4, cr9, cr15, {2}
     1f0:	5058455f 	subspl	r4, r8, pc, asr r5
     1f4:	28205f5f 	stmdacs	r0!, {r0, r1, r2, r3, r4, r6, r8, r9, sl, fp, ip, lr}
     1f8:	3230312d 	eorscc	r3, r0, #1073741835	@ 0x4000000b
     1fc:	5f002931 	svcpl	0x00002931
     200:	4e4f4c5f 	mcrmi	12, 2, r4, cr15, cr15, {2}
     204:	4f4c5f47 	svcmi	0x004c5f47
     208:	575f474e 	ldrbpl	r4, [pc, -lr, asr #14]
     20c:	48544449 	ldmdami	r4, {r0, r3, r6, sl, lr}^
     210:	36205f5f 			@ <UNDEFINED> instruction: 0x36205f5f
     214:	5f5f0034 	svcpl	0x005f0034
     218:	5f434347 	svcpl	0x00434347
     21c:	4d4f5441 	stclmi	4, cr5, [pc, #-260]	@ 120 <_start-0x2e0>
     220:	435f4349 	cmpmi	pc, #603979777	@ 0x24000001
     224:	31524148 	cmpcc	r2, r8, asr #2
     228:	5f545f36 	svcpl	0x00545f36
     22c:	4b434f4c 	blmi	10d3f64 <_exit+0x10d3a94>
     230:	4552465f 	ldrbmi	r4, [r2, #-1631]	@ 0xfffff9a1
     234:	00312045 	eorseq	r2, r1, r5, asr #32
     238:	52415f5f 	subpl	r5, r1, #380	@ 0x17c
     23c:	45465f4d 	strbmi	r5, [r6, #-3917]	@ 0xfffff0b3
     240:	52555441 	subspl	r5, r5, #1090519040	@ 0x41000000
     244:	44435f45 	strbmi	r5, [r3], #-3909	@ 0xfffff0bb
     248:	4f435f45 	svcmi	0x00435f45
     24c:	434f5250 	cmpmi	pc, #80, 4
     250:	415f5f00 	cmpmi	pc, r0, lsl #30
     254:	535f4d52 	cmppl	pc, #5248	@ 0x1480
     258:	4f455a49 	svcmi	0x00455a49
     25c:	43575f46 	cmpmi	r7, #280	@ 0x118
     260:	5f524148 	svcpl	0x00524148
     264:	00342054 	eorseq	r2, r4, r4, asr r0
     268:	52415f5f 	subpl	r5, r1, #380	@ 0x17c
     26c:	50465f4d 	subpl	r5, r6, sp, asr #30
     270:	465f3631 			@ <UNDEFINED> instruction: 0x465f3631
     274:	414d524f 	cmpmi	sp, pc, asr #4
     278:	45495f54 	strbmi	r5, [r9, #-3924]	@ 0xfffff0ac
     27c:	5f004545 	svcpl	0x00004545
     280:	4d52415f 	ldclmi	1, cr4, [r2, #-380]	@ 0xfffffe84
     284:	4145465f 	cmpmi	r5, pc, asr r6
     288:	45525554 	ldrbmi	r5, [r2, #-1364]	@ 0xfffffaac
     28c:	4d4f435f 	stclmi	3, cr4, [pc, #-380]	@ 118 <_start-0x2e8>
     290:	58454c50 	stmdapl	r5, {r4, r6, sl, fp, lr}^
     294:	4c5f5f00 	ldclmi	15, cr5, [pc], {-0}
     298:	4152464c 	cmpmi	r2, ip, asr #12
     29c:	495f5443 	ldmdbmi	pc, {r0, r1, r6, sl, ip, lr}^	@ <UNPREDICTABLE>
     2a0:	5f544942 	svcpl	0x00544942
     2a4:	0030205f 	eorseq	r2, r0, pc, asr r0
     2a8:	42445f5f 	submi	r5, r4, #380	@ 0x17c
     2ac:	414d5f4c 	cmpmi	sp, ip, asr #30
     2b0:	205f5f58 	subscs	r5, pc, r8, asr pc	@ <UNPREDICTABLE>
     2b4:	6f642828 	svcvs	0x00642828
     2b8:	656c6275 	strbvs	r6, [ip, #-629]!	@ 0xfffffd8b
     2bc:	372e3129 	strcc	r3, [lr, -r9, lsr #2]!
     2c0:	39363739 	ldmdbcc	r6!, {r0, r3, r4, r5, r8, r9, sl, ip, sp}
     2c4:	34333133 	ldrtcc	r3, [r3], #-307	@ 0xfffffecd
     2c8:	33323638 	teqcc	r2, #56, 12	@ 0x3800000
     2cc:	65373531 	ldrvs	r3, [r7, #-1329]!	@ 0xfffffacf
     2d0:	3830332b 	ldmdacc	r0!, {r0, r1, r3, r5, r8, r9, ip, sp}
     2d4:	5f00294c 	svcpl	0x0000294c
     2d8:	4653555f 			@ <UNDEFINED> instruction: 0x4653555f
     2dc:	54434152 	strbpl	r4, [r3], #-338	@ 0xfffffeae
     2e0:	4e494d5f 	mcrmi	13, 2, r4, cr9, cr15, {2}
     2e4:	30205f5f 	eorcc	r5, r0, pc, asr pc
     2e8:	4855302e 	ldmdami	r5, {r1, r2, r3, r5, ip, sp}^
     2ec:	5f5f0052 	svcpl	0x005f0052
     2f0:	544e4957 	strbpl	r4, [lr], #-2391	@ 0xfffff6a9
     2f4:	4e494d5f 	mcrmi	13, 2, r4, cr9, cr15, {2}
     2f8:	30205f5f 	eorcc	r5, r0, pc, asr pc
     2fc:	5f5f0055 	svcpl	0x005f0055
     300:	43554e47 	cmpmi	r5, #1136	@ 0x470
     304:	4e494d5f 	mcrmi	13, 2, r4, cr9, cr15, {2}
     308:	5f5f524f 	svcpl	0x005f524f
     30c:	5f003220 	svcpl	0x00003220
     310:	4d52415f 	ldclmi	1, cr4, [r2, #-380]	@ 0xfffffe84
     314:	4232335f 	eorsmi	r3, r2, #2080374785	@ 0x7c000001
     318:	535f5449 	cmppl	pc, #1224736768	@ 0x49000000
     31c:	45544154 	ldrbmi	r4, [r4, #-340]	@ 0xfffffeac
     320:	5f003120 	svcpl	0x00003120
     324:	4d52415f 	ldclmi	1, cr4, [r2, #-380]	@ 0xfffffe84
     328:	4145465f 	cmpmi	r5, pc, asr r6
     32c:	45525554 	ldrbmi	r5, [r2, #-1364]	@ 0xfffffaac
     330:	5952435f 	ldmdbpl	r2, {r0, r1, r2, r3, r4, r6, r8, r9, lr}^
     334:	004f5450 	subeq	r5, pc, r0, asr r4	@ <UNPREDICTABLE>
     338:	42445f5f 	submi	r5, r4, #380	@ 0x17c
     33c:	4f4e5f4c 	svcmi	0x004e5f4c
     340:	4d5f4d52 	ldclmi	13, cr4, [pc, #-328]	@ 200 <_start-0x200>
     344:	5f5f5841 	svcpl	0x005f5841
     348:	64282820 	strtvs	r2, [r8], #-2080	@ 0xfffff7e0
     34c:	6c62756f 	stclvs	5, cr7, [r2], #-444	@ 0xfffffe44
     350:	2e312965 			@ <UNDEFINED> instruction: 0x2e312965
     354:	36373937 			@ <UNDEFINED> instruction: 0x36373937
     358:	33313339 	teqcc	r1, #-469762048	@ 0xe4000000
     35c:	32363834 	eorscc	r3, r6, #52, 16	@ 0x340000
     360:	37353133 			@ <UNDEFINED> instruction: 0x37353133
     364:	30332b65 	eorscc	r2, r3, r5, ror #22
     368:	00294c38 	eoreq	r4, r9, r8, lsr ip
     36c:	4c465f5f 	stclmi	15, cr5, [r6], {95}	@ 0x5f
     370:	5f323354 	svcpl	0x00323354
     374:	495f5349 	ldmdbmi	pc, {r0, r3, r6, r8, r9, ip, lr}^	@ <UNPREDICTABLE>
     378:	365f4345 	ldrbcc	r4, [pc], -r5, asr #6
     37c:	39353530 	ldmdbcc	r5!, {r4, r5, r8, sl, ip, sp}
     380:	31205f5f 			@ <UNDEFINED> instruction: 0x31205f5f
     384:	555f5f00 	ldrbpl	r5, [pc, #-3840]	@ fffff48c <_exit+0xffffefbc>
     388:	31544e49 	cmpcc	r4, r9, asr #28
     38c:	28435f36 	stmdacs	r3, {r1, r2, r4, r5, r8, r9, sl, fp, ip, lr}^
     390:	63202963 			@ <UNDEFINED> instruction: 0x63202963
     394:	535f5f00 	cmppl	pc, #0, 30
     398:	4f455a49 	svcmi	0x00455a49
     39c:	48535f46 	ldmdami	r3, {r1, r2, r6, r8, r9, sl, fp, ip, lr}^
     3a0:	5f54524f 	svcpl	0x0054524f
     3a4:	0032205f 	eorseq	r2, r2, pc, asr r0
     3a8:	48435f5f 	stmdami	r3, {r0, r1, r2, r3, r4, r6, r8, r9, sl, fp, ip, lr}^
     3ac:	36315241 	ldrtcc	r5, [r1], -r1, asr #4
     3b0:	5059545f 	subspl	r5, r9, pc, asr r4
     3b4:	205f5f45 	subscs	r5, pc, r5, asr #30
     3b8:	726f6873 	rsbvc	r6, pc, #7536640	@ 0x730000
     3bc:	6e752074 	mrcvs	0, 3, r2, cr5, cr4, {3}
     3c0:	6e676973 			@ <UNDEFINED> instruction: 0x6e676973
     3c4:	69206465 	stmdbvs	r0!, {r0, r2, r5, r6, sl, sp, lr}
     3c8:	5f00746e 	svcpl	0x0000746e
     3cc:	5a49535f 	bpl	1255150 <_exit+0x1254c80>
     3d0:	5f464f45 	svcpl	0x00464f45
     3d4:	474e4f4c 	strbmi	r4, [lr, -ip, asr #30]
     3d8:	554f445f 	strbpl	r4, [pc, #-1119]	@ ffffff81 <_exit+0xfffffab1>
     3dc:	5f454c42 	svcpl	0x00454c42
     3e0:	0038205f 	eorseq	r2, r8, pc, asr r0
     3e4:	43475f5f 	cmpmi	r7, #380	@ 0x17c
     3e8:	54415f43 	strbpl	r5, [r1], #-3907	@ 0xfffff0bd
     3ec:	43494d4f 	cmpmi	r9, #5056	@ 0x13c0
     3f0:	4f48535f 	svcmi	0x0048535f
     3f4:	4c5f5452 	ldclmi	4, cr5, [pc], {82}	@ 0x52
     3f8:	5f4b434f 	svcpl	0x004b434f
     3fc:	45455246 	strbmi	r5, [r5, #-582]	@ 0xfffffdba
     400:	5f003120 	svcpl	0x00003120
     404:	42444c5f 	submi	r4, r4, #24320	@ 0x5f00
     408:	53495f4c 	cmppl	r9, #76, 30	@ 0x130
     40c:	4345495f 	cmpmi	r5, #1556480	@ 0x17c000
     410:	3530365f 	ldrcc	r3, [r0, #-1631]!	@ 0xfffff9a1
     414:	5f5f3935 	svcpl	0x005f3935
     418:	5f003120 	svcpl	0x00003120
     41c:	544e495f 	strbpl	r4, [lr], #-2399	@ 0xfffff6a1
     420:	5341465f 	cmppl	r1, #99614720	@ 0x5f00000
     424:	4d5f3854 	ldclmi	8, cr3, [pc, #-336]	@ 2dc <_start-0x124>
     428:	5f5f5841 	svcpl	0x005f5841
     42c:	37783020 	ldrbcc	r3, [r8, -r0, lsr #32]!
     430:	66666666 	strbtvs	r6, [r6], -r6, ror #12
     434:	00666666 	rsbeq	r6, r6, r6, ror #12
     438:	524f5f5f 	subpl	r5, pc, #380	@ 0x17c
     43c:	5f524544 	svcpl	0x00524544
     440:	5f474942 	svcpl	0x00474942
     444:	49444e45 	stmdbmi	r4, {r0, r2, r6, r9, sl, fp, lr}^
     448:	5f5f4e41 	svcpl	0x005f4e41
     44c:	32333420 	eorscc	r3, r3, #32, 8	@ 0x20000000
     450:	5f5f0031 	svcpl	0x005f0031
     454:	464c4c55 			@ <UNDEFINED> instruction: 0x464c4c55
     458:	54434152 	strbpl	r4, [r3], #-338	@ 0xfffffeae
     45c:	58414d5f 	stmdapl	r1, {r0, r1, r2, r3, r4, r6, r8, sl, fp, lr}^
     460:	30205f5f 	eorcc	r5, r0, pc, asr pc
     464:	46464658 			@ <UNDEFINED> instruction: 0x46464658
     468:	46464646 	strbmi	r4, [r6], -r6, asr #12
     46c:	46464646 	strbmi	r4, [r6], -r6, asr #12
     470:	46464646 	strbmi	r4, [r6], -r6, asr #12
     474:	362d5046 	strtcc	r5, [sp], -r6, asr #32
     478:	4c4c5534 	stclmi	5, cr5, [ip], {52}	@ 0x34
     47c:	5f5f0052 	svcpl	0x005f0052
     480:	5f434347 	svcpl	0x00434347
     484:	534e4f43 	cmppl	lr, #268	@ 0x10c
     488:	43555254 	cmpmi	r5, #84, 4	@ 0x40000005
     48c:	45564954 	ldrbmi	r4, [r6, #-2388]	@ 0xfffff6ac
     490:	5a49535f 	bpl	1255214 <_exit+0x1254d44>
     494:	34362045 	ldrtcc	r2, [r6], #-69	@ 0xffffffbb
     498:	6e6f6300 	cdpvs	3, 6, cr6, cr15, cr0, {0}
     49c:	6c6f7274 	stclvs	2, cr7, [pc], #-464	@ 2d4 <_start-0x12c>
     4a0:	5f00632e 	svcpl	0x0000632e
     4a4:	4d52415f 	ldclmi	1, cr4, [r2, #-380]	@ 0xfffffe84
     4a8:	4145465f 	cmpmi	r5, pc, asr r6
     4ac:	45525554 	ldrbmi	r5, [r2, #-1364]	@ 0xfffffaac
     4b0:	54414d5f 	strbpl	r4, [r1], #-3423	@ 0xfffff2a1
     4b4:	5f4c554d 	svcpl	0x004c554d
     4b8:	38544e49 	ldmdacc	r4, {r0, r3, r6, r9, sl, fp, lr}^
     4bc:	555f5f00 	ldrbpl	r5, [pc, #-3840]	@ fffff5c4 <_exit+0xfffff0f4>
     4c0:	465f4154 			@ <UNDEFINED> instruction: 0x465f4154
     4c4:	5f544942 	svcpl	0x00544942
     4c8:	3436205f 	ldrtcc	r2, [r6], #-95	@ 0xffffffa1
     4cc:	445f5f00 	ldrbmi	r5, [pc], #-3840	@ 4d4 <_exit+0x4>
     4d0:	4d5f4c42 	ldclmi	12, cr4, [pc, #-264]	@ 3d0 <_start-0x30>
     4d4:	5f544e41 	svcpl	0x00544e41
     4d8:	5f474944 	svcpl	0x00474944
     4dc:	3335205f 	teqcc	r5, #95	@ 0x5f
     4e0:	555f5f00 	ldrbpl	r5, [pc, #-3840]	@ fffff5e8 <_exit+0xfffff118>
     4e4:	5f544e49 	svcpl	0x00544e49
     4e8:	5341454c 	cmppl	r1, #76, 10	@ 0x13000000
     4ec:	5f343654 	svcpl	0x00343654
     4f0:	45505954 	ldrbmi	r5, [r0, #-2388]	@ 0xfffff6ac
     4f4:	6c205f5f 	stcvs	15, cr5, [r0], #-380	@ 0xfffffe84
     4f8:	20676e6f 	rsbcs	r6, r7, pc, ror #28
     4fc:	676e6f6c 	strbvs	r6, [lr, -ip, ror #30]!
     500:	736e7520 	cmnvc	lr, #32, 10	@ 0x8000000
     504:	656e6769 	strbvs	r6, [lr, #-1897]!	@ 0xfffff897
     508:	6e692064 	cdpvs	0, 6, cr2, cr9, cr4, {3}
     50c:	5f5f0074 	svcpl	0x005f0074
     510:	5f544e49 	svcpl	0x00544e49
     514:	5f58414d 	svcpl	0x0058414d
     518:	7830205f 	ldmdavc	r0!, {r0, r1, r2, r3, r4, r6, sp}
     51c:	66666637 			@ <UNDEFINED> instruction: 0x66666637
     520:	66666666 	strbtvs	r6, [r6], -r6, ror #12
     524:	465f5f00 	ldrbmi	r5, [pc], -r0, lsl #30
     528:	495f544c 	ldmdbmi	pc, {r2, r3, r6, sl, ip, lr}^	@ <UNPREDICTABLE>
     52c:	45495f53 	strbmi	r5, [r9, #-3923]	@ 0xfffff0ad
     530:	30365f43 	eorscc	r5, r6, r3, asr #30
     534:	5f393535 	svcpl	0x00393535
     538:	0031205f 	eorseq	r2, r1, pc, asr r0
     53c:	54505f5f 	ldrbpl	r5, [r0], #-3935	@ 0xfffff0a1
     540:	46494452 			@ <UNDEFINED> instruction: 0x46494452
     544:	59545f46 	ldmdbpl	r4, {r1, r2, r6, r8, r9, sl, fp, ip, lr}^
     548:	5f5f4550 	svcpl	0x005f4550
     54c:	746e6920 	strbtvc	r6, [lr], #-2336	@ 0xfffff6e0
     550:	465f5f00 	ldrbmi	r5, [pc], -r0, lsl #30
     554:	54434152 	strbpl	r4, [r3], #-338	@ 0xfffffeae
     558:	4942495f 	stmdbmi	r2, {r0, r1, r2, r3, r4, r6, r8, fp, lr}^
     55c:	205f5f54 	subscs	r5, pc, r4, asr pc	@ <UNPREDICTABLE>
     560:	5f5f0030 	svcpl	0x005f0030
     564:	31544e49 	cmpcc	r4, r9, asr #28
     568:	59545f36 	ldmdbpl	r4, {r1, r2, r4, r5, r8, r9, sl, fp, ip, lr}^
     56c:	5f5f4550 	svcpl	0x005f4550
     570:	6f687320 	svcvs	0x00687320
     574:	69207472 	stmdbvs	r0!, {r1, r4, r5, r6, sl, ip, sp, lr}
     578:	5f00746e 	svcpl	0x0000746e
     57c:	5858475f 	ldmdapl	r8, {r0, r1, r2, r3, r4, r6, r8, r9, sl, lr}^
     580:	4942415f 	stmdbmi	r2, {r0, r1, r2, r3, r4, r6, r8, lr}^
     584:	5245565f 	subpl	r5, r5, #99614720	@ 0x5f00000
     588:	4e4f4953 			@ <UNDEFINED> instruction: 0x4e4f4953
     58c:	32303120 	eorscc	r3, r0, #32, 2
     590:	5f5f0030 	svcpl	0x005f0030
     594:	4c42444c 	stclmi	4, cr4, [r2], {76}	@ 0x4c
     598:	4749445f 			@ <UNDEFINED> instruction: 0x4749445f
     59c:	31205f5f 			@ <UNDEFINED> instruction: 0x31205f5f
     5a0:	5f5f0035 	svcpl	0x005f0035
     5a4:	33544c46 	cmpcc	r4, #17920	@ 0x4600
     5a8:	414d5f32 	cmpmi	sp, r2, lsr pc
     5ac:	205f5f58 	subscs	r5, pc, r8, asr pc	@ <UNPREDICTABLE>
     5b0:	30342e33 	eorscc	r2, r4, r3, lsr lr
     5b4:	33323832 	teqcc	r2, #3276800	@ 0x320000
     5b8:	33363634 	teqcc	r6, #52, 12	@ 0x3400000
     5bc:	38323538 	ldmdacc	r2!, {r3, r4, r5, r8, sl, ip, sp}
     5c0:	2b653638 	blcs	194dea8 <_exit+0x194d9d8>
     5c4:	33463833 	cmpcc	r6, #3342336	@ 0x330000
     5c8:	5f5f0032 	svcpl	0x005f0032
     5cc:	43414c4c 	cmpmi	r1, #76, 24	@ 0x4c00
     5d0:	5f4d5543 	svcpl	0x004d5543
     5d4:	54494249 	strbpl	r4, [r9], #-585	@ 0xfffffdb7
     5d8:	33205f5f 			@ <UNDEFINED> instruction: 0x33205f5f
     5dc:	5f5f0032 	svcpl	0x005f0032
     5e0:	4d4f5441 	stclmi	4, cr5, [pc, #-260]	@ 4e4 <_exit+0x14>
     5e4:	535f4349 	cmppl	pc, #603979777	@ 0x24000001
     5e8:	435f5145 	cmpmi	pc, #1073741841	@ 0x40000011
     5ec:	35205453 	strcc	r5, [r0, #-1107]!	@ 0xfffffbad
     5f0:	495f5f00 	ldmdbmi	pc, {r8, r9, sl, fp, ip, lr}^	@ <UNPREDICTABLE>
     5f4:	4c5f544e 	ldclmi	4, cr5, [pc], {78}	@ 0x4e
     5f8:	54534145 	ldrbpl	r4, [r3], #-325	@ 0xfffffebb
     5fc:	414d5f38 	cmpmi	sp, r8, lsr pc
     600:	205f5f58 	subscs	r5, pc, r8, asr pc	@ <UNPREDICTABLE>
     604:	66377830 			@ <UNDEFINED> instruction: 0x66377830
     608:	525f5f00 	subspl	r5, pc, #0, 30
     60c:	53494745 	cmppl	r9, #18087936	@ 0x1140000
     610:	5f524554 	svcpl	0x00524554
     614:	46455250 			@ <UNDEFINED> instruction: 0x46455250
     618:	5f5f5849 	svcpl	0x005f5849
     61c:	5f5f0020 	svcpl	0x005f0020
     620:	36544c46 	ldrbcc	r4, [r4], -r6, asr #24
     624:	414d5f34 	cmpmi	sp, r4, lsr pc
     628:	445f544e 	ldrbmi	r5, [pc], #-1102	@ 630 <_exit+0x160>
     62c:	5f5f4749 	svcpl	0x005f4749
     630:	00333520 	eorseq	r3, r3, r0, lsr #10
     634:	49555f5f 	ldmdbmi	r5, {r0, r1, r2, r3, r4, r6, r8, r9, sl, fp, ip, lr}^
     638:	414d544e 	cmpmi	sp, lr, asr #8
     63c:	28435f58 	stmdacs	r3, {r3, r4, r6, r8, r9, sl, fp, ip, lr}^
     640:	63202963 			@ <UNDEFINED> instruction: 0x63202963
     644:	20232320 	eorcs	r2, r3, r0, lsr #6
     648:	004c4c55 	subeq	r4, ip, r5, asr ip
     64c:	59425f5f 	stmdbpl	r2, {r0, r1, r2, r3, r4, r6, r8, r9, sl, fp, ip, lr}^
     650:	4f5f4554 	svcmi	0x005f4554
     654:	52454452 	subpl	r4, r5, #1375731712	@ 0x52000000
     658:	5f205f5f 	svcpl	0x00205f5f
     65c:	44524f5f 	ldrbmi	r4, [r2], #-3935	@ 0xfffff0a1
     660:	4c5f5245 	ldclmi	2, cr5, [pc], {69}	@ 0x45
     664:	4c545449 	ldclmi	4, cr5, [r4], {73}	@ 0x49
     668:	4e455f45 	cdpmi	15, 4, cr5, cr5, cr5, {2}
     66c:	4e414944 			@ <UNDEFINED> instruction: 0x4e414944
     670:	5f005f5f 	svcpl	0x00005f5f
     674:	544c465f 	strbpl	r4, [ip], #-1631	@ 0xfffff9a1
     678:	4d5f3233 	ldclmi	2, cr3, [pc, #-204]	@ 5b4 <_exit+0xe4>
     67c:	315f4e49 	cmpcc	pc, r9, asr #28
     680:	58455f30 	stmdapl	r5, {r4, r5, r8, r9, sl, fp, ip, lr}^
     684:	205f5f50 	subscs	r5, pc, r0, asr pc	@ <UNPREDICTABLE>
     688:	37332d28 	ldrcc	r2, [r3, -r8, lsr #26]!
     68c:	5f5f0029 	svcpl	0x005f0029
     690:	4152464c 	cmpmi	r2, ip, asr #12
     694:	495f5443 	ldmdbmi	pc, {r0, r1, r6, sl, ip, lr}^	@ <UNPREDICTABLE>
     698:	5f544942 	svcpl	0x00544942
     69c:	0030205f 	eorseq	r2, r0, pc, asr r0
     6a0:	52415f5f 	subpl	r5, r1, #380	@ 0x17c
     6a4:	52415f4d 	subpl	r5, r1, #308	@ 0x134
     6a8:	34204843 	strtcc	r4, [r0], #-2115	@ 0xfffff7bd
     6ac:	535f5f00 	cmppl	pc, #0, 30
     6b0:	5f434454 	svcpl	0x00434454
     6b4:	5f465455 	svcpl	0x00465455
     6b8:	5f5f3233 	svcpl	0x005f3233
     6bc:	5f003120 	svcpl	0x00003120
     6c0:	544e495f 	strbpl	r4, [lr], #-2399	@ 0xfffff6a1
     6c4:	41454c5f 	cmpmi	r5, pc, asr ip
     6c8:	36315453 			@ <UNDEFINED> instruction: 0x36315453
     6cc:	58414d5f 	stmdapl	r1, {r0, r1, r2, r3, r4, r6, r8, sl, fp, lr}^
     6d0:	30205f5f 	eorcc	r5, r0, pc, asr pc
     6d4:	66663778 			@ <UNDEFINED> instruction: 0x66663778
     6d8:	5f5f0066 	svcpl	0x005f0066
     6dc:	41484353 	cmpmi	r8, r3, asr r3
     6e0:	414d5f52 	cmpmi	sp, r2, asr pc
     6e4:	205f5f58 	subscs	r5, pc, r8, asr pc	@ <UNPREDICTABLE>
     6e8:	66377830 			@ <UNDEFINED> instruction: 0x66377830
     6ec:	465f5f00 	ldrbmi	r5, [pc], -r0, lsl #30
     6f0:	3436544c 	ldrtcc	r5, [r6], #-1100	@ 0xfffffbb4
     6f4:	524f4e5f 	subpl	r4, pc, #1520	@ 0x5f0
     6f8:	414d5f4d 	cmpmi	sp, sp, asr #30
     6fc:	205f5f58 	subscs	r5, pc, r8, asr pc	@ <UNPREDICTABLE>
     700:	39372e31 	ldmdbcc	r7!, {r0, r4, r5, r9, sl, fp, sp}
     704:	33393637 	teqcc	r9, #57671680	@ 0x3700000
     708:	38343331 	ldmdacc	r4!, {r0, r4, r5, r8, r9, ip, sp}
     70c:	31333236 	teqcc	r3, r6, lsr r2
     710:	2b653735 	blcs	194e3ec <_exit+0x194df1c>
     714:	46383033 			@ <UNDEFINED> instruction: 0x46383033
     718:	5f003436 	svcpl	0x00003436
     71c:	4d52415f 	ldclmi	1, cr4, [r2, #-380]	@ 0xfffffe84
     720:	4145465f 	cmpmi	r5, pc, asr r6
     724:	45525554 	ldrbmi	r5, [r2, #-1364]	@ 0xfffffaac
     728:	4d554e5f 	ldclmi	14, cr4, [r5, #-380]	@ 0xfffffe84
     72c:	43495245 	cmpmi	r9, #1342177284	@ 0x50000004
     730:	58414d5f 	stmdapl	r1, {r0, r1, r2, r3, r4, r6, r8, sl, fp, lr}^
     734:	004e494d 	subeq	r4, lr, sp, asr #18
     738:	4c555f5f 	ldclmi	15, cr5, [r5], {95}	@ 0x5f
     73c:	4152464c 	cmpmi	r2, ip, asr #12
     740:	495f5443 	ldmdbmi	pc, {r0, r1, r6, sl, ip, lr}^	@ <UNPREDICTABLE>
     744:	5f544942 	svcpl	0x00544942
     748:	0030205f 	eorseq	r2, r0, pc, asr r0
     74c:	4c465f5f 	stclmi	15, cr5, [r6], {95}	@ 0x5f
     750:	5f343654 	svcpl	0x00343654
     754:	5f474944 	svcpl	0x00474944
     758:	3531205f 	ldrcc	r2, [r1, #-95]!	@ 0xffffffa1
     75c:	415f5f00 	cmpmi	pc, r0, lsl #30
     760:	494d4f54 	stmdbmi	sp, {r2, r4, r6, r8, r9, sl, fp, lr}^
     764:	45525f43 	ldrbmi	r5, [r2, #-3907]	@ 0xfffff0bd
     768:	4558414c 	ldrbmi	r4, [r8, #-332]	@ 0xfffffeb4
     76c:	00302044 	eorseq	r2, r0, r4, asr #32
     770:	52415f5f 	subpl	r5, r1, #380	@ 0x17c
     774:	45465f4d 	strbmi	r5, [r6, #-3917]	@ 0xfffff0b3
     778:	52555441 	subspl	r5, r5, #1090519040	@ 0x41000000
     77c:	50465f45 	subpl	r5, r6, r5, asr #30
     780:	465f3631 			@ <UNDEFINED> instruction: 0x465f3631
     784:	5f004c4d 	svcpl	0x00004c4d
     788:	5a49535f 	bpl	125550c <_exit+0x125503c>
     78c:	414d5f45 	cmpmi	sp, r5, asr #30
     790:	205f5f58 	subscs	r5, pc, r8, asr pc	@ <UNPREDICTABLE>
     794:	66667830 			@ <UNDEFINED> instruction: 0x66667830
     798:	66666666 	strbtvs	r6, [r6], -r6, ror #12
     79c:	00556666 	subseq	r6, r5, r6, ror #12
     7a0:	414c5f5f 	cmpmi	ip, pc, asr pc
     7a4:	4d554343 	ldclmi	3, cr4, [r5, #-268]	@ 0xfffffef4
     7a8:	4e494d5f 	mcrmi	13, 2, r4, cr9, cr15, {2}
     7ac:	28205f5f 	stmdacs	r0!, {r0, r1, r2, r3, r4, r6, r8, r9, sl, fp, ip, lr}
     7b0:	3158302d 	cmpcc	r8, sp, lsr #32
     7b4:	4c313350 	ldcmi	3, cr3, [r1], #-320	@ 0xfffffec0
     7b8:	58302d4b 	ldmdapl	r0!, {r0, r1, r3, r6, r8, sl, fp, sp}
     7bc:	31335031 	teqcc	r3, r1, lsr r0
     7c0:	00294b4c 	eoreq	r4, r9, ip, asr #22
     7c4:	4c555f5f 	ldclmi	15, cr5, [r5], {95}	@ 0x5f
     7c8:	4343414c 	cmpmi	r3, #76, 2
     7cc:	4d5f4d55 	ldclmi	13, cr4, [pc, #-340]	@ 680 <_exit+0x1b0>
     7d0:	5f5f5841 	svcpl	0x005f5841
     7d4:	46583020 	ldrbmi	r3, [r8], -r0, lsr #32
     7d8:	46464646 	strbmi	r4, [r6], -r6, asr #12
     7dc:	46464646 	strbmi	r4, [r6], -r6, asr #12
     7e0:	46464646 	strbmi	r4, [r6], -r6, asr #12
     7e4:	50464646 	subpl	r4, r6, r6, asr #12
     7e8:	5532332d 	ldrpl	r3, [r2, #-813]!	@ 0xfffffcd3
     7ec:	004b4c4c 	subeq	r4, fp, ip, asr #24
     7f0:	4c555f5f 	ldclmi	15, cr5, [r5], {95}	@ 0x5f
     7f4:	55434341 	strbpl	r4, [r3, #-833]	@ 0xfffffcbf
     7f8:	494d5f4d 	stmdbmi	sp, {r0, r2, r3, r6, r8, r9, sl, fp, ip, lr}^
     7fc:	205f5f4e 	subscs	r5, pc, lr, asr #30
     800:	55302e30 	ldrpl	r2, [r0, #-3632]!	@ 0xfffff1d0
     804:	5f004b4c 	svcpl	0x00004b4c
     808:	544c465f 	strbpl	r4, [ip], #-1631	@ 0xfffff9a1
     80c:	5f583233 	svcpl	0x00583233
     810:	5f534148 	svcpl	0x00534148
     814:	49464e49 	stmdbmi	r6, {r0, r3, r6, r9, sl, fp, lr}^
     818:	5954494e 	ldmdbpl	r4, {r1, r2, r3, r6, r8, fp, lr}^
     81c:	31205f5f 			@ <UNDEFINED> instruction: 0x31205f5f
     820:	465f5f00 	ldrbmi	r5, [pc], -r0, lsl #30
     824:	485f544c 	ldmdami	pc, {r2, r3, r6, sl, ip, lr}^	@ <UNPREDICTABLE>
     828:	495f5341 	ldmdbmi	pc, {r0, r6, r8, r9, ip, lr}^	@ <UNPREDICTABLE>
     82c:	4e49464e 	cdpmi	6, 4, cr4, cr9, cr14, {2}
     830:	5f595449 	svcpl	0x00595449
     834:	0031205f 	eorseq	r2, r1, pc, asr r0
     838:	52415f5f 	subpl	r5, r1, #380	@ 0x17c
     83c:	45465f4d 	strbmi	r5, [r6, #-3917]	@ 0xfffff0b3
     840:	52555441 	subspl	r5, r5, #1090519040	@ 0x41000000
     844:	52515f45 	subspl	r5, r1, #276	@ 0x114
     848:	00584d44 	subseq	r4, r8, r4, asr #26
     84c:	4c465f5f 	stclmi	15, cr5, [r6], {95}	@ 0x5f
     850:	5f323354 	svcpl	0x00323354
     854:	49535045 	ldmdbmi	r3, {r0, r2, r6, ip, lr}^
     858:	5f4e4f4c 	svcpl	0x004e4f4c
     85c:	2e31205f 	mrccs	0, 1, r2, cr1, cr15, {2}
     860:	30323931 	eorscc	r3, r2, r1, lsr r9
     864:	39383239 	ldmdbcc	r8!, {r0, r3, r4, r5, r9, ip, sp}
     868:	37303535 			@ <UNDEFINED> instruction: 0x37303535
     86c:	35323138 	ldrcc	r3, [r2, #-312]!	@ 0xfffffec8
     870:	46372d65 	ldrtmi	r2, [r7], -r5, ror #26
     874:	5f003233 	svcpl	0x00003233
     878:	4144555f 	cmpmi	r4, pc, asr r5
     87c:	4942495f 	stmdbmi	r2, {r0, r1, r2, r3, r4, r6, r8, fp, lr}^
     880:	205f5f54 	subscs	r5, pc, r4, asr pc	@ <UNPREDICTABLE>
     884:	5f003233 	svcpl	0x00003233
     888:	4d52415f 	ldclmi	1, cr4, [r2, #-380]	@ 0xfffffe84
     88c:	4145465f 	cmpmi	r5, pc, asr r6
     890:	45525554 	ldrbmi	r5, [r2, #-1364]	@ 0xfffffaac
     894:	4954425f 	ldmdbmi	r4, {r0, r1, r2, r3, r4, r6, r9, lr}^
     898:	495f5f00 	ldmdbmi	pc, {r8, r9, sl, fp, ip, lr}^	@ <UNPREDICTABLE>
     89c:	465f544e 	ldrbmi	r5, [pc], -lr, asr #8
     8a0:	36545341 	ldrbcc	r5, [r4], -r1, asr #6
     8a4:	59545f34 	ldmdbpl	r4, {r2, r4, r5, r8, r9, sl, fp, ip, lr}^
     8a8:	5f5f4550 	svcpl	0x005f4550
     8ac:	6e6f6c20 	cdpvs	12, 6, cr6, cr15, cr0, {1}
     8b0:	6f6c2067 	svcvs	0x006c2067
     8b4:	6920676e 	stmdbvs	r0!, {r1, r2, r3, r5, r6, r8, r9, sl, sp, lr}
     8b8:	5f00746e 	svcpl	0x0000746e
     8bc:	544e495f 	strbpl	r4, [lr], #-2399	@ 0xfffff6a1
     8c0:	28435f38 	stmdacs	r3, {r3, r4, r5, r8, r9, sl, fp, ip, lr}^
     8c4:	63202963 			@ <UNDEFINED> instruction: 0x63202963
     8c8:	465f5f00 	ldrbmi	r5, [pc], -r0, lsl #30
     8cc:	43495044 	cmpmi	r9, #68	@ 0x44
     8d0:	5f005f5f 	svcpl	0x00005f5f
     8d4:	544e495f 	strbpl	r4, [lr], #-2399	@ 0xfffff6a1
     8d8:	41454c5f 	cmpmi	r5, pc, asr ip
     8dc:	36315453 			@ <UNDEFINED> instruction: 0x36315453
     8e0:	4449575f 	strbmi	r5, [r9], #-1887	@ 0xfffff8a1
     8e4:	5f5f4854 	svcpl	0x005f4854
     8e8:	00363120 	eorseq	r3, r6, r0, lsr #2
     8ec:	52415f5f 	subpl	r5, r1, #380	@ 0x17c
     8f0:	50465f4d 	subpl	r5, r6, sp, asr #30
     8f4:	465f3631 			@ <UNDEFINED> instruction: 0x465f3631
     8f8:	414d524f 	cmpmi	sp, pc, asr #4
     8fc:	4c415f54 	stclmi	15, cr5, [r1], {84}	@ 0x54
     900:	4e524554 	mrcmi	5, 2, r4, cr2, cr4, {2}
     904:	56495441 	strbpl	r5, [r9], -r1, asr #8
     908:	5f5f0045 	svcpl	0x005f0045
     90c:	414c4c55 	cmpmi	ip, r5, asr ip
     910:	4d554343 	ldclmi	3, cr4, [r5, #-268]	@ 0xfffffef4
     914:	4e494d5f 	mcrmi	13, 2, r4, cr9, cr15, {2}
     918:	30205f5f 	eorcc	r5, r0, pc, asr pc
     91c:	4c55302e 	ldclmi	0, cr3, [r5], {46}	@ 0x2e
     920:	5f004b4c 	svcpl	0x00004b4c
     924:	4454535f 	ldrbmi	r5, [r4], #-863	@ 0xfffffca1
     928:	45565f43 	ldrbmi	r5, [r6, #-3907]	@ 0xfffff0bd
     92c:	4f495352 	svcmi	0x00495352
     930:	205f5f4e 	subscs	r5, pc, lr, asr #30
     934:	33323032 	teqcc	r2, #50	@ 0x32
     938:	004c3131 	subeq	r3, ip, r1, lsr r1
     93c:	52415f5f 	subpl	r5, r1, #380	@ 0x17c
     940:	45465f4d 	strbmi	r5, [r6, #-3917]	@ 0xfffff0b3
     944:	52555441 	subspl	r5, r5, #1090519040	@ 0x41000000
     948:	4f445f45 	svcmi	0x00445f45
     94c:	4f525054 	svcmi	0x00525054
     950:	5f5f0044 	svcpl	0x005f0044
     954:	5f4d5241 	svcpl	0x004d5241
     958:	4e4f454e 	cdpmi	5, 4, cr4, cr15, cr14, {2}
     95c:	415f5f00 	cmpmi	pc, r0, lsl #30
     960:	465f4d52 			@ <UNDEFINED> instruction: 0x465f4d52
     964:	55544145 	ldrbpl	r4, [r4, #-325]	@ 0xfffffebb
     968:	435f4552 	cmpmi	pc, #343932928	@ 0x14800000
     96c:	0045534d 	subeq	r5, r5, sp, asr #6
     970:	49555f5f 	ldmdbmi	r5, {r0, r1, r2, r3, r4, r6, r8, r9, sl, fp, ip, lr}^
     974:	5450544e 	ldrbpl	r5, [r0], #-1102	@ 0xfffffbb2
     978:	59545f52 	ldmdbpl	r4, {r1, r4, r6, r8, r9, sl, fp, ip, lr}^
     97c:	5f5f4550 	svcpl	0x005f4550
     980:	736e7520 	cmnvc	lr, #32, 10	@ 0x8000000
     984:	656e6769 	strbvs	r6, [lr, #-1897]!	@ 0xfffff897
     988:	6e692064 	cdpvs	0, 6, cr2, cr9, cr4, {3}
     98c:	5f5f0074 	svcpl	0x005f0074
     990:	33544c46 	cmpcc	r4, #17920	@ 0x4600
     994:	41485f32 	cmpmi	r8, r2, lsr pc
     998:	45445f53 	strbmi	r5, [r4, #-3923]	@ 0xfffff0ad
     99c:	4d524f4e 	ldclmi	15, cr4, [r2, #-312]	@ 0xfffffec8
     9a0:	31205f5f 			@ <UNDEFINED> instruction: 0x31205f5f
     9a4:	465f5f00 	ldrbmi	r5, [pc], -r0, lsl #30
     9a8:	3436544c 	ldrtcc	r5, [r6], #-1100	@ 0xfffffbb4
     9ac:	4e45445f 	mcrmi	4, 2, r4, cr5, cr15, {2}
     9b0:	5f4d524f 	svcpl	0x004d524f
     9b4:	5f4e494d 	svcpl	0x004e494d
     9b8:	2e34205f 	mrccs	0, 1, r2, cr4, cr15, {2}
     9bc:	36303439 			@ <UNDEFINED> instruction: 0x36303439
     9c0:	35343635 	ldrcc	r3, [r4, #-1589]!	@ 0xfffff9cb
     9c4:	32313438 	eorscc	r3, r1, #56, 8	@ 0x38000000
     9c8:	34353634 	ldrtcc	r3, [r5], #-1588	@ 0xfffff9cc
     9cc:	32332d65 	eorscc	r2, r3, #6464	@ 0x1940
     9d0:	34364634 	ldrtcc	r4, [r6], #-1588	@ 0xfffff9cc
     9d4:	535f5f00 	cmppl	pc, #0, 30
     9d8:	42495f41 	submi	r5, r9, #260	@ 0x104
     9dc:	5f5f5449 	svcpl	0x005f5449
     9e0:	00363120 	eorseq	r3, r6, r0, lsr #2
     9e4:	4c4c5f5f 	stclmi	15, cr5, [ip], {95}	@ 0x5f
     9e8:	43415246 	cmpmi	r1, #1610612740	@ 0x60000004
     9ec:	414d5f54 	cmpmi	sp, r4, asr pc
     9f0:	205f5f58 	subscs	r5, pc, r8, asr pc	@ <UNPREDICTABLE>
     9f4:	46375830 			@ <UNDEFINED> instruction: 0x46375830
     9f8:	46464646 	strbmi	r4, [r6], -r6, asr #12
     9fc:	46464646 	strbmi	r4, [r6], -r6, asr #12
     a00:	46464646 	strbmi	r4, [r6], -r6, asr #12
     a04:	2d504646 	ldclcs	6, cr4, [r0, #-280]	@ 0xfffffee8
     a08:	4c4c3336 	stclmi	3, cr3, [ip], {54}	@ 0x36
     a0c:	5f5f0052 	svcpl	0x005f0052
     a10:	5f544e49 	svcpl	0x00544e49
     a14:	54534146 	ldrbpl	r4, [r3], #-326	@ 0xfffffeba
     a18:	4d5f3436 	ldclmi	4, cr3, [pc, #-216]	@ 948 <_exit+0x478>
     a1c:	5f5f5841 	svcpl	0x005f5841
     a20:	37783020 	ldrbcc	r3, [r8, -r0, lsr #32]!
     a24:	66666666 	strbtvs	r6, [r6], -r6, ror #12
     a28:	66666666 	strbtvs	r6, [r6], -r6, ror #12
     a2c:	66666666 	strbtvs	r6, [r6], -r6, ror #12
     a30:	4c666666 	stclmi	6, cr6, [r6], #-408	@ 0xfffffe68
     a34:	5f5f004c 	svcpl	0x005f004c
     a38:	5f4d5241 	svcpl	0x004d5241
     a3c:	54414546 	strbpl	r4, [r1], #-1350	@ 0xfffffaba
     a40:	5f455255 	svcpl	0x00455255
     a44:	36315046 	ldrtcc	r5, [r1], -r6, asr #32
     a48:	4143535f 	cmpmi	r3, pc, asr r3
     a4c:	5f52414c 	svcpl	0x0052414c
     a50:	54495241 	strbpl	r5, [r9], #-577	@ 0xfffffdbf
     a54:	54454d48 	strbpl	r4, [r5], #-3400	@ 0xfffff2b8
     a58:	5f004349 	svcpl	0x00004349
     a5c:	544c465f 	strbpl	r4, [ip], #-1631	@ 0xfffff9a1
     a60:	4749445f 			@ <UNDEFINED> instruction: 0x4749445f
     a64:	36205f5f 			@ <UNDEFINED> instruction: 0x36205f5f
     a68:	445f5f00 	ldrbmi	r5, [pc], #-3840	@ a70 <_exit+0x5a0>
     a6c:	455f4c42 	ldrbmi	r4, [pc, #-3138]	@ fffffe32 <_exit+0xfffff962>
     a70:	4c495350 	stclmi	3, cr5, [r9], {80}	@ 0x50
     a74:	5f5f4e4f 	svcpl	0x005f4e4f
     a78:	64282820 	strtvs	r2, [r8], #-2080	@ 0xfffff7e0
     a7c:	6c62756f 	stclvs	5, cr7, [r2], #-444	@ 0xfffffe44
     a80:	2e322965 			@ <UNDEFINED> instruction: 0x2e322965
     a84:	34303232 	ldrtcc	r3, [r0], #-562	@ 0xfffffdce
     a88:	34303634 	ldrtcc	r3, [r0], #-1588	@ 0xfffff9cc
     a8c:	30353239 	eorscc	r3, r5, r9, lsr r2
     a90:	31333133 	teqcc	r3, r3, lsr r1
     a94:	36312d65 	ldrtcc	r2, [r1], -r5, ror #26
     a98:	5f00294c 	svcpl	0x0000294c
     a9c:	5f41445f 	svcpl	0x0041445f
     aa0:	54494246 	strbpl	r4, [r9], #-582	@ 0xfffffdba
     aa4:	33205f5f 			@ <UNDEFINED> instruction: 0x33205f5f
     aa8:	5f5f0031 	svcpl	0x005f0031
     aac:	5f4d5241 	svcpl	0x004d5241
     ab0:	455a4953 	ldrbmi	r4, [sl, #-2387]	@ 0xfffff6ad
     ab4:	4d5f464f 	ldclmi	6, cr4, [pc, #-316]	@ 980 <_exit+0x4b0>
     ab8:	4d494e49 	stclmi	14, cr4, [r9, #-292]	@ 0xfffffedc
     abc:	455f4c41 	ldrbmi	r4, [pc, #-3137]	@ fffffe83 <_exit+0xfffff9b3>
     ac0:	204d554e 	subcs	r5, sp, lr, asr #10
     ac4:	5f5f0031 	svcpl	0x005f0031
     ac8:	53455355 	cmppl	r5, #1409286145	@ 0x54000001
     acc:	494e495f 	stmdbmi	lr, {r0, r1, r2, r3, r4, r6, r8, fp, lr}^
     ad0:	4e494654 	mcrmi	6, 2, r4, cr9, cr4, {2}
     ad4:	205f5f49 	subscs	r5, pc, r9, asr #30
     ad8:	5f5f0031 	svcpl	0x005f0031
     adc:	5f434347 	svcpl	0x00434347
     ae0:	5f434549 	svcpl	0x00434549
     ae4:	20393535 	eorscs	r3, r9, r5, lsr r5
     ae8:	5f5f0030 	svcpl	0x005f0030
     aec:	43415355 	cmpmi	r1, #1409286145	@ 0x54000001
     af0:	5f4d5543 	svcpl	0x004d5543
     af4:	49535045 	ldmdbmi	r3, {r0, r2, r6, ip, lr}^
     af8:	5f4e4f4c 	svcpl	0x004e4f4c
     afc:	7830205f 	ldmdavc	r0!, {r0, r1, r2, r3, r4, r6, sp}
     b00:	382d5031 	stmdacc	sp!, {r0, r4, r5, ip, lr}
     b04:	004b4855 	subeq	r4, fp, r5, asr r8
     b08:	54505f5f 	ldrbpl	r5, [r0], #-3935	@ 0xfffff0a1
     b0c:	46494452 			@ <UNDEFINED> instruction: 0x46494452
     b10:	414d5f46 	cmpmi	sp, r6, asr #30
     b14:	205f5f58 	subscs	r5, pc, r8, asr pc	@ <UNPREDICTABLE>
     b18:	66377830 			@ <UNDEFINED> instruction: 0x66377830
     b1c:	66666666 	strbtvs	r6, [r6], -r6, ror #12
     b20:	5f006666 	svcpl	0x00006666
     b24:	544c465f 	strbpl	r4, [ip], #-1631	@ 0xfffff9a1
     b28:	485f3233 	ldmdami	pc, {r0, r1, r4, r5, r9, ip, sp}^	@ <UNPREDICTABLE>
     b2c:	515f5341 	cmppl	pc, r1, asr #6
     b30:	54454955 	strbpl	r4, [r5], #-2389	@ 0xfffff6ab
     b34:	4e414e5f 	mcrmi	14, 2, r4, cr1, cr15, {2}
     b38:	31205f5f 			@ <UNDEFINED> instruction: 0x31205f5f
     b3c:	555f5f00 	ldrbpl	r5, [pc, #-3840]	@ fffffc44 <_exit+0xfffff774>
     b40:	4343414c 	cmpmi	r3, #76, 2
     b44:	4d5f4d55 	ldclmi	13, cr4, [pc, #-340]	@ 9f8 <_exit+0x528>
     b48:	5f5f5841 	svcpl	0x005f5841
     b4c:	46583020 	ldrbmi	r3, [r8], -r0, lsr #32
     b50:	46464646 	strbmi	r4, [r6], -r6, asr #12
     b54:	46464646 	strbmi	r4, [r6], -r6, asr #12
     b58:	46464646 	strbmi	r4, [r6], -r6, asr #12
     b5c:	50464646 	subpl	r4, r6, r6, asr #12
     b60:	5532332d 	ldrpl	r3, [r2, #-813]!	@ 0xfffffcd3
     b64:	5f004b4c 	svcpl	0x00004b4c
     b68:	5246555f 	subpl	r5, r6, #398458880	@ 0x17c00000
     b6c:	5f544341 	svcpl	0x00544341
     b70:	5f58414d 	svcpl	0x0058414d
     b74:	5830205f 	ldmdapl	r0!, {r0, r1, r2, r3, r4, r6, sp}
     b78:	46464646 	strbmi	r4, [r6], -r6, asr #12
     b7c:	36312d50 			@ <UNDEFINED> instruction: 0x36312d50
     b80:	5f005255 	svcpl	0x00005255
     b84:	5246535f 	subpl	r5, r6, #2080374785	@ 0x7c000001
     b88:	5f544341 	svcpl	0x00544341
     b8c:	5f58414d 	svcpl	0x0058414d
     b90:	5830205f 	ldmdapl	r0!, {r0, r1, r2, r3, r4, r6, sp}
     b94:	2d504637 	ldclcs	6, cr4, [r0, #-220]	@ 0xffffff24
     b98:	00524837 	subseq	r4, r2, r7, lsr r8
     b9c:	52415f5f 	subpl	r5, r1, #380	@ 0x17c
     ba0:	45465f4d 	strbmi	r5, [r6, #-3917]	@ 0xfffff0b3
     ba4:	52555441 	subspl	r5, r5, #1090519040	@ 0x41000000
     ba8:	48535f45 	ldmdami	r3, {r0, r2, r6, r8, r9, sl, fp, ip, lr}^
     bac:	5f003241 	svcpl	0x00003241
     bb0:	554e475f 	strbpl	r4, [lr, #-1887]	@ 0xfffff8a1
     bb4:	205f5f43 	subscs	r5, pc, r3, asr #30
     bb8:	5f003531 	svcpl	0x00003531
     bbc:	4e49555f 	mcrmi	5, 2, r5, cr9, cr15, {2}
     bc0:	454c5f54 	strbmi	r5, [ip, #-3924]	@ 0xfffff0ac
     bc4:	38545341 	ldmdacc	r4, {r0, r6, r8, r9, ip, lr}^
     bc8:	58414d5f 	stmdapl	r1, {r0, r1, r2, r3, r4, r6, r8, sl, fp, lr}^
     bcc:	30205f5f 	eorcc	r5, r0, pc, asr pc
     bd0:	00666678 	rsbeq	r6, r6, r8, ror r6
     bd4:	4e495f5f 	mcrmi	15, 2, r5, cr9, cr15, {2}
     bd8:	5f343654 	svcpl	0x00343654
     bdc:	5f58414d 	svcpl	0x0058414d
     be0:	7830205f 	ldmdavc	r0!, {r0, r1, r2, r3, r4, r6, sp}
     be4:	66666637 			@ <UNDEFINED> instruction: 0x66666637
     be8:	66666666 	strbtvs	r6, [r6], -r6, ror #12
     bec:	66666666 	strbtvs	r6, [r6], -r6, ror #12
     bf0:	66666666 	strbtvs	r6, [r6], -r6, ror #12
     bf4:	5f004c4c 	svcpl	0x00004c4c
     bf8:	544e495f 	strbpl	r4, [lr], #-2399	@ 0xfffff6a1
     bfc:	414d5f38 	cmpmi	sp, r8, lsr pc
     c00:	205f5f58 	subscs	r5, pc, r8, asr pc	@ <UNPREDICTABLE>
     c04:	66377830 			@ <UNDEFINED> instruction: 0x66377830
     c08:	555f5f00 	ldrbpl	r5, [pc, #-3840]	@ fffffd10 <_exit+0xfffff840>
     c0c:	4152464c 	cmpmi	r2, ip, asr #12
     c10:	455f5443 	ldrbmi	r5, [pc, #-1091]	@ 7d5 <_exit+0x305>
     c14:	4c495350 	stclmi	3, cr5, [r9], {80}	@ 0x50
     c18:	5f5f4e4f 	svcpl	0x005f4e4f
     c1c:	31783020 	cmncc	r8, r0, lsr #32
     c20:	32332d50 	eorscc	r2, r3, #80, 26	@ 0x1400
     c24:	00524c55 	subseq	r4, r2, r5, asr ip
     c28:	4e495f5f 	mcrmi	15, 2, r5, cr9, cr15, {2}
     c2c:	454c5f54 	strbmi	r5, [ip, #-3924]	@ 0xfffff0ac
     c30:	33545341 	cmpcc	r4, #67108865	@ 0x4000001
     c34:	59545f32 	ldmdbpl	r4, {r1, r4, r5, r8, r9, sl, fp, ip, lr}^
     c38:	5f5f4550 	svcpl	0x005f4550
     c3c:	6e6f6c20 	cdpvs	12, 6, cr6, cr15, cr0, {1}
     c40:	6e692067 	cdpvs	0, 6, cr2, cr9, cr7, {3}
     c44:	5f5f0074 	svcpl	0x005f0074
     c48:	52464c55 	subpl	r4, r6, #21760	@ 0x5500
     c4c:	5f544341 	svcpl	0x00544341
     c50:	54494249 	strbpl	r4, [r9], #-585	@ 0xfffffdb7
     c54:	30205f5f 	eorcc	r5, r0, pc, asr pc
     c58:	4c5f5f00 	ldclmi	15, cr5, [pc], {-0}
     c5c:	4343414c 	cmpmi	r3, #76, 2
     c60:	465f4d55 			@ <UNDEFINED> instruction: 0x465f4d55
     c64:	5f544942 	svcpl	0x00544942
     c68:	3133205f 	teqcc	r3, pc, asr r0
     c6c:	555f5f00 	ldrbpl	r5, [pc, #-3840]	@ fffffd74 <_exit+0xfffff8a4>
     c70:	4343414c 	cmpmi	r3, #76, 2
     c74:	455f4d55 	ldrbmi	r4, [pc, #-3413]	@ ffffff27 <_exit+0xfffffa57>
     c78:	4c495350 	stclmi	3, cr5, [r9], {80}	@ 0x50
     c7c:	5f5f4e4f 	svcpl	0x005f4e4f
     c80:	31783020 	cmncc	r8, r0, lsr #32
     c84:	32332d50 	eorscc	r2, r3, #80, 26	@ 0x1400
     c88:	004b4c55 	subeq	r4, fp, r5, asr ip
     c8c:	49555f5f 	ldmdbmi	r5, {r0, r1, r2, r3, r4, r6, r8, r9, sl, fp, ip, lr}^
     c90:	4c5f544e 	ldclmi	4, cr5, [pc], {78}	@ 0x4e
     c94:	54534145 	ldrbpl	r4, [r3], #-325	@ 0xfffffebb
     c98:	4d5f3436 	ldclmi	4, cr3, [pc, #-216]	@ bc8 <_exit+0x6f8>
     c9c:	5f5f5841 	svcpl	0x005f5841
     ca0:	66783020 	ldrbtvs	r3, [r8], -r0, lsr #32
     ca4:	66666666 	strbtvs	r6, [r6], -r6, ror #12
     ca8:	66666666 	strbtvs	r6, [r6], -r6, ror #12
     cac:	66666666 	strbtvs	r6, [r6], -r6, ror #12
     cb0:	55666666 	strbpl	r6, [r6, #-1638]!	@ 0xfffff99a
     cb4:	5f004c4c 	svcpl	0x00004c4c
     cb8:	544c465f 	strbpl	r4, [ip], #-1631	@ 0xfffff9a1
     cbc:	4441525f 	strbmi	r5, [r1], #-607	@ 0xfffffda1
     cc0:	5f5f5849 	svcpl	0x005f5849
     cc4:	5f003220 	svcpl	0x00003220
     cc8:	4c4c555f 	stclmi	5, cr5, [ip], {95}	@ 0x5f
     ccc:	43415246 	cmpmi	r1, #1610612740	@ 0x60000004
     cd0:	494d5f54 	stmdbmi	sp, {r2, r4, r6, r8, r9, sl, fp, ip, lr}^
     cd4:	205f5f4e 	subscs	r5, pc, lr, asr #30
     cd8:	55302e30 	ldrpl	r2, [r0, #-3632]!	@ 0xfffff1d0
     cdc:	00524c4c 	subseq	r4, r2, ip, asr #24
     ce0:	42445f5f 	submi	r5, r4, #380	@ 0x17c
     ce4:	41485f4c 	cmpmi	r8, ip, asr #30
     ce8:	55515f53 	ldrbpl	r5, [r1, #-3923]	@ 0xfffff0ad
     cec:	5f544549 	svcpl	0x00544549
     cf0:	5f4e414e 	svcpl	0x004e414e
     cf4:	0031205f 	eorseq	r2, r1, pc, asr r0
     cf8:	41555f5f 	cmpmi	r5, pc, asr pc
     cfc:	4d554343 	ldclmi	3, cr4, [r5, #-268]	@ 0xfffffef4
     d00:	4e494d5f 	mcrmi	13, 2, r4, cr9, cr15, {2}
     d04:	30205f5f 	eorcc	r5, r0, pc, asr pc
     d08:	4b55302e 	blmi	154cdc8 <_exit+0x154c8f8>
     d0c:	415f5f00 	cmpmi	pc, r0, lsl #30
     d10:	465f4d52 			@ <UNDEFINED> instruction: 0x465f4d52
     d14:	55544145 	ldrbpl	r4, [r4, #-325]	@ 0xfffffebb
     d18:	515f4552 	cmppl	pc, r2, asr r5	@ <UNPREDICTABLE>
     d1c:	00544942 	subseq	r4, r4, r2, asr #18
     d20:	464c5f5f 			@ <UNDEFINED> instruction: 0x464c5f5f
     d24:	54434152 	strbpl	r4, [r3], #-338	@ 0xfffffeae
     d28:	5350455f 	cmppl	r0, #398458880	@ 0x17c00000
     d2c:	4e4f4c49 	cdpmi	12, 4, cr4, cr15, cr9, {2}
     d30:	30205f5f 	eorcc	r5, r0, pc, asr pc
     d34:	2d503178 	ldclcs	1, cr3, [r0, #-480]	@ 0xfffffe20
     d38:	524c3133 	subpl	r3, ip, #-1073741812	@ 0xc000000c
     d3c:	495f5f00 	ldmdbmi	pc, {r8, r9, sl, fp, ip, lr}^	@ <UNPREDICTABLE>
     d40:	465f544e 	ldrbmi	r5, [pc], -lr, asr #8
     d44:	38545341 	ldmdacc	r4, {r0, r6, r8, r9, ip, lr}^
     d48:	5059545f 	subspl	r5, r9, pc, asr r4
     d4c:	205f5f45 	subscs	r5, pc, r5, asr #30
     d50:	00746e69 	rsbseq	r6, r4, r9, ror #28
     d54:	4c465f5f 	stclmi	15, cr5, [r6], {95}	@ 0x5f
     d58:	5f343654 	svcpl	0x00343654
     d5c:	5f534148 	svcpl	0x00534148
     d60:	49464e49 	stmdbmi	r6, {r0, r3, r6, r9, sl, fp, lr}^
     d64:	5954494e 	ldmdbpl	r4, {r1, r2, r3, r6, r8, fp, lr}^
     d68:	31205f5f 			@ <UNDEFINED> instruction: 0x31205f5f
     d6c:	465f5f00 	ldrbmi	r5, [pc], -r0, lsl #30
     d70:	3233544c 	eorscc	r5, r3, #76, 8	@ 0x4c000000
     d74:	45445f58 	strbmi	r5, [r4, #-3928]	@ 0xfffff0a8
     d78:	4d524f4e 	ldclmi	15, cr4, [r2, #-312]	@ 0xfffffec8
     d7c:	4e494d5f 	mcrmi	13, 2, r4, cr9, cr15, {2}
     d80:	34205f5f 	strtcc	r5, [r0], #-3935	@ 0xfffff0a1
     d84:	3034392e 	eorscc	r3, r4, lr, lsr #18
     d88:	34363536 	ldrtcc	r3, [r6], #-1334	@ 0xfffffaca
     d8c:	31343835 	teqcc	r4, r5, lsr r8
     d90:	35363432 	ldrcc	r3, [r6, #-1074]!	@ 0xfffffbce
     d94:	332d6534 			@ <UNDEFINED> instruction: 0x332d6534
     d98:	33463432 	cmpcc	r6, #838860800	@ 0x32000000
     d9c:	5f007832 	svcpl	0x00007832
     da0:	4341535f 	cmpmi	r1, #2080374785	@ 0x7c000001
     da4:	5f4d5543 	svcpl	0x004d5543
     da8:	54494246 	strbpl	r4, [r9], #-582	@ 0xfffffdba
     dac:	37205f5f 			@ <UNDEFINED> instruction: 0x37205f5f
     db0:	575f5f00 	ldrbpl	r5, [pc, -r0, lsl #30]
     db4:	52414843 	subpl	r4, r1, #4390912	@ 0x430000
     db8:	5059545f 	subspl	r5, r9, pc, asr r4
     dbc:	205f5f45 	subscs	r5, pc, r5, asr #30
     dc0:	69736e75 	ldmdbvs	r3!, {r0, r2, r4, r5, r6, r9, sl, fp, sp, lr}^
     dc4:	64656e67 	strbtvs	r6, [r5], #-3687	@ 0xfffff199
     dc8:	746e6920 	strbtvc	r6, [lr], #-2336	@ 0xfffff6e0
     dcc:	415f5f00 	cmpmi	pc, r0, lsl #30
     dd0:	415f4d52 	cmpmi	pc, r2, asr sp	@ <UNPREDICTABLE>
     dd4:	535f4d53 	cmppl	pc, #5312	@ 0x14c0
     dd8:	41544e59 	cmpmi	r4, r9, asr lr
     ddc:	4e555f58 	mrcmi	15, 2, r5, cr5, cr8, {2}
     de0:	45494649 	strbmi	r4, [r9, #-1609]	@ 0xfffff9b7
     de4:	005f5f44 	subseq	r5, pc, r4, asr #30
     de8:	42445f5f 	submi	r5, r4, #380	@ 0x17c
     dec:	494d5f4c 	stmdbmi	sp, {r2, r3, r6, r8, r9, sl, fp, ip, lr}^
     df0:	205f5f4e 	subscs	r5, pc, lr, asr #30
     df4:	6f642828 	svcvs	0x00642828
     df8:	656c6275 	strbvs	r6, [ip, #-629]!	@ 0xfffffd8b
     dfc:	322e3229 	eorcc	r3, lr, #-1879048190	@ 0x90000002
     e00:	37303532 			@ <UNDEFINED> instruction: 0x37303532
     e04:	38353833 	ldmdacc	r5!, {r0, r1, r4, r5, fp, ip, sp}
     e08:	32373035 	eorscc	r3, r7, #53	@ 0x35
     e0c:	65343130 	ldrvs	r3, [r4, #-304]!	@ 0xfffffed0
     e10:	3830332d 	ldmdacc	r0!, {r0, r2, r3, r5, r8, r9, ip, sp}
     e14:	5f00294c 	svcpl	0x0000294c
     e18:	544c465f 	strbpl	r4, [ip], #-1631	@ 0xfffff9a1
     e1c:	4d5f3436 	ldclmi	4, cr3, [pc, #-216]	@ d4c <_exit+0x87c>
     e20:	5f5f4e49 	svcpl	0x005f4e49
     e24:	322e3220 	eorcc	r3, lr, #32, 4
     e28:	37303532 			@ <UNDEFINED> instruction: 0x37303532
     e2c:	38353833 	ldmdacc	r5!, {r0, r1, r4, r5, fp, ip, sp}
     e30:	32373035 	eorscc	r3, r7, #53	@ 0x35
     e34:	65343130 	ldrvs	r3, [r4, #-304]!	@ 0xfffffed0
     e38:	3830332d 	ldmdacc	r0!, {r0, r2, r3, r5, r8, r9, ip, sp}
     e3c:	00343646 	eorseq	r3, r4, r6, asr #12
     e40:	52465f5f 	subpl	r5, r6, #380	@ 0x17c
     e44:	5f544341 	svcpl	0x00544341
     e48:	5f4e494d 	svcpl	0x004e494d
     e4c:	2d28205f 	stccs	0, cr2, [r8, #-380]!	@ 0xfffffe84
     e50:	52352e30 	eorspl	r2, r5, #48, 28	@ 0x300
     e54:	352e302d 	strcc	r3, [lr, #-45]!	@ 0xffffffd3
     e58:	5f002952 	svcpl	0x00002952
     e5c:	4343475f 	cmpmi	r3, #24903680	@ 0x17c0000
     e60:	4f54415f 	svcmi	0x0054415f
     e64:	5f43494d 	svcpl	0x0043494d
     e68:	5f544e49 	svcpl	0x00544e49
     e6c:	4b434f4c 	blmi	10d4ba4 <_exit+0x10d46d4>
     e70:	4552465f 	ldrbmi	r4, [r2, #-1631]	@ 0xfffff9a1
     e74:	00312045 	eorseq	r2, r1, r5, asr #32
     e78:	4e495f5f 	mcrmi	15, 2, r5, cr9, cr15, {2}
     e7c:	58414d54 	stmdapl	r1, {r2, r4, r6, r8, sl, fp, lr}^
     e80:	58414d5f 	stmdapl	r1, {r0, r1, r2, r3, r4, r6, r8, sl, fp, lr}^
     e84:	30205f5f 	eorcc	r5, r0, pc, asr pc
     e88:	66663778 			@ <UNDEFINED> instruction: 0x66663778
     e8c:	66666666 	strbtvs	r6, [r6], -r6, ror #12
     e90:	66666666 	strbtvs	r6, [r6], -r6, ror #12
     e94:	66666666 	strbtvs	r6, [r6], -r6, ror #12
     e98:	004c4c66 	subeq	r4, ip, r6, ror #24
     e9c:	41555f5f 	cmpmi	r5, pc, asr pc
     ea0:	4d554343 	ldclmi	3, cr4, [r5, #-268]	@ 0xfffffef4
     ea4:	5350455f 	cmppl	r0, #398458880	@ 0x17c00000
     ea8:	4e4f4c49 	cdpmi	12, 4, cr4, cr15, cr9, {2}
     eac:	30205f5f 	eorcc	r5, r0, pc, asr pc
     eb0:	2d503178 	ldclcs	1, cr3, [r0, #-480]	@ 0xfffffe20
     eb4:	4b553631 	blmi	154e780 <_exit+0x154e2b0>
     eb8:	415f5f00 	cmpmi	pc, r0, lsl #30
     ebc:	4d554343 	ldclmi	3, cr4, [r5, #-268]	@ 0xfffffef4
     ec0:	4942495f 	stmdbmi	r2, {r0, r1, r2, r3, r4, r6, r8, fp, lr}^
     ec4:	205f5f54 	subscs	r5, pc, r4, asr pc	@ <UNPREDICTABLE>
     ec8:	5f003631 	svcpl	0x00003631
     ecc:	72617473 	rsbvc	r7, r1, #1929379840	@ 0x73000000
     ed0:	5f5f0074 	svcpl	0x005f0074
     ed4:	4c42444c 	stclmi	4, cr4, [r2], {76}	@ 0x4c
     ed8:	4e45445f 	mcrmi	4, 2, r4, cr5, cr15, {2}
     edc:	5f4d524f 	svcpl	0x004d524f
     ee0:	5f4e494d 	svcpl	0x004e494d
     ee4:	2e34205f 	mrccs	0, 1, r2, cr4, cr15, {2}
     ee8:	36303439 			@ <UNDEFINED> instruction: 0x36303439
     eec:	35343635 	ldrcc	r3, [r4, #-1589]!	@ 0xfffff9cb
     ef0:	32313438 	eorscc	r3, r1, #56, 8	@ 0x38000000
     ef4:	34353634 	ldrtcc	r3, [r5], #-1588	@ 0xfffff9cc
     ef8:	32332d65 	eorscc	r2, r3, #6464	@ 0x1940
     efc:	5f004c34 	svcpl	0x00004c34
     f00:	544c465f 	strbpl	r4, [ip], #-1631	@ 0xfffff9a1
     f04:	4d5f3436 	ldclmi	4, cr3, [pc, #-216]	@ e34 <_exit+0x964>
     f08:	315f5841 	cmpcc	pc, r1, asr #16
     f0c:	58455f30 	stmdapl	r5, {r4, r5, r8, r9, sl, fp, ip, lr}^
     f10:	205f5f50 	subscs	r5, pc, r0, asr pc	@ <UNPREDICTABLE>
     f14:	00383033 	eorseq	r3, r8, r3, lsr r0
     f18:	41535f5f 	cmpmi	r3, pc, asr pc
     f1c:	4d554343 	ldclmi	3, cr4, [r5, #-268]	@ 0xfffffef4
     f20:	4942495f 	stmdbmi	r2, {r0, r1, r2, r3, r4, r6, r8, fp, lr}^
     f24:	205f5f54 	subscs	r5, pc, r4, asr pc	@ <UNPREDICTABLE>
     f28:	5f5f0038 	svcpl	0x005f0038
     f2c:	455a4953 	ldrbmi	r4, [sl, #-2387]	@ 0xfffff6ad
     f30:	505f464f 	subspl	r4, pc, pc, asr #12
     f34:	49445254 	stmdbmi	r4, {r2, r4, r6, r9, ip, lr}^
     f38:	545f4646 	ldrbpl	r4, [pc], #-1606	@ f40 <_exit+0xa70>
     f3c:	34205f5f 	strtcc	r5, [r0], #-3935	@ 0xfffff0a1
     f40:	535f5f00 	cmppl	pc, #0, 30
     f44:	43415246 	cmpmi	r1, #1610612740	@ 0x60000004
     f48:	494d5f54 	stmdbmi	sp, {r2, r4, r6, r8, r9, sl, fp, ip, lr}^
     f4c:	205f5f4e 	subscs	r5, pc, lr, asr #30
     f50:	2e302d28 	cdpcs	13, 3, cr2, cr0, cr8, {1}
     f54:	2d524835 	ldclcs	8, cr4, [r2, #-212]	@ 0xffffff2c
     f58:	48352e30 	ldmdami	r5!, {r4, r5, r9, sl, fp, sp}
     f5c:	5f002952 	svcpl	0x00002952
     f60:	4153555f 	cmpmi	r3, pc, asr r5
     f64:	4942495f 	stmdbmi	r2, {r0, r1, r2, r3, r4, r6, r8, fp, lr}^
     f68:	205f5f54 	subscs	r5, pc, r4, asr pc	@ <UNPREDICTABLE>
     f6c:	5f003631 	svcpl	0x00003631
     f70:	5a49535f 	bpl	1255cf4 <_exit+0x1255824>
     f74:	5f464f45 	svcpl	0x00464f45
     f78:	414f4c46 	cmpmi	pc, r6, asr #24
     f7c:	205f5f54 	subscs	r5, pc, r4, asr pc	@ <UNPREDICTABLE>
     f80:	5f5f0034 	svcpl	0x005f0034
     f84:	43415355 	cmpmi	r1, #1409286145	@ 0x54000001
     f88:	5f4d5543 	svcpl	0x004d5543
     f8c:	5f58414d 	svcpl	0x0058414d
     f90:	5830205f 	ldmdapl	r0!, {r0, r1, r2, r3, r4, r6, sp}
     f94:	46464646 	strbmi	r4, [r6], -r6, asr #12
     f98:	55382d50 	ldrpl	r2, [r8, #-3408]!	@ 0xfffff2b0
     f9c:	5f004b48 	svcpl	0x00004b48
     fa0:	4e49555f 	mcrmi	5, 2, r5, cr9, cr15, {2}
     fa4:	5f323354 	svcpl	0x00323354
     fa8:	29632843 	stmdbcs	r3!, {r0, r1, r6, fp, sp}^
     fac:	23206320 			@ <UNDEFINED> instruction: 0x23206320
     fb0:	4c552023 	ldclmi	0, cr2, [r5], {35}	@ 0x23
     fb4:	555f5f00 	ldrbpl	r5, [pc, #-3840]	@ bc <_start-0x344>
     fb8:	465f4144 	ldrbmi	r4, [pc], -r4, asr #2
     fbc:	5f544942 	svcpl	0x00544942
     fc0:	3233205f 	eorscc	r2, r3, #95	@ 0x5f
     fc4:	415f5f00 	cmpmi	pc, r0, lsl #30
     fc8:	465f4d52 			@ <UNDEFINED> instruction: 0x465f4d52
     fcc:	55544145 	ldrbpl	r4, [r4, #-325]	@ 0xfffffebb
     fd0:	555f4552 	ldrbpl	r4, [pc, #-1362]	@ a86 <_exit+0x5b6>
     fd4:	494c414e 	stmdbmi	ip, {r1, r2, r3, r6, r8, lr}^
     fd8:	44454e47 	strbmi	r4, [r5], #-3655	@ 0xfffff1b9
     fdc:	465f5f00 	ldrbmi	r5, [pc], -r0, lsl #30
     fe0:	455f544c 	ldrbmi	r5, [pc, #-1100]	@ b9c <_exit+0x6cc>
     fe4:	5f4c4156 	svcpl	0x004c4156
     fe8:	4854454d 	ldmdami	r4, {r0, r2, r3, r6, r8, sl, lr}^
     fec:	545f444f 	ldrbpl	r4, [pc], #-1103	@ ff4 <_exit+0xb24>
     ff0:	38315f53 	ldmdacc	r1!, {r0, r1, r4, r6, r8, r9, sl, fp, ip, lr}
     ff4:	5f313636 	svcpl	0x00313636
     ff8:	205f5f33 	subscs	r5, pc, r3, lsr pc	@ <UNPREDICTABLE>
     ffc:	5f5f0030 	svcpl	0x005f0030
    1000:	47474942 	strbmi	r4, [r7, -r2, asr #18]
    1004:	5f545345 	svcpl	0x00545345
    1008:	47494c41 	strbmi	r4, [r9, -r1, asr #24]
    100c:	4e454d4e 	cdpmi	13, 4, cr4, cr5, cr14, {2}
    1010:	205f5f54 	subscs	r5, pc, r4, asr pc	@ <UNPREDICTABLE>
    1014:	5f5f0038 	svcpl	0x005f0038
    1018:	4343414c 	cmpmi	r3, #76, 2
    101c:	495f4d55 	ldmdbmi	pc, {r0, r2, r4, r6, r8, sl, fp, lr}^	@ <UNPREDICTABLE>
    1020:	5f544942 	svcpl	0x00544942
    1024:	3233205f 	eorscc	r2, r3, #95	@ 0x5f
    1028:	555f5f00 	ldrbpl	r5, [pc, #-3840]	@ 130 <_start-0x2d0>
    102c:	4343414c 	cmpmi	r3, #76, 2
    1030:	495f4d55 	ldmdbmi	pc, {r0, r2, r4, r6, r8, sl, fp, lr}^	@ <UNPREDICTABLE>
    1034:	5f544942 	svcpl	0x00544942
    1038:	3233205f 	eorscc	r2, r3, #95	@ 0x5f
    103c:	555f5f00 	ldrbpl	r5, [pc, #-3840]	@ 144 <_start-0x2bc>
    1040:	41524653 	cmpmi	r2, r3, asr r6
    1044:	4d5f5443 	ldclmi	4, cr5, [pc, #-268]	@ f40 <_exit+0xa70>
    1048:	5f5f5841 	svcpl	0x005f5841
    104c:	46583020 	ldrbmi	r3, [r8], -r0, lsr #32
    1050:	382d5046 	stmdacc	sp!, {r1, r2, r6, ip, lr}
    1054:	00524855 	subseq	r4, r2, r5, asr r8
    1058:	49555f5f 	ldmdbmi	r5, {r0, r1, r2, r3, r4, r6, r8, r9, sl, fp, ip, lr}^
    105c:	465f544e 	ldrbmi	r5, [pc], -lr, asr #8
    1060:	38545341 	ldmdacc	r4, {r0, r6, r8, r9, ip, lr}^
    1064:	58414d5f 	stmdapl	r1, {r0, r1, r2, r3, r4, r6, r8, sl, fp, lr}^
    1068:	30205f5f 	eorcc	r5, r0, pc, asr pc
    106c:	66666678 			@ <UNDEFINED> instruction: 0x66666678
    1070:	66666666 	strbtvs	r6, [r6], -r6, ror #12
    1074:	5f005566 	svcpl	0x00005566
    1078:	44524f5f 	ldrbmi	r4, [r2], #-3935	@ 0xfffff0a1
    107c:	4c5f5245 	ldclmi	2, cr5, [pc], {69}	@ 0x45
    1080:	4c545449 	ldclmi	4, cr5, [r4], {73}	@ 0x49
    1084:	4e455f45 	cdpmi	15, 4, cr5, cr5, cr5, {2}
    1088:	4e414944 			@ <UNDEFINED> instruction: 0x4e414944
    108c:	31205f5f 			@ <UNDEFINED> instruction: 0x31205f5f
    1090:	00343332 	eorseq	r3, r4, r2, lsr r3
    1094:	41485f5f 	cmpmi	r8, pc, asr pc
    1098:	535f4556 	cmppl	pc, #360710144	@ 0x15800000
    109c:	55434550 	strbpl	r4, [r3, #-1360]	@ 0xfffffab0
    10a0:	4954414c 	ldmdbmi	r4, {r2, r3, r6, r8, lr}^
    10a4:	535f4e4f 	cmppl	pc, #1264	@ 0x4f0
    10a8:	5f454641 	svcpl	0x00454641
    10ac:	554c4156 	strbpl	r4, [ip, #-342]	@ 0xfffffeaa
    10b0:	00312045 	eorseq	r2, r1, r5, asr #32
    10b4:	4c4c5f5f 	stclmi	15, cr5, [ip], {95}	@ 0x5f
    10b8:	55434341 	strbpl	r4, [r3, #-833]	@ 0xfffffcbf
    10bc:	494d5f4d 	stmdbmi	sp, {r0, r2, r3, r6, r8, r9, sl, fp, ip, lr}^
    10c0:	205f5f4e 	subscs	r5, pc, lr, asr #30
    10c4:	58302d28 	ldmdapl	r0!, {r3, r5, r8, sl, fp, sp}
    10c8:	31335031 	teqcc	r3, r1, lsr r0
    10cc:	2d4b4c4c 	stclcs	12, cr4, [fp, #-304]	@ 0xfffffed0
    10d0:	50315830 	eorspl	r5, r1, r0, lsr r8
    10d4:	4c4c3133 	stclmi	1, cr3, [ip], {51}	@ 0x33
    10d8:	5f00294b 	svcpl	0x0000294b
    10dc:	5f41535f 	svcpl	0x0041535f
    10e0:	54494246 	strbpl	r4, [r9], #-582	@ 0xfffffdba
    10e4:	31205f5f 			@ <UNDEFINED> instruction: 0x31205f5f
    10e8:	5f5f0035 	svcpl	0x005f0035
    10ec:	36544c46 	ldrbcc	r4, [r4], -r6, asr #24
    10f0:	494d5f34 	stmdbmi	sp, {r2, r4, r5, r8, r9, sl, fp, ip, lr}^
    10f4:	30315f4e 	eorscc	r5, r1, lr, asr #30
    10f8:	5058455f 	subspl	r4, r8, pc, asr r5
    10fc:	28205f5f 	stmdacs	r0!, {r0, r1, r2, r3, r4, r6, r8, r9, sl, fp, ip, lr}
    1100:	3730332d 	ldrcc	r3, [r0, -sp, lsr #6]!
    1104:	5f5f0029 	svcpl	0x005f0029
    1108:	5f4d5241 	svcpl	0x004d5241
    110c:	54414546 	strbpl	r4, [r1], #-1350	@ 0xfffffaba
    1110:	5f455255 	svcpl	0x00455255
    1114:	5f495442 	svcpl	0x00495442
    1118:	41464544 	cmpmi	r6, r4, asr #10
    111c:	00544c55 	subseq	r4, r4, r5, asr ip
    1120:	41535f5f 	cmpmi	r3, pc, asr pc
    1124:	4d554343 	ldclmi	3, cr4, [r5, #-268]	@ 0xfffffef4
    1128:	5350455f 	cmppl	r0, #398458880	@ 0x17c00000
    112c:	4e4f4c49 	cdpmi	12, 4, cr4, cr15, cr9, {2}
    1130:	30205f5f 	eorcc	r5, r0, pc, asr pc
    1134:	2d503178 	ldclcs	1, cr3, [r0, #-480]	@ 0xfffffe20
    1138:	004b4837 	subeq	r4, fp, r7, lsr r8
    113c:	52415f5f 	subpl	r5, r1, #380	@ 0x17c
    1140:	45465f4d 	strbmi	r5, [r6, #-3917]	@ 0xfffff0b3
    1144:	52555441 	subspl	r5, r5, #1090519040	@ 0x41000000
    1148:	41505f45 	cmpmi	r0, r5, asr #30
    114c:	45445f43 	strbmi	r5, [r4, #-3907]	@ 0xfffff0bd
    1150:	4c554146 	ldclmi	1, cr4, [r5], {70}	@ 0x46
    1154:	5f5f0054 	svcpl	0x005f0054
    1158:	5f544e49 	svcpl	0x00544e49
    115c:	54534146 	ldrbpl	r4, [r3], #-326	@ 0xfffffeba
    1160:	545f3631 	ldrbpl	r3, [pc], #-1585	@ 1168 <_exit+0xc98>
    1164:	5f455059 	svcpl	0x00455059
    1168:	6e69205f 	mcrvs	0, 3, r2, cr9, cr15, {2}
    116c:	5f5f0074 	svcpl	0x005f0074
    1170:	33544c46 	cmpcc	r4, #17920	@ 0x4600
    1174:	45445f32 	strbmi	r5, [r4, #-3890]	@ 0xfffff0ce
    1178:	414d4943 	cmpmi	sp, r3, asr #18
    117c:	49445f4c 	stmdbmi	r4, {r2, r3, r6, r8, r9, sl, fp, ip, lr}^
    1180:	205f5f47 	subscs	r5, pc, r7, asr #30
    1184:	5f5f0039 	svcpl	0x005f0039
    1188:	544e4955 	strbpl	r4, [lr], #-2389	@ 0xfffff6ab
    118c:	545f3631 	ldrbpl	r3, [pc], #-1585	@ 1194 <_exit+0xcc4>
    1190:	5f455059 	svcpl	0x00455059
    1194:	6873205f 	ldmdavs	r3!, {r0, r1, r2, r3, r4, r6, sp}^
    1198:	2074726f 	rsbscs	r7, r4, pc, ror #4
    119c:	69736e75 	ldmdbvs	r3!, {r0, r2, r4, r5, r6, r9, sl, fp, sp, lr}^
    11a0:	64656e67 	strbtvs	r6, [r5], #-3687	@ 0xfffff199
    11a4:	746e6920 	strbtvc	r6, [lr], #-2336	@ 0xfffff6e0
    11a8:	575f5f00 	ldrbpl	r5, [pc, -r0, lsl #30]
    11ac:	52414843 	subpl	r4, r1, #4390912	@ 0x430000
    11b0:	4449575f 	strbmi	r5, [r9], #-1887	@ 0xfffff8a1
    11b4:	5f5f4854 	svcpl	0x005f4854
    11b8:	00323320 	eorseq	r3, r2, r0, lsr #6
    11bc:	4e475f5f 	mcrmi	15, 2, r5, cr7, cr15, {2}
    11c0:	535f4355 	cmppl	pc, #1409286145	@ 0x54000001
    11c4:	5f434454 	svcpl	0x00434454
    11c8:	494c4e49 	stmdbmi	ip, {r0, r3, r6, r9, sl, fp, lr}^
    11cc:	5f5f454e 	svcpl	0x005f454e
    11d0:	5f003120 	svcpl	0x00003120
    11d4:	5148555f 	cmppl	r8, pc, asr r5
    11d8:	4942495f 	stmdbmi	r2, {r0, r1, r2, r3, r4, r6, r8, fp, lr}^
    11dc:	205f5f54 	subscs	r5, pc, r4, asr pc	@ <UNPREDICTABLE>
    11e0:	5f5f0030 	svcpl	0x005f0030
    11e4:	41524655 	cmpmi	r2, r5, asr r6
    11e8:	465f5443 	ldrbmi	r5, [pc], -r3, asr #8
    11ec:	5f544942 	svcpl	0x00544942
    11f0:	3631205f 			@ <UNDEFINED> instruction: 0x3631205f
    11f4:	4c5f5f00 	ldclmi	15, cr5, [pc], {-0}
    11f8:	5f474e4f 	svcpl	0x00474e4f
    11fc:	474e4f4c 	strbmi	r4, [lr, -ip, asr #30]
    1200:	58414d5f 	stmdapl	r1, {r0, r1, r2, r3, r4, r6, r8, sl, fp, lr}^
    1204:	30205f5f 	eorcc	r5, r0, pc, asr pc
    1208:	66663778 			@ <UNDEFINED> instruction: 0x66663778
    120c:	66666666 	strbtvs	r6, [r6], -r6, ror #12
    1210:	66666666 	strbtvs	r6, [r6], -r6, ror #12
    1214:	66666666 	strbtvs	r6, [r6], -r6, ror #12
    1218:	004c4c66 	subeq	r4, ip, r6, ror #24
    121c:	49555f5f 	ldmdbmi	r5, {r0, r1, r2, r3, r4, r6, r8, r9, sl, fp, ip, lr}^
    1220:	4c5f544e 	ldclmi	4, cr5, [pc], {78}	@ 0x4e
    1224:	54534145 	ldrbpl	r4, [r3], #-325	@ 0xfffffebb
    1228:	545f3631 	ldrbpl	r3, [pc], #-1585	@ 1230 <_exit+0xd60>
    122c:	5f455059 	svcpl	0x00455059
    1230:	6873205f 	ldmdavs	r3!, {r0, r1, r2, r3, r4, r6, sp}^
    1234:	2074726f 	rsbscs	r7, r4, pc, ror #4
    1238:	69736e75 	ldmdbvs	r3!, {r0, r2, r4, r5, r6, r9, sl, fp, sp, lr}^
    123c:	64656e67 	strbtvs	r6, [r5], #-3687	@ 0xfffff199
    1240:	746e6920 	strbtvc	r6, [lr], #-2336	@ 0xfffff6e0
    1244:	465f5f00 	ldrbmi	r5, [pc], -r0, lsl #30
    1248:	4d5f544c 	ldclmi	4, cr5, [pc, #-304]	@ 1120 <_exit+0xc50>
    124c:	315f5841 	cmpcc	pc, r1, asr #16
    1250:	58455f30 	stmdapl	r5, {r4, r5, r8, r9, sl, fp, ip, lr}^
    1254:	205f5f50 	subscs	r5, pc, r0, asr pc	@ <UNPREDICTABLE>
    1258:	5f003833 	svcpl	0x00003833
    125c:	414c4c5f 	cmpmi	ip, pc, asr ip
    1260:	4d554343 	ldclmi	3, cr4, [r5, #-268]	@ 0xfffffef4
    1264:	58414d5f 	stmdapl	r1, {r0, r1, r2, r3, r4, r6, r8, sl, fp, lr}^
    1268:	30205f5f 	eorcc	r5, r0, pc, asr pc
    126c:	46463758 			@ <UNDEFINED> instruction: 0x46463758
    1270:	46464646 	strbmi	r4, [r6], -r6, asr #12
    1274:	46464646 	strbmi	r4, [r6], -r6, asr #12
    1278:	46464646 	strbmi	r4, [r6], -r6, asr #12
    127c:	332d5046 			@ <UNDEFINED> instruction: 0x332d5046
    1280:	4b4c4c31 	blmi	131434c <_exit+0x1313e7c>
    1284:	67726100 	ldrbvs	r6, [r2, -r0, lsl #2]!
    1288:	5f5f0076 	svcpl	0x005f0076
    128c:	43414c4c 	cmpmi	r1, #76, 24	@ 0x4c00
    1290:	5f4d5543 	svcpl	0x004d5543
    1294:	49535045 	ldmdbmi	r3, {r0, r2, r6, ip, lr}^
    1298:	5f4e4f4c 	svcpl	0x004e4f4c
    129c:	7830205f 	ldmdavc	r0!, {r0, r1, r2, r3, r4, r6, sp}
    12a0:	332d5031 			@ <UNDEFINED> instruction: 0x332d5031
    12a4:	4b4c4c31 	blmi	1314370 <_exit+0x1313ea0>
    12a8:	415f5f00 	cmpmi	pc, r0, lsl #30
    12ac:	465f4d52 			@ <UNDEFINED> instruction: 0x465f4d52
    12b0:	55544145 	ldrbpl	r4, [r4, #-325]	@ 0xfffffebb
    12b4:	435f4552 	cmpmi	pc, #343932928	@ 0x14800000
    12b8:	4f52504f 	svcmi	0x0052504f
    12bc:	5f5f0043 	svcpl	0x005f0043
    12c0:	495f4f4e 	ldmdbmi	pc, {r1, r2, r3, r6, r8, r9, sl, fp, lr}^	@ <UNPREDICTABLE>
    12c4:	4e494c4e 	cdpmi	12, 4, cr4, cr9, cr14, {2}
    12c8:	205f5f45 	subscs	r5, pc, r5, asr #30
    12cc:	5f5f0031 	svcpl	0x005f0031
    12d0:	52464c55 	subpl	r4, r6, #21760	@ 0x5500
    12d4:	5f544341 	svcpl	0x00544341
    12d8:	5f4e494d 	svcpl	0x004e494d
    12dc:	2e30205f 	mrccs	0, 1, r2, cr0, cr15, {2}
    12e0:	524c5530 	subpl	r5, ip, #48, 10	@ 0xc000000
    12e4:	465f5f00 	ldrbmi	r5, [pc], -r0, lsl #30
    12e8:	4d5f544c 	ldclmi	4, cr5, [pc, #-304]	@ 11c0 <_exit+0xcf0>
    12ec:	5f544e41 	svcpl	0x00544e41
    12f0:	5f474944 	svcpl	0x00474944
    12f4:	3432205f 	ldrtcc	r2, [r2], #-95	@ 0xffffffa1
    12f8:	415f5f00 	cmpmi	pc, r0, lsl #30
    12fc:	415f4d52 	cmpmi	pc, r2, asr sp	@ <UNPREDICTABLE>
    1300:	00484352 	subeq	r4, r8, r2, asr r3
    1304:	4c465f5f 	stclmi	15, cr5, [r6], {95}	@ 0x5f
    1308:	5f343654 	svcpl	0x00343654
    130c:	49434544 	stmdbmi	r3, {r2, r6, r8, sl, lr}^
    1310:	5f4c414d 	svcpl	0x004c414d
    1314:	5f474944 	svcpl	0x00474944
    1318:	3731205f 			@ <UNDEFINED> instruction: 0x3731205f
    131c:	465f5f00 	ldrbmi	r5, [pc], -r0, lsl #30
    1320:	3233544c 	eorscc	r5, r3, #76, 8	@ 0x4c000000
    1324:	4e494d5f 	mcrmi	13, 2, r4, cr9, cr15, {2}
    1328:	5058455f 	subspl	r4, r8, pc, asr r5
    132c:	28205f5f 	stmdacs	r0!, {r0, r1, r2, r3, r4, r6, r8, r9, sl, fp, ip, lr}
    1330:	3532312d 	ldrcc	r3, [r2, #-301]!	@ 0xfffffed3
    1334:	5f5f0029 	svcpl	0x005f0029
    1338:	43434155 	cmpmi	r3, #1073741845	@ 0x40000015
    133c:	495f4d55 	ldmdbmi	pc, {r0, r2, r4, r6, r8, sl, fp, lr}^	@ <UNPREDICTABLE>
    1340:	5f544942 	svcpl	0x00544942
    1344:	3631205f 			@ <UNDEFINED> instruction: 0x3631205f
    1348:	555f5f00 	ldrbpl	r5, [pc, #-3840]	@ 450 <zero+0x10>
    134c:	5f544e49 	svcpl	0x00544e49
    1350:	54534146 	ldrbpl	r4, [r3], #-326	@ 0xfffffeba
    1354:	4d5f3631 	ldclmi	6, cr3, [pc, #-196]	@ 1298 <_exit+0xdc8>
    1358:	5f5f5841 	svcpl	0x005f5841
    135c:	66783020 	ldrbtvs	r3, [r8], -r0, lsr #32
    1360:	66666666 	strbtvs	r6, [r6], -r6, ror #12
    1364:	55666666 	strbpl	r6, [r6, #-1638]!	@ 0xfffff99a
    1368:	555f5f00 	ldrbpl	r5, [pc, #-3840]	@ 470 <main+0x14>
    136c:	5f544e49 	svcpl	0x00544e49
    1370:	54534146 	ldrbpl	r4, [r3], #-326	@ 0xfffffeba
    1374:	545f3631 	ldrbpl	r3, [pc], #-1585	@ 137c <_exit+0xeac>
    1378:	5f455059 	svcpl	0x00455059
    137c:	6e75205f 	mrcvs	0, 3, r2, cr5, cr15, {2}
    1380:	6e676973 			@ <UNDEFINED> instruction: 0x6e676973
    1384:	69206465 	stmdbvs	r0!, {r0, r2, r5, r6, sl, sp, lr}
    1388:	5f00746e 	svcpl	0x0000746e
    138c:	544c465f 	strbpl	r4, [ip], #-1631	@ 0xfffff9a1
    1390:	4d5f3233 	ldclmi	2, cr3, [pc, #-204]	@ 12cc <_exit+0xdfc>
    1394:	455f5841 	ldrbmi	r5, [pc, #-2113]	@ b5b <_exit+0x68b>
    1398:	5f5f5058 	svcpl	0x005f5058
    139c:	38323120 	ldmdacc	r2!, {r5, r8, ip, sp}
    13a0:	445f5f00 	ldrbmi	r5, [pc], #-3840	@ 13a8 <_exit+0xed8>
    13a4:	4d5f4c42 	ldclmi	12, cr4, [pc, #-264]	@ 12a4 <_exit+0xdd4>
    13a8:	315f4e49 	cmpcc	pc, r9, asr #28
    13ac:	58455f30 	stmdapl	r5, {r4, r5, r8, r9, sl, fp, ip, lr}^
    13b0:	205f5f50 	subscs	r5, pc, r0, asr pc	@ <UNPREDICTABLE>
    13b4:	30332d28 	eorscc	r2, r3, r8, lsr #26
    13b8:	5f002937 	svcpl	0x00002937
    13bc:	4153555f 	cmpmi	r3, pc, asr r5
    13c0:	4d554343 	ldclmi	3, cr4, [r5, #-268]	@ 0xfffffef4
    13c4:	4942495f 	stmdbmi	r2, {r0, r1, r2, r3, r4, r6, r8, fp, lr}^
    13c8:	205f5f54 	subscs	r5, pc, r4, asr pc	@ <UNPREDICTABLE>
    13cc:	5f5f0038 	svcpl	0x005f0038
    13d0:	4d554854 	ldclmi	8, cr4, [r5, #-336]	@ 0xfffffeb0
    13d4:	4e495f42 	cdpmi	15, 4, cr5, cr9, cr2, {2}
    13d8:	57524554 			@ <UNDEFINED> instruction: 0x57524554
    13dc:	5f4b524f 	svcpl	0x004b524f
    13e0:	0031205f 	eorseq	r2, r1, pc, asr r0
    13e4:	4c465f5f 	stclmi	15, cr5, [r6], {95}	@ 0x5f
    13e8:	5f323354 	svcpl	0x00323354
    13ec:	5f474944 	svcpl	0x00474944
    13f0:	0036205f 	eorseq	r2, r6, pc, asr r0
    13f4:	4c465f5f 	stclmi	15, cr5, [r6], {95}	@ 0x5f
    13f8:	5f343654 	svcpl	0x00343654
    13fc:	5f534148 	svcpl	0x00534148
    1400:	4f4e4544 	svcmi	0x004e4544
    1404:	5f5f4d52 	svcpl	0x005f4d52
    1408:	5f003120 	svcpl	0x00003120
    140c:	544c465f 	strbpl	r4, [ip], #-1631	@ 0xfffff9a1
    1410:	4156455f 	cmpmi	r6, pc, asr r5
    1414:	454d5f4c 	strbmi	r5, [sp, #-3916]	@ 0xfffff0b4
    1418:	444f4854 	strbmi	r4, [pc], #-2132	@ 1420 <_exit+0xf50>
    141c:	30205f5f 	eorcc	r5, r0, pc, asr pc
    1420:	465f5f00 	ldrbmi	r5, [pc], -r0, lsl #30
    1424:	3233544c 	eorscc	r5, r3, #76, 8	@ 0x4c000000
    1428:	41485f58 	cmpmi	r8, r8, asr pc
    142c:	45445f53 	strbmi	r5, [r4, #-3923]	@ 0xfffff0ad
    1430:	4d524f4e 	ldclmi	15, cr4, [r2, #-312]	@ 0xfffffec8
    1434:	31205f5f 			@ <UNDEFINED> instruction: 0x31205f5f
    1438:	415f5f00 	cmpmi	pc, r0, lsl #30
    143c:	465f4d52 			@ <UNDEFINED> instruction: 0x465f4d52
    1440:	55544145 	ldrbpl	r4, [r4, #-325]	@ 0xfffffebb
    1444:	435f4552 	cmpmi	pc, #343932928	@ 0x14800000
    1448:	4f52504f 	svcmi	0x0052504f
    144c:	00312043 	eorseq	r2, r1, r3, asr #32
    1450:	4e495f5f 	mcrmi	15, 2, r5, cr9, cr15, {2}
    1454:	454c5f54 	strbmi	r5, [ip, #-3924]	@ 0xfffff0ac
    1458:	36545341 	ldrbcc	r5, [r4], -r1, asr #6
    145c:	414d5f34 	cmpmi	sp, r4, lsr pc
    1460:	205f5f58 	subscs	r5, pc, r8, asr pc	@ <UNPREDICTABLE>
    1464:	66377830 			@ <UNDEFINED> instruction: 0x66377830
    1468:	66666666 	strbtvs	r6, [r6], -r6, ror #12
    146c:	66666666 	strbtvs	r6, [r6], -r6, ror #12
    1470:	66666666 	strbtvs	r6, [r6], -r6, ror #12
    1474:	4c4c6666 	stclmi	6, cr6, [ip], {102}	@ 0x66
    1478:	415f5f00 	cmpmi	pc, r0, lsl #30
    147c:	4d554343 	ldclmi	3, cr4, [r5, #-268]	@ 0xfffffef4
    1480:	4942465f 	stmdbmi	r2, {r0, r1, r2, r3, r4, r6, r9, sl, lr}^
    1484:	205f5f54 	subscs	r5, pc, r4, asr pc	@ <UNPREDICTABLE>
    1488:	5f003531 	svcpl	0x00003531
    148c:	4343475f 	cmpmi	r3, #24903680	@ 0x17c0000
    1490:	4f54415f 	svcmi	0x0054415f
    1494:	5f43494d 	svcpl	0x0043494d
    1498:	41484357 	cmpmi	r8, r7, asr r3
    149c:	5f545f52 	svcpl	0x00545f52
    14a0:	4b434f4c 	blmi	10d51d8 <_exit+0x10d4d08>
    14a4:	4552465f 	ldrbmi	r4, [r2, #-1631]	@ 0xfffff9a1
    14a8:	00312045 	eorseq	r2, r1, r5, asr #32
    14ac:	45565f5f 	ldrbmi	r5, [r6, #-3935]	@ 0xfffff0a1
    14b0:	4f495352 	svcmi	0x00495352
    14b4:	205f5f4e 	subscs	r5, pc, lr, asr #30
    14b8:	2e353122 	cdpcs	1, 3, cr3, cr5, cr2, {1}
    14bc:	22302e32 	eorscs	r2, r0, #800	@ 0x320
    14c0:	4c5f5f00 	ldclmi	15, cr5, [pc], {-0}
    14c4:	4152464c 	cmpmi	r2, ip, asr #12
    14c8:	465f5443 	ldrbmi	r5, [pc], -r3, asr #8
    14cc:	5f544942 	svcpl	0x00544942
    14d0:	3336205f 	teqcc	r6, #95	@ 0x5f
    14d4:	495f5f00 	ldmdbmi	pc, {r8, r9, sl, fp, ip, lr}^	@ <UNPREDICTABLE>
    14d8:	4c5f544e 	ldclmi	4, cr5, [pc], {78}	@ 0x4e
    14dc:	54534145 	ldrbpl	r4, [r3], #-325	@ 0xfffffebb
    14e0:	49575f38 	ldmdbmi	r7, {r3, r4, r5, r8, r9, sl, fp, ip, lr}^
    14e4:	5f485444 	svcpl	0x00485444
    14e8:	0038205f 	eorseq	r2, r8, pc, asr r0
    14ec:	53555f5f 	cmppl	r5, #380	@ 0x17c
    14f0:	42465f41 	submi	r5, r6, #260	@ 0x104
    14f4:	5f5f5449 	svcpl	0x005f5449
    14f8:	00363120 	eorseq	r3, r6, r0, lsr #2
    14fc:	49555f5f 	ldmdbmi	r5, {r0, r1, r2, r3, r4, r6, r8, r9, sl, fp, ip, lr}^
    1500:	5f38544e 	svcpl	0x0038544e
    1504:	5f58414d 	svcpl	0x0058414d
    1508:	7830205f 	ldmdavc	r0!, {r0, r1, r2, r3, r4, r6, sp}
    150c:	5f006666 	svcpl	0x00006666
    1510:	4d52415f 	ldclmi	1, cr4, [r2, #-380]	@ 0xfffffe84
    1514:	4145465f 	cmpmi	r5, pc, asr r6
    1518:	45525554 	ldrbmi	r5, [r2, #-1364]	@ 0xfffffaac
    151c:	4944495f 	stmdbmi	r4, {r0, r1, r2, r3, r4, r6, r8, fp, lr}^
    1520:	5f5f0056 	svcpl	0x005f0056
    1524:	544e4955 	strbpl	r4, [lr], #-2389	@ 0xfffff6ab
    1528:	4d5f3631 	ldclmi	6, cr3, [pc, #-196]	@ 146c <_exit+0xf9c>
    152c:	5f5f5841 	svcpl	0x005f5841
    1530:	66783020 	ldrbtvs	r3, [r8], -r0, lsr #32
    1534:	00666666 	rsbeq	r6, r6, r6, ror #12
    1538:	52415f5f 	subpl	r5, r1, #380	@ 0x17c
    153c:	45465f4d 	strbmi	r5, [r6, #-3917]	@ 0xfffff0b3
    1540:	52555441 	subspl	r5, r5, #1090519040	@ 0x41000000
    1544:	4d465f45 	stclmi	15, cr5, [r6, #-276]	@ 0xfffffeec
    1548:	5f5f0041 	svcpl	0x005f0041
    154c:	43434155 	cmpmi	r3, #1073741845	@ 0x40000015
    1550:	465f4d55 			@ <UNDEFINED> instruction: 0x465f4d55
    1554:	5f544942 	svcpl	0x00544942
    1558:	3631205f 			@ <UNDEFINED> instruction: 0x3631205f
    155c:	495f5f00 	ldmdbmi	pc, {r8, r9, sl, fp, ip, lr}^	@ <UNPREDICTABLE>
    1560:	414d544e 	cmpmi	sp, lr, asr #8
    1564:	49575f58 	ldmdbmi	r7, {r3, r4, r6, r8, r9, sl, fp, ip, lr}^
    1568:	5f485444 	svcpl	0x00485444
    156c:	3436205f 	ldrtcc	r2, [r6], #-95	@ 0xffffffa1
    1570:	415f5f00 	cmpmi	pc, r0, lsl #30
    1574:	465f4d52 			@ <UNDEFINED> instruction: 0x465f4d52
    1578:	55544145 	ldrbpl	r4, [r4, #-325]	@ 0xfffffebb
    157c:	435f4552 	cmpmi	pc, #343932928	@ 0x14800000
    1580:	5f004544 	svcpl	0x00004544
    1584:	52464c5f 	subpl	r4, r6, #24320	@ 0x5f00
    1588:	5f544341 	svcpl	0x00544341
    158c:	54494246 	strbpl	r4, [r9], #-582	@ 0xfffffdba
    1590:	33205f5f 			@ <UNDEFINED> instruction: 0x33205f5f
    1594:	5f5f0031 	svcpl	0x005f0031
    1598:	5f544e49 	svcpl	0x00544e49
    159c:	5341454c 	cmppl	r1, #76, 10	@ 0x13000000
    15a0:	5f363154 	svcpl	0x00363154
    15a4:	45505954 	ldrbmi	r5, [r0, #-2388]	@ 0xfffff6ac
    15a8:	73205f5f 			@ <UNDEFINED> instruction: 0x73205f5f
    15ac:	74726f68 	ldrbtvc	r6, [r2], #-3944	@ 0xfffff098
    15b0:	746e6920 	strbtvc	r6, [lr], #-2336	@ 0xfffff6e0
    15b4:	465f5f00 	ldrbmi	r5, [pc], -r0, lsl #30
    15b8:	3436544c 	ldrtcc	r5, [r6], #-1100	@ 0xfffffbb4
    15bc:	5341485f 	cmppl	r1, #6225920	@ 0x5f0000
    15c0:	4955515f 	ldmdbmi	r5, {r0, r1, r2, r3, r4, r6, r8, ip, lr}^
    15c4:	4e5f5445 	cdpmi	4, 5, cr5, cr15, cr5, {2}
    15c8:	5f5f4e41 	svcpl	0x005f4e41
    15cc:	5f003120 	svcpl	0x00003120
    15d0:	4c42445f 	stclmi	4, cr4, [r2], {95}	@ 0x5f
    15d4:	4749445f 			@ <UNDEFINED> instruction: 0x4749445f
    15d8:	31205f5f 			@ <UNDEFINED> instruction: 0x31205f5f
    15dc:	5f5f0035 	svcpl	0x005f0035
    15e0:	454d5241 	strbmi	r5, [sp, #-577]	@ 0xfffffdbf
    15e4:	205f5f4c 	subscs	r5, pc, ip, asr #30
    15e8:	5f5f0031 	svcpl	0x005f0031
    15ec:	5f4d5241 	svcpl	0x004d5241
    15f0:	48435241 	stmdami	r3, {r0, r6, r9, ip, lr}^
    15f4:	4153495f 	cmpmi	r3, pc, asr r9
    15f8:	5548545f 	strbpl	r5, [r8, #-1119]	@ 0xfffffba1
    15fc:	5f00424d 	svcpl	0x0000424d
    1600:	43414c5f 	cmpmi	r1, #24320	@ 0x5f00
    1604:	5f4d5543 	svcpl	0x004d5543
    1608:	54494246 	strbpl	r4, [r9], #-582	@ 0xfffffdba
    160c:	33205f5f 			@ <UNDEFINED> instruction: 0x33205f5f
    1610:	5f5f0031 	svcpl	0x005f0031
    1614:	5f515455 	svcpl	0x00515455
    1618:	54494249 	strbpl	r4, [r9], #-585	@ 0xfffffdb7
    161c:	30205f5f 	eorcc	r5, r0, pc, asr pc
    1620:	535f5f00 	cmppl	pc, #0, 30
    1624:	5f434454 	svcpl	0x00434454
    1628:	45424d45 	strbmi	r4, [r2, #-3397]	@ 0xfffff2bb
    162c:	4f465f44 	svcmi	0x00465f44
    1630:	5f444e55 	svcpl	0x00444e55
    1634:	0031205f 	eorseq	r2, r1, pc, asr r0
    1638:	4c465f5f 	stclmi	15, cr5, [r6], {95}	@ 0x5f
    163c:	494d5f54 	stmdbmi	sp, {r2, r4, r6, r8, r9, sl, fp, ip, lr}^
    1640:	205f5f4e 	subscs	r5, pc, lr, asr #30
    1644:	37312e31 			@ <UNDEFINED> instruction: 0x37312e31
    1648:	34393435 	ldrtcc	r3, [r9], #-1077	@ 0xfffffbcb
    164c:	38303533 	ldmdacc	r0!, {r0, r1, r4, r5, r8, sl, ip, sp}
    1650:	38323232 	ldmdacc	r2!, {r1, r4, r5, r9, ip, sp}
    1654:	2d653537 	stclcs	5, cr3, [r5, #-220]!	@ 0xffffff24
    1658:	00463833 	subeq	r3, r6, r3, lsr r8
    165c:	4c465f5f 	stclmi	15, cr5, [r6], {95}	@ 0x5f
    1660:	58323354 	ldmdapl	r2!, {r2, r4, r6, r8, r9, ip, sp}
    1664:	4749445f 			@ <UNDEFINED> instruction: 0x4749445f
    1668:	31205f5f 			@ <UNDEFINED> instruction: 0x31205f5f
    166c:	5f5f0035 	svcpl	0x005f0035
    1670:	55434341 	strbpl	r4, [r3, #-833]	@ 0xfffffcbf
    1674:	50455f4d 	subpl	r5, r5, sp, asr #30
    1678:	4f4c4953 	svcmi	0x004c4953
    167c:	205f5f4e 	subscs	r5, pc, lr, asr #30
    1680:	50317830 	eorspl	r7, r1, r0, lsr r8
    1684:	4b35312d 	blmi	d4db40 <_exit+0xd4d670>
    1688:	555f5f00 	ldrbpl	r5, [pc, #-3840]	@ 790 <_exit+0x2c0>
    168c:	465f5144 	ldrbmi	r5, [pc], -r4, asr #2
    1690:	5f544942 	svcpl	0x00544942
    1694:	3436205f 	ldrtcc	r2, [r6], #-95	@ 0xffffffa1
    1698:	465f5f00 	ldrbmi	r5, [pc], -r0, lsl #30
    169c:	3233544c 	eorscc	r5, r3, #76, 8	@ 0x4c000000
    16a0:	414d5f58 	cmpmi	sp, r8, asr pc
    16a4:	445f544e 	ldrbmi	r5, [pc], #-1102	@ 16ac <_exit+0x11dc>
    16a8:	5f5f4749 	svcpl	0x005f4749
    16ac:	00333520 	eorseq	r3, r3, r0, lsr #10
    16b0:	41485f5f 	cmpmi	r8, pc, asr pc
    16b4:	4942495f 	stmdbmi	r2, {r0, r1, r2, r3, r4, r6, r8, fp, lr}^
    16b8:	205f5f54 	subscs	r5, pc, r4, asr pc	@ <UNPREDICTABLE>
    16bc:	5f5f0038 	svcpl	0x005f0038
    16c0:	5f4d5241 	svcpl	0x004d5241
    16c4:	48435241 	stmdami	r3, {r0, r6, r9, ip, lr}^
    16c8:	4153495f 	cmpmi	r3, pc, asr r9
    16cc:	5548545f 	strbpl	r5, [r8, #-1119]	@ 0xfffffba1
    16d0:	3120424d 			@ <UNDEFINED> instruction: 0x3120424d
    16d4:	555f5f00 	ldrbpl	r5, [pc, #-3840]	@ 7dc <_exit+0x30c>
    16d8:	465f5154 			@ <UNDEFINED> instruction: 0x465f5154
    16dc:	5f544942 	svcpl	0x00544942
    16e0:	3231205f 	eorscc	r2, r1, #95	@ 0x5f
    16e4:	5f5f0038 	svcpl	0x005f0038
    16e8:	52414843 	subpl	r4, r1, #4390912	@ 0x430000
    16ec:	5449425f 	strbpl	r4, [r9], #-607	@ 0xfffffda1
    16f0:	38205f5f 	stmdacc	r0!, {r0, r1, r2, r3, r4, r6, r8, r9, sl, fp, ip, lr}
    16f4:	72657a00 	rsbvc	r7, r5, #0, 20
    16f8:	5f5f006f 	svcpl	0x005f006f
    16fc:	33544c46 	cmpcc	r4, #17920	@ 0x4600
    1700:	495f5832 	ldmdbmi	pc, {r1, r4, r5, fp, ip, lr}^	@ <UNPREDICTABLE>
    1704:	45495f53 	strbmi	r5, [r9, #-3923]	@ 0xfffff0ad
    1708:	30365f43 	eorscc	r5, r6, r3, asr #30
    170c:	5f393535 	svcpl	0x00393535
    1710:	0031205f 	eorseq	r2, r1, pc, asr r0
    1714:	4e495f5f 	mcrmi	15, 2, r5, cr9, cr15, {2}
    1718:	454c5f54 	strbmi	r5, [ip, #-3924]	@ 0xfffff0ac
    171c:	38545341 	ldmdacc	r4, {r0, r6, r8, r9, ip, lr}^
    1720:	5059545f 	subspl	r5, r9, pc, asr r4
    1724:	205f5f45 	subscs	r5, pc, r5, asr #30
    1728:	6e676973 			@ <UNDEFINED> instruction: 0x6e676973
    172c:	63206465 			@ <UNDEFINED> instruction: 0x63206465
    1730:	00726168 	rsbseq	r6, r2, r8, ror #2
    1734:	4e495f5f 	mcrmi	15, 2, r5, cr9, cr15, {2}
    1738:	52545054 	subspl	r5, r4, #84	@ 0x54
    173c:	4449575f 	strbmi	r5, [r9], #-1887	@ 0xfffff8a1
    1740:	5f5f4854 	svcpl	0x005f4854
    1744:	00323320 	eorseq	r3, r2, r0, lsr #6
    1748:	49555f5f 	ldmdbmi	r5, {r0, r1, r2, r3, r4, r6, r8, r9, sl, fp, ip, lr}^
    174c:	4c5f544e 	ldclmi	4, cr5, [pc], {78}	@ 0x4e
    1750:	54534145 	ldrbpl	r4, [r3], #-325	@ 0xfffffebb
    1754:	59545f38 	ldmdbpl	r4, {r3, r4, r5, r8, r9, sl, fp, ip, lr}^
    1758:	5f5f4550 	svcpl	0x005f4550
    175c:	736e7520 	cmnvc	lr, #32, 10	@ 0x8000000
    1760:	656e6769 	strbvs	r6, [lr, #-1897]!	@ 0xfffff897
    1764:	68632064 	stmdavs	r3!, {r2, r5, r6, sp}^
    1768:	5f007261 	svcpl	0x00007261
    176c:	42444c5f 	submi	r4, r4, #24320	@ 0x5f00
    1770:	414d5f4c 	cmpmi	sp, ip, asr #30
    1774:	205f5f58 	subscs	r5, pc, r8, asr pc	@ <UNPREDICTABLE>
    1778:	39372e31 	ldmdbcc	r7!, {r0, r4, r5, r9, sl, fp, sp}
    177c:	33393637 	teqcc	r9, #57671680	@ 0x3700000
    1780:	38343331 	ldmdacc	r4!, {r0, r4, r5, r8, r9, ip, sp}
    1784:	31333236 	teqcc	r3, r6, lsr r2
    1788:	2b653735 	blcs	194f464 <_exit+0x194ef94>
    178c:	4c383033 	ldcmi	0, cr3, [r8], #-204	@ 0xffffff34
    1790:	465f5f00 	ldrbmi	r5, [pc], -r0, lsl #30
    1794:	54494e49 	strbpl	r4, [r9], #-3657	@ 0xfffff1b7
    1798:	414d5f45 	cmpmi	sp, r5, asr #30
    179c:	4f5f4854 	svcmi	0x005f4854
    17a0:	5f594c4e 	svcpl	0x00594c4e
    17a4:	0030205f 	eorseq	r2, r0, pc, asr r0
    17a8:	41535f5f 	cmpmi	r3, pc, asr pc
    17ac:	4d554343 	ldclmi	3, cr4, [r5, #-268]	@ 0xfffffef4
    17b0:	58414d5f 	stmdapl	r1, {r0, r1, r2, r3, r4, r6, r8, sl, fp, lr}^
    17b4:	30205f5f 	eorcc	r5, r0, pc, asr pc
    17b8:	46463758 			@ <UNDEFINED> instruction: 0x46463758
    17bc:	372d5046 	strcc	r5, [sp, -r6, asr #32]!
    17c0:	5f004b48 	svcpl	0x00004b48
    17c4:	6d72615f 	ldclvs	1, cr6, [r2, #-380]!	@ 0xfffffe84
    17c8:	31205f5f 			@ <UNDEFINED> instruction: 0x31205f5f
    17cc:	4c5f5f00 	ldclmi	15, cr5, [pc], {-0}
    17d0:	5f4c4244 	svcpl	0x004c4244
    17d4:	544e414d 	strbpl	r4, [lr], #-333	@ 0xfffffeb3
    17d8:	4749445f 			@ <UNDEFINED> instruction: 0x4749445f
    17dc:	35205f5f 	strcc	r5, [r0, #-3935]!	@ 0xfffff0a1
    17e0:	5f5f0033 	svcpl	0x005f0033
    17e4:	495f5154 	ldmdbmi	pc, {r2, r4, r6, r8, ip, lr}^	@ <UNPREDICTABLE>
    17e8:	5f544942 	svcpl	0x00544942
    17ec:	0030205f 	eorseq	r2, r0, pc, asr r0
    17f0:	48555f5f 	ldmdami	r5, {r0, r1, r2, r3, r4, r6, r8, r9, sl, fp, ip, lr}^
    17f4:	42465f41 	submi	r5, r6, #260	@ 0x104
    17f8:	5f5f5449 	svcpl	0x005f5449
    17fc:	5f003820 	svcpl	0x00003820
    1800:	4343475f 	cmpmi	r3, #24903680	@ 0x17c0000
    1804:	4d53415f 	ldclmi	1, cr4, [r3, #-380]	@ 0xfffffe84
    1808:	414c465f 	cmpmi	ip, pc, asr r6
    180c:	554f5f47 	strbpl	r5, [pc, #-3911]	@ 8cd <_exit+0x3fd>
    1810:	54555054 	ldrbpl	r5, [r5], #-84	@ 0xffffffac
    1814:	205f5f53 	subscs	r5, pc, r3, asr pc	@ <UNPREDICTABLE>
    1818:	5f5f0031 	svcpl	0x005f0031
    181c:	5f4d5241 	svcpl	0x004d5241
    1820:	48435241 	stmdami	r3, {r0, r6, r9, ip, lr}^
    1824:	5f54345f 	svcpl	0x0054345f
    1828:	0031205f 	eorseq	r2, r1, pc, asr r0
    182c:	4c455f5f 	stclmi	15, cr5, [r5], {95}	@ 0x5f
    1830:	205f5f46 	subscs	r5, pc, r6, asr #30
    1834:	5f5f0031 	svcpl	0x005f0031
    1838:	5f4d5241 	svcpl	0x004d5241
    183c:	48435241 	stmdami	r3, {r0, r6, r9, ip, lr}^
    1840:	4f52505f 	svcmi	0x0052505f
    1844:	454c4946 	strbmi	r4, [ip, #-2374]	@ 0xfffff6ba
    1848:	545f5f00 	ldrbpl	r5, [pc], #-3840	@ 1850 <_exit+0x1380>
    184c:	424d5548 	submi	r5, sp, #72, 10	@ 0x12000000
    1850:	5f5f4c45 	svcpl	0x005f4c45
    1854:	495f5f00 	ldmdbmi	pc, {r8, r9, sl, fp, ip, lr}^	@ <UNPREDICTABLE>
    1858:	3631544e 	ldrtcc	r5, [r1], -lr, asr #8
    185c:	6328435f 			@ <UNDEFINED> instruction: 0x6328435f
    1860:	00632029 	rsbeq	r2, r3, r9, lsr #32
    1864:	43475f5f 	cmpmi	r7, #380	@ 0x17c
    1868:	41485f43 	cmpmi	r8, r3, asr #30
    186c:	445f4556 	ldrbmi	r4, [pc], #-1366	@ 1874 <_exit+0x13a4>
    1870:	46524157 			@ <UNDEFINED> instruction: 0x46524157
    1874:	46435f32 			@ <UNDEFINED> instruction: 0x46435f32
    1878:	53415f49 	cmppl	r1, #292	@ 0x124
    187c:	0031204d 	eorseq	r2, r1, sp, asr #32
    1880:	49555f5f 	ldmdbmi	r5, {r0, r1, r2, r3, r4, r6, r8, r9, sl, fp, ip, lr}^
    1884:	3436544e 	ldrtcc	r5, [r6], #-1102	@ 0xfffffbb2
    1888:	58414d5f 	stmdapl	r1, {r0, r1, r2, r3, r4, r6, r8, sl, fp, lr}^
    188c:	30205f5f 	eorcc	r5, r0, pc, asr pc
    1890:	66666678 			@ <UNDEFINED> instruction: 0x66666678
    1894:	66666666 	strbtvs	r6, [r6], -r6, ror #12
    1898:	66666666 	strbtvs	r6, [r6], -r6, ror #12
    189c:	66666666 	strbtvs	r6, [r6], -r6, ror #12
    18a0:	4c4c5566 	stclmi	5, cr5, [ip], {102}	@ 0x66
    18a4:	4c5f5f00 	ldclmi	15, cr5, [pc], {-0}
    18a8:	55434341 	strbpl	r4, [r3, #-833]	@ 0xfffffcbf
    18ac:	414d5f4d 	cmpmi	sp, sp, asr #30
    18b0:	205f5f58 	subscs	r5, pc, r8, asr pc	@ <UNPREDICTABLE>
    18b4:	46375830 			@ <UNDEFINED> instruction: 0x46375830
    18b8:	46464646 	strbmi	r4, [r6], -r6, asr #12
    18bc:	46464646 	strbmi	r4, [r6], -r6, asr #12
    18c0:	46464646 	strbmi	r4, [r6], -r6, asr #12
    18c4:	2d504646 	ldclcs	6, cr4, [r0, #-280]	@ 0xfffffee8
    18c8:	4b4c3133 	blmi	130dd9c <_exit+0x130d8cc>
    18cc:	495f5f00 	ldmdbmi	pc, {r8, r9, sl, fp, ip, lr}^	@ <UNPREDICTABLE>
    18d0:	465f544e 	ldrbmi	r5, [pc], -lr, asr #8
    18d4:	33545341 	cmpcc	r4, #67108865	@ 0x4000001
    18d8:	414d5f32 	cmpmi	sp, r2, lsr pc
    18dc:	205f5f58 	subscs	r5, pc, r8, asr pc	@ <UNPREDICTABLE>
    18e0:	66377830 			@ <UNDEFINED> instruction: 0x66377830
    18e4:	66666666 	strbtvs	r6, [r6], -r6, ror #12
    18e8:	5f006666 	svcpl	0x00006666
    18ec:	4653555f 			@ <UNDEFINED> instruction: 0x4653555f
    18f0:	54434152 	strbpl	r4, [r3], #-338	@ 0xfffffeae
    18f4:	5350455f 	cmppl	r0, #398458880	@ 0x17c00000
    18f8:	4e4f4c49 	cdpmi	12, 4, cr4, cr15, cr9, {2}
    18fc:	30205f5f 	eorcc	r5, r0, pc, asr pc
    1900:	2d503178 	ldclcs	1, cr3, [r0, #-480]	@ 0xfffffe20
    1904:	52485538 	subpl	r5, r8, #56, 10	@ 0xe000000
    1908:	415f5f00 	cmpmi	pc, r0, lsl #30
    190c:	494d4f54 	stmdbmi	sp, {r2, r4, r6, r8, r9, sl, fp, lr}^
    1910:	43415f43 	cmpmi	r1, #268	@ 0x10c
    1914:	52495551 	subpl	r5, r9, #339738624	@ 0x14400000
    1918:	00322045 	eorseq	r2, r2, r5, asr #32
    191c:	54535f5f 	ldrbpl	r5, [r3], #-3935	@ 0xfffff0a1
    1920:	5f5f4344 	svcpl	0x005f4344
    1924:	5f003120 	svcpl	0x00003120
    1928:	5a49535f 	bpl	12566ac <_exit+0x12561dc>
    192c:	5f464f45 	svcpl	0x00464f45
    1930:	474e4f4c 	strbmi	r4, [lr, -ip, asr #30]
    1934:	34205f5f 	strtcc	r5, [r0], #-3935	@ 0xfffff0a1
    1938:	445f5f00 	ldrbmi	r5, [pc], #-3840	@ 1940 <_exit+0x1470>
    193c:	4d5f4c42 	ldclmi	12, cr4, [pc, #-264]	@ 183c <_exit+0x136c>
    1940:	455f5841 	ldrbmi	r5, [pc, #-2113]	@ 1107 <_exit+0xc37>
    1944:	5f5f5058 	svcpl	0x005f5058
    1948:	32303120 	eorscc	r3, r0, #32, 2
    194c:	5f5f0034 	svcpl	0x005f0034
    1950:	4d4f5441 	stclmi	4, cr5, [pc, #-260]	@ 1854 <_exit+0x1384>
    1954:	435f4349 	cmpmi	pc, #603979777	@ 0x24000001
    1958:	55534e4f 	ldrbpl	r4, [r3, #-3663]	@ 0xfffff1b1
    195c:	3120454d 			@ <UNDEFINED> instruction: 0x3120454d
    1960:	495f5f00 	ldmdbmi	pc, {r8, r9, sl, fp, ip, lr}^	@ <UNPREDICTABLE>
    1964:	465f544e 	ldrbmi	r5, [pc], -lr, asr #8
    1968:	33545341 	cmpcc	r4, #67108865	@ 0x4000001
    196c:	49575f32 	ldmdbmi	r7, {r1, r4, r5, r8, r9, sl, fp, ip, lr}^
    1970:	5f485444 	svcpl	0x00485444
    1974:	3233205f 	eorscc	r2, r3, #95	@ 0x5f
    1978:	415f5f00 	cmpmi	pc, r0, lsl #30
    197c:	425f4d52 	subsmi	r4, pc, #5248	@ 0x1480
    1980:	5f363146 	svcpl	0x00363146
    1984:	4d524f46 	ldclmi	15, cr4, [r2, #-280]	@ 0xfffffee8
    1988:	415f5441 	cmpmi	pc, r1, asr #8
    198c:	5245544c 	subpl	r5, r5, #76, 8	@ 0x4c000000
    1990:	4954414e 	ldmdbmi	r4, {r1, r2, r3, r6, r8, lr}^
    1994:	5f004556 	svcpl	0x00004556
    1998:	4e49575f 	mcrmi	7, 2, r5, cr9, cr15, {2}
    199c:	59545f54 	ldmdbpl	r4, {r2, r4, r6, r8, r9, sl, fp, ip, lr}^
    19a0:	5f5f4550 	svcpl	0x005f4550
    19a4:	736e7520 	cmnvc	lr, #32, 10	@ 0x8000000
    19a8:	656e6769 	strbvs	r6, [lr, #-1897]!	@ 0xfffff897
    19ac:	6e692064 	cdpvs	0, 6, cr2, cr9, cr4, {3}
    19b0:	5f5f0074 	svcpl	0x005f0074
    19b4:	474e4f4c 	strbmi	r4, [lr, -ip, asr #30]
    19b8:	58414d5f 	stmdapl	r1, {r0, r1, r2, r3, r4, r6, r8, sl, fp, lr}^
    19bc:	30205f5f 	eorcc	r5, r0, pc, asr pc
    19c0:	66663778 			@ <UNDEFINED> instruction: 0x66663778
    19c4:	66666666 	strbtvs	r6, [r6], -r6, ror #12
    19c8:	5f004c66 	svcpl	0x00004c66
    19cc:	544e495f 	strbpl	r4, [lr], #-2399	@ 0xfffff6a1
    19d0:	4d5f3631 	ldclmi	6, cr3, [pc, #-196]	@ 1914 <_exit+0x1444>
    19d4:	5f5f5841 	svcpl	0x005f5841
    19d8:	37783020 	ldrbcc	r3, [r8, -r0, lsr #32]!
    19dc:	00666666 	rsbeq	r6, r6, r6, ror #12
    19e0:	4c555f5f 	ldclmi	15, cr5, [r5], {95}	@ 0x5f
    19e4:	43415246 	cmpmi	r1, #1610612740	@ 0x60000004
    19e8:	42465f54 	submi	r5, r6, #84, 30	@ 0x150
    19ec:	5f5f5449 	svcpl	0x005f5449
    19f0:	00323320 	eorseq	r3, r2, r0, lsr #6
    19f4:	43535f5f 	cmpmi	r3, #380	@ 0x17c
    19f8:	5f524148 	svcpl	0x00524148
    19fc:	54444957 	strbpl	r4, [r4], #-2391	@ 0xfffff6a9
    1a00:	205f5f48 	subscs	r5, pc, r8, asr #30
    1a04:	5f5f0038 	svcpl	0x005f0038
    1a08:	55434341 	strbpl	r4, [r3, #-833]	@ 0xfffffcbf
    1a0c:	494d5f4d 	stmdbmi	sp, {r0, r2, r3, r6, r8, r9, sl, fp, ip, lr}^
    1a10:	205f5f4e 	subscs	r5, pc, lr, asr #30
    1a14:	58302d28 	ldmdapl	r0!, {r3, r5, r8, sl, fp, sp}
    1a18:	35315031 	ldrcc	r5, [r1, #-49]!	@ 0xffffffcf
    1a1c:	58302d4b 	ldmdapl	r0!, {r0, r1, r3, r6, r8, sl, fp, sp}
    1a20:	35315031 	ldrcc	r5, [r1, #-49]!	@ 0xffffffcf
    1a24:	5f00294b 	svcpl	0x0000294b
    1a28:	5a49535f 	bpl	12567ac <_exit+0x12562dc>
    1a2c:	5f464f45 	svcpl	0x00464f45
    1a30:	42554f44 	subsmi	r4, r5, #68, 30	@ 0x110
    1a34:	5f5f454c 	svcpl	0x005f454c
    1a38:	5f003820 	svcpl	0x00003820
    1a3c:	554e475f 	strbpl	r4, [lr, #-1887]	@ 0xfffff8a1
    1a40:	41505f43 	cmpmi	r0, r3, asr #30
    1a44:	4c484354 	stclmi	3, cr4, [r8], {84}	@ 0x54
    1a48:	4c455645 	stclmi	6, cr5, [r5], {69}	@ 0x45
    1a4c:	30205f5f 	eorcc	r5, r0, pc, asr pc
    1a50:	475f5f00 	ldrbmi	r5, [pc, -r0, lsl #30]
    1a54:	545f5858 	ldrbpl	r5, [pc], #-2136	@ 1a5c <_exit+0x158c>
    1a58:	49455059 	stmdbmi	r5, {r0, r3, r4, r6, ip, lr}^
    1a5c:	5f4f464e 	svcpl	0x004f464e
    1a60:	41555145 	cmpmi	r5, r5, asr #2
    1a64:	5954494c 	ldmdbpl	r4, {r2, r3, r6, r8, fp, lr}^
    1a68:	4c4e495f 			@ <UNDEFINED> instruction: 0x4c4e495f
    1a6c:	20454e49 	subcs	r4, r5, r9, asr #28
    1a70:	5f5f0030 	svcpl	0x005f0030
    1a74:	5f4d5241 	svcpl	0x004d5241
    1a78:	48435241 	stmdami	r3, {r0, r6, r9, ip, lr}^
    1a7c:	5458455f 	ldrbpl	r4, [r8], #-1375	@ 0xfffffaa1
    1a80:	4944495f 	stmdbmi	r4, {r0, r1, r2, r3, r4, r6, r8, fp, lr}^
    1a84:	005f5f56 	subseq	r5, pc, r6, asr pc	@ <UNPREDICTABLE>
    1a88:	52465f5f 	subpl	r5, r6, #380	@ 0x17c
    1a8c:	5f544341 	svcpl	0x00544341
    1a90:	5f58414d 	svcpl	0x0058414d
    1a94:	5830205f 	ldmdapl	r0!, {r0, r1, r2, r3, r4, r6, sp}
    1a98:	46464637 			@ <UNDEFINED> instruction: 0x46464637
    1a9c:	35312d50 	ldrcc	r2, [r1, #-3408]!	@ 0xfffff2b0
    1aa0:	5f5f0052 	svcpl	0x005f0052
    1aa4:	36544e49 	ldrbcc	r4, [r4], -r9, asr #28
    1aa8:	59545f34 	ldmdbpl	r4, {r2, r4, r5, r8, r9, sl, fp, ip, lr}^
    1aac:	5f5f4550 	svcpl	0x005f4550
    1ab0:	6e6f6c20 	cdpvs	12, 6, cr6, cr15, cr0, {1}
    1ab4:	6f6c2067 	svcvs	0x006c2067
    1ab8:	6920676e 	stmdbvs	r0!, {r1, r2, r3, r5, r6, r8, r9, sl, sp, lr}
    1abc:	5f00746e 	svcpl	0x0000746e
    1ac0:	414c555f 	cmpmi	ip, pc, asr r5
    1ac4:	4d554343 	ldclmi	3, cr4, [r5, #-268]	@ 0xfffffef4
    1ac8:	4942465f 	stmdbmi	r2, {r0, r1, r2, r3, r4, r6, r9, sl, lr}^
    1acc:	205f5f54 	subscs	r5, pc, r4, asr pc	@ <UNPREDICTABLE>
    1ad0:	5f003233 	svcpl	0x00003233
    1ad4:	544c465f 	strbpl	r4, [ip], #-1631	@ 0xfffff9a1
    1ad8:	524f4e5f 	subpl	r4, pc, #1520	@ 0x5f0
    1adc:	414d5f4d 	cmpmi	sp, sp, asr #30
    1ae0:	205f5f58 	subscs	r5, pc, r8, asr pc	@ <UNPREDICTABLE>
    1ae4:	30342e33 	eorscc	r2, r4, r3, lsr lr
    1ae8:	33323832 	teqcc	r2, #3276800	@ 0x320000
    1aec:	33363634 	teqcc	r6, #52, 12	@ 0x3400000
    1af0:	38323538 	ldmdacc	r2!, {r3, r4, r5, r8, sl, ip, sp}
    1af4:	2b653638 	blcs	194f3dc <_exit+0x194ef0c>
    1af8:	00463833 	subeq	r3, r6, r3, lsr r8
    1afc:	46555f5f 			@ <UNDEFINED> instruction: 0x46555f5f
    1b00:	54434152 	strbpl	r4, [r3], #-338	@ 0xfffffeae
    1b04:	4e494d5f 	mcrmi	13, 2, r4, cr9, cr15, {2}
    1b08:	30205f5f 	eorcc	r5, r0, pc, asr pc
    1b0c:	5255302e 	subspl	r3, r5, #46	@ 0x2e
    1b10:	415f5f00 	cmpmi	pc, r0, lsl #30
    1b14:	4e5f4d52 	mrcmi	13, 2, r4, cr15, cr2, {2}
    1b18:	5f4e4f45 	svcpl	0x004e4f45
    1b1c:	5f005046 	svcpl	0x00005046
    1b20:	4454535f 	ldrbmi	r5, [r4], #-863	@ 0xfffffca1
    1b24:	54555f43 	ldrbpl	r5, [r5], #-3907	@ 0xfffff0bd
    1b28:	36315f46 	ldrtcc	r5, [r1], -r6, asr #30
    1b2c:	31205f5f 			@ <UNDEFINED> instruction: 0x31205f5f
    1b30:	555f5f00 	ldrbpl	r5, [pc, #-3840]	@ c38 <_exit+0x768>
    1b34:	43414c4c 	cmpmi	r1, #76, 24	@ 0x4c00
    1b38:	5f4d5543 	svcpl	0x004d5543
    1b3c:	54494249 	strbpl	r4, [r9], #-585	@ 0xfffffdb7
    1b40:	33205f5f 			@ <UNDEFINED> instruction: 0x33205f5f
    1b44:	5f5f0032 	svcpl	0x005f0032
    1b48:	495f4144 	ldmdbmi	pc, {r2, r6, r8, lr}^	@ <UNPREDICTABLE>
    1b4c:	5f544942 	svcpl	0x00544942
    1b50:	3233205f 	eorscc	r2, r3, #95	@ 0x5f
    1b54:	4c5f5f00 	ldclmi	15, cr5, [pc], {-0}
    1b58:	5f4c4244 	svcpl	0x004c4244
    1b5c:	5f4e494d 	svcpl	0x004e494d
    1b60:	2e32205f 	mrccs	0, 1, r2, cr2, cr15, {2}
    1b64:	30353232 	eorscc	r3, r5, r2, lsr r2
    1b68:	35383337 	ldrcc	r3, [r8, #-823]!	@ 0xfffffcc9
    1b6c:	37303538 			@ <UNDEFINED> instruction: 0x37303538
    1b70:	34313032 	ldrtcc	r3, [r1], #-50	@ 0xffffffce
    1b74:	30332d65 	eorscc	r2, r3, r5, ror #26
    1b78:	5f004c38 	svcpl	0x00004c38
    1b7c:	42444c5f 	submi	r4, r4, #24320	@ 0x5f00
    1b80:	41485f4c 	cmpmi	r8, ip, asr #30
    1b84:	4e495f53 	mcrmi	15, 2, r5, cr9, cr3, {2}
    1b88:	494e4946 	stmdbmi	lr, {r1, r2, r6, r8, fp, lr}^
    1b8c:	5f5f5954 	svcpl	0x005f5954
    1b90:	5f003120 	svcpl	0x00003120
    1b94:	4343475f 	cmpmi	r3, #24903680	@ 0x17c0000
    1b98:	4345495f 	cmpmi	r5, #1556480	@ 0x17c000
    1b9c:	3935355f 	ldmdbcc	r5!, {r0, r1, r2, r3, r4, r6, r8, sl, ip, sp}
    1ba0:	4d4f435f 	stclmi	3, cr4, [pc, #-380]	@ 1a2c <_exit+0x155c>
    1ba4:	58454c50 	stmdapl	r5, {r4, r6, sl, fp, lr}^
    1ba8:	5f003020 	svcpl	0x00003020
    1bac:	4e49555f 	mcrmi	5, 2, r5, cr9, cr15, {2}
    1bb0:	5f323354 	svcpl	0x00323354
    1bb4:	5f58414d 	svcpl	0x0058414d
    1bb8:	7830205f 	ldmdavc	r0!, {r0, r1, r2, r3, r4, r6, sp}
    1bbc:	66666666 	strbtvs	r6, [r6], -r6, ror #12
    1bc0:	66666666 	strbtvs	r6, [r6], -r6, ror #12
    1bc4:	5f004c55 	svcpl	0x00004c55
    1bc8:	42444c5f 	submi	r4, r4, #24320	@ 0x5f00
    1bcc:	494d5f4c 	stmdbmi	sp, {r2, r3, r6, r8, r9, sl, fp, ip, lr}^
    1bd0:	58455f4e 	stmdapl	r5, {r1, r2, r3, r6, r8, r9, sl, fp, ip, lr}^
    1bd4:	205f5f50 	subscs	r5, pc, r0, asr pc	@ <UNPREDICTABLE>
    1bd8:	30312d28 	eorscc	r2, r1, r8, lsr #26
    1bdc:	00293132 	eoreq	r3, r9, r2, lsr r1
    1be0:	4c555f5f 	ldclmi	15, cr5, [r5], {95}	@ 0x5f
    1be4:	4152464c 	cmpmi	r2, ip, asr #12
    1be8:	465f5443 	ldrbmi	r5, [pc], -r3, asr #8
    1bec:	5f544942 	svcpl	0x00544942
    1bf0:	3436205f 	ldrtcc	r2, [r6], #-95	@ 0xffffffa1
    1bf4:	535f5f00 	cmppl	pc, #0, 30
    1bf8:	4f455a49 	svcmi	0x00455a49
    1bfc:	43575f46 	cmpmi	r7, #280	@ 0x118
    1c00:	5f524148 	svcpl	0x00524148
    1c04:	205f5f54 	subscs	r5, pc, r4, asr pc	@ <UNPREDICTABLE>
    1c08:	5f5f0034 	svcpl	0x005f0034
    1c0c:	5f4d5241 	svcpl	0x004d5241
    1c10:	48435241 	stmdami	r3, {r0, r6, r9, ip, lr}^
    1c14:	4153495f 	cmpmi	r3, pc, asr r9
    1c18:	4d52415f 	ldclmi	1, cr4, [r2, #-380]	@ 0xfffffe84
    1c1c:	61003120 	tstvs	r0, r0, lsr #2
    1c20:	00636772 	rsbeq	r6, r3, r2, ror r7
    1c24:	4c465f5f 	stclmi	15, cr5, [r6], {95}	@ 0x5f
    1c28:	5f54414f 	svcpl	0x0054414f
    1c2c:	44524f57 	ldrbmi	r4, [r2], #-3927	@ 0xfffff0a9
    1c30:	44524f5f 	ldrbmi	r4, [r2], #-3935	@ 0xfffff0a1
    1c34:	5f5f5245 	svcpl	0x005f5245
    1c38:	4f5f5f20 	svcmi	0x005f5f20
    1c3c:	52454452 	subpl	r4, r5, #1375731712	@ 0x52000000
    1c40:	54494c5f 	strbpl	r4, [r9], #-3167	@ 0xfffff3a1
    1c44:	5f454c54 	svcpl	0x00454c54
    1c48:	49444e45 	stmdbmi	r4, {r0, r2, r6, r9, sl, fp, lr}^
    1c4c:	5f5f4e41 	svcpl	0x005f4e41
    1c50:	415f5f00 	cmpmi	pc, r0, lsl #30
    1c54:	4d554343 	ldclmi	3, cr4, [r5, #-268]	@ 0xfffffef4
    1c58:	58414d5f 	stmdapl	r1, {r0, r1, r2, r3, r4, r6, r8, sl, fp, lr}^
    1c5c:	30205f5f 	eorcc	r5, r0, pc, asr pc
    1c60:	46463758 			@ <UNDEFINED> instruction: 0x46463758
    1c64:	46464646 	strbmi	r4, [r6], -r6, asr #12
    1c68:	312d5046 			@ <UNDEFINED> instruction: 0x312d5046
    1c6c:	5f004b35 	svcpl	0x00004b35
    1c70:	5a49535f 	bpl	12569f4 <_exit+0x1256524>
    1c74:	49575f45 	ldmdbmi	r7, {r0, r2, r6, r8, r9, sl, fp, ip, lr}^
    1c78:	5f485444 	svcpl	0x00485444
    1c7c:	3233205f 	eorscc	r2, r3, #95	@ 0x5f
    1c80:	415f5f00 	cmpmi	pc, r0, lsl #30
    1c84:	465f4d52 			@ <UNDEFINED> instruction: 0x465f4d52
    1c88:	55544145 	ldrbpl	r4, [r4, #-325]	@ 0xfffffebb
    1c8c:	4d5f4552 	ldclmi	5, cr4, [pc, #-328]	@ 1b4c <_exit+0x167c>
    1c90:	5f004556 	svcpl	0x00004556
    1c94:	4749535f 			@ <UNDEFINED> instruction: 0x4749535f
    1c98:	4f54415f 	svcmi	0x0054415f
    1c9c:	5f43494d 	svcpl	0x0043494d
    1ca0:	5f4e494d 	svcpl	0x004e494d
    1ca4:	2d28205f 	stccs	0, cr2, [r8, #-380]!	@ 0xfffffe84
    1ca8:	49535f5f 	ldmdbmi	r3, {r0, r1, r2, r3, r4, r6, r8, r9, sl, fp, ip, lr}^
    1cac:	54415f47 	strbpl	r5, [r1], #-3911	@ 0xfffff0b9
    1cb0:	43494d4f 	cmpmi	r9, #5056	@ 0x13c0
    1cb4:	58414d5f 	stmdapl	r1, {r0, r1, r2, r3, r4, r6, r8, sl, fp, lr}^
    1cb8:	2d205f5f 	stccs	15, cr5, [r0, #-380]!	@ 0xfffffe84
    1cbc:	00293120 	eoreq	r3, r9, r0, lsr #2
    1cc0:	4c4c5f5f 	stclmi	15, cr5, [ip], {95}	@ 0x5f
    1cc4:	43415246 	cmpmi	r1, #1610612740	@ 0x60000004
    1cc8:	50455f54 	subpl	r5, r5, r4, asr pc
    1ccc:	4f4c4953 	svcmi	0x004c4953
    1cd0:	205f5f4e 	subscs	r5, pc, lr, asr #30
    1cd4:	50317830 	eorspl	r7, r1, r0, lsr r8
    1cd8:	4c33362d 	ldcmi	6, cr3, [r3], #-180	@ 0xffffff4c
    1cdc:	5f00524c 	svcpl	0x0000524c
    1ce0:	4e4f4c5f 	mcrmi	12, 2, r4, cr15, cr15, {2}
    1ce4:	49575f47 	ldmdbmi	r7, {r0, r1, r2, r6, r8, r9, sl, fp, ip, lr}^
    1ce8:	5f485444 	svcpl	0x00485444
    1cec:	3233205f 	eorscc	r2, r3, #95	@ 0x5f
    1cf0:	535f5f00 	cmppl	pc, #0, 30
    1cf4:	43415246 	cmpmi	r1, #1610612740	@ 0x60000004
    1cf8:	42465f54 	submi	r5, r6, #84, 30	@ 0x150
    1cfc:	5f5f5449 	svcpl	0x005f5449
    1d00:	5f003720 	svcpl	0x00003720
    1d04:	4148435f 	cmpmi	r8, pc, asr r3
    1d08:	5f323352 	svcpl	0x00323352
    1d0c:	45505954 	ldrbmi	r5, [r0, #-2388]	@ 0xfffff6ac
    1d10:	6c205f5f 	stcvs	15, cr5, [r0], #-380	@ 0xfffffe84
    1d14:	20676e6f 	rsbcs	r6, r7, pc, ror #28
    1d18:	69736e75 	ldmdbvs	r3!, {r0, r2, r4, r5, r6, r9, sl, fp, sp, lr}^
    1d1c:	64656e67 	strbtvs	r6, [r5], #-3687	@ 0xfffff199
    1d20:	746e6920 	strbtvc	r6, [lr], #-2336	@ 0xfffff6e0
    1d24:	535f5f00 	cmppl	pc, #0, 30
    1d28:	43415246 	cmpmi	r1, #1610612740	@ 0x60000004
    1d2c:	42495f54 	submi	r5, r9, #84, 30	@ 0x150
    1d30:	5f5f5449 	svcpl	0x005f5449
    1d34:	5f003020 	svcpl	0x00003020
    1d38:	4d52415f 	ldclmi	1, cr4, [r2, #-380]	@ 0xfffffe84
    1d3c:	4145465f 	cmpmi	r5, pc, asr r6
    1d40:	45525554 	ldrbmi	r5, [r2, #-1364]	@ 0xfffffaac
    1d44:	5441535f 	strbpl	r5, [r1], #-863	@ 0xfffffca1
    1d48:	415f5f00 	cmpmi	pc, r0, lsl #30
    1d4c:	505f4d52 	subspl	r4, pc, r2, asr sp	@ <UNPREDICTABLE>
    1d50:	31205343 			@ <UNDEFINED> instruction: 0x31205343
    1d54:	485f5f00 	ldmdami	pc, {r8, r9, sl, fp, ip, lr}^	@ <UNPREDICTABLE>
    1d58:	42495f51 	submi	r5, r9, #324	@ 0x144
    1d5c:	5f5f5449 	svcpl	0x005f5449
    1d60:	5f003020 	svcpl	0x00003020
    1d64:	544c465f 	strbpl	r4, [ip], #-1631	@ 0xfffff9a1
    1d68:	4e45445f 	mcrmi	4, 2, r4, cr5, cr15, {2}
    1d6c:	5f4d524f 	svcpl	0x004d524f
    1d70:	5f4e494d 	svcpl	0x004e494d
    1d74:	2e31205f 	mrccs	0, 1, r2, cr1, cr15, {2}
    1d78:	32313034 	eorscc	r3, r1, #52	@ 0x34
    1d7c:	36343839 			@ <UNDEFINED> instruction: 0x36343839
    1d80:	34323334 	ldrtcc	r3, [r2], #-820	@ 0xfffffccc
    1d84:	31373138 	teqcc	r7, r8, lsr r1
    1d88:	35342d65 	ldrcc	r2, [r4, #-3429]!	@ 0xfffff29b
    1d8c:	5f5f0046 	svcpl	0x005f0046
    1d90:	544e4955 	strbpl	r4, [lr], #-2389	@ 0xfffff6ab
    1d94:	41454c5f 	cmpmi	r5, pc, asr ip
    1d98:	32335453 	eorscc	r5, r3, #1392508928	@ 0x53000000
    1d9c:	5059545f 	subspl	r5, r9, pc, asr r4
    1da0:	205f5f45 	subscs	r5, pc, r5, asr #30
    1da4:	676e6f6c 	strbvs	r6, [lr, -ip, ror #30]!
    1da8:	736e7520 	cmnvc	lr, #32, 10	@ 0x8000000
    1dac:	656e6769 	strbvs	r6, [lr, #-1897]!	@ 0xfffff897
    1db0:	6e692064 	cdpvs	0, 6, cr2, cr9, cr4, {3}
    1db4:	5f5f0074 	svcpl	0x005f0074
    1db8:	465f5144 	ldrbmi	r5, [pc], -r4, asr #2
    1dbc:	5f544942 	svcpl	0x00544942
    1dc0:	3336205f 	teqcc	r6, #95	@ 0x5f
    1dc4:	555f5f00 	ldrbpl	r5, [pc, #-3840]	@ ecc <_exit+0x9fc>
    1dc8:	495f4148 	ldmdbmi	pc, {r3, r6, r8, lr}^	@ <UNPREDICTABLE>
    1dcc:	5f544942 	svcpl	0x00544942
    1dd0:	0038205f 	eorseq	r2, r8, pc, asr r0
    1dd4:	49535f5f 	ldmdbmi	r3, {r0, r1, r2, r3, r4, r6, r8, r9, sl, fp, ip, lr}^
    1dd8:	54415f47 	strbpl	r5, [r1], #-3911	@ 0xfffff0b9
    1ddc:	43494d4f 	cmpmi	r9, #5056	@ 0x13c0
    1de0:	4449575f 	strbmi	r5, [r9], #-1887	@ 0xfffff8a1
    1de4:	5f5f4854 	svcpl	0x005f4854
    1de8:	00323320 	eorseq	r3, r2, r0, lsr #6
    1dec:	52415f5f 	subpl	r5, r1, #380	@ 0x17c
    1df0:	45465f4d 	strbmi	r5, [r6, #-3917]	@ 0xfffff0b3
    1df4:	52555441 	subspl	r5, r5, #1090519040	@ 0x41000000
    1df8:	46425f45 	strbmi	r5, [r2], -r5, asr #30
    1dfc:	565f3631 			@ <UNDEFINED> instruction: 0x565f3631
    1e00:	4f544345 	svcmi	0x00544345
    1e04:	52415f52 	subpl	r5, r1, #328	@ 0x148
    1e08:	4d485449 	stclmi	4, cr5, [r8, #-292]	@ 0xfffffedc
    1e0c:	43495445 	cmpmi	r9, #1157627904	@ 0x45000000
    1e10:	535f5f00 	cmppl	pc, #0, 30
    1e14:	5f545248 	svcpl	0x00545248
    1e18:	5f58414d 	svcpl	0x0058414d
    1e1c:	7830205f 	ldmdavc	r0!, {r0, r1, r2, r3, r4, r6, sp}
    1e20:	66666637 			@ <UNDEFINED> instruction: 0x66666637
    1e24:	415f5f00 	cmpmi	pc, r0, lsl #30
    1e28:	465f4d52 			@ <UNDEFINED> instruction: 0x465f4d52
    1e2c:	5f363150 	svcpl	0x00363150
    1e30:	53475241 	cmppl	r7, #268435460	@ 0x10000004
    1e34:	4f5f5f00 	svcmi	0x005f5f00
    1e38:	52454452 	subpl	r4, r5, #1375731712	@ 0x52000000
    1e3c:	5044505f 	subpl	r5, r4, pc, asr r0
    1e40:	444e455f 	strbmi	r4, [lr], #-1375	@ 0xfffffaa1
    1e44:	5f4e4149 	svcpl	0x004e4149
    1e48:	3433205f 	ldrtcc	r2, [r3], #-95	@ 0xffffffa1
    1e4c:	5f003231 	svcpl	0x00003231
    1e50:	5f51535f 	svcpl	0x0051535f
    1e54:	54494249 	strbpl	r4, [r9], #-585	@ 0xfffffdb7
    1e58:	30205f5f 	eorcc	r5, r0, pc, asr pc
    1e5c:	465f5f00 	ldrbmi	r5, [pc], -r0, lsl #30
    1e60:	3233544c 	eorscc	r5, r3, #76, 8	@ 0x4c000000
    1e64:	524f4e5f 	subpl	r4, pc, #1520	@ 0x5f0
    1e68:	414d5f4d 	cmpmi	sp, sp, asr #30
    1e6c:	205f5f58 	subscs	r5, pc, r8, asr pc	@ <UNPREDICTABLE>
    1e70:	30342e33 	eorscc	r2, r4, r3, lsr lr
    1e74:	33323832 	teqcc	r2, #3276800	@ 0x320000
    1e78:	33363634 	teqcc	r6, #52, 12	@ 0x3400000
    1e7c:	38323538 	ldmdacc	r2!, {r3, r4, r5, r8, sl, ip, sp}
    1e80:	2b653638 	blcs	194f768 <_exit+0x194f298>
    1e84:	33463833 	cmpcc	r6, #3342336	@ 0x330000
    1e88:	5f5f0032 	svcpl	0x005f0032
    1e8c:	5f544c46 	svcpl	0x00544c46
    1e90:	49434544 	stmdbmi	r3, {r2, r6, r8, sl, lr}^
    1e94:	5f4c414d 	svcpl	0x004c414d
    1e98:	5f474944 	svcpl	0x00474944
    1e9c:	0039205f 	eorseq	r2, r9, pc, asr r0
    1ea0:	4e495f5f 	mcrmi	15, 2, r5, cr9, cr15, {2}
    1ea4:	5f323354 	svcpl	0x00323354
    1ea8:	5f58414d 	svcpl	0x0058414d
    1eac:	7830205f 	ldmdavc	r0!, {r0, r1, r2, r3, r4, r6, sp}
    1eb0:	66666637 			@ <UNDEFINED> instruction: 0x66666637
    1eb4:	66666666 	strbtvs	r6, [r6], -r6, ror #12
    1eb8:	5f5f004c 	svcpl	0x005f004c
    1ebc:	544e4957 	strbpl	r4, [lr], #-2391	@ 0xfffff6a9
    1ec0:	4449575f 	strbmi	r5, [r9], #-1887	@ 0xfffff8a1
    1ec4:	5f5f4854 	svcpl	0x005f4854
    1ec8:	00323320 	eorseq	r3, r2, r0, lsr #6
    1ecc:	51555f5f 	cmppl	r5, pc, asr pc
    1ed0:	42465f51 	submi	r5, r6, #324	@ 0x144
    1ed4:	5f5f5449 	svcpl	0x005f5449
    1ed8:	5f003820 	svcpl	0x00003820
    1edc:	5153555f 	cmppl	r3, pc, asr r5
    1ee0:	4942495f 	stmdbmi	r2, {r0, r1, r2, r3, r4, r6, r8, fp, lr}^
    1ee4:	205f5f54 	subscs	r5, pc, r4, asr pc	@ <UNPREDICTABLE>
    1ee8:	5f5f0030 	svcpl	0x005f0030
    1eec:	41524655 	cmpmi	r2, r5, asr r6
    1ef0:	455f5443 	ldrbmi	r5, [pc, #-1091]	@ 1ab5 <_exit+0x15e5>
    1ef4:	4c495350 	stclmi	3, cr5, [r9], {80}	@ 0x50
    1ef8:	5f5f4e4f 	svcpl	0x005f4e4f
    1efc:	31783020 	cmncc	r8, r0, lsr #32
    1f00:	36312d50 			@ <UNDEFINED> instruction: 0x36312d50
    1f04:	5f005255 	svcpl	0x00005255
    1f08:	544e495f 	strbpl	r4, [lr], #-2399	@ 0xfffff6a1
    1f0c:	41454c5f 	cmpmi	r5, pc, asr ip
    1f10:	34365453 	ldrtcc	r5, [r6], #-1107	@ 0xfffffbad
    1f14:	4449575f 	strbmi	r5, [r9], #-1887	@ 0xfffff8a1
    1f18:	5f5f4854 	svcpl	0x005f4854
    1f1c:	00343620 	eorseq	r3, r4, r0, lsr #12
    1f20:	4e495f5f 	mcrmi	15, 2, r5, cr9, cr15, {2}
    1f24:	5f323354 	svcpl	0x00323354
    1f28:	45505954 	ldrbmi	r5, [r0, #-2388]	@ 0xfffff6ac
    1f2c:	6c205f5f 	stcvs	15, cr5, [r0], #-380	@ 0xfffffe84
    1f30:	20676e6f 	rsbcs	r6, r7, pc, ror #28
    1f34:	00746e69 	rsbseq	r6, r4, r9, ror #28
    1f38:	4c465f5f 	stclmi	15, cr5, [r6], {95}	@ 0x5f
    1f3c:	58323354 	ldmdapl	r2!, {r2, r4, r6, r8, r9, ip, sp}
    1f40:	4e494d5f 	mcrmi	13, 2, r4, cr9, cr15, {2}
    1f44:	5f30315f 	svcpl	0x0030315f
    1f48:	5f505845 	svcpl	0x00505845
    1f4c:	2d28205f 	stccs	0, cr2, [r8, #-380]!	@ 0xfffffe84
    1f50:	29373033 	ldmdbcs	r7!, {r0, r1, r4, r5, ip, sp}
    1f54:	415f5f00 	cmpmi	pc, r0, lsl #30
    1f58:	465f4d52 			@ <UNDEFINED> instruction: 0x465f4d52
    1f5c:	55544145 	ldrbpl	r4, [r4, #-325]	@ 0xfffffebb
    1f60:	425f4552 	subsmi	r4, pc, #343932928	@ 0x14800000
    1f64:	5f363146 	svcpl	0x00363146
    1f68:	4c414353 	stclmi	3, cr4, [r1], {83}	@ 0x53
    1f6c:	415f5241 	cmpmi	pc, r1, asr #4
    1f70:	48544952 	ldmdami	r4, {r1, r4, r6, r8, fp, lr}^
    1f74:	4954454d 	ldmdbmi	r4, {r0, r2, r3, r6, r8, sl, lr}^
    1f78:	5f5f0043 	svcpl	0x005f0043
    1f7c:	544e4955 	strbpl	r4, [lr], #-2389	@ 0xfffff6ab
    1f80:	5341465f 	cmppl	r1, #99614720	@ 0x5f00000
    1f84:	5f323354 	svcpl	0x00323354
    1f88:	45505954 	ldrbmi	r5, [r0, #-2388]	@ 0xfffff6ac
    1f8c:	75205f5f 	strvc	r5, [r0, #-3935]!	@ 0xfffff0a1
    1f90:	6769736e 	strbvs	r7, [r9, -lr, ror #6]!
    1f94:	2064656e 	rsbcs	r6, r4, lr, ror #10
    1f98:	00746e69 	rsbseq	r6, r4, r9, ror #28
    1f9c:	68745f5f 	ldmdavs	r4!, {r0, r1, r2, r3, r4, r6, r8, r9, sl, fp, ip, lr}^
    1fa0:	32626d75 	rsbcc	r6, r2, #7488	@ 0x1d40
    1fa4:	5f005f5f 	svcpl	0x00005f5f
    1fa8:	42444c5f 	submi	r4, r4, #24320	@ 0x5f00
    1fac:	414d5f4c 	cmpmi	sp, ip, asr #30
    1fb0:	58455f58 	stmdapl	r5, {r3, r4, r6, r8, r9, sl, fp, ip, lr}^
    1fb4:	205f5f50 	subscs	r5, pc, r0, asr pc	@ <UNPREDICTABLE>
    1fb8:	34323031 	ldrtcc	r3, [r2], #-49	@ 0xffffffcf
    1fbc:	535f5f00 	cmppl	pc, #0, 30
    1fc0:	42465f51 	submi	r5, r6, #324	@ 0x144
    1fc4:	5f5f5449 	svcpl	0x005f5449
    1fc8:	00313320 	eorseq	r3, r1, r0, lsr #6
    1fcc:	464c5f5f 			@ <UNDEFINED> instruction: 0x464c5f5f
    1fd0:	54434152 	strbpl	r4, [r3], #-338	@ 0xfffffeae
    1fd4:	4e494d5f 	mcrmi	13, 2, r4, cr9, cr15, {2}
    1fd8:	28205f5f 	stmdacs	r0!, {r0, r1, r2, r3, r4, r6, r8, r9, sl, fp, ip, lr}
    1fdc:	352e302d 	strcc	r3, [lr, #-45]!	@ 0xffffffd3
    1fe0:	302d524c 	eorcc	r5, sp, ip, asr #4
    1fe4:	524c352e 	subpl	r3, ip, #192937984	@ 0xb800000
    1fe8:	5f5f0029 	svcpl	0x005f0029
    1fec:	33544c46 	cmpcc	r4, #17920	@ 0x4600
    1ff0:	4d5f5832 	ldclmi	8, cr5, [pc, #-200]	@ 1f30 <_exit+0x1a60>
    1ff4:	455f4e49 	ldrbmi	r4, [pc, #-3657]	@ 11b3 <_exit+0xce3>
    1ff8:	5f5f5058 	svcpl	0x005f5058
    1ffc:	312d2820 			@ <UNDEFINED> instruction: 0x312d2820
    2000:	29313230 	ldmdbcs	r1!, {r4, r5, r9, ip, sp}
    2004:	465f5f00 	ldrbmi	r5, [pc], -r0, lsl #30
    2008:	3436544c 	ldrtcc	r5, [r6], #-1100	@ 0xfffffbb4
    200c:	58414d5f 	stmdapl	r1, {r0, r1, r2, r3, r4, r6, r8, sl, fp, lr}^
    2010:	31205f5f 			@ <UNDEFINED> instruction: 0x31205f5f
    2014:	3739372e 	ldrcc	r3, [r9, -lr, lsr #14]!
    2018:	31333936 	teqcc	r3, r6, lsr r9
    201c:	36383433 			@ <UNDEFINED> instruction: 0x36383433
    2020:	35313332 	ldrcc	r3, [r1, #-818]!	@ 0xfffffcce
    2024:	332b6537 			@ <UNDEFINED> instruction: 0x332b6537
    2028:	36463830 			@ <UNDEFINED> instruction: 0x36463830
    202c:	5f5f0034 	svcpl	0x005f0034
    2030:	544e4955 	strbpl	r4, [lr], #-2389	@ 0xfffff6ab
    2034:	41454c5f 	cmpmi	r5, pc, asr ip
    2038:	32335453 	eorscc	r5, r3, #1392508928	@ 0x53000000
    203c:	58414d5f 	stmdapl	r1, {r0, r1, r2, r3, r4, r6, r8, sl, fp, lr}^
    2040:	30205f5f 	eorcc	r5, r0, pc, asr pc
    2044:	66666678 			@ <UNDEFINED> instruction: 0x66666678
    2048:	66666666 	strbtvs	r6, [r6], -r6, ror #12
    204c:	004c5566 	subeq	r5, ip, r6, ror #10
    2050:	43475f5f 	cmpmi	r7, #380	@ 0x17c
    2054:	45445f43 	strbmi	r5, [r4, #-3907]	@ 0xfffff0bd
    2058:	55525453 	ldrbpl	r5, [r2, #-1107]	@ 0xfffffbad
    205c:	56495443 	strbpl	r5, [r9], -r3, asr #8
    2060:	49535f45 	ldmdbmi	r3, {r0, r2, r6, r8, r9, sl, fp, ip, lr}^
    2064:	3620455a 			@ <UNDEFINED> instruction: 0x3620455a
    2068:	5f5f0034 	svcpl	0x005f0034
    206c:	6d756874 	ldclvs	8, cr6, [r5, #-464]!	@ 0xfffffe30
    2070:	005f5f62 	subseq	r5, pc, r2, ror #30
    2074:	444c5f5f 	strbmi	r5, [ip], #-3935	@ 0xfffff0a1
    2078:	485f4c42 	ldmdami	pc, {r1, r6, sl, fp, lr}^	@ <UNPREDICTABLE>
    207c:	515f5341 	cmppl	pc, r1, asr #6
    2080:	54454955 	strbpl	r4, [r5], #-2389	@ 0xfffff6ab
    2084:	4e414e5f 	mcrmi	14, 2, r4, cr1, cr15, {2}
    2088:	31205f5f 			@ <UNDEFINED> instruction: 0x31205f5f
    208c:	495f5f00 	ldmdbmi	pc, {r8, r9, sl, fp, ip, lr}^	@ <UNPREDICTABLE>
    2090:	5f38544e 	svcpl	0x0038544e
    2094:	45505954 	ldrbmi	r5, [r0, #-2388]	@ 0xfffff6ac
    2098:	73205f5f 			@ <UNDEFINED> instruction: 0x73205f5f
    209c:	656e6769 	strbvs	r6, [lr, #-1897]!	@ 0xfffff897
    20a0:	68632064 	stmdavs	r3!, {r2, r5, r6, sp}^
    20a4:	5f007261 	svcpl	0x00007261
    20a8:	4e49575f 	mcrmi	7, 2, r5, cr9, cr15, {2}
    20ac:	414d5f54 	cmpmi	sp, r4, asr pc
    20b0:	205f5f58 	subscs	r5, pc, r8, asr pc	@ <UNPREDICTABLE>
    20b4:	66667830 			@ <UNDEFINED> instruction: 0x66667830
    20b8:	66666666 	strbtvs	r6, [r6], -r6, ror #12
    20bc:	00556666 	subseq	r6, r5, r6, ror #12
    20c0:	48435f5f 	stmdami	r3, {r0, r1, r2, r3, r4, r6, r8, r9, sl, fp, ip, lr}^
    20c4:	5f385241 	svcpl	0x00385241
    20c8:	45505954 	ldrbmi	r5, [r0, #-2388]	@ 0xfffff6ac
    20cc:	75205f5f 	strvc	r5, [r0, #-3935]!	@ 0xfffff0a1
    20d0:	6769736e 	strbvs	r7, [r9, -lr, ror #6]!
    20d4:	2064656e 	rsbcs	r6, r4, lr, ror #10
    20d8:	72616863 	rsbvc	r6, r1, #6488064	@ 0x630000
    20dc:	78655f00 	stmdavc	r5!, {r8, r9, sl, fp, ip, lr}^
    20e0:	5f007469 	svcpl	0x00007469
    20e4:	5f51545f 	svcpl	0x0051545f
    20e8:	54494246 	strbpl	r4, [r9], #-582	@ 0xfffffdba
    20ec:	31205f5f 			@ <UNDEFINED> instruction: 0x31205f5f
    20f0:	5f003732 	svcpl	0x00003732
    20f4:	5148555f 	cmppl	r8, pc, asr r5
    20f8:	4942465f 	stmdbmi	r2, {r0, r1, r2, r3, r4, r6, r9, sl, lr}^
    20fc:	205f5f54 	subscs	r5, pc, r4, asr pc	@ <UNPREDICTABLE>
    2100:	5f003631 	svcpl	0x00003631
    2104:	42444c5f 	submi	r4, r4, #24320	@ 0x5f00
    2108:	45445f4c 	strbmi	r5, [r4, #-3916]	@ 0xfffff0b4
    210c:	414d4943 	cmpmi	sp, r3, asr #18
    2110:	49445f4c 	stmdbmi	r4, {r2, r3, r6, r8, r9, sl, fp, ip, lr}^
    2114:	205f5f47 	subscs	r5, pc, r7, asr #30
    2118:	5f003731 	svcpl	0x00003731
    211c:	4148435f 	cmpmi	r8, pc, asr r3
    2120:	4e555f52 	mrcmi	15, 2, r5, cr5, cr2, {2}
    2124:	4e474953 			@ <UNDEFINED> instruction: 0x4e474953
    2128:	5f5f4445 	svcpl	0x005f4445
    212c:	5f003120 	svcpl	0x00003120
    2130:	4e49555f 	mcrmi	5, 2, r5, cr9, cr15, {2}
    2134:	41465f54 	cmpmi	r6, r4, asr pc
    2138:	34365453 	ldrtcc	r5, [r6], #-1107	@ 0xfffffbad
    213c:	58414d5f 	stmdapl	r1, {r0, r1, r2, r3, r4, r6, r8, sl, fp, lr}^
    2140:	30205f5f 	eorcc	r5, r0, pc, asr pc
    2144:	66666678 			@ <UNDEFINED> instruction: 0x66666678
    2148:	66666666 	strbtvs	r6, [r6], -r6, ror #12
    214c:	66666666 	strbtvs	r6, [r6], -r6, ror #12
    2150:	66666666 	strbtvs	r6, [r6], -r6, ror #12
    2154:	4c4c5566 	stclmi	5, cr5, [ip], {102}	@ 0x66
    2158:	555f5f00 	ldrbpl	r5, [pc, #-3840]	@ 1260 <_exit+0xd90>
    215c:	5f544e49 	svcpl	0x00544e49
    2160:	54534146 	ldrbpl	r4, [r3], #-326	@ 0xfffffeba
    2164:	4d5f3233 	ldclmi	2, cr3, [pc, #-204]	@ 20a0 <_exit+0x1bd0>
    2168:	5f5f5841 	svcpl	0x005f5841
    216c:	66783020 	ldrbtvs	r3, [r8], -r0, lsr #32
    2170:	66666666 	strbtvs	r6, [r6], -r6, ror #12
    2174:	55666666 	strbpl	r6, [r6, #-1638]!	@ 0xfffff99a
    2178:	555f5f00 	ldrbpl	r5, [pc, #-3840]	@ 1280 <_exit+0xdb0>
    217c:	41524653 	cmpmi	r2, r3, asr r6
    2180:	465f5443 	ldrbmi	r5, [pc], -r3, asr #8
    2184:	5f544942 	svcpl	0x00544942
    2188:	0038205f 	eorseq	r2, r8, pc, asr r0
    218c:	4e495f5f 	mcrmi	15, 2, r5, cr9, cr15, {2}
    2190:	5f343654 	svcpl	0x00343654
    2194:	29632843 	stmdbcs	r3!, {r0, r1, r6, fp, sp}^
    2198:	23206320 			@ <UNDEFINED> instruction: 0x23206320
    219c:	4c4c2023 	stclmi	0, cr2, [ip], {35}	@ 0x23
    21a0:	485f5f00 	ldmdami	pc, {r8, r9, sl, fp, ip, lr}^	@ <UNPREDICTABLE>
    21a4:	42465f51 	submi	r5, r6, #324	@ 0x144
    21a8:	5f5f5449 	svcpl	0x005f5449
    21ac:	00353120 	eorseq	r3, r5, r0, lsr #2
    21b0:	43575f5f 	cmpmi	r7, #380	@ 0x17c
    21b4:	5f524148 	svcpl	0x00524148
    21b8:	5f58414d 	svcpl	0x0058414d
    21bc:	7830205f 	ldmdavc	r0!, {r0, r1, r2, r3, r4, r6, sp}
    21c0:	66666666 	strbtvs	r6, [r6], -r6, ror #12
    21c4:	66666666 	strbtvs	r6, [r6], -r6, ror #12
    21c8:	5f5f0055 	svcpl	0x005f0055
    21cc:	455a4953 	ldrbmi	r4, [sl, #-2387]	@ 0xfffff6ad
    21d0:	4c5f464f 	ldclmi	6, cr4, [pc], {79}	@ 0x4f
    21d4:	5f474e4f 	svcpl	0x00474e4f
    21d8:	474e4f4c 	strbmi	r4, [lr, -ip, asr #30]
    21dc:	38205f5f 	stmdacc	r0!, {r0, r1, r2, r3, r4, r6, r8, r9, sl, fp, ip, lr}
    21e0:	465f5f00 	ldrbmi	r5, [pc], -r0, lsl #30
    21e4:	3436544c 	ldrtcc	r5, [r6], #-1100	@ 0xfffffbb4
    21e8:	5f53495f 	svcpl	0x0053495f
    21ec:	5f434549 	svcpl	0x00434549
    21f0:	35353036 	ldrcc	r3, [r5, #-54]!	@ 0xffffffca
    21f4:	205f5f39 	subscs	r5, pc, r9, lsr pc	@ <UNPREDICTABLE>
    21f8:	5f5f0031 	svcpl	0x005f0031
    21fc:	544e4955 	strbpl	r4, [lr], #-2389	@ 0xfffff6ab
    2200:	59545f38 	ldmdbpl	r4, {r3, r4, r5, r8, r9, sl, fp, ip, lr}^
    2204:	5f5f4550 	svcpl	0x005f4550
    2208:	736e7520 	cmnvc	lr, #32, 10	@ 0x8000000
    220c:	656e6769 	strbvs	r6, [lr, #-1897]!	@ 0xfffff897
    2210:	68632064 	stmdavs	r3!, {r2, r5, r6, sp}^
    2214:	5f007261 	svcpl	0x00007261
    2218:	5248535f 	subpl	r5, r8, #2080374785	@ 0x7c000001
    221c:	49575f54 	ldmdbmi	r7, {r2, r4, r6, r8, r9, sl, fp, ip, lr}^
    2220:	5f485444 	svcpl	0x00485444
    2224:	3631205f 			@ <UNDEFINED> instruction: 0x3631205f
    2228:	415f5f00 	cmpmi	pc, r0, lsl #30
    222c:	465f4d52 			@ <UNDEFINED> instruction: 0x465f4d52
    2230:	5f5f0050 	svcpl	0x005f0050
    2234:	5f4d5241 	svcpl	0x004d5241
    2238:	54414546 	strbpl	r4, [r1], #-1350	@ 0xfffffaba
    223c:	5f455255 	svcpl	0x00455255
    2240:	00534541 	subseq	r4, r3, r1, asr #10
    2244:	54535f5f 	ldrbpl	r5, [r3], #-3935	@ 0xfffff0a1
    2248:	455f4344 	ldrbmi	r4, [pc, #-836]	@ 1f0c <_exit+0x1a3c>
    224c:	4445424d 	strbmi	r4, [r5], #-589	@ 0xfffffdb3
    2250:	544f4e5f 	strbpl	r4, [pc], #-3679	@ 2258 <_exit+0x1d88>
    2254:	554f465f 	strbpl	r4, [pc, #-1631]	@ 1bfd <_exit+0x172d>
    2258:	5f5f444e 	svcpl	0x005f444e
    225c:	5f003020 	svcpl	0x00003020
    2260:	544c465f 	strbpl	r4, [ip], #-1631	@ 0xfffff9a1
    2264:	5350455f 	cmppl	r0, #398458880	@ 0x17c00000
    2268:	4e4f4c49 	cdpmi	12, 4, cr4, cr15, cr9, {2}
    226c:	31205f5f 			@ <UNDEFINED> instruction: 0x31205f5f
    2270:	3239312e 	eorscc	r3, r9, #-2147483637	@ 0x8000000b
    2274:	38323930 	ldmdacc	r2!, {r4, r5, r8, fp, ip, sp}
    2278:	30353539 	eorscc	r3, r5, r9, lsr r5
    227c:	32313837 	eorscc	r3, r1, #3604480	@ 0x370000
    2280:	372d6535 			@ <UNDEFINED> instruction: 0x372d6535
    2284:	5f5f0046 	svcpl	0x005f0046
    2288:	5f544e49 	svcpl	0x00544e49
    228c:	5341454c 	cmppl	r1, #76, 10	@ 0x13000000
    2290:	5f343654 	svcpl	0x00343654
    2294:	45505954 	ldrbmi	r5, [r0, #-2388]	@ 0xfffff6ac
    2298:	6c205f5f 	stcvs	15, cr5, [r0], #-380	@ 0xfffffe84
    229c:	20676e6f 	rsbcs	r6, r7, pc, ror #28
    22a0:	676e6f6c 	strbvs	r6, [lr, -ip, ror #30]!
    22a4:	746e6920 	strbtvc	r6, [lr], #-2336	@ 0xfffff6e0
    22a8:	495f5f00 	ldmdbmi	pc, {r8, r9, sl, fp, ip, lr}^	@ <UNPREDICTABLE>
    22ac:	465f544e 	ldrbmi	r5, [pc], -lr, asr #8
    22b0:	31545341 	cmpcc	r4, r1, asr #6
    22b4:	414d5f36 	cmpmi	sp, r6, lsr pc
    22b8:	205f5f58 	subscs	r5, pc, r8, asr pc	@ <UNPREDICTABLE>
    22bc:	66377830 			@ <UNDEFINED> instruction: 0x66377830
    22c0:	66666666 	strbtvs	r6, [r6], -r6, ror #12
    22c4:	5f006666 	svcpl	0x00006666
    22c8:	4e49555f 	mcrmi	5, 2, r5, cr9, cr15, {2}
    22cc:	5f323354 	svcpl	0x00323354
    22d0:	45505954 	ldrbmi	r5, [r0, #-2388]	@ 0xfffff6ac
    22d4:	6c205f5f 	stcvs	15, cr5, [r0], #-380	@ 0xfffffe84
    22d8:	20676e6f 	rsbcs	r6, r7, pc, ror #28
    22dc:	69736e75 	ldmdbvs	r3!, {r0, r2, r4, r5, r6, r9, sl, fp, sp, lr}^
    22e0:	64656e67 	strbtvs	r6, [r5], #-3687	@ 0xfffff199
    22e4:	746e6920 	strbtvc	r6, [lr], #-2336	@ 0xfffff6e0
    22e8:	4c5f5f00 	ldclmi	15, cr5, [pc], {-0}
    22ec:	5f4c4244 	svcpl	0x004c4244
    22f0:	5f4e494d 	svcpl	0x004e494d
    22f4:	455f3031 	ldrbmi	r3, [pc, #-49]	@ 22cb <_exit+0x1dfb>
    22f8:	5f5f5058 	svcpl	0x005f5058
    22fc:	332d2820 			@ <UNDEFINED> instruction: 0x332d2820
    2300:	00293730 	eoreq	r3, r9, r0, lsr r7
    2304:	49535f5f 	ldmdbmi	r3, {r0, r1, r2, r3, r4, r6, r8, r9, sl, fp, ip, lr}^
    2308:	464f455a 			@ <UNDEFINED> instruction: 0x464f455a
    230c:	494f505f 	stmdbmi	pc, {r0, r1, r2, r3, r4, r6, ip, lr}^	@ <UNPREDICTABLE>
    2310:	5245544e 	subpl	r5, r5, #1308622848	@ 0x4e000000
    2314:	34205f5f 	strtcc	r5, [r0], #-3935	@ 0xfffff0a1
    2318:	555f5f00 	ldrbpl	r5, [pc, #-3840]	@ 1420 <_exit+0xf50>
    231c:	55434341 	strbpl	r4, [r3, #-833]	@ 0xfffffcbf
    2320:	414d5f4d 	cmpmi	sp, sp, asr #30
    2324:	205f5f58 	subscs	r5, pc, r8, asr pc	@ <UNPREDICTABLE>
    2328:	46465830 			@ <UNDEFINED> instruction: 0x46465830
    232c:	46464646 	strbmi	r4, [r6], -r6, asr #12
    2330:	2d504646 	ldclcs	6, cr4, [r0, #-280]	@ 0xfffffee8
    2334:	4b553631 	blmi	154fc00 <_exit+0x154f730>
    2338:	565f5f00 	ldrbpl	r5, [pc], -r0, lsl #30
    233c:	465f5046 	ldrbmi	r5, [pc], -r6, asr #32
    2340:	205f5f50 	subscs	r5, pc, r0, asr pc	@ <UNPREDICTABLE>
    2344:	5f5f0031 	svcpl	0x005f0031
    2348:	52464c55 	subpl	r4, r6, #21760	@ 0x5500
    234c:	5f544341 	svcpl	0x00544341
    2350:	5f58414d 	svcpl	0x0058414d
    2354:	5830205f 	ldmdapl	r0!, {r0, r1, r2, r3, r4, r6, sp}
    2358:	46464646 	strbmi	r4, [r6], -r6, asr #12
    235c:	46464646 	strbmi	r4, [r6], -r6, asr #12
    2360:	32332d50 	eorscc	r2, r3, #80, 26	@ 0x1400
    2364:	00524c55 	subseq	r4, r2, r5, asr ip
    2368:	41485f5f 	cmpmi	r8, pc, asr pc
    236c:	4942465f 	stmdbmi	r2, {r0, r1, r2, r3, r4, r6, r9, sl, lr}^
    2370:	205f5f54 	subscs	r5, pc, r4, asr pc	@ <UNPREDICTABLE>
    2374:	5f5f0037 	svcpl	0x005f0037
    2378:	44525450 	ldrbmi	r5, [r2], #-1104	@ 0xfffffbb0
    237c:	5f464649 	svcpl	0x00464649
    2380:	54444957 	strbpl	r4, [r4], #-2391	@ 0xfffff6a9
    2384:	205f5f48 	subscs	r5, pc, r8, asr #30
    2388:	5f003233 	svcpl	0x00003233
    238c:	544c465f 	strbpl	r4, [ip], #-1631	@ 0xfffff9a1
    2390:	445f3233 	ldrbmi	r3, [pc], #-563	@ 2398 <_exit+0x1ec8>
    2394:	524f4e45 	subpl	r4, pc, #1104	@ 0x450
    2398:	494d5f4d 	stmdbmi	sp, {r0, r2, r3, r6, r8, r9, sl, fp, ip, lr}^
    239c:	205f5f4e 	subscs	r5, pc, lr, asr #30
    23a0:	30342e31 	eorscc	r2, r4, r1, lsr lr
    23a4:	38393231 	ldmdacc	r9!, {r0, r4, r5, r9, ip, sp}
    23a8:	33343634 	teqcc	r4, #52, 12	@ 0x3400000
    23ac:	31383432 	teqcc	r8, r2, lsr r4
    23b0:	2d653137 	stclcs	1, cr3, [r5, #-220]!	@ 0xffffff24
    23b4:	33463534 	cmpcc	r6, #52, 10	@ 0xd000000
    23b8:	5f5f0032 	svcpl	0x005f0032
    23bc:	43434153 	cmpmi	r3, #-1073741804	@ 0xc0000014
    23c0:	4d5f4d55 	ldclmi	13, cr4, [pc, #-340]	@ 2274 <_exit+0x1da4>
    23c4:	5f5f4e49 	svcpl	0x005f4e49
    23c8:	302d2820 	eorcc	r2, sp, r0, lsr #16
    23cc:	37503158 			@ <UNDEFINED> instruction: 0x37503158
    23d0:	302d4b48 	eorcc	r4, sp, r8, asr #22
    23d4:	37503158 			@ <UNDEFINED> instruction: 0x37503158
    23d8:	00294b48 	eoreq	r4, r9, r8, asr #22
    23dc:	4e495f5f 	mcrmi	15, 2, r5, cr9, cr15, {2}
    23e0:	49575f54 	ldmdbmi	r7, {r2, r4, r6, r8, r9, sl, fp, ip, lr}^
    23e4:	5f485444 	svcpl	0x00485444
    23e8:	3233205f 	eorscc	r2, r3, #95	@ 0x5f
    23ec:	475f5f00 	ldrbmi	r5, [pc, -r0, lsl #30]
    23f0:	415f4343 	cmpmi	pc, r3, asr #6
    23f4:	494d4f54 	stmdbmi	sp, {r2, r4, r6, r8, r9, sl, fp, lr}^
    23f8:	4f505f43 	svcmi	0x00505f43
    23fc:	45544e49 	ldrbmi	r4, [r4, #-3657]	@ 0xfffff1b7
    2400:	4f4c5f52 	svcmi	0x004c5f52
    2404:	465f4b43 	ldrbmi	r4, [pc], -r3, asr #22
    2408:	20454552 	subcs	r4, r5, r2, asr r5
    240c:	5f5f0031 	svcpl	0x005f0031
    2410:	544e4955 	strbpl	r4, [lr], #-2389	@ 0xfffff6ab
    2414:	435f3436 	cmpmi	pc, #905969664	@ 0x36000000
    2418:	20296328 	eorcs	r6, r9, r8, lsr #6
    241c:	23232063 			@ <UNDEFINED> instruction: 0x23232063
    2420:	4c4c5520 	stclmi	5, cr5, [ip], {32}
    2424:	4c5f5f00 	ldclmi	15, cr5, [pc], {-0}
    2428:	55434341 	strbpl	r4, [r3, #-833]	@ 0xfffffcbf
    242c:	50455f4d 	subpl	r5, r5, sp, asr #30
    2430:	4f4c4953 	svcmi	0x004c4953
    2434:	205f5f4e 	subscs	r5, pc, lr, asr #30
    2438:	50317830 	eorspl	r7, r1, r0, lsr r8
    243c:	4c31332d 	ldcmi	3, cr3, [r1], #-180	@ 0xffffff4c
    2440:	5f5f004b 	svcpl	0x005f004b
    2444:	41524653 	cmpmi	r2, r3, asr r6
    2448:	455f5443 	ldrbmi	r5, [pc, #-1091]	@ 200d <_exit+0x1b3d>
    244c:	4c495350 	stclmi	3, cr5, [r9], {80}	@ 0x50
    2450:	5f5f4e4f 	svcpl	0x005f4e4f
    2454:	31783020 	cmncc	r8, r0, lsr #32
    2458:	48372d50 	ldmdami	r7!, {r4, r6, r8, sl, fp, sp}
    245c:	5f5f0052 	svcpl	0x005f0052
    2460:	5f515155 	svcpl	0x00515155
    2464:	54494249 	strbpl	r4, [r9], #-585	@ 0xfffffdb7
    2468:	30205f5f 	eorcc	r5, r0, pc, asr pc
    246c:	465f5f00 	ldrbmi	r5, [pc], -r0, lsl #30
    2470:	3233544c 	eorscc	r5, r3, #76, 8	@ 0x4c000000
    2474:	414d5f58 	cmpmi	sp, r8, asr pc
    2478:	205f5f58 	subscs	r5, pc, r8, asr pc	@ <UNPREDICTABLE>
    247c:	39372e31 	ldmdbcc	r7!, {r0, r4, r5, r9, sl, fp, sp}
    2480:	33393637 	teqcc	r9, #57671680	@ 0x3700000
    2484:	38343331 	ldmdacc	r4!, {r0, r4, r5, r8, r9, ip, sp}
    2488:	31333236 	teqcc	r3, r6, lsr r2
    248c:	2b653735 	blcs	1950168 <_exit+0x194fc98>
    2490:	46383033 			@ <UNDEFINED> instruction: 0x46383033
    2494:	00783233 	rsbseq	r3, r8, r3, lsr r2
    2498:	53555f5f 	cmppl	r5, #380	@ 0x17c
    249c:	42465f51 	submi	r5, r6, #324	@ 0x144
    24a0:	5f5f5449 	svcpl	0x005f5449
    24a4:	00323320 	eorseq	r3, r2, r0, lsr #6
    24a8:	53555f5f 	cmppl	r5, #380	@ 0x17c
    24ac:	4c5f5245 	ldclmi	2, cr5, [pc], {69}	@ 0x45
    24b0:	4c454241 	stclmi	2, cr4, [r5], {65}	@ 0x41
    24b4:	4552505f 	ldrbmi	r5, [r2, #-95]	@ 0xffffffa1
    24b8:	5f584946 	svcpl	0x00584946
    24bc:	5f00205f 	svcpl	0x0000205f
    24c0:	4d52415f 	ldclmi	1, cr4, [r2, #-380]	@ 0xfffffe84
    24c4:	4241455f 	submi	r4, r1, #398458880	@ 0x17c00000
    24c8:	205f5f49 	subscs	r5, pc, r9, asr #30
    24cc:	5f5f0031 	svcpl	0x005f0031
    24d0:	5f434347 	svcpl	0x00434347
    24d4:	4d4f5441 	stclmi	4, cr5, [pc, #-260]	@ 23d8 <_exit+0x1f08>
    24d8:	435f4349 	cmpmi	pc, #603979777	@ 0x24000001
    24dc:	33524148 	cmpcc	r2, #72, 2
    24e0:	5f545f32 	svcpl	0x00545f32
    24e4:	4b434f4c 	blmi	10d621c <_exit+0x10d5d4c>
    24e8:	4552465f 	ldrbmi	r4, [r2, #-1631]	@ 0xfffff9a1
    24ec:	00312045 	eorseq	r2, r1, r5, asr #32
    24f0:	43475f5f 	cmpmi	r7, #380	@ 0x17c
    24f4:	54415f43 	strbpl	r5, [r1], #-3907	@ 0xfffff0bd
    24f8:	43494d4f 	cmpmi	r9, #5056	@ 0x13c0
    24fc:	4148435f 	cmpmi	r8, pc, asr r3
    2500:	545f3852 	ldrbpl	r3, [pc], #-2130	@ 2508 <_exit+0x2038>
    2504:	434f4c5f 	cmpmi	pc, #24320	@ 0x5f00
    2508:	52465f4b 	subpl	r5, r6, #300	@ 0x12c
    250c:	31204545 			@ <UNDEFINED> instruction: 0x31204545
    2510:	535f5f00 	cmppl	pc, #0, 30
    2514:	4f455a49 	svcmi	0x00455a49
    2518:	49535f46 	ldmdbmi	r3, {r1, r2, r6, r8, r9, sl, fp, ip, lr}^
    251c:	545f455a 	ldrbpl	r4, [pc], #-1370	@ 2524 <_exit+0x2054>
    2520:	34205f5f 	strtcc	r5, [r0], #-3935	@ 0xfffff0a1
    2524:	554e4700 	strbpl	r4, [lr, #-1792]	@ 0xfffff900
    2528:	33324320 	teqcc	r2, #32, 6	@ 0x80000000
    252c:	2e353120 	cdpcs	1, 3, cr3, cr5, cr0, {1}
    2530:	20302e32 	eorscs	r2, r0, r2, lsr lr
    2534:	72616d2d 	rsbvc	r6, r1, #2880	@ 0xb40
    2538:	6d2d206d 	stcvs	0, cr2, [sp, #-436]!	@ 0xfffffe4c
    253c:	3d757063 	ldclcc	0, cr7, [r5, #-396]!	@ 0xfffffe74
    2540:	376d7261 	strbcc	r7, [sp, -r1, ror #4]!
    2544:	696d6474 	stmdbvs	sp!, {r2, r4, r5, r6, sl, sp, lr}^
    2548:	666d2d20 	strbtvs	r2, [sp], -r0, lsr #26
    254c:	74616f6c 	strbtvc	r6, [r1], #-3948	@ 0xfffff094
    2550:	6962612d 	stmdbvs	r2!, {r0, r2, r3, r5, r8, sp, lr}^
    2554:	666f733d 			@ <UNDEFINED> instruction: 0x666f733d
    2558:	6d2d2074 	stcvs	0, cr2, [sp, #-464]!	@ 0xfffffe30
    255c:	68637261 	stmdavs	r3!, {r0, r5, r6, r9, ip, sp, lr}^
    2560:	6d72613d 	ldclvs	1, cr6, [r2, #-244]!	@ 0xffffff0c
    2564:	20743476 	rsbscs	r3, r4, r6, ror r4
    2568:	2033672d 	eorscs	r6, r3, sp, lsr #14
    256c:	6f6e662d 	svcvs	0x006e662d
    2570:	6174732d 	cmnvs	r4, sp, lsr #6
    2574:	702d6b63 	eorvc	r6, sp, r3, ror #22
    2578:	65746f72 	ldrbvs	r6, [r4, #-3954]!	@ 0xfffff08e
    257c:	726f7463 	rsbvc	r7, pc, #1660944384	@ 0x63000000
    2580:	535f5f00 	cmppl	pc, #0, 30
    2584:	5f434454 	svcpl	0x00434454
    2588:	54534f48 	ldrbpl	r4, [r3], #-3912	@ 0xfffff0b8
    258c:	5f5f4445 	svcpl	0x005f4445
    2590:	5f003120 	svcpl	0x00003120
    2594:	544e495f 	strbpl	r4, [lr], #-2399	@ 0xfffff6a1
    2598:	5f525450 	svcpl	0x00525450
    259c:	5f58414d 	svcpl	0x0058414d
    25a0:	7830205f 	ldmdavc	r0!, {r0, r1, r2, r3, r4, r6, sp}
    25a4:	66666637 			@ <UNDEFINED> instruction: 0x66666637
    25a8:	66666666 	strbtvs	r6, [r6], -r6, ror #12
    25ac:	505f5f00 	subspl	r5, pc, r0, lsl #30
    25b0:	4d474152 	stclmi	1, cr4, [r7, #-328]	@ 0xfffffeb8
    25b4:	45525f41 	ldrbmi	r5, [r2, #-3905]	@ 0xfffff0bf
    25b8:	49464544 	stmdbmi	r6, {r2, r6, r8, sl, lr}^
    25bc:	455f454e 	ldrbmi	r4, [pc, #-1358]	@ 2076 <_exit+0x1ba6>
    25c0:	414e5458 	cmpmi	lr, r8, asr r4
    25c4:	3120454d 			@ <UNDEFINED> instruction: 0x3120454d
    25c8:	535f5f00 	cmppl	pc, #0, 30
    25cc:	4654464f 	ldrbmi	r4, [r4], -pc, asr #12
    25d0:	205f5f50 	subscs	r5, pc, r0, asr pc	@ <UNPREDICTABLE>
    25d4:	5f5f0031 	svcpl	0x005f0031
    25d8:	33544c46 	cmpcc	r4, #17920	@ 0x4600
    25dc:	414d5f32 	cmpmi	sp, r2, lsr pc
    25e0:	30315f58 	eorscc	r5, r1, r8, asr pc
    25e4:	5058455f 	subspl	r4, r8, pc, asr r5
    25e8:	33205f5f 			@ <UNDEFINED> instruction: 0x33205f5f
    25ec:	5f5f0038 	svcpl	0x005f0038
    25f0:	36544c46 	ldrbcc	r4, [r4], -r6, asr #24
    25f4:	50455f34 	subpl	r5, r5, r4, lsr pc
    25f8:	4f4c4953 	svcmi	0x004c4953
    25fc:	205f5f4e 	subscs	r5, pc, lr, asr #30
    2600:	32322e32 	eorscc	r2, r2, #800	@ 0x320
    2604:	36343430 			@ <UNDEFINED> instruction: 0x36343430
    2608:	32393430 	eorscc	r3, r9, #48, 8	@ 0x30000000
    260c:	31333035 	teqcc	r3, r5, lsr r0
    2610:	2d653133 	stclcs	1, cr3, [r5, #-204]!	@ 0xffffff34
    2614:	36463631 			@ <UNDEFINED> instruction: 0x36463631
    2618:	5f5f0034 	svcpl	0x005f0034
    261c:	5f434347 	svcpl	0x00434347
    2620:	4d4f5441 	stclmi	4, cr5, [pc, #-260]	@ 2524 <_exit+0x2054>
    2624:	4c5f4349 	ldclmi	3, cr4, [pc], {73}	@ 0x49
    2628:	474e4f4c 	strbmi	r4, [lr, -ip, asr #30]
    262c:	434f4c5f 	cmpmi	pc, #24320	@ 0x5f00
    2630:	52465f4b 	subpl	r5, r6, #300	@ 0x12c
    2634:	31204545 			@ <UNDEFINED> instruction: 0x31204545
    2638:	465f5f00 	ldrbmi	r5, [pc], -r0, lsl #30
    263c:	4d5f544c 	ldclmi	4, cr5, [pc, #-304]	@ 2514 <_exit+0x2044>
    2640:	455f5841 	ldrbmi	r5, [pc, #-2113]	@ 1e07 <_exit+0x1937>
    2644:	5f5f5058 	svcpl	0x005f5058
    2648:	38323120 	ldmdacc	r2!, {r5, r8, ip, sp}
    264c:	415f5f00 	cmpmi	pc, r0, lsl #30
    2650:	494d4f54 	stmdbmi	sp, {r2, r4, r6, r8, r9, sl, fp, lr}^
    2654:	43415f43 	cmpmi	r1, #268	@ 0x10c
    2658:	45525f51 	ldrbmi	r5, [r2, #-3921]	@ 0xfffff0af
    265c:	0034204c 	eorseq	r2, r4, ip, asr #32
    2660:	49555f5f 	ldmdbmi	r5, {r0, r1, r2, r3, r4, r6, r8, r9, sl, fp, ip, lr}^
    2664:	465f544e 	ldrbmi	r5, [pc], -lr, asr #8
    2668:	36545341 	ldrbcc	r5, [r4], -r1, asr #6
    266c:	59545f34 	ldmdbpl	r4, {r2, r4, r5, r8, r9, sl, fp, ip, lr}^
    2670:	5f5f4550 	svcpl	0x005f4550
    2674:	6e6f6c20 	cdpvs	12, 6, cr6, cr15, cr0, {1}
    2678:	6f6c2067 	svcvs	0x006c2067
    267c:	7520676e 	strvc	r6, [r0, #-1902]!	@ 0xfffff892
    2680:	6769736e 	strbvs	r7, [r9, -lr, ror #6]!
    2684:	2064656e 	rsbcs	r6, r4, lr, ror #10
    2688:	00746e69 	rsbseq	r6, r4, r9, ror #28
    268c:	49555f5f 	ldmdbmi	r5, {r0, r1, r2, r3, r4, r6, r8, r9, sl, fp, ip, lr}^
    2690:	414d544e 	cmpmi	sp, lr, asr #8
    2694:	59545f58 	ldmdbpl	r4, {r3, r4, r6, r8, r9, sl, fp, ip, lr}^
    2698:	5f5f4550 	svcpl	0x005f4550
    269c:	6e6f6c20 	cdpvs	12, 6, cr6, cr15, cr0, {1}
    26a0:	6f6c2067 	svcvs	0x006c2067
    26a4:	7520676e 	strvc	r6, [r0, #-1902]!	@ 0xfffff892
    26a8:	6769736e 	strbvs	r7, [r9, -lr, ror #6]!
    26ac:	2064656e 	rsbcs	r6, r4, lr, ror #10
    26b0:	00746e69 	rsbseq	r6, r4, r9, ror #28
    26b4:	4c465f5f 	stclmi	15, cr5, [r6], {95}	@ 0x5f
    26b8:	58323354 	ldmdapl	r2!, {r2, r4, r6, r8, r9, ip, sp}
    26bc:	524f4e5f 	subpl	r4, pc, #1520	@ 0x5f0
    26c0:	414d5f4d 	cmpmi	sp, sp, asr #30
    26c4:	205f5f58 	subscs	r5, pc, r8, asr pc	@ <UNPREDICTABLE>
    26c8:	39372e31 	ldmdbcc	r7!, {r0, r4, r5, r9, sl, fp, sp}
    26cc:	33393637 	teqcc	r9, #57671680	@ 0x3700000
    26d0:	38343331 	ldmdacc	r4!, {r0, r4, r5, r8, r9, ip, sp}
    26d4:	31333236 	teqcc	r3, r6, lsr r2
    26d8:	2b653735 	blcs	19503b4 <_exit+0x194fee4>
    26dc:	46383033 			@ <UNDEFINED> instruction: 0x46383033
    26e0:	00783233 	rsbseq	r3, r8, r3, lsr r2
    26e4:	444c5f5f 	strbmi	r5, [ip], #-3935	@ 0xfffff0a1
    26e8:	455f4c42 	ldrbmi	r4, [pc, #-3138]	@ 1aae <_exit+0x15de>
    26ec:	4c495350 	stclmi	3, cr5, [r9], {80}	@ 0x50
    26f0:	5f5f4e4f 	svcpl	0x005f4e4f
    26f4:	322e3220 	eorcc	r3, lr, #32, 4
    26f8:	34343032 	ldrtcc	r3, [r4], #-50	@ 0xffffffce
    26fc:	39343036 	ldmdbcc	r4!, {r1, r2, r4, r5, ip, sp}
    2700:	33303532 	teqcc	r0, #209715200	@ 0xc800000
    2704:	65313331 	ldrvs	r3, [r1, #-817]!	@ 0xfffffccf
    2708:	4c36312d 	ldcmi	1, cr3, [r6], #-180	@ 0xffffff4c
    270c:	495f5f00 	ldmdbmi	pc, {r8, r9, sl, fp, ip, lr}^	@ <UNPREDICTABLE>
    2710:	5450544e 	ldrbpl	r5, [r0], #-1102	@ 0xfffffbb2
    2714:	59545f52 	ldmdbpl	r4, {r1, r4, r6, r8, r9, sl, fp, ip, lr}^
    2718:	5f5f4550 	svcpl	0x005f4550
    271c:	746e6920 	strbtvc	r6, [lr], #-2336	@ 0xfffff6e0
    2720:	445f5f00 	ldrbmi	r5, [pc], #-3840	@ 2728 <_exit+0x2258>
    2724:	455f4345 	ldrbmi	r4, [pc, #-837]	@ 23e7 <_exit+0x1f17>
    2728:	5f4c4156 	svcpl	0x004c4156
    272c:	4854454d 	ldmdami	r4, {r0, r2, r3, r6, r8, sl, lr}^
    2730:	5f5f444f 	svcpl	0x005f444f
    2734:	5f003220 	svcpl	0x00003220
    2738:	4153555f 	cmpmi	r3, pc, asr r5
    273c:	4d554343 	ldclmi	3, cr4, [r5, #-268]	@ 0xfffffef4
    2740:	4e494d5f 	mcrmi	13, 2, r4, cr9, cr15, {2}
    2744:	30205f5f 	eorcc	r5, r0, pc, asr pc
    2748:	4855302e 	ldmdami	r5, {r1, r2, r3, r5, ip, sp}^
    274c:	5f5f004b 	svcpl	0x005f004b
    2750:	52465355 	subpl	r5, r6, #1409286145	@ 0x54000001
    2754:	5f544341 	svcpl	0x00544341
    2758:	54494249 	strbpl	r4, [r9], #-585	@ 0xfffffdb7
    275c:	30205f5f 	eorcc	r5, r0, pc, asr pc
    2760:	495f5f00 	ldmdbmi	pc, {r8, r9, sl, fp, ip, lr}^	@ <UNPREDICTABLE>
    2764:	4c5f544e 	ldclmi	4, cr5, [pc], {78}	@ 0x4e
    2768:	54534145 	ldrbpl	r4, [r3], #-325	@ 0xfffffebb
    276c:	575f3233 			@ <UNDEFINED> instruction: 0x575f3233
    2770:	48544449 	ldmdami	r4, {r0, r3, r6, sl, lr}^
    2774:	33205f5f 			@ <UNDEFINED> instruction: 0x33205f5f
    2778:	5f5f0032 	svcpl	0x005f0032
    277c:	5f4d5241 	svcpl	0x004d5241
    2780:	54414546 	strbpl	r4, [r1], #-1350	@ 0xfffffaba
    2784:	5f455255 	svcpl	0x00455255
    2788:	00505344 	subseq	r5, r0, r4, asr #6
    278c:	4e475f5f 	mcrmi	15, 2, r5, cr7, cr15, {2}
    2790:	575f4355 			@ <UNDEFINED> instruction: 0x575f4355
    2794:	5f454449 	svcpl	0x00454449
    2798:	43455845 	cmpmi	r5, #4521984	@ 0x450000
    279c:	4f495455 	svcmi	0x00495455
    27a0:	48435f4e 	stmdami	r3, {r1, r2, r3, r6, r8, r9, sl, fp, ip, lr}^
    27a4:	45535241 	ldrbmi	r5, [r3, #-577]	@ 0xfffffdbf
    27a8:	414e5f54 	cmpmi	lr, r4, asr pc
    27ac:	2220454d 	eorcs	r4, r0, #322961408	@ 0x13400000
    27b0:	2d465455 	stclcs	4, cr5, [r6, #-340]	@ 0xfffffeac
    27b4:	454c3233 	strbmi	r3, [ip, #-563]	@ 0xfffffdcd
    27b8:	5f5f0022 	svcpl	0x005f0022
    27bc:	495f5144 	ldmdbmi	pc, {r2, r6, r8, ip, lr}^	@ <UNPREDICTABLE>
    27c0:	5f544942 	svcpl	0x00544942
    27c4:	0030205f 	eorseq	r2, r0, pc, asr r0
    27c8:	4c465f5f 	stclmi	15, cr5, [r6], {95}	@ 0x5f
    27cc:	414d5f54 	cmpmi	sp, r4, asr pc
    27d0:	205f5f58 	subscs	r5, pc, r8, asr pc	@ <UNPREDICTABLE>
    27d4:	30342e33 	eorscc	r2, r4, r3, lsr lr
    27d8:	33323832 	teqcc	r2, #3276800	@ 0x320000
    27dc:	33363634 	teqcc	r6, #52, 12	@ 0x3400000
    27e0:	38323538 	ldmdacc	r2!, {r3, r4, r5, r8, sl, ip, sp}
    27e4:	2b653638 	blcs	19500cc <_exit+0x194fbfc>
    27e8:	00463833 	subeq	r3, r6, r3, lsr r8
    27ec:	4c465f5f 	stclmi	15, cr5, [r6], {95}	@ 0x5f
    27f0:	5f323354 	svcpl	0x00323354
    27f4:	5f4e494d 	svcpl	0x004e494d
    27f8:	2e31205f 	mrccs	0, 1, r2, cr1, cr15, {2}
    27fc:	34353731 	ldrtcc	r3, [r5], #-1841	@ 0xfffff8cf
    2800:	35333439 	ldrcc	r3, [r3, #-1081]!	@ 0xfffffbc7
    2804:	32323830 	eorscc	r3, r2, #48, 16	@ 0x300000
    2808:	35373832 	ldrcc	r3, [r7, #-2098]!	@ 0xfffff7ce
    280c:	38332d65 	ldmdacc	r3!, {r0, r2, r5, r6, r8, sl, fp, sp}
    2810:	00323346 	eorseq	r3, r2, r6, asr #6
    2814:	49535f5f 	ldmdbmi	r3, {r0, r1, r2, r3, r4, r6, r8, r9, sl, fp, ip, lr}^
    2818:	545f455a 	ldrbpl	r4, [pc], #-1370	@ 2820 <_exit+0x2350>
    281c:	5f455059 	svcpl	0x00455059
    2820:	6e75205f 	mrcvs	0, 3, r2, cr5, cr15, {2}
    2824:	6e676973 			@ <UNDEFINED> instruction: 0x6e676973
    2828:	69206465 	stmdbvs	r0!, {r0, r2, r5, r6, sl, sp, lr}
    282c:	5f00746e 	svcpl	0x0000746e
    2830:	4c4c555f 	stclmi	5, cr5, [ip], {95}	@ 0x5f
    2834:	55434341 	strbpl	r4, [r3, #-833]	@ 0xfffffcbf
    2838:	42465f4d 	submi	r5, r6, #308	@ 0x134
    283c:	5f5f5449 	svcpl	0x005f5449
    2840:	00323320 	eorseq	r3, r2, r0, lsr #6
    2844:	42445f5f 	submi	r5, r4, #380	@ 0x17c
    2848:	53495f4c 	cmppl	r9, #76, 30	@ 0x130
    284c:	4345495f 	cmpmi	r5, #1556480	@ 0x17c000
    2850:	3530365f 	ldrcc	r3, [r0, #-1631]!	@ 0xfffff9a1
    2854:	5f5f3935 	svcpl	0x005f3935
    2858:	5f003120 	svcpl	0x00003120
    285c:	4152465f 	cmpmi	r2, pc, asr r6
    2860:	465f5443 	ldrbmi	r5, [pc], -r3, asr #8
    2864:	5f544942 	svcpl	0x00544942
    2868:	3531205f 	ldrcc	r2, [r1, #-95]!	@ 0xffffffa1
    286c:	465f5f00 	ldrbmi	r5, [pc], -r0, lsl #30
    2870:	54434152 	strbpl	r4, [r3], #-338	@ 0xfffffeae
    2874:	5350455f 	cmppl	r0, #398458880	@ 0x17c00000
    2878:	4e4f4c49 	cdpmi	12, 4, cr4, cr15, cr9, {2}
    287c:	30205f5f 	eorcc	r5, r0, pc, asr pc
    2880:	2d503178 	ldclcs	1, cr3, [r0, #-480]	@ 0xfffffe20
    2884:	00523531 	subseq	r3, r2, r1, lsr r5
    2888:	4c465f5f 	stclmi	15, cr5, [r6], {95}	@ 0x5f
    288c:	494d5f54 	stmdbmi	sp, {r2, r4, r6, r8, r9, sl, fp, ip, lr}^
    2890:	30315f4e 	eorscc	r5, r1, lr, asr #30
    2894:	5058455f 	subspl	r4, r8, pc, asr r5
    2898:	28205f5f 	stmdacs	r0!, {r0, r1, r2, r3, r4, r6, r8, r9, sl, fp, ip, lr}
    289c:	2937332d 	ldmdbcs	r7!, {r0, r2, r3, r5, r8, r9, ip, sp}
    28a0:	465f5f00 	ldrbmi	r5, [pc], -r0, lsl #30
    28a4:	3436544c 	ldrtcc	r5, [r6], #-1100	@ 0xfffffbb4
    28a8:	4e494d5f 	mcrmi	13, 2, r4, cr9, cr15, {2}
    28ac:	5058455f 	subspl	r4, r8, pc, asr r5
    28b0:	28205f5f 	stmdacs	r0!, {r0, r1, r2, r3, r4, r6, r8, r9, sl, fp, ip, lr}
    28b4:	3230312d 	eorscc	r3, r0, #1073741835	@ 0x4000000b
    28b8:	5f002931 	svcpl	0x00002931
    28bc:	544c465f 	strbpl	r4, [ip], #-1631	@ 0xfffff9a1
    28c0:	5f583233 	svcpl	0x00583233
    28c4:	49535045 	ldmdbmi	r3, {r0, r2, r6, ip, lr}^
    28c8:	5f4e4f4c 	svcpl	0x004e4f4c
    28cc:	2e32205f 	mrccs	0, 1, r2, cr2, cr15, {2}
    28d0:	34303232 	ldrtcc	r3, [r0], #-562	@ 0xfffffdce
    28d4:	34303634 	ldrtcc	r3, [r0], #-1588	@ 0xfffff9cc
    28d8:	30353239 	eorscc	r3, r5, r9, lsr r2
    28dc:	31333133 	teqcc	r3, r3, lsr r1
    28e0:	36312d65 	ldrtcc	r2, [r1], -r5, ror #26
    28e4:	78323346 	ldmdavc	r2!, {r1, r2, r6, r8, r9, ip, sp}
    28e8:	575f5f00 	ldrbpl	r5, [pc, -r0, lsl #30]
    28ec:	52414843 	subpl	r4, r1, #4390912	@ 0x430000
    28f0:	4e494d5f 	mcrmi	13, 2, r4, cr9, cr15, {2}
    28f4:	30205f5f 	eorcc	r5, r0, pc, asr pc
    28f8:	5f5f0055 	svcpl	0x005f0055
    28fc:	5f4c4244 	svcpl	0x004c4244
    2900:	5f534148 	svcpl	0x00534148
    2904:	49464e49 	stmdbmi	r6, {r0, r3, r6, r9, sl, fp, lr}^
    2908:	5954494e 	ldmdbpl	r4, {r1, r2, r3, r6, r8, fp, lr}^
    290c:	31205f5f 			@ <UNDEFINED> instruction: 0x31205f5f
    2910:	495f5f00 	ldmdbmi	pc, {r8, r9, sl, fp, ip, lr}^	@ <UNPREDICTABLE>
    2914:	465f544e 	ldrbmi	r5, [pc], -lr, asr #8
    2918:	33545341 	cmpcc	r4, #67108865	@ 0x4000001
    291c:	59545f32 	ldmdbpl	r4, {r1, r4, r5, r8, r9, sl, fp, ip, lr}^
    2920:	5f5f4550 	svcpl	0x005f4550
    2924:	746e6920 	strbtvc	r6, [lr], #-2336	@ 0xfffff6e0
    2928:	465f5f00 	ldrbmi	r5, [pc], -r0, lsl #30
    292c:	485f544c 	ldmdami	pc, {r2, r3, r6, sl, ip, lr}^	@ <UNPREDICTABLE>
    2930:	515f5341 	cmppl	pc, r1, asr #6
    2934:	54454955 	strbpl	r4, [r5], #-2389	@ 0xfffff6ab
    2938:	4e414e5f 	mcrmi	14, 2, r4, cr1, cr15, {2}
    293c:	31205f5f 			@ <UNDEFINED> instruction: 0x31205f5f
    2940:	535f5f00 	cmppl	pc, #0, 30
    2944:	4f455a49 	svcmi	0x00455a49
    2948:	4e495f46 	cdpmi	15, 4, cr5, cr9, cr6, {2}
    294c:	205f5f54 	subscs	r5, pc, r4, asr pc	@ <UNPREDICTABLE>
    2950:	5f5f0034 	svcpl	0x005f0034
    2954:	4d544e49 	ldclmi	14, cr4, [r4, #-292]	@ 0xfffffedc
    2958:	545f5841 	ldrbpl	r5, [pc], #-2113	@ 2960 <_exit+0x2490>
    295c:	5f455059 	svcpl	0x00455059
    2960:	6f6c205f 	svcvs	0x006c205f
    2964:	6c20676e 	stcvs	7, cr6, [r0], #-440	@ 0xfffffe48
    2968:	20676e6f 	rsbcs	r6, r7, pc, ror #28
    296c:	00746e69 	rsbseq	r6, r4, r9, ror #28
    2970:	4e495f5f 	mcrmi	15, 2, r5, cr9, cr15, {2}
    2974:	58414d54 	stmdapl	r1, {r2, r4, r6, r8, sl, fp, lr}^
    2978:	6328435f 			@ <UNDEFINED> instruction: 0x6328435f
    297c:	20632029 	rsbcs	r2, r3, r9, lsr #32
    2980:	4c202323 	stcmi	3, cr2, [r0], #-140	@ 0xffffff74
    2984:	5f5f004c 	svcpl	0x005f004c
    2988:	53435041 	cmppl	r3, #65	@ 0x41
    298c:	5f32335f 	svcpl	0x0032335f
    2990:	0031205f 	eorseq	r2, r1, pc, asr r0
    2994:	42445f5f 	submi	r5, r4, #380	@ 0x17c
    2998:	45445f4c 	strbmi	r5, [r4, #-3916]	@ 0xfffff0b4
    299c:	4d524f4e 	ldclmi	15, cr4, [r2, #-312]	@ 0xfffffec8
    29a0:	4e494d5f 	mcrmi	13, 2, r4, cr9, cr15, {2}
    29a4:	28205f5f 	stmdacs	r0!, {r0, r1, r2, r3, r4, r6, r8, r9, sl, fp, ip, lr}
    29a8:	756f6428 	strbvc	r6, [pc, #-1064]!	@ 2588 <_exit+0x20b8>
    29ac:	29656c62 	stmdbcs	r5!, {r1, r5, r6, sl, fp, sp, lr}^
    29b0:	34392e34 	ldrtcc	r2, [r9], #-3636	@ 0xfffff1cc
    29b4:	36353630 			@ <UNDEFINED> instruction: 0x36353630
    29b8:	34383534 	ldrtcc	r3, [r8], #-1332	@ 0xfffffacc
    29bc:	36343231 			@ <UNDEFINED> instruction: 0x36343231
    29c0:	2d653435 	stclcs	4, cr3, [r5, #-212]!	@ 0xffffff2c
    29c4:	4c343233 	ldcmi	2, cr3, [r4], #-204	@ 0xffffff34
    29c8:	5f5f0029 	svcpl	0x005f0029
    29cc:	544e4955 	strbpl	r4, [lr], #-2389	@ 0xfffff6ab
    29d0:	545f3436 	ldrbpl	r3, [pc], #-1078	@ 29d8 <_exit+0x2508>
    29d4:	5f455059 	svcpl	0x00455059
    29d8:	6f6c205f 	svcvs	0x006c205f
    29dc:	6c20676e 	stcvs	7, cr6, [r0], #-440	@ 0xfffffe48
    29e0:	20676e6f 	rsbcs	r6, r7, pc, ror #28
    29e4:	69736e75 	ldmdbvs	r3!, {r0, r2, r4, r5, r6, r9, sl, fp, sp, lr}^
    29e8:	64656e67 	strbtvs	r6, [r5], #-3687	@ 0xfffff199
    29ec:	746e6920 	strbtvc	r6, [lr], #-2336	@ 0xfffff6e0
    29f0:	465f5f00 	ldrbmi	r5, [pc], -r0, lsl #30
    29f4:	3233544c 	eorscc	r5, r3, #76, 8	@ 0x4c000000
    29f8:	41485f58 	cmpmi	r8, r8, asr pc
    29fc:	55515f53 	ldrbpl	r5, [r1, #-3923]	@ 0xfffff0ad
    2a00:	5f544549 	svcpl	0x00544549
    2a04:	5f4e414e 	svcpl	0x004e414e
    2a08:	0031205f 	eorseq	r2, r1, pc, asr r0
    2a0c:	42445f5f 	submi	r5, r4, #380	@ 0x17c
    2a10:	414d5f4c 	cmpmi	sp, ip, asr #30
    2a14:	30315f58 	eorscc	r5, r1, r8, asr pc
    2a18:	5058455f 	subspl	r4, r8, pc, asr r5
    2a1c:	33205f5f 			@ <UNDEFINED> instruction: 0x33205f5f
    2a20:	5f003830 	svcpl	0x00003830
    2a24:	544c465f 	strbpl	r4, [ip], #-1631	@ 0xfffff9a1
    2a28:	5f583233 	svcpl	0x00583233
    2a2c:	5f4e494d 	svcpl	0x004e494d
    2a30:	2e32205f 	mrccs	0, 1, r2, cr2, cr15, {2}
    2a34:	30353232 	eorscc	r3, r5, r2, lsr r2
    2a38:	35383337 	ldrcc	r3, [r8, #-823]!	@ 0xfffffcc9
    2a3c:	37303538 			@ <UNDEFINED> instruction: 0x37303538
    2a40:	34313032 	ldrtcc	r3, [r1], #-50	@ 0xffffffce
    2a44:	30332d65 	eorscc	r2, r3, r5, ror #26
    2a48:	32334638 	eorscc	r4, r3, #56, 12	@ 0x3800000
    2a4c:	5f5f0078 	svcpl	0x005f0078
    2a50:	5f434347 	svcpl	0x00434347
    2a54:	4d4f5441 	stclmi	4, cr5, [pc, #-260]	@ 2958 <_exit+0x2488>
    2a58:	435f4349 	cmpmi	pc, #603979777	@ 0x24000001
    2a5c:	5f524148 	svcpl	0x00524148
    2a60:	4b434f4c 	blmi	10d6798 <_exit+0x10d62c8>
    2a64:	4552465f 	ldrbmi	r4, [r2, #-1631]	@ 0xfffff9a1
    2a68:	00312045 	eorseq	r2, r1, r5, asr #32
    2a6c:	54535f5f 	ldrbpl	r5, [r3], #-3935	@ 0xfffff0a1
    2a70:	455f4344 	ldrbmi	r4, [pc, #-836]	@ 2734 <_exit+0x2264>
    2a74:	4445424d 	strbmi	r4, [r5], #-589	@ 0xfffffdb3
    2a78:	504d455f 	subpl	r4, sp, pc, asr r5
    2a7c:	5f5f5954 	svcpl	0x005f5954
    2a80:	5f003220 	svcpl	0x00003220
    2a84:	5f41545f 	svcpl	0x0041545f
    2a88:	54494249 	strbpl	r4, [r9], #-585	@ 0xfffffdb7
    2a8c:	36205f5f 			@ <UNDEFINED> instruction: 0x36205f5f
    2a90:	5f5f0034 	svcpl	0x005f0034
    2a94:	465f5151 			@ <UNDEFINED> instruction: 0x465f5151
    2a98:	5f544942 	svcpl	0x00544942
    2a9c:	0037205f 	eorseq	r2, r7, pc, asr r0
    2aa0:	6e69616d 	cdpvs	1, 6, cr6, cr9, cr13, {3}
    2aa4:	495f5f00 	ldmdbmi	pc, {r8, r9, sl, fp, ip, lr}^	@ <UNPREDICTABLE>
    2aa8:	465f544e 	ldrbmi	r5, [pc], -lr, asr #8
    2aac:	38545341 	ldmdacc	r4, {r0, r6, r8, r9, ip, lr}^
    2ab0:	4449575f 	strbmi	r5, [r9], #-1887	@ 0xfffff8a1
    2ab4:	5f5f4854 	svcpl	0x005f4854
    2ab8:	00323320 	eorseq	r3, r2, r0, lsr #6
    2abc:	4c465f5f 	stclmi	15, cr5, [r6], {95}	@ 0x5f
    2ac0:	494d5f54 	stmdbmi	sp, {r2, r4, r6, r8, r9, sl, fp, ip, lr}^
    2ac4:	58455f4e 	stmdapl	r5, {r1, r2, r3, r6, r8, r9, sl, fp, ip, lr}^
    2ac8:	205f5f50 	subscs	r5, pc, r0, asr pc	@ <UNPREDICTABLE>
    2acc:	32312d28 	eorscc	r2, r1, #40, 26	@ 0xa00
    2ad0:	5f002935 	svcpl	0x00002935
    2ad4:	4343475f 	cmpmi	r3, #24903680	@ 0x17c0000
    2ad8:	4f54415f 	svcmi	0x0054415f
    2adc:	5f43494d 	svcpl	0x0043494d
    2ae0:	4c4f4f42 	stclmi	15, cr4, [pc], {66}	@ 0x42
    2ae4:	434f4c5f 	cmpmi	pc, #24320	@ 0x5f00
    2ae8:	52465f4b 	subpl	r5, r6, #300	@ 0x12c
    2aec:	31204545 			@ <UNDEFINED> instruction: 0x31204545
    2af0:	445f5f00 	ldrbmi	r5, [pc], #-3840	@ 2af8 <_exit+0x2628>
    2af4:	4d494345 	stclmi	3, cr4, [r9, #-276]	@ 0xfffffeec
    2af8:	445f4c41 	ldrbmi	r4, [pc], #-3137	@ 2b00 <_exit+0x2630>
    2afc:	5f5f4749 	svcpl	0x005f4749
    2b00:	00373120 	eorseq	r3, r7, r0, lsr #2
    2b04:	4e495f5f 	mcrmi	15, 2, r5, cr9, cr15, {2}
    2b08:	5f323354 	svcpl	0x00323354
    2b0c:	29632843 	stmdbcs	r3!, {r0, r1, r6, fp, sp}^
    2b10:	23206320 			@ <UNDEFINED> instruction: 0x23206320
    2b14:	004c2023 	subeq	r2, ip, r3, lsr #32
    2b18:	52415f5f 	subpl	r5, r1, #380	@ 0x17c
    2b1c:	45465f4d 	strbmi	r5, [r6, #-3917]	@ 0xfffff0b3
    2b20:	52555441 	subspl	r5, r5, #1090519040	@ 0x41000000
    2b24:	41505f45 	cmpmi	r0, r5, asr #30
    2b28:	00485455 	subeq	r5, r8, r5, asr r4
    2b2c:	444c5f5f 	strbmi	r5, [ip], #-3935	@ 0xfffff0a1
    2b30:	4d5f4c42 	ldclmi	12, cr4, [pc, #-264]	@ 2a30 <_exit+0x2560>
    2b34:	315f5841 	cmpcc	pc, r1, asr #16
    2b38:	58455f30 	stmdapl	r5, {r4, r5, r8, r9, sl, fp, ip, lr}^
    2b3c:	205f5f50 	subscs	r5, pc, r0, asr pc	@ <UNPREDICTABLE>
    2b40:	00383033 	eorseq	r3, r8, r3, lsr r0
    2b44:	4c465f5f 	stclmi	15, cr5, [r6], {95}	@ 0x5f
    2b48:	58323354 	ldmdapl	r2!, {r2, r4, r6, r8, r9, ip, sp}
    2b4c:	58414d5f 	stmdapl	r1, {r0, r1, r2, r3, r4, r6, r8, sl, fp, lr}^
    2b50:	5f30315f 	svcpl	0x0030315f
    2b54:	5f505845 	svcpl	0x00505845
    2b58:	3033205f 	eorscc	r2, r3, pc, asr r0
    2b5c:	5f5f0038 	svcpl	0x005f0038
    2b60:	544e4955 	strbpl	r4, [lr], #-2389	@ 0xfffff6ab
    2b64:	5f525450 	svcpl	0x00525450
    2b68:	5f58414d 	svcpl	0x0058414d
    2b6c:	7830205f 	ldmdavc	r0!, {r0, r1, r2, r3, r4, r6, sp}
    2b70:	66666666 	strbtvs	r6, [r6], -r6, ror #12
    2b74:	66666666 	strbtvs	r6, [r6], -r6, ror #12
    2b78:	5f5f0055 	svcpl	0x005f0055
    2b7c:	5f4c4244 	svcpl	0x004c4244
    2b80:	5f534148 	svcpl	0x00534148
    2b84:	4f4e4544 	svcmi	0x004e4544
    2b88:	5f5f4d52 	svcpl	0x005f4d52
    2b8c:	5f003120 	svcpl	0x00003120
    2b90:	554e475f 	strbpl	r4, [lr, #-1887]	@ 0xfffff8a1
    2b94:	58455f43 	stmdapl	r5, {r0, r1, r6, r8, r9, sl, fp, ip, lr}^
    2b98:	54554345 	ldrbpl	r4, [r5], #-837	@ 0xfffffcbb
    2b9c:	5f4e4f49 	svcpl	0x004e4f49
    2ba0:	52414843 	subpl	r4, r1, #4390912	@ 0x430000
    2ba4:	5f544553 	svcpl	0x00544553
    2ba8:	454d414e 	strbmi	r4, [sp, #-334]	@ 0xfffffeb2
    2bac:	54552220 	ldrbpl	r2, [r5], #-544	@ 0xfffffde0
    2bb0:	22382d46 	eorscs	r2, r8, #4480	@ 0x1180
    2bb4:	415f5f00 	cmpmi	pc, r0, lsl #30
    2bb8:	465f4d52 			@ <UNDEFINED> instruction: 0x465f4d52
    2bbc:	55544145 	ldrbpl	r4, [r4, #-325]	@ 0xfffffebb
    2bc0:	435f4552 	cmpmi	pc, #343932928	@ 0x14800000
    2bc4:	32334352 	eorscc	r4, r3, #1207959553	@ 0x48000001
    2bc8:	555f5f00 	ldrbpl	r5, [pc, #-3840]	@ 1cd0 <_exit+0x1800>
    2bcc:	495f4154 	ldmdbmi	pc, {r2, r4, r6, r8, lr}^	@ <UNPREDICTABLE>
    2bd0:	5f544942 	svcpl	0x00544942
    2bd4:	3436205f 	ldrtcc	r2, [r6], #-95	@ 0xffffffa1
    2bd8:	415f5f00 	cmpmi	pc, r0, lsl #30
    2bdc:	465f4d52 			@ <UNDEFINED> instruction: 0x465f4d52
    2be0:	55544145 	ldrbpl	r4, [r4, #-325]	@ 0xfffffebb
    2be4:	435f4552 	cmpmi	pc, #343932928	@ 0x14800000
    2be8:	5f005a4c 	svcpl	0x00005a4c
    2bec:	52464c5f 	subpl	r4, r6, #24320	@ 0x5f00
    2bf0:	5f544341 	svcpl	0x00544341
    2bf4:	5f58414d 	svcpl	0x0058414d
    2bf8:	5830205f 	ldmdapl	r0!, {r0, r1, r2, r3, r4, r6, sp}
    2bfc:	46464637 			@ <UNDEFINED> instruction: 0x46464637
    2c00:	46464646 	strbmi	r4, [r6], -r6, asr #12
    2c04:	31332d50 	teqcc	r3, r0, asr sp
    2c08:	5f00524c 	svcpl	0x0000524c
    2c0c:	544e495f 	strbpl	r4, [lr], #-2399	@ 0xfffff6a1
    2c10:	41454c5f 	cmpmi	r5, pc, asr ip
    2c14:	32335453 	eorscc	r5, r3, #1392508928	@ 0x53000000
    2c18:	58414d5f 	stmdapl	r1, {r0, r1, r2, r3, r4, r6, r8, sl, fp, lr}^
    2c1c:	30205f5f 	eorcc	r5, r0, pc, asr pc
    2c20:	66663778 			@ <UNDEFINED> instruction: 0x66663778
    2c24:	66666666 	strbtvs	r6, [r6], -r6, ror #12
    2c28:	5f004c66 	svcpl	0x00004c66
    2c2c:	4343475f 	cmpmi	r3, #24903680	@ 0x17c0000
    2c30:	4f54415f 	svcmi	0x0054415f
    2c34:	5f43494d 	svcpl	0x0043494d
    2c38:	474e4f4c 	strbmi	r4, [lr, -ip, asr #30]
    2c3c:	434f4c5f 	cmpmi	pc, #24320	@ 0x5f00
    2c40:	52465f4b 	subpl	r5, r6, #300	@ 0x12c
    2c44:	31204545 			@ <UNDEFINED> instruction: 0x31204545
    2c48:	555f5f00 	ldrbpl	r5, [pc, #-3840]	@ 1d50 <_exit+0x1880>
    2c4c:	4d544e49 	ldclmi	14, cr4, [r4, #-292]	@ 0xfffffedc
    2c50:	4d5f5841 	ldclmi	8, cr5, [pc, #-260]	@ 2b54 <_exit+0x2684>
    2c54:	5f5f5841 	svcpl	0x005f5841
    2c58:	66783020 	ldrbtvs	r3, [r8], -r0, lsr #32
    2c5c:	66666666 	strbtvs	r6, [r6], -r6, ror #12
    2c60:	66666666 	strbtvs	r6, [r6], -r6, ror #12
    2c64:	66666666 	strbtvs	r6, [r6], -r6, ror #12
    2c68:	55666666 	strbpl	r6, [r6, #-1638]!	@ 0xfffff99a
    2c6c:	5f004c4c 	svcpl	0x00004c4c
    2c70:	4749535f 			@ <UNDEFINED> instruction: 0x4749535f
    2c74:	4f54415f 	svcmi	0x0054415f
    2c78:	5f43494d 	svcpl	0x0043494d
    2c7c:	45505954 	ldrbmi	r5, [r0, #-2388]	@ 0xfffff6ac
    2c80:	69205f5f 	stmdbvs	r0!, {r0, r1, r2, r3, r4, r6, r8, r9, sl, fp, ip, lr}
    2c84:	5f00746e 	svcpl	0x0000746e
    2c88:	464c4c5f 			@ <UNDEFINED> instruction: 0x464c4c5f
    2c8c:	54434152 	strbpl	r4, [r3], #-338	@ 0xfffffeae
    2c90:	4e494d5f 	mcrmi	13, 2, r4, cr9, cr15, {2}
    2c94:	28205f5f 	stmdacs	r0!, {r0, r1, r2, r3, r4, r6, r8, r9, sl, fp, ip, lr}
    2c98:	352e302d 	strcc	r3, [lr, #-45]!	@ 0xffffffd3
    2c9c:	2d524c4c 	ldclcs	12, cr4, [r2, #-304]	@ 0xfffffed0
    2ca0:	4c352e30 	ldcmi	14, cr2, [r5], #-192	@ 0xffffff40
    2ca4:	0029524c 	eoreq	r5, r9, ip, asr #4
    2ca8:	4c555f5f 	ldclmi	15, cr5, [r5], {95}	@ 0x5f
    2cac:	4152464c 	cmpmi	r2, ip, asr #12
    2cb0:	455f5443 	ldrbmi	r5, [pc, #-1091]	@ 2875 <_exit+0x23a5>
    2cb4:	4c495350 	stclmi	3, cr5, [r9], {80}	@ 0x50
    2cb8:	5f5f4e4f 	svcpl	0x005f4e4f
    2cbc:	31783020 	cmncc	r8, r0, lsr #32
    2cc0:	34362d50 	ldrtcc	r2, [r6], #-3408	@ 0xfffff2b0
    2cc4:	524c4c55 	subpl	r4, ip, #21760	@ 0x5500
    2cc8:	4c5f5f00 	ldclmi	15, cr5, [pc], {-0}
    2ccc:	5f4c4244 	svcpl	0x004c4244
    2cd0:	5f534148 	svcpl	0x00534148
    2cd4:	4f4e4544 	svcmi	0x004e4544
    2cd8:	5f5f4d52 	svcpl	0x005f4d52
    2cdc:	5f003120 	svcpl	0x00003120
    2ce0:	4e49555f 	mcrmi	5, 2, r5, cr9, cr15, {2}
    2ce4:	454c5f54 	strbmi	r5, [ip, #-3924]	@ 0xfffff0ac
    2ce8:	31545341 	cmpcc	r4, r1, asr #6
    2cec:	414d5f36 	cmpmi	sp, r6, lsr pc
    2cf0:	205f5f58 	subscs	r5, pc, r8, asr pc	@ <UNPREDICTABLE>
    2cf4:	66667830 			@ <UNDEFINED> instruction: 0x66667830
    2cf8:	5f006666 	svcpl	0x00006666
    2cfc:	4d52415f 	ldclmi	1, cr4, [r2, #-380]	@ 0xfffffe84
    2d00:	4145465f 	cmpmi	r5, pc, asr r6
    2d04:	45525554 	ldrbmi	r5, [r2, #-1364]	@ 0xfffffaac
    2d08:	52444c5f 	subpl	r4, r4, #24320	@ 0x5f00
    2d0c:	5f005845 	svcpl	0x00005845
    2d10:	42444c5f 	submi	r4, r4, #24320	@ 0x5f00
    2d14:	4f4e5f4c 	svcmi	0x004e5f4c
    2d18:	4d5f4d52 	ldclmi	13, cr4, [pc, #-328]	@ 2bd8 <_exit+0x2708>
    2d1c:	5f5f5841 	svcpl	0x005f5841
    2d20:	372e3120 	strcc	r3, [lr, -r0, lsr #2]!
    2d24:	39363739 	ldmdbcc	r6!, {r0, r3, r4, r5, r8, r9, sl, ip, sp}
    2d28:	34333133 	ldrtcc	r3, [r3], #-307	@ 0xfffffecd
    2d2c:	33323638 	teqcc	r2, #56, 12	@ 0x3800000
    2d30:	65373531 	ldrvs	r3, [r7, #-1329]!	@ 0xfffffacf
    2d34:	3830332b 	ldmdacc	r0!, {r0, r1, r3, r5, r8, r9, ip, sp}
    2d38:	5f5f004c 	svcpl	0x005f004c
    2d3c:	414c4c55 	cmpmi	ip, r5, asr ip
    2d40:	4d554343 	ldclmi	3, cr4, [r5, #-268]	@ 0xfffffef4
    2d44:	5350455f 	cmppl	r0, #398458880	@ 0x17c00000
    2d48:	4e4f4c49 	cdpmi	12, 4, cr4, cr15, cr9, {2}
    2d4c:	30205f5f 	eorcc	r5, r0, pc, asr pc
    2d50:	2d503178 	ldclcs	1, cr3, [r0, #-480]	@ 0xfffffe20
    2d54:	4c553233 	ldclmi	2, cr3, [r5], {51}	@ 0x33
    2d58:	5f004b4c 	svcpl	0x00004b4c
    2d5c:	4153555f 	cmpmi	r3, pc, asr r5
    2d60:	4d554343 	ldclmi	3, cr4, [r5, #-268]	@ 0xfffffef4
    2d64:	4942465f 	stmdbmi	r2, {r0, r1, r2, r3, r4, r6, r9, sl, lr}^
    2d68:	205f5f54 	subscs	r5, pc, r4, asr pc	@ <UNPREDICTABLE>
    2d6c:	5f5f0038 	svcpl	0x005f0038
    2d70:	5f544c46 	svcpl	0x00544c46
    2d74:	5f534148 	svcpl	0x00534148
    2d78:	4f4e4544 	svcmi	0x004e4544
    2d7c:	5f5f4d52 	svcpl	0x005f4d52
    2d80:	5f003120 	svcpl	0x00003120
    2d84:	544e495f 	strbpl	r4, [lr], #-2399	@ 0xfffff6a1
    2d88:	5341465f 	cmppl	r1, #99614720	@ 0x5f00000
    2d8c:	5f343654 	svcpl	0x00343654
    2d90:	54444957 	strbpl	r4, [r4], #-2391	@ 0xfffff6a9
    2d94:	205f5f48 	subscs	r5, pc, r8, asr #30
    2d98:	5f003436 	svcpl	0x00003436
    2d9c:	4c42445f 	stclmi	4, cr4, [r2], {95}	@ 0x5f
    2da0:	4345445f 	cmpmi	r5, #1593835520	@ 0x5f000000
    2da4:	4c414d49 	stclmi	13, cr4, [r1], {73}	@ 0x49
    2da8:	4749445f 			@ <UNDEFINED> instruction: 0x4749445f
    2dac:	31205f5f 			@ <UNDEFINED> instruction: 0x31205f5f
    2db0:	Address 0x2db0 is out of bounds.


Disassembly of section .comment:

00000000 <.comment>:
   0:	3a434347 	bcc	10d0d24 <_exit+0x10d0854>
   4:	65462820 	strbvs	r2, [r6, #-2080]	@ 0xfffff7e0
   8:	61726f64 	cmnvs	r2, r4, ror #30
   c:	2e353120 	cdpcs	1, 3, cr3, cr5, cr0, {1}
  10:	2d302e32 	ldccs	14, cr2, [r0, #-200]!	@ 0xffffff38
  14:	63662e31 	cmnvs	r6, #784	@ 0x310
  18:	20293234 	eorcs	r3, r9, r4, lsr r2
  1c:	322e3531 	eorcc	r3, lr, #205520896	@ 0xc400000
  20:	Address 0x20 is out of bounds.


Disassembly of section .ARM.attributes:

00000000 <.ARM.attributes>:
   0:	00002941 	andeq	r2, r0, r1, asr #18
   4:	61656100 	cmnvs	r5, r0, lsl #2
   8:	01006962 	tsteq	r0, r2, ror #18
   c:	0000001f 	andeq	r0, r0, pc, lsl r0
  10:	00543405 	subseq	r3, r4, r5, lsl #8
  14:	01080206 	tsteq	r8, r6, lsl #4
  18:	04120109 	ldreq	r0, [r2], #-265	@ 0xfffffef7
  1c:	01150114 	tsteq	r5, r4, lsl r1
  20:	01180317 	tsteq	r8, r7, lsl r3
  24:	011a0119 	tsteq	sl, r9, lsl r1
  28:	Address 0x28 is out of bounds.


Disassembly of section .debug_frame:

00000000 <.debug_frame>:
   0:	0000000c 	andeq	r0, r0, ip
   4:	ffffffff 			@ <UNDEFINED> instruction: 0xffffffff
   8:	7c020001 	stcvc	0, cr0, [r2], {1}
   c:	000d0c0e 	andeq	r0, sp, lr, lsl #24
  10:	00000018 	andeq	r0, r0, r8, lsl r0
  14:	00000000 	andeq	r0, r0, r0
  18:	00000400 	andeq	r0, r0, r0, lsl #8
  1c:	00000024 	andeq	r0, r0, r4, lsr #32
  20:	8b080e42 	blhi	203930 <_exit+0x203460>
  24:	42018e02 	andmi	r8, r1, #2, 28
  28:	00040b0c 	andeq	r0, r4, ip, lsl #22
  2c:	0000001c 	andeq	r0, r0, ip, lsl r0
  30:	00000000 	andeq	r0, r0, r0
  34:	00000424 	andeq	r0, r0, r4, lsr #8
  38:	0000001c 	andeq	r0, r0, ip, lsl r0
  3c:	8b040e42 	blhi	10394c <_exit+0x10347c>
  40:	0b0d4201 	bleq	35084c <_exit+0x35037c>
  44:	420d0d46 	andmi	r0, sp, #4480	@ 0x1180
  48:	00000ecb 	andeq	r0, r0, fp, asr #29
  4c:	0000001c 	andeq	r0, r0, ip, lsl r0
  50:	00000000 	andeq	r0, r0, r0
  54:	00000440 	andeq	r0, r0, r0, asr #8
  58:	0000001c 	andeq	r0, r0, ip, lsl r0
  5c:	8b040e42 	blhi	10396c <_exit+0x10349c>
  60:	0b0d4201 	bleq	35086c <_exit+0x35039c>
  64:	420d0d46 	andmi	r0, sp, #4480	@ 0x1180
  68:	00000ecb 	andeq	r0, r0, fp, asr #29
  6c:	00000020 	andeq	r0, r0, r0, lsr #32
  70:	00000000 	andeq	r0, r0, r0
  74:	0000045c 	andeq	r0, r0, ip, asr r4
  78:	00000074 	andeq	r0, r0, r4, ror r0
  7c:	8b080e42 	blhi	20398c <_exit+0x2034bc>
  80:	42018e02 	andmi	r8, r1, #2, 28
  84:	6e040b0c 	vmlavs.f64	d0, d4, d12
  88:	42080d0c 	andmi	r0, r8, #12, 26	@ 0x300
  8c:	000ecbce 	andeq	ip, lr, lr, asr #23
  90:	00000014 	andeq	r0, r0, r4, lsl r0
  94:	00000000 	andeq	r0, r0, r0
  98:	000004d0 			@ <UNDEFINED> instruction: 0x000004d0
  9c:	00000018 	andeq	r0, r0, r8, lsl r0
  a0:	8b040e42 	blhi	1039b0 <_exit+0x1034e0>
  a4:	0b0d4201 	bleq	3508b0 <_exit+0x3503e0>
