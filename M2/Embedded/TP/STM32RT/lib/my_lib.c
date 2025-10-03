#include "my_lib.h"
#include <stm32f4/gpio.h>
#include <stm32f4/tim.h>

void init_tim(int prescaler, int delay){

	TIM4_CR1 = 0;
	TIM4_PSC = prescaler - 1;
	TIM4_ARR = delay - 1;
	TIM4_EGR = TIM_UG;
	TIM4_SR = 0;

}

void init_led(int LED) {
	// GPIOD_MODER registre à modifier
	// led * 2 car 2 bits par PIN, 
	// 2 est nb bits a écrire, 
	// GPIO_MODER_OUT est 0b10, donc mode out !
	GPIOD_MODER = REP_BITS(GPIOD_MODER, LED*2, 2, GPIO_MODER_OUT);
	
	// mode push-pull (envoie le courant)
	GPIOD_OTYPER &= ~(1<<GREEN_LED); 
}

void init_button(int BUTTON) {
	GPIOA_MODER = REP_BITS(GPIOA_MODER, BUTTON*2, 2, GPIO_MODER_IN);
	GPIOA_PUPDR = REP_BITS(GPIOA_PUPDR, BUTTON*2, 2, GPIO_PUPDR_PD);
}

void delay(int time) {
	for(int i = 0; i < time; i++) { NOP; }
}

void blink(int LED, int TIME) {
	GPIOD_BSRR = (1 << LED); // On allume parce que pin => [0;15]
	delay(TIME);
	GPIOD_BSRR = (1 << (LED + 16)); // ON éteint parce que pin => [16;31]
}
int button_pressed(int BUTTON) {
	return (GPIOA_IDR & (1 << BUTTON)) != 0;
}

int time_out() {
	return (TIM4_SR & TIM_UIF) == 0;
}



