#include <stdint.h>

#define MASK(l)	((1 << (l))-1)
#define GET_BITS(x, i, l)		(((x)>>(i))&MASK(l))
#define REP_BITS(x, i, l, y)	(((x)&~(MASK(l)<<i))|((y)<<(i)))

static uint8_t pattern = 0b11001010;

void init() {
	for (int i=4; i<11; i++) {
		GPIOD_MODER = REP_BITS(GPIOD_MODER, i*2, 2, GPIO_MODER_OUT)
		GPIOD_OTYPER &= ~(1 << i);
	}
	display();
}

void display() {
	GPIOD_ODR = REP_BITS(GPIOD_ODR, 4, 8, pattern);

	// Deuxième solution
	GPIO_BSSR = (pattern) ((~pattern & 0xFF) << 16)) << 4;
}

int main() {

	init();
	while(1) {
		for(;;) {
			pattern = (pattern >> 1) | (pattern << 7);
			display();
		}
	}

	return 0;
}
