/* Embedded Systems - Exercise 2 */

#include <tinyprintf.h>
#include <stm32f4/rcc.h>
#include <stm32f4/gpio.h>


// GPIOD
#define GREEN_LED	12
#define ORANGE_LED	13
#define RED_LED		14
#define BLUE_LED	15

// GPIODA
#define BUTTON 0

// void init_button(int BUTTON) {
// 	GPIOA_MODER = REP_BITS(GPIOA_MODER, B1*2, 2, GPIOA_MODER_IN);
// 	GPIOA_PUPDR = REP_BITS(GPIOA_PUPDR, B1*2, 2, GPIO_PUPDR_PD);
// }

int main() {
	printf("Starting...\n");

	// RCC init
	RCC_AHB1ENR |= RCC_GPIOAEN;
	RCC_AHB1ENR |= RCC_GPIODEN;
	RCC_APB1ENR |= RCC_TIM4EN;

	// GPIO init
	

	printf("Endless loop!\n");
	while(1) {
	}

}
