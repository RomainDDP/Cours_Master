/* Embedded Systems - Exercise 1 */

#include <tinyprintf.h>
#include <stm32f4/rcc.h>
#include <stm32f4/gpio.h>

#include <my_lib.h>

// LEDS
#define GREEN_LED 12
#define ORANGE_LED 13
#define RED_LED 14
#define BLUE_LED 15

#define DELAY 10000000

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
