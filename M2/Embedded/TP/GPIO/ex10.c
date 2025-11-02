#include "stm32f4/io.h"
#include <tinyprintf.h>
#include <stm32f4/rcc.h>
#include <stm32f4/gpio.h>
#include <stm32f4/nvic.h>
#include <stm32f4/exti.h>
#include <stm32f4/syscfg.h>
#include <stm32f4/tim.h>


#define PSC 1000
#define CLICK_TIME (APB1_CLK / PSC / 30)

#define EXTERNAL_LED    10  // PD10
#define INTERNAL_LED    12  // PA12
#define EXTERNAL_BUTTON 0  // PD0


#define SYSCFG_EXTICR_GPIOD 0b11
#define SYSCFGEN            0x4000

void handle_button();
void switchLed(int led);
void init_led(int led);
void init_TIM4(int psc, int delay);
void init_button(void *handler);
void wait_end_click(int button);


void switchLed(int led) {
    GPIOD_ODR ^= (1 << led); 
}

void handle_button() {

    if((GPIOD_IDR & (1 << EXTERNAL_BUTTON)) != 0) {
        /* disable interrupts */
        EXTI_IMR &= ~(1 << EXTERNAL_BUTTON);
        NVIC_ICER(EXTI0_IRQ/32) = 1 << (EXTI0_IRQ%32);  // disable interrupt
        
        /* processing */
        switchLed(EXTERNAL_LED);
        switchLed(INTERNAL_LED);
        wait_end_click(EXTERNAL_BUTTON);
        
        /* enable interrupts */
        EXTI_IMR |= (1 << EXTERNAL_BUTTON);
        NVIC_ISER(EXTI0_IRQ/32) = 1 << (EXTI0_IRQ%32); // enable interrupt
    } else {
    }

    /* clear pending */
    EXTI_PR |= (1 << EXTERNAL_BUTTON);
    NVIC_ICPR(EXTI0_IRQ/32) = 1 << (EXTI0_IRQ%32);

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
    int button = EXTERNAL_BUTTON;
    DISABLE_IRQS;

    GPIOD_MODER = REP_BITS(GPIOD_MODER, button*2, 2, GPIO_MODER_IN); // Mode input
    GPIOD_PUPDR = REP_BITS(GPIOD_PUPDR, button*2, 2, GPIO_PUPDR_PD); // Resistance de pull-down

    SYSCFG_EXTICR1 = REP_BITS(SYSCFG_EXTICR1, button*4, 4, SYSCFG_EXTICR_GPIOD); // EXTI0 (Px0) generate interrupt based on GPIOD
    EXTI_IMR &= ~(1 << button);     // disable interrupt
    EXTI_FTSR &= ~(1 << button);    // falling edge
    EXTI_RTSR |= (1 << button);     // rising edge
    EXTI_PR |= (1 << button);       // clear pending
    EXTI_IMR |= 1 << button;        // enable interrupt

    NVIC_ICER(EXTI0_IRQ>>5) = 1 << (EXTI0_IRQ & 0x1F);  // disable interrupt in NVIC
    NVIC_IRQ(EXTI0_IRQ) = (uint32_t)handler;        // config handler
    NVIC_IPR(EXTI0_IRQ) = 0;                        // setup priority
    NVIC_ICPR(EXTI0_IRQ>>5) = 1 << (EXTI0_IRQ & 0x1F);  // clear pending in NVIC
    NVIC_ISER(EXTI0_IRQ>>5) = 1 << (EXTI0_IRQ & 0x1F);  // enable interrupt in NVIC

    ENABLE_IRQS;
}


void wait_end_click(int button) {
    TIM4_EGR = TIM_UG;
    TIM4_SR = 0;
    TIM4_CR1 = TIM_CEN;

    while((TIM4_SR & TIM_UIF) == 0) // Wait end of timer
    {
        if ((GPIOD_IDR & (1 << button)) != 0) {
            TIM4_EGR = TIM_UG;  // reset timer if button is pushed
            TIM4_SR = 0;
        }
    }
    TIM4_CR1 = 0;
}

int main() {
	printf("\nStarting...\n");

	// RCC init
	RCC_AHB1ENR |= RCC_GPIOAEN;
	RCC_AHB1ENR |= RCC_GPIODEN;
	RCC_APB1ENR |= RCC_TIM4EN;
    RCC_AHB2ENR |= RCC_GPIODEN;
    RCC_APB2ENR |= SYSCFGEN;

    init_TIM4(PSC, CLICK_TIME);
    init_led(EXTERNAL_LED);
    init_led(INTERNAL_LED);
    init_button(handle_button);

	// main loop
	printf("Endless loop!\n");
	while(1) {
	}

}
