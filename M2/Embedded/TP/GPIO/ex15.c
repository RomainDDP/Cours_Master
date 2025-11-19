#include "stm32f4/io.h"
#include <stdint.h>
#include <tinyprintf.h>
#include <stm32f4/rcc.h>
#include <stm32f4/gpio.h>
#include <stm32f4/nvic.h>
#include <stm32f4/exti.h>
#include <stm32f4/syscfg.h>
#include <stm32f4/tim.h>
#include <stm32f4/adc.h>

#define TIM_CC1S_OUTPUT (0b00 << 0)

#define MOTOR_PIN 6
#define SYSCFGEN 0x4000

#define PSC 14
#define PERIOD (APB1_CLK / (PSC * 50))
#define ANGLE_MIN (APB1_CLK / (PSC * 1000))
#define CONVERT_ANGLE(angle) (ANGLE_MIN + ((APB1_CLK / (180 * PSC * 1000)) * angle))

void handle_TIM4()  {
    static int angle = 0;
    if ((TIM4_SR & TIM_UIF) == 0) {
        NVIC_ICPR(TIM4_IRQ/32) = 1 << (TIM4_IRQ % 32);
        return;
    }

    angle = (angle + 10) % 180;
    TIM3_CCR1 = CONVERT_ANGLE(angle);

    TIM4_SR &= ~TIM_UIF;
    NVIC_ICPR(TIM4_IRQ/32) = 1 << (TIM4_IRQ % 32);
}

void config_motor(int psc, int delay, int ccr){
    DISABLE_IRQS;

	TIM3_CR1 = 0;               // Disable timer
	TIM3_PSC = psc - 1;         // setup prescalor
	TIM3_ARR = delay;           // setup period
	TIM3_EGR = TIM_UG;          // reset counter
	TIM3_SR = 0;                // reset status

    TIM3_CCR1 = ccr;
    TIM3_CCMR1 = TIM_CC1S_OUTPUT | TIM_OC1M_PWM1 | TIM_OC1PE;
    TIM3_CCER = TIM_CC1E ;
    TIM3_EGR = TIM_UG;
    
    GPIOA_MODER = REP_BITS(GPIOA_MODER, 2*MOTOR_PIN, 2, GPIO_MODER_ALT);
    GPIOA_AFRL = REP_BITS(GPIOA_AFRL, MOTOR_PIN*4, 4, 0b0010);
}

void config_timer4(int psc, int delay, void* handler) {
    DISABLE_IRQS;

	TIM4_CR1 = 0;
	TIM4_PSC = psc - 1;
	TIM4_ARR = delay;
	TIM4_EGR = TIM_UG;
	TIM4_SR = 0;
    TIM4_DIER = TIM_UIE;

    NVIC_ICER(TIM4_IRQ/32) = 1 <<(TIM4_IRQ%32);
    NVIC_IRQ(TIM4_IRQ) = (uint32_t)handler;
    NVIC_IPR(TIM4_IRQ) = 0;
    NVIC_ICPR(TIM4_IRQ/32) = 1 << (TIM4_IRQ % 32);
    NVIC_ISER(TIM4_IRQ/32) = 1 << (TIM4_IRQ % 32);
}

int main() {
	printf("\nStarting...\n");

	// RCC init
	RCC_AHB1ENR |= RCC_GPIOAEN;
	RCC_APB1ENR |= RCC_TIM3EN;
    RCC_APB1ENR |= RCC_TIM4EN;
    RCC_APB2ENR |= SYSCFGEN;

    config_motor(PSC, PERIOD, CONVERT_ANGLE(90));
    config_timer4(2000, ((APB1_CLK / (2000 * 2))), handle_TIM4);
    ENABLE_IRQS;
    TIM3_CR1 = TIM_CEN | TIM_ARPE;
    TIM4_CR1 = TIM_CEN;

	// main loop
	printf("Endless loop!\n");
	while(1) {}
}


