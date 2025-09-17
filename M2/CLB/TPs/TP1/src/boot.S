#include "mm.h"

.section ".text.boot"

.globl _start
_start:

	// @ at which the the threads/cores will branch to.
	ldr w1, =_start // Address of _start.
	add w1, w1, #32 // 4*8, skip 8 instructions.
	
	// Address at which each thread reads to.
	// For each thread : @ is 216 + thread ID * 8.
	// Ex : Thread 2 = 216 + 2 * 8 = 232 <=> 0xE8.
	mov x0, #224 //0xE0, thread 2
	str w1, [x0]
	mov x0, #232 //0xE8, thread 3
	str w1, [x0]
	mov x0, #240 //0xF0, thread 4
	str w1, [x0]

	// Threads (cores) 2,3 and 4 land here
	mrs	x0, mpidr_el1
	and	x0, x0,#0xFF		// Check processor id
	cbz	x0, master		// Hang for all non-primary CPU
	
	b	proc_hang

proc_hang:
	wfi // wait for interrupt instead of wfe
	b 	proc_hang

master:

	adr	x0, bss_begin
	adr	x1, bss_end
	sub	x1, x1, x0
	bl 	memzero

	mov	sp, #LOW_MEMORY
	bl	kernel_main
	b 	proc_hang		// should never come here
