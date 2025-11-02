#include "my_lib.h"
#include <stm32f4/gpio.h>
#include <stm32f4/tim.h>
#include <stm32f4/nvic.h>

// void init_interrupt_tim4(void *handler) {
// // Gestion des interrupts
	// DISABLE_IRQS;
	//
	// // Configure IRQs
	// NVIC_ICER(TIM4_IRQ >> 5) = 1 << (TIM4_IRQ & 0X1f);
	// NVIC_IRQ(TIM4_IRQ) = (uint32_t)handler;
	// NVIC_IPR(TIM4_IRQ) = 0;
	//
	// // Purge les IRQs pending
	// NVIC_ICPR(TIM4_IRQ >> 5) = 1 << (TIM4_IRQ & 0X1f);
	//
	// // Enable les IRQs
	// NVIC_ISER(TIM4_IRQ >> 5) = 1 << (TIM4_IRQ & 0X1f);
	// TIM4_DIER = TIM_UIE;
	// ENABLE_IRQS;
// }

void init_tim4(int prescaler, int delay){
	
	// Configuration du timer.
	TIM4_CR1 = 0; // Désactive le timer le temps de la config.
	TIM4_PSC = prescaler - 1; // Prescaler.
	TIM4_ARR = delay - 1; // ARR => valeur à laquelle SR passe à 1.
	TIM4_EGR = TIM_UG;
	TIM4_SR = 0; // On set SR à 0.

	TIM4_CR1 |= TIM_CEN;
}

void init_led(int LED) {
	// GPIOD_MODER registre à modifier
	// led * 2 car 2 bits par PIN, 
	// 2 est nb bits a écrire, 
	// GPIO_MODER_OUT est 0b10, donc mode out !
	GPIOD_MODER = REP_BITS(GPIOD_MODER, LED*2, 2, GPIO_MODER_OUT);
	
	// mode push-pull (envoie le courant)
	GPIOD_OTYPER &= ~(1<<LED); 
}

void init_button(int U_BUTTON) {
	GPIOA_MODER = REP_BITS(GPIOA_MODER, U_BUTTON*2, 2, GPIO_MODER_IN);
	GPIOA_PUPDR = REP_BITS(GPIOA_PUPDR, U_BUTTON*2, 2, GPIO_PUPDR_PD);
}

void turn_on(int LED) {
	GPIOD_BSRR = (1 << LED); // On allume parce que pin => [0;15]
}

void turn_off(int LED) {
	GPIOD_BSRR = (1 << (LED + 16)); // ON éteint parce que pin => [16;31]
}

int is_led_on(int LED) {
	return (GPIOD_ODR & (1<<GREEN_LED)) == 0;	
}

int is_button_pressed(int U_BUTTON) {
	return (GPIOA_IDR & (1 << U_BUTTON)) != 0;
}

int time_out() {
	// Mask pour récup le bit UIF dans le Status Register
	return (TIM4_SR & TIM_UIF) == 0;
}



