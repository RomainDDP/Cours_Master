#include "stm32f4/io.h"
#include <stdint.h>
#include <tinyprintf.h>
#include <stm32f4/rcc.h>
#include <stm32f4/gpio.h>
#include <stm32f4/nvic.h>
#include <stm32f4/exti.h>
#include <stm32f4/syscfg.h>
#include <stm32f4/tim.h>

#define PSC 1000
#define CLICK_TIME (APB1_CLK / PSC / 30)

#define GREEN_LED	12

#define USER_BUT	0
#define SYSCFG_EXTICR_GPIOA 0x0

void switchLed(int led) {
    GPIOD_ODR ^= (1 << led); 
}

void handle_button() {
    if((GPIOA_IDR & (1 << USER_BUT)) != 0) {
        NVIC_ICPR(EXTI0_IRQ/32) = 1 << (EXTI0_IRQ%32); // clear pending
        NVIC_ICER(EXTI0_IRQ/32) = 1 << (EXTI0_IRQ%32); // disable interrupt
        
		switchLed(GREEN_LED);

		TIM4_EGR = TIM_UG;
		TIM4_SR = 0;
		TIM4_CR1 = TIM_CEN;

		while((TIM4_SR & TIM_UIF) == 0)
		{
			if ((GPIOA_IDR & (1 << USER_BUT)) != 0) {
				TIM4_EGR = TIM_UG;
				TIM4_SR = 0;
			}
		}

		TIM4_CR1 = 0;

        NVIC_ICPR(EXTI0_IRQ/32) = 1 << (EXTI0_IRQ%32); // clear pending
        NVIC_ISER(EXTI0_IRQ/32) = 1 << (EXTI0_IRQ%32); // enable interrupt
    }
}

void init_led(int led) {
    GPIOD_MODER = REP_BITS(GPIOD_MODER, led*2, 2, GPIO_MODER_OUT); // Mode output
    GPIOD_OTYPER &= ~(1 << led); // Mode push pull (envoie le courant dans la led)
}

void init_TIM4(int psc, int delay){
	TIM4_CR1 = 0;               // Disable timer
	TIM4_PSC = psc - 1;         // setup prescalor
	TIM4_ARR = delay;           // setup period
	TIM4_EGR = TIM_UG;          // reset counter
	TIM4_SR = 0;                // reset status
}


void init_button(void *handler) {
    int button = 0;
    GPIOA_MODER = REP_BITS(GPIOA_MODER, button*2, 2, GPIO_MODER_IN); // Mode input
    GPIOA_PUPDR = REP_BITS(GPIOA_PUPDR, button*2, 2, GPIO_PUPDR_PD); // Resistance de pull-down

    SYSCFG_EXTICR1 = REP_BITS(SYSCFG_EXTICR1, button*4, 4, SYSCFG_EXTICR_GPIOA); // EXTI1 (Px1) generate interrupt based on GPIOA
    EXTI_IMR &= ~(1 << button);     // disable interrupt
    EXTI_RTSR |= 1 << button;       // rising edge
    EXTI_FTSR &= ~(1 << button);    // falling edge
    EXTI_PR |= 1 << button;         // clear pendaing
    EXTI_IMR |= 1 << button;        // enable interrupt

    NVIC_ICER(EXTI0_IRQ/32) = 1 << (EXTI0_IRQ%32); // disable interrupt in NVIC
    NVIC_IRQ(EXTI0_IRQ) = (uint32_t)handler;       // config handler
    NVIC_IPR(EXTI0_IRQ) = 0;                       // setup priority
    NVIC_ICPR(EXTI0_IRQ/32) = 1 << (EXTI0_IRQ%32); // clear pending in NVIC
    NVIC_ISER(EXTI0_IRQ/32) = 1 << (EXTI0_IRQ%32); // enable interrupt in NVIC
}

int main() {
	printf("\nStarting...\n");

	// RCC init
	RCC_AHB1ENR |= RCC_GPIOAEN;
	RCC_AHB1ENR |= RCC_GPIODEN;
	RCC_APB1ENR |= RCC_TIM4EN;

    init_TIM4(PSC, CLICK_TIME);
    init_led(GREEN_LED);
    init_button(handle_button);

	// main loop
	printf("Endless loop!\n");
	while(1) {
	}
}


