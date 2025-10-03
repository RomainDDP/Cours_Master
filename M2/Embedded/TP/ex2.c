/* Embedded Systems - Exercise 2 */

#include <tinyprintf.h>
#include <stm32f4/rcc.h>
#include <stm32f4/gpio.h>

#include <my_lib.h>

// GPIOD
#define GREEN_LED	12

// GPIODA
#define BUTTON 0

int main() {
	printf("Starting...\n");

	// RCC init
	RCC_AHB1ENR |= RCC_GPIOAEN;
	RCC_AHB1ENR |= RCC_GPIODEN;
	RCC_APB1ENR |= RCC_TIM4EN;

	// GPIO init
	init_button(BUTTON);
	init_led(GREEN_LED);	


	printf("Endless loop!\n");
	while(1) {

		if(button_pressed(BUTTON)) {
			// Turn on the LED.
			GPIOD_BSRR = (1 << GREEN_LED);
		} else {
			GPIOD_BSRR = (1 << (GREEN_LED + 16));
		}
	}

}
