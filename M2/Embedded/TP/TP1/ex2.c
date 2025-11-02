/* Embedded Systems - Exercise 2 */

#include <tinyprintf.h>
#include <stm32f4/rcc.h>
#include <stm32f4/gpio.h>

// GPIOD
#define GREEN_LED	12

// GPIODA
#define BUTTON 0

void init_led(int LED) {
	// GPIOD_MODER registre à modifier
	// led * 2 car 2 bits par PIN, 
	// 2 est nb bits a écrire, 
	// GPIO_MODER_OUT est 0b10, donc mode out !
	GPIOD_MODER = REP_BITS(GPIOD_MODER, LED*2, 2, GPIO_MODER_OUT);
	
	// mode push-pull (envoie le courant)
	GPIOD_OTYPER &= ~(1<<GREEN_LED); 
}

void init_button(int U_BUTTON) {
	GPIOA_MODER = REP_BITS(GPIOA_MODER, U_BUTTON*2, 2, GPIO_MODER_IN);
	GPIOA_PUPDR = REP_BITS(GPIOA_PUPDR, U_BUTTON*2, 2, GPIO_PUPDR_PD);
}

int button_pressed(int U_BUTTON) {
	return (GPIOA_IDR & (1 << U_BUTTON)) != 0;
}

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
