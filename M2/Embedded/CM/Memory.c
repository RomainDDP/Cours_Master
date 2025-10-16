extern uint32_t _bss_begin;
extern uint32_t _bss_end;

uint32_t *p = &_bss_begin;

while (p < &_bss_end) *p++ = 0;


// Link.ld :
// .text :
// {
//	_flash_begin = .;
//	[...]
//	_flash_end = .;
// } > FLASH

uint32_t checksum(){
	extern uint32_t _flash_begin;
	extern uint32_t _flash_end;
	uint32_t *p = &_flash_begin;
	uint32_t sum = 0;

	while(p < &_flash_end) sum += *p++;

	return sum;

}
