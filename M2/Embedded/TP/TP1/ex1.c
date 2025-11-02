/* Embedded Systems - Exercise 1 */

#include <tinyprintf.h>
#include <stm32f4/rcc.h>
#include <stm32f4/gpio.h>

// LEDS
#define GREEN_LED 12
#define ORANGE_LED 13
#define RED_LED 14
#define BLUE_LED 15

#define DELAY 10000000

void init_led(int LED) {
	// GPIOD_MODER registre à modifier
	// led * 2 car 2 bits par PIN, 
	// 2 est nb bits a écrire, 
	// GPIO_MODER_OUT est 0b10, donc mode out !
	GPIOD_MODER = REP_BITS(GPIOD_MODER, LED*2, 2, GPIO_MODER_OUT);
	
	// mode push-pull (envoie le courant)
	GPIOD_OTYPER &= ~(1<<GREEN_LED); 
}

void delay(int time) {
	for(int i = 0; i < time; i++) { NOP; }
}

void blink(int LED, int TIME) {
	GPIOD_BSRR = (1 << LED); // On allume parce que pin => [0;15]
	delay(TIME);
	GPIOD_BSRR = (1 << (LED + 16)); // ON éteint parce que pin => [16;31]
}

int main() {
	printf("Starting...\n");

	// RCC init
	RCC_AHB1ENR |= RCC_GPIODEN;

	// GPIO init
	init_led(GREEN_LED);
	init_led(ORANGE_LED);
	init_led(RED_LED);
	init_led(BLUE_LED);

	printf("Endless loop!\n");
	while(1) {

		blink(GREEN_LED, DELAY);
		blink(ORANGE_LED, DELAY);
		blink(RED_LED, DELAY);
		blink(BLUE_LED, DELAY);
	}
}
