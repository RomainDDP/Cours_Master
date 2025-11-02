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

// GPIOD
#define GREEN_LED 12
#define ORANGE_LED 13
#define RED_LED 14
#define BLUE_LED 15

// GPIODA
#define USER_BUTTON 0

#define PSC 1000
#define DELAY_50 (APB1_CLK / PSC / 20)

uint32_t last_b = 0;
uint8_t b_state;

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
    while ((TIM4_SR & TIM_UIF) == 0) {
        if ((GPIOA_IDR & (1 << USER_BUTTON)) != 0) {
            b_state = 1;
            last_b = TIM4_CNT;
        } else if (b_state) {
            uint32_t now = TIM4_CNT;
            if (now <= last_b)
                now += DELAY_50;
            if (now - last_b >= DELAY_50) {
                b_state = 0;
                GPIOD_ODR ^= (1 << GREEN_LED);
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
    GPIO_MODER_SET(GPIOA(USER_BUTTON), GPIO_MODER_IN);
    GPIO_PUPDR_SET(GPIOA(USER_BUTTON), GPIO_PUPDR_PD);

    GPIO_MODER_SET(GPIOD(GREEN_LED), GPIO_MODER_OUT);
    GPIOD_OTYPER = GPIOD_OTYPER & ~(1 << GREEN_LED);

    init_TIM4();
    init_b0();

    // main loop
    printf("Endless loop!\n");
    while (1) {
    }
}
