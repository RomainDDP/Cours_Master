#include <tinyprintf.h>
#include <stm32f4/rcc.h>
#include <stm32f4/gpio.h>
#include <stm32f4/tim.h>
#include <stm32f4/nvic.h>
#include <stm32f4/nvic.h>

#define GREEN_LED	12
#define PSC 1000
#define BLINK_TIME (APB1_CLK / PSC / 2)

void init_led(int led) {
    GPIOD_MODER = REP_BITS(GPIOD_MODER, led*2, 2, GPIO_MODER_OUT);
    GPIOD_OTYPER &= ~(1<<led);
}

void switchLed(int led) {
    GPIOD_ODR ^= (1 << led);
}

void handle_TIM4()  {
    if ((TIM4_SR & TIM_UIF) == 0) {
        return;
    }
    TIM4_SR &= ~TIM_UIF;
    switchLed(GREEN_LED);
}

void init_TIM4(int psc, int delay, void* handler){
    DISABLE_IRQS;

	TIM4_CR1 = 0;               // Disable timer
	TIM4_PSC = psc - 1;         // setup prescalor
	TIM4_ARR = delay;           // setup period
	TIM4_EGR = TIM_UG;          // reset counter
	TIM4_SR = 0;                // reset status
    TIM4_DIER = TIM_UIE;        // update interrupt enabled
    NVIC_ICER(TIM4_IRQ/32) = 1 <<(TIM4_IRQ%32);     // Interrupt Clear-Enable (desable interrupt)
    NVIC_IRQ(TIM4_IRQ) = (uint32_t)handle_TIM4;     // Define handler
    NVIC_IPR(TIM4_IRQ) = 0;     // InterruptPriority
    NVIC_ICPR(TIM4_IRQ/32) = 1 << (TIM4_IRQ % 32);  // Interrupt clear pending
    NVIC_ISER(TIM4_IRQ/32) = 1 << (TIM4_IRQ % 32);  // Interrupt Set-Enable (enable interrupt)

    ENABLE_IRQS;
}

int main() {
	printf("\nStarting...\n");

	// RCC init
	RCC_AHB1ENR |= RCC_GPIOAEN;
	RCC_AHB1ENR |= RCC_GPIODEN;
	RCC_APB1ENR |= RCC_TIM4EN;

    init_TIM4(PSC, BLINK_TIME,handle_TIM4);
    init_led(GREEN_LED);

    TIM4_CR1 = TIM_CEN; // Enable counter

	// main loop
	printf("Endless loop!\n");
	while(1) {
        NOP;
	}

}


