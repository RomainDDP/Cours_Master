#define GPIO_IDR 0x10
#define GPIO_ODR 0x14
#define GPIO_BASE 0x40020800

#define ORANGE_LED 13
#define RED_LED 14
#define GREEN_LED 12
#define BLUE_LED 15

#define GPIOD_ODR *(volatile uint32_t *)(GPIO_BASE + GPIO_ODR)
#define GPIOD_BSSR 0x0 

#define MASK(l) 				((1 << (l)) - 1)
#define REP_BITS(y, i, l, x)	(((y) & (~MASK(l) << (i)))|((x) << (i)))
#define GET_BITS(x, i , l) 		(((x) >> (i)) & MASK(l))

int main(){

	/* Première version, sympa mais y'a mieux avec GPIOx_BSSR */
	GPIOD_ODR |= (1 << ORANGE_LED);
	GPIOD_ODR |= (2 << RED_LED);

	GPIOD_ODR &= ~(1 << GREEN_LED);
	GPIOD_ODR &= ~(1 << BLUE_LED);

	/* Deuxième version, avec GPIOx_BSSR */
	GPIOD_BSSR = (1 << ORANGE_LED) // On allume parce que pin => [0;15]
				|(1 << RED_LED)
				|(1 << BLUE_LED + 16) // On éteint parce que pin => [16;31]
				|(1 << GREEN_LED + 16);



	return 0;
}
