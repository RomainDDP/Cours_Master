/* Embedded Systems - Exercise 6 */


#include <tinyprintf.h>
#include <stm32f4/rcc.h>
#include <stm32f4/gpio.h>
#include <stm32f4/tim.h>
#include <stm32f4/nvic.h>
#include <my_lib.h>

// GPIOD
#define GREEN_LED	12
#define ORANGE_LED	13
#define RED_LED		14
#define BLUE_LED	15

// GPIODA
#define USER_BUT	0

#define WAIT_PSC 1000 // APBI_CLK = 42Mhz
#define WAIT_DELAY (APB1_CLK / WAIT_PSC) 
#define MS_500 (WAIT_DELAY / 2)

volatile int irq_recv = 0;

void handler_tim4() {
	printf("Interrupt from tim4 received !\n");
	TIM4_ARR = MS_500;

	// invert LED
	if((GPIOD_ODR & (1 << GREEN_LED)) == 0)
		turn_on(GREEN_LED);
	else
		turn_off(GREEN_LED);

	// Clear l'interrupt
	TIM4_SR &= ~TIM_UIF;
}

void init_this4(int prescaler, int delay){
	
	DISABLE_IRQS; // on désactive les interrupts le temps de la config.
	
	// Configure IRQs
	NVIC_ICER(TIM4_IRQ >> 5) = 1 << (TIM4_IRQ & 0X1f);
	NVIC_IRQ(TIM4_IRQ) = (uint32_t)handler_tim4;
	NVIC_IPR(TIM4_IRQ) = 0;

	// Purge les IRQs pending
	NVIC_ICPR(TIM4_IRQ >> 5) = 1 << (TIM4_IRQ & 0X1f);
	
	// Configuration du timer.
	TIM4_CR1 = 0; // Désactive le timer le temps de la config.
	TIM4_PSC = prescaler; // Prescaler.
	TIM4_ARR = delay; // ARR => valeur à laquelle SR passe à 1.
	TIM4_EGR = TIM_UG;
	TIM4_SR = 0; // On set SR à 0.
	
	// Enable les IRQs et le timer !
	NVIC_ISER(TIM4_IRQ >> 5) = 1 << (TIM4_IRQ & 0X1f);
	TIM4_DIER = TIM_UIE;

	ENABLE_IRQS;
	TIM4_CR1 |= TIM_CEN;
}

int main() {
	printf("\nStarting...\n");

	// RCC init
	RCC_AHB1ENR |= RCC_GPIOAEN;
	RCC_AHB1ENR |= RCC_GPIODEN;
	RCC_APB1ENR |= RCC_TIM4EN;

	init_led(GREEN_LED);
	init_this4(WAIT_PSC, WAIT_DELAY);

	// main loop
	printf("Endless loop!\n");
	while(1) {}

}


