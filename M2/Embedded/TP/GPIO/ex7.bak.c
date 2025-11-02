/* Embedded Systems - Exercise 7 */

#include "stm32f4/tim.h"
#include <stdint.h>
#include <stm32f4/exti.h>
#include <stm32f4/gpio.h>
#include <stm32f4/io.h>
#include <stm32f4/nvic.h>
#include <stm32f4/rcc.h>
#include <stm32f4/syscfg.h>
#include <tinyprintf.h>
#include <my_lib.h>

// GPIOD
#define GREEN_LED 12
#define ORANGE_LED 13
#define RED_LED 14
#define BLUE_LED 15

// GPIODA
#define USER_BUTTON 0

#define PSC 1000
#define DELAY_50 (APB1_CLK / PSC / 20)

#define DEBOUNCE_MS 50
#define DEBOUNCE_TICKS (DELAY_50 * DEBOUNCE_MS / 1000)

volatile int current_read = 0;

void handle_button();

void init_b0() {
    DISABLE_IRQS;

    SYSCFG_EXTICR1 = REP_BITS(SYSCFG_EXTICR1, 0, 4, 0);
    EXTI_RTSR |= 1 << 0;
    EXTI_FTSR |= 1 << 0;
    EXTI_IMR |= 1 << 0;
    EXTI_PR |= 1 << 0;

    NVIC_ICER(EXTI0_IRQ >> 5) = 1 << (EXTI0_IRQ & 0X1F);
    NVIC_IRQ(EXTI0_IRQ) = (uint32_t)handle_button;
    NVIC_IPR(EXTI0_IRQ) = 0;
    NVIC_ICPR(EXTI0_IRQ >> 5) = 1 << (EXTI0_IRQ & 0X1F);
    NVIC_ISER(EXTI0_IRQ >> 5) = 1 << (EXTI0_IRQ & 0X1F);

    ENABLE_IRQS;
}

void init_TIM4() {
    TIM4_CR1 = 0;
    TIM4_PSC = PSC - 1;
    TIM4_ARR = DELAY_50 - 1;
    TIM4_EGR = TIM_UG;
    TIM4_SR = 0;
}

void handle_button() {
	uint32_t now = TIM4_CNT;
	int led_state = 0;
	int last_stable_state = 0;
	uint32_t last_change_time = 0;

	// Interrupt donc changement détecté 
	last_change_time = now;

	// Est ce que ca fait assez longtemps ?
	// Penser à gérer le wrap, voir CM1 slide 47
	// cette version marche bien aussi.
	uint32_t elapsed = (now >= last_change_time)
		? now - last_change_time
		: (0xFFFF - last_change_time + now);

	if (elapsed > DEBOUNCE_TICKS) {
		// If stable and different from last known state
		if (current_read != last_stable_state) {
			last_stable_state = current_read;

			// Detect press edge (not release)
			if (current_read) {
				led_state = !led_state;
				if (led_state)
					GPIOD_BSRR = 1 << ORANGE_LED;
				else
					GPIOD_BSRR = 1 << (ORANGE_LED + 16);
			}
		}
	}
    EXTI_PR |= 1 << 0;
    NVIC_ICPR(EXTI0_IRQ >> 5) |= 1 << (EXTI0_IRQ & 0X1F);
}

int main() {
    printf("\nStarting...\n");

    // RCC init
    RCC_AHB1ENR |= RCC_GPIOAEN;
    RCC_AHB1ENR |= RCC_GPIODEN;
    RCC_APB1ENR |= RCC_TIM4EN;

    // GPIO init
    GPIOA_MODER = REP_BITS(GPIOA_MODER, USER_BUTTON*2, 2, GPIO_MODER_IN);
    GPIOA_PUPDR = REP_BITS(GPIOA_PUPDR, USER_BUTTON*2, 2, GPIO_PUPDR_PD);

	init_led(GREEN_LED);

    init_TIM4();
    init_b0();

    // main loop
    printf("Endless loop!\n");
    while (1) {
    }
}
